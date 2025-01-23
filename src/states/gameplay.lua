local Gameplay = {}

local wf = require("src.entities.colision")
local world
local ground, line1, line2, teto, platform

local Player = require("src.entities.player")
local player
local Enemy = require("src.entities.enemy")
local enemy
local PowerUp = require("src.entities.powerUp")
local powerUp

local tileImage
local tilesWide, tilesHigh

function Gameplay.load()
    -- Windfield
    world = wf:new(800)

    -- Player
    player = Player:new()
    player.collider = world:addPlayer(0, love.graphics.getHeight() - 64, 32, 32)

    -- Enemy
    enemy = Enemy:new(600, love.graphics.getHeight() - 64)
    enemy.collider = world:addEnemy(600, love.graphics.getHeight() - 64, 32, 32)
    
    -- PowerUp
    -- powerUp = PowerUp:new()
    -- powerUp.collider = world:addPowerUp(150, love.graphics.getHeight() - 64, 8)

    -- Calcular quantos tiles cabem na tela
    tileImage = love.graphics.newImage("src/assets/tile.png")
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

    ground = world:addGround(0, love.graphics.getHeight() - tileHeight, w, tileHeight)
    line1 = world:addWall(0, 0, 1, 600)
    line2 = world:addWall(800, 0, 1, 600)
    teto = world:addWall(0, 0, 800, 1)
    platform = world:addPlatform(150, love.graphics.getHeight() - 120, 120, 16)
end

function Gameplay:update(dt)
    player:update(dt)
    enemy:update(dt)
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