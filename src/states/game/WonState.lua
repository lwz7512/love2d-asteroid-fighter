--[[
    GD50
    Asteriod Fighter

    game over screen with animation
]]

WonState = Class{__includes = BaseState}

function WonState:init()
    self.animation = Animation {
        frames = {
            1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
            16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27
        },
        interval = 0.1,
        texture = 'fireworks',
    }
end

function WonState:enter(def)
    gSounds['winning']:play()
end


function WonState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('start', {level = 1, score = 0})
    end

    if self.animation then
        self.animation:update(dt)
    end
end

function WonState:exit()
  gSounds['winning']:pause()
end


function WonState:render()
    -- draw fireworks animation
    love.graphics.draw(
        gTextures[self.animation.texture], 
        gFrames[self.animation.texture][self.animation:getCurrentFrame()],
        VIRTUAL_WIDTH/2 - 119/2, -- position x
        VIRTUAL_HEIGHT - 64 -- postion y
    )
    -- draw title
    local gameTitle = 'You Won!'
    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf(gameTitle, 1, VIRTUAL_HEIGHT / 2 - 40 + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.printf(gameTitle, 0, VIRTUAL_HEIGHT / 2 - 40, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(102/255, 102/255, 102/255, 255)
    love.graphics.printf('Press Enter to restart', 1, VIRTUAL_HEIGHT / 2 + 5, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Press Enter to restart', 0, VIRTUAL_HEIGHT / 2 + 5, VIRTUAL_WIDTH, 'center')
end