local _, xVermin = ...

local cfg = {
	fontSize = 15,
	fontOutline = false,
	position = {
		'BOTTOMRIGHT',
		UIParent,
		'BOTTOMRIGHT',
		-27.35,
		27.35
	},
	disableFade = false, -- Can cause errors or a buggy tooltip!
	showOnMouseover = true,
	hideInCombat = false, -- Hide unit frame tooltips during combat
	reactionBorderColor = false,
	itemqualityBorderColor = true,
	abbrevRealmNames = false,
	hideRealmText = false, -- Hide the coalesced/interactive realm text
	showPlayerTitles = true,
	showUnitRole = false,
	showPVPIcons = false, -- Show pvp icons instead of just a prefix
	showMouseoverTarget = true,
	showItemLevel = false,
	showSpecializationIcon = false,
	healthbar = {
		showHealthValue = true,
		healthFormat = '$cur / $max', -- Possible: $cur, $max, $deficit, $perc, $smartperc, $smartcolorperc, $colorperc
		healthFullFormat = '$cur', -- if the tooltip unit has 100% hp
		fontSize = 13,
		font = 'Fonts\\ARIALN.ttf',
		showOutline = true,
		textPos = 'CENTER', -- Possible 'TOP' 'BOTTOM' 'CENTER'
		reactionColoring = false, -- Overrides customColor
		customColor = {
			apply = false,
			r = 0,
			g = 1,
			b = 1
		}
	},
	reaction = {
		[1] = {182 / 255, 34 / 255, 32 / 255},
		[2] = {182 / 255, 34 / 255, 32 / 255},
		[3] = {182 / 255, 92 / 255, 32 / 255},
		[4] = {220 / 225, 180 / 255, 52 / 255},
		[5] = {132 / 255, 181 / 255, 26 / 255},
		[6] = {132 / 255, 181 / 255, 26 / 255},
		[7] = {132 / 255, 181 / 255, 26 / 255},
		[8] = {132 / 255, 181 / 255, 26 / 255},
		['grey'] = {128 / 255, 128 / 255, 128 / 255}
	}
}

for _, tooltip in pairs(
	{
		GameTooltip,
		BattlePetTooltip,
		EmbeddedItemTooltip,
		ItemRefTooltip,
		ItemRefShoppingTooltip1,
		ItemRefShoppingTooltip2,
		ShoppingTooltip1,
		ShoppingTooltip2,
		DropDownList1MenuBackdrop,
		DropDownList2MenuBackdrop,
		ConsolidatedBuffsTooltip,
		AutoCompleteBox,
		ChatMenu,
		EmoteMenu,
		LanguageMenu,
		VoiceMacroMenu,
		FriendsTooltip,
		FloatingGarrisonFollowerTooltip,
		FloatingBattlePetTooltip,
		FloatingPetBattleAbilityTooltip,
		ReputationParagonTooltip,
		LibDBIconTooltip,
		SmallTextTooltip,
		LibItemUpdateInfoTooltip,
		NamePlateTooltip,
		AtlasLootTooltip
	}
) do
	xVermin.CheckIfLoadedWithTimer(
		tooltip:GetName(),
		function()
			if not tooltip:HasBeautyBorder() then
				tooltip:CreateBeautyBorder(12)

				local bgOffset, borderSize = 3, 12
				tooltip.Background = tooltip:CreateTexture('TooltipBackground', 'BORDER')
				tooltip.Background:SetColorTexture(0.0, 0.0, 0.0, 0.70)
				tooltip.Background:SetPoint('TOPLEFT', tooltip, bgOffset, -bgOffset)
				tooltip.Background:SetPoint('BOTTOMRIGHT', tooltip, -bgOffset, bgOffset)
			end
		end
	)
end

for _, tooltip in pairs(
	{
		GameTooltip,
		BattlePetTooltip,
		EmbeddedItemTooltip,
		ItemRefTooltip,
		ItemRefShoppingTooltip1,
		ItemRefShoppingTooltip2,
		ShoppingTooltip1,
		ShoppingTooltip2,
		AtlasLootTooltip
	}
) do
	xVermin.CheckIfLoadedWithTimer(
		tooltip:GetName(),
		function()
			if tooltip.beautyBorder or tooltip:GetName() == 'AtlasLootTooltip' then
				tooltip:HookScript(
					'OnTooltipSetItem',
					function(self)
						local name, item = self:GetItem()
						if item then
							local quality = select(3, GetItemInfo(item))
							if quality then
								local r, g, b = GetItemQualityColor(quality)
								self:SetBeautyBorderTexture('white')
								self:SetBeautyBorderColor(r, g, b)
							end
						end
					end
				)

				tooltip:HookScript(
					'OnTooltipCleared',
					function(self)
						self:SetBeautyBorderTexture('default')
						self:SetBeautyBorderColor(1, 1, 1)
					end
				)
			end
		end
	)
end

local function SetHealthBarColor(unit)
	local r, g, b = 0, 1, 0

	if unit and UnitIsPlayer(unit) then
		local classColor = RAID_CLASS_COLORS[select(2, UnitClass(unit))]
		r, g, b = classColor.r, classColor.g, classColor.b
	elseif UnitIsTrivial(unit) and UnitIsEnemy(unit, 'player') then
		r, g, b = unpack(cfg.reaction['grey'])
	end

	-- if cfg.healthbar.customColor.apply and not cfg.healthbar.reactionColoring then
	-- 	r, g, b = cfg.healthbar.customColor.r, cfg.healthbar.customColor.g, cfg.healthbar.customColor.b
	-- elseif cfg.healthbar.reactionColoring and unit then
	-- 	r, g, b = UnitSelectionColor(unit)
	-- else
	-- 	r, g, b = 0, 1, 0
	-- end

	GameTooltipStatusBar:SetStatusBarColor(r, g, b)
	-- GameTooltipStatusBar:SetBackdropColor(r, g, b, 0.3)
end

local function HandleUnit(self, ...)
	local _, unit = self:GetUnit()

	if UnitExists(unit) and UnitName(unit) ~= UNKNOWN then
		local specIcon = ''

		local name, realm = UnitName(unit)
		mainSpeed, offSpeed = UnitAttackSpeed(unit);

		if UnitIsAFK(unit) then
			self:AppendText('|cff00ff00 <' .. CHAT_MSG_AFK .. '>|r')
		elseif UnitIsDND(unit) then
			self:AppendText('|cff00ff00 <' .. DEFAULT_DND_MESSAGE .. '>|r')
		end

		-- add attack speed
		-- if offSpeed ~= nil then os = "/" .. xVermin:Round(offSpeed, 2) else os = "" end
		-- self:AddLine('Attack speed: ' .. xVermin:Round(mainSpeed, 2) .. os)

		-- Move the healthbar inside the tooltip
		if GameTooltipStatusBar:IsShown() then
			self:AddLine('                         ') -- min width empty spaces :)
			GameTooltipStatusBar:ClearAllPoints()
			GameTooltipStatusBar:SetPoint('LEFT', self:GetName() .. 'TextLeft' .. self:NumLines(), 1, 0)
			GameTooltipStatusBar:SetPoint('RIGHT', self, -10, 0)
			-- GameTooltipStatusBar:AddTexture('Interface\\Addons\\SharedMedia\\statusbar\\Glamour2.tga')
			SetHealthBarColor(unit)
		end

		-- Border coloring
		if UnitIsPlayer(unit) then
			local classColor = RAID_CLASS_COLORS[select(2, UnitClass(unit))]
			self:SetBeautyBorderTexture('white')
			self:SetBeautyBorderColor(classColor.r, classColor.g, classColor.b)
		else
			if UnitReaction('mouseover', 'player') and UnitReaction('mouseover', 'player') > 0 and UnitReaction('mouseover', 'player') < 9 then
				self:SetBeautyBorderTexture('white')
				self:SetBeautyBorderColor(unpack(cfg.reaction[UnitReaction('mouseover', 'player')]))
			end
		end

		-- Dead or ghost recoloring
		if UnitIsDead(unit) or UnitIsGhost(unit) or (UnitIsTrivial(unit) and UnitIsEnemy(unit, 'player')) then
			self:SetBeautyBorderTexture('white')
			self:SetBeautyBorderColor(unpack(cfg.reaction['grey']))
		end

	end
end

local function HandleStatusBar(self, ...)
	local _, unit = self:GetUnit()

	if UnitExists(unit) and UnitName(unit) ~= UNKNOWN and GameTooltipStatusBar:IsShown() then
		SetHealthBarColor(unit)
	end
end

GameTooltip:HookScript('OnTooltipSetUnit', HandleUnit)
GameTooltip:HookScript('OnUpdate', HandleStatusBar)

GameTooltip:HookScript(
	'OnTooltipCleared',
	function(self)
		GameTooltipStatusBar:ClearAllPoints()
		GameTooltipStatusBar:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', 0.5, 3)
		GameTooltipStatusBar:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', -1, 3)
		-- GameTooltipStatusBar:SetBackdropColor(0, 1, 0, 0.3)

		self:SetBeautyBorderTexture('default')
		self:SetBeautyBorderColor(1, 1, 1)
	end
)
