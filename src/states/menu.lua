local Menu = {}
local selectOption = 1
local options = { "Iniciar", "Configurações", "Sair" }

local input = require("src.utils.input")

function Menu.load()
    
end

function Menu.update(dt)
    
end

function Menu.draw()
    love.graphics.setBackgroundColor(0.1, 0.1, 0.1)
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(love.graphics.newFont(24))

    -- desenho das opções
    for i, options in ipairs(options) do 
        if i == selectOption then
            love.graphics.setColor(1, 0, 0)
        else 
            love.graphics.setColor(1, 1, 1)
        end
        love.graphics.printf(options, 0, 200 + (i * 40), 800, "center")
    end 
end

function Menu.keypressed(key)
    input.keypressed(key)

    if input.up_pressed() then
        selectOption = selectOption - 1
        if selectOption < 1 then
            selectOption = #options
        end
    elseif input.down_pressed() then
        selectOption = selectOption + 1
        if selectOption > #options then
            selectOption = 1
        end 
    elseif input.confirm_press() or input.jump_press() then
        if options[selectOption] == "Iniciar" then
            Change_state(require("src.states.gameplay"))
        elseif options[selectOption] == "Configurações" then
            Change_state(require("src.states.settings"))
        elseif options[selectOption] == "Sair" then
            love.event.quit()
        end
    end
end

function Menu.keyreleased(key)
    input.keyreleased(key)
end

return Menu