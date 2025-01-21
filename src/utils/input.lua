local game_keys = require("src.utils.keys")

local Input = {}

function Input.up_press(key)
    return key == game_keys.up or key == game_keys.alt_up
end

return Input