--[[
	QuestReward
	v1.3.7
	
	Revision: $Id: main.lua 20 2014-12-08 12:24:54 PST Kjasi $
]]
local kjl = LibStub('LibKjasi-1.0')
local Version = '1.3.7'
local DebugMode = 0
local QLevelMessage = false
local MaxLevel = MAX_PLAYER_LEVEL_TABLE[GetExpansionLevel()]

local TempSell = nil --Watto_Version, Watto_TempSell
local BuyNowItems = {
	44812, -- Turkey Shooter (Pimgrim's Bounty reward item)
	45724 -- Argent Tournament Champion's Purse
}

-- Localization
-- Included here, since it's currently limited.
QUESTREWARD_TITLE = 'QuestReward'
QUESTREWARD_CURRENTMODE = 'QuestReward is currently %s.'
QUESTREWARD_QLEVEL = "QuestReward's current Quest Level Limit is %i."
QUESTREWARD_QLEVEL_MODE = "QuestReward's Quest Level Limit is currently %s."
QUESTREWARD_QLEVEL_CHANGED = 'QuestReward will now only effect quests that are %i levels or lower than your character.'
QUESTREWARD_QLIMITED = 'Quest level limit was reached. Type "/qr questlvl off" to re-enable QuestReward for all Quests.'
QUESTREWARD_QLLINVALID = 'Invalid input for Quest Level Limit. Please enter a number.'

-- Setup our addon with KjasiLib
kjl:setupAddon(
	{
		['Name'] = QUESTREWARD_TITLE,
		['Version'] = Version,
		['MsgStrings'] = {
			['Default'] = LIGHTYELLOW_FONT_COLOR_CODE .. '%s: |r%s',
			['debug'] = GREEN_FONT_COLOR_CODE .. '%s Debug: |r%s',
			['error'] = RED_FONT_COLOR_CODE .. '%s Error: |r%s'
		},
		['ChannelLevel'] = DebugMode
	}
)

-- Defaults
QuestReward_Defaults = {
	['Options'] = {
		['Version'] = Version,
		['MasterOnOff'] = 'on',
		['QLevelOnOff'] = 'on',
		['QLevel'] = 3
	}
}

-- Load Function
function QuestReward_Load(self)
	-- Event Registration
	self:RegisterEvent('ADDON_LOADED')
	self:RegisterEvent('QUEST_COMPLETE')
	self:RegisterEvent('QUEST_FINISHED')
	self:RegisterEvent('QUEST_ACCEPT_CONFIRM')
	self:RegisterEvent('QUEST_ITEM_UPDATE')
	self:RegisterEvent('QUEST_PROGRESS')

	-- Hooks
	hooksecurefunc('QuestInfoItem_OnClick', QuestReward_PressButton)

	-- Slash Commands
	SLASH_QuestReward1 = '/questreward'
	SLASH_QuestReward2 = '/qr'
	SlashCmdList['QuestReward'] = QuestReward_commandline
end

function QuestReward_Msg(message)
	kjl:Msg(QUESTREWARD_TITLE, message)
end

function QuestReward_Events(self, event, ...)
	if (event == 'ADDON_LOADED') then
		QuestReward_Loaded(self)
		self:UnregisterEvent('ADDON_LOADED')
	elseif (event == 'QUEST_COMPLETE') then
		QuestReward_ChooseItem(self)
	elseif (event == 'QUEST_FINISHED') then
		if (TempSell ~= nil) and (Watto_TempSell) then
			Watto_TempSell[TempSell] = 1
		end
	end
end

function QuestReward_Loaded(self)
	if (not QuestReward_Options) or (not QuestReward_Options['Version']) then
		QuestReward_Options = QuestReward_Defaults['Options']
	end

	if (QuestReward_Options['Version'] < Version) then
		QuestReward_Options = kjl:UpdateDatabase(QuestReward_Options, QuestReward_Defaults['Options'])
	end
end

function QuestReward_ChooseItem(self)
	local items = {}
	local num = GetNumQuestChoices()
	local sel, selp = 1, 0 -- default to first button in case none of the items have sell values.

	if (num <= 0) or (QuestReward_Options['MasterOnOff'] == 'off') then
		return
	end

	if (UnitLevel('player') < MaxLevel) then
		if (QuestReward_Options['QLevelOnOff'] == 'on') then
			local plvl = UnitLevel('player')
			local qid = GetQuestID()
			local qlink = GetQuestLink(qid)
			local _, _, qlvl = kjl:getIDNumber(qlink)
			if (qlvl <= (qlvl - tonumber(QuestReward_Options['QLevel']))) then
				if (QLevelMessage == false) then
					QuestReward_Msg(QUESTREWARD_QLIMITED)
					QLevelMessage = true
				end
				return
			end
		end
	end

	for x = 1, num do
		local link = GetQuestItemLink('choice', x)
		if (not link) then
			kjl:Timer(
				QUESTREWARD_TITLE,
				'RestartScan',
				1,
				function(self)
					return QuestReward_ChooseItem(self)
				end
			)
			return
		end
		local _, _, _, _, _, _, _, _, _, _, ISP = GetItemInfo(link)
		for k, v in pairs(BuyNowItems) do
			local a = kjl:getIDNumber(link)
			a = tonumber(a)
			if (a == v) then
				QuestReward_SelectItem(self, x)
				return
			end
		end
		items[x] = ISP
	end

	for x = 1, num do
		if items[x] > selp then
			sel = x
			selp = items[x]
		end
	end

	QuestReward_SelectItem(self, sel)
end

function QuestReward_SelectItem(self, index)
	local btn = _G['QuestInfoRewardsFrameQuestInfoItem' .. index]
	if (btn.type == 'choice') then
		QuestInfoItemHighlight:SetPoint('TOPLEFT', btn, 'TOPLEFT', -8, 7)
		QuestInfoItemHighlight:Show()
		QuestInfoFrame.itemChoice = btn:GetID()

		local id = QuestReward_ReturnId(btn)

		while (id == nil) do
			id = kjl:Timer(QUESTREWARD_TITLE, 'WaitforID', 2, QuestReward_ReturnId, btn)
		end

		local bad = false
		for k, v in pairs(BuyNowItems) do
			if (id == v) then
				bad = true
				break
			end
		end
		if (bad ~= true) then
			TempSell = id
		end
	end
end

function QuestReward_PressButton(self)
	TempSell = nil
end

function QuestReward_ItemID(link)
	if (strfind(link, ':') == nil) then
		return
	end

	local justItemId = string.gsub(link, '.-\124H([^\124]*)\124h.*', '%1')
	local _, itemid = strsplit(':', justItemId)

	return tostring(itemid)
end

function QuestReward_ReturnId(btn)
	return kjl:getIDNumber(GetQuestItemLink('choice', btn:GetID()))
end

function QuestReward_commandline(cmd)
	cmd = strlower(cmd)

	if (cmd == 'off') then
		QuestReward_Options['MasterOnOff'] = 'off'
		QuestReward_Msg(format(QUESTREWARD_CURRENTMODE, QuestReward_Options['MasterOnOff']))
	elseif (cmd == 'on') then
		QuestReward_Options['MasterOnOff'] = 'on'
		QuestReward_Msg(format(QUESTREWARD_CURRENTMODE, QuestReward_Options['MasterOnOff']))
	elseif (cmd == 'questlvl off') or (cmd == 'qll off') then
		QuestReward_Options['QLevelOnOff'] = 'off'
		QuestReward_Msg(format(QUESTREWARD_QLEVEL, QuestReward_Options['QLevelOnOff']))
	elseif (cmd == 'questlvl on') or (cmd == 'qll on') then
		QuestReward_Options['QLevelOnOff'] = 'on'
		QuestReward_Msg(format(QUESTREWARD_QLEVEL, QuestReward_Options['QLevelOnOff']))
	elseif (cmd == 'questlvl default') then
		QuestReward_Options['QLevel'] = QuestReward_Defaults['Options']['QLevel']
		QuestReward_Msg(format(QUESTREWARD_QLEVEL_CHANGED, QuestReward_Options['QLevel']))
	elseif (string.find(cmd, 'questlvl')) then
		local input = string.find(cmd, 'questlvl')
		local a = strsub(cmd, input, input + strlen('questlvl'))
		local level = string.gsub(cmd, a, '')
		level = tonumber(level)
		if (level == nil) then
			QuestReward_Msg(QUESTREWARD_QLLINVALID, 'error')
			return
		end
		QuestReward_Options['QLevel'] = level
		QuestReward_Msg(format(QUESTREWARD_QLEVEL_CHANGED, QuestReward_Options['QLevel']))
	else
		QuestReward_Msg(format(QUESTREWARD_CURRENTMODE, QuestReward_Options['MasterOnOff']))
		QuestReward_Msg(format(QUESTREWARD_QLEVEL_MODE, QuestReward_Options['QLevelOnOff']))
		QuestReward_Msg(format(QUESTREWARD_QLEVEL, QuestReward_Options['QLevel']))
	end
end
