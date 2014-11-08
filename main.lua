-- Initialization stuff
function love.load()
  -- Specify background image
  background = love.graphics.newImage('assets/background.png')

  -- Set font
  love.graphics.setNewFont(28)

  -- Initialize score
  score = 0

  -- Set initial player character origin (center of screen)
  origin = { x = love.graphics.getWidth() / 2, y = love.graphics.getHeight() / 2 }

  -- Set initial player character heading (rotational orientation)
  heading = 0

  -- Set initial player inertial heading (simulate resistance to heading change)
  inertial_heading = 0

  -- Set initial player character heading sensitivity
  heading_sensitivity = 1.5

  -- Set initial player character movement speed (forward/backward)
  movement_speed = 0

  -- Max movement_speed
  movement_max = 8

  -- Initial player character polygon
  pc_vertices = { origin.x + 25, origin.y + 25, origin.x, origin.x - 25,
               origin.x - 25, origin.y + 25 }
end

-- Update
function love.update(dt)
  -- User input
  if love.keyboard.isDown('w') then     -- Forward
    if movement_speed < movement_max then
      movement_speed = movement_speed + 0.25
    end
  end
  if love.keyboard.isDown('a') then     -- Rotate clockwise (left)
    if heading <= 0 then
      heading = 2 * math.pi
    else
      heading = heading - math.pi * dt * heading_sensitivity
    end
  elseif love.keyboard.isDown('d') then -- Rotate counter-clockwise (right)
    if heading <= 2 * math.pi then
      heading = heading + math.pi * dt * heading_sensitivity
    else
      heading = 0
    end
  end

  -- Update inertial heading
  if inertial_heading ~= heading then
    if inertial_heading > heading then
      inertial_heading = inertial_heading - .05
    else
      inertial_heading = inertial_heading + .05
    end
  end

  -- Decelerate naturally
  if movement_speed > 0 then
    -- Inertial movement
    origin.x = origin.x + math.sin(inertial_heading) * movement_speed
    origin.y = origin.y - math.cos(inertial_heading) * movement_speed

    -- Decelerate over dt
    movement_speed = movement_speed - 0.1
  end

  -- Edge of screen wrapping
  if origin.y < -25 then                              -- Top of window
    origin.y = love.graphics.getHeight()
  elseif origin.y > love.graphics.getHeight()+25 then -- Bottom of window
    origin.y = 0
  end
  if origin.x < -25 then                              -- Left side of window
    origin.x = love.graphics.getWidth()
  elseif origin.x > love.graphics.getWidth()+25 then  -- Right side of window
    origin.x = 0
  end

  -- Updated player character polygon
  pc_vertices = {
                  math.cos(heading) * (origin.x+25 - origin.x) - math.sin(heading) * (origin.y+25 - origin.y) + origin.x,
                  math.sin(heading) * (origin.x+25 - origin.x) + math.cos(heading) * (origin.y+25 - origin.y) + origin.y,
                  math.cos(heading) * (origin.x - origin.x) - math.sin(heading) * (origin.y-25 - origin.y) + origin.x,
                  math.sin(heading) * (origin.x - origin.x) + math.cos(heading) * (origin.y-25 - origin.y) + origin.y,
                  math.cos(heading) * (origin.x-25 - origin.x) - math.sin(heading) * (origin.y+25 - origin.y) + origin.x,
                  math.sin(heading) * (origin.x-25 - origin.x) + math.cos(heading) * (origin.y+25 - origin.y) + origin.y,
                }
end

-- Main
function love.draw()
  for i = 0, love.graphics.getWidth() / background:getWidth() do
    for j = 0, love.graphics.getHeight() / background:getHeight() do
      love.graphics.draw(background, i * background:getWidth(),
                         j * background:getHeight())
    end
  end

  -- Draw score
  love.graphics.print('Score: ' .. score, 5, 0)

  -- Display heading
  love.graphics.print('Heading: ' .. heading, 5, 30)

  -- Display inertial heading
  love.graphics.print('Inertial Heading: ' .. inertial_heading, 5, 60)

  -- Draw player character
  love.graphics.polygon('line', pc_vertices)
end
