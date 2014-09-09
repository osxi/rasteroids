-- initialization stuff
function love.load()
   background = love.graphics.newImage("assets/background.png")
end

-- main
function love.draw()
    for i = 0, love.graphics.getWidth() / background:getWidth() do
        for j = 0, love.graphics.getHeight() / background:getHeight() do
            love.graphics.draw(background, i * background:getWidth(), j * background:getHeight())
        end
    end
end
