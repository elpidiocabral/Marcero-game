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
    
end

return PowerUp