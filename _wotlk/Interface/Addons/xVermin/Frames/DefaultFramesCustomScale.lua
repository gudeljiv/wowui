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
		MerchantFrame,
		PVPParentFrame,
		PVEFrame
	}
) do
	if v then
		v:SetScale(1.2)
	-- v:ClearAllPoints()
	-- v:SetPoint("CENTER", UIParent, "CENTER", 400, 300)
	end
end


QuestLogFrame:HookScript('OnShow', function()ExpandQuestHeader(0)end)
QuestLogFrame:HookScript('OnUpdate', function()ExpandQuestHeader(0)end)

xVermin.CheckIfLoadedWithTimer(
	'LFGParentFrame',
	function()
		LFGParentFrame:SetScale(1.2)
	end
)

xVermin.CheckIfLoadedWithTimer(
	'CraftFrame',
	function()
		CraftFrame:SetScale(1.2)
	end
)

local LoDMap = {
	Blizzard_CraftUI = {'CraftFrame'},
	Blizzard_MacroUI = {'MacroFrame'},
	Blizzard_TalentUI = {'PlayerTalentFrame'},
	Blizzard_TradeSkillUI = {'TradeSkillFrame'},
	Blizzard_InspectUI = {'InspectFrame'},
	Blizzard_TrainerUI = {'ClassTrainerFrame'},
	Blizzard_AuctionUI = {'AuctionFrame'},
	Blizzard_Calendar = {'CalendarFrame'},
	Blizzard_ItemSocketingUI = {'ItemSocketingFrame'},
}

local f = CreateFrame('Frame')
f:RegisterEvent('ADDON_LOADED')
f:SetScript(
	'OnEvent',
	function(self, event, ...)
		if event == 'ADDON_LOADED' then
			local framelist = LoDMap[(...)]
			if framelist then
				for _, name in ipairs(framelist) do
					_G[name]:SetScale(1.2)

					if (name == 'AuctionFrame') then
						for i = 1, 7 do
							_G['BrowseButton' .. i .. 'Item']:CreateBeautyBorder(8)
						end
					end
					-- if (name == 'CalendarFrame') then
					-- 	CalendarFrameTopLeftTexture:SetVertexColor(.05, .05, .05)
					-- 	CalendarFrameTopMiddleTexture:SetVertexColor(.05, .05, .05)
					-- 	CalendarFrameRightMiddleTexture:SetVertexColor(.05, .05, .05)
					-- 	CalendarFrameBottomMiddleTexture:SetVertexColor(.05, .05, .05)
					-- 	CalendarFrameLeftMiddleTexture:SetVertexColor(.05, .05, .05)
					-- 	CalendarFrameTopRightTexture:SetVertexColor(.05, .05, .05)
					-- 	CalendarFrameBottomLeftTexture:SetVertexColor(.05, .05, .05)
					-- 	CalendarFrameBottomRightTexture:SetVertexColor(.05, .05, .05)
					-- 	CalendarFrameRightBottomTexture:SetVertexColor(.05, .05, .05)
					-- 	CalendarFrameRightTopTexture:SetVertexColor(.05, .05, .05)
					-- 	CalendarFrameLeftTopTexture:SetVertexColor(.05, .05, .05)
					-- 	CalendarFrameLeftBottomTexture:SetVertexColor(.05, .05, .05)
					-- end
				end
			end
		end
	end
)
