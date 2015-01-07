local hud = {}

function hud.draw(options)
  -- Draw score
  love.graphics.print('Score: ' .. score, 5, 0)

  if options.debug then
    -- Display heading
    love.graphics.print('Heading: ' .. heading, 5, 30)

    -- Display inertial heading
    love.graphics.print('Inertial Heading: ' .. inertial_heading, 5, 60)

    -- Display pew ttl
    if pew then
      love.graphics.print('Pew TTL: ' .. pew.ttl, 5, 90)
    end

    -- Display PC/projectile collision message
    if collision then
      love.graphics.print('Collision', 515, 0)
    end
  end
end

return hud
