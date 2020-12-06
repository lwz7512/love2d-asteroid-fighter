--[[
    GD50
    Asteriod Fighter

    -- Play Class --
]]


Player = Class{__includes = Entity}

function Player:init(def)

    self.angle = 0
    self.speed = 0
    self.change_x = 0
    self.change_y = 0
    self.health = 3
    self.damaged = false
    self.transitionAlpha = 0
    self.center_x = VIRTUAL_WIDTH/2 + 5
    self.center_y = VIRTUAL_HEIGHT / 2 + 4

    self.level = def.level -- game level to fire
    self.playerTexture = def.playerTexture
    self.stateMachine = StateMachine {
        ['idle'] = function() return PlayerIdleState(self) end,
        ['moving'] = function() return PlayerWalkingState(self) end,
        ['explode'] = function() return PlayerExplodeState(self) end
    }
    def['x'] = VIRTUAL_WIDTH/2
    def['y'] = VIRTUAL_HEIGHT/2
    def['width'] = 8
    def['height'] = 6
    def['texture'] = 'flames'  --  default animation texture
    def['stateMachine'] = self.stateMachine
    Entity.init(self, def)

    self:changeState('idle') -- initial state

    -- fadein
    Timer.tween(1, {
        [self] = {transitionAlpha = 1}
    })
    -- super mode to fire cluster missles
    self.superMode = false
end

-- restore to intial state, use 2nd life
function Player:onExplodeEnd()
    self.damaged = false
    self.superMode = false
    self.angle = 0
    self.center_x = VIRTUAL_WIDTH/2 + 5
    self.center_y = VIRTUAL_HEIGHT / 2 + 4
    self.change_x = 0
    self.change_y = 0
end

function Player:update(dt)
    Timer.update(dt)
    Entity.update(self, dt)  --  update player state, mainly for animation change

    if self.damaged then return end

    if love.keyboard.isDown('left') then
        self.angle = self.angle - 3 * math.pi / 180
        self:move()
    elseif love.keyboard.isDown('right') then
        self.angle = self.angle + 3 * math.pi / 180
        self:move()
    elseif love.keyboard.isDown('up') then
        self.speed = self.speed + 0.03
        self:move()
    else
        self:slowdown() -- no key pressed then slowdown
        self:move()
    end
    
    if love.keyboard.wasPressed('space') then
        self:fire()
    end
    
    -- update player position
    self.center_x = self.center_x + self.change_x
    self.center_y = self.center_y + self.change_y

    -- correct player position if out of screen
    if self.center_x < 0 then
        self.center_x = VIRTUAL_WIDTH
    end
    if self.center_x > VIRTUAL_WIDTH then
        self.center_x = 0
    end
    if self.center_y < 0 then
        self.center_y = VIRTUAL_HEIGHT
    end
    if self.center_y > VIRTUAL_HEIGHT then
        self.center_y = 0
    end

    -- save player position to check collision
    self.x = self.center_x
    self.y = self.center_y

    -- then check collision using x/y
    local collided = self:checkAsteriodsCollision()
    if collided then
        self.health = self.health - 1
        gSounds['explosion-2']:play()
        self.damaged = true
        self:changeState('explode') -- explosion state
    end

    -- tell game level my position, not necessary currently
    self.level:follow(self.center_x, self.center_y)
end


function Player:isDead()
    return self.health == 0
end


function Player:move()
    self.change_x = math.sin(self.angle) * self.speed
    self.change_y = -math.cos(self.angle) * self.speed
end

function Player:slowdown()
    self.speed = self.speed - 0.015
    if self.speed < 0 then
        self.speed = 0
    end
end

-- add a bullet
function Player:fire()

    if self.superMode then
        gSounds['missile']:play()
        self.level:clusterFire(self.center_x, self.center_y, self.angle)
    else
        gSounds['fire']:play()
        self.level:fire(self.center_x, self.center_y, self.angle)
    end
end

function Player:render()

    love.graphics.setColor(1, 1, 1, self.transitionAlpha)

    Entity.render(self)  --  render player state, flames animation
    
    if self.damaged then return end

    -- player
    love.graphics.draw(
        gTextures[self.playerTexture], 
        self.center_x, 
        self.center_y, 
        self.angle, -- rotation
        self.superMode and 0.15 or 0.1,  -- scale y 
        self.superMode and 0.15 or 0.1,  -- scale y
        50, 40 -- offset to make rotation normal
    )
    -- USE THIS TO DEBUG PLAYER ROTATION
    -- love.graphics.rectangle("fill", VIRTUAL_WIDTH/2, VIRTUAL_HEIGHT / 2, 10, 10 )
end


function Player:checkAsteriodsCollision()
    local isCollided = false

    for k, object in pairs(self.level.entities) do
        if object:collides(self) then
            isCollided = true
        end
        if object.consumeable and isCollided then
            object:collect()  --  got the reward
            self.superMode = true
            return false
        end
    end

    return isCollided
end