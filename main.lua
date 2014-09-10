-- initialization stuff
function love.load()
  -- Specify background image
  background = love.graphics.newImage("assets/background.png")

  -- Set font
  love.graphics.setNewFont('assets/Inconsolata for Powerline.otf', 28)

  -- Initialize score
  score = 0
end

-- main
function love.draw()
  for i = 0, love.graphics.getWidth() / background:getWidth() do
    for j = 0, love.graphics.getHeight() / background:getHeight() do
      love.graphics.draw(background, i * background:getWidth(), j * background:getHeight())
    end
  end

  love.graphics.print('Score: ' .. score, 5, 0)
end
