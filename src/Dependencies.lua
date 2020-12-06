--[[
    GD50
    Super Mario Bros. Remake

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    -- Dependencies --

    A file to organize all of the global dependencies for our project, as
    well as the assets for our game, rather than pollute our main.lua file.
]]

--
-- libraries
--
Class = require 'lib/class'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

--
-- our own code
--

-- utility
require 'src/constants'
require 'src/StateMachine'
require 'src/Util'

-- game states
require 'src/states/BaseState'
require 'src/states/game/PlayState'
require 'src/states/game/StartState'
require 'src/states/game/EndState'
require 'src/states/game/LevelUpState'
require 'src/states/game/WonState'

-- entity states
require 'src/states/entity/PlayerIdleState'
require 'src/states/entity/PlayerWalkingState'
require 'src/states/entity/PlayerExplodeState'

-- general
require 'src/Animation'
require 'src/Entity'
require 'src/GameLevel'
require 'src/LevelMaker'
require 'src/Player'

-- objects
require 'src/objects/GameObject'
require 'src/objects/Asteriod'
require 'src/objects/Reward'


gSounds = {
    ['fire'] = love.audio.newSource('sounds/fire.wav', 'static'),
    ['missile'] = love.audio.newSource('sounds/missile.wav', 'static'),
    ['explosion-1'] = love.audio.newSource('sounds/explosion1.wav', 'static'),
    ['explosion-2'] = love.audio.newSource('sounds/explosion2.wav', 'static'),
    ['powerup'] = love.audio.newSource('sounds/powerup.wav', 'static'),
    ['levelup'] = love.audio.newSource('sounds/levelup.wav', 'static'),
    ['hit-1'] = love.audio.newSource('sounds/hit1.wav', 'static'),
    ['hit-2'] = love.audio.newSource('sounds/hit2.wav', 'static'),
    ['start-music'] = love.audio.newSource('sounds/start-music.mp3', 'static'),
    ['battle-music'] = love.audio.newSource('sounds/battle-music.mp3', 'static'),
    ['select'] = love.audio.newSource('sounds/select.wav', 'static'),
    ['gameover'] = love.audio.newSource('sounds/gameover3.wav', 'static'),
    ['winning'] = love.audio.newSource('sounds/cant_stop_winning.mp3', 'static'),
}


gTextures = {
    ['player-ship-1'] = love.graphics.newImage('graphics/playerShip1_green.png'),
    ['player-ship-2'] = love.graphics.newImage('graphics/playerShip1_orange.png'),
    ['player-ship-4'] = love.graphics.newImage('graphics/playerShip3_orange.png'),

    ['laser-1'] = love.graphics.newImage('graphics/laserBlue01.png'),
    ['laser-2'] = love.graphics.newImage('graphics/laserRed01.png'),
    
    ['meteor-big-1'] = love.graphics.newImage('graphics/meteorGrey_big1.png'),
    ['meteor-big-2'] = love.graphics.newImage('graphics/meteorGrey_big2.png'),
    ['meteor-big-3'] = love.graphics.newImage('graphics/meteorGrey_big3.png'),
    ['meteor-big-4'] = love.graphics.newImage('graphics/meteorGrey_big4.png'),
    ['meteor-medium-1'] = love.graphics.newImage('graphics/meteorGrey_med1.png'),
    ['meteor-medium-2'] = love.graphics.newImage('graphics/meteorGrey_med2.png'),
    ['meteor-small-1'] = love.graphics.newImage('graphics/meteorGrey_small1.png'),
    ['meteor-small-2'] = love.graphics.newImage('graphics/meteorGrey_small2.png'),
    ['meteor-tiny-1'] = love.graphics.newImage('graphics/meteorGrey_tiny1.png'),
    ['meteor-tiny-2'] = love.graphics.newImage('graphics/meteorGrey_tiny2.png'),

    ['missile'] = love.graphics.newImage('graphics/missile00.png'),
    
    ['explosion-1'] = love.graphics.newImage('graphics/explosion1.png'),
    ['explosion-2'] = love.graphics.newImage('graphics/explosion2.png'),
    ['explosion-3'] = love.graphics.newImage('graphics/explosion3.png'),
    
    ['flames'] = love.graphics.newImage('graphics/flames.png'),
    ['flame-1'] = love.graphics.newImage('graphics/flame1.png'),
    ['flame-2'] = love.graphics.newImage('graphics/flame2.png'),
    ['flame-3'] = love.graphics.newImage('graphics/flame3.png'),
    
    ['ui-sheet'] = love.graphics.newImage('graphics/sheet_white1x.png'),
    ['fireworks'] = love.graphics.newImage('graphics/fireworks.png'),

    ['background'] = love.graphics.newImage('graphics/back_sm.png'),
}


gFrames = {
    ['ui-backward'] = GnerateQuadBackward(gTextures['ui-sheet']),
    ['ui-forward'] = GnerateQuadForward(gTextures['ui-sheet']),
    ['flames'] = GenerateQuads(gTextures['flames'], 32, 32),
    ['fireworks'] = GenerateQuads(gTextures['fireworks'], 119, 64),
}


gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
    ['title'] = love.graphics.newFont('fonts/ArcadeAlternate.ttf', 32)
}