local PowerUp = {}
PowerUp.__index = PowerUp

function PowerUp:new(x, y)
    local powerUp = {}
    setmetatable(powerUp, PowerUp)

    powerUp.type = nil
    powerUp.width = 8
    powerUp.height = 8

    powerUp.collider = nil

    return powerUp
end

function PowerUp:update(dt)
    if not self.collider then return end
    
    if self.collider:enter("Player") then
        self.collider:destroy()
        self.collider = nil
    end
end

function PowerUp:destroy()
    if self.collider then
        self.collider:destroy()
        self.collider = nil
    end
end

function PowerUp:draw()
    if self.collider ~= nil then
        local x, y = self.collider:getPosition()
        love.graphics.setColor(0, 1, 0)
        love.graphics.circle("fill", x, y, self.width / 2)
    end
end

return PowerUp