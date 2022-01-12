local _, xVermin = ...

for i, v in pairs(
	{
		GameMenuFrame,
		CharacterFrame,
		SpellBookFrame,
		FriendsFrame,
		QuestLogFrame,
		MailFrame,
		MacroFrame,
		ItemTextFrame,
		DressUpFrame,
		TaxiFrame,
		QuestFrame,
		PetStableFrame,
		GossipFrame,
		MerchantFrame,
		CraftFrame,
		ClassTrainerFrame,
		AuctionFrame
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

local EventFrame = CreateFrame("Frame")
EventFrame:RegisterEvent("ADDON_LOADED")
EventFrame:SetScript(
	"OnEvent",
	function(self, event, ...)
		if event == "ADDON_LOADED" then
			local framelist = LoDMap[(...)]
			if framelist then
				for _, name in ipairs(framelist) do
					_G[name]:SetScale(1.3)
					-- _G[name]:ClearAllPoints()
					-- _G[name]:SetPoint("CENTER", UIParent, "CENTER", 400, 300)
					-- _G[name].SetPoint = function()
					-- end
				end
			end
		end
	end
)
