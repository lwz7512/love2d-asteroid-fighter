--[[
    GD50
    Asteriod Fighter

    game over screen
]]

EndState = Class{__includes = BaseState}

function EndState:init()
    -- self.background = math.random(3)
    -- self.level_num = 0
    -- self.score = 0
end

function EndState:enter(def)
    gSounds['battle-music']:pause()
    gSounds['gameover']:play()
end


function EndState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('start', {level = 1, score = 0})
    end
end


function EndState:render()

    local gameTitle = 'Game Over'
    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf(gameTitle, 1, VIRTUAL_HEIGHT / 2 - 40 + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(0, 0, 255, 255)
    love.graphics.printf(gameTitle, 0, VIRTUAL_HEIGHT / 2 - 40, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(102/255, 102/255, 102/255, 255)
    love.graphics.printf('Press Enter to restart', 1, VIRTUAL_HEIGHT / 2 + 27, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Press Enter to restart', 0, VIRTUAL_HEIGHT / 2 + 27, VIRTUAL_WIDTH, 'center')
end