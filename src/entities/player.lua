local Player = {}
Player.__index = Player

local game_keys = require("src.utils.keys")

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
    player.jump_force = -600
    player.is_on_ground = false

    return player
end

function Player:update(dt)
    -- Atualizar o estado: verificar contato com o chão
    if self.collider:enter("Ground") then
        self.is_on_ground = true
    elseif self.collider:exit("Ground") then
        self.is_on_ground = false
    end

    -- Movimento horizontal
    local x_velocity, y_velocity = self.collider:getLinearVelocity()

    if game_keys.right_press() then
        self.collider:setLinearVelocity(self.speed, y_velocity)
    elseif game_keys.left_press() then
        self.collider:setLinearVelocity(-self.speed, y_velocity)
    else
        self.collider:setLinearVelocity(0, y_velocity)
    end

    -- Pulo
    if game_keys.jump_press() and self.is_on_ground then
        self.collider:applyLinearImpulse(0, self.jump_force)
        self.is_on_ground = false -- Evitar múltiplos pulos
    end
end

function Player:draw()
    -- Desenhar jogador como um quadrado
    love.graphics.setColor(1, 1, 1)
    local x, y = self.collider:getPosition()
    love.graphics.rectangle("fill", x - self.width / 2, y - self.height / 2, self.width, self.height)
end

return Player
