--[[
    GD50
    Asteriod Fighter

    -- PlayerIdleState Class --
]]


PlayerIdleState = Class{__includes = BaseState}

function PlayerIdleState:init(player)
    self.player = player
    self.animation = Animation {
        frames = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
        interval = 0.15,
        texture = 'flames',
    }
    self.player.currentAnimation = self.animation
end

function PlayerIdleState:update(dt)
    if love.keyboard.isDown('left') then
        self.player:changeState('moving')
    elseif love.keyboard.isDown('right') then
        self.player:changeState('moving')
    elseif love.keyboard.isDown('up') then
        self.player:changeState('moving')
    end
end

function PlayerIdleState:render()
    love.graphics.draw(
        gTextures[self.animation.texture], 
        gFrames[self.animation.texture][self.animation:getCurrentFrame()],
        math.floor(self.player.center_x), -- position x
        math.floor(self.player.center_y), -- postion y
        self.player.angle,  -- rotation
        0.3,  -- scale x
        -0.3,  -- scale y
        16, -- offset x
        38  -- offset y
    )
end