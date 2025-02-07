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
local highgrounds = {}

local contact = require("src.utils.contact")
local interections = require("src.context.interections")

local player

local Platform = require("src.entities.platform")
local platforms = {}

function Stage.load(gameplay_player)
    world = wf:new(800)
    
    cam = camera(0, 0)
    cam:zoomTo(2.5)

    map = sti("src/assets/maps/map-test.lua")

    -- Player de teste
    player = gameplay_player
    player.collider = world:addPlayer(0, love.graphics.getHeight() - 120, 16, 30)

    ground = world:addGround(0, love.graphics.getHeight(), 586, map.tileheight)
    ground = world:addGround(627, love.graphics.getHeight(), map.width * map.tilewidth, map.tileheight)
    leftWall = world:addWall(0, 0, 1, love.graphics.getHeight())
    rightWall = world:addWall(map.width * map.tilewidth, 0, 1, love.graphics.getHeight())

    -- Criar múltiplas plataformas
    local platform_positions = {
        {97, love.graphics.getHeight() - 49, 126, 4},
        {177, love.graphics.getHeight() - 65, 110, 4},
        {354, love.graphics.getHeight() - 82, 140, 2},
        {450, love.graphics.getHeight() - 85, 140, 2},
    }

    for _, pos in ipairs(platform_positions) do
        local platform
        platform = world:addHighGround(pos[1], pos[2], pos[3], pos[4])
        table.insert(highgrounds, platform)
    end

    -- HandleColision
    contact.handleColision(player, {
        interections.player_enemy_behavior,
        interections.player_platform_behavior,
        interections.player_block_behavior,
        interections.player_powerUp_behavior,
        interections.player_highground_behavior
    })
end

function Stage:update(dt)
    world:update(dt)
    player:update(dt)

    for _, platform in ipairs(platforms) do
        platform:update(dt)
    end

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
        local offsetX = (love.graphics.getWidth() / 2) * (1 - 1 / cam.scale) - (map.width * map.tilewidth) / 2 + 416
        local offsetY = (love.graphics.getHeight() / 2) * (1 - 1 / cam.scale) + (map.tileheight * map.height) / 2 - 34

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