local Enemy = {}
Enemy.__index = Enemy

function Enemy:new(x, y)
    local enemy = {}
    setmetatable(enemy, Enemy)

    -- Enemy attributes
    enemy.width = 32
    enemy.height = 32

    enemy.collider = nil

    enemy.speed = 100
    enemy.direction = -1  -- 1 for right, -1 for left
    enemy.max_distance = 100  -- Distance to walk before changing direction
    enemy.start_x = x or 200

    return enemy
end

function Enemy:update(dt)
    -- Movement
    local x_velocity, y_velocity = self.collider:getLinearVelocity()
    local x, y = self.collider:getPosition()

    if self.direction == 1 and x >= self.start_x + self.max_distance then
        self.direction = -1
    elseif self.direction == -1 and x <= self.start_x - self.max_distance then
        self.direction = 1
    end

    self.collider:setLinearVelocity(self.speed * self.direction, y_velocity)
end

function Enemy:draw()
    -- Draw enemy
    love.graphics.setColor(1, 0, 0)
    local x, y = self.collider:getPosition()
    love.graphics.rectangle("fill", x - self.width / 2, y - self.height / 2, self.width, self.height)
end

return Enemy