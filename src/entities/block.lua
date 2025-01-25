local PowerUp = require("src.entities.powerUp")

local Block = {}
Block.__index = Block

function Block:new(x, y)
    local block = {}
    setmetatable(block, Block)

    block.x = x or 200
    block.y = y or 200
    block.width = 16
    block.height = 16

    block.status = true
    block.collider = nil

    block.powerUp = PowerUp:new(x, y-16)
    block.powerUp.collider = nil
    block.movePowerUp = false

    return block
end

function Block:update(dt)
    if not self.collider then return end

    -- Verificar se é tempo dt de mover o powerUp
    if self.movePowerUp and self.powerUp and self.powerUp.collider then
        local block_x, block_y = self.collider:getPosition()
        self.powerUp.collider:setPosition(block_x, block_y - self.height)
        self.movePowerUp = false -- Resetar a flag
    end

    self.collider:setPreSolve(
        function(collider1, collider2, contact)
            if collider2.collision_class == "Player" and self.status then
                local block_x, block_y = collider1:getPosition()
                local block_width, block_height = self.width, self.height
                local player_x, player_y = collider2:getPosition()
                local player = collider2:getObject()
                local player_width, player_height = player.width, player.height

                if (player_y + player_height / 2) >= (block_y + block_height / 2)  then
                    -- Mover power-up para cima do bloco
                    collider2:applyLinearImpulse(500, 0)
                    self.movePowerUp = true
                    self.status = false
                end
            end
        end
    )
end

function Block:draw()
    if self.collider ~= nil then
        love.graphics.setColor(1, 1, 0)
        local x, y = self.collider:getPosition()
        love.graphics.rectangle("fill", x - self.width / 2, y - self.height / 2, self.width, self.height)
    end

    if self.powerUp then
        self.powerUp:draw()
    end
end

return Block
