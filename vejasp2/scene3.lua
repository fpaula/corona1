local json = require "json"
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
  establishment_details(event.params.id)
  label1 = display.newText( "", 25, 25, 175, 400, "Helvetica", 18 )
  screenGroup:insert( label1 )
end

function scene:enterScene( event )
  storyboard.purgeScene( "scene2" )
end

function scene:exitScene( event )
end

function scene:destroyScene( event )
end

establishment_details = function(id)
end

networkListener = function(event)
  if (event.isError) then
    print("Network error!")
  else
    local establishment = json.decode(event.response)
    label1.text = establishment.endereco.logradouro
    label1.text = label1.text .. ", " .. establishment.endereco.numero
  end
end

establishment_details = function(id)
  network.request( id, "GET", networkListener )
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene