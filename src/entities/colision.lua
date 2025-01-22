--[[
Arquivo responsável pela criação da colisão do mundo.
World com Windfield
]]--

local Colision = {}
Colision.__index = Colision

local wf = require("libs.windfield")
local world

local Player = require("src.entities.player")
local Enemy = require("src.entities.enemy")

function Colision:new(gravity)
    local colision = {}
    setmetatable(colision, Colision)

    world = wf.newWorld(0, gravity, true)
    world:addCollisionClass("Player")
    world:addCollisionClass("Enemy")
    world:addCollisionClass("Ground")
    world:addCollisionClass("Wall")

    return colision
end

-- Funções locais
function Colision.addClass(class)
    world:addCollisionClass(class)
end

function Colision:addPlayer(x_position, y_position, width, height)
    local colider = world:newRectangleCollider(x_position, y_position, width, height, { collision_class = "Player" })
    colider:setFixedRotation(true)

    return colider
end

--[[
    Inicalmente parece código repetido, 
    mas o inimigo terá outras proprieades, 
    além de precisar alterar sets diferentes do player
]] 
function Colision:addEnemy(x_position, y_position, width, height)
    local colider = world:newRectangleCollider(x_position, y_position, width, height, { collision_class = "Enemy" })
    colider:setFixedRotation(true)
    colider:setType("static")

    return colider
end

function Colision:addGround(x_position, y_position, width, height)
    return world:newRectangleCollider(x_position, y_position, width, height, { collision_class = "Ground", body_type = "static" })
end

function Colision:addWall(x_position, y_position, width, height)
    return world:newRectangleCollider(x_position, y_position, width, height, { collision_class = "Wall", body_type = "static" })
end
-- Fim

function Colision:update(dt)
    world:update(dt)
end

function Colision:draw()
    -- Printar os limites de colisão
    world:draw()
end

return Colision