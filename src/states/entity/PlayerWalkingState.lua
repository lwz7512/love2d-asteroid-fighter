--[[
    GD50
    Asteriod Fighter

    -- PlayerWalkingState Class --
]]


PlayerWalkingState = Class{__includes = BaseState}

function PlayerWalkingState:init(player)
    self.player = player
    self.animation = Animation {
        frames = {1, 2, 3},
        interval = 0.15,
        texture = 'flame-',
    }
    self.player.currentAnimation = self.animation
end

function PlayerWalkingState:update(dt)

    -- idle if we're not pressing anything at all
    if not love.keyboard.isDown('left') and 
        not love.keyboard.isDown('right') and
            not love.keyboard.isDown('up')
        then
        self.player:changeState('idle')
    end

end

function PlayerWalkingState:render()
    love.graphics.draw(
        gTextures[self.animation.texture..tostring(self.animation:getCurrentFrame())],
        math.floor(self.player.center_x), -- position x
        math.floor(self.player.center_y), -- postion y
        self.player.angle - math.pi/2,  -- rotation
        0.3,  -- scale x
        -0.3,  -- scale y
        40, -- offset y
        4  -- offset x
    )
end