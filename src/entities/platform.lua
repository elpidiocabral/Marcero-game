local Platform = {}
Platform.__index = Platform

local player_roles = require("src.utils.player_roles")

function Platform:new(x, y)
    local platform = {}
    setmetatable(platform, Platform)

    platform.x = x or 0
    platform.y = y or 0
    platform.width = 120
    platform.height = 16

    platform.collider = nil

    return platform
end

function Platform:load()
    local platform_obj = self.collider:getObject()
    self.width = platform_obj.width
    self.height = platform_obj.height
end

function Platform:update(dt)
    if not self.collider then return end
end

function Platform:draw()
    if self.collider ~= nil then
        love.graphics.setColor(0, 0.8, 0)
        local x, y = self.collider:getPosition()
        love.graphics.rectangle("fill", x - self.width / 2, y - self.height / 2, self.width, self.height)
    end
end

return Platform