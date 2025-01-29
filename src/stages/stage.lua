local Stage = {}
local player

local sti = require("libs.sti")
local map
local camera = require("libs.camera")
local cam
local wf = require("src.entities.colision")
local world
local input = require("src.utils.input")

local ground, celling, leftWall, rightWall

local contact = require("src.utils.contact")
local interections = require("src.context.interections")

local Player = require("src.entities.player")

function Stage.load()
    world = wf:new(800)
    
    cam = camera()
    cam:zoomTo(1.5)

    map = sti("src/assets/maps/house.lua")

    -- Player de teste
    player = Player:new()
    player.collider = world:addPlayer(0, love.graphics.getHeight() - 128, 32, 32)

    ground = world:addGround(0, love.graphics.getHeight() - 64, map.width * map.tilewidth, map.tileheight)
    leftWall = world:addWall(0, 0, 1, love.graphics.getHeight())
    rightWall = world:addWall(446, 0, 1, love.graphics.getHeight())
    -- celling = world:addGround(0, love.graphics.getHeight() - 200, map.width * map.tilewidth, 1)
end

function Stage:update(dt)
    world:update(dt)
    player:update(dt)

    local px, py = player.collider:getPosition()

    local mapWidth = map.width * map.tilewidth
    local mapHeight = map.height * map.tileheight
    local min_x, min_y = love.graphics.getWidth() / 2, love.graphics.getHeight() / 2
    local max_x, max_y = mapWidth - min_x, mapHeight - min_y

    --cam:lookAt(player.x, player.y)
end

function Stage.draw()
    --cam:attach()
        local offsetX, offsetY = 0, map.height * map.tileheight
        local mapWidth = map.width * map.tilewidth
        local mapHeight = map.height * map.tileheight
        local camX, camY = cam:position()

        map:draw(0, love.graphics.getHeight() / 2 - 26)
        
        world:draw()
        player:draw()
    --cam:detach()
end


function Stage.keypressed()
    
end

function Stage.keyreleased()
    
end

return Stage