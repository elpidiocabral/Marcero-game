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
local function handleColision(collider1, collider2, contact, player)
    -- Platform Colision
    if collider2.collision_class == "Platform" then
        local player_x, player_y = collider1:getPosition()
        local player_width, player_height = player.width, player.height
        local platform_x, platform_y = collider2:getPosition()
        local platform = collider2:getObject()
        local platform_width, platform_height = platform.width, platform.height

        -- Verificar se o jogador está abaixo da plataforma (verticalmente)
        if (player_y + player_height / 2) > (platform_y + platform_height / 2) then
            -- Verificar se o jogador está suficientemente dentro da plataforma (horizontalmente)
            local player_left = player_x - player_width / 2
            local player_right = player_x + player_width / 2
            local platform_left = platform_x - platform_width / 2
            local platform_right = platform_x + platform_width / 2
            player.is_on_ground = false

            if player_left >= platform_left and player_right <= platform_right then
                contact:setEnabled(false)
            end
        end
    end
end

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
    if self.collider:enter("Ground") or self.collider:enter("Platform") or self.collider:enter("Block")  then
        self.is_on_ground = true
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

    -- Pular Plataforma, talvez grande demais
    self.collider:setPreSolve(function(collider1, collider2, contact)
        handleColision(collider1, collider2, contact, self)
    end)

    -- Colisão com PowerUp
    if self.collider:enter("PowerUp") then
        self:activateGhostMode(15)
        local powerUp = self.collider:getEnterCollisionData("PowerUp").collider
        powerUp:destroy()
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
