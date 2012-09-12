local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local label1

local function onSceneTouch( self, event )
print 'entrou aqui'
  if event.phase == "began" then
    return true
  end
end

function scene:createScene( event )
  local screenGroup = self.view

  label1 = display.newText( "Teste", (display.contentWidth - 80), 30, native.systemFontBold, 15 )
  screenGroup:insert( label1 )
end

function scene:enterScene( event )
  storyboard.purgeScene( "scene2" )
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