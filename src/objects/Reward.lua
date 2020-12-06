--[[
    GD50 - final project
    Asteriod Fighter

    -- Reward Class --
]]

Reward = Class{__includes = GameObject}

function Reward:init(def)
  GameObject.init(self, def)

  self.speedX = math.random(def.speed) - def.speed/2
  self.speedY = math.random(def.speed) - def.speed/2
  -- flag to be collected by player
  self.consumeable = true
end

function Reward:placeTo(x, y)
  self.x = x
  self.y = y
end

function Reward:collect()
  self.consumeable = false
  self:dead()
end

function Reward:update(dt)

    self.x = self.x + self.speedX * dt
    self.y = self.y + self.speedY * dt

    if self.x < 0 then
      self.x = VIRTUAL_WIDTH
    end
    if self.x > VIRTUAL_WIDTH then
      self.x = 0
    end
    if self.y < 0 then
      self.y = VIRTUAL_HEIGHT
    end
    if self.y > VIRTUAL_HEIGHT then
        self.y = 0
    end

end

function Reward:damage(point)
  -- do nothing
end

function Reward:isDead()
  -- do nothing
end

