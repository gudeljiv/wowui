local _, xVermin = ...

if C_AddOns.IsAddOnLoaded("AdiBags") then
	local addon = LibStub("AceAddon-3.0"):GetAddon("AdiBags")
	local L = setmetatable({}, { __index = addon.L })

	local mod = addon:NewModule("ClassicItemLevel", "ABEvent-1.0")
	mod.uiName = L["Classic item level"]
	mod.uiDesc = L["Adds Classic-compatable item level text to items"]

	local maxLevelColors = {}
	do
		local t = maxLevelColors
		t[1], t[2], t[3] = GetItemQualityColor(2)
		t[4], t[5], t[6] = GetItemQualityColor(3)
		t[7], t[8], t[9] = GetItemQualityColor(4)
		t[10], t[11], t[12] = GetItemQualityColor(5)
	end

	function mod:OnInitialize()
		self.db = addon.db:RegisterNamespace(self.moduleName, {
			profile = {
				equippableOnly = true,
				minLevel = 1,
				ignoreJunk = true,
			},
		})
	end

	function mod:OnEnable()
		self:RegisterMessage("AdiBags_UpdateButton", "UpdateButton")
		self:SendMessage("AdiBags_UpdateAllButtons")
	end

	function mod:OnDisable()
		self:SendMessage("AdiBags_UpdateAllButtons")
	end

	function mod:GetOptions()
		return {
			equippableOnly = {
				name = L["Only equippable items"],
				desc = L["Do not show level of items that cannot be equipped."],
				type = "toggle",
				order = 10,
			},
			minLevel = {
				name = L["Mininum level"],
				desc = L["Do not show levels under this threshold."],
				type = "range",
				min = 1,
				max = 1000,
				step = 1,
				bigStep = 10,
				order = 30,
			},
			ignoreJunk = {
				name = L["Ignore low quality items"],
				desc = L["Do not show level of poor quality items."],
				type = "toggle",
				order = 40,
			},
		},
			addon:GetOptionHandler(self)
	end

	local function GetBorder(quality, isQuestItem, questId, isQuestActive, settings)
		local color = quality ~= ITEM_QUALITY_COMMON and BAG_ITEM_QUALITY_COLORS[quality]
		if color then
			return [[Interface\Buttons\UI-ActionButton-Border]],
				color.r,
				color.g,
				color.b,
				settings.qualityOpacity,
				14 / 64,
				49 / 64,
				15 / 64,
				50 / 64,
				"ADD"
		end
	end

	local function UpdateItemLevel(button)
		if not button.hasItem then
			if button.text then
				button.text:Hide()
			end
			return
		end
		if not button.text then
			button.text = button:CreateFontString(nil, "ARTWORK")
			button.text:SetFont("Fonts\\FRIZQT__.TTF", 10, "THINOUTLINE")
			button.text:SetTextColor(1, 1, 0)
			button.text:SetPoint("TOPRIGHT", button, "TOPRIGHT", 0, -2)
			button.text:Hide()
		else
			button.text:Hide()
		end

		itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice =
			GetItemInfo(button.itemLink)

		if itemLevel and itemEquipLoc and itemEquipLoc ~= "" then
			button.text:SetText(itemLevel)
			button.text:Show()
		else
			button.text:Hide()
		end
	end

	function mod:UpdateButton(event, button)
		local settings = self.db.profile
		local link = button:GetItemLink()
		local text = button.ClassicItemLevelText

		button:CreateBeautyBorder(8)
		button:SetBeautyBorderTexture("Interface\\AddOns\\xVermin\\Media\\textureNormal")
		button:SetBeautyBorderColor(1, 1, 1, 1)

		if not button.hasItem then
			if button.text then
				button.text:Hide()
			end
			return
		end

		if link then
			if button.hasItem then
				isQuestItem, questId, isQuestActive = addon:GetContainerItemQuestInfo(button.bag, button.slot)
				itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice =
					GetItemInfo(button.itemLink)
				texture, r, g, b, a, x1, x2, y1, y2, blendMode =
					GetBorder(itemRarity, isQuestItem, questId, isQuestActive, settings)

				if itemRarity and itemRarity > 1 then
					button:SetBeautyBorderTexture("Interface\\AddOns\\xVermin\\Media\\textureWhite")
					button:SetBeautyBorderColor(r or 1, g or 0, b or 0, 1)
				end

				if itemType and itemType == "Quest" then
					button:SetBeautyBorderTexture("Interface\\AddOns\\xVermin\\Media\\textureWhite")
					button:SetBeautyBorderColor(1, 0.964, 0, 1)
				end
			end

			UpdateItemLevel(button)
		end
	end

	hooksecurefunc(addon, "CreateContainerFrame", function(self, name, isBank, bagObject)
		if AdiBagsContainer1 then
			AdiBagsContainer1:CreateBeautyBorder(8)
		end
		if AdiBagsContainer2 then
			AdiBagsContainer2:CreateBeautyBorder(8)
		end
	end)
end
