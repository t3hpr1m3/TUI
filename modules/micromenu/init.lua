local F, C = unpack(select(2, ...))

--
-- Create the micro menu
--
local function CreateMicroMenuDropDown(frame)
	frame:Skin()
	local options = {
		{text = CHARACTER_BUTTON,
		func = function() ToggleCharacter("PaperDollFrame") end,
		notCheckable = 1},
		{text = SPELLBOOK_ABILITIES_BUTTON,
		func = function() ToggleFrame(SpellBookFrame) end,
		notCheckable = 1}
	}

	for i = 1, 2 do
		UIDropDownMenu_AddButton(options[i])
	end

	local taint = CreateFrame("Frame")
	taint:RegisterEvent("PLAYER_ENTERING_WORLD")
	taint:SetScript("OnEvent", function(self)
		ToggleFrame(SpellBookFrame)
		ToggleFrame(SpellBookFrame)
	end)
end

local MicroMenu = CreateFrame("Frame", "TUIMicroMenu", UIParent, "UIDropDownMenuTemplate")
UIDropDownMenu_Initialize(MicroMenu, CreateMicroMenuDropDown, "MENU")
UIDropDownMenu_SetAnchor(MicroMenu, 0, F.Scale(-2), "TOPRIGHT", "TUIInfoRight", "BOTTOMRIGHT")
hooksecurefunc("ToggleDropDownMenu", function(level, ...)
	if not level then
		level = 1
	end

	local menu1 = _G["DropDownList"..level.."Backdrop"]
	local menu2 = _G["DropDownList"..level.."MenuBackdrop"]
	if menu1 then menu1:Skin() end
	if menu2 then menu2:Skin() end
end)

--
-- Create the menu button
--
local Stat = CreateFrame("Frame")
Stat:EnableMouse(true)
Stat:SetFrameStrata("BACKGROUND")
Stat:SetFrameLevel(3)

local Text = TUIInfoRight:CreateFontString(nil, "OVERLAY")
Text:SetFont(C.media.font, 10)
Text:SetParent(TUIInfoRight)
Text:SetHeight(TUIInfoRight:GetHeight())
Text:SetPoint("LEFT", TUIInfoRight, 30, 0)
Text:SetPoint("TOP", TUIInfoRight)
Text:SetPoint("BOTTOM", TUIInfoRight)

local function OnEvent(self, event, ...)
	Text:SetText(MAINMENU_BUTTON)
	self:SetAllPoints(Text)
end

local function ShowMenu()
	ToggleDropDownMenu(1, nil, MicroMenu)
end

Stat:RegisterEvent("PLAYER_LOGIN")
Stat:SetScript("OnEvent", OnEvent)
Stat:SetScript("OnMouseUp", function() ShowMenu() end)
