local game_keys = require("src.utils.keys")

local Input = {
    pressed_keys = {}, -- Armazena o estado das teclas que foram pressionadas
}

function Input.keypressed(key) Input.pressed_keys[key] = true end

function Input.keyreleased(key) Input.pressed_keys[key] = false end

function Input.is_pressed(key) -- Função para verificar se a tecla foi pressionada uma única vez
    if Input.pressed_keys[key] then
        Input.pressed_keys[key] = false -- Resetar o estado
        return true
    end
    return false
end

function Input.is_down(key) return love.keyboard.isDown(key) end

-- Se a tecla foi pressionada uma única vez
function Input.up_press() return Input.is_pressed(game_keys.up) or Input.is_pressed(game_keys.alt_up) end
function Input.down_press() return Input.is_pressed(game_keys.down) or Input.is_pressed(game_keys.alt_down) end
function Input.left_press() return Input.is_pressed(game_keys.left) or Input.is_pressed(game_keys.alt_left) end
function Input.right_press() return Input.is_pressed(game_keys.right) or Input.is_pressed(game_keys.alt_right) end
function Input.jump_press() return Input.is_pressed(game_keys.jump) end
function Input.confirm_press() return Input.is_pressed(game_keys.confirm) end
function Input.escape_press() return Input.is_pressed(game_keys.escape) end
function Input.debug_press() return Input.is_pressed(game_keys.debug) end

-- Se a tecla está pressionada
function Input.up_pressed() return Input.is_down(game_keys.up) or Input.is_down(game_keys.alt_up) end
function Input.down_pressed() return Input.is_down(game_keys.down) or Input.is_down(game_keys.alt_down) end
function Input.left_pressed() return Input.is_down(game_keys.left) or Input.is_down(game_keys.alt_left) end
function Input.right_pressed() return Input.is_down(game_keys.right) or Input.is_down(game_keys.alt_right) end
function Input.jump_pressed() return Input.is_down(game_keys.jump) end
function Input.confirm_pressed() return Input.is_down(game_keys.confirm) end

return Input
