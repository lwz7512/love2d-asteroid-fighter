--[[
    GD50
    Asteriod Fighter

    welcome screen
]]

StartState = Class{__includes = BaseState}

function StartState:init()
    self.background = math.random(3)
    self.level_num = 0
    self.score = 0

    self.pid = 1
    self.players = {
        'player-ship-1', 'player-ship-2', 'player-ship-4',
    }
    self.direction = nil
end

function StartState:enter(def)
    self.level_num = def.level
    self.score = def.score

    gSounds['start-music']:setLooping(true)
    gSounds['start-music']:setVolume(0.5)
    gSounds['start-music']:play()
end


function StartState:update(dt)
    -- choose fighter
    if love.keyboard.wasPressed('left') then
        gSounds['select']:play()

        self.pid = self.pid - 1

        if self.pid < 1 then self.pid = 3 end

        self.direction = 'l'

    elseif love.keyboard.wasPressed('right') then
        gSounds['select']:play()
        
        self.pid = self.pid + 1

        if self.pid > 3 then self.pid = 1 end

        self.direction = 'r'
    end
    
    -- enter the play state
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play', {
            level = self.level_num,
            score = self.score,
            player = self.players[self.pid],
        })
    end

    -- we no longer have this globally, so include here
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

end

function StartState:render()

    local gameTitle = 'Asteriod Fighter'
    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(0, 0, 255, 255)
    love.graphics.printf(gameTitle, 1, VIRTUAL_HEIGHT / 2 - 40 + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf(gameTitle, 0, VIRTUAL_HEIGHT / 2 - 40, VIRTUAL_WIDTH, 'center')

    -- player
    love.graphics.draw(
        gTextures[self.players[self.pid]], 
        VIRTUAL_WIDTH/2, VIRTUAL_HEIGHT / 2, 
        0, -- rotation
        0.1, 0.1 -- scale
    )

    -- selection arrow left
    if self.direction == 'l' then
        love.graphics.setColor(0/255, 0/255, 255/255, 255)
    end
    love.graphics.draw(
        gTextures['ui-sheet'],
        gFrames['ui-backward'],
        VIRTUAL_WIDTH/2 - 10, VIRTUAL_HEIGHT / 2 + 2,
        0, -- rotation
        0.1, 0.1 -- scale
    )

    -- reset color before drawing
    love.graphics.setColor(255, 255, 255, 255)

    if self.direction == 'r' then
        love.graphics.setColor(0/255, 0/255, 255/255, 255)
    end
    -- selection arrow right
    love.graphics.draw(
        gTextures['ui-sheet'],
        gFrames['ui-forward'],
        VIRTUAL_WIDTH/2 + 15, VIRTUAL_HEIGHT / 2 + 2,
        0, -- rotation
        0.1, 0.1 -- scale
    )
    
    local enterText = 'Press Enter to start'
    local choosePlayer = 'Press left/right arrow to select aircraft'
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(204/255, 204/255, 204/255, 255)
    love.graphics.printf(enterText, 1, VIRTUAL_HEIGHT / 2 + 27, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(204/255, 204/255, 204/255, 255)
    love.graphics.printf(choosePlayer, 0, VIRTUAL_HEIGHT / 2 + 40, VIRTUAL_WIDTH, 'center')
end