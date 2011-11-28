local noop = function() return end
TUI.noop = noop

scale = 1
if GetCVar("useUiScale") == "1" then
	scale = GetCVar("uiScale")	
end
local mult = (768 / string.match(GetCVar("gxResolution"), "%d+x(%d+)")) / scale

TUI.mult = mult

local Scale = function(x)
	scaled = TUI.mult * math.floor(x + .5)
	return scaled
end
TUI.Scale = Scale

local function Size(frame, w, h)
	frame:SetSize(Scale(w), Scale(h or w))
end
TUI.Size = Size

local function Panelize(frame)
	frame:Skin()
	frame:SetScript("OnEnter", function(self, event)
		self:SetBackdropBorderColor(unpack(TUI:GetSkin()["backdropBorderColorHighlight"]))
	end)
	frame:SetScript("OnLeave", function(self, event)
		self:SetBackdropBorderColor(unpack(TUI:GetSkin()["backdropBorderColor"]))
	end)
end

function TUI:GetSkin()
	local skin = "default"
	return self["CONSTANTS"]["skins"][skin]
end

function TUI:EdgeOffset()
	local skin = self:GetSkin()
	return TUI.Scale(skin["backdrop"].edgeSize + 1 - skin["backdrop"].insets.top)
end

local function Skin(frame)
	local skin = TUI:GetSkin()
	local frameType = frame:GetObjectType()
	if frameType == ("Frame") then
		frame:SetBackdrop(skin["backdrop"])
		frame:SetBackdropColor(unpack(skin["backdropColor"]))
		frame:SetBackdropBorderColor(unpack(skin["backdropBorderColor"]))
	elseif frameType == ("CheckButton") then
	end
end

TUI.Skin = Skin

local function Fit(parent, obj)
	local width = parent:GetWidth()
	local height = parent:GetHeight()
	obj:ClearAllPoints()
	obj:SetPoint("TOPLEFT", TUI:EdgeOffset(), TUI:EdgeOffset() * -1)
	obj:SetSize(width - (TUI:EdgeOffset() * 2), height - (TUI:EdgeOffset() * 2))
end

local obj = CreateFrame("Frame")
local mt = getmetatable(obj).__index
mt.Size = Size
mt.Skin = Skin
mt.Fit = Fit
mt.Panelize = Panelize
