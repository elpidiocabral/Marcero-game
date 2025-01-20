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

-- Movement
function game_keys.up_press(key) 
    return key == game_keys.up or key == game_keys.alt_up
end

function game_keys.down_press(key)
    return key == game_keys.down or key == game_keys.alt_down
end

function game_keys.left_press(key)
    return key == game_keys.left or key == game_keys.alt_left
end

function game_keys.right_press(key)
    return key == game_keys.right or key == game_keys.alt_right
end

-- Actions
function game_keys.jump_press(key)
    return key == game_keys.jump
end

function game_keys.confirm_press(key)
    return key == game_keys.confirm or key == game_keys.alt_confirm
end

return game_keys