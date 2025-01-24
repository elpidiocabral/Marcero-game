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
    if not self.collider then return end -- Impede atualizações post mortem

    -- Movement
    local x_velocity, y_velocity = self.collider:getLinearVelocity()
    local x, y = self.collider:getPosition()

    if self.direction == 1 and x >= self.start_x + self.max_distance then
        self.direction = -1
    elseif self.direction == -1 and x <= self.start_x - self.max_distance then
        self.direction = 1
    end

    self.collider:setLinearVelocity(self.speed * self.direction, y_velocity)

    -- colisão com player
    self.collider:setPreSolve(
        function(collider1, collider2, contact)
            if collider2.collision_class == "Player" then
                local enemy_x, enemy_y = collider1:getPosition()
                local enemy_width, enemy_height = self.width, self.height
                local player_x, player_y = collider2:getPosition()
                local player = collider2:getObject()
                local player_width, player_height = player.width, player.height

                local player_left = player_x - player_width / 2
                local player_right = player_x + player_width / 2
                local enemy_left = enemy_x - enemy_width / 2
                local enemy_right = enemy_x + enemy_width / 2

                local player_top = player_y - player_height / 2
                local player_bottom = player_y + player_height / 2
                local enemy_top = enemy_y - enemy_height / 2
                local enemy_bottom = enemy_y + enemy_height / 2

                if (player_right > enemy_left or player_left < enemy_right) and (player_bottom > enemy_top) then
                    collider2:applyLinearImpulse(-300, -150)
                elseif (player_bottom <= enemy_top) then
                    collider2:applyLinearImpulse(0, -200)
                    collider1:destroy()
                    self.collider = nil
                end
            end
        end
    )
end

function Enemy:draw()
    -- Draw enemy
    if self.collider ~= nil then
        love.graphics.setColor(1, 0, 0)
        local x, y = self.collider:getPosition()
        love.graphics.rectangle("fill", x - self.width / 2, y - self.height / 2, self.width, self.height)
    end
end

return Enemy