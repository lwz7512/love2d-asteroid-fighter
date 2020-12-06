--[[
    GD50 - final project
    Asteriod Fighter

    -- GameLevel Class --
]]


GameLevel = Class{}

function GameLevel:init(entities, objects, defs)
    self.entities = entities -- asteriods
    self.objects = objects -- bullets
    self.defs = defs  --  level objs definition, bullets/asteriods
    -- asteriod to be exploded
    self.shotted = nil
    -- player initial position
    self.playerX = VIRTUAL_WIDTH/2 + 5
    self.playerY = VIRTUAL_HEIGHT / 2 + 4
end

-- dynamic add a bullet
function GameLevel:fire(x, y, angle)
    local bullet = GameObject(self.defs['bullet'])
    bullet.x = x
    bullet.y = y
    bullet.angle = angle
    table.insert(self.objects, bullet)
end

-- Crazy mode to shot cluster bullets in 2nd level
function GameLevel:clusterFire(x, y, angle)
    for i = 1, 3 do
        local bullet_1 = GameObject(self.defs['bullet'])
        bullet_1.x = x
        bullet_1.y = y
        bullet_1.angle = angle + (i-2) * math.pi/30
        table.insert(self.objects, bullet_1)
    end
end

-- spawn reward game object
function GameLevel:spawnReward(x, y)
    local missile = Reward(self.defs['reward'])
    missile:placeTo(x, y)
    table.insert(self.entities, missile)
end

-- dynamic create asteriods
function GameLevel:explode(x, y, size)
    if size == 3 then return end  --  tiny one doesnt explode

    local asteriodDef = size == 1 and 
        self.defs['asteriod']['small'] or self.defs['asteriod']['tiny']
    
    local asteriods = asteriodDef.count
    for i = 1, asteriods do
        local asteriod = Asteriod(asteriodDef)
        asteriod:placeTo(x, y)
        table.insert(self.entities, asteriod)
    end

    gSounds['explosion-1']:play()
end

-- follow player
function GameLevel:follow(playerX, playerY)
    self.playerX = playerX
    self.playerY = playerY
end

--[[
    Remove all nil references from tables in case they've set themselves to nil.
]]
function GameLevel:clear()
    for i = #self.objects, 1, -1 do
        if not self.objects[i].alive then
            table.remove(self.objects, i)
        end
    end

    for i = #self.entities, 1, -1 do
        if not self.entities[i].alive then
            table.remove(self.entities, i)
        end
    end
end

function GameLevel:isEmpty()
    return #self.entities == 0
end

function GameLevel:update(dt)
    -- reset target asteriod
    self.shotted = nil

    -- bullets
    for k, object in pairs(self.objects) do
        object:update(dt)
        -- check collide with asteriods ...
        for e, aste in pairs(self.entities) do
            if object:collides(aste) then
                object:dead()  -- bullet disappear
                aste:damage(1) -- hit the asteriod
                self.shotted = aste -- remember it
            end
        end
    end
    -- asteriods
    for k, entity in pairs(self.entities) do
        if entity.withAI then -- reset game object moving if AI enabled
            entity:performAI(self.playerX, self.playerY, dt)
        end
        entity:update(dt)
    end
    -- explode if dead
    if self.shotted and self.shotted:isDead() then
        self:explode(self.shotted.x, self.shotted.y, self.shotted.class)
        if self.shotted.withReward then
            self:spawnReward(self.shotted.x, self.shotted.y)
        end
    end
end

function GameLevel:render()

    for k, object in pairs(self.objects) do
        object:render()
    end

    for k, entity in pairs(self.entities) do
        entity:render()
    end
end