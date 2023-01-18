local _, xVermin = ...

local function SetVariables()
	if (not C.Lua.Setup) then
		return
	end

	--  SetCVar Here

	-- ActionBars
	if (C.ActionBars.Enable) then
		SetActionBarToggles(1, 1, 1, 1, 1) -- enable all extra action bars.
	end
end

local f = CreateFrame('Frame')
f:RegisterEvent('ADDON_LOADED')
f:SetScript(
	'OnEvent',
	function(self, event, addon)
		if (addon ~= 'LuaUI') then
			return
		end

		local Name = UnitName('player')
		local Realm = GetRealmName()

		if (not LuaUIData) then
			LuaUIData = {}
		end

		if (not LuaUIData[Realm]) then
			LuaUIData[Realm] = {}
		end

		if (not LuaUIData[Realm][Name]) then
			LuaUIData[Realm][Name] = {}
		end

		if (LuaUIDataPerChar) then
			LuaUIData[Realm][Name] = LuaUIDataPerChar
			LuaUIDataPerChar = nil
		end

		local IsInstalled = LuaUIData[Realm][Name].InstallDone

		if (not IsInstalled) then
			local Data = LuaUIData[Realm][Name]

			-- define visible actionbars
			Data['HideBar2'] = false
			Data['HideBar3'] = false
			Data['HideBar4'] = false
			Data['HideBar5'] = true
			Data['HideBar6'] = true

			SetVariables()
		end

		self:UnregisterEvent('ADDON_LOADED')
	end
)

local function LoadVariables()
	if (not LuaUIData[GetRealmName()][UnitName('player')]) then
		LuaUI[GetRealmName()][UnitName('player')] = {}
	end

	local Data = LuaUIData[GetRealmName()][UnitName('player')]

	-- hide actionbars
	for i = 5, 6 do
		local ToggleButton = BarButtons[i]

		if (Data['HideBar' .. i]) then
			OnClick(ToggleButton)
		end
	end
end
hooksecurefunc(ActionBars, 'LoadVariables', LoadVariables)
