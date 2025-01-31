--[[
    Variável global estética, 
    sua função é remover os sublinhados de erro do vscode
    por não reconhecer o ambiente global love
]] 
love = love
love.graphics.setDefaultFilter("nearest", "nearest")

local Menu = require("src.states.menu")
local Settings = require("src.states.settings")
local Gameplay = require("src.states.gameplay")

-- Gerenciador de estados do jogo
local current_state = nil

-- Função global para alterar o estado do jogo
function Change_state(newState)
    current_state = newState
    if current_state and current_state.load then
        current_state:load()
    end
end

function love.load()
    -- Inicializa o jogo no menu
    Change_state(Menu)
end

function love.update(dt)
    if current_state and current_state.update then
        current_state:update(dt)
    end
end

function love.draw()
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
    if current_state and current_state.draw then
        current_state:draw()
    end
end

function love.keypressed(key)
    if current_state and current_state.keypressed then
        current_state.keypressed(key)
    end
end
