--[[
    GD50 - final project
    Asteriod Fighter

    -- Level Maker Class --
]]

LevelMaker = Class{}

-- global static constant, but:
-- this should be dynamic according to the level files count
LevelMaker.level_total = 2

-- GENERATE NEXT LEVEL ...
function LevelMaker.nextLevel(currentLevel)
    return LevelMaker.generate(currentLevel+1)
end

-- === Dynamic LOAD level definition module ===
function LevelMaker.generate(level)
    local levelModule = 'src/levels/level'..tostring(level)
    package.loaded[levelModule]=false
    -- load level module ...
    local gameObjDefs = require(levelModule)
    local entities = {} -- have state, asteriods
    local objects = {}  -- no state, bullet
    -- create initial asteriods
    local asteriods = gameObjDefs['asteriod']['big'].count
    local rewardIdx = math.random(asteriods)
    local offset = 30 -- make it outside of the screen
    for i = 1, asteriods do
        local asteriod = Asteriod(gameObjDefs['asteriod']['big'])
        local rdmX = math.random(VIRTUAL_WIDTH + offset) - offset
        local rdmY = math.random(VIRTUAL_HEIGHT + offset) - offset
        asteriod:placeTo(rdmX, rdmY)
        if i == rewardIdx then
            asteriod:attachReward()
        end
        table.insert(entities, asteriod)
    end
    return GameLevel(entities, objects, gameObjDefs)
end