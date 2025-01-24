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

    return player
end

-- Local Functions
-- Função local para pular plataformas
local function handlePlatformCollision(collider1, collider2, contact, player)
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

            if player_left >= platform_left and player_right <= platform_right then
                contact:setEnabled(false)
                player.is_on_ground = false
            end
        end
    end
end
-- End

function Player:update(dt)
    -- Atualizar o estado: verificar contato com o chão
    if self.collider:enter("Ground") or self.collider:enter("Platform") then
        self.is_on_ground = true
    elseif self.collider:exit("Ground") or self.collider:enter("Plataform") then
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
        handlePlatformCollision(collider1, collider2, contact, self)
    end)

    -- Encontrão com um inimigo
    if self.collider:enter("Enemy") then
        --self.collider:applyLinearImpulse(0, -500)
    end
end

function Player:draw()
    -- Desenhar jogador como um quadrado
    love.graphics.setColor(1, 1, 1)
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
