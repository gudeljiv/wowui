whoa = {}
cfg = {}

function whoaSetDefaults()
	if (cfg.smallAuraSize == nil) then
		cfg.smallAuraSize = 18
	end
	if (cfg.largeAuraSize == nil) then
		cfg.largeAuraSize = 22
	end
	if (cfg.classColor == nil) then
		cfg.classColor = true
	end
	if (cfg.reactionColor == nil) then
		cfg.reactionColor = true
	end
	if (cfg.BlizzardReactionColor == nil) then
		cfg.BlizzardReactionColor = false
	end
	if (cfg.noClickFrame == nil) then
		cfg.noClickFrame = false
	end
	if (cfg.blueShaman == nil) then
		cfg.blueShaman = true
	end -- blueShamans
	if (cfg.usePartyFrames == nil) then
		cfg.usePartyFrames = false
	end
	if (cfg.styleFont == nil) then
		cfg.styleFont = true
	end
	if (cfg.bigAuras == nil) then
		cfg.bigAuras = true
	end
	if (cfg.useBossFrames == nil) then
		cfg.useBossFrames = false
	end
	if (cfg.whoaTexture == nil) then
		cfg.whoaTexture = true
	end
	if (cfg.darkFrames == nil) then
		cfg.darkFrames = true
	end
end
whoaSetDefaults()

-- CreateFont --
function whoa:CreateFont(frame, name, text, x, y, font, size)
	if size == nil then
		size = 15
	end
	if font == nil then
		font = STANDARD_TEXT_FONT
	end

	local fontString = frame:CreateFontString(name)
	fontString:SetPoint("TOPLEFT", x, y)
	fontString:SetFont(font, size, "")
	fontString:SetText(text)
	return (fontString)
end

--	Checkbutton factory.
local uniquealyzer = 0
function createCheckbutton(parent, x_loc, y_loc, displayname)
	uniquealyzer = uniquealyzer + 1
	local checkbutton =
		CreateFrame("CheckButton", "whoaCheckButton" .. uniquealyzer, parent, "ChatConfigCheckButtonTemplate")
	checkbutton:SetPoint("TOPLEFT", x_loc, y_loc)
	getglobal(checkbutton:GetName() .. "Text"):SetText(displayname)
	return checkbutton
end

--	UI panel.
whoaUI = {}
whoaUI.panel = CreateFrame("Frame", "whoaUI", UIParent)
whoaUI.panel.name = "whoa ThickFrames"
InterfaceOptions_AddCategory(whoaUI.panel)

local title = whoa:CreateFont(whoaUI.panel, "title", "whoa ThickFrames v1.3.9", 15, -18, font, 15)
title:SetFontObject(GameFontNormal)
title:SetPoint("LEFT", whoaUI.panel, "TOPLEFT", 0, 0)

local disclaimer =
	whoa:CreateFont(
	whoaUI.panel,
	"disclaimer",
	"Most options require a /reload in order to correctly apply the changes.",
	25,
	-40,
	font,
	10
)
disclaimer:SetPoint("LEFT", whoaUI.panel, "TOPLEFT", 0, 0)

--	UI panel
function whoa:CreateUI(frame)
	local xOffset = -80

	local mainOptions = whoa:CreateFont(whoaUI.panel, "mainOptions", "Main frames options.", 25, xOffset, font, 13)
	mainOptions:SetPoint("LEFT", whoaUI.panel, "TOPLEFT", 0, 0)

	--	Players class colored HP.
	myCheckButton = createCheckbutton(whoaUI.panel, 40, xOffset - 30, " Players class colors.")
	myCheckButton.tooltip = "Displays class colored HP bars for player frame and targeted players frames."
	myCheckButton:SetScript(
		"OnClick",
		function()
			-- if whoaCheckButton2:GetChecked() then
			if (cfg.classColor == false) then
				cfg.classColor = true
			else
				cfg.classColor = false
				cfg.blueShamans = false
				whoaCheckButton2:SetChecked(false)
			end
		end
	)

	--	Blue shamans
	myCheckButton = createCheckbutton(whoaUI.panel, 280, xOffset - 30, " Blue shamans.")
	myCheckButton.tooltip = "Sets blue instead of pink for shaman class color."
	myCheckButton:SetScript(
		"OnClick",
		function()
			-- if whoaCheckButton2:GetChecked() then
			if (cfg.blueShamans == false) then
				cfg.blueShamans = true
				cfg.classColor = true
				whoaCheckButton1:SetChecked(true)
			else
				cfg.blueShamans = false
			end
		end
	)

	--	Unit reaction color HP.
	myCheckButton = createCheckbutton(whoaUI.panel, 40, xOffset - 60, " Target reaction colors.")
	myCheckButton.tooltip = "Displays reaction colors on non-player enemies HP bars."
	myCheckButton:SetScript(
		"OnClick",
		function(self)
			if (cfg.reactionColor == true) then
				cfg.reactionColor = false
				cfg.BlizzardReactionColor = false
				whoaCheckButton4:SetChecked(false)
			elseif (cfg.reactionColor == false) then
				cfg.reactionColor = true
			end
		end
	)

	--	Unit bright reaction color HP.
	myCheckButton = createCheckbutton(whoaUI.panel, 280, xOffset - 60, " Bright reaction colors.")
	myCheckButton.tooltip = "Displays bright reaction colors on non-player enemies HP bars."
	myCheckButton:SetScript(
		"OnClick",
		function(self)
			if (cfg.BlizzardReactionColor == true) then
				cfg.BlizzardReactionColor = false
			elseif (cfg.BlizzardReactionColor == false) then
				cfg.BlizzardReactionColor = true
				cfg.reactionColor = true
				whoaCheckButton3:SetChecked(true)
			end
		end
	)

	--	Enlarge auras.
	myCheckButton = createCheckbutton(whoaUI.panel, 40, xOffset - 90, " Enlarge auras.")
	myCheckButton.tooltip = "Displays bigger debuffs on enemy frames and buffs on allied frames to 4 in a row."
	myCheckButton:SetScript(
		"OnClick",
		function(self)
			if (cfg.bigAuras == false) then
				cfg.bigAuras = true
			else
				cfg.bigAuras = false
			end
		end
	)

	local styleOptions = whoa:CreateFont(whoaUI.panel, "styleOptions", "Styling options.", 25, xOffset - 140, font, 13)
	styleOptions:SetPoint("LEFT", whoaUI.panel, "TOPLEFT", 0, 0)

	--	Dark Frames
	myCheckButton = createCheckbutton(whoaUI.panel, 40, xOffset - 170, " Enable dark frames.")
	-- myCheckButton:SetEnabled(false);
	myCheckButton.tooltip = "Enables dark textures frames for dark themed ui."
	myCheckButton:SetScript(
		"OnClick",
		function(self)
			if (cfg.darkFrames == true) then
				cfg.darkFrames = false
			else
				cfg.darkFrames = true
			end
		end
	)

	--	Blizzard status text.
	myCheckButton = createCheckbutton(whoaUI.panel, 40, xOffset - 200, " Use Blizzard default status bar text.")
	-- myCheckButton:SetEnabled(false);
	myCheckButton.tooltip = "Displays Blizzard´s default font style for player and target frames status text."
	myCheckButton:SetScript(
		"OnClick",
		function(self)
			if (cfg.styleFont == true) then
				cfg.styleFont = false
			else
				cfg.styleFont = true
			end
		end
	)

	-- whoa custom statusbar texture.
	myCheckButton = createCheckbutton(whoaUI.panel, 40, xOffset - 230, " Use Blizzard´s default status bar texture.")
	myCheckButton.tooltip = "Use Blizzard´s default health and mana bar texture."
	myCheckButton:SetScript(
		"OnClick",
		function(self)
			-- if whoaCheckButton6:GetChecked() then
			if (cfg.whoaTexture == false) then
				cfg.whoaTexture = true
			else
				cfg.whoaTexture = false
			end
		end
	)

	local otherOptions = whoa:CreateFont(whoaUI.panel, "otherOptions", "Other extra options.", 25, xOffset - 280, font, 13)
	otherOptions:SetPoint("LEFT", whoaUI.panel, "TOPLEFT", 0, 0)

	--	Unclikeable frames
	myCheckButton =
		createCheckbutton(whoaUI.panel, 40, xOffset - 310, "Disable mouse clicks over player and target frames.")
	-- myCheckButton:SetEnabled(false);
	myCheckButton.tooltip = "Disable mouse clicks over player and target frames."
	myCheckButton:SetScript(
		"OnClick",
		function(self)
			if (cfg.noClickFrame == false) then
				cfg.noClickFrame = true
			else
				cfg.noClickFrame = false
			end
		end
	)

	--	Positioning
	-- local positionOptions = whoa:CreateFont(whoaUI.panel, "mainOptions", "Positioning options.", 25, xOffset-350, font, 13)
	-- mainOptions:SetPoint("LEFT",whoaUI.panel,"TOPLEFT",0,0)

	local centerBttnInfo =
		whoa:CreateFont(whoaUI.panel, "centerBttnInfo", "Center player and target frames middle screen.", 50, -500, font, 12)
	mainOptions:SetPoint("LEFT", whoaUI.panel, "TOPLEFT", 0, 0)

	local centerBttn = CreateFrame("Button", "centerButton", whoaUI.panel, "UIPanelButtonTemplate")
	centerBttn:SetSize(110, 25)
	centerBttn:SetText("Center frames")
	centerBttn:SetPoint("BOTTOMLEFT", 70, 20)
	centerBttn:SetScript(
		"OnClick",
		function()
			local x, y = -20, -150
			for i, f in pairs({PlayerFrame, TargetFrame}) do
				f:ClearAllPoints()
				f:SetPoint(i == 1 and "RIGHT" or "LEFT", UIParent, "CENTER", i == 1 and x or -x, y)
				f:SetUserPlaced(true)
			end
		end
	)

	local resetBttn = CreateFrame("Button", "resetButton", whoaUI.panel, "UIPanelButtonTemplate")
	resetBttn:SetSize(100, 25)
	resetBttn:SetText("Reset frames")
	resetBttn:SetPoint("BOTTOMLEFT", 210, 20)
	resetBttn:SetScript(
		"OnClick",
		function()
			PlayerFrame_ResetUserPlacedPosition()
			TargetFrame_ResetUserPlacedPosition()
		end
	)

	local reloadBttn = CreateFrame("Button", "reloadButton", whoaUI.panel, "UIPanelButtonTemplate")
	reloadBttn:SetSize(80, 22)
	reloadBttn:SetText("Reload UI")
	reloadBttn:SetPoint("BOTTOMRIGHT", -20, 20)
	reloadBttn:SetScript(
		"OnClick",
		function()
			ReloadUI()
		end
	)
end

local function defaults()
	if (cfg.classColor == true) then
		whoaCheckButton1:SetChecked(true)
	end
	if (cfg.blueShamans == true) then
		whoaCheckButton2:SetChecked(true)
	end
	if (cfg.reactionColor == true) then
		whoaCheckButton3:SetChecked(true)
	end
	if (cfg.BlizzardReactionColor == true) then
		whoaCheckButton4:SetChecked(true)
	end
	if (cfg.bigAuras == true) then
		whoaCheckButton5:SetChecked(true)
	end
	if (cfg.darkFrames == true) then
		whoaCheckButton6:SetChecked(true)
	end
	if (cfg.styleFont == false) then
		whoaCheckButton7:SetChecked(true)
	end
	if (cfg.whoaTexture == false) then
		whoaCheckButton8:SetChecked(true)
	end
	if (cfg.noClickFrame == true) then
		whoaCheckButton9:SetChecked(true)
	end
end

SlashCmdList.whoaUI = function()
	InterfaceOptionsFrame_OpenToCategory(whoaUI.panel)
	InterfaceOptionsFrame_OpenToCategory(whoaUI.panel)
end
SLASH_whoaUI1 = "/wtf"

whoa:CreateUI()

local function checkPlayerDead()
	local isDead = UnitIsDead("player")
	local isGhost = UnitIsGhost("player")

	if isDead then
		PlayerFrameDeadText:Show()
		PlayerFrameGhostText:Hide()
	elseif isGhost then
		PlayerFrameDeadText:Hide()
		PlayerFrameGhostText:Show()
	else
		PlayerFrameDeadText:Hide()
		PlayerFrameGhostText:Hide()
	end
end
local function checkTargetDead()
	local isDead = UnitIsDead("Target")
	local isGhost = UnitIsGhost("target")
	local spiritHealer = (UnitName("target") == "Spirit Healer")

	if isGhost then
		TargetFrameTextureFrameGhostText:Show()
	elseif isGhost and spiritHealer then
		TargetFrameTextureFrameGhostText:Hide()
	else
		TargetFrameTextureFrameGhostText:Hide()
	end
end

--	Events
function whoa:Init(event, addon, ...)
	if (event == "ADDON_LOADED" and addon == "whoaThickFrames_Classic") then
		blueShamans()
		defaults()
		if rmhAddon then
			print("|cff00ccff[whoa ThickFrames]:|cff00ff00 RealMobHealth detected.")
		end
		if mi2addonaddon then
			print("|cff00ccff[whoa ThickFrames:|cff00ff00 MobInfo2 detected.")
		end
		if lortiUIaddon then
			print(
				"|cff00ccff[whoa ThickFrames]:|cffffff00 Lorti-UI-Classic detected. |cffffffffMake sure to enable whoa´s dark frames with /wtf to match with LortiUI."
			)
		end
		print(
			"|cff00ccff[whoa ThickFrames] |cffffffffis now |cff00ff00loaded. |cffffffffUse |cffffff00'/wtf' |cffffffff open options."
		)

		--	luad unclickeable frames
		if (cfg.noClickFrame == true) then
			PlayerFrame:SetMouseClickEnabled(false)
			PetFrame:SetMouseClickEnabled(false)
			TargetFrame:SetMouseClickEnabled(false)
		end
	end
	if (event == "PLAYER_ENTERING_WORLD") then
		blueShamans()
		unitClassColors(healthbar, unit)
		npcReactionBrightColors()
	end
	if
		(event == "PLAYER_ENTERING_WORLD") or (event == "PLAYER_DEAD") or (event == "PLAYER_ALIVE") or
			(event == "PLAYER_UNGHOST")
	 then
	-- checkPlayerDead()
	end
	if (event == "PLAYER_TARGET_CHANGED") or (event == "PLAYER_ALIVE") or (event == "PLAYER_UNGHOST") then
	-- checkTargetDead()
	end
end

-- create addon frame
local whoaUI = CreateFrame("Frame", "whoaUI", UIParent)
whoaUI:SetScript("OnEvent", whoa.Init)
whoaUI:RegisterEvent("ADDON_LOADED")
whoaUI:RegisterEvent("PLAYER_ENTERING_WORLD")

whoaUI:RegisterEvent("PLAYER_DEAD")
whoaUI:RegisterEvent("PLAYER_ALIVE")
whoaUI:RegisterEvent("PLAYER_UNGHOST")
whoaUI:RegisterEvent("PLAYER_TARGET_CHANGED")
-- whoaUI:RegisterEvent("PLAYER_ENTERING_WORLD")
-- whoaUI:RegisterEvent("PLAYER_ENTERING_WORLD")

Minimap:EnableMouseWheel(true)
Minimap:SetScript(
	"OnMouseWheel",
	function(mp, input)
		local zoom = Minimap:GetZoom()
		if input > 0 and zoom < 5 then
			mp:SetZoom(zoom + 1)
		elseif input < 0 and zoom > 0 then
			mp:SetZoom(zoom - 1)
		end
	end
)
