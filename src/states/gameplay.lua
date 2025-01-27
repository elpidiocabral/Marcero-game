local Gameplay = {}

local wf = require("src.entities.colision")
local world
local ground, line, teto, block

local contact = require("src.utils.contact")

local Player = require("src.entities.player")
local player
local Enemy = require("src.entities.enemy")
local enemy
local Platform = require("src.entities.platform")
local platform
local PowerUp = require("src.entities.powerUp")
local powerUps = {}
local Block = require("src.entities.block")
local block

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
    
    -- Platform
    platform = Platform:new(100, love.graphics.getHeight() - 120)
    platform.collider = world:addPlatform(100, love.graphics.getHeight() - 120, 120, 16) -- 120 - 64base = 56
    --platform.collider = world:addPlatform(200, love.graphics.getHeight() - 210, 120, 16)

    -- Block
    block = Block:new(300, love.graphics.getHeight() - 300)
    block.collider = world:addBlock(300, love.graphics.getHeight() - 120, 16, 16)
    -- Adicionar o power-up do bloco ao mundo
    if block.powerUp then
        block.powerUp.collider = world:addPowerUp(block.powerUp.x, block.powerUp.y, block.powerUp.width / 2)
        table.insert(powerUps, block.powerUp)
    end

    contact.handleColision(player, player.contact_behavior)
    contact.handleColision(enemy, enemy.contact_behavior)
    contact.handleColision(block, block.contact_behavior)
    contact.handleColision(platform, platform.contact_behavior)

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
    line = world:addWall(0, 0, 1, 600)
    line = world:addWall(800, 0, 1, 600)
    teto = world:addWall(0, 0, 800, 1)
end

function Gameplay:update(dt)
    player:update(dt)
    enemy:update(dt)
    --platform:update(dt)
    block:update(dt)
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
    block:draw()
    --platform:draw()
    
    for _, powerUp in ipairs(powerUps) do
        powerUp:draw()
    end

    enemy:draw()
    player:draw()

    world:draw()
end

function Gameplay.keypressed(key)
    Player.keypressed(key)
end

function Gameplay.keyreleased(key)
    Player.keyreleased(key)
end

return Gameplay