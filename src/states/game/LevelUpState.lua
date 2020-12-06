--[[
    GD50
    Asteriod Fighter

    level up screen to forward next level or success
    @2020/12/05
]]

LevelUpState = Class{__includes = BaseState}

function LevelUpState:init()
    self.level_num = 0
end

function LevelUpState:enter(def)
    gSounds['battle-music']:pause()

    self.level_num = def.level + 1
    self.player = def.player -- player texture
    self.mode = def.mode
    
    -- check won
    if self.level_num > LevelMaker.level_total then
      gStateMachine:change('won')
    else
      gSounds['levelup']:play()
    end
end


function LevelUpState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change(
          'play',
          {
            level = self.level_num,
            player = self.player,
            mode = self.mode,
          }
        )
    end
end


function LevelUpState:render()

    local gameTitle = 'Level Up!'
    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(0/255, 88/255, 49/255, 1)
    love.graphics.printf(gameTitle, 1, VIRTUAL_HEIGHT / 2 - 40 + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf(gameTitle, 0, VIRTUAL_HEIGHT / 2 - 40, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf(
      tostring(self.level_num), 1,  
      VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center'
    )

    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(51/255, 51/255, 51/255, 1)
    love.graphics.printf('Press Enter to continue', 1, VIRTUAL_HEIGHT / 2 + 27, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf('Press Enter to continue', 0, VIRTUAL_HEIGHT / 2 + 27, VIRTUAL_WIDTH, 'center')
end