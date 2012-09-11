display.setStatusBar( display.HiddenStatusBar )

-- Libraries
local director = require("Lib_Director")
require("Lib_MiddleClass")
require("Lib_XmlParser")

-- Classes
require("Data_UrlLoader")
require("Rss_SyndicationFeed")
require("Rss_SyndicationItem")

local mainGroup

local function main()
	mainGroup = display.newGroup()
	mainGroup:insert(director.directorView)
	director:changeScene("View_News")
	return true
end

main()