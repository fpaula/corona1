local storyboard = require( "storyboard" )
local json = require "json"
local widget = require("widget")

local scene = storyboard.newScene()
local widgetGroup
local rowTitles = {}
local text2
local list

local function onSceneTouch( self, event )
  if event.phase == "began" then
    return true
  end
end

function scene:createScene( event )
  widgetGroup = self.view
  list = widget.newTableView{
    width = 320, 
    height = 448,
    bottomPadding = 8,
    maskFile = "images/mask-320x448.png"
  }
  widgetGroup:insert(list)
end

function scene:enterScene( event )
  storyboard.purgeScene( "scenes.search" )
  search_establishments(event.params.search_term)
end

function scene:exitScene( event )
end

function scene:destroyScene( event )
end

local function onRowRender( event )
  local row = event.row
  local rowGroup = event.view
  local label = rowTitles[ row.index ]
  local color = 0
  row.itemName = label
  row.textObj = display.newRetinaText( rowGroup, label, 0, 0, native.systemFontBold, 14 )
  row.textObj:setTextColor( color )
  row.textObj:setReferencePoint( display.CenterLeftReferencePoint )
  row.textObj.x, row.textObj.y = 20, rowGroup.contentHeight * 0.5
  rowGroup:insert( row.textObj )
end

local function onRowTouch( event )
  local row = event.target
  local rowGroup = event.view
  row.reRender = true
  options = { params = {id = event.id} }
  storyboard.gotoScene( "scenes.establishment_details", options )
  return true
end

networkListener = function(event)
  if (event.isError) then
    print("Network error!")
  else
    local establishments = json.decode(event.response)
    render_establishment_list(establishments.resultado)
  end
end

render_establishment_list = function(establishments)
  list:deleteAllRows()
  rowTitles = {}
  for i = 1, #establishments do
    rowTitles[ #rowTitles + 1 ] = establishments[i].nome
    list:insertRow{
      height = 72,
      onRender = onRowRender,
      isCategory = false,
      listener = onRowTouch,
      id = establishments[i].id
    }
  end
end

search_establishments = function(search_term)
  local url = "http://stage.estabelecimentos.api.abril.com.br/estabelecimentos/busca?order=nome&nome=" .. search_term
  network.request( url, "GET", networkListener )
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene