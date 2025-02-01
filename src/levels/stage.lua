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
local player

function Stage.load(gameplay_player)
    world = wf:new(800)
    
    cam = camera(0, 0)
    cam:zoomTo(2)

    map = sti("src/assets/maps/map1.lua")

    -- Player de teste
    player = gameplay_player
    player.collider = world:addPlayer(0, love.graphics.getHeight() - 120, 16, 30)

    ground = world:addGround(0, love.graphics.getHeight(), map.width * map.tilewidth, map.tileheight)
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

        --[[
            Corrige o offset para centralizar o mapa corretamente em qualquer zoom 
            Mas só se o mapa estiver configurado corretamente, do contrário tem que adicionar constantes 
        ]] 
        local offsetX = (love.graphics.getWidth() / 2) * (1 - 1 / cam.scale) - (map.width * map.tilewidth) / 2
        local offsetY = (love.graphics.getHeight() / 2) * (1 - 1 / cam.scale) + (map.tileheight * map.height) / 2 + 43

        -- Renderiza o mapa na posição correta levando em conta a escala
        map:draw(-tx + offsetX, -ty + offsetY, cam.scale, cam.scale)

        --world:draw()
        player:draw()
    cam:detach()
end

function Stage.keypressed()
    
end

function Stage.keyreleased()
    
end

return Stage