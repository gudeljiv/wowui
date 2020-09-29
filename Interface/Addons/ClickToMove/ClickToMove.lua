-- Title: ClickToMove -- Desc: Control the Click-To-Move option setting
-- Author: Awlduhrage of Wyrmrest Accord
-- Version: 1.0.0
-- -- Initial Version
-- Version 1.1.0
-- -- User can choose whether to have CTM on or off during battle
-- -- User can choose the default CTM during battle for new toons
-- -- Cleaned up the code a bit.
-- -- Added status command ("?")
-- -- Added help command ("help")
local version = "1.1.0"

-- Sadly, Blizzard does not provide a deterministic method of reporting that a character has entered/left combat.
-- The "regen" events are used, however, there is no telling if there is a "1 to 1" relation with combat, that is
-- are these "regen" events reported for EVERY combat event, and ONLY for combat events?  It could change in the
-- future, somebody (maybe me) is not thinking.
-- I given these events names that indicate the purpose for which they are being used.
local ENTERING_COMBAT = "PLAYER_REGEN_DISABLED"
local LEAVING_COMBAT = "PLAYER_REGEN_ENABLED"
local ADDON_LOADED = "ADDON_LOADED"

-- Should move the frame "code" from the XML file to this LUA file

-- This is the slash command, "/ctm" is aliased below
local CTM = "/ctm"
local saved_state
local verbose = true -- enables disabling spam control

function ctm_OnLoad()
	SLASH_CLICKTOMOVE1 = CTM
	ClickToMoveFrame:SetScript("OnEvent", ctm_OnEvent)
	ClickToMoveFrame:RegisterEvent(ENTERING_COMBAT)
	ClickToMoveFrame:RegisterEvent(LEAVING_COMBAT)
	ClickToMoveFrame:RegisterEvent(ADDON_LOADED)
end

function ctm_OnEvent(self, event, ...)
	local for_who = ...

	if (for_who ~= null) then
		if (for_who ~= "ClickToMove") then
			return
		end
	else
		for_who = "<ctm>" -- This came in nil on occasion
	end

	if (event == ENTERING_COMBAT) then
		--	if (saved_state != ctm_combat_char) then
		-- debating reporting that the CTM value changed
		--	end
		saved_state = get_ctm()
		set_ctm(ctm_combat_char)
	elseif (event == LEAVING_COMBAT) then
		set_ctm(saved_state)
	elseif (event == ADDON_LOADED) then
		if (ctm_combat_global == nil) then
			ctm_combat_global = false
			print("CTM Creating default combat flag: " .. get_on_or_off(ctm_combat_global) .. " during combat")
		end

		if (ctm_combat_char == nil) then
			ctm_combat_char = ctm_combat_global
			print("CTM Creating character combat to " .. get_on_or_off(ctm_combat_char) .. " during combat")
		end

		if (ctm_spam == nil) then
			ctm_spam = true
		end

		saved_state = get_ctm()
		print("Click-to-move V" .. version .. " loaded, " .. CTM .. " help")
	else -- Only occurs if an event was added without support here.
		print(CTM .. ": Internal error: '" .. event .. "'")
	end
end

-- Syntax:  ctm  [on|off]
function SlashCmdList.CLICKTOMOVE(msg)
	local state
	if (not (msg ~= nil and msg ~= "")) then
		set_ctm(not get_ctm())
		ctm_status_message()
	elseif (string.find(msg, "?")) then -- This is cheezy, but the string:match function is "broken".
		print_status()
	else
		msg = string.lower(msg)
		words = {}
		-- Need the index to know if there are more words on the command line.  (this is cheezy)
		for word in msg:gmatch("%w+") do
			tinsert(words, word)
		end

		-- I don't like the parser, either.
		for index = 1, #words do
			word = words[index]
			if (word == "on" or word == "off") then
				state = (word == "on")
				if (index == #words) then
					set_ctm(state)
					ctm_status_message()
				end
			elseif (word == "combat") then
				ctm_combat_char = state
				ctm_combat_status_message()
			elseif (word == "default") then
				ctm_combat_global = state
				print("Default Combat flag to " .. get_on_or_off(state))
			elseif (word == "spam") then
				ctm_spam = state
				verbose = ctm_spam
				ctm_spam_status_message()
			elseif (word == "help") then
				print_help()
				return
			else
				print(CTM .. ": '" .. msg .. "' not recognized, try " .. CTM .. " help")
				return
			end
		end
	end
end

-- LUA does not treat 0 or "0" as false, so map integer values into boolean
function set_ctm(on_or_off)
	SetCVar("AutoInteract", on_or_off and "1" or "0")
end
function get_ctm()
	return GetCVar("AutoInteract") == "1"
end

function ctm_status_message()
	print("Click-to-move is now " .. get_on_or_off(get_ctm()))
end

function ctm_combat_status_message()
	print("Click-to-move will be " .. get_on_or_off(ctm_combat_char) .. " during combat")
end

function get_on_or_off(flag)
	return (flag and "ON" or "OFF")
end

function ctm_spam_status_message()
	DEFAULT_CHAT_FRAME:AddMessage("Click-to-move is " .. (ctm_spam and "printing changes in status" or "silent"))
end

-- Isolate all print() calls in the event they get tweeked
function print(text)
	if (verbose) then
		DEFAULT_CHAT_FRAME:AddMessage(text)
	end
end

function print_status()
	verbose = true
	ctm_status_message()
	ctm_combat_status_message()
	print("Click-to-move messages (spam) are " .. (ctm_spam and "ENABLED" or "DISABLED"))
	print("Click-to-move default in-combat flag is " .. (ctm_combat_global and "ON" or "OFF"))
	verbose = ctm_spam
end

function print_help()
	verbose = true
	print("Click to Move, version " .. version)
	print(CTM .. " control the Click-To-Move setting")
	print("   " .. CTM .. " - toggles Click-To-Move on and off")
	print("   " .. CTM .. " {on|off} - turns Click-To-Move on or off")
	print("   " .. CTM .. " {on|off} combat - Sets Click-To-Move state during combat")
	print("   " .. CTM .. " {on|off} default - Sets default 'combat' mode for new toons")
	print("   " .. CTM .. " ?  - print current state")
	print("Serving Suggestion: put '/ctm' in a macro, drag the macro to an ActionBar")
	print("Click-to-Move is found in the Mouse section of the options dialog.")
	verbose = ctm_spam
end
