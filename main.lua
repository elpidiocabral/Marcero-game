local Menu = require("src.states.menu")
local Settings = require("src.states.settings")
local Gameplay = require("src.states.gameplay")

-- Gerenciador de estados do jogo
local currentState = nil

-- Função global para alterar o estado do jogo
function changeState(newState)
    currentState = newState
    if currentState and currentState.load then
        currentState:load()
    end
end

function love.load()
    -- Inicializa o jogo no menu
    changeState(Menu)
end

function love.update(dt)
    if currentState and currentState.update then
        currentState:update(dt)
    end
end

function love.draw()
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
    if currentState and currentState.draw then
        currentState:draw()
    end
end

function love.keypressed(key)
    if currentState and currentState.keypressed then
        currentState.keypressed(key)
    end
end
