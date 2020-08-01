local FOLDER_NAME, ADDON_TABLE = ...
local ADDON_NAME = ADDON_TABLE.AddonName
local TE = ADDON_TABLE.Addon
local Colors = TE.Include("Data.Colors")
local Icon = TE.Include("Service.Icon")
local Settings = TE.Include("Service.Settings")
local AutoTracker = TE.Include("Service.AutoTracker")
local MyLib = TE.Include("Util.MyLib")
local L = TE.Include("Locale")

local private = {
	ldb = nil,
	icon = nil,
	GAME_EVENTS = {
		["MINIMAP_UPDATE_TRACKING"] = true
	},
	USER_EVENTS = {
		["MINIMAP_ICON_DISPLAY_TYPE_CHANGE"] = true,
		["OPTIONS_RESET"] = true
	}
}

local NO_TRACK_ICON = "Interface\\AddOns\\" .. FOLDER_NAME .. "\\Media\\Logo64x64.blp" -- 136235
local ENABLED_COLOR = Colors:GetColorByName("GREEN2")
local DISABLED_COLOR = Colors:GetColorByName("RED")
local PAUSED_COLOR = Colors:GetColorByName("GRAY")
local COMMAND_COLOR = Colors:GetColorByName("LIGHTYELLOW")

function Icon:OnInitialize()
	private.ldb =
		LibStub("LibDataBroker-1.1"):NewDataObject(
		ADDON_NAME,
		{
			type = "data source",
			text = ADDON_NAME,
			icon = self:GetIcon(),
			OnTooltipShow = function(tooltip)
				local cs = COMMAND_COLOR
				local ce = "|r"
				tooltip:SetText(ADDON_NAME .. " [" .. Icon:GetAddonState() .. "]")
				tooltip:AddLine(format(L["%sLeft-click%s to manualy select tracking spell"], cs, ce))
				tooltip:AddLine(format(L["%sRight-click%s to cancel current tracking spell"], cs, ce))
				tooltip:AddLine(format(L["%sShift+Left-click%s to enable/disable auto swithing"], cs, ce))
				tooltip:AddLine(format(L["%sShift+Right-click%s to open settings"], cs, ce))
				tooltip:AddLine(format(L["%sDrag%s to move icon"], cs, ce))
				tooltip:Show()
			end,
			OnClick = function(self, button)
				Icon:OnClick(self, button)
			end
		}
	)

	private.icon = LibStub("LibDBIcon-1.0")
	private.icon:Register(ADDON_NAME, private.ldb, TE.db.profile.minimap)
	private.minimapButton = private.icon:GetMinimapButton(ADDON_NAME)
	TE.minimapButton = private.minimapButton

	if private.minimapButton then
		private.minimapButton:SetScale(TE.db.profile.minimap.scale)
	end

	self:RegisterEvents(private.GAME_EVENTS, "EventHandler")
	self:RegisterUserEvents(private.USER_EVENTS, "EventHandler")
end

function Icon:Refresh()
	private.icon:Refresh(ADDON_NAME, TE.db.profile.minimap)
end

function Icon:UpdateIcon()
	private.ldb.icon = Icon:GetIcon()
	Icon:Refresh()
end

function Icon:GetNextSpellIcon()
	local nextSpellID = AutoTracker:GetNextSpellID()
	local icon = GetSpellTexture(nextSpellID)

	if not icon then
		return NO_TRACK_ICON
	end

	return icon
end

function Icon:GetIcon()
	if TE.db.profile.minimap.displayType == "CURRENT_SPELL" then
		return GetTrackingTexture() or NO_TRACK_ICON
	else
		return self:GetNextSpellIcon()
	end
end

function Icon:OnClick(self, button)
	local alt_key = IsAltKeyDown()
	local shift_key = IsShiftKeyDown()
	local control_key = IsControlKeyDown()

	if button == "LeftButton" then
		if shift_key then
			Settings:Toggle()
		else
			Icon:DropDownMenu_Open()
		end
	elseif button == "RightButton" then
		if shift_key then
			Settings:OpenOptionsFrame()
		else
			CancelTrackingBuff()
		end
	else
		Settings:OpenOptionsFrame()
	end
end

function Icon:DropDownMenu_Open()
	local menuList = {
		isNotRadio = true,
		{
			text = ADDON_NAME,
			isTitle = true,
			notCheckable = true
		}
	}

	local resources = Settings:GetPlayerTrackingSpells("resources") or {}
	local units = Settings:GetPlayerTrackingSpells("units") or {}
	local spells = MyLib.ConcatTwoTables(resources, units)

	for id, name in pairs(spells) do
		table.insert(
			menuList,
			{
				text = name,
				icon = GetSpellTexture(id),
				checked = function(self)
					if self.icon == GetTrackingTexture() then
						return true
					end
					return false
				end,
				func = function(self, arg1, arg2, checked)
					CastSpellByID(id)
				end
			}
		)
	end

	local menuFrame = CreateFrame("Frame", FOLDER_NAME .. "Menu", UIParent, "UIDropDownMenuTemplate")
	EasyMenu(menuList, menuFrame, private.minimapButton, -138, 3, "MENU")
end

function Icon:GetAddonState()
	if TE.db.profile.general.enable then
		if AutoTracker:isPaused() then
			return PAUSED_COLOR .. L["paused"] .. "|r"
		else
			return ENABLED_COLOR .. L["enabled"] .. "|r"
		end
	else
		return DISABLED_COLOR .. L["disabled"] .. "|r"
	end
end

-- =================================================================================
--                              Event handl functions
-- =================================================================================

function Icon:EventHandler(...)
	local event, arg1, arg2, arg3 = ...

	if private.GAME_EVENTS[event] then
		if event == "MINIMAP_UPDATE_TRACKING" then
			self:UpdateIcon()
		end
	elseif private.USER_EVENTS[event] then
		if event == "MINIMAP_ICON_DISPLAY_TYPE_CHANGE" then
			self:UpdateIcon()
		elseif event == "OPTIONS_RESET" then
			self:Refresh()
		end
	end
end

function Icon:RegisterEvents(eventTable, func)
	for key, val in pairs(eventTable) do
		if val then
			self:RegisterEvent(key, func)
		end
	end
end

function Icon:RegisterUserEvents(eventTable, func)
	for key, val in pairs(eventTable) do
		if val then
			self:RegisterMessage(key, func)
		end
	end
end
