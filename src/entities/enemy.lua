local Enemy = {}
Enemy.__index = Enemy

function Enemy:new(x, y)
    local enemy = {}
    setmetatable(enemy, Enemy)

    -- Enemy attributes
    enemy.x = x or 200
    enemy.y = y or 200
    enemy.width = 32
    enemy.height = 32

    enemy.collider = nil

    enemy.speed = 100
    enemy.direction = -1  -- 1 for right, -1 for left
    enemy.max_distance = 100  -- Distance to walk before changing direction
    enemy.start_x = x or 200

    enemy.is_alive = true
    enemy.death_timer = 0

    return enemy
end

function Enemy.contact_behavior(contact_data)
    if contact_data.collider2.collision_class == "Player" then
        if (contact_data.collider2_right > contact_data.collider1_left or
        contact_data.collider2_left < contact_data.collider1_right) and
        (contact_data.collider2_bottom > contact_data.collider1_top) then
            -- Esse if de colisão lateral para player - enemy
        elseif (contact_data.collider2_bottom <= contact_data.collider1_top) then
            contact_data.collider1:setCollisionClass("DeadEnemy")
            contact_data.entitie.collider:setLinearVelocity(0, 0)
            contact_data.entitie.is_alive = false
            contact_data.entitie.speed = 0
            contact_data.entitie.death_timer = 0.3
            --contact_data.collider1:destroy()
            --contact_data.entitie.collider = nil
        end
    end
end

function Enemy:update(dt)
    if not self.collider then return end -- Impede atualizações post mortem

    -- Verificar se o inimigo morreu
    if not self.is_alive then
        self.death_timer = self.death_timer - dt
        if self.death_timer <= 0 then
            self:destroy()
            self.collider = nil
        end
        return
    end

    -- Movement
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

function Enemy:destroy()
    if self.collider then
        self.collider:destroy()
        self.collider = nil
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