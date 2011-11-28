local F, C = unpack(select(2, ...))

local bar = TUIBar1
MultiBarBottomLeft:SetParent(bar)

for i=1, 12 do
	local Button = _G["MultiBarBottomLeftButton"..i]
	local skin = F.GetSkin()
	--TUI.Size(Button, skin.buttonSize)
	Button:ClearAllPoints()
	Button:SetFrameStrata("BACKGROUND")
	Button:SetFrameLevel(15)

	if i == 1 then
		Button:SetPoint("BOTTOMLEFT", bar, skin.buttonSpacing, skin.buttonSpacing)
	else
		local previous = _G["MultiBarBottomLeftButton"..i-1]
		Button:SetPoint("LEFT", previous, "RIGHT", skin.buttonSpacing, 0)
	end
end

print("bar2 loaded")
