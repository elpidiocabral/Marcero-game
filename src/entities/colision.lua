--[[
Arquivo responsável pela criação da colisão do mundo.
World com Windfield
]]--

local Colision = {}
Colision.__index = Colision

local wf = require("libs.windfield")
local world

function Colision:new(gravity)
    local colision = {}
    setmetatable(colision, Colision)

    world = wf.newWorld(0, gravity, true)

    world:addCollisionClass("Player")
    world:addCollisionClass("Enemy")
    world:addCollisionClass("Ground")
    world:addCollisionClass("Wall")
    world:addCollisionClass("Platform")
    world:addCollisionClass("Block")
    world:addCollisionClass("PowerUp")
    
    -- Player modes
    world:addCollisionClass("GhostPlayer", { ignores = { "Enemy" } })
    world:addCollisionClass("DeadEnemy", { ignores = { "Player" } })

    return colision
end

-- Funções locais
function Colision.addClass(class)
    world:addCollisionClass(class)
end

function Colision:addPlayer(x_position, y_position, width, height)
    local colider = world:newRectangleCollider(x_position, y_position, width, height, { collision_class = "Player" })
    colider:setObject({ width = width, height = height })
    colider:setFixedRotation(true)
    colider:setRestitution(0)
    colider:setFriction(0) -- Impede "grudes" nas paredes

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
    colider:setRestitution(0)
    colider:setFriction(0) -- Impede "grudes"

    return colider
end

function Colision:addGround(x_position, y_position, width, height)
    return world:newRectangleCollider(x_position, y_position, width, height, { collision_class = "Ground", body_type = "static" })
end

function Colision:addWall(x_position, y_position, width, height)
    local colider = world:newRectangleCollider(x_position, y_position, width, height, { collision_class = "Wall", body_type = "static" })
    colider:setFriction(0)

    return colider
end

function Colision:addPlatform(x_position, y_position, width, height)
    local colider = world:newRectangleCollider(x_position, y_position, width, height, { collision_class = "Platform", body_type = "static" })
    colider:setObject({ width = width, height = height })
    colider:setFriction(0)

    return colider
end

function Colision:addBlock(x_position, y_position, width, height)
    local colider = world:newRectangleCollider(x_position, y_position, width, height, { collision_class = "Block", body_type = "static" })
    colider:setObject({ width = width, height = height })
    colider:setFriction(0)

    return colider
    
end

function Colision:addPowerUp(x_position, y_position, radius)
    local colider = world:newCircleCollider(x_position, y_position, radius, { collision_class = "PowerUp", body_type = "static" })
    colider:setFriction(0)

    return colider
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