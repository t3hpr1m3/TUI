local F, C = unpack(select(2, ...))

local TUIMinimap = CreateFrame("Frame", "TUIMinimap", UIParent)
TUIMinimap:RegisterEvent("ADDON_LOADED")
TUIMinimap:SetPoint("TOPRIGHT", F.Scale(-50), F.Scale(-50))
TUIMinimap:Size(200)
TUIMinimap:SetFrameStrata("BACKGROUND")
TUIMinimap:SetFrameLevel(1)
TUIMinimap:Panelize()

MinimapCluster:UnregisterAllEvents()
MinimapCluster.Show = F.noop
MinimapCluster:Hide()

Minimap:SetParent(TUIMinimap)
TUIMinimap:Fit(Minimap)
Minimap:SetMaskTexture(C["media"].blank)

local TUIZoneTextFrame = CreateFrame("Frame", "TUIZoneTextFrame", UIParent)
TUIZoneTextFrame:SetScript("OnMouseUp", function(self, event)
	MiniMapWorldMapButton:Click()
end)
TUIZoneTextFrame:SetPoint("BOTTOMRIGHT", TUIMinimap, "TOPRIGHT", 0, F.Scale(2))
TUIZoneTextFrame:Size(200, 20)
TUIZoneTextFrame:Panelize()
MinimapZoneText:SetParent(TUIZoneTextFrame)
MinimapZoneText:ClearAllPoints()
MinimapZoneText:SetPoint("CENTER")

-- Mail stuff
MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:SetPoint("TOPRIGHT", Minimap, F.Scale(3), F.Scale(3))
MiniMapMailIcon:SetTexture("Interface\\Addons\\TUI\\media\\textures\\mail")
MiniMapMailBorder:Hide()

-- Hide blizzard elements
MinimapBorder:Hide()
MinimapBorderTop:Hide()
MinimapBackdrop:Hide()
MinimapCompassTexture:Hide()
--MiniMapTracking:Hide()
--MiniMapWorldMapButton:Hide()
GameTimeFrame:Hide()
MiniMapTracking:Hide()
MinimapZoomIn:Hide()
MinimapZoomOut:Hide()
MinimapZoneTextButton:Hide()

TUIMinimap:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_TimeManager" then
		TimeManagerClockButton:UnregisterAllEvents()
		TimeManagerClockButton.Show = F.noop
		TimeManagerClockButton:Hide()
	end
end)

local function AddButton(button)
	button:SetParent(TUIMinimapButtonFrame)
	button:ClearAllPoints()
	button:SetPoint("TOPLEFT", F.EdgeOffset(), F.EdgeOffset() * -1)
end

local function FindButtons(frame)
	local i, child
	for i, child in ipairs({frame:GetChildren()}) do
		
	end
end

--AddButton(MiniMapMailIcon)

print("minimap loaded")
