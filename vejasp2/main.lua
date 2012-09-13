local storyboard = require "storyboard"
local widget = require "widget"

storyboard.gotoScene( "scenes.search" )

local onHomePress = function(event)
  storyboard.gotoScene( "scenes.search" )
end

local tabButtons = {
  { label="Home", onPress=onHomePress, up="images/icon1.png", down="images/icon1.png", width = 32, height = 32, selected=true }
}

local tabBar = widget.newTabBar{
  top = display.contentHeight - 50,
  buttons = tabButtons
}