local Interections = {}

local player_roles = require("src.utils.player_roles")

-- Player Context
function Interections.player_enemy_behavior(contact_data)
    if contact_data.collider2.collision_class == "Enemy" then
        if (contact_data.collider1_right > contact_data.collider2_left or contact_data.collider1_left < contact_data.collider2_right) and (contact_data.collider1_bottom > contact_data.collider2_top) then
            contact_data.entitie.is_alive = false -- Morte do Player
        elseif (contact_data.collider1_bottom - 1 <= contact_data.collider2_top) then
            contact_data.entitie.collider:applyLinearImpulse(0, contact_data.entitie.kick_jump_force * contact_data.entitie.mass)
        end
    end
end

function Interections.player_platform_behavior(contact_data)
    if contact_data.collider2.collision_class == "Platform" then
        local tolerance = 1

        if (contact_data.collider1_bottom >= contact_data.collider2_top - tolerance)
        and (contact_data.collider1_left < contact_data.collider2_right)
        and (contact_data.collider1_right > contact_data.collider2_left)
        and (contact_data.collider1_y_velocity >= 0) then
            contact_data.entitie.is_on_ground = true
        else
            contact_data.entitie.is_on_ground = false
        end
    end
end


function Interections.player_block_behavior(contact_data)
    if contact_data.collider2.collision_class == "Block" then
        if (contact_data.collider1_bottom <= contact_data.collider2_top) and (contact_data.collider1_left < contact_data.collider2_right) and (contact_data.collider1_right > contact_data.collider2_left) and (contact_data.collider1_y_velocity >= 0) then
            contact_data.entitie.is_on_ground = true
        else
            contact_data.entitie.is_on_ground = false
        end
    end
end

function Interections.player_powerUp_behavior(contact_data)
    -- 
end

function Interections.player_highground_behavior(contact_data)
    if contact_data.collider2.collision_class == "HighGround" then
        contact_data.contact:setEnabled(false)

        if contact_data.collider1_bottom < contact_data.collider2_top then
            contact_data.contact:setEnabled(true)
            contact_data.entitie.is_on_ground = true
        end
    end
end

-- Enemy Context
function Interections.enemy_player_behavior(contact_data)
    if contact_data.collider2.collision_class == "Player" then
        if (contact_data.collider2_bottom - 2 <= contact_data.collider1_top) then
            contact_data.collider1:setCollisionClass("DeadEnemy")
            contact_data.entitie.collider:setLinearVelocity(0, 0)
            contact_data.entitie.speed = 0
            contact_data.entitie.is_alive = false
            contact_data.entitie.death_timer = 0.3
        end
    end
end

-- Platform Context
function Interections.platform_player_behavior(contact_data)
    for _, role in ipairs(player_roles) do
        if contact_data.collider2.collision_class == role then
            if (contact_data.collider2_bottom) > (contact_data.collider1_bottom) then
                if contact_data.collider2_x >= contact_data.collider1_left and contact_data.collider2_x <= contact_data.collider1_right then
                    contact_data.contact:setEnabled(false)
                end
            end
        end
    end
end

-- Block Context
function Interections.block_player_behavior(contact_data)
    if contact_data.collider2_top >= contact_data.collider1_bottom then
        -- Mover power-up para cima do bloco
        contact_data.entitie.movePowerUp = true
        contact_data.entitie.status = false
    end
end

return Interections