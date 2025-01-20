local game_keys = {
    -- Movement
    up = "w",
    down = "s",
    left = "a",
    right = "d",

    alt_up = "up",
    alt_down = "down",
    alt_left = "left",
    alt_right = "right",

    -- Actions
    confirm = "return",
    interact = "e",
    attack = "l",
    jump = "space",
    -- Inventory
    inventory = "i",
    -- Menu
    menu = "escape",

    -- Debug
    debug = "f1",

}

--[[
Funções adaptadas para funcionar com ou sem parâmetro
]]--

-- Movement
function game_keys.up_press(key)
    if key then
        return key == game_keys.up or key == game_keys.alt_up
    else
        return love.keyboard.isDown(game_keys.up) or love.keyboard.isDown(game_keys.alt_up)
    end
end

function game_keys.down_press(key)
    if key then
        return key == game_keys.down or key == game_keys.alt_down
    else
        return love.keyboard.isDown(game_keys.down) or love.keyboard.isDown(game_keys.alt_down)
    end
end

function game_keys.left_press(key)
    if key then
        return key == game_keys.left or key == game_keys.alt_left
    else
        return love.keyboard.isDown(game_keys.left) or love.keyboard.isDown(game_keys.alt_left)
    end
end

function game_keys.right_press(key)
    if key then
        return key == game_keys.right or key == game_keys.alt_right
    else
        return love.keyboard.isDown(game_keys.right) or love.keyboard.isDown(game_keys.alt_right)
    end
end

-- Actions
function game_keys.jump_press(key)
    if key then
        return key == game_keys.jump
    else
        return love.keyboard.isDown(game_keys.jump)
    end
end

function game_keys.confirm_press(key)
    if key then
        return key == game_keys.confirm
    else
        return love.keyboard.isDown(game_keys.confirm)
    end
end

-- Releases


return game_keys