local _, xVermin = ...

local type = 8
local mark = false

local function ClearMark()
	if not UnitInParty('player') then
		for i = 0, 8 do
			SetRaidTarget('player', i)
		end
		SetRaidTarget('player', 0)
	end
end

local function SetMark()
	if mark then
		ClearMark()
		local faction = 'nil'
		if TargetFrame:IsShown() then
			faction, _ = UnitFactionGroup('target')

			if faction ~= 'Alliance' then
				-- if (UnitInParty("player") and UnitIsGroupLeader("player")) then
				-- 	SetRaidTarget("target", type)
				-- end
				if (not UnitInParty('player')) then
					SetRaidTarget('target', type)
				end
			end
		end
	end
end

local function ToggleMark()
	mark = not mark
	ClearMark()
end

local frame = CreateFrame('Frame')
frame:RegisterEvent('PLAYER_TARGET_CHANGED')
frame:SetScript('OnEvent', SetMark)

ClearMark()

SLASH_SETMARK1 = '/mark'
SlashCmdList['SETMARK'] = ToggleMark
