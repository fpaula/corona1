local json = require "json"
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local label_title, label_address

local function onSceneTouch( self, event )
print 'entrou aqui'
  if event.phase == "began" then
    return true
  end
end

function scene:createScene( event )
  local screenGroup = self.view
  establishment_details(event.params.id)
  label_title = display.newText( "", 15, 25, (display.contentWidth - 30), 40, "Helvetica", 22 )
  label_address = display.newText( "", 15, 60, (display.contentWidth - 30), 400, "Helvetica", 18 )
  screenGroup:insert( label_title )
  screenGroup:insert( label_address )
end

function scene:enterScene( event )
end

function scene:exitScene( event )
end

function scene:destroyScene( event )
end

networkListener = function(event)
  if (event.isError) then
    print("Network error!")
  else
    local establishment = json.decode(event.response)
    label_title.text = establishment.nome
    label_address.text = establishment.endereco.logradouro
    label_address.text = label_address.text .. ", " .. establishment.endereco.numero
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