--[[
    GD50
    Asteriod Fighter

    -- PlayState Class --
]]

PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.camX = 0
    self.camY = 0
    
    self.background = math.random(3)
    self.backgroundX = 0
    self.level_num = 0
    self.gravityOn = true
    self.gravityAmount = 6
    self.level = nil  --  init Game Level Object later
end

function PlayState:enter(def)
    gSounds['start-music']:pause()
    gSounds['battle-music']:setLooping(true)
    gSounds['battle-music']:setVolume(0.5)
    gSounds['battle-music']:play()

    self.level_num = def.level
    self.playerTexture = def.player

    self.level = LevelMaker.generate(self.level_num)

    self.player = Player({
        playerTexture = self.playerTexture,  --  plain image
        level = self.level,  -- game level obj
    })

    if def.mode then
        self.player.superMode = true
    end

end

function PlayState:update(dt)
    
    -- remove any nils from pickups, etc.
    self.level:clear()

    -- update player and level
    self.player:update(dt)
    self.level:update(dt)
    
    -- game over !
    if self.player:isDead() then
        gStateMachine:change('over')
    end

    -- next level
    if self.level:isEmpty() then
        gStateMachine:change(
            'levelup', 
            {
                level = self.level_num,
                player = self.playerTexture,
                mode = self.player.superMode,
            }
        )
    end
    
end

function PlayState:render()

    -- background
    love.graphics.draw(
        gTextures['background'],
        0, 0,
        0, -- rotation
        0.5, 0.5 -- scale
    )

    -- render player life
    love.graphics.setColor(1, 1, 1, 1)
    for x = 1, self.player.health do
        love.graphics.draw(
            gTextures[self.playerTexture], 
            x * 10 + 4, 
            6, 
            0, -- rotation
            0.06, 0.06, -- scale
            50, 40 -- offset to make rotation normal
        )
    end
    -- level
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print('Level '..tostring(self.level_num), VIRTUAL_WIDTH - 40, 5)

    love.graphics.push()
    
    self.level:render()
    self.player:render()

    love.graphics.pop()
end
