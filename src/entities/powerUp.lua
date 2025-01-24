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
    
end

function PowerUp:draw()
    if self.collider then
        local x, y = self.collider:getPosition()
        love.graphics.setColor(0, 1, 0)
        love.graphics.circle("fill", x, y, self.width / 2)
    else
        love.graphics.setColor(0, 1, 0)
        love.graphics.circle("fill", self.x, self.y, self.width / 2)
    end
end

return PowerUp