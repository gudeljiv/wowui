local _, xVermin = ...

for i, v in pairs(
	{
		GameMenuFrame,
		CharacterFrame,
		SpellBookFrame,
		FriendsFrame,
		QuestLogFrame,
		MailFrame,
		ItemTextFrame,
		DressUpFrame,
		TaxiFrame,
		QuestFrame,
		PetStableFrame,
		GossipFrame,
		MerchantFrame
	}
) do
	if v then 
		v:SetScale(1.3)
		-- v:ClearAllPoints()
		-- v:SetPoint("CENTER", UIParent, "CENTER", 400, 300)
		-- v.SetPoint = function()
		-- end
	end
end

local LoDMap = {
	Blizzard_CraftUI = {"CraftFrame"},
	Blizzard_MacroUI = {"MacroFrame"},
	Blizzard_TalentUI = {"PlayerTalentFrame"},
	Blizzard_TradeSkillUI = {"TradeSkillFrame"},
	Blizzard_InspectUI = {"InspectFrame"},
	Blizzard_TrainerUI = {"ClassTrainerFrame"},
	Blizzard_AuctionUI = {"AuctionFrame"}
}

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript(
	"OnEvent",
	function(self, event, ...)
		if event == "ADDON_LOADED" then
			local framelist = LoDMap[(...)]
			if framelist then
				for _, name in ipairs(framelist) do
					_G[name]:SetScale(1.3)

					if(name == "AuctionFrame") then
						for i = 1, 7 do
							_G["BrowseButton" .. i .."Item"]:CreateBeautyBorder(8)

							-- local name, texture, count, quality, canUse, level, levelColHeader, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, bidderFullName, owner, ownerFullName, saleStatus, itemId, hasAllInfo = GetAuctionItemInfo("type", index)
							-- local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(itemID or "itemString" or "itemName" or "itemLink")
						end
					end
					-- _G[name]:ClearAllPoints()
					-- _G[name]:SetPoint("CENTER", UIParent, "CENTER", 400, 300)
					-- _G[name].SetPoint = function() end
				end
			end
		end
	end
)



-- AuctionFrame:HookScript(
-- 	"OnUpdate",
-- 	function(self)
-- 		print("auction update")
-- 	end
-- )

-- AuctionFrame:HookScript(
-- 	"OnShow",
-- 	function(self)
-- 		print("auction show")
-- 	end
-- )

-- AuctionFrame:HookScript(
-- 	"OnHide",
-- 	function(self)
-- 		print("auction hide")
-- 	end
-- )


-- for i = 1, 7 do
-- 	_G["BrowseButton" .. i .."Item"]:CreateBeautyBorder(8)
-- end