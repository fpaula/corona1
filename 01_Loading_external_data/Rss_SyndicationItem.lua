SyndicationItem = class("SyndicationItem")

function SyndicationItem:initialize(node)
	self.title = XmlParser:XmlValue(node, "title")
	self.link = XmlParser:XmlValue(node, "link")
	self.description = XmlParser:XmlValue(node, "description")
	self.updatedDate = XmlParser:XmlValue(node, "a10:updated")
	
	local enclosure = XmlParser:XmlAttributes(node, "enclosure")
	if enclosure then self.enclosureUrl = enclosure.url end
end