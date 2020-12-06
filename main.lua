--[[
    Asteriod Fighter

    By lwz7512 @2020/12/01

    Idea from:
    https://arcade.academy/examples/asteroid_smasher.html
]]

require 'src/Dependencies'

love.graphics.setDefaultFilter('nearest', 'nearest')

function love.load()

    love.graphics.setFont(gFonts['medium'])
    love.window.setTitle('Asteriod Fighter')

    math.randomseed(os.time())
    
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true,
        canvas = false
    })

    gStateMachine = StateMachine {
        ['start']   = function() return StartState() end,
        ['play']    = function() return PlayState() end,
        ['over']    = function() return EndState() end,
        ['levelup'] = function() return LevelUpState() end,
        ['won'] = function() return WonState() end,
    }
    gStateMachine:change('start', {level = START_LEVEL, score = 0})

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
    gStateMachine:render()
    push:finish()
end