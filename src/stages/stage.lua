local Stage = {}

local sti = require("libs.sti")
local map

function Stage.load()
    map = sti("src/assets/maps/house.lua")
end

function Stage.update(dt)
    
end

function Stage.draw()
    map:draw()
end

return Stage