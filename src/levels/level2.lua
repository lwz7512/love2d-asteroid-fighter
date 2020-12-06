--[[
    GD50 - final project
    Asteriod Fighter

    -- Level Specification --
]]

local GAME_OBJECT_DEFS = {
  ['bullet'] = {
    texture = 'laser-2',
    width = 3,
    height = 3,
    scaleX = 0.1,
    scaleY = 0.1,
    offsetX = 5,
    offsetY = 5,
    angleFix = math.pi/2,
    speed = 100
  },
  ['reward'] = {
    texture = 'missile',
    width = 4,
    height = 8,
    scaleX = 0.2,
    scaleY = 0.2,
    offsetX = 5,
    offsetY = 5,
    angleFix = 0,
    speed = 10
  },
  ['asteriod'] = {
    ['big'] = {
      texture = 'meteor-big-',
      variants = 4,
      class = 1, -- big:1, small:2, tiny:3
      width = 12,
      height = 12,
      scaleX = 0.2,
      scaleY = 0.2,
      offsetX = 50,
      offsetY = 50,
      angleFix = 0,
      speed = 30,
      withAI = true, -- smart asteriod following the player all the time
      count = 3,
      health = 5
    },
    ['small'] = {
      texture = 'meteor-small-',
      variants = 2,
      class = 2, -- big:1, small:2, tiny:3
      width = 4,
      height = 4,
      scaleX = 0.2,
      scaleY = 0.2,
      offsetX = 15,
      offsetY = 15,
      angleFix = 0,
      speed = 40,
      withAI = false,
      count = 3,
      health = 1
    },
    ['tiny'] = {
      texture = 'meteor-tiny-',
      variants = 2,
      class = 3, -- big:1, small:2, tiny:3
      width = 2,
      height = 2,
      scaleX = 0.1,
      scaleY = 0.1,
      offsetX = 1,
      offsetY = 1,
      angleFix = 0,
      speed = 60,
      withAI = false,
      count = 3,
      health = 1
    }
  },
}

function GAME_OBJECT_DEFS.foo()
  print("This is level 2!")
end

return GAME_OBJECT_DEFS