local game_keys = require("src.utils.keys")

local Input = {
    pressed_keys = {}, -- Armazena o estado das teclas que foram pressionadas
}

function Input.keypressed(key) Input.pressed_keys[key] = true end

function Input.keyreleased(key) Input.pressed_keys[key] = false end

function Input.isPressed(key) -- Função para verificar se a tecla foi pressionada uma única vez
    if Input.pressed_keys[key] then
        Input.pressed_keys[key] = false -- Resetar o estado
        return true
    end
    return false
end

function Input.isDown(key) return love.keyboard.isDown(key) end

-- Se a tecla foi pressionada uma única vez
function Input.up_press() return Input.isPressed(game_keys.up) or Input.isPressed(game_keys.alt_up) end
function Input.down_press() return Input.isPressed(game_keys.down) or Input.isPressed(game_keys.alt_down) end
function Input.left_press() return Input.isPressed(game_keys.left) or Input.isPressed(game_keys.alt_left) end
function Input.right_press() return Input.isPressed(game_keys.right) or Input.isPressed(game_keys.alt_right) end
function Input.jump_press() return Input.isPressed(game_keys.jump) end
function Input.confirm_press() return Input.isPressed(game_keys.confirm) end

-- Se a tecla está pressionada
function Input.up_pressed() return Input.isDown(game_keys.up) or Input.isDown(game_keys.alt_up) end
function Input.down_pressed() return Input.isDown(game_keys.down) or Input.isDown(game_keys.alt_down) end
function Input.left_pressed() return Input.isDown(game_keys.left) or Input.isDown(game_keys.alt_left) end
function Input.right_pressed() return Input.isDown(game_keys.right) or Input.isDown(game_keys.alt_right) end
function Input.jump_pressed() return Input.isDown(game_keys.jump) end
function Input.confirm_pressed() return Input.isDown(game_keys.confirm) end

return Input
