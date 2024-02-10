local _, xVermin = ...

local function FixBindings()
	SetBinding('A', 'STRAFELEFT', 1)
	SetBinding('D', 'STRAFERIGHT', 1)
	SetBinding('Q', 'TOGGLEAUTORUN', 1)
	SetBinding('PAGEUP', 'CAMERAZOOMIN', 1)
	SetBinding('PAGEDOWN', 'CAMERAZOOMOUT', 1)
	SetBinding('UPARROW', 'CAMERAZOOMIN', 1)
	SetBinding('DOWNARROW', 'CAMERAZOOMOUT', 1)
	SetBinding('CTRL-SHIFT-V', 'NAMEPLATES', 1)
	SetBinding('ALT-SHIFT-V', 'FRIENDNAMEPLATES', 1)
	SetBinding('CTRL-F', 'FOLLOWTARGET', 1)
	SetBinding('¸', 'TARGETNEARESTENEMY', 1)
	SetBinding('SHIFT-F', 'FOCUSTARGET', 1)
	SetBinding('SHIFT-P', 'TOGGLECHARACTER4', 1)

	SetBinding('CTRL-G', 'TOGGLEGROUPFINDER', 1)
	SetBinding('CTRL-G', 'TOGGLELFGPARENT', 1)
	SetBinding('CTRL-Y', 'TOGGLEACHIEVEMENT', 1)
	SetBinding('CTRL-SHIFT-M', 'TOGGLEMOUNTJOURNAL', 1)
	SetBinding('CTRL-SHIFT-C', 'TOGGLECOMPANIONJOURNAL', 1)
	SetBinding('CTRL-SHIFT-P', 'TOGGLEPETJOURNAL', 1)

	-- SetBinding("L", "MONKEYQUEST_CLOSE", 1)
	SetBinding('L', 'TOGGLEQUESTLOG', 1)
	SetBinding('SHIFT-K', 'BAGNON_KEYS_TOGGLE', 1)
	SetBinding('', 'BAGNON_TOGGLE', 1)
	SetBinding('ð', 'BAGNON_BANK_TOGGLE', 1)

	-- if xVermin.Class == 'HUNTER' or xVermin.Class == 'WARLOCK' then
	SetBinding('CTRL-1', 'BONUSACTIONBUTTON1', 1)
	SetBinding('CTRL-2', 'BONUSACTIONBUTTON2', 1)
	SetBinding('CTRL-3', 'BONUSACTIONBUTTON3', 1)
	SetBinding('CTRL-4', 'BONUSACTIONBUTTON4', 1)
	SetBinding('CTRL-5', 'BONUSACTIONBUTTON5', 1)
	SetBinding('CTRL-6', 'BONUSACTIONBUTTON6', 1)
	SetBinding('CTRL-7', 'BONUSACTIONBUTTON7', 1)
	SetBinding('CTRL-8', 'BONUSACTIONBUTTON8', 1)
	SetBinding('CTRL-9', 'BONUSACTIONBUTTON9', 1)
	SetBinding('CTRL-0', 'BONUSACTIONBUTTON10', 1)
	-- else
	SetBinding('ALT-R', 'MULTIACTIONBAR2BUTTON6', 1)
	SetBinding('ALT-D', 'MULTIACTIONBAR2BUTTON7', 1)
	SetBinding('ALT-F', 'MULTIACTIONBAR2BUTTON8', 1)
	-- end
	SetBinding('Y', 'MULTIACTIONBAR2BUTTON11', 1)
	SetBinding('X', 'MULTIACTIONBAR2BUTTON12', 1)

	SetBinding('1', 'ACTIONBUTTON1', 1)
	SetBinding('2', 'ACTIONBUTTON2', 1)
	SetBinding('3', 'ACTIONBUTTON3', 1)
	SetBinding('4', 'ACTIONBUTTON4', 1)
	SetBinding('5', 'ACTIONBUTTON5', 1)
	SetBinding('6', 'ACTIONBUTTON6', 1)
	SetBinding('7', 'ACTIONBUTTON7', 1)
	SetBinding('8', 'ACTIONBUTTON8', 1)

	if xVermin.Class == 'MAGE' then
		SetBinding('SHIFT-MOUSEWHEELUP', 'NONE', 1)
		SetBinding('F9', 'NONE', 2)
	else
		SetBinding('SHIFT-MOUSEWHEELUP', 'ACTIONBUTTON9', 1)
		SetBinding('F9', 'ACTIONBUTTON9', 2)
	end

	SetBinding('TAB', 'ACTIONBUTTON10', 1)
	SetBinding('E', 'ACTIONBUTTON11', 1)
	SetBinding('F', 'ACTIONBUTTON12', 1)

	SetBinding('H', 'MULTIACTIONBAR1BUTTON1', 1)
	SetBinding('V', 'MULTIACTIONBAR1BUTTON2', 1)
	SetBinding('G', 'MULTIACTIONBAR1BUTTON3', 1)
	SetBinding('T', 'MULTIACTIONBAR1BUTTON4', 1)
	SetBinding('SHIFT-T', 'MULTIACTIONBAR1BUTTON5', 1)
	SetBinding('SHIFT-E', 'MULTIACTIONBAR1BUTTON6', 1)
	SetBinding('SHIFT-R', 'MULTIACTIONBAR1BUTTON7', 1)
	SetBinding('K', 'MULTIACTIONBAR1BUTTON8', 1)

	SetBinding('MOUSEWHEELDOWN', 'MULTIACTIONBAR2BUTTON1', 1)
	SetBinding('MOUSEWHEELUP', 'MULTIACTIONBAR2BUTTON2', 1)
	SetBinding('ALT-9', 'MULTIACTIONBAR2BUTTON3', 1)
	SetBinding('ALT-0', 'MULTIACTIONBAR2BUTTON4', 1)
	SetBinding('ALT-E', 'MULTIACTIONBAR2BUTTON5', 1)

	-- SetBinding("F1", "STANCEBUTTON1", 1)
	-- SetBinding("F2", "STANCEBUTTON2", 1)
	-- SetBinding("F3", "STANCEBUTTON3", 1)

	SetBinding('F1', 'MULTIACTIONBAR3BUTTON1', 1)
	SetBinding('F2', 'MULTIACTIONBAR3BUTTON2', 1)
	SetBinding('F3', 'MULTIACTIONBAR3BUTTON3', 1)
	SetBinding('F4', 'MULTIACTIONBAR3BUTTON4', 1)
	SetBinding('F5', 'MULTIACTIONBAR3BUTTON5', 1)
	SetBinding('F6', 'MULTIACTIONBAR3BUTTON6', 1)
	SetBinding('CTRL-F5', 'MULTIACTIONBAR3BUTTON8', 1)
	SetBinding('CTRL-F4', 'MULTIACTIONBAR3BUTTON9', 1)
	SetBinding('CTRL-F3', 'MULTIACTIONBAR3BUTTON10', 1)
	SetBinding('CTRL-F2', 'MULTIACTIONBAR3BUTTON11', 1)
	SetBinding('CTRL-F1', 'MULTIACTIONBAR3BUTTON12', 1)

	-- if xVermin.Class == 'HUNTER' or xVermin.Class == 'WARLOCK' then
	-- 	SetBinding('SHIFT-1', 'MULTIACTIONBAR4BUTTON1', 1)
	-- 	SetBinding('SHIFT-2', 'MULTIACTIONBAR4BUTTON2', 1)
	-- 	SetBinding('SHIFT-3', 'MULTIACTIONBAR4BUTTON3', 1)
	-- 	SetBinding('SHIFT-4', 'MULTIACTIONBAR4BUTTON4', 1)
	-- 	SetBinding('SHIFT-5', 'MULTIACTIONBAR4BUTTON5', 1)
	-- 	SetBinding('SHIFT-6', 'MULTIACTIONBAR4BUTTON6', 1)
	-- 	SetBinding('SHIFT-7', 'MULTIACTIONBAR4BUTTON7', 1)
	-- else
	SetBinding('ALT-1', 'MULTIACTIONBAR4BUTTON1', 1)
	SetBinding('ALT-2', 'MULTIACTIONBAR4BUTTON2', 1)
	SetBinding('ALT-3', 'MULTIACTIONBAR4BUTTON3', 1)
	SetBinding('ALT-4', 'MULTIACTIONBAR4BUTTON4', 1)
	SetBinding('ALT-5', 'MULTIACTIONBAR4BUTTON5', 1)
	SetBinding('ALT-6', 'MULTIACTIONBAR4BUTTON6', 1)
	SetBinding('ALT-7', 'MULTIACTIONBAR4BUTTON7', 1)
	-- end
	SetBinding('CTRL-B', 'MULTIACTIONBAR4BUTTON8', 1)
	SetBinding('CTRL-D', 'MULTIACTIONBAR4BUTTON9', 1)
	SetBinding('CTRL-H', 'MULTIACTIONBAR4BUTTON10', 1)
	SetBinding('CTRL-M', 'MULTIACTIONBAR4BUTTON11', 1)
	SetBinding('I', 'MULTIACTIONBAR4BUTTON12', 1)

	SetBinding('J', 'CLICK RingMenuToggleRing1:LeftButton', 1)
	SetBinding('ALT-G', 'Open/Close LFGBulletinBoard', 1)

	-- if UnitName("player") == "Konac" then
	-- 	SetBinding("CTRL-H", "NONE", 1)
	-- 	SetBinding("CTRL-M", "NONE", 1)
	-- 	SetBinding("ALT-X", "MULTIACTIONBAR2BUTTON10", 1)
	-- 	SetBinding("SHIFT-X", "MULTIACTIONBAR2BUTTON11", 1)
	-- 	SetBinding("X", "MULTIACTIONBAR2BUTTON12", 1)
	-- end

	-- for i = 6, 12 do
	-- 	SetBindingClick('CTRL-F' .. i, 'RingMenuRingFrame1Button' .. i)
	-- end
	-- SetBindingClick('SHIFT-R', 'RingMenuRingFrame1Button1', 1)
	SetBindingClick('SHIFT-S', 'RingMenuRingFrame1Button2', 1)
	SetBindingClick('ALT-S', 'RingMenuRingFrame1Button3', 1)

	-- SetBinding('CTRL-F1', 'EXTRABARBUTTON1', 1)
	-- SetBinding('CTRL-F2', 'EXTRABARBUTTON2', 1)
	-- SetBinding('CTRL-F3', 'EXTRABARBUTTON3', 1)
	-- SetBinding('CTRL-F4', 'EXTRABARBUTTON4', 1)
	-- SetBinding('CTRL-F5', 'EXTRABARBUTTON5', 1)
	-- SetBinding('CTRL-F6', 'EXTRABARBUTTON6', 1)
	-- SetBinding('CTRL-F7', 'EXTRABARBUTTON7', 1)
	-- SetBinding('CTRL-F8', 'EXTRABARBUTTON8', 1)
	-- SetBinding('CTRL-F9', 'EXTRABARBUTTON9', 1)
	-- SetBinding('CTRL-F10', 'EXTRABARBUTTON10', 1)
	-- SetBinding('CTRL-F11', 'EXTRABARBUTTON11', 1)
	-- SetBinding('CTRL-F12', 'EXTRABARBUTTON12', 1)
end

local function ClearAllBindings()
	-- local x = {}
	-- local y = 0
	-- for i = 0, 200 do
	-- 	key1, key2 = GetBindingKey(GetBinding(i))
	-- 	if key1 ~= nil then
	-- 		table.insert(x, key1)
	-- 	end
	-- 	if key2 ~= nil then
	-- 		table.insert(x, key2)
	-- 	end
	-- end
	-- for i = 1, table.getn(x) do
	-- 	-- SetBinding(x[i])
	-- end

	SetBinding('I', 'NONE', 1)
	SetBinding('K', 'NONE', 1)
	SetBinding('7', 'NONE', 1)
	SetBinding('8', 'NONE', 1)
	SetBinding('9', 'NONE', 1)
	SetBinding('0', 'NONE', 1)
	SetBinding('-', 'NONE', 1)
	SetBinding('=', 'NONE', 1)
	SetBinding('CTRL-1', 'NONE', 1)
	SetBinding('CTRL-2', 'NONE', 1)
	SetBinding('CTRL-3', 'NONE', 1)
	SetBinding('CTRL-4', 'NONE', 1)
	SetBinding('CTRL-5', 'NONE', 1)
	SetBinding('CTRL-6', 'NONE', 1)
	SetBinding('CTRL-7', 'NONE', 1)
	SetBinding('CTRL-8', 'NONE', 1)
	SetBinding('CTRL-9', 'NONE', 1)
	SetBinding('CTRL-0', 'NONE', 1)
	SetBinding('CTRL-H', 'NONE', 1)
	SetBinding('CTRL-M', 'NONE', 1)
	SetBinding('SHIFT-6', 'NONE', 1)
	SetBinding('SHIFT-UP', 'NONE', 1)
	SetBinding('SHIFT-DOWN', 'NONE', 1)
	SetBinding('SHIFT-MOUSEWHEELDOWN', 'NONE', 1)
	SetBinding('SHIFT-V', 'NONE', 1)
	SetBinding('CTRL-V', 'NONE', 1)
	SetBinding('F12', 'NONE', 1)
	SetBinding('CTRL-S', 'NONE', 1)
	SetBinding('CTRL-Q', 'NONE', 1)
	SetBinding('Y', 'NONE', 1)
	SetBinding('SHIFT-G', 'NONE', 1)
	SetBinding('SHIFT-F', 'NONE', 1)
	SetBinding('SHIFT-D', 'NONE', 1)
	SetBinding('SHIFT-R', 'NONE', 1)

	-- SetBinding('ALT-F1', 'NONE', 1)
	-- SetBinding('ALT-F2', 'NONE', 1)
	SetBinding('ALT-F3', 'NONE', 1)
	SetBinding('ALT-F4', 'NONE', 1)
	SetBinding('ALT-F5', 'NONE', 1)
	SetBinding('ALT-F6', 'NONE', 1)
	SetBinding('ALT-F7', 'NONE', 1)
	SetBinding('ALT-F8', 'NONE', 1)
	SetBinding('ALT-F9', 'NONE', 1)

	SetBinding('ALT-1', 'NONE', 1)
	SetBinding('ALT-2', 'NONE', 1)
	SetBinding('ALT-3', 'NONE', 1)
	SetBinding('ALT-4', 'NONE', 1)
	SetBinding('ALT-5', 'NONE', 1)
	SetBinding('ALT-6', 'NONE', 1)
	SetBinding('ALT-7', 'NONE', 1)
	SetBinding('ALT-8', 'NONE', 1)
	SetBinding('ALT-9', 'NONE', 1)
	SetBinding('ALT-0', 'NONE', 1)

	SetBinding('ALT-MOUSEWHEELUP', 'NONE', 1)
	SetBinding('ALT-MOUSEWHEELDOWN', 'NONE', 1)
	SetBinding('SHIFT-MOUSEWHEELDOWN', 'NONE', 1)
	SetBinding('SHIFT-MOUSEWHEELUP', 'NONE', 1)

	SetBinding('SHIFT-1', 'NONE', 1)
	SetBinding('SHIFT-2', 'NONE', 1)
	SetBinding('SHIFT-3', 'NONE', 1)
	SetBinding('SHIFT-4', 'NONE', 1)
	SetBinding('SHIFT-5', 'NONE', 1)
	SetBinding('SHIFT-6', 'NONE', 1)
	SetBinding('SHIFT-7', 'NONE', 1)
	SetBinding('SHIFT-8', 'NONE', 1)
	SetBinding('SHIFT-9', 'NONE', 1)
	SetBinding('SHIFT-0', 'NONE', 1)

	SetBinding('CTRL-F1', 'NONE', 1)
	SetBinding('CTRL-F2', 'NONE', 1)
	SetBinding('CTRL-F3', 'NONE', 1)
	SetBinding('CTRL-F4', 'NONE', 1)
	SetBinding('CTRL-F5', 'NONE', 1)
	SetBinding('CTRL-F6', 'NONE', 1)
	SetBinding('CTRL-F7', 'NONE', 1)
	SetBinding('CTRL-F8', 'NONE', 1)
	SetBinding('CTRL-F9', 'NONE', 1)
	SetBinding('CTRL-F10', 'NONE', 1)
	SetBinding('CTRL-F11', 'NONE', 1)
	SetBinding('CTRL-F12', 'NONE', 1)
	SetBinding('CTRL-SHIFT-B', 'NONE', 1)
	SetBinding('CTRL-SHIFT-V', 'NONE', 1)
	SetBinding('CTRL-SHIFT-M', 'NONE', 1)
	SetBinding('CTRL-SHIFT-C', 'NONE', 1)
	SetBinding('CTRL-SHIFT-P', 'NONE', 1)
	SetBinding('ALT-SHIFT-V', 'NONE', 1)
	SetBinding('CTRL-L', 'NONE', 1)

	SetBinding('SHIFT-F1', 'NONE', 1)
	SetBinding('SHIFT-F2', 'NONE', 1)
	SetBinding('SHIFT-F3', 'NONE', 1)
	SetBinding('SHIFT-F4', 'NONE', 1)
	SetBinding('SHIFT-F5', 'NONE', 1)
	SetBinding('SHIFT-F6', 'NONE', 1)
	SetBinding('SHIFT-F7', 'NONE', 1)
	SetBinding('SHIFT-F8', 'NONE', 1)
	SetBinding('SHIFT-F9', 'NONE', 1)
	SetBinding('SHIFT-F10', 'NONE', 1)
	SetBinding('SHIFT-F11', 'NONE', 1)
	SetBinding('SHIFT-F12', 'NONE', 1)

	SetBinding('CTRL-SHIFT-F1', 'NONE', 1)
	SetBinding('CTRL-SHIFT-F2', 'NONE', 1)
	SetBinding('CTRL-SHIFT-F3', 'NONE', 1)
	SetBinding('CTRL-SHIFT-F4', 'NONE', 1)
	SetBinding('CTRL-SHIFT-F5', 'NONE', 1)
	SetBinding('CTRL-SHIFT-F6', 'NONE', 1)
	SetBinding('CTRL-SHIFT-F7', 'NONE', 1)
	SetBinding('CTRL-SHIFT-F8', 'NONE', 1)
	SetBinding('CTRL-SHIFT-F9', 'NONE', 1)
	SetBinding('CTRL-SHIFT-F10', 'NONE', 1)
	SetBinding('CTRL-SHIFT-F11', 'NONE', 1)
	SetBinding('CTRL-SHIFT-F12', 'NONE', 1)

	SetBinding('F7', 'NONE', 1)
	SetBinding('F7', 'NONE', 2)
	SetBinding('F8', 'NONE', 1)
	SetBinding('F8', 'NONE', 2)
	SetBinding('F9', 'NONE', 1)
	SetBinding('F9', 'NONE', 2)
	SetBinding('F10', 'NONE', 1)
	SetBinding('F10', 'NONE', 2)
	SetBinding('F11', 'NONE', 1)
	SetBinding('F11', 'NONE', 2)

	SetBinding('CTRL-F1', 'NONE', 1)
	SetBinding('CTRL-F2', 'NONE', 1)
	SetBinding('CTRL-F3', 'NONE', 1)
	SetBinding('CTRL-F4', 'NONE', 1)
	SetBinding('CTRL-F5', 'NONE', 1)
	SetBinding('CTRL-F6', 'NONE', 1)
	SetBinding('CTRL-F7', 'NONE', 1)
	SetBinding('CTRL-F8', 'NONE', 1)
	SetBinding('CTRL-F9', 'NONE', 1)
	SetBinding('CTRL-F10', 'NONE', 1)
	SetBinding('CTRL-F11', 'NONE', 1)
	SetBinding('CTRL-F12', 'NONE', 1)

	FixBindings()
	SaveBindings(1)
end

-- local f = CreateFrame('Frame')
-- f:RegisterEvent('PLAYER_ENTERING_WORLD')
-- f:SetScript(
-- 	'OnEvent',
-- 	function(self, event, isInitialLogin, isReloadingUi)
-- 		if event == 'PLAYER_ENTERING_WORLD' then
-- 			if not InCombatLockdown() then
-- 				C_Timer.After(
-- 					2,
-- 					function()
-- 						ClearAllBindings()
-- 					end
-- 				)
-- 			else
-- 				self:RegisterEvent('PLAYER_REGEN_ENABLED')
-- 			end
-- 		end

-- 		if event == 'PLAYER_REGEN_ENABLED' then
-- 			C_Timer.After(
-- 				2,
-- 				function()
-- 					ClearAllBindings()
-- 				end
-- 			)
-- 			self:UnregisterEvent('PLAYER_REGEN_ENABLED')
-- 		end
-- 	end
-- )

SLASH_BINDINGS1 = '/fb'
SlashCmdList['BINDINGS'] = ClearAllBindings
