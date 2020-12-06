--[[
    GD50
    Asteriod Fighter

    -- PlayerExplodeState Class --
]]


PlayerExplodeState = Class{__includes = BaseState}

function PlayerExplodeState:init(player)
    self.player = player
    self.animation = Animation {
        frames = {1, 2, 3, 2, 1},
        interval = 0.1,
        texture = 'explosion-',
    }
    self.player.currentAnimation = self.animation
end

-- when animation complete change to idle
function PlayerExplodeState:update(dt)
    if self.animation:toTheEnd() then
      self.player:onExplodeEnd()
      self.player:changeState('idle')
    end
end

function PlayerExplodeState:render()
  love.graphics.draw(
      gTextures[self.animation.texture..tostring(self.animation:getCurrentFrame())],
      math.floor(self.player.center_x), -- position x
      math.floor(self.player.center_y), -- postion y
      self.player.angle - math.pi/2,  -- rotation
      0.2,  -- scale x
      0.2,  -- scale y
      20, -- offset y
      20  -- offset x
  )
end