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
    
    cam = camera(0, 0, 1.5)
    --cam:zoomTo(1.5)

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

    -- Camera Logics
    local px, py = player.collider:getPosition()
    cam:lookAt(px, py)
end

function Stage.draw()
    cam:attach()
        -- Obtém as coordenadas reais da câmera no mundo
        local tx, ty = cam:worldCoords(0, 0)

        -- Corrige o offset para centralizar o mapa corretamente em qualquer zoom
        local offsetX = (love.graphics.getWidth() / 2) * (1 - 1 / cam.scale) - (map.width * map.tilewidth) / 2 + 108
        local offsetY = (love.graphics.getHeight() / 2) * (1 - 1 / cam.scale) + (map.tileheight * map.height) / 2 + 40

        -- Renderiza o mapa na posição correta levando em conta a escala
        map:draw(-tx + offsetX, -ty + offsetY, cam.scale, cam.scale)

        world:draw()
        player:draw()
    cam:detach()
end

function Stage.keypressed()
    
end

function Stage.keyreleased()
    
end

return Stage