local Player = {}
Player.__index = Player

local anim8 = require("libs.anim8")
local input = require("src.utils.input")

function Player:new(x, y)
    local player = {}
    setmetatable(player, Player)

    -- palyer x, y
    player.x = x or 0
    player.y = y or love.graphics.getHeight() - 64
    player.width = 16
    player.height = 32
    player.is_alive = true

    -- Criar colisor injetado
    player.collider = nil
    
    -- Parâmetros de movimento
    player.speed = 200
    player.jump_force = -400
    player.kick_jump_force = -200
    player.mass = 0
    player.is_on_ground = false

    -- PowerUps
     -- Modo Cachaça Fantasma
    player.is_ghost = false
    player.ghost_timer = 0

    -- Sprite
    player.sprite_sheet = love.graphics.newImage("src/assets/sprites/luigi_walk.png")
    player.grid = anim8.newGrid(
        16, 30, player.sprite_sheet:getWidth(), player.sprite_sheet:getHeight(), nil, nil, 2
    )
    player.animations = {}
    player.animations.idle = anim8.newAnimation( player.grid( 1, 2 ), 1 )
    player.animations.right = anim8.newAnimation( player.grid( '2-4', 2 ), 0.3 )
    player.animations.left = anim8.newAnimation( player.grid( '2-4', 1 ), 0.3 )

    player.current_animation = player.animations.idle

    return player
end

-- Functions
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
    -- Verificar se o Player morreu
    if not self.collider then return end
    if not self.is_alive then
        self.collider:destroy()
        self.collider = nil
        return
    end

    -- Atualizar as variáveis de Player
    self.x, self.y = self.collider:getPosition()
    self.mass = self.collider:getMass()

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
        self.is_on_ground = true
        if y_velocity >= 0 then
        end
    elseif self.collider:exit("Ground") or self.collider:enter("Plataform") or self.collider:enter("Block") then
        self.is_on_ground = false
    end

    -- Movimento horizontal
    local x_velocity, y_velocity = self.collider:getLinearVelocity()
    if input.right_pressed() then
        self.current_animation = self.animations.right
        self.collider:setLinearVelocity(self.speed, y_velocity)
    elseif input.left_pressed() then
        self.current_animation = self.animations.left
        self.collider:setLinearVelocity(-self.speed, y_velocity)
    else
        self.current_animation = self.animations.idle
        self.collider:setLinearVelocity(0, y_velocity)
    end

    -- Pulo
    if input.jump_press() and self.is_on_ground then
        self.collider:applyLinearImpulse(0, self.jump_force * self.mass)
        self.is_on_ground = false -- Evitar múltiplos pulos
    end
    
    -- Colisão com PowerUp
    if self.collider:enter("PowerUp") then
        self:activateGhostMode(15)
    end

    -- Animações
    self.current_animation:update(dt)
end

function Player:draw()
    -- Desenhar jogador
    if self.is_ghost then
        love.graphics.setColor(0.5, 0.5, 1)
    else
        --love.graphics.setColor(1, 1, 1)
    end
    local x, y = self.collider:getPosition()
    --love.graphics.rectangle("fill", x - self.width / 2, y - self.height / 2, self.width, self.height, nil, nil, nil, self.width / 2, self.height / 2)
    self.current_animation:draw(self.sprite_sheet, x - self.width / 2, y - self.height / 2, nil, 1, 1)
end

function Player.keypressed(key)
    input.keypressed(key)
end

function Player.keyreleased(key)
   input.keyreleased(key)
end

return Player