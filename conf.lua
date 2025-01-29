function love.conf(t)
    t.window.title = "Marcero Adventures"         
    t.window.width = 1280 --640 * 2
    t.window.height = 720 --360 * 2
    t.window.resizable = false
    t.window.fullscreen = false
    t.window.vsync = 1
    -- t.window.icon = "assets/images/icon.png"
    
    t.modules.audio = true
    t.modules.event = true
    t.modules.graphics = true
    t.modules.image = true
    t.modules.timer = true
    t.modules.mouse = true
    t.modules.keyboard = true
    t.modules.physics = true

    -- Por algum motivo o console faz o jogo crashar em 1min
	-- t.console = true
end
