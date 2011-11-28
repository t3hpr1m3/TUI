local skin = TUI:GetSkin()
local TUIBar1 = CreateFrame("Frame", "TUIBar1", UIParent, "SecureHandlerStateTemplate")
TUIBar1:SetPoint("BOTTOM", 0, TUI.Scale(26))
TUIBar1:SetWidth((skin.buttonSize * 18) + (skin.buttonSpacing * 17))
TUIBar1:SetHeight((skin.buttonSize * 2) + (skin.buttonSpacing * 3))
--TUIBar1:SetHeight(TUI.Scale(80))
TUIBar1:SetFrameStrata("BACKGROUND")
TUIBar1:SetFrameLevel(1)
TUIBar1:Skin()

TUIBar1:RegisterEvent("PLAYER_LOGIN")
TUIBar1:RegisterEvent("PLAYER_ENTERING_WORLD")

TUIBar1:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_LOGIN" then
		-- Hijack buttons
		local button
		for i = 1, NUM_ACTIONBAR_BUTTONS do
			button = _G["ActionButton"..i]
			self:SetFrameRef("ActionButton"..i, button)
		end

		self:Execute([[
			buttons = table.new()
			for i = 1, 12 do
				table.insert(buttons, self:GetFrameRef("ActionButton"..i))
			end
		]])

		self:SetAttribute("_onstate-page", [[
			for i, button in ipairs(buttons) do
				button:SetAttribute("actionpage", tonumber(newstate))
			end
		]])

		--RegisterStateDriver(self, "page", GetBar())
	elseif event == "PLAYER_ENTERING_WORLD" then
		local skin = TUI:GetSkin()
		local button
		for i = 1, 12 do
			button = _G["ActionButton"..i]
			button:SetSize(skin.buttonSize, skin.buttonSize)
			button:ClearAllPoints()
			button:SetParent(TUIBar1)
			button:SetFrameStrata("BACKGROUND")
			button:SetFrameLevel(15)
			if i == 1 then
				button:SetPoint("TOPLEFT", skin.buttonSpacing, skin.buttonSpacing * -1)
			else
				local previous = _G["ActionButton"..i-1]
				button:SetPoint("LEFT", previous, "RIGHT", skin.buttonSpacing, 0)
			end
		end
	end
end)
