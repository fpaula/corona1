module(..., package.seeall)

function new()
	local g = display.newGroup()
	
	local callback = function(rss)
		local syndication = SyndicationFeed:new("NRK Feed")
		syndication:parseFeed(rss)

		local items = syndication:getItems()
		for i=1, #items do
			local item = items[i]
			local itemGroup = display.newGroup()
			local title = display.newText(item.title, 10, 10, "Helvetica", 16)
			itemGroup:insert(title)
			itemGroup.y = 10 + (40 * (i-1))
			g:insert(itemGroup)
		end
	end
	
	UrlLoader:new("http://www.nrk.no/nyheter/siste.rss", callback)
	
	return g
end