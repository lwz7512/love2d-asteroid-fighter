--[[
    GD50
    -- Super Mario Bros. Remake --

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GameObject = Class{}

function GameObject:init(def)
    self.x = 0
    self.y = 0
    self.angle = 0

    self.texture = def.texture
    self.width = def.width
    self.height = def.height
    self.scaleX = def.scaleX
    self.scaleY = def.scaleY
    self.offsetX = def.offsetX
    self.offsetY = def.offsetY
    self.speed = def.speed
    self.angleFix = def.angleFix

    self.frame = def.frame
    self.solid = def.solid
    self.collidable = def.collidable
    self.consumable = def.consumable
    self.onCollide = def.onCollide
    self.onConsume = def.onConsume
    self.hit = def.hit
    self.unlockable = def.unlockable

    self.alive = true
end

function GameObject:collides(target)
    return not (target.x > self.x + self.width or self.x > target.x + target.width or
            target.y > self.y + self.height or self.y > target.y + target.height)
end

function GameObject:update(dt)
    local deltaX = math.sin(self.angle) * self.speed * dt
    local deltaY = -math.cos(self.angle) * self.speed * dt
    
    self.x = self.x + deltaX
    self.y = self.y + deltaY

    if self.y < 0 or self.y > VIRTUAL_HEIGHT or
     self.x < 0 or self.x > VIRTUAL_WIDTH then
        self:dead()
    end
end

function GameObject:render(ctx)
    -- TRICKY: ctx is for sub class use
    if ctx then self = ctx end

    love.graphics.draw(
        gTextures[self.texture], 
        self.x, self.y,
        self.angle - self.angleFix,
        self.scaleX, self.scaleY,
        self.offsetX, self.offsetY
    )
end

function GameObject:dead()
    self.alive = false
end