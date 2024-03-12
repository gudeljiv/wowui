local _, xVermin = ...

local default_macro = [[#showtooltip
/startattack
/use <rune>
]]
local default_tease_macro = [[#showtooltip
/stopattack
/cast [@mouseover,exists,harm][] Tease
]]
local default_feint_macro = [[#showtooltip
/cast Feint
]]

local function CreateOrUpdateMacro(macroName, text)
	local macroID = GetMacroIndexByName(macroName)
	if macroID == 0 then
		CreateMacro(macroName, 'Inv_misc_questionmark', text, true)
	else
		EditMacro(macroID, macroName, 'Inv_misc_questionmark', text, true)
	end
end

local function UpdateEngravingMacro()

	if InCombatLockdown() then
		return
	end

	local mutilate = false
	local saber = false
	local flesh = false

	C_Engraving.RefreshRunesList();
	local categories = C_Engraving.GetRuneCategories(false, false);
	if #categories > 0 then
		for c, category in ipairs(categories) do
			local runes = C_Engraving.GetRunesForCategory(category, false);
			local knownRunes = C_Engraving.GetRunesForCategory(category, true);
			for r, rune in ipairs(runes) do
				if rune.name == "Mutilate" and C_Engraving.IsRuneEquipped(rune.skillLineAbilityID) then
					mutilate = true
				end
				if rune.name == "Saber Slash" and C_Engraving.IsRuneEquipped(rune.skillLineAbilityID) then
					saber = true
				end
				if rune.name == "Just a Flesh Wound" and C_Engraving.IsRuneEquipped(rune.skillLineAbilityID) then
					flesh = true
				end
			end
		end
	end

	local rune_macro =
		default_macro:gsub(
		'<%a+>',
		{
			['<rune>'] = tostring("Sinister Strike")
		}
	)

	if mutilate then 
		rune_macro =
			default_macro:gsub(
			'<%a+>',
			{
				['<rune>'] = tostring("Mutilate")
			}
		)
		CreateOrUpdateMacro('attack', rune_macro)
	end

	if saber then 
		rune_macro =
			default_macro:gsub(
			'<%a+>',
			{
				['<rune>'] = tostring("Saber Slash")
			}
		)
		CreateOrUpdateMacro('attack', rune_macro)
	end

	if flesh then 
		CreateOrUpdateMacro('tease', default_tease_macro)
	else 
		CreateOrUpdateMacro('tease', default_feint_macro)
	end
end


local f = CreateFrame('Frame')
f:RegisterEvent('PLAYER_ENTERING_WORLD')
f:RegisterEvent('RUNE_UPDATED')
f:RegisterEvent('PLAYER_REGEN_DISABLED')
f:RegisterEvent('PLAYER_REGEN_ENABLED')
f:RegisterEvent('UNIT_INVENTORY_CHANGED')
f:SetScript(
	'OnEvent',
	function(self, event, isInitialLogin, isReloadingUi)

		if xVermin.Class ~= "ROGUE" then 
			return
		end
		
		if InCombatLockdown() then
			return
		end
		UpdateEngravingMacro()
	end
)
