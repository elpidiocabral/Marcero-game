Keys = {
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
function Keys.up_press(key) 
    return key == Keys.up or key == Keys.alt_up
end

function Keys.down_press(key)
    return key == Keys.down or key == Keys.alt_down
end

function Keys.left_press(key)
    return key == Keys.left or key == Keys.alt_left
end

function Keys.right_press(key)
    return key == Keys.right or key == Keys.alt_right
end

-- Actions
function Keys.jump_press(key)
    return key == Keys.jump
end

function Keys.confirm_press(key)
    return key == Keys.confirm or key == Keys.alt_confirm
end
