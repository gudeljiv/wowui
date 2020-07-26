-------------------------------------------
-- custom modification of wow UI elements
-------------------------------------------
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
		DressUpFrame
	}
) do
	v:SetScale(1.2)
end

local LoDMap = {
	-- Maps Blizzard addon names to frame list
	Blizzard_CraftUI = {"CraftFrame"},
	Blizzard_MacroUI = {"MacroFrame"},
	Blizzard_TalentUI = {"TalentFrame"},
	Blizzard_TradeSkillUI = {"TradeSkillFrame"},
	Blizzard_InspectUI = {"InspectFrame"}
}

local EventFrame = CreateFrame("Frame") --    Event Listener Frame
EventFrame:RegisterEvent("ADDON_LOADED")
EventFrame:SetScript(
	"OnEvent",
	function(self, event, ...) --   OnEvent Script
		if event == "ADDON_LOADED" then
			local framelist = LoDMap[(...)]
			-- Loads list from map using addon name
			if framelist then -- Check if one of the LoD addons in our list
				for _, name in ipairs(framelist) do
					local frame = _G[name] -- Get our frame from the global table

					-- Do stuff
					frame:SetScale(1.2) --    Set scale of the frame
				end
			end
		end
	end
)
