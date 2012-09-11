local button_started_position_x = 15
local button_started_position_y = (display.contentHeight - 20)

local button = display.newImage( "award.png" )
button.x = button_started_position_x
button.y = button_started_position_y

function button:tap( event )
  x, y = 0
  if (button.x == button_started_position_x and button.y == button_started_position_y) then
    x = display.contentWidth - 15
    y = 35
  else
    x = button_started_position_x
    y = button_started_position_y
  end
  transition.to( button, { time=800, x=x, y=y } )
end

button:addEventListener( "tap", button )