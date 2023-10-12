function love.conf(t)
    -- misc configs
    t.console = true

    -- window config
    t.window.title = "Project Dominium"
    t.window.icon = nil
    t.window.width = 1200
    t.window.height = 900
    t.window.borderless = false
    t.window.resizable = true
    t.window.minwidth = 100
    t.window.minheight = 100
    t.window.fullscreen = false
    t.window.fullscreentype = "desktop"
    t.window.vsync = 1
    t.window.msaa = 1
end