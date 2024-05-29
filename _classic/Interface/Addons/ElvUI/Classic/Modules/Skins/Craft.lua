local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule('Skins')

local _G = _G
local unpack = unpack

local GetItemInfo = GetItemInfo
local GetCraftNumReagents = GetCraftNumReagents
local GetItemQualityColor = GetItemQualityColor
local GetCraftItemLink = GetCraftItemLink
local GetCraftReagentInfo = GetCraftReagentInfo
local GetCraftReagentItemLink = GetCraftReagentItemLink
local hooksecurefunc = hooksecurefunc

function S:SkinCraft()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.craft) then return end

	local CraftFrame = _G.CraftFrame
	S:HandleFrame(CraftFrame, true, nil, 11, -12, -32, 76)

	local CraftRankFrame = _G.CraftRankFrame
	CraftRankFrame:StripTextures()
	CraftRankFrame:Size(322, 16)
	CraftRankFrame:ClearAllPoints()
	CraftRankFrame:Point('TOP', -10, -45)
	CraftRankFrame:CreateBackdrop()
	CraftRankFrame:SetStatusBarTexture(E.media.normTex)
	CraftRankFrame:SetStatusBarColor(0.13, 0.35, 0.80)
	E:RegisterStatusBar(CraftRankFrame)

	_G.CraftRankFrameBorder:StripTextures()

	_G.CraftListScrollFrame:StripTextures()
	_G.CraftDetailScrollFrame:StripTextures()
	_G.CraftDetailScrollChildFrame:StripTextures()

	S:HandleScrollBar(_G.CraftListScrollFrameScrollBar)
	S:HandleScrollBar(_G.CraftDetailScrollFrameScrollBar)

	S:HandleButton(_G.CraftCancelButton)

	S:HandleButton(_G.CraftCreateButton)

	local CraftIcon = _G.CraftIcon

	_G.CraftRequirements:SetTextColor(1, 0.80, 0.10)

	S:HandleCloseButton(_G.CraftFrameCloseButton, CraftFrame.backdrop)

	_G.CraftExpandButtonFrame:StripTextures()

	local CraftCollapseAllButton = _G.CraftCollapseAllButton
	S:HandleCollapseTexture(CraftCollapseAllButton, nil, true)
	CraftCollapseAllButton:SetHighlightTexture(E.ClearTexture)

	for i = 1, _G.CRAFTS_DISPLAYED do
		local button = _G['Craft'..i]
		S:HandleCollapseTexture(button, nil, true)

		local normal = button:GetNormalTexture()
		if normal then
			normal:Size(14)
			normal:Point('LEFT', 4, 1)
		end

		local highlight = _G['Craft'..i..'Highlight']
		if highlight then
			highlight:SetTexture(E.ClearTexture)
			highlight.SetTexture = E.noop
		end
	end

	for i = 1, _G.MAX_CRAFT_REAGENTS do
		local icon = _G['CraftReagent'..i..'IconTexture']
		local count = _G['CraftReagent'..i..'Count']
		local nameFrame = _G['CraftReagent'..i..'NameFrame']

		S:HandleIcon(icon, true)
		icon:SetDrawLayer('ARTWORK')
		count:SetDrawLayer('OVERLAY')

		nameFrame:SetAlpha(0)
	end

	_G.CraftReagent1:Point('TOPLEFT', _G.CraftReagentLabel, 'BOTTOMLEFT', -3, -3)
	_G.CraftReagent2:Point('LEFT', _G.CraftReagent1, 'RIGHT', 3, 0)
	_G.CraftReagent4:Point('LEFT', _G.CraftReagent3, 'RIGHT', 3, 0)
	_G.CraftReagent6:Point('LEFT', _G.CraftReagent5, 'RIGHT', 3, 0)
	_G.CraftReagent8:Point('LEFT', _G.CraftReagent7, 'RIGHT', 3, 0)

	CraftIcon:CreateBackdrop()

	hooksecurefunc('CraftFrame_SetSelection', function(id)
		if not id then return end

		local CraftReagentLabel = _G.CraftReagentLabel
		CraftReagentLabel:Point('TOPLEFT', _G.CraftDescription, 'BOTTOMLEFT', 0, -10)

		if CraftIcon:GetNormalTexture() then
			S:HandleIcon(CraftIcon:GetNormalTexture())
		end

		CraftIcon:Size(40)
		CraftIcon:Point('TOPLEFT', 2, -3)

		local skillLink = GetCraftItemLink(id)
		if skillLink then
			local _, _, quality = GetItemInfo(skillLink)
			if quality and quality > 1 then
				local r, g, b = GetItemQualityColor(quality)
				CraftIcon.backdrop:SetBackdropBorderColor(r, g, b)
				_G.CraftName:SetTextColor(GetItemQualityColor(quality))
			else
				CraftIcon.backdrop:SetBackdropBorderColor(unpack(E.media.bordercolor))
				_G.CraftName:SetTextColor(1, 1, 1)
			end
		end

		local numReagents = GetCraftNumReagents(id)
		for i = 1, numReagents, 1 do
			local _, _, reagentCount, playerReagentCount = GetCraftReagentInfo(id, i)
			local reagentLink = GetCraftReagentItemLink(id, i)
			local icon = _G['CraftReagent'..i..'IconTexture']
			local name = _G['CraftReagent'..i..'Name']

			if reagentLink then
				local _, _, quality = GetItemInfo(reagentLink)
				if quality and quality > 1 then
					if playerReagentCount < reagentCount then
						name:SetTextColor(0.5, 0.5, 0.5)
					else
						local r, g, b = GetItemQualityColor(quality)
						name:SetTextColor(r, g, b)
					end

					local r, g, b = GetItemQualityColor(quality)
					icon.backdrop:SetBackdropBorderColor(r, g, b)
				else
					icon.backdrop:SetBackdropBorderColor(unpack(E.media.bordercolor))
				end
			end
		end

		if numReagents < 5 then
			_G.CraftDetailScrollFrameScrollBar:Hide()
			_G.CraftDetailScrollFrameTop:Hide()
			_G.CraftDetailScrollFrameBottom:Hide()
		else
			_G.CraftDetailScrollFrameScrollBar:Show()
			_G.CraftDetailScrollFrameTop:Show()
			_G.CraftDetailScrollFrameBottom:Show()
		end
	end)
end

S:AddCallbackForAddon('Blizzard_CraftUI', 'SkinCraft')
