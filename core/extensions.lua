local noop = function() return end
TUI.noop = noop

scale = 1
if GetCVar("useUiScale") == "1" then
	scale = GetCVar("uiScale")	
end
scale = .71
local mult = (768 / string.match(GetCVar("gxResolution"), "%d+x(%d+)")) / scale
TUI.mult = mult

local Scale = function(x)
	return mult * math.floor(x/mult + .5)
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
TUI.Panelize = Panelize

local skin = {
	["name"] = "none"
}
function TUI:GetSkin()
	local skin_name = "default"
	local raw_skin = self["CONSTANTS"]["skins"][skin_name]
	if skin["name"] ~= skin_name then
		print("converting skin")
		skin["name"] = skin_name
		skin["backdrop"] = {
			bgFile = raw_skin["backdrop"].bgFile,
			edgeFile = raw_skin["backdrop"].edgeFile,
			tileSize = TUI.Scale(raw_skin["backdrop"].tileSize),
			edgeSize = TUI.Scale(raw_skin["backdrop"].edgeSize),
			insets = {
				left = TUI.Scale(raw_skin["backdrop"].insets.left),
				right = TUI.Scale(raw_skin["backdrop"].insets.right),
				top = TUI.Scale(raw_skin["backdrop"].insets.top),
				bottom = TUI.Scale(raw_skin["backdrop"].insets.bottom)
			}
		}
		skin["backdropColor"] = raw_skin["backdropColor"]
		skin["backdropBorderColor"] = raw_skin["backdropBorderColor"]
		skin["backdropBorderColorHighlight"] = raw_skin["backdropBorderColorHighlight"]
		skin["buttonSize"] = TUI.Scale(raw_skin["buttonSize"])
		skin["buttonSpacing"] = TUI.Scale(raw_skin["buttonSpacing"])
	end
	return skin
end

function TUI:EdgeOffset()
	local s = self:GetSkin()
	return s["backdrop"].edgeSize + 1 - s["backdrop"].insets.top
end

local backdrop = {}
local function Skin(frame)
	local s = TUI:GetSkin()
	local frameType = frame:GetObjectType()
	if frameType == ("Frame") then
		frame:SetBackdrop(s["backdrop"])
		frame:SetBackdropColor(unpack(s["backdropColor"]))
		frame:SetBackdropBorderColor(unpack(s["backdropBorderColor"]))
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
TUI.Fit = Fit

local obj = CreateFrame("Frame")
local mt = getmetatable(obj).__index
mt.Size = Size
mt.Skin = Skin
mt.Fit = Fit
mt.Panelize = Panelize
