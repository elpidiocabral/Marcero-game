local Game_Over = {}

local input = require("src.utils.input")

function Game_Over.load()

end

function Game_Over.update(dt)

end

function Game_Over.draw()
    love.graphics.setBackgroundColor(0.1, 0.1, 0.1)
    love.graphics.setColor(1, 0, 0)
    love.graphics.setFont(love.graphics.newFont(24))

    love.graphics.printf("Game Over", 0, 200, 800, "center")
    love.graphics.printf("Pressione Enter ou Espaço para voltar ao menu", 0, 300, 800, "center")
end

function Game_Over.keypressed(key)
    input.keypressed(key)

    if input.confirm_press() or input.jump_press() then
        Change_state(require("src.states.menu"))
    end
end

function Game_Over.keyreleased(key)
    input.keypressed(key)
end

return Game_Over