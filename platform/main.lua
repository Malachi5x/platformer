function love.load()
  myWorld = love.physics.newWorld(0, 1000)

  sprites = {}
  sprites.coin_sheet = love.graphics.newImage('sprites/coin_sheet.png')
  sprites.player_jump = love.graphics.newImage('sprites/player_jump.png')
  sprites.player_stand = love.graphics.newImage('sprites/player_stand.png')

  require('player')

  platforms = {}

  spawnPlatform(50, 400, 300, 30)
end

function love.update(dt)
  myWorld:update(dt)
end

function love.draw()
  love.graphics.draw(sprites.player_stand, player.body:getX(), player.body:getY(), nil, nil, nil, sprites.player_stand:getWidth()/2, sprites.player_stand:getHeight()/2)

  for i,p in ipairs(platforms) do
    love.graphics.rectangle('fill', p.body:getX(), p.body:getY(), p.width, p.height)
  end
end

function love.keypressed(key, scancode, isrepeat)
  if key == 'w' then
    player.body:applyLinearImpulse(0, -3700)
  end
end

function spawnPlatform(x, y, width, height)
  local platform = {}
  platform.body = love.physics.newBody(myWorld, x, y, 'static')
  platform.shape = love.physics.newRectangleShape(width/2, height/2, width, height)
  platform.fixture = love.physics.newFixture(platform.body, platform.shape)
  platform.width = width
  platform.height = height

  table.insert(platforms, platform)
end
