local F, C = unpack(select(2, ...))

F.noop = function() return end

local scale = 1
if GetCVar("useUiScale") == "1" then
	scale = GetCVar("uiScale")	
end
scale = .71
local mult = (768 / string.match(GetCVar("gxResolution"), "%d+x(%d+)")) / scale
C.mult = mult

local Scale = function(x)
	return C.mult * math.floor(x/C.mult + .5)
end
F.Scale = function(x) return Scale(x) end

local function Size(frame, w, h)
	frame:SetSize(Scale(w), Scale(h or w))
end
F.Size = function(frame, w, h) return Size(frame, w, h) end

local function Panelize(frame)
	frame:Skin()
	frame:SetScript("OnEnter", function(self, event)
		self:SetBackdropBorderColor(unpack(F.GetSkin()["backdropBorderColorHighlight"]))
	end)
	frame:SetScript("OnLeave", function(self, event)
		self:SetBackdropBorderColor(unpack(F.GetSkin()["backdropBorderColor"]))
	end)
end
F.Panelize = function(frame) return Panelize(frame) end

local skin = {
	["name"] = "none"
}
local function GetSkin()
	local skin_name = "default"
	local raw_skin = C["skins"][skin_name]
	if skin["name"] ~= skin_name then
		print("converting skin")
		skin["name"] = skin_name
		skin["backdrop"] = {
			bgFile = raw_skin["backdrop"].bgFile,
			edgeFile = raw_skin["backdrop"].edgeFile,
			tileSize = F.Scale(raw_skin["backdrop"].tileSize),
			edgeSize = F.Scale(raw_skin["backdrop"].edgeSize),
			insets = {
				left = F.Scale(raw_skin["backdrop"].insets.left),
				right = F.Scale(raw_skin["backdrop"].insets.right),
				top = F.Scale(raw_skin["backdrop"].insets.top),
				bottom = F.Scale(raw_skin["backdrop"].insets.bottom)
			}
		}
		skin["backdropColor"] = raw_skin["backdropColor"]
		skin["backdropBorderColor"] = raw_skin["backdropBorderColor"]
		skin["backdropBorderColorHighlight"] = raw_skin["backdropBorderColorHighlight"]
		skin["buttonSize"] = F.Scale(raw_skin["buttonSize"])
		skin["buttonSpacing"] = F.Scale(raw_skin["buttonSpacing"])
	end
	return skin
end
F.GetSkin = function() return GetSkin() end

local function EdgeOffset()
	local s = GetSkin()
	return s["backdrop"].edgeSize + 1 - s["backdrop"].insets.top
end
F.EdgeOffset = function() return EdgeOffset() end

local function Skin(frame)
	local s = GetSkin()
	local frameType = frame:GetObjectType()
	if frameType == ("Frame") then
		frame:SetBackdrop(s["backdrop"])
		frame:SetBackdropColor(unpack(s["backdropColor"]))
		frame:SetBackdropBorderColor(unpack(s["backdropBorderColor"]))
	elseif frameType == ("CheckButton") then
	end
end
F.Skin = function(frame) return Skin(frame) end

local function Fit(parent, obj)
	local width = parent:GetWidth()
	local height = parent:GetHeight()
	obj:ClearAllPoints()
	obj:SetPoint("TOPLEFT", EdgeOffset(), EdgeOffset() * -1)
	obj:SetSize(width - (EdgeOffset() * 2), height - (EdgeOffset() * 2))
end
F.Fit = function(parent, obj) return Fit(parent, obj) end

local obj = CreateFrame("Frame")
local mt = getmetatable(obj).__index
mt.Size = Size
mt.Skin = Skin
mt.Fit = Fit
mt.Panelize = Panelize
