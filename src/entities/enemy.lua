local Enemy = {}
Enemy.__index = Enemy

function Enemy:new(x, y)
    local enemy = {}
    setmetatable(enemy, Enemy)

    -- Enemy attibutes
    Enemy.width = 32
    Enemy.height = 32

    Enemy.collider = nil

    Enemy.speed = 200

    return enemy
end

function Enemy:update(dt)
    -- Movimento 
    local x_velocity, y_velocity = self.collider:getLinearVelocity()
    if x_velocity < ( love.graphics.getWidth() - 128) then
        self.collider:setLinearVelocity(self.speed, y_velocity)
    end
end

function Enemy:draw()
    -- Draw enemy
    love.graphics.setColor(1, 0, 0)
    local x, y = self.collider:getPosition()
    love.graphics.rectangle("fill", x - self.width / 2, y - self.height / 2, self.width, self.height)
end

return Enemy