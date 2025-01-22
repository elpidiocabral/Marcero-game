local Gameplay = {}

local wf = require("libs.windfield")
local world
local ground, line1, line2, teto

local Player = require("src.entities.player")
local player
local Enemy = require("src.entities.enemy")
local enemy

local tileImage
local tilesWide, tilesHigh

function Gameplay.load()
    local collider = nil
    -- Windfield
    world = wf.newWorld(0, 800, true)

    -- Adicionar classes de colisão
    world:addCollisionClass("Player")
    world:addCollisionClass("Ground")

    -- Player
    player = Player:new(0, love.graphics.getHeight() - 64)
    collider = world:newRectangleCollider(0, love.graphics.getHeight() - 64, 32, 32, { collision_class = "Player" })
    player.collider = collider
    player.collider:setFixedRotation(true)

    -- Enemy
    enemy = Enemy:new(300, 64)
    collider = world:newRectangleCollider(300, 64, 32, 32, { collision_class = "Enemy" })
    enemy.collider = collider
    enemy.collider:setFixedRotation(true)
    
    -- Calcular quantos tiles cabem na tela
    tileImage = love.graphics.newImage("assets/tile.png")
    local tileWidth = tileImage:getWidth()
    local tileHeight = tileImage:getHeight()
    local w = 0

    tilesWide = math.ceil(love.graphics.getWidth() / tileWidth)
    tilesHigh = 1 -- Altura do chão em número de tiles (uma linha neste caso)

    -- testando tile collision
    for i = 0, tilesWide - 1 do
        w = w + tileWidth
        h = tileHeight
    end

    ground = world:newRectangleCollider(0, love.graphics.getHeight() - tileHeight, w, tileHeight, { collision_class = "Ground", body_type = "static" })
    line1 = world:newRectangleCollider(0, 0, 1, 600, { collision_class = "Wall", body_type = "static" })
    line2 = world:newRectangleCollider(800, 0, 1, 600, { collision_class = "Wall", body_type = "static" })
    teto = world:newRectangleCollider(0, 0, 800, 1, { collision_class = "Wall", body_type = "static" })
end

function Gameplay:update(dt)
    player:update(dt)
    world:update(dt)
end

function Gameplay.draw()
    local tileWidth = tileImage:getWidth()
    local tileHeight = tileImage:getHeight()

    for x = 0, tilesWide - 1 do
        for y = 0, tilesHigh - 1 do
            love.graphics.draw(tileImage, x * tileWidth, love.graphics.getHeight() - tileHeight * (y + 1))
        end
    end

    -- Draw Entities
    enemy:draw()
    player:draw()
    world:draw()
end

function Gameplay.keypressed()
    
end

return Gameplay