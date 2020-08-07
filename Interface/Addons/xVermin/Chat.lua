_G.CHAT_FLAG_AFK = "[AFK] "
_G.CHAT_FLAG_DND = "[DND] "
_G.CHAT_FLAG_GM = "[GM] "

_G.CHAT_GUILD_GET = "(|Hchannel:Guild|hG|h) %s:\32"
_G.CHAT_OFFICER_GET = "(|Hchannel:o|hO|h) %s:\32"

_G.CHAT_PARTY_GET = "(|Hchannel:party|hP|h) %s:\32"
_G.CHAT_PARTY_LEADER_GET = "(|Hchannel:party|hPL|h) %s:\32"
_G.CHAT_PARTY_GUIDE_GET = "(|Hchannel:party|hDG|h) %s:\32"
_G.CHAT_MONSTER_PARTY_GET = "(|Hchannel:raid|hR|h) %s:\32"

_G.CHAT_RAID_GET = "(|Hchannel:raid|hR|h) %s:\32"
_G.CHAT_RAID_WARNING_GET = "(RW!) %s:\32"
_G.CHAT_RAID_LEADER_GET = "(|Hchannel:raid|hL|h) %s:\32"

_G.CHAT_BATTLEGROUND_GET = "(|Hchannel:Battleground|hBG|h) %s:\32"
_G.CHAT_BATTLEGROUND_LEADER_GET = "(|Hchannel:Battleground|hBL|h) %s:\32"

_G.CHAT_INSTANCE_CHAT_GET = "|Hchannel:INSTANCE_CHAT|h[I]|h %s:\32"
_G.CHAT_INSTANCE_CHAT_LEADER_GET = "|Hchannel:INSTANCE_CHAT|h[IL]|h %s:\32"

channel = {
	-- "%[%d+%. General.-%]",
	-- "%[%d+%. Trade.-%]",
	-- "%[%d+%. WorldDefense%]",
	-- "%[%d+%. LocalDefense.-%]",
	-- "%[%d+%. LookingForGroup%]",
	-- "%[%d+%. GuildRecruitment.-%]"
	"General.-",
	"Trade.-",
	"WorldDefense",
	"LocalDefense.-",
	"LookingForGroup",
	"GuildRecruitment.-"
}
replace = {}

local newAddMsg = {}
local function AddMessage(frame, text, ...)
	for i = 1, 6 do
		text = gsub(text, channel[i], "")
	end
	--If Blizz timestamps is enabled, stamp anything it misses
	if CHAT_TIMESTAMP_FORMAT and not text:find("|r") then
		text = BetterDate(CHAT_TIMESTAMP_FORMAT, time()) .. text
	end
	text = gsub(text, "%[(%d0?)%. .-%]", "[%1]") --custom channels
	return newAddMsg[frame:GetName()](frame, text, ...)
end
do
	for i = 1, 5 do
		if i ~= 2 then -- skip combatlog
			local f = _G[format("%s%d", "ChatFrame", i)]
			newAddMsg[format("%s%d", "ChatFrame", i)] = f.AddMessage
			f.AddMessage = AddMessage
		end
	end
end

local cfg = {
	alwaysAlertOnWhisper = true,
	disableFade = false,
	chatOutline = false,
	enableChatWindowBorder = false,
	enableBottomButton = false,
	enableHyperlinkTooltip = false,
	enableBorderColoring = true,
	enableVoiceChatButtons = false,
	showInputBoxAbove = true, -- Show the chat input box above the chat window
	tab = {
		fontSize = 12,
		fontOutline = true,
		normalColor = {1, 1, 1},
		specialColor = {1, 0, 1},
		selectedColor = {0, 0.75, 1}
	}
}

local chat = CreateFrame("Frame")
chat:SetScript(
	"OnEvent",
	function()
		-- local chatWidth = GetScreenWidth() * UIParent:GetEffectiveScale() / 2.6
		local chatWidth = GetScreenWidth() * UIParent:GetEffectiveScale() / (4.5 * xVermin.config.scale)

		FCF_ResetChatWindows()
		JoinChannelByName("WorldDefense")
		JoinChannelByName("LookingForGroup")
		-------------------------------------------
		-- chat frames
		-------------------------------------------
		ChatFrame1:ClearAllPoints()
		ChatFrame1:SetClampRectInsets(0, -1, 0, 0)
		ChatFrame1:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 3, 7)
		ChatFrame1:SetHeight(220)
		ChatFrame1:SetWidth(chatWidth)
		ChatFrame1Background:SetAlpha(0.6)
		FCF_SetChatWindowFontSize(nil, ChatFrame1, 12)

		ChatFrame2:ClearAllPoints()
		ChatFrame2:SetClampRectInsets(0, -1, 0, 0)
		ChatFrame2:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 3, 7)
		ChatFrame2:SetHeight(196)
		ChatFrame2:SetWidth(chatWidth)
		ChatFrame2Background:SetAlpha(0.6)
		FCF_SetChatWindowFontSize(nil, ChatFrame2, 12)

		local frame = ChatFrame3
		FCF_SetWindowName(frame, "Groups and parties")
		FCF_SetChatWindowFontSize(nil, frame, 12)
		ChatFrame_RemoveAllMessageGroups(ChatFrame3)
		ChatFrame_AddMessageGroup(frame, "GUILD")
		ChatFrame_AddMessageGroup(frame, "OFFICER")
		ChatFrame_AddMessageGroup(frame, "PARTY")
		ChatFrame_AddMessageGroup(frame, "PARTY_LEADER")
		ChatFrame_AddMessageGroup(frame, "RAID")
		ChatFrame_AddMessageGroup(frame, "RAID_LEADER")
		ChatFrame_AddMessageGroup(frame, "RAID_WARNING")
		ChatFrame_AddMessageGroup(frame, "BATTLEGROUND")
		ChatFrame_AddMessageGroup(frame, "BATTLEGROUND_LEADER")
		ChatFrame_AddMessageGroup(frame, "INSTANCE_CHAT")
		ChatFrame_AddMessageGroup(frame, "INSTANCE_CHAT_LEADER")
		ChatFrame_AddMessageGroup(frame, "WHISPER")
		ChatFrame_AddMessageGroup(frame, "BN_WHISPER")

		ChatFrame_RemoveMessageGroup(ChatFrame1, "GUILD")
		ChatFrame_RemoveMessageGroup(ChatFrame1, "OFFICER")
		ChatFrame_RemoveMessageGroup(ChatFrame1, "PARTY")
		ChatFrame_RemoveMessageGroup(ChatFrame1, "PARTY_LEADER")
		ChatFrame_RemoveMessageGroup(ChatFrame1, "RAID")
		ChatFrame_RemoveMessageGroup(ChatFrame1, "RAID_LEADER")
		ChatFrame_RemoveMessageGroup(ChatFrame1, "RAID_WARNING")
		ChatFrame_RemoveMessageGroup(ChatFrame1, "BATTLEGROUND")
		ChatFrame_RemoveMessageGroup(ChatFrame1, "BATTLEGROUND_LEADER")
		ChatFrame_RemoveMessageGroup(ChatFrame1, "INSTANCE_CHAT")
		ChatFrame_RemoveMessageGroup(ChatFrame1, "INSTANCE_CHAT_LEADER")
		ChatFrame_RemoveMessageGroup(ChatFrame1, "WHISPER")
		ChatFrame_RemoveMessageGroup(ChatFrame1, "BN_WHISPER")

		ChatFrame3:ClearAllPoints()
		ChatFrame3:SetClampRectInsets(0, -1, 0, 0)
		ChatFrame3:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -3, 7)
		ChatFrame3:SetHeight(220)
		ChatFrame3:SetWidth(chatWidth)
		ChatFrame3:Show()
		ChatFrame3Tab:Show()
		ChatFrame3Background:SetAlpha(0.6)

		local frame = FCF_OpenNewWindow("LFG")
		FCF_SetChatWindowFontSize(nil, frame, 12)
		ChatFrame_RemoveAllMessageGroups(frame)
		ChatFrame4:ClearAllPoints()
		ChatFrame4:SetClampRectInsets(0, -1, 0, 0)
		ChatFrame4:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 3, 7)
		ChatFrame4:SetHeight(220)
		ChatFrame4:SetWidth(chatWidth)
		ChatFrame4:Show()
		ChatFrame4Tab:Show()
		ChatFrame4Background:SetAlpha(0.6)

		local frame = FCF_OpenNewWindow("Defense")
		FCF_SetChatWindowFontSize(nil, frame, 12)
		ChatFrame_RemoveAllMessageGroups(frame)
		ChatFrame5:ClearAllPoints()
		ChatFrame5:SetClampRectInsets(0, -1, 0, 0)
		ChatFrame5:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 3, 7)
		ChatFrame5:SetHeight(220)
		ChatFrame5:SetWidth(chatWidth)
		ChatFrame5:Show()
		ChatFrame5Tab:Show()
		ChatFrame5Background:SetAlpha(0.6)

		local channel_type, channel_name = JoinChannelByName("xVerminPrivateDEV", "perika10", ChatFrame6:GetID(), 1)

		-- ChatFrame1.ClearAllPoints = function() end
		ChatFrame1.SetPoint = function()
		end
		-- ChatFrame1.SetClampRectInsets = function() end
		ChatFrame1Background.SetAlpha = function()
		end

		-- ChatFrame2.ClearAllPoints = function() end
		ChatFrame2.SetPoint = function()
		end
		-- ChatFrame2.SetClampRectInsets = function() end
		ChatFrame2Background.SetAlpha = function()
		end

		-- ChatFrame3.ClearAllPoints = function() end
		ChatFrame3.SetPoint = function()
		end
		-- ChatFrame3.SetClampRectInsets = function() end
		ChatFrame3Background.SetAlpha = function()
		end

		-- ChatFrame4.ClearAllPoints = function() end
		ChatFrame4.SetPoint = function()
		end
		-- ChatFrame4.SetClampRectInsets = function() end
		ChatFrame4Background.SetAlpha = function()
		end

		-- ChatFrame5.ClearAllPoints = function() end
		ChatFrame5.SetPoint = function()
		end
		-- ChatFrame5.SetClampRectInsets = function() end
		ChatFrame5Background.SetAlpha = function()
		end

		for i, v in pairs(
			{
				ChatFrame1,
				ChatFrame2,
				ChatFrame3,
				ChatFrame4,
				ChatFrame5,
				ChatFrame6
			}
		) do
			v:HookScript(
				"OnUpdate",
				function(self)
					local btnFrame = _G[v:GetName() .. "ButtonFrame"]
					btnFrame:Hide()
				end
			)
		end

		ChatFrameChannelButton:Hide()
		ChatFrameMenuButton:Hide()

		ChatFrame1Tab:Click()
	end
)
chat:RegisterEvent("PLAYER_LOGIN")

local function SetChatChannels()
	ChatFrame_RemoveChannel(ChatFrame1, "LookingForGroup")
	ChatFrame_RemoveChannel(ChatFrame1, "LocalDefense")
	ChatFrame_RemoveChannel(ChatFrame1, "WorldDefense")

	ChatFrame_RemoveAllChannels(ChatFrame3)
	ChatFrame_RemoveAllChannels(ChatFrame4)
	ChatFrame_RemoveAllChannels(ChatFrame5)
	ChatFrame_RemoveAllChannels(ChatFrame6)

	JoinChannelByName("LookingForGroup")
	JoinChannelByName("LocalDefense")
	JoinChannelByName("WorldDefense")

	ChatFrame_AddChannel(ChatFrame4, "LookingForGroup")
	ChatFrame_AddChannel(ChatFrame5, "LocalDefense")
	ChatFrame_AddChannel(ChatFrame5, "WorldDefense")
end

local f = CreateFrame("Frame")
f:SetScript(
	"OnEvent",
	function(self, event)
		if event == "PLAYER_ENTERING_WORLD" then
			C_Timer.After(
				15,
				function()
					SetChatChannels()
				end
			)
		end
	end
)
f:RegisterEvent("PLAYER_ENTERING_WORLD")

SLASH_SETCHANNELS1 = "/fc"
SlashCmdList["SETCHANNELS"] = SetChatChannels

-- Tab text colors for the tabs
hooksecurefunc(
	"FCFTab_UpdateColors",
	function(self, selected)
		if selected then
			self:GetFontString():SetTextColor(0, 0.75, 1)
		else
			self:GetFontString():SetTextColor(1, 1, 1)
		end
	end
)

-- Tab text fadeout.
hooksecurefunc(
	"FCF_FadeOutChatFrame",
	function(chatFrame)
		local frameName = chatFrame:GetName()
		local chatTab = _G[frameName .. "Tab"]
		local tabGlow = _G[frameName .. "TabGlow"]

		if not tabGlow:IsShown() then
			if frameName.isDocked then
				securecall("UIFrameFadeOut", chatTab, CHAT_FRAME_FADE_OUT_TIME, chatTab:GetAlpha(), CHAT_FRAME_TAB_NORMAL_NOMOUSE_ALPHA)
			else
				securecall("UIFrameFadeOut", chatTab, CHAT_FRAME_FADE_OUT_TIME, chatTab:GetAlpha(), CHAT_FRAME_TAB_NORMAL_NOMOUSE_ALPHA)
			end
		end
	end
)

-- Modify the chat tabs.
local function SkinTab(self)
	local chat = _G[self]
	local font, _, _ = chat:GetFont()

	local tab = _G[self .. "Tab"]
	for i = 1, select("#", tab:GetRegions()) do
		local texture = select(i, tab:GetRegions())
		if texture and texture:GetObjectType() == "Texture" then
			texture:SetTexture(nil)
		end
	end

	local tabText = _G[self .. "TabText"]
	tabText:SetJustifyH("CENTER")
	tabText:SetWidth(60)
	tabText:SetFont(font, cfg.tab.fontSize)
	tabText:SetShadowOffset(1, -1)

	local a1, a2, a3, a4, a5 = tabText:GetPoint()
	tabText:SetPoint(a1, a2, a3, a4, 1)

	local s1, s2, s3 = unpack(cfg.tab.specialColor)
	local e1, e2, e3 = unpack(cfg.tab.selectedColor)
	local n1, n2, n3 = unpack(cfg.tab.normalColor)

	local tabGlow = _G[self .. "TabGlow"]
	hooksecurefunc(
		tabGlow,
		"Show",
		function()
			tabText:SetTextColor(s1, s2, s3, CHAT_FRAME_TAB_NORMAL_MOUSEOVER_ALPHA)
		end
	)

	hooksecurefunc(
		tabGlow,
		"Hide",
		function()
			tabText:SetTextColor(n1, n2, n3)
		end
	)

	tab:SetScript(
		"OnEnter",
		function()
			tabText:SetTextColor(s1, s2, s3, tabText:GetAlpha())
			tab:SetAlpha(1)
		end
	)

	tab:SetScript(
		"OnLeave",
		function()
			local hasNofication = tabGlow:IsShown()

			local r, g, b
			if _G[self] == SELECTED_CHAT_FRAME and chat.isDocked then
				r, g, b = e1, e2, e3
			elseif hasNofication then
				r, g, b = s1, s2, s3
			else
				r, g, b = n1, n2, n3
			end

			tabText:SetTextColor(r, g, b)
			tab:SetAlpha(1)
		end
	)

	hooksecurefunc(
		tab,
		"Show",
		function()
			if not tab.wasShown then
				local hasNofication = tabGlow:IsShown()
				local r, g, b
				if _G[self] == SELECTED_CHAT_FRAME and chat.isDocked then
					r, g, b = e1, e2, e3
				elseif hasNofication then
					r, g, b = s1, s2, s3
				else
					r, g, b = n1, n2, n3
				end

				tabText:SetTextColor(r, g, b)

				tab.wasShown = true
			end

			tab:SetAlpha(1)
			tab.SetAlpha = function()
			end
		end
	)
end

local count = 0
for _, frame in pairs(CHAT_FRAMES) do
	local chat = _G[frame]
	if chat then
		SkinTab(chat:GetName())
	end
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Modify the editbox
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ChatFrame1EditBox:SetAltArrowKeyMode(false)
ChatFrame1EditBox:ClearAllPoints()
ChatFrame1EditBox:SetPoint("BOTTOMLEFT", ChatFrame1, "TOPLEFT", 2, 35)
ChatFrame1EditBox:SetPoint("BOTTOMRIGHT", ChatFrame1, "TOPRIGHT", 0, 35)
ChatFrame1EditBox:SetBackdrop(
	{
		bgFile = "Interface\\Buttons\\WHITE8x8",
		insets = {
			left = 0,
			right = 0,
			top = 0,
			bottom = 0
		}
	}
)

ChatFrame1EditBox:SetBackdropColor(0, 0, 0, 0.75)
ChatFrame1EditBox:SetHeight(28)
ChatFrame1EditBox:CreateBeautyBorder(8)
-- ChatFrame1EditBox:SetBeautyBorderPadding(-2, -1, -2, -1, -2, -1, -2, -1)

ChatFrame1EditBox:SetBeautyBorderTexture("white")

hooksecurefunc(
	"ChatEdit_UpdateHeader",
	function(editBox)
		local type = editBox:GetAttribute("chatType")
		if (not type) then
			return
		end

		local info = ChatTypeInfo[type]
		ChatFrame1EditBox:SetBeautyBorderColor(info.r, info.g, info.b)
	end
)

ChatFrame1EditBoxMid:Hide()
ChatFrame1EditBoxLeft:Hide()
ChatFrame1EditBoxRight:Hide()

-- local function UpdateBackgroundAnchors(self)
-- 	--fix wierd combat log
-- 	self:SetClampRectInsets(0, 0, 0, 0)
-- end

-- hooksecurefunc("FloatingChatFrame_UpdateBackgroundAnchors", UpdateBackgroundAnchors)

local patterns = {
	"(https://%S+%.%S+)",
	"(http://%S+%.%S+)",
	"(www%.%S+%.%S+)",
	"(%d+%.%d+%.%d+%.%d+:?%d*/?%S*)"
}

local SetHyperlink = _G.ItemRefTooltip.SetHyperlink
function _G.ItemRefTooltip:SetHyperlink(link, ...)
	if link and (strsub(link, 1, 3) == "url") then
		local editbox = ChatEdit_ChooseBoxForSend()
		ChatEdit_ActivateChat(editbox)
		editbox:Insert(string.sub(link, 5))
		editbox:HighlightText()
		return
	end

	SetHyperlink(self, link, ...)
end
