
local function style_button(self)
	local name = self:GetName()
	print("styling: "..name)
	local Border = _G[name.."Border"]
	local Flash = _G[name.."Flash"]
	local Icon = _G[name.."Icon"]
	local skin = TUI:GetSkin()
	Flash:SetTexture("")
	self:SetNormalTexture("")
	Border:Hide()
	self:SetBackdropBorderColor(0, 0, 0, 0)
	TUI.Size(self, skin.buttonSize)

	if not _G[name.."Panel"] then
		if self:GetHeight() ~= skin.buttonSize and not InCombatLockdown() then
			TUI.Size(self, skin.buttonSize)
		end

		local panel = CreateFrame("Frame", name.."Panel", self)
		panel:SetPoint("CENTER", self)
		panel:Size(skin.buttonSize)
		panel:SetFrameStrata("BACKGROUND")
		panel:Skin()
		panel:SetFrameStrata(self:GetFrameStrata())
		panel:SetFrameLevel(self:GetFrameLevel() - 1)

		Icon:SetTexCoord(.08, .92, .08, .92)
		Icon:SetPoint("TOPLEFT", self, 3, -3)
		Icon:SetPoint("BOTTOMRIGHT", self, -3, 3)
	end
	--TUI.Skin(self)
end

for i = 1, 12 do
	--_G["ActionButton"..i]:StyleButton(true)
end

hooksecurefunc("ActionButton_Update", style_button)
