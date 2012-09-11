local json = require "json"
local widget = require("widget")
local storyboard = require "storyboard"

local widgetGroup = display.newGroup()
local rowTitles = {}
local list = widget.newTableView{
  width = 320, 
  height = 448,
  bottomPadding = 8,
  maskFile = "mask-320x448.png"
}

local button = display.newText("Buscar", (display.contentWidth - 65), (display.contentHeight - 30), nil, 15)
local textfield = native.newTextField(1, (display.contentHeight - 30), 240, 25 )

widgetGroup:insert(list)

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
  print( "You touched row #" .. event.id )
  return true
end

function button:tap( event )
  search_establishments()
end

button:addEventListener( "tap", button )

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

search_establishments = function()
  local url = "http://stage.estabelecimentos.api.abril.com.br/estabelecimentos/busca?order=nome&nome=" .. textfield.text
  network.request( url, "GET", networkListener )
end
