--- @module polo.game_keys

local game_keys = {
    up = "w",
    alt_up = "up",
    down = "s",
    alt_down = "down",
    left = "a",
    alt_left = "left",
    right = "d",
    alt_right = "right",
    confirm = "space",
    alt_confirm = "return",
}

function game_keys.up_pressed(key) return key == game_keys.up or key == game_keys.alt_up end
function game_keys.down_pressed(key) return key == game_keys.down or key == game_keys.alt_down end
function game_keys.left_pressed(key) return key == game_keys.left or key == game_keys.alt_left end
function game_keys.right_pressed(key) return key == game_keys.right or key == game_keys.alt_right end
function game_keys.confirm_pressed(key) return key == game_keys.confirm or key == game_keys.alt_confirm end

return game_keys