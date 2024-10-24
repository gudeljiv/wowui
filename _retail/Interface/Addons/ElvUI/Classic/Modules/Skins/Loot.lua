local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule('Skins')
local LCG = E.Libs.CustomGlow

local _G = _G
local next = next
local unpack = unpack

local hooksecurefunc = hooksecurefunc
local GetLootSlotInfo = GetLootSlotInfo
local UnitIsDead = UnitIsDead
local UnitIsFriend = UnitIsFriend
local UnitName = UnitName
local GetItemInfo = GetItemInfo
local IsFishingLoot = IsFishingLoot
local C_LootHistory_GetNumItems = C_LootHistory.GetNumItems
local C_LootHistory_GetItem = C_LootHistory.GetItem
local ITEM_QUALITY_COLORS = ITEM_QUALITY_COLORS
local LOOT, ITEMS = LOOT, ITEMS

local function UpdateLoots()
	local numItems = C_LootHistory_GetNumItems()
	for i=1, numItems do
		local frame = _G.LootHistoryFrame.itemFrames[i]
		if frame and not frame.isSkinned then
			local Icon = frame.Icon:GetTexture()
			frame:StripTextures()
			frame.Icon:SetTexture(Icon)
			frame.Icon:SetTexCoord(unpack(E.TexCoords))

			-- create a backdrop around the icon
			frame:CreateBackdrop()
			frame.backdrop:SetOutside(frame.Icon)
			frame.Icon:SetParent(frame.backdrop)

			local _, itemLink = C_LootHistory_GetItem(frame.itemIdx)
			if itemLink then
				local _, _, itemRarity = GetItemInfo(itemLink)

				if itemRarity then
					local color = ITEM_QUALITY_COLORS[itemRarity]

					if color then
						frame.backdrop:SetBackdropBorderColor(color.r, color.g, color.b)
					end
				end
			end

			frame.isSkinned = true
		end
	end
end

function S:LootFrame()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.loot) then return end

	-- Loot history frame
	local LootHistoryFrame = _G.LootHistoryFrame
	LootHistoryFrame:StripTextures()
	S:HandleCloseButton(LootHistoryFrame.CloseButton)
	LootHistoryFrame:StripTextures()
	LootHistoryFrame:SetTemplate('Transparent')
	LootHistoryFrame.ResizeButton:StripTextures()
	LootHistoryFrame.ResizeButton.text = LootHistoryFrame.ResizeButton:CreateFontString(nil, 'OVERLAY')
	LootHistoryFrame.ResizeButton.text:FontTemplate(nil, 16, 'OUTLINE')
	LootHistoryFrame.ResizeButton.text:SetJustifyH('CENTER')
	LootHistoryFrame.ResizeButton.text:Point('CENTER', LootHistoryFrame.ResizeButton)
	LootHistoryFrame.ResizeButton.text:SetText('v v v v')
	LootHistoryFrame.ResizeButton:SetTemplate()
	LootHistoryFrame.ResizeButton:Width(LootHistoryFrame:GetWidth())
	LootHistoryFrame.ResizeButton:Height(19)
	LootHistoryFrame.ResizeButton:ClearAllPoints()
	LootHistoryFrame.ResizeButton:Point('TOP', LootHistoryFrame, 'BOTTOM', 0, -2)
	_G.LootHistoryFrameScrollFrame:StripTextures()
	S:HandleScrollBar(_G.LootHistoryFrameScrollFrameScrollBar)

	hooksecurefunc('LootHistoryFrame_FullUpdate', UpdateLoots)

	-- Master Loot
	local MasterLooterFrame = _G.MasterLooterFrame
	MasterLooterFrame:StripTextures()
	MasterLooterFrame:SetTemplate()

	hooksecurefunc('MasterLooterFrame_Show', function()
		local b = MasterLooterFrame.Item
		if b then
			local i = b.Icon
			local icon = i:GetTexture()
			local c = ITEM_QUALITY_COLORS[_G.LootFrame.selectedQuality]

			b:StripTextures()
			i:SetTexture(icon)
			i:SetTexCoord(unpack(E.TexCoords))
			b:CreateBackdrop()
			b.backdrop:SetOutside(i)
			b.backdrop:SetBackdropBorderColor(c.r, c.g, c.b)
		end

		for _, child in next, { MasterLooterFrame:GetChildren() } do
			if not child.isSkinned and not child:GetName() and child:IsObjectType('Button') then
				if child:GetPushedTexture() then
					S:HandleCloseButton(child)
				else
					child:SetTemplate()
					child:StyleButton()
				end

				child.isSkinned = true
			end
		end
	end)

	local LootFrame = _G.LootFrame
	S:HandleFrame(LootFrame, true)
	LootFrame:Height(LootFrame:GetHeight() - 30)
	_G.LootFramePortraitOverlay:SetParent(E.HiddenFrame)

	for _, region in next, { LootFrame:GetRegions() } do
		if region:IsObjectType('FontString') and region:GetText() == ITEMS then
			LootFrame.Title = region
		end
	end

	LootFrame.Title:ClearAllPoints()
	LootFrame.Title:Point('TOPLEFT', LootFrame, 'TOPLEFT', 4, -4)
	LootFrame.Title:SetJustifyH('LEFT')

	for i=1, _G.LOOTFRAME_NUMBUTTONS do
		local button = _G['LootButton'..i]
		_G['LootButton'..i..'NameFrame']:Hide()
		--_G['LootButton'..i..'IconQuestTexture']:SetParent(E.HiddenFrame)
		S:HandleItemButton(button, true)

		button.IconBorder:SetTexture()
		hooksecurefunc(button.IconBorder, 'SetVertexColor', function(s, r, g, b)
			s:GetParent().backdrop:SetBackdropBorderColor(r, g, b)
			s:SetTexture()
		end)
		hooksecurefunc(button.IconBorder, 'Hide', function(s)
			s:GetParent().backdrop:SetBackdropBorderColor(unpack(E.media.bordercolor))
		end)

		local point, attachTo, point2, x, y = button:GetPoint()
		button:ClearAllPoints()
		button:Point(point, attachTo, point2, x, y+30)
	end

	hooksecurefunc('LootFrame_UpdateButton', function(index)
		local numLootItems = LootFrame.numLootItems
		--Logic to determine how many items to show per page
		local numLootToShow = _G.LOOTFRAME_NUMBUTTONS
		if LootFrame.AutoLootTable then
			numLootItems = #LootFrame.AutoLootTable
		end
		if numLootItems > _G.LOOTFRAME_NUMBUTTONS then
			numLootToShow = numLootToShow - 1 -- make space for the page buttons
		end

		local button = _G['LootButton'..index]
		local slot = (numLootToShow * (LootFrame.page - 1)) + index
		if(button and button:IsShown()) then
			local texture, _, isQuestItem, questId, isActive
			if (LootFrame.AutoLootTable) then
				local entry = LootFrame.AutoLootTable[slot]
				if( entry.hide ) then
					button:Hide()
					return
				else
					texture = entry.texture
					isQuestItem = entry.isQuestItem
					questId = entry.questId
					isActive = entry.isActive
				end
			else
				texture, _, _, _, _, _, isQuestItem, questId, isActive = GetLootSlotInfo(slot)
			end

			if texture then
				if questId and not isActive then
					LCG.ShowOverlayGlow(button)
				elseif questId or isQuestItem then
					LCG.ShowOverlayGlow(button)
				else
					LCG.HideOverlayGlow(button)
				end
			end
		end
	end)

	LootFrame:HookScript('OnShow', function(frame)
		if IsFishingLoot() then
			frame.Title:SetText(L["Fishy Loot"])
		elseif(not UnitIsFriend('player', 'target') and UnitIsDead'target') then
			frame.Title:SetText(UnitName('target'))
		else
			frame.Title:SetText(LOOT)
		end
	end)

	S:HandleNextPrevButton(_G.LootFrameDownButton)
	S:HandleNextPrevButton(_G.LootFrameUpButton)
end

S:AddCallback('LootFrame')
