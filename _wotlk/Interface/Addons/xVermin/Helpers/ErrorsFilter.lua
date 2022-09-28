local _, xVermin = ...

-- local messages = {
-- 	'Ability is not ready yet',
-- 	'Another action is in progress',
-- 	"Can't attack while mounted",
-- 	"Can't do that while moving",
-- 	'Item is not ready yet',
-- 	'Not enough',
-- 	'Nothing to attack',
-- 	'Spell is not ready yet',
-- 	'You have no target',
-- 	"You can't do that yet",
-- 	'There is nothing to attack.',
-- 	'You are too far away!',
-- 	'Out of range',
-- 	'You are facing the wrong way',
-- 	'Target too close',
-- 	'You are in combat',
-- 	'Someone is already looting that corpse.',
-- 	'Must have a Shield equipped'
-- }

-- local enable
-- local onevent
-- local uierrorsframe_addmessage
-- local old_uierrosframe_addmessage

-- function enable()
-- 	old_uierrosframe_addmessage = UIErrorsFrame.AddMessage
-- 	UIErrorsFrame.AddMessage = uierrorsframe_addmessage
-- end

-- function uierrorsframe_addmessage(frame, text, red, green, blue, id)
-- 	print(text)
-- 	for i, v in ipairs(messages) do
-- 		if text and text:match(v) then
-- 			return
-- 		end
-- 	end
-- 	old_uierrosframe_addmessage(frame, text, red, green, blue, id)
-- end

-- local frame = CreateFrame('Frame')
-- frame:SetScript(
-- 	'OnEvent',
-- 	function()
-- 		enable()
-- 	end
-- )
-- frame:RegisterEvent('PLAYER_LOGIN')

-- local frame = CreateFrame('Frame')
-- frame:SetScript(
-- 	'OnEvent',
-- 	function(self, event, isInitialLogin, isReloadingUi)
-- 		if event == 'PLAYER_REGEN_DISABLED' then
-- 			UIErrorsFrame:Hide()
-- 		else
-- 			UIErrorsFrame:Show()
-- 		end
-- 	end
-- )
-- frame:RegisterEvent('PLAYER_REGEN_ENABLED')
-- frame:RegisterEvent('PLAYER_REGEN_DISABLED')

local blacklist = {
	[SPELL_FAILED_NOT_IN_CONTROL] = true,
	[SPELL_FAILED_NOT_ON_TAXI] = true,
	[SPELL_FAILED_NOT_MOUNTED] = true,
	[SPELL_FAILED_NO_ENDURANCE] = true,
	[INTERRUPTED] = false,
	[ERR_ABILITY_COOLDOWN] = true,
	[ERR_ATTACK_CHANNEL] = false,
	[ERR_ATTACK_CHARMED] = false,
	[ERR_ATTACK_CONFUSED] = false,
	[ERR_ATTACK_DEAD] = false,
	[ERR_ATTACK_FLEEING] = false,
	[ERR_ATTACK_MOUNTED] = true,
	[ERR_ATTACK_PACIFIED] = false,
	[ERR_ATTACK_STUNNED] = false,
	[ERR_AUTOFOLLOW_TOO_FAR] = false,
	[ERR_BADATTACKFACING] = false,
	[ERR_BADATTACKPOS] = true,
	[ERR_CLIENT_LOCKED_OUT] = false,
	[ERR_GENERIC_NO_TARGET] = true,
	[ERR_GENERIC_NO_VALID_TARGETS] = true,
	[ERR_GENERIC_STUNNED] = false,
	[ERR_INVALID_ATTACK_TARGET] = true,
	[ERR_ITEM_COOLDOWN] = true,
	[ERR_NOEMOTEWHILERUNNING] = false,
	[ERR_NOT_IN_COMBAT] = false,
	[ERR_NOT_WHILE_DISARMED] = false,
	[ERR_NOT_WHILE_FALLING] = false,
	[ERR_NOT_WHILE_MOUNTED] = false,
	[ERR_NO_ATTACK_TARGET] = true,
	[ERR_OUT_OF_ENERGY] = true,
	[ERR_OUT_OF_FOCUS] = true,
	[ERR_OUT_OF_MANA] = true,
	[ERR_OUT_OF_RAGE] = true,
	[ERR_OUT_OF_RANGE] = true,
	[ERR_OUT_OF_RUNES] = true,
	[ERR_OUT_OF_RUNIC_POWER] = true,
	[ERR_OUT_OF_HOLY_POWER] = true,
	[SPELL_FAILED_CUSTOM_ERROR_153] = true,
	[ERR_SPELL_COOLDOWN] = true,
	[ERR_SPELL_OUT_OF_RANGE] = false,
	[ERR_TOO_FAR_TO_INTERACT] = false,
	[ERR_USE_BAD_ANGLE] = false,
	[ERR_USE_CANT_IMMUNE] = false,
	[ERR_USE_TOO_FAR] = false,
	[SPELL_FAILED_BAD_IMPLICIT_TARGETS] = true,
	[SPELL_FAILED_BAD_TARGETS] = true,
	[SPELL_FAILED_CASTER_AURASTATE] = false,
	[SPELL_FAILED_NO_COMBO_POINTS] = true,
	[SPELL_FAILED_SPELL_IN_PROGRESS] = true,
	[SPELL_FAILED_TARGET_AURASTATE] = true,
	[SPELL_FAILED_MOVING] = false,
	[SPELL_FAILED_UNIT_NOT_INFRONT] = false
}
-- function mod:UI_ERROR_MESSAGE(error)
-- 	if not blacklist[error] then
-- 		UIErrorsFrame:AddMessage(error, 1, .1, .1)
-- 	end
-- end
-- mod:RegisterEvent('UI_ERROR_MESSAGE')
-- UIErrorsFrame:UnregisterEvent('UI_ERROR_MESSAGE')

local UIErrorsFrame_OnEvent = UIErrorsFrame:GetScript('OnEvent')
UIErrorsFrame:SetScript(
	'OnEvent',
	function(self, event, error, ...)
		if event == 'UI_ERROR_MESSAGE' and blacklist[error] then
			return
		end
		UIErrorsFrame_OnEvent(self, event, error, ...)
	end
)
