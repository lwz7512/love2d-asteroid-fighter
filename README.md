Asteroid Fighter
-----------------------------

By : lwz7512 @2020/12/01



## Game Features

- Aircraft selection on start state
- Weapon pickup in 2nd level
- Boss with health bar and basic AI
- Pass two levels to win


## Game Structure Explaination

```
|-- fonts
|-- grapics
|-- lib
|-- src
      |-- levels
      |    -- level1.lua : game objects specification for level one
      |    -- level2.lua : game objects specification for level two
      |-- objects
      |    -- Asteriod.lua : inherited from game object
      |    -- GameObject.lua : base game object
      |    -- Reward.lua : drop off by broken asteriod inherited from game object
      |-- states
      |    |-- entity
      |    |   -- PlayerExplodeState.lua : explosion effect
      |    |   -- PlayerIdleState.lua : idle animation
      |    |   -- PlayerWalkingState.lua : moving animation
      |    |-- game
      |    |   -- EndState.lua : game over screen
      |    |   -- LevelUpState.lua : level up screen
      |    |   -- PlayState.lua : playing screen
      |    |   -- StartState.lua : welcome screen
      |    |   -- WonState.lua : gamen complete/win screen with animation
      |    -- BaseState.lua
      -- Animation.lua : animation texture renderer
      -- constant.lua
      -- Dependencies.lua : game assets & class loader
      -- Entity.lua : base of player
      -- GameLevel.lua : game object/enties management
      -- LevelMaker.lua : level loader
      -- Player.lua : based on entity
      -- StateMachine.lua : game engine state management
      -- Util.lua
-- main.lua
```

## Game Complexity and Solutions and Conventions

- for game state management, using state machine and different states/screen
- for game objects structure: mainly based on `GameObject`, player based on `Entity`
- for bullets and game objects(Asteriods/Reward) collision test, put into two different collections
- for level creation scaleability, using `LevelMaker` dynamiclly load level definition module
- for base asteriod AI function, using lazy follow algorithm
- for game objects creation/life cycle management, PlayState --> Player/(LevelMaker --> GameLevel)
- for game screen/state switching, just take place in state itself

## Tricky Part

Last but not the least, while smart Asteriods need health bar displaying, it needs to draw rectangle in its render() function, yet we still want its parent(GameObject) drawing meteor texture:

```
function Asteriod:render()
  GameObject:render(self)
  -- draw health bar
  -- ...two rectangles
end
```

But, our Asteriod did not call parent update function, so we need to have GameObject reference to Aasteriod:

```
function GameObject:render(ctx)

    -- TRICKY: ctx is for sub class use
    if ctx then self = ctx end

    -- draw texture ...
end
```