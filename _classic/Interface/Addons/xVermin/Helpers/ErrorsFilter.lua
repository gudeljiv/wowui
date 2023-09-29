local _, xVermin = ...

local messages = {
	'Ability is not ready yet',
	'Another action is in progress',
	"Can't attack while mounted",
	"Can't do that while moving",
	'Item is not ready yet',
	'Not enough',
	'Nothing to attack',
	'Spell is not ready yet',
	'You have no target',
	"You can't do that yet",
	'There is nothing to attack.',
	'You are too far away!',
	'Out of range',
	'You are facing the wrong way',
	'Target too close',
	'You are in combat',
	'Someone is already looting that corpse.',
	'Must have a Shield equipped',
	'Interrupted',
	'Unknown unit',
	"You can't use that item."
}

local old_uierrosframe_addmessage

local filter_error_messages = function()
	old_uierrosframe_addmessage = UIErrorsFrame.AddMessage
	UIErrorsFrame.AddMessage = uierrorsframe_addmessage
end

function uierrorsframe_addmessage(frame, text, red, green, blue, id)
	for i, v in ipairs(messages) do
		if text and text:match(v) then
			ChatFrame7:AddMessage(_G.RED_FONT_COLOR_CODE .. text)
			return
		end
	end
	old_uierrosframe_addmessage(frame, text, red, green, blue, id)
end

filter_error_messages()
