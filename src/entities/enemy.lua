local Enemy = {}
Enemy.__index = Enemy

function Enemy:new(x, y, width, height)
    local enemy = {}
    setmetatable(enemy, Enemy)

    -- Enemy attributes
    enemy.x = x or 200
    enemy.y = y or 200
    enemy.width = width or 32
    enemy.height = height or 32

    enemy.collider = nil

    enemy.speed = 100
    enemy.direction = -1  -- 1 for right, -1 for left
    enemy.max_distance = 100  -- Distance to walk before changing direction
    enemy.start_x = x or 200

    enemy.is_alive = true
    enemy.death_timer = 0

    return enemy
end

function Enemy:update(dt)
    if not self.collider then return end -- Impede atualizações post mortem

    -- Comportamento
    self:is_dead(dt)
    self:movement()
end

function Enemy:is_dead(dt)
    if not self.is_alive then
        self.death_timer = self.death_timer - dt
        if self.death_timer <= 0 then
            self:destroy()
            self.collider = nil
        end
        return
    end
end

function Enemy:destroy()
    if self.collider then
        self.collider:destroy()
        self.collider = nil
    end
end

function Enemy:movement()
    if self.is_alive then
        local x_velocity, y_velocity = self.collider:getLinearVelocity()
        local x, y = self.collider:getPosition()

        if self.direction == 1 and x >= self.start_x + self.max_distance then
            self.direction = -1
        elseif self.direction == -1 and x <= self.start_x - self.max_distance then
            self.direction = 1
        end
    
        self.collider:setLinearVelocity(self.speed * self.direction, y_velocity)
    end
end

function Enemy:draw()
    -- Draw enemy
    if self.collider ~= nil then
        if self.is_alive then
            love.graphics.setColor(1, 0, 0)
        else
            love.graphics.setColor(0.5, 0, 0)
        end
        local x, y = self.collider:getPosition()
        love.graphics.rectangle("fill", x - self.width / 2, y - self.height / 2, self.width, self.height)
    end
end

return Enemy