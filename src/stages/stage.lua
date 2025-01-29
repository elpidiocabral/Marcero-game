local Stage = {}

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

function Stage.load()
    world = wf:new(800)

    map = sti("src/assets/maps/house.lua")

    ground = world:addGround(0, love.graphics.getHeight(), map.width, map.tileheight)
    leftWall = world:addWall(0, 0, 1, love.graphics.getHeight())
    rightWall = world:addWall(446, 0, 1, love.graphics.getHeight())
    celling = world:addGround(0, love.graphics.getHeight() - 200, map.width * map.tilewidth, 1)
end

function Stage:update(dt)
    world:update(dt)
end

function Stage.draw()
    local offsetx, offsety = 0, love.graphics.getHeight() - map.height * map.tileheight
    map:draw(offsetx, offsety)

    world:draw()
end

function Stage.keypressed()
    
end

function Stage.keyreleased()
    
end

return Stage