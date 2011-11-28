local F, C = unpack(select(2, ...))

local function style_button(self)
	local name = self:GetName()
	local Button = self
	local Border = _G[name.."Border"]
	local Flash = _G[name.."Flash"]
	local Icon = _G[name.."Icon"]
	local normal = _G[name.."NormalTexture"]
	local skin = F.GetSkin()
	Flash:SetTexture("")
	Button:SetNormalTexture("")
	Border:Hide()
	Border = F.noop

	if not _G[name.."Panel"] then
		if Button:GetHeight() ~= skin.buttonSize and not InCombatLockdown() then
			Button:SetSize(skin.buttonSize, skin.buttonSize)
		end

		local panel = CreateFrame("Frame", name.."Panel", Button)
		panel:SetPoint("CENTER", Button)
		panel:SetSize(skin.buttonSize, skin.buttonSize)
		panel:SetFrameStrata("BACKGROUND")
		panel:SetFrameStrata(Button:GetFrameStrata())
		panel:SetFrameLevel(Button:GetFrameLevel() - 1)
		panel:Skin()

		Icon:SetTexCoord(.08, .92, .08, .92)
		Icon:SetPoint("TOPLEFT", Button, 2, -2)
		Icon:SetPoint("BOTTOMRIGHT", Button, -2, 2)
		--Icon:Hide()
	end
	if normal then
		normal:ClearAllPoints()
		normal:SetPoint("TOPLEFT")
		normal:SetPoint("BOTTOMRIGHT")
	end
	--TUI.Skin(self)
end

for i = 1, 12 do
	--_G["ActionButton"..i]:StyleButton(true)
end

hooksecurefunc("ActionButton_Update", style_button)
