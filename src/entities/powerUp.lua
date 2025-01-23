local PowerUp = {}
PowerUp.__index = PowerUp

function PowerUp:new()
    local powerUp = {}
    setmetatable(powerUp, PowerUp)

    powerUp.width = 16
    powerUp.height = 16

    powerUp.collider = nil

    return powerUp
end

function PowerUp:update(dt)
    
end

function PowerUp:draw()
    love.graphics.setColor(1, 0, 1)
    local x, y = self.collider:getPosition()
    love.graphics.circle("fill", x - self.width / 2, y - self.height / 2, self.width)
end

return PowerUp