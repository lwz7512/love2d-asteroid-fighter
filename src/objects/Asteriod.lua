--[[
    GD50 - final project
    Asteriod Fighter

    -- Asteriod Class --
]]

Asteriod = Class{__includes = GameObject}

function Asteriod:init(def)
  GameObject.init(self, def)

  local rdmTxr = tostring(math.random(def.variants))
  self.texture = def.texture..rdmTxr
  self.withAI  = def.withAI
  self.health  = def.health   --  current health
  self.origHealth = def.health -- original health
  self.class   = def.class  --  asteriod size level
  self.origSpeed = def.speed
  self.speedX = math.random(def.speed) - def.speed/2
  self.speedY = math.random(def.speed) - def.speed/2
  self.deltaAnlge = math.random(2) * math.pi/180
  self.withReward = false
  -- for ai moving use seems like asteriod is thinking
  self.lazyMovingCounter = 0
end

function Asteriod:attachReward()
  self.withReward = true
end

function Asteriod:placeTo(x, y)
  self.x = x
  self.y = y
end

function Asteriod:damage(point)
  self.health = self.health - point
end

function Asteriod:isDead()
  -- health may be NEGATIVE !!!
  return self.health <= 0
end

-- fix move speed by following positon
function Asteriod:performAI(playerX, playerY, dt)
  self.lazyMovingCounter = self.lazyMovingCounter + 1
  -- need time to simulate response behavior
  if self.lazyMovingCounter % 60 ~= 0 then return end
  -- only take effect every 60th frame
  local currentDiffX = playerX - self.x
  if currentDiffX < 0 then
    self.speedX = - self.origSpeed/4
  else
    self.speedX = self.origSpeed/4
  end
  local currentDiffY = playerY - self.y
  if currentDiffY < 0 then
    self.speedY = - self.origSpeed/4
  else
    self.speedY = self.origSpeed/4
  end
end

function Asteriod:explode()
  gSounds['hit-1']:play()
  self:dead() -- disappear
end

function Asteriod:update(dt)

    self.x = self.x + self.speedX * dt
    self.y = self.y + self.speedY * dt
    self.angle = self.angle + self.deltaAnlge

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

    if self.health <= 0 then
      self:explode()
    end

end

function Asteriod:render()
  GameObject:render(self)
  -- draw health bar
  if self.withAI then
    local loss = 1 - self.health/self.origHealth
    local diff = 10 * loss
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.rectangle('fill', self.x - 5, self.y - 10, 10, 3)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle('fill', self.x - 4.6 + (9 - diff), self.y - 9.6, diff, 2)
    love.graphics.setColor(1, 1, 1, 1)
  end
end
