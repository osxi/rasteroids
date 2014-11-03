-- initialization stuff
function love.load()
  -- Specify background image
  background = love.graphics.newImage('assets/background.png')

  -- Set font
  love.graphics.setNewFont('assets/Inconsolata for Powerline.otf', 28)

  -- Initialize score
  score = 0

  -- Set initial player character origin (center of screen)
  origin = { love.graphics.getWidth() / 2, love.graphics.getHeight() / 2 }

  -- Initial player character polygon
  pc_vertices = { origin[1] + 25, origin[2] + 25, origin[1], origin[2] - 25,
               origin[1] - 25, origin[2] + 25 }
end

-- update
function love.update(dt)
  -- User input
    if love.keyboard.isDown('w') then
      origin[2] = origin[2] - 1
    end
    if love.keyboard.isDown('s') then
      origin[2] = origin[2] + 1
    end

  -- Update player character polygon
  pc_vertices = { origin[1] + 25, origin[2] + 25, origin[1], origin[2] - 25,
                  origin[1] - 25, origin[2] + 25 }
end

-- main
function love.draw()
  for i = 0, love.graphics.getWidth() / background:getWidth() do
    for j = 0, love.graphics.getHeight() / background:getHeight() do
      love.graphics.draw(background, i * background:getWidth(),
                         j * background:getHeight())
    end
  end

  -- Draw score
  love.graphics.print('Score: ' .. score, 5, 0)

  -- Draw player character
  love.graphics.polygon('line', pc_vertices)
end
