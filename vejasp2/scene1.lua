local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local button1, textfield1

local function onSceneTouch( self, event )
  if event.phase == "began" then
    search_term = textfield1.text
    local options = {
      params = { search_term = textfield1.text }
    }
    storyboard.gotoScene( "scene2", options  )
    return true
  end
end

function scene:createScene( event )
  local screenGroup = self.view

  textfield1 = native.newTextField(10, 30, 220, 25 )

  button1 = display.newText( "Buscar", (display.contentWidth - 80), 30, native.systemFontBold, 15 )
  button1.touch = onSceneTouch
  screenGroup:insert( button1 )
  screenGroup:insert( textfield1 )
end

function scene:enterScene( event )
  storyboard.purgeScene( "scene2" )
  button1:addEventListener( "touch", button1 )
end

function scene:exitScene( event )
end

function scene:destroyScene( event )
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene