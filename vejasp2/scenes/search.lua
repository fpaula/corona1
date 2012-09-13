local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require("widget")

local search_button, search_textfield, label_title

local function onSearchButtonTouch( self, event )
  if event.phase == "began" then
    search_term = search_textfield.text
    local options = {
      params = { search_term = search_textfield.text }
    }
    storyboard.gotoScene( "scenes.search_result", options  )
    return true
  end
end

function scene:createScene( event )
  local screenGroup = self.view
  label_title = display.newText( "Estabelecimentos", 15, 35, (display.contentWidth - 30), 40, "Helvetica", 22 )

  search_textfield = native.newTextField(15, 80, (display.contentWidth - 30), 25 )

  search_button = widget.newButton{
    left = 15,
    top = 115,
    label = "Buscar",
    cornerRadius = 3,
    onEvent = onSearchButtonTouch
  }
  search_button.touch = onSearchButtonTouch
  screenGroup:insert( search_button )
  screenGroup:insert( search_textfield )
  screenGroup:insert( label_title )
end

function scene:enterScene( event )
  search_button:addEventListener( "touch", search_button )
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