--[[
    GD50 - final project
    Asteriod Fighter

    -- Level Specification --
]]

local GAME_OBJECT_DEFS = {
  ['bullet'] = {
    texture = 'laser-1',
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
      texture = 'meteor-medium-',
      variants = 2,
      class = 1, -- big:1, small:2, tiny:3
      width = 6,
      height = 6,
      scaleX = 0.2,
      scaleY = 0.2,
      offsetX = 20,
      offsetY = 20,
      angleFix = 0,
      speed = 20,
      withAI = false,
      count = 6,
      health = 1
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
  print("This is level 1!")
end

return GAME_OBJECT_DEFS