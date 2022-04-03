local _, xVermin = ...

_G.CHAT_FLAG_AFK = '[AFK] '
_G.CHAT_FLAG_DND = '[DND] '
_G.CHAT_FLAG_GM = '[GM] '
_G.CHAT_GUILD_GET = '(|Hchannel:Guild|hG|h) %s:\32'
_G.CHAT_OFFICER_GET = '(|Hchannel:o|hO|h) %s:\32'
_G.CHAT_PARTY_GET = '(|Hchannel:party|hP|h) %s:\32'
_G.CHAT_PARTY_LEADER_GET = '(|Hchannel:party|hPL|h) %s:\32'
_G.CHAT_PARTY_GUIDE_GET = '(|Hchannel:party|hDG|h) %s:\32'
_G.CHAT_MONSTER_PARTY_GET = '(|Hchannel:raid|hR|h) %s:\32'
_G.CHAT_RAID_GET = '(|Hchannel:raid|hR|h) %s:\32'
_G.CHAT_RAID_WARNING_GET = '(RW!) %s:\32'
_G.CHAT_RAID_LEADER_GET = '(|Hchannel:raid|hL|h) %s:\32'
_G.CHAT_BATTLEGROUND_GET = '(|Hchannel:Battleground|hBG|h) %s:\32'
_G.CHAT_BATTLEGROUND_LEADER_GET = '(|Hchannel:Battleground|hBL|h) %s:\32'
_G.CHAT_INSTANCE_CHAT_GET = '|Hchannel:INSTANCE_CHAT|h[I]|h %s:\32'
_G.CHAT_INSTANCE_CHAT_LEADER_GET = '|Hchannel:INSTANCE_CHAT|h[IL]|h %s:\32'

channel = {
	'General.-',
	'Trade.-',
	'WorldDefense',
	'LocalDefense.-',
	'LookingForGroup',
	'GuildRecruitment.-'
}
replace = {}

local newAddMsg = {}
local function AddMessage(frame, text, ...)
	for i = 1, 6 do
		text = gsub(text, channel[i], '')
	end
	--If Blizz timestamps is enabled, stamp anything it misses
	if CHAT_TIMESTAMP_FORMAT and not text:find('|r') then
		text = BetterDate(CHAT_TIMESTAMP_FORMAT, time()) .. text
	end
	text = gsub(text, '%[(%d0?)%. .-%]', '[%1]') --custom channels
	return newAddMsg[frame:GetName()](frame, text, ...)
end
do
	for i = 1, 5 do
		if i ~= 2 then -- skip combatlog
			local f = _G[format('%s%d', 'ChatFrame', i)]
			newAddMsg[format('%s%d', 'ChatFrame', i)] = f.AddMessage
			f.AddMessage = AddMessage
		end
	end
end

local function OpenChatWindow(id)
	-- name, fontSize, r, g, b, alpha, shown, locked, docked, uninteractable = GetChatWindowInfo(frameIndex)
	if not select(7, GetChatWindowInfo(id)) then
		local name = 'ChatFrame' .. id
		_G[name]:Show()
		_G[name .. 'Tab']:Show()
		SetChatWindowShown(id, 1)
	end
end

local function SetChat()
	local chatWidth = (GetScreenWidth() * UIParent:GetEffectiveScale()) / (4.2 * xVermin.Config.UIscale)

	FCF_ResetChatWindows()
	JoinChannelByName('WorldDefense')
	JoinChannelByName('LookingForGroup')
	-------------------------------------------
	-- chat frames
	-------------------------------------------
	ChatFrame1:ClearAllPoints()
	ChatFrame1:SetClampedToScreen()
	ChatFrame1:SetClampRectInsets(0, -1, 0, 0)
	ChatFrame1:SetPoint('BOTTOMLEFT', UIParent, 'BOTTOMLEFT', 3, 7)
	ChatFrame1:SetHeight(220)
	FCF_SetChatWindowFontSize(nil, ChatFrame1, 12)

	ChatFrame_RemoveMessageGroup(ChatFrame1, 'GUILD')
	ChatFrame_RemoveMessageGroup(ChatFrame1, 'OFFICER')
	ChatFrame_RemoveMessageGroup(ChatFrame1, 'PARTY')
	ChatFrame_RemoveMessageGroup(ChatFrame1, 'PARTY_LEADER')
	ChatFrame_RemoveMessageGroup(ChatFrame1, 'RAID')
	ChatFrame_RemoveMessageGroup(ChatFrame1, 'RAID_LEADER')
	ChatFrame_RemoveMessageGroup(ChatFrame1, 'RAID_WARNING')
	ChatFrame_RemoveMessageGroup(ChatFrame1, 'BATTLEGROUND')
	ChatFrame_RemoveMessageGroup(ChatFrame1, 'BATTLEGROUND_LEADER')
	ChatFrame_RemoveMessageGroup(ChatFrame1, 'INSTANCE_CHAT')
	ChatFrame_RemoveMessageGroup(ChatFrame1, 'INSTANCE_CHAT_LEADER')
	ChatFrame_RemoveMessageGroup(ChatFrame1, 'WHISPER')
	ChatFrame_RemoveMessageGroup(ChatFrame1, 'BN_WHISPER')

	OpenChatWindow(2)
	FCF_SetLocked(ChatFrame2, nil)
	FCF_UnDockFrame(ChatFrame2)
	ChatFrame2:ClearAllPoints()
	ChatFrame2:SetClampedToScreen()
	ChatFrame2:SetClampRectInsets(0, -1, 0, 0)
	ChatFrame2:SetPoint('BOTTOMLEFT', UIParent, 'BOTTOMLEFT', 3, 7)
	ChatFrame2:SetHeight(196)
	FCF_SetChatWindowFontSize(nil, ChatFrame2, 12)
	ChatFrame2:SetUserPlaced(true)
	FCF_SavePositionAndDimensions(ChatFrame2)
	FCF_DockFrame(ChatFrame2)

	local frame = ChatFrame3
	FCF_UnDockFrame(frame)
	FCF_SetWindowName(frame, 'Groups and parties')
	FCF_SetChatWindowFontSize(nil, frame, 12)
	ChatFrame_RemoveAllMessageGroups(frame)
	ChatFrame_AddMessageGroup(frame, 'GUILD')
	ChatFrame_AddMessageGroup(frame, 'OFFICER')
	ChatFrame_AddMessageGroup(frame, 'PARTY')
	ChatFrame_AddMessageGroup(frame, 'PARTY_LEADER')
	ChatFrame_AddMessageGroup(frame, 'RAID')
	ChatFrame_AddMessageGroup(frame, 'RAID_LEADER')
	ChatFrame_AddMessageGroup(frame, 'RAID_WARNING')
	ChatFrame_AddMessageGroup(frame, 'BATTLEGROUND')
	ChatFrame_AddMessageGroup(frame, 'BATTLEGROUND_LEADER')
	ChatFrame_AddMessageGroup(frame, 'INSTANCE_CHAT')
	ChatFrame_AddMessageGroup(frame, 'INSTANCE_CHAT_LEADER')
	ChatFrame_AddMessageGroup(frame, 'WHISPER')
	ChatFrame_AddMessageGroup(frame, 'BN_WHISPER')

	ChatFrame3:ClearAllPoints()
	ChatFrame3:SetClampedToScreen()
	ChatFrame3:SetClampRectInsets(0, -1, 0, 0)
	ChatFrame3:SetPoint('BOTTOMRIGHT', UIParent, 'BOTTOMRIGHT', -3, 7)
	ChatFrame3Tab:ClearAllPoints()
	ChatFrame3Tab:SetPoint('BOTTOMLEFT', ChatFrame3, 'TOPLEFT', -3, 7)
	ChatFrame3:SetHeight(220)
	ChatFrame3:Show()
	ChatFrame3Tab:Show()

	local frame = ChatFrame4
	FCF_SetWindowName(frame, 'Looking for Group')
	FCF_SetChatWindowFontSize(nil, frame, 10)
	ChatFrame_RemoveAllMessageGroups(frame)
	ChatFrame4:ClearAllPoints()
	ChatFrame4:SetClampedToScreen()
	ChatFrame4:SetClampRectInsets(0, -1, 0, 0)
	ChatFrame4:SetPoint('CENTER', ChatFrame1, 0, 240)
	ChatFrame4:SetHeight(100)
	ChatFrame4:Show()
	ChatFrame4Tab:Show()

	local frame = FCF_OpenNewWindow('Defense')
	FCF_SetChatWindowFontSize(nil, frame, 12)
	ChatFrame_RemoveAllMessageGroups(frame)
	ChatFrame5:ClearAllPoints()
	ChatFrame5:SetClampedToScreen()
	ChatFrame5:SetClampRectInsets(0, -1, 0, 0)
	ChatFrame5:SetPoint('BOTTOMLEFT', UIParent, 'BOTTOMLEFT', 3, 7)
	ChatFrame5:SetHeight(220)
	ChatFrame5:Show()
	ChatFrame5Tab:Show()

	local frame = FCF_OpenNewWindow('Debug')
	FCF_SetChatWindowFontSize(nil, frame, 10)
	ChatFrame_RemoveAllMessageGroups(frame)
	ChatFrame6:ClearAllPoints()
	ChatFrame6:SetClampedToScreen()
	ChatFrame6:SetClampRectInsets(0, -1, 0, 0)
	ChatFrame6:SetPoint('BOTTOMLEFT', UIParent, 'BOTTOMLEFT', 3, 7)
	ChatFrame6:SetHeight(220)
	ChatFrame6:Show()
	ChatFrame6Tab:Show()

	local frame = ChatFrame7
	FCF_SetWindowName(frame, 'Loot & XP')
	FCF_SetChatWindowFontSize(nil, frame, 11)
	ChatFrame_RemoveAllMessageGroups(frame)
	ChatFrame7:ClearAllPoints()
	ChatFrame7:SetClampedToScreen()
	ChatFrame7:SetClampRectInsets(0, -1, 0, 0)
	-- ChatFrame7:SetPoint("RIGHT", ChatFrame3, -((chatWidth / 2) + 4), 260)
	ChatFrame7:SetPoint('TOPLEFT', UIParent, 'TOPLEFT', 3, -225)
	ChatFrame7:SetHeight(250)
	ChatFrame7:Show()
	ChatFrame7Tab:Hide()

	-- local frame = ChatFrame8
	-- FCF_SetWindowName(frame, "XP")
	-- FCF_SetChatWindowFontSize(nil, frame, 11)
	-- ChatFrame_RemoveAllMessageGroups(frame)
	-- ChatFrame8:ClearAllPoints()
	-- ChatFrame8:SetClampedToScreen()
	-- ChatFrame8:SetClampRectInsets(0, -1, 0, 0)
	-- ChatFrame8:SetPoint("RIGHT", ChatFrame3, 0, 260)
	-- ChatFrame8:SetHeight(150)
	-- ChatFrame8:Show()
	-- ChatFrame8Tab:Show()

	local background, tab

	for i, v in pairs(
		{
			ChatFrame1,
			ChatFrame2,
			ChatFrame3,
			ChatFrame4,
			ChatFrame5,
			ChatFrame6,
			ChatFrame7,
			ChatFrame8
		}
	) do
		v.SetPoint = function()
		end
		background = _G[v:GetName() .. 'Background']

		if (v:GetName() == 'ChatFrame7' or v:GetName() == 'ChatFrame8') then
			v:SetWidth((chatWidth / 1.3) - 4)
		else
			v:SetWidth(chatWidth)
			background:SetAlpha(0.6)
			background.SetAlpha = function()
			end
		end

		local BottomButton = _G[v:GetName() .. 'ButtonFrameBottomButton']
		local UpButton = _G[v:GetName() .. 'ButtonFrameUpButton']
		local DownButton = _G[v:GetName() .. 'ButtonFrameDownButton']
		local MinimizeButton = _G[v:GetName() .. 'ButtonFrameMinimizeButton']

		UpButton:Hide()
		UpButton.Show = function()
		end

		DownButton:Hide()
		DownButton.Show = function()
		end

		MinimizeButton:Hide()
		DownButton.Show = function()
		end

		BottomButton:ClearAllPoints()
		BottomButton:SetPoint('BOTTOMRIGHT', v, 'BOTTOMRIGHT', 0, -5)
		BottomButton:SetScale(0.7)
		BottomButton.SetPoint = function()
		end
		BottomButton.Hide = function()
		end
		BottomButton.SetScale = function()
		end

		v:EnableMouse(false)
	end

	ChatFrameChannelButton:Hide()
	ChatFrameMenuButton:Hide()
	ChatFrame1Tab:Click()
end

local function SetChatChannels()
	ChatFrame_RemoveChannel(ChatFrame1, 'LookingForGroup')
	ChatFrame_RemoveChannel(ChatFrame1, 'LocalDefense')
	ChatFrame_RemoveChannel(ChatFrame1, 'WorldDefense')

	ChatFrame_RemoveAllChannels(ChatFrame3)
	ChatFrame_RemoveAllChannels(ChatFrame4)
	ChatFrame_RemoveAllChannels(ChatFrame5)
	ChatFrame_RemoveAllChannels(ChatFrame6)
	ChatFrame_RemoveAllChannels(ChatFrame7)

	JoinChannelByName('LookingForGroup')
	JoinChannelByName('LocalDefense')
	JoinChannelByName('WorldDefense')

	ChatFrame_AddChannel(ChatFrame4, 'LookingForGroup')
	ChatFrame_AddChannel(ChatFrame5, 'LocalDefense')
	ChatFrame_AddChannel(ChatFrame5, 'WorldDefense')

	ChatFrame_RemoveMessageGroup(ChatFrame1, 'COMBAT_XP_GAIN')
	ChatFrame_RemoveMessageGroup(ChatFrame1, 'COMBAT_HONOR_GAIN')
	ChatFrame_RemoveMessageGroup(ChatFrame1, 'COMBAT_FACTION_CHANGE')
	ChatFrame_RemoveMessageGroup(ChatFrame1, 'SKILL')
	ChatFrame_RemoveMessageGroup(ChatFrame1, 'LOOT')
	ChatFrame_RemoveMessageGroup(ChatFrame1, 'MONEY')

	ChatFrame_AddMessageGroup(ChatFrame7, 'SKILL')
	ChatFrame_AddMessageGroup(ChatFrame7, 'LOOT')
	ChatFrame_AddMessageGroup(ChatFrame7, 'MONEY')
	ChatFrame_AddMessageGroup(ChatFrame7, 'COMBAT_XP_GAIN')
	ChatFrame_AddMessageGroup(ChatFrame7, 'COMBAT_HONOR_GAIN')
	ChatFrame_AddMessageGroup(ChatFrame7, 'COMBAT_FACTION_CHANGE')
end

local chat = CreateFrame('Frame')
chat:SetScript(
	'OnEvent',
	function(self, event)
		if event == 'PLAYER_LOGIN' then
			C_Timer.After(
				2,
				function()
					SetChat()
					C_Timer.After(
						2,
						function()
							SetChatChannels()
						end
					)
				end
			)
		end
	end
)
chat:RegisterEvent('PLAYER_LOGIN')

-- Tab text colors for the tabs
hooksecurefunc(
	'FCFTab_UpdateColors',
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
	'FCF_FadeOutChatFrame',
	function(chatFrame)
		local frameName = chatFrame:GetName()
		local chatTab = _G[frameName .. 'Tab']
		local tabGlow = _G[frameName .. 'TabGlow']
		if not tabGlow:IsShown() then
			if frameName.isDocked then
				securecall('UIFrameFadeOut', chatTab, CHAT_FRAME_FADE_OUT_TIME, chatTab:GetAlpha(), CHAT_FRAME_TAB_NORMAL_NOMOUSE_ALPHA)
			else
				securecall('UIFrameFadeOut', chatTab, CHAT_FRAME_FADE_OUT_TIME, chatTab:GetAlpha(), CHAT_FRAME_TAB_NORMAL_NOMOUSE_ALPHA)
			end
		end
	end
)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Modify the chat tabs ---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local function SkinTab(self)
	local chat = _G[self]
	local font, _, _ = chat:GetFont()

	local tab = _G[self .. 'Tab']
	for i = 1, select('#', tab:GetRegions()) do
		local texture = select(i, tab:GetRegions())
		if texture and texture:GetObjectType() == 'Texture' then
			texture:SetTexture(nil)
		end
	end

	local tabText = _G[self .. 'TabText']
	tabText:SetJustifyH('CENTER')
	tabText:SetWidth(60)
	tabText:SetFont(font, xVermin.Config.Chat.tab.fontSize)
	tabText:SetShadowOffset(1, -1)

	local a1, a2, a3, a4, a5 = tabText:GetPoint()
	tabText:SetPoint(a1, a2, a3, a4, 1)

	local s1, s2, s3 = unpack(xVermin.Config.Chat.tab.specialColor)
	local e1, e2, e3 = unpack(xVermin.Config.Chat.tab.selectedColor)
	local n1, n2, n3 = unpack(xVermin.Config.Chat.tab.normalColor)

	local tabGlow = _G[self .. 'TabGlow']
	hooksecurefunc(
		tabGlow,
		'Show',
		function()
			tabText:SetTextColor(s1, s2, s3, CHAT_FRAME_TAB_NORMAL_MOUSEOVER_ALPHA)
		end
	)

	hooksecurefunc(
		tabGlow,
		'Hide',
		function()
			tabText:SetTextColor(n1, n2, n3)
		end
	)

	tab:SetScript(
		'OnEnter',
		function()
			tabText:SetTextColor(s1, s2, s3, tabText:GetAlpha())
			tab:SetAlpha(1)
		end
	)

	tab:SetScript(
		'OnLeave',
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
		'Show',
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
-- Modify the editbox -----------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if not ChatFrame1EditBox.SetBackdrop then
	Mixin(ChatFrame1EditBox, BackdropTemplateMixin)
end
ChatFrame1EditBox:SetAltArrowKeyMode(false)
ChatFrame1EditBox:ClearAllPoints()
ChatFrame1EditBox:SetPoint('BOTTOMLEFT', ChatFrame1, 'TOPLEFT', 2, 35)
ChatFrame1EditBox:SetPoint('BOTTOMRIGHT', ChatFrame1, 'TOPRIGHT', 0, 35)
ChatFrame1EditBox:SetBackdrop(
	{
		bgFile = 'Interface\\Buttons\\WHITE8x8',
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
ChatFrame1EditBox:SetBeautyBorderTexture('white')

hooksecurefunc(
	'ChatEdit_UpdateHeader',
	function(editBox)
		local type = editBox:GetAttribute('chatType')
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
	'(https://%S+%.%S+)',
	'(http://%S+%.%S+)',
	'(www%.%S+%.%S+)',
	'(%d+%.%d+%.%d+%.%d+:?%d*/?%S*)'
}

local SetHyperlink = _G.ItemRefTooltip.SetHyperlink
function _G.ItemRefTooltip:SetHyperlink(link, ...)
	if link and (strsub(link, 1, 3) == 'url') then
		local editbox = ChatEdit_ChooseBoxForSend()
		ChatEdit_ActivateChat(editbox)
		editbox:Insert(string.sub(link, 5))
		editbox:HighlightText()
		return
	end
	SetHyperlink(self, link, ...)
end
