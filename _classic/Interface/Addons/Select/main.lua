-- main.lua handles login/logout and event coordination

--[[
    Each macro with "/select [condition] list1; list2" is automatically given a "/click [btn:2]S000M;S000A".
    The /select command itself does nothing except describe what happens when the S000M;S000A buttons are clicked.
    - If the macro is right-clicked, it will /click S000M (menu) and summon a flyout at $cursor.
    - (Clicking a button in the flyout will copy its attributes to S000A.)
    - If the macro is otherwise used, it will /click S000A (action) and use whatever was last selected.

    Flyouts are made for each possible lists across all /select macros. For instance:
    /select [exists] item1, item2; item3, spell1
    has two lists: "item1, item2" and "item3, spell1". Many macros can share a common list. When a menu
    is /clicked, it will get this flyout, parent it to itself, and display it at $cursor.

    [condition]s are handled by a state driver at the menu level. When a state changes, the menu will
    grab the currently-selected attributes of the flyout for that state and copy them to the action (S000A);
    so that as states change, the action changes with the state based on what was last selected.

    The secure s.main.frame heiarchy is built/updated in this structure: root <- action <- menu <~ flyout <- button
    - Actions are always parented to root.
    - Menus are always parented to actions.
    - Flyouts have no consistent parent and are re-parented to the menu they're summoned from.
    - Flyout buttons are always parented to their flyout.

    It's important for a flyout to get parented to menu when summoned; this allows attributes from a clicked
    flyout button to copy up the parent chain to the action which is being selected. (Making separate flyouts
    for each menu would still require a way to restore saved selects for each flyout--because macros can
    change their index quite often, the saved reference would still need to be by list and there would be
    no benefit gained at the expense of potentially extra flyouts.)

    The heiarchy is stored in these tables:
    - s.root <- parent s.main.frame that contains settings as attributes and flyout s.main.frame references
    - s.root.actions[index] <- indexed by macro index, the S000A button /clicked in a select macro
    - s.root.actions[index].menu <- the S000M button /clicked in a select macro, contains the state driver for [conditions]
    - s.root.flyouts[list] <- indexed by state lists ("item, item, spell" or "spell:heal"), a flyout for each state list
    - s.root.flyouts[list].buttons[i] <- list of buttons on the flyout

    The flyouts' buttons placement and attributes can only be changed out of combat. They are populated:
    - On login from percharacter savedvars (SelectPerCharacterSettings) (*)
    - When a menu is /clicked out of combat
    - At the start of combat (to get most up-to-date entries while flyouts can change)
    (*) Note: if the same list is used in multiple macros, the last-selected item or spell is saved to the list.
    On the next login, all macros that use that list will load that same selected item or spell.

    Flyout icons and cooldowns are updated out of combat and happen in the flyout's OnShow.

    Action bar icons are updated out of combat via SetMacroItem and SetMacroSpell and happen in response to attributes
    changing. Neither SetMacroItem nor SetMacroSpell can set icons for battle pets, so the Revive Battle Pets icon is
    used in place of all battle pets and battle pets remain unofficially supported. (This limitation is incidentally why
    equipsets and other swappable things are not supported; there's no way to change their icon without directly
    referencing the action button's icon.)
]]
local _, s = ...
s.main = {}
_Select = s

local macrosEditedDuringCombat  -- becomes true during combat when a macro is potentially edited

--[[ event handling ]]
s.main.frame = CreateFrame("Frame")
s.main.frame:SetScript(
	"OnEvent",
	function(self, event, ...)
		if s.main[event] then
			s.main[event](self, ...)
		end
	end
)

-- register login event to kick everything off
s.main.frame:RegisterEvent("PLAYER_LOGIN")

--[[ events ]]
-- fires once on login to set up savedvars, register for events, and start updating macros to create secure s.main.frames
function s.main:PLAYER_LOGIN()
	s.settings:Load()
	s.main.frame:RegisterEvent("UPDATE_MACROS")
	s.main.frame:RegisterEvent("PLAYER_REGEN_DISABLED")
	s.main.frame:RegisterEvent("PLAYER_REGEN_ENABLED")
	s.main.frame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")

	-- for now all caches are enabled from the start to improve reliability. note: moving this to an independent
	-- PLAYER_LOGIN from s.cache will often mean these caches will be empty/not enabled when first queried in this
	-- execution path. messing with this will require extensive testing with deleted saved variables!
	s.cache:Enable("item")
	s.cache:Enable("spell")
	s.cache:Enable("mount")
	s.cache:Enable("toy")

	s.main:UPDATE_MACROS() -- pretend event just fired; could've logged into combat and need to handle it
	s.root:FillMissing() -- after first pass of secure s.main.frames being set up, look for missing flyouts/actions (savedvars maybe wiped?)
end

-- fires when selecting macros in the macro edit window or closing the macro window; the macros and secure s.main.frames may need updating
function s.main:UPDATE_MACROS()
	if not InCombatLockdown() then
		macrosEditedDuringCombat = nil
		s.macro:UpdateAllMacros()
		s.root:UpdateSecureFrames()
	else
		macrosEditedDuringCombat = true
	end
end

-- fires when entering combat; fill flyouts so they're the most up-to-date when used during combat
function s.main:PLAYER_REGEN_DISABLED()
	s.flyout:FillAll()
	if s.options:IsVisible() then
		s.options:EnableSettings(false)
	end
end

-- fires when leaving combat; if any macro edits were made during combat, now they can be processed
function s.main:PLAYER_REGEN_ENABLED()
	-- if macros were edited during combat, then return to process them after leaving combat
	if macrosEditedDuringCombat then
		s.main:UPDATE_MACROS()
	end
	if s.options:IsVisible() then
		s.options:EnableSettings(true)
	end
end

-- fires after player equipment changes; equipslot macros icons update after the item in the slot changes and not during select
function s.main:PLAYER_EQUIPMENT_CHANGED()
	if s.cache:IsEnabled("item") then -- only fire if item cache is running; todo: flag specific macros that have a /use
		s.macro:UpdateAllIcons()
	end
end

-- the /select slash command actually does nothing and doesn't need to exist, but adding one to summon options
-- if no parameters given
SlashCmdList["SELECT"] = function(msg)
	if (msg or ""):trim() == "" then
		InterfaceOptionsFrame_Show()
		InterfaceOptionsFrame_OpenToCategory("Select")
	end
end
SLASH_SELECT1 = "/select"
