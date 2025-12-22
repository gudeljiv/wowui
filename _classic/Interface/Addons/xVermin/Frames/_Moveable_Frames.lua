local _, xVermin = ...

local frames = {
	SettingsPanel,
	GameMenuFrame,
	CharacterFrame,
	SpellBookFrame,
	FriendsFrame,
	QuestLogFrame,
	MailFrame,
	OpenMailFrame,
	ItemTextFrame,
	DressUpFrame,
	TaxiFrame,
	QuestFrame,
	PetStableFrame,
	GossipFrame,
	MerchantFrame,
	PVPParentFrame,
	CommunitiesFrame,
	AuctionFrame
}


for index, frame in pairs(frames) do

	if not frame then return end

	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:SetScript(
		"OnMouseDown", 
		function(self, button)
			if button == "LeftButton" and not self.isMoving then
				self:StartMoving();
				self.isMoving = true;
			end
		end
	)
	frame:SetScript(
		"OnMouseUp", 
		function(self, button)
			if button == "LeftButton" and self.isMoving then
			self:StopMovingOrSizing();
			self.isMoving = false;
			end
		end
	)
	frame:SetScript(
		"OnHide", 
		function(self)
			if ( self.isMoving ) then
				self:StopMovingOrSizing();
				self.isMoving = false;
			end
		end
	)
end


-- local LoDMap = {
-- 	Blizzard_CraftUI = {'CraftFrame'},
-- 	Blizzard_MacroUI = {'MacroFrame'},
-- 	Blizzard_TalentUI = {'PlayerTalentFrame'},
-- 	Blizzard_TradeSkillUI = {'TradeSkillFrame'},
-- 	Blizzard_InspectUI = {'InspectFrame'},
-- 	Blizzard_TrainerUI = {'ClassTrainerFrame'},
-- 	Blizzard_AuctionUI = {'AuctionFrame'},
-- 	Blizzard_Calendar = {'CalendarFrame'}
-- }

-- local f = CreateFrame('Frame')
-- f:RegisterEvent('ADDON_LOADED')
-- f:SetScript(
-- 	'OnEvent',
-- 	function(self, event, ...)
-- 		if event == 'ADDON_LOADED' then
-- 			local framelist = LoDMap[(...)]
-- 			if framelist then
-- 				for _, name in ipairs(framelist) do
-- 					local frame = _G[name]

-- 					if not frame then return end

-- 					frame:SetMovable(true)
-- 					frame:EnableMouse(true)
-- 					frame:SetScript(
-- 						"OnMouseDown", 
-- 						function(self, button)
-- 							if button == "LeftButton" and not self.isMoving then
-- 								self:StartMoving();
-- 								self.isMoving = true;
-- 							end
-- 						end
-- 					)
-- 					frame:SetScript(
-- 						"OnMouseUp", 
-- 						function(self, button)
-- 							if button == "LeftButton" and self.isMoving then
-- 							self:StopMovingOrSizing();
-- 							self.isMoving = false;
-- 							end
-- 						end
-- 					)
-- 					frame:SetScript(
-- 						"OnHide", 
-- 						function(self)
-- 							if ( self.isMoving ) then
-- 								self:StopMovingOrSizing();
-- 								self.isMoving = false;
-- 							end
-- 						end
-- 					)

-- 				end
-- 			end
-- 		end
-- 	end
-- )


-- local eventframe = CreateFrame("frame")
-- eventframe:RegisterEvent("ADDON_LOADED")
-- eventframe:SetScript("OnEvent", function(self, event, addon)
--     if addon == "Blizzard_AuctionUI" then
--         AuctionFrame:SetMovable(true)
--         AuctionFrame:SetClampedToScreen(true)
--         AuctionFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
--         AuctionFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
 
--         local handleAuctionFrame = function(self)
--             if AuctionFrame:GetAttribute("UIPanelLayout-enabled") then
--                 if AuctionFrame:IsVisible() then
--                     AuctionFrame.Hide = function() end
--                     HideUIPanel(AuctionFrame)
--                     AuctionFrame.Hide = nil
--                 end
--                 AuctionFrame:SetAttribute("UIPanelLayout-enabled", nil)
--             else
--                 if AuctionFrame:IsVisible() then
--                     AuctionFrame.IsShown = function() end
--                     ShowUIPanel(AuctionFrame)
--                     AuctionFrame.IsShown = nil
--                 end
--             end
--         end
--         hooksecurefunc("AuctionFrame_Show", handleAuctionFrame)
--         hooksecurefunc("AuctionFrame_Hide", handleAuctionFrame)
      
--       self:UnregisterEvent("ADDON_LOADED")
--       self:SetScript("OnEvent", nil)
--     end
-- end)