local Player = {}
Player.__index = Player

local input = require("src.utils.input")

function Player:new(x, y)
    local player = {}
    setmetatable(player, Player)

    -- palyer x, y
    player.width = 32
    player.height = 32

    -- Criar colisor injetado
    player.collider = nil
    
    -- Parâmetros de movimento
    player.speed = 200
    player.jump_force = -800
    player.is_on_ground = false

    -- PowerUps
     -- Modo Cachaça Fantasma
    player.is_ghost = false
    player.ghost_timer = 0

    return player
end

-- Functions
function Player.contact_behavior(contact_data)
    -- Platforms
    if contact_data.collider2.collision_class == "Platform" then
        if (contact_data.collider1_bottom <= contact_data.collider2_top) and
           (contact_data.collider1_left < contact_data.collider2_right) and
           (contact_data.collider1_right > contact_data.collider2_left) and
           (contact_data.collider1_y_velocity >= 0) then
            contact_data.entitie.is_on_ground = true
        else
            contact_data.entitie.is_on_ground = false
        end
    end

    -- Blocks
    if contact_data.collider2.collision_class == "Block" then
        if (contact_data.collider1_bottom <= contact_data.collider2_top) and
           (contact_data.collider1_left < contact_data.collider2_right) and
           (contact_data.collider1_right > contact_data.collider2_left) and
           (contact_data.collider1_y_velocity >= 0) then
            contact_data.entitie.is_on_ground = true
        else
            contact_data.entitie.is_on_ground = false
        end
    end
end
-- End

function Player:activateGhostMode(duration)
    self.is_ghost = true
    self.ghost_timer = duration
    self.collider:setCollisionClass("GhostPlayer")
end

function Player:deactivateGhostMode()
    self.is_ghost = false
    self.collider:setCollisionClass("Player")
end
-- End

function Player:update(dt)
    -- Atualizar o estado de "fantasma"
    if self.is_ghost then
        self.ghost_timer = self.ghost_timer - dt
        if self.ghost_timer <= 0 then
            self:deactivateGhostMode()
        end
    end

    -- Verificar se está no chão
    if self.collider:enter("Ground") or self.collider:enter("Block") or self.collider:enter("Platform") then
        local x_velocity, y_velocity = self.collider:getLinearVelocity()
        if y_velocity >= 0 then
            self.is_on_ground = true
        end
    elseif self.collider:exit("Ground") or self.collider:enter("Plataform") or self.collider:enter("Block") then
        self.is_on_ground = false
    end

    -- Movimento horizontal
    local x_velocity, y_velocity = self.collider:getLinearVelocity()
    if input.right_pressed() then
        self.collider:setLinearVelocity(self.speed, y_velocity)
    elseif input.left_pressed() then
        self.collider:setLinearVelocity(-self.speed, y_velocity)
    else
        self.collider:setLinearVelocity(0, y_velocity)
    end

    -- Pulo
    if input.jump_press() and self.is_on_ground then
        self.collider:applyLinearImpulse(0, self.jump_force)
        self.is_on_ground = false -- Evitar múltiplos pulos
    end
    
    -- Colisão com PowerUp
    if self.collider:enter("PowerUp") then
        self:activateGhostMode(15)
    end
end

function Player:draw()
    -- Desenhar jogador
    if self.is_ghost then
        love.graphics.setColor(0.5, 0.5, 1)
    else
        love.graphics.setColor(1, 1, 1)
    end
    local x, y = self.collider:getPosition()
    love.graphics.rectangle("fill", x - self.width / 2, y - self.height / 2, self.width, self.height)
end

function Player.keypressed(key)
    input.keypressed(key)
end

function Player.keyreleased(key)
   input.keyreleased(key)
end

return Player
