local _, xVermin = ...

local messages = {
	"Ability is not ready yet",
	"Another action is in progress",
	"Can't attack while mounted",
	"Can't do that while moving",
	"Item is not ready yet",
	"Not enough",
	"Nothing to attack",
	"Spell is not ready yet",
	"You have no target",
	"You can't do that yet",
	"There is nothing to attack.",
	"You are too far away!",
	"Out of range",
	"You are facing the wrong way",
	"Target too close",
	"You are in combat",
	"Someone is already looting that corpse.",
	"Must have a Shield equipped",
	"Interrupted",
	"Unknown unit",
	"You can't use that item.",
	"That ability requires combo points",
}

local old_uierrosframe_addmessage
local lastErrorTime = {}

local filter_error_messages = function()
	old_uierrosframe_addmessage = UIErrorsFrame.AddMessage
	UIErrorsFrame.AddMessage = uierrorsframe_addmessage
	local font = xVermin.Config.font.coalition
	UIErrorsFrame:SetFont(font, 36, "OUTLINE")
	UIErrorsFrame:SetShadowColor(0, 0, 0, 1)
	UIErrorsFrame:SetShadowOffset(1, -1)
	UIErrorsFrame:SetWidth(UIErrorsFrame:GetWidth() * 1.5)
end

function uierrorsframe_addmessage(frame, text, red, green, blue, id)
	if text then
		local now = GetTime()
		if lastErrorTime[text] and (now - lastErrorTime[text]) < 1 then
			return
		end
		lastErrorTime[text] = now
		local color = text:match("%d+/%d+") and _G.GREEN_FONT_COLOR_CODE or _G.RED_FONT_COLOR_CODE
		ChatFrame7:AddMessage(color .. text)
	end
	for i, v in ipairs(messages) do
		if text and text:match(v) then
			return
		end
	end
	local displayText = text
	local x, y = text:match("(%d+)/(%d+)")
	if x and y then
		local ratio = tonumber(x) / tonumber(y)
		local cr, cg, cb
		if ratio >= 1 then
			cr, cg, cb = 0, 255, 0
		else
			cr, cg, cb = 255, 255, math.floor(128 * (1 - ratio))
		end
		displayText = text:gsub("%s*(%d+)/(%d+)", function(a, b)
			return string.format("\n|cFF%02X%02X%02X%s/%s|r", cr, cg, cb, a, b)
		end)
	end
	old_uierrosframe_addmessage(frame, displayText, red, green, blue, id)
end

filter_error_messages()
