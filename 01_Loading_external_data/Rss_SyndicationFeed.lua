SyndicationFeed = class("SyndicationFeed")

SyndicationFeed.items = nil
SyndicationFeed.title = nil

function SyndicationFeed:initialize(title)
	SyndicationFeed.title = title
	SyndicationFeed.items = {}
end

function SyndicationFeed:addItem(item)
	table.insert(SyndicationFeed.items, item)
end

function SyndicationFeed:parseFeed(xml)
	local parsed = XmlParser:ParseXmlText(xml)
	local channel = XmlParser:XmlNodes(parsed, "channel")
	local syndicationFeed = SyndicationFeed:new("NRK")
	
	for i, xmlNode in ipairs(channel) do
		if xmlNode.Name == "item" then
			local item = SyndicationItem:new(xmlNode)
			SyndicationFeed:addItem(item)
		end
	end
end

function SyndicationFeed:getItems()
	return SyndicationFeed.items
end

function SyndicationFeed:getItem(i)
	return SyndicationFeed.items[i]
end