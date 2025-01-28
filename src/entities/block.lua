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

function Block.contact_behavior(contact_data)
        if contact_data.collider2_top >= contact_data.collider1_bottom then
            -- Mover power-up para cima do bloco
            contact_data.entitie.movePowerUp = true
            contact_data.entitie.status = false
    end
end

function Block:update(dt)
    if not self.collider then return end
    self.powerUp:update(dt)

    -- Verificar se é tempo dt de mover o powerUp
    if self.movePowerUp and self.powerUp and self.powerUp.collider then
        local block_x, block_y = self.collider:getPosition()
        self.powerUp.collider:setPosition(block_x, block_y - self.height)
        self.movePowerUp = false -- Resetar a flag
    end

    if ( self.powerUp.collider ~= nil ) and ( self.powerUp.collider:enter("Player") ) then
        self.powerUp:destroy()
        self.powerUp.collider = nil
    end
end

function Block:draw()
    if self.collider ~= nil then
        love.graphics.setColor(1, 1, 0)
        local x, y = self.collider:getPosition()
        love.graphics.rectangle("fill", x - self.width / 2, y - self.height / 2, self.width, self.height)
    end
end

return Block
