local Menu = {}
local selectOption = 1
local options = { "Iniciar", "Configurações", "Sair" }

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

    -- teste press
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(selectOption, 15, 15)
end

function Menu.keypressed(key)
    print("Tecra pressionada: " .. key) 

    if key == "up" or key == "w" then
        selectOption = selectOption - 1
        if selectOption < 1 then
            selectOption = #options
        end
    elseif key == "down" or key == "s" then
        selectOption = selectOption + 1
        if selectOption > #options then
            selectOption = 1
        end 
    elseif key == "return" or key == "space" then
        if options[selectOption] == "Iniciar" then
            changeState(require("src.states.gameplay"))
        elseif options[selectOption] == "Configurações" then
            changeState(require("src.states.settings"))
        elseif options[selectOption] == "Sair" then
            love.event.quit()
        end
    end 
end

return Menu