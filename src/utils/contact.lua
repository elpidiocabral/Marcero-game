local Contact = {}
local contact_data = {}

function Contact.handleColision(entitie, collision_function)
    entitie.collider:setPreSolve(function(collider1, collider2, contact)
        local collider1_x, collider1_y = collider1:getPosition()
        local collider1_width, collider1_height = entitie.width, entitie.height

        local collider2_obj = collider2:getObject()
        local collider2_x, collider2_y, collider2_width, collider2_height
        
        if collider2_obj then
            collider2_x, collider2_y = collider2:getPosition()
            collider2_width, collider2_height = collider2_obj.width, collider2_obj.height
        else
            collider2_x, collider2_y = collider2:getPosition()
            collider2_width, collider2_height = 0, 0
        end

        local collider2_left = collider2_x - collider2_width / 2
        local collider2_right = collider2_x + collider2_width / 2
        local collider1_left = collider1_x - collider1_width / 2
        local collider1_right = collider1_x + collider1_width / 2

        local collider2_top = collider2_y - collider2_height / 2
        local collider2_bottom = collider2_y + collider2_height / 2
        local collider1_top = collider1_y - collider1_height / 2
        local collider1_bottom = collider1_y + collider1_height / 2

        contact_data = {
            entitie = entitie,
            collider1 = collider1,
            collider2 = collider2,
            contact = contact,
            collider1_x = collider1_x,
            collider1_y = collider1_y,
            collider1_width = collider1_width,
            collider1_height = collider1_height,
            collider2_obj = collider2_obj,
            collider2_x = collider2_x,
            collider2_y = collider2_y,
            collider2_width = collider2_width,
            collider2_height = collider2_height,
            collider2_left = collider2_left,
            collider2_right = collider2_right,
            collider1_left = collider1_left,
            collider1_right = collider1_right,
            collider2_top = collider2_top,
            collider2_bottom = collider2_bottom,
            collider1_top = collider1_top,
            collider1_bottom = collider1_bottom
        }

        collision_function(contact_data)
    end)
end

return Contact
