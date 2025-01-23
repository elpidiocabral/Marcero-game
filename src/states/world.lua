--[[
Arquivo responsável pela criação da colisão do mundo.
World com Windfield
]]--
local wf = require("libs.windfield")
local world

function wf:new()
    world = wf.newWorld(0, 800, true)
    local collider

    
end

return wf