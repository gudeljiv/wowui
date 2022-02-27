local L = LibStub("AceLocale-3.0"):NewLocale("Spy", "ruRU")
if not L then return end
-- TOC Note: Detects and alerts you to the presence of nearby enemy players.

-- Configuration
L["Spy"] = "Spy"
L["Version"] = "Version"
L["Spy Option"] = "Spy"
L["Profiles"] = "Profiles"

-- About
L["About"] = "Info"
L["SpyDescription1"] = [[
Spy is an addon that will alert you to the presence of nearby enemy players. These are some of the main features.
]]
L["SpyDescription2"] = [[
|cffffd000Nearby list|cffffffff
Displays enemy players that have been detected nearby. Players are removed from the list if they have not been detected after a period of time.

|cffffd000Last Hour list|cffffffff
Displays all enemies that have been detected in the last hour.

|cffffd000Ignore list|cffffffff
Players that are added to the Ignore list will not be reported by Spy. You can add and remove players to/from this list by using the button's drop down menu or by holding the Control key while clicking the button.

|cffffd000Kill On Sight list|cffffffff
Players on your Kill On Sight list cause an alarm to sound when detected. You can add and remove players to/from this list by using the button's drop down menu or by holding the Shift key while clicking the button.

The drop down menu can also be used to set the reasons why you have added someone to the Kill On Sight list. If you want to enter a specific reason that is not in the list, then use the "Enter your own reason..." in the Other list.

|cffffd000Statistics Window|cffffffff
The Statistics Window contains a list of all enemy encounters which can be sorted by name, level, guild, wins, losses and the last time an enemy was detected. It also provides the ability to search for a specific enemy by name or guild and has filters to show only enemies that are marked as Kill on Sight, with a Win/Loss or entered Reasons.

|cffffd000Kill On Sight Button|cffffffff
If enabled, this button will be located on the enemy players target frame. Clicking on this button will add/remove the enemy target to/from the Kill On Sight list. Right clicking on the button will allow you to enter Kill on Sight reasons.

|cffffd000Author: Slipjack|cffffffff
]]

-- General Settings
L["GeneralSettings"] = "General Settings"
L["GeneralSettingsDescription"] = [[
Options for when Spy is Enabled or Disabled.
]]
L["EnableSpy"] = "Enable Spy"
L["EnableSpyDescription"] = "Enables or disables Spy."
L["EnabledInBattlegrounds"] = "Enable Spy in battlegrounds"
L["EnabledInBattlegroundsDescription"] = "Enables or disables Spy when you are in a battleground."
L["EnabledInArenas"] = "Enable Spy in arenas"
L["EnabledInArenasDescription"] = "Enables or disables Spy when you are in an arena."
L["EnabledInWintergrasp"] = "Enable Spy in world combat zones"
L["EnabledInWintergraspDescription"] = "Enables or disables Spy when you are in world combat zones such as Lake Wintergrasp in Northrend."
L["DisableWhenPVPUnflagged"] = "Disable Spy when not flagged for PVP"
L["DisableWhenPVPUnflaggedDescription"] = "Enables or disables Spy depending on your PVP status."
L["DisabledInZones"] = "Disable Spy while in these locations"
L["DisabledInZonesDescription"]	= "Selecet locations where Spy will be disabled"
L["Booty Bay"] = "Пиратская Бухта"
L["Everlook"] = "Круговзор"						
L["Gadgetzan"] = "Прибамбасск"
L["Ratchet"] = "Кабестан"
L["The Salty Sailor Tavern"] = "Таверна \"Старый моряк\""
L["Shattrath City"] = "Шаттрат"
L["Area 52"] = "Зона 52"
L["Dalaran"] = "Даларан"
L["Bogpaddle"] = "Веслотопь"
L["The Vindicaar"] = "Виндикар"

-- Display
L["DisplayOptions"] = "Display"
L["DisplayOptionsDescription"] = [[
Options for the Spy window and tooltips.
]]
L["ShowOnDetection"] = "Show Spy when enemy players are detected"
L["ShowOnDetectionDescription"] = "Set this to display the Spy window and the Nearby list if Spy is hidden when enemy players are detected."
L["HideSpy"] = "Hide Spy when no enemy players are detected"
L["HideSpyDescription"] = "Set this to hide Spy when the Nearby list is displayed and it becomes empty. Spy will not be hidden if you clear the list manually."
L["ShowOnlyPvPFlagged"] = "Show only enemy players flagged for PvP"
L["ShowOnlyPvPFlaggedDescription"] = "Set this to show only enemy players that are flagged for PvP in the Nearby list."
L["ShowKoSButton"] = "Show KOS button on the enemy target frame"
L["ShowKoSButtonDescription"] = "Set this to show the KOS button on the enemy player's target frame."
L["LockSpy"] = "Lock the Spy window"
L["LockSpyDescription"] = "Locks the Spy window in place so it doesn't move."
L["ClampToScreen"] = "Прикрепить к экрану"
L["ClampToScreenDescription"] = "Управляет возможностью перемещения окна Spy с экрана"
L["InvertSpy"] = "Invert the Spy window"
L["InvertSpyDescription"] = "Flips the Spy window upside down."
L["Reload"] = "Reload UI"
L["ReloadDescription"] = "Required when changing the Spy window."
L["ResizeSpy"] = "Resize the Spy window automatically"
L["ResizeSpyDescription"] = "Set this to automatically resize the Spy window as enemy players are added and removed."
L["ResizeSpyLimit"] = "List Limit"
L["ResizeSpyLimitDescription"] = "Limit the number of enemy players shown in the Spy window."
L["DisplayTooltipNearSpyWindow"] = "Display tooltip near the Spy window"
L["DisplayTooltipNearSpyWindowDescription"] = "Set this to display tooltips near the Spy window."
L["SelectTooltipAnchor"] = "Tooltip Anchor Point"
L["SelectTooltipAnchorDescription"] = "Select the anchor point for the tooltip if the option above has been checked"
L["ANCHOR_CURSOR"] = "Cursor"
L["ANCHOR_TOP"] = "Top"
L["ANCHOR_BOTTOM"] = "Bottom"
L["ANCHOR_LEFT"] = "Left"			
L["ANCHOR_RIGHT"] = "Right"
L["TooltipDisplayWinLoss"] = "Display win/loss statistics in tooltip"
L["TooltipDisplayWinLossDescription"] = "Set this to display the win/loss statistics of a player in the player's tooltip."
L["TooltipDisplayKOSReason"] = "Display Kill On Sight reasons in tooltip"
L["TooltipDisplayKOSReasonDescription"] = "Set this to display the Kill On Sight reasons of a player in the player's tooltip."
L["TooltipDisplayLastSeen"] = "Display last seen details in tooltip"
L["TooltipDisplayLastSeenDescription"] = "Set this to display the last known time and location of a player in the player's tooltip."
L["SelectFont"] = "Select a Font"
L["SelectFontDescription"] = "Select a Font for the Spy Window."
L["RowHeight"] = "Select the Row Height"
L["RowHeightDescription"] = "Select the Row Height for the Spy window."
L["Texture"] = "Texture"
L["TextureDescription"] = "Select a texture for the Spy Window"

-- Alerts
L["AlertOptions"] = "Alerts"
L["AlertOptionsDescription"] = [[
Options for alerts, announcements and warnings when enemy players are detected.
]]
L["SoundChannel"] = "Select Sound Channel"
L["Master"] = "Master"
L["SFX"] = "Sound Effects"
L["Music"] = "Music"
L["Ambience"] = "Ambience"
L["Announce"] = "Send announcements to:"
L["None"] = "None"
L["NoneDescription"] = "Do not announce when enemy players are detected."
L["Self"] = "Self"
L["SelfDescription"] = "Announce to yourself when enemy players are detected."
L["Party"] = "Party"
L["PartyDescription"] = "Announce to your party when enemy players are detected."
L["Guild"] = "Guild"
L["GuildDescription"] = "Announce to your guild when enemy players are detected."
L["Raid"] = "Raid"
L["RaidDescription"] = "Announce to your raid when enemy players are detected."
L["LocalDefense"] = "Local Defense"
L["LocalDefenseDescription"] = "Announce to the Local Defense channel when enemy players are detected."
L["OnlyAnnounceKoS"] = "Only announce enemy players that are Kill On Sight"
L["OnlyAnnounceKoSDescription"] = "Set this to only announce enemy players that are on your Kill On Sight list."
L["WarnOnStealth"] = "Warn upon stealth detection"
L["WarnOnStealthDescription"] = "Set this to display a warning and sound an alert when an enemy player gains stealth."
L["WarnOnKOS"] = "Warn upon Kill On Sight detection"
L["WarnOnKOSDescription"] = "Set this to display a warning and sound an alert when an enemy player on your Kill On Sight list is detected."
L["WarnOnKOSGuild"] = "Warn upon Kill On Sight guild detection"
L["WarnOnKOSGuildDescription"] = "Set this to display a warning and sound an alert when an enemy player in the same guild as someone on your Kill On Sight list is detected."
L["WarnOnRace"] = "Warn upon Race detection"
L["WarnOnRaceDescription"] = "Set this to sound an alert when the selected Race is detected."
L["SelectWarnRace"] = "Select Race for detection"
L["SelectWarnRaceDescription"] = "Select a Race for audio alert."
L["WarnRaceNote"] = "Note: You must target an enemy at least once so their Race can be added to the database. Upon the next detection an alert will sound. This does not work the same as detecting nearby enemies in combat."
L["DisplayWarningsInErrorsFrame"] = "Display warnings in the errors frame"
L["DisplayWarningsInErrorsFrameDescription"] = "Set this to use the errors frame to display warnings instead of using the graphical popup frames."
L["EnableSound"] = "Enable audio alerts"
L["EnableSoundDescription"] = "Set this to enable audio alerts when enemy players are detected. Different alerts sound if an enemy player gains stealth or if an enemy player is on your Kill On Sight list."
L["OnlySoundKoS"] = "Only sound audio alerts for Kill on Sight detection"
L["OnlySoundKoSDescription"] = "Set this to only play audio alerts when enemy players on the Kill on Sight list are detected."
L["StopAlertsOnTaxi"] = "Turn off alerts while on a flight path"
L["StopAlertsOnTaxiDescription"] = "Stop all new alerts and warnings while on a flight path."

-- Nearby List
L["ListOptions"] = "Nearby List"
L["ListOptionsDescription"] = [[
Options on how enemy players are added and removed.
]]
L["RemoveUndetected"] = "Remove enemy players from the Nearby list after:"
L["1Min"] = "1 minute"
L["1MinDescription"] = "Remove an enemy player who has been undetected for over 1 minute."
L["2Min"] = "2 minutes"
L["2MinDescription"] = "Remove an enemy player who has been undetected for over 2 minutes."
L["5Min"] = "5 minutes"
L["5MinDescription"] = "Remove an enemy player who has been undetected for over 5 minutes."
L["10Min"] = "10 minutes"
L["10MinDescription"] = "Remove an enemy player who has been undetected for over 10 minutes."
L["15Min"] = "15 minutes"
L["15MinDescription"] = "Remove an enemy player who has been undetected for over 15 minutes."
L["Never"] = "Never remove"
L["NeverDescription"] = "Never remove enemy players. The Nearby list can still be cleared manually."
L["ShowNearbyList"] = "Switch to the Nearby list upon enemy player detection"
L["ShowNearbyListDescription"] = "Set this to display the Nearby list if it is not already visible when enemy players are detected."
L["PrioritiseKoS"] = "Prioritise Kill On Sight enemy players in the Nearby list"
L["PrioritiseKoSDescription"] = "Set this to always show Kill On Sight enemy players first in the Nearby list."

-- Map
L["MapOptions"] = "Map"
L["MapOptionsDescription"] = [[
Options for world map and minimap including icons and tooltips.
]]
L["MinimapDetection"] = "Enable minimap detection"
L["MinimapDetectionDescription"] = "Rolling the cursor over known enemy players detected on the minimap will add them to the Nearby list."
L["MinimapNote"] = "          Note: Only works for players that can Track Humanoids."
L["MinimapDetails"] = "Display level/class details in tooltips"
L["MinimapDetailsDescription"] = "Set this to update the map tooltips so that level/class details are displayed alongside enemy names."
L["DisplayOnMap"] = "Display icons on the map"
L["DisplayOnMapDescription"] = "Display map icons for the location of other Spy users in your party, raid and guild when they detect enemies."
L["SwitchToZone"] = "Switch to current zone map on enemy detection"
L["SwitchToZoneDescription"] = "Change the map to the players current zone map when enemies are detected."
L["MapDisplayLimit"] = "Limit displayed map icons to:"
L["LimitNone"] = "Everywhere"
L["LimitNoneDescription"] = "Displays all detected enemies on the map regardless of your current location."
L["LimitSameZone"] = "Same zone"
L["LimitSameZoneDescription"] = "Only displays detected enemies on the map if you are in the same zone."
L["LimitSameContinent"] = "Same continent"
L["LimitSameContinentDescription"] = "Only displays detected enemies on the map if you are on the same continent."

-- Data Management
L["DataOptions"] = "Data Management"
L["DataOptionsDescription"] = [[
Options on how Spy maintains and gathers data.
]]
L["PurgeData"] = "Purge undetected enemy player data after:"
L["OneDay"] = "1 day"
L["OneDayDescription"] = "Purge data for enemy players that have been undetected for 1 day."
L["FiveDays"] = "5 days"
L["FiveDaysDescription"] = "Purge data for enemy players that have been undetected for 5 days."
L["TenDays"] = "10 days"
L["TenDaysDescription"] = "Purge data for enemy players that have been undetected for 10 days."
L["ThirtyDays"] = "30 days"
L["ThirtyDaysDescription"] = "Purge data for enemy players that have been undetected for 30 days."
L["SixtyDays"] = "60 days"
L["SixtyDaysDescription"] = "Purge data for enemy players that have been undetected for 60 days."
L["NinetyDays"] = "90 days"
L["NinetyDaysDescription"] = "Purge data for enemy players that have been undetected for 90 days."
L["PurgeKoS"] = "Purge Kill on Sight players based on undetected time."
L["PurgeKoSDescription"] = "Set this to purge Kill on Sight players that have been undetected based on the time settings for undetected players."
L["PurgeWinLossData"] = "Purge win/loss data based on undetected time."
L["PurgeWinLossDataDescription"] = "Set this to purge win/loss data of your enemy encounters based on the time settings for undetected players."
L["ShareData"] = "Share data with other Spy addon users"
L["ShareDataDescription"] = "Set this to share the details of your enemy player encounters with other Spy users in your party, raid and guild."
L["UseData"] = "Use data from other Spy addon users"
L["UseDataDescription"] = "Set this to use the data collected by other Spy users in your party, raid and guild."
L["ShareKOSBetweenCharacters"] = "Share Kill On Sight players between your characters"
L["ShareKOSBetweenCharactersDescription"] = "Set this to share the players you mark as Kill On Sight between other characters that you play on the same server and faction."

-- Commands
L["SlashCommand"] = "Slash Command"
L["SpySlashDescription"] = "These buttons execute the same functions as the ones in the slash command /spy"
L["Enable"] = "Enable"
L["EnableDescription"] = "Enables Spy and shows the main window."
L["Show"] = "Show"
L["ShowDescription"] = "Shows the main window."
L["Hide"] = "Hide"
L["HideDescription"] = "Hides the main window."
L["Reset"] = "Reset"
L["ResetDescription"] = "Resets the position and appearance of the main window."
L["ClearSlash"] = "Clear"
L["ClearSlashDescription"] = "Clears the list of players that have been detected."
L["Config"] = "Config"
L["ConfigDescription"] = "Open the Interface Addons configuration window for Spy."
L["KOS"] = "KOS"
L["KOSDescription"] = "Add/remove a player to/from the Kill On Sight list."
L["InvalidInput"] = "Invalid Input"
L["Ignore"] = "Ignore"
L["IgnoreDescription"] = "Add/remove a player to/from the Ignore list."

-- Lists
L["Nearby"] = "Nearby"
L["LastHour"] = "Last Hour"
L["Ignore"] = "Ignore"
L["KillOnSight"] = "Kill On Sight"

--Stats
L["Time"] = "Time"	
L["List"] = "List"
L["Filter"] = "Filter"
L["Show Only"] = "Show Only"
L["KOS"] = "KOS"
L["Won/Lost"] = "Won/Lost"
L["Reason"] = "Reason"	 
L["HonorKills"] = "Honor Kills"
L["PvPDeaths"] = "PvP Deaths"

-- Output messages
L["VersionCheck"] = "|cffc41e3aПредупреждение! Неправильная версия Spy установлена. Удалите эту версию и установите Spy Classic."
L["SpyEnabled"] = "|cff9933ffSpy addon enabled."
L["SpyDisabled"] = "|cff9933ffSpy addon disabled. Type |cffffffff/spy show|cff9933ff to enable."
L["UpgradeAvailable"] = "|cff9933ffA new version of Spy is available. It can be downloaded from:\n|cffffffffhttps://www.curseforge.com/wow/addons/spy-classic"
L["AlertStealthTitle"] = "Stealth player detected!"
L["AlertKOSTitle"] = "Kill On Sight player detected!"
L["AlertKOSGuildTitle"] = "Kill On Sight player guild detected!"
L["AlertTitle_kosaway"] = "Kill On Sight player located by "
L["AlertTitle_kosguildaway"] = "Kill On Sight player guild located by "
L["StealthWarning"] = "|cff9933ffStealth player detected: |cffffffff"
L["KOSWarning"] = "|cffff0000Kill On Sight player detected: |cffffffff"
L["KOSGuildWarning"] = "|cffff0000Kill On Sight player guild detected: |cffffffff"
L["SpySignatureColored"] = "|cff9933ff[Spy] "
L["PlayerDetectedColored"] = "Player detected: |cffffffff"
L["PlayersDetectedColored"] = "Players detected: |cffffffff"
L["KillOnSightDetectedColored"] = "Kill On Sight player detected: |cffffffff"
L["PlayerAddedToIgnoreColored"] = "Added player to Ignore list: |cffffffff"
L["PlayerRemovedFromIgnoreColored"] = "Removed player from Ignore list: |cffffffff"
L["PlayerAddedToKOSColored"] = "Added player to Kill On Sight list: |cffffffff"
L["PlayerRemovedFromKOSColored"] = "Removed player from Kill On Sight list: |cffffffff"
L["PlayerDetected"] = "[Spy] Player detected: "
L["KillOnSightDetected"] = "[Spy] Kill On Sight player detected: "
L["Level"] = "Level"
L["LastSeen"] = "Last seen"
L["LessThanOneMinuteAgo"] = "less than a minute ago"
L["MinutesAgo"] = "minutes ago"
L["HoursAgo"] = "hours ago"
L["DaysAgo"] = "days ago"
L["Close"] = "Close"
L["CloseDescription"] = "|cffffffffHides the Spy window. By default will show again when the next enemy player is detected."
L["Left/Right"] = "Left/Right"
L["Left/RightDescription"] = "|cffffffffNavigates between the Nearby, Last Hour, Ignore and Kill On Sight lists."
L["Clear"] = "Clear"
L["ClearDescription"] = "|cffffffffClears the list of players that have been detected. CTRL-Click will turn Spy On/Off. Shift-Click will turn all sound On/Off."
L["SoundEnabled"] = "Audio alerts enabled"
L["SoundDisabled"] = "Audio alerts disabled"
L["NearbyCount"] = "Nearby Count"
L["NearbyCountDescription"] = "|cffffffffCount of nearby players."
L["Statistics"] = "Statistics"
L["StatsDescription"] = "|cffffffffShows a list of enemy players encountered, win/loss records and where they were last seen."
L["AddToIgnoreList"] = "Add to Ignore list"
L["AddToKOSList"] = "Add to Kill On Sight list"
L["RemoveFromIgnoreList"] = "Remove from Ignore list"
L["RemoveFromKOSList"] = "Remove from Kill On Sight list"
L["RemoveFromStatsList"] = "Remove from Statistics List"   
L["AnnounceDropDownMenu"] = "Announce"
L["KOSReasonDropDownMenu"] = "Set Kill On Sight reason"
L["PartyDropDownMenu"] = "Party"
L["RaidDropDownMenu"] = "Raid"
L["GuildDropDownMenu"] = "Guild"
L["LocalDefenseDropDownMenu"] = "Local Defense"
L["Player"] = " (Player)"
L["KOSReason"] = "Kill On Sight"
L["KOSReasonIndent"] = "    "
L["KOSReasonOther"] = "Enter your own reason..."
L["KOSReasonClear"] = "Clear Reason"
L["StatsWins"] = "|cff40ff00Wins: "
L["StatsSeparator"] = "  "
L["StatsLoses"] = "|cff0070ddLosses: "
L["Located"] = "located:"
L["Yards"] = "yards"
L["LocalDefenseChannelName"] = "ОборонаЛокальный" 

Spy_KOSReasonListLength = 6
Spy_KOSReasonList = {
	[1] = {
		["title"] = "Started combat";
		["content"] = {
			"Attacked me for no reason",
			"Attacked me at a quest giver", 
			"Attacked me while I was fighting NPCs",
			"Attacked me while I was near an instance",
			"Attacked me while I was AFK",
			"Attacked me while I was mounted/flying",
			"Attacked me while I had low health/mana",
		};
	},
	[2] = {
		["title"] = "Style of combat";
		["content"] = {
			"Ambushed me",
			"Always attacks me on sight",
			"Killed me with a higher level character",
			"Steamrolled me with a group of enemies",
			"Doesn't attack without backup",
			"Always calls for help",
			"Uses too much crowd control",
		};
	},
	[3] = {
		["title"] = "Camping";
		["content"] = {
			"Camped me",
			"Camped an alt",
			"Camped lowbies",
			"Camped from stealth",
			"Camped guild members",
			"Camped game NPCs/objectives",
			"Camped a city/site",
		};
	},
	[4] = {
		["title"] = "Questing";
		["content"] = {
			"Attacked me while I was questing",
			"Attacked me after I helped with a quest",
			"Interfered with a quest objective",
			"Started a quest I wanted to do",
			"Killed my faction's NPCs",
			"Killed a quest NPC",
		};
	},
	[5] = {
		["title"] = "Stole resources";
		["content"] = {
			"Gathered herbs I wanted",
			"Gathered minerals I wanted",
			"Gathered resources I wanted",
			"Killed me and stole my target/rare NPC",
			"Skinned my kills",
			"Salvaged my kills",
			"Fished in my pool",
		};
	},
	[6] = {
		["title"] = "Other";
		["content"] = {
			"Flagged for PvP",
			"Pushed me off a cliff",
			"Uses engineering tricks",
			"Always manages to escape",
			"Uses items and skills to escape",
			"Exploits game mechanics",
			"Enter your own reason...",
		};
	},
}

StaticPopupDialogs["Spy_SetKOSReasonOther"] = {
	preferredIndex=STATICPOPUPS_NUMDIALOGS,  -- http://forums.wowace.com/showthread.php?p=320956
	text = "Enter the Kill On Sight reason for %s:",
	button1 = "Set",
	button2 = "Cancel",
	timeout = 120,
	hasEditBox = 1,
	editBoxWidth = 260,	
	whileDead = 1,
	hideOnEscape = 1,
	OnShow = function(self)
		self.editBox:SetText("");
	end,
    	OnAccept = function(self)
		local reason = self.editBox:GetText()
		Spy:SetKOSReason(self.playerName, "Enter your own reason...", reason)
	end,
};

--++ Class descriptions
--L["DEATHKNIGHT"] = "рыцарь смерти"
--L["DEMONHUNTER"] = "Охотник на демонов"
L["DRUID"] = "Друид"
L["HUNTER"] = "Охотник"
L["MAGE"] = "Маг"
--L["MONK"] = "Монах"
L["PALADIN"] = "Паладин"
L["PRIEST"] = "Жрец"
L["ROGUE"] = "Разбойник"
L["SHAMAN"] = "Шаман"
L["WARLOCK"] = "Чернокнижник"
L["WARRIOR"] = "Воин"
L["UNKNOWN"] = "Неизвестный"

--++ Race descriptions
L["HUMAN"] = "Человек"
L["ORC"] = "Орк"
L["DWARF"] = "Дворф"
L["NIGHT ELF"] = "Ночной эльф"
L["UNDEAD"] = "Нежить"
L["TAUREN"] = "Таурен"
L["GNOME"] = "Гном"
L["TROLL"] = "Тролль"
L["GOBLIN"] = "Гоблин"
--L["BLOOD ELF"] = "Эльф крови"
--L["DRAENEI"] = "Дреней"
--L["WORGEN"] = "Ворген"
--L["PANDAREN"] = "Пандарен"
--L["NIGHTBORNE"] = "Ночнорожденный"
--L["HIGHMOUNTAIN TAUREN"] = "Таурен Крутогорья"
--L["VOID ELF"] = "Эльф Бездны"
--L["LIGHTFORGED DRAENEI"] = "Озаренный дреней"
--L["ZANDALARI TROLL"] = "Зандалар"
--L["KUL TIRAN"] = "Култирасец"
--L["DARK IRON DWARF"] = "Дворф из клана Черного Железа"
--L["MAG'HAR ORC"] = "Маг'хар"
 
-- Stealth abilities
L["Stealth"] = "Незаметность"
L["Prowl"] = "Крадущийся зверь"
 
--++ Minimap color codes
--L["MinimapClassTextDEATHKNIGHT"] = "|cffc41e3a"
--L["MinimapClassTextDEMONHUNTER"] = "|cffa330c9"
L["MinimapClassTextDRUID"] = "|cffff7c0a"
L["MinimapClassTextHUNTER"] = "|cffaad372"
L["MinimapClassTextMAGE"] = "|cff68ccef"
--L["MinimapClassTextMONK"] = "|cff00ff96"
L["MinimapClassTextPALADIN"] = "|cfff48cba"
L["MinimapClassTextPRIEST"] = "|cffffffff"
L["MinimapClassTextROGUE"] = "|cfffff468"
L["MinimapClassTextSHAMAN"] = "|cff2359ff"
L["MinimapClassTextWARLOCK"] = "|cff9382c9"
L["MinimapClassTextWARRIOR"] = "|cffc69b6d"
L["MinimapClassTextUNKNOWN"] = "|cff191919"
L["MinimapGuildText"] = "|cffffffff"

Spy_AbilityList = {
-----------------------------------------------------------
-- Allows an estimation of the race, class and level of a
-- player based on the abilities observed in the combat log.
-----------------------------------------------------------

--++ Racial Traits ++	
	["Уход в тень"]={ class = "Night Elf", level = 1, },
	["Кровавое неистовство"]={ class = "Orc", level = 1, },
	["Воля Отрекшихся"]={ class = "Undead", level = 1, },
	["Каменная форма"]={ class = "Dwarf", level = 1, },
	["Боевое исступление"]={ class = "Troll", level = 1, },
	["Твердость"]={ class = "Orc", level = 1, },
	["Специализация на владении мечами"]={ class = "Human", level = 1, },
	["Мастер побега"]={ class = "Gnome", level = 1, },
	["Человеческий дух"]={ class = "Human", level = 1, },
	["Регенерация"]={ class = "Troll", level = 1, },
	["Внимательность"]={ class = "Human", level = 1, },
	["Закалка"]={ class = "Tauren", level = 1, },
	["Специализация на луке"]={ class = "Troll", level = 1, },
	["Проращивание"]={ class = "Tauren", level = 1, },
	["Инженерное дело, специализация"]={ class = "Gnome", level = 1, },
	["Громовая поступь"]={ class = "Tauren", level = 1, },
	["Убийство животных"]={ class = "Troll", level = 1, },
	["Поиск сокровища"]={ class = "Dwarf", level = 1, },
	["Специализация на владении топором"]={ class = "Orc", level = 1, },
	["Каннибализм"]={ class = "Undead", level = 1, },
	["Дипломатия"]={ class = "Human", level = 1, },
	["Расторопность"]={ class = "Night Elf", level = 1, },
	["Специализация - броски"]={ class = "Troll", level = 1, },
	["Специализация на ударном оружии"]={ class = "Human", level = 1, },
	["Специализация по стрелковому оружию"]={ class = "Dwarf", level = 1, },
	["Подводное дыхание"]={ class = "Undead", level = 1, },
	["Властность"]={ class = "Orc", level = 1, },
	["Сопротивление силам природы"]={ class = "Night Elf", level = 1, },
	["Сопротивление магии льда"]={ class = "Dwarf", level = 1, },
	["Сопротивление темной магии"]={ class = "Undead", level = 1, },
	["Сопротивление тайной магии"]={ class = "Gnome", level = 1, },
	["Дух огонька"]={ class = "Night Elf", level = 1, },
	
--++ Druid Abilities ++	
	["Целительное прикосновение"]={ class = "DRUID", level = 1, },
	["Гнев"]={ class = "DRUID", level = 1, },
	["Лунный огонь"]={ class = "DRUID", level = 4, },
	["Гнев деревьев"]={ class = "DRUID", level = 8, },
	["Облик медведя"]={ class = "DRUID", level = 10, },
	["Устрашающий рев"]={ class = "DRUID", level = 10, },
	["Рык"]={ class = "DRUID", level = 10, },
	["Трепка"]={ class = "DRUID", level = 10, },
	["Телепортация: Лунная поляна"]={ class = "DRUID", level = 10, },
	["Исступление"]={ class = "DRUID", level = 12, },
	["Восстановление"]={ class = "DRUID", level = 12, },
	["Оглушить"]={ class = "DRUID", level = 14, },
	["Водный облик"]={ class = "DRUID", level = 16, },
	["Размах"]={ class = "DRUID", level = 16, },
	["Волшебный огонь"]={ class = "DRUID", level = 18, },
	["Спячка"]={ class = "DRUID", level = 18, },
	["Облик кошки"]={ class = "DRUID", level = 20, },
	["Когти"]={ class = "DRUID", level = 20, },
	["Крадущийся зверь"]={ class = "DRUID", level = 20, },
	["Возрождение"]={ class = "DRUID", level = 20, },
	["Разорвать"]={ class = "DRUID", level = 20, },
	["Звездный огонь"]={ class = "DRUID", level = 20, },
	["Полоснуть"]={ class = "DRUID", level = 22, },
	["Умиротворение зверя"]={ class = "DRUID", level = 22, },
	["Глубокая рана"]={ class = "DRUID", level = 24, },
	["Снятие проклятья"]={ class = "DRUID", level = 24, },
	["Тигриное неистовство"]={ class = "DRUID", level = 24, },
	["Выведение яда"]={ class = "DRUID", level = 26, },
	["Порыв"]={ class = "DRUID", level = 26, },
	["Вызывающий рев"]={ class = "DRUID", level = 28, },
	["Попятиться"]={ class = "DRUID", level = 28, },
	["Походный облик"]={ class = "DRUID", level = 30, },
	["Свирепый укус"]={ class = "DRUID", level = 32, },
	["Накинуться"]={ class = "DRUID", level = 32, },
	["Неистовое восстановление"]={ class = "DRUID", level = 36, },
	["Наскок"]={ class = "DRUID", level = 36, },
	["Облик лютого медведя"]={ class = "DRUID", level = 40, },
--++ Druid Talents ++	
	["Природный захват"]={ class = "DRUID", level = 10, },
	["Звериная атака"]={ class = "DRUID", level = 20, },
	["Рой насекомых"]={ class = "DRUID", level = 20, },
	["Знамение ясности"]={ class = "DRUID", level = 20, },
	["Волшебный огонь (сила зверя)"]={ class = "DRUID", level = 30, },
--++ Hunter Abilities ++	
	["Готовность"]={ class = "HUNTER", level = 1, },
	["Автоматическая стрельба"]={ class = "HUNTER", level = 1, },
	["Удар ящера"]={ class = "HUNTER", level = 1, },
	["Выслеживание животных"]={ class = "HUNTER", level = 1, },
	["Дух обезьяны"]={ class = "HUNTER", level = 4, },
	["Укус змеи"]={ class = "HUNTER", level = 4, },
	["Чародейский выстрел"]={ class = "HUNTER", level = 6, },
	["Метка охотника"]={ class = "HUNTER", level = 6, },
	["Шокирующий выстрел"]={ class = "HUNTER", level = 8, },
	["Дух ястреба"]={ class = "HUNTER", level = 10, },
	["Призыв питомца"]={ class = "HUNTER", level = 10, },
	["Прогнать питомца"]={ class = "HUNTER", level = 10, },
	["Кормление питомца"]={ class = "HUNTER", level = 10, },
	["Воскрешение питомца"]={ class = "HUNTER", level = 10, },
	["Приручение зверя"]={ class = "HUNTER", level = 10, },
	["Отвлекающий выстрел"]={ class = "HUNTER", level = 12, },
	["Лечение питомца"]={ class = "HUNTER", level = 12, },
	["Подрезать крылья"]={ class = "HUNTER", level = 12, },
	["Орлиный глаз"]={ class = "HUNTER", level = 14, },
	["Звериный глаз"]={ class = "HUNTER", level = 14, },
	["Отпугивание зверя"]={ class = "HUNTER", level = 14, },
	["Обжигающая ловушка"]={ class = "HUNTER", level = 16, },
	["Укус мангуста"]={ class = "HUNTER", level = 16, },
	["Залп"]={ class = "HUNTER", level = 18, },
	["Выслеживание нежити"]={ class = "HUNTER", level = 18, },
	["Дух гепарда"]={ class = "HUNTER", level = 20, },
	["Отрыв"]={ class = "HUNTER", level = 20, },
	["Замораживающая ловушка"]={ class = "HUNTER", level = 20, },
	["Жало скорпида"]={ class = "HUNTER", level = 22, },
	["Знание зверя"]={ class = "HUNTER", level = 24, },
	["Выслеживание скрытого"]={ class = "HUNTER", level = 24, },
	["Быстрая стрельба"]={ class = "HUNTER", level = 26, },
	["Выслеживание элементалей"]={ class = "HUNTER", level = 26, },
	["Ледяная ловушка"]={ class = "HUNTER", level = 28, },
	["Дух зверя"]={ class = "HUNTER", level = 30, },
	["Притвориться мертвым"]={ class = "HUNTER", level = 30, },
	["Осветительная ракета"]={ class = "HUNTER", level = 32, },
	["Выслеживание демонов"]={ class = "HUNTER", level = 32, },
	["Взрывная ловушка"]={ class = "HUNTER", level = 34, },
	["Жало гадюки"]={ class = "HUNTER", level = 36, },
	["Дух стаи"]={ class = "HUNTER", level = 40, },
	["Выслеживание великанов"]={ class = "HUNTER", level = 40, },
	["Град стрел"]={ class = "HUNTER", level = 40, },
	["Дух дикой природы"]={ class = "HUNTER", level = 46, },
	["Выслеживание драконов"]={ class = "HUNTER", level = 50, },
	["Усмиряющий выстрел"]={ class = "HUNTER", level = 60, },
--++ Hunter Talents ++	
	["Прицельный выстрел"]={ class = "HUNTER", level = 20, },
	["Сдерживание"]={ class = "HUNTER", level = 20, },
	["Контратака"]={ class = "HUNTER", level = 30, },
	["Устрашение"]={ class = "HUNTER", level = 30, },
	["Дезориентирующий выстрел"]={ class = "HUNTER", level = 30, },
	["Звериный гнев"]={ class = "HUNTER", level = 40, },
	["Жало виверны"]={ class = "HUNTER", level = 40, },
--++ Mage Abilities ++	
	["Огненный шар"]={ class = "MAGE", level = 1, },
	["Морозный доспех"]={ class = "MAGE", level = 1, },
	["Ледяная стрела"]={ class = "MAGE", level = 4, },
	["Сотворение воды"]={ class = "MAGE", level = 4, },
	["Огненный взрыв"]={ class = "MAGE", level = 6, },
	["Сотворение пищи"]={ class = "MAGE", level = 6, },
	["Чародейские снаряды"]={ class = "MAGE", level = 8, },
	["Превращение"]={ class = "MAGE", level = 8, },
	["Кольцо льда"]={ class = "MAGE", level = 10, },
	["Чародейский взрыв"]={ class = "MAGE", level = 14, },
	["Распознавание магии"]={ class = "MAGE", level = 16, },
	["Огненный столб"]={ class = "MAGE", level = 16, },
	["Снятие малого проклятия"]={ class = "MAGE", level = 18, },
	["Скачок"]={ class = "MAGE", level = 20, },
	["Снежная буря"]={ class = "MAGE", level = 20, },
	["Прилив сил"]={ class = "MAGE", level = 20, },
	["Защита от огня"]={ class = "MAGE", level = 20, },
	["Щит маны"]={ class = "MAGE", level = 20, },
	["Телепортация: Стальгорн"]={ class = "MAGE", level = 20, },
	["Телепортация: Оргриммар"]={ class = "MAGE", level = 20, },
	["Телепортация: Штормград"]={ class = "MAGE", level = 20, },
	["Телепортация:Подгород"]={ class = "MAGE", level = 20, },
	["Защита от магии льда"]={ class = "MAGE", level = 22, },
	["Ожог"]={ class = "MAGE", level = 22, },
	["Антимагия"]={ class = "MAGE", level = 24, },
	["Конус холода"]={ class = "MAGE", level = 26, },
	["Сотворение агата маны"]={ class = "MAGE", level = 28, },
	["Ледяной доспех"]={ class = "MAGE", level = 30, },
	["Телепортация: Дарнасс"]={ class = "MAGE", level = 30, },
	["Телепортация: Громовой Утес"]={ class = "MAGE", level = 30, },
	["Магический доспех"]={ class = "MAGE", level = 34, },
	["Сотворение нефрита маны"]={ class = "MAGE", level = 38, },
	["Портал в Стальгорн"]={ class = "MAGE", level = 40, },
	["Портал в Оргриммар"]={ class = "MAGE", level = 40, },
	["Портал в Штормград"]={ class = "MAGE", level = 40, },
	["Портал в Подгород"]={ class = "MAGE", level = 40, },
	["Сотворение цитрина маны"]={ class = "MAGE", level = 48, },
	["Портал: Дарнасс"]={ class = "MAGE", level = 50, },
	["Портал в Громовой Утес"]={ class = "MAGE", level = 50, },
	["Чародейская гениальность"]={ class = "MAGE", level = 56, },
	["Сотворение рубина маны"]={ class = "MAGE", level = 58, },
	["Превращение в корову"]={ class = "MAGE", level = 60, },
	["Превращение"]={ class = "MAGE", level = 60, },
	["Превращение"]={ class = "MAGE", level = 60, },
--++ Mage Talents ++	
	["Холодная хватка"]={ class = "MAGE", level = 20, },
	["Огненная глыба"]={ class = "MAGE", level = 20, },
	["Взрывная волна"]={ class = "MAGE", level = 30, },
	["Ледяная глыба"]={ class = "MAGE", level = 30, },
	["Присутствие разума"]={ class = "MAGE", level = 30, },
	["Мощь тайной магии"]={ class = "MAGE", level = 40, },
	["Возгорание"]={ class = "MAGE", level = 40, },
	["Ледяная преграда"]={ class = "MAGE", level = 40, },
--++ Paladin Abilities ++	
	["Свет небес"]={ class = "PALADIN", level = 1, },
	["Печать праведности"]={ class = "PALADIN", level = 1, },
	["Правосудие"]={ class = "PALADIN", level = 4, },
	["Божественная защита"]={ class = "PALADIN", level = 6, },
	["Печать воина Cвета"]={ class = "PALADIN", level = 6, },
	["Молот правосудия"]={ class = "PALADIN", level = 8, },
	["Очищение"]={ class = "PALADIN", level = 8, },
	["Возложение рук"]={ class = "PALADIN", level = 10, },
	["Искупление"]={ class = "PALADIN", level = 12, },
	["Праведное неистовство"]={ class = "PALADIN", level = 16, },
	["Экзорцизм"]={ class = "PALADIN", level = 20, },
	["Вспышка Света"]={ class = "PALADIN", level = 20, },
	["Чутье на нежить"]={ class = "PALADIN", level = 20, },
	["Печать справедливости"]={ class = "PALADIN", level = 22, },
	["Изгнание нежити"]={ class = "PALADIN", level = 24, },
	["Благословение спасения"]={ class = "PALADIN", level = 26, },
	["Божественное вмешательство"]={ class = "PALADIN", level = 30, },
	["Печать Cвета"]={ class = "PALADIN", level = 30, },
	["Божественный щит"]={ class = "PALADIN", level = 34, },
	["Печать мудрости"]={ class = "PALADIN", level = 38, },
	["Благословение Света"]={ class = "PALADIN", level = 40, },
	["Вызов боевого коня"]={ class = "PALADIN", level = 40, },
	["Очищение"]={ class = "PALADIN", level = 42, },
	["Молот гнева"]={ class = "PALADIN", level = 44, },
	["Гнев небес"]={ class = "PALADIN", level = 50, },
	["Призыв скакуна"]={ class = "PALADIN", level = 60, },
--++ Paladin Talents ++	
	["Освящение"]={ class = "PALADIN", level = 20, },
	["Печать повиновения"]={ class = "PALADIN", level = 20, },
	["Божественное одобрение"]={ class = "PALADIN", level = 30, },
	["Щит небес"]={ class = "PALADIN", level = 40, },
	["Шок небес"]={ class = "PALADIN", level = 40, },
	["Покаяние"]={ class = "PALADIN", level = 40, },
--++ Priest Abilities ++	
	["Малое исцеление"]={ class = "PRIEST", level = 1, },
	["Кара"]={ class = "PRIEST", level = 1, },
	["Слово Тьмы: Боль"]={ class = "PRIEST", level = 4, },
	["Уход в тень"]={ class = "PRIEST", level = 8, },
	["Молитва отчаяния"]={ class = "PRIEST", level = 10, },
	["Обессиливающий сглаз"]={ class = "PRIEST", level = 10, },
	["Взрыв разума"]={ class = "PRIEST", level = 10, },
	["Воскрешение"]={ class = "PRIEST", level = 10, },
	["Звездные осколки"]={ class = "PRIEST", level = 10, },
	["Прикосновение слабости"]={ class = "PRIEST", level = 10, },
	["Внутренний огонь"]={ class = "PRIEST", level = 12, },
	["Ментальный крик"]={ class = "PRIEST", level = 14, },
	["Исцеление"]={ class = "PRIEST", level = 16, },
	["Рассеивание заклинаний"]={ class = "PRIEST", level = 18, },
	["Всепожирающая чума"]={ class = "PRIEST", level = 20, },
	["Благодать Элуны"]={ class = "PRIEST", level = 20, },
	["Ответная реакция"]={ class = "PRIEST", level = 20, },
	["Быстрое исцеление"]={ class = "PRIEST", level = 20, },
	["Священный огонь"]={ class = "PRIEST", level = 20, },
	["Усмирение"]={ class = "PRIEST", level = 20, },
	["Сковывание нежити"]={ class = "PRIEST", level = 20, },
	["Страж Тьмы"]={ class = "PRIEST", level = 20, },
	["Внутреннее зрение"]={ class = "PRIEST", level = 22, },
	["Сожжение маны"]={ class = "PRIEST", level = 24, },
	["Контроль над разумом"]={ class = "PRIEST", level = 30, },
	["Молитва исцеления"]={ class = "PRIEST", level = 30, },
	["Снятие болезни"]={ class = "PRIEST", level = 32, },
	["Левитация"]={ class = "PRIEST", level = 34, },
	["Большее исцеление"]={ class = "PRIEST", level = 40, },
--++ Priest Talents ++	
	["Кольцо света"]={ class = "PRIEST", level = 20, },
	["Внутреннее сосредоточение"]={ class = "PRIEST", level = 20, },
	["Пытка разума"]={ class = "PRIEST", level = 20, },
	["Молчание"]={ class = "PRIEST", level = 30, },
	["Колодец Света"]={ class = "PRIEST", level = 40, },
	["Облик Тьмы"]={ class = "PRIEST", level = 40, },
--++ Rogue Abilities ++	
	["Потрошение"]={ class = "ROGUE", level = 1, },
	["Взлом замка"]={ class = "ROGUE", level = 1, },
	["Коварный удар"]={ class = "ROGUE", level = 1, },
	["Незаметность"]={ class = "ROGUE", level = 1, },
	["Удар в спину"]={ class = "ROGUE", level = 4, },
	["Обшаривание карманов"]={ class = "ROGUE", level = 4, },
	["Парализующий удар"]={ class = "ROGUE", level = 6, },
	["Ускользание"]={ class = "ROGUE", level = 8, },
	["Ошеломление"]={ class = "ROGUE", level = 10, },
	["Мясорубка"]={ class = "ROGUE", level = 10, },
	["Спринт"]={ class = "ROGUE", level = 10, },
	["Пинок"]={ class = "ROGUE", level = 12, },
	["Ослабление доспеха"]={ class = "ROGUE", level = 14, },
	["Гаррота"]={ class = "ROGUE", level = 14, },
	["Ложный выпад"]={ class = "ROGUE", level = 16, },
	["Внезапный удар"]={ class = "ROGUE", level = 18, },
	["Яды"]={ class = "ROGUE", level = 20, },
	["Рваная рана"]={ class = "ROGUE", level = 20, },
	["Калечащий яд"]={ class = "ROGUE", level = 20, },
	["Быстродействующий яд"]={ class = "ROGUE", level = 20, },
	["Отвлечение"]={ class = "ROGUE", level = 22, },
	["Исчезновение"]={ class = "ROGUE", level = 22, },
	["Обнаружение ловушек"]={ class = "ROGUE", level = 24, },
	["Дурманящий яд"]={ class = "ROGUE", level = 24, },
	["Подлый трюк"]={ class = "ROGUE", level = 26, },
	["Обезвреживание ловушки"]={ class = "ROGUE", level = 30, },
	["Удар по почкам"]={ class = "ROGUE", level = 30, },
	["Смертельный яд"]={ class = "ROGUE", level = 30, },
	["Нейтрализующий яд"]={ class = "ROGUE", level = 32, },
	["Ослепление"]={ class = "ROGUE", level = 34, },
	["Ослепляющий порошок"]={ class = "ROGUE", level = 34, },
	["Безопасное падение"]={ class = "ROGUE", level = 40, },
--++ Rogue Talents ++	
	["Призрачный удар"]={ class = "ROGUE", level = 20, },
	["Ответный удар"]={ class = "ROGUE", level = 20, },
	["Шквал клинков"]={ class = "ROGUE", level = 30, },
	["Хладнокровие"]={ class = "ROGUE", level = 30, },
	["Кровоизлияние"]={ class = "ROGUE", level = 30, },
	["Подготовка"]={ class = "ROGUE", level = 30, },
	["Выброс адреналина"]={ class = "ROGUE", level = 40, },
	["Умысел"]={ class = "ROGUE", level = 40, },
--++ Shaman Abilities ++	
	["Волна исцеления"]={ class = "SHAMAN", level = 1, },
	["Молния"]={ class = "SHAMAN", level = 1, },
	["Оружие Камнедробителя"]={ class = "SHAMAN", level = 1, },
	["Земной шок"]={ class = "SHAMAN", level = 4, },
	["Тотем каменной кожи"]={ class = "SHAMAN", level = 4, },
	["Тотем оков земли"]={ class = "SHAMAN", level = 6, },
	["Щит молний"]={ class = "SHAMAN", level = 8, },
	["Тотем каменного когтя"]={ class = "SHAMAN", level = 8, },
	["Огненный шок"]={ class = "SHAMAN", level = 10, },
	["Оружие языка пламени"]={ class = "SHAMAN", level = 10, },
	["Опаляющий тотем"]={ class = "SHAMAN", level = 10, },
	["Тотем силы земли"]={ class = "SHAMAN", level = 10, },
	["Дух предков"]={ class = "SHAMAN", level = 12, },
	["Тотем кольца огня"]={ class = "SHAMAN", level = 12, },
	["Развеяние магии"]={ class = "SHAMAN", level = 12, },
	["Тотем трепета"]={ class = "SHAMAN", level = 18, },
	["Ледяной шок"]={ class = "SHAMAN", level = 20, },
	["Оружие ледяного клейма"]={ class = "SHAMAN", level = 20, },
	["Призрачный волк"]={ class = "SHAMAN", level = 20, },
	["Тотем исцеляющего потока"]={ class = "SHAMAN", level = 20, },
	["Малая волна исцеления"]={ class = "SHAMAN", level = 20, },
	["Тотем противоядия"]={ class = "SHAMAN", level = 22, },
	["Тотем сопротивления льду"]={ class = "SHAMAN", level = 24, },
	["Дальнее зрение"]={ class = "SHAMAN", level = 26, },
	["Тотем магмы"]={ class = "SHAMAN", level = 26, },
	["Тотем источника маны"]={ class = "SHAMAN", level = 26, },
	["Тотем сопротивления огню"]={ class = "SHAMAN", level = 28, },
	["Тотем языка пламени"]={ class = "SHAMAN", level = 28, },
	["Астральное возвращение"]={ class = "SHAMAN", level = 30, },
	["Тотем заземления"]={ class = "SHAMAN", level = 30, },
	["Тотем сопротивления силам природы"]={ class = "SHAMAN", level = 30, },
	["Восстание из мертвых"]={ class = "SHAMAN", level = 30, },
	["Оружие неистовства ветра"]={ class = "SHAMAN", level = 30, },
	["Цепная молния"]={ class = "SHAMAN", level = 32, },
	["Тотем неистовства ветра"]={ class = "SHAMAN", level = 32, },
	["Сторожевой тотем"]={ class = "SHAMAN", level = 34, },
	["Тотем стены ветра"]={ class = "SHAMAN", level = 36, },
	["Тотем очищения от болезней"]={ class = "SHAMAN", level = 38, },
	["Цепное исцеление"]={ class = "SHAMAN", level = 40, },
	["Тотем легкости воздуха"]={ class = "SHAMAN", level = 42, },
	["Тотем безветрия"]={ class = "SHAMAN", level = 50, },
--++ Shaman Talents ++	
	["Парирование"]={ class = "SHAMAN", level = 30, },
	["Покорение стихий"]={ class = "SHAMAN", level = 40, },
	["Тотем прилива маны"]={ class = "SHAMAN", level = 40, },
	["Удар бури"]={ class = "SHAMAN", level = 40, },
--++ Warlock Abilities ++	
	["Шкура демона"]={ class = "WARLOCK", level = 1, },
	["Жертвенный огонь"]={ class = "WARLOCK", level = 1, },
	["Стрела Тьмы"]={ class = "WARLOCK", level = 1, },
	["Призыв беса"]={ class = "WARLOCK", level = 1, },
	["Порча"]={ class = "WARLOCK", level = 4, },
	["Проклятие слабости"]={ class = "WARLOCK", level = 4, },
	["Жизнеотвод"]={ class = "WARLOCK", level = 6, },
	["Проклятие агонии"]={ class = "WARLOCK", level = 8, },
	["Страх"]={ class = "WARLOCK", level = 8, },
	["Создание слабого камня здоровья"]={ class = "WARLOCK", level = 10, },
	["Похищение души"]={ class = "WARLOCK", level = 10, },
	["Призыв демона Бездны"]={ class = "WARLOCK", level = 10, },
	["Канал здоровья"]={ class = "WARLOCK", level = 12, },
	["Проклятие безрассудства"]={ class = "WARLOCK", level = 14, },
	["Похищение жизни"]={ class = "WARLOCK", level = 14, },
	["Нескончаемое дыхание"]={ class = "WARLOCK", level = 16, },
	["Жгучая боль"]={ class = "WARLOCK", level = 18, },
	["Создание крошечного камня души"]={ class = "WARLOCK", level = 18, },
	["Демонический доспех"]={ class = "WARLOCK", level = 20, },
	["Огненный ливень"]={ class = "WARLOCK", level = 20, },
	["Ритуал призывания"]={ class = "WARLOCK", level = 20, },
	["Призыв суккуба"]={ class = "WARLOCK", level = 20, },
	["Создание малого камня здоровья"]={ class = "WARLOCK", level = 22, },
	["Око Килрогга"]={ class = "WARLOCK", level = 22, },
	["Похищение маны"]={ class = "WARLOCK", level = 24, },
	["Чутье на демонов"]={ class = "WARLOCK", level = 24, },
	["Проклятие косноязычия"]={ class = "WARLOCK", level = 26, },
	["Обнаружение обычной невидимости"]={ class = "WARLOCK", level = 26, },
	["Изгнание"]={ class = "WARLOCK", level = 28, },
	["Создание малого камня огня"]={ class = "WARLOCK", level = 28, },
	["Порабощение демона"]={ class = "WARLOCK", level = 30, },
	["Адское Пламя"]={ class = "WARLOCK", level = 30, },
	["Призыв охотника Скверны"]={ class = "WARLOCK", level = 30, },
	["Создание малого камня души"]={ class = "WARLOCK", level = 30, },
	["Проклятие стихий"]={ class = "WARLOCK", level = 32, },
	["Защита от темной магии"]={ class = "WARLOCK", level = 32, },
	["Создание камня здоровья"]={ class = "WARLOCK", level = 34, },
	["Создание камня огня"]={ class = "WARLOCK", level = 36, },
	["Создание камня чар"]={ class = "WARLOCK", level = 36, },
	["Обнаружение невидимости"]={ class = "WARLOCK", level = 38, },
	["Вой ужаса"]={ class = "WARLOCK", level = 40, },
	["Призывание коня Скверны"]={ class = "WARLOCK", level = 40, },
	["Создание камня души"]={ class = "WARLOCK", level = 40, },
	["Лик смерти"]={ class = "WARLOCK", level = 42, },
	["Проклятие Тьмы"]={ class = "WARLOCK", level = 44, },
	["Создание большого камня здоровья"]={ class = "WARLOCK", level = 46, },
	["Создание большого камня огня"]={ class = "WARLOCK", level = 46, },
	["Ожог души"]={ class = "WARLOCK", level = 48, },
	["Создание большого камня чар"]={ class = "WARLOCK", level = 48, },
	["Обнаружение большей невидимости"]={ class = "WARLOCK", level = 50, },
	["Инфернал"]={ class = "WARLOCK", level = 50, },
	["Создание большого камня души"]={ class = "WARLOCK", level = 50, },
	["Создание крупного камня огня"]={ class = "WARLOCK", level = 56, },
	["Создание крупного камня здоровья"]={ class = "WARLOCK", level = 58, },
	["Проклятие рока"]={ class = "WARLOCK", level = 60, },
	["Ритуал Рока"]={ class = "WARLOCK", level = 60, },
	["Призыв коня погибели"]={ class = "WARLOCK", level = 60, },
	["Создание крупного камня души"]={ class = "WARLOCK", level = 60, },
	["Создание крупного камня чар"]={ class = "WARLOCK", level = 60, },
--++ Warlock Talents ++	
	["Усиление проклятия"]={ class = "WARLOCK", level = 20, },
	["Господство Скверны"]={ class = "WARLOCK", level = 20, },
	["Ожог Тьмы"]={ class = "WARLOCK", level = 20, },
	["Проклятие изнеможения"]={ class = "WARLOCK", level = 30, },
	["Демоническое жертвоприношение"]={ class = "WARLOCK", level = 30, },
	["Вытягивание жизни"]={ class = "WARLOCK", level = 30, },
	["Поджигание"]={ class = "WARLOCK", level = 40, },
	["Темный союз"]={ class = "WARLOCK", level = 40, },
	["Связка души"]={ class = "WARLOCK", level = 40, },
--++ Warrior Abilities ++	
	["Боевая стойка"]={ class = "WARRIOR", level = 1, },
	["Удар героя"]={ class = "WARRIOR", level = 1, },
	["Улучшенная зуботычина"]={ class = "WARRIOR", level = 1, },
	["Рывок"]={ class = "WARRIOR", level = 4, },
	["Кровопускание"]={ class = "WARRIOR", level = 4, },
	["Удар грома"]={ class = "WARRIOR", level = 6, },
	["Подрезать сухожилия"]={ class = "WARRIOR", level = 8, },
	["Кровавая ярость"]={ class = "WARRIOR", level = 10, },
	["Оборонительная стойка"]={ class = "WARRIOR", level = 10, },
	["Раскол брони"]={ class = "WARRIOR", level = 10, },
	["Провокация"]={ class = "WARRIOR", level = 10, },
	["Превосходство"]={ class = "WARRIOR", level = 12, },
	["Удар щитом"]={ class = "WARRIOR", level = 12, },
	["Деморализующий крик"]={ class = "WARRIOR", level = 14, },
	["Реванш"]={ class = "WARRIOR", level = 14, },
	["Дразнящий удар"]={ class = "WARRIOR", level = 16, },
	["Блок щитом"]={ class = "WARRIOR", level = 16, },
	["Разоружение"]={ class = "WARRIOR", level = 18, },
	["Рассекающий удар"]={ class = "WARRIOR", level = 20, },
	["Возмездие"]={ class = "WARRIOR", level = 20, },
	["Устрашающий крик"]={ class = "WARRIOR", level = 22, },
	["Казнь"]={ class = "WARRIOR", level = 24, },
	["Вызывающий крик"]={ class = "WARRIOR", level = 26, },
	["Глухая оборона"]={ class = "WARRIOR", level = 28, },
	["Стойка берсерка"]={ class = "WARRIOR", level = 30, },
	["Перехват"]={ class = "WARRIOR", level = 30, },
	["Сокрушение"]={ class = "WARRIOR", level = 30, },
	["Ярость берсерка"]={ class = "WARRIOR", level = 32, },
	["Вихрь"]={ class = "WARRIOR", level = 36, },
	["Зуботычина"]={ class = "WARRIOR", level = 38, },
	["Безрассудство"]={ class = "WARRIOR", level = 50, },
--++ Warrior Talents ++	
	["Ни шагу назад"]={ class = "WARRIOR", level = 20, },
	["Пронзительный вой"]={ class = "WARRIOR", level = 20, },
	["Оглушающий удар"]={ class = "WARRIOR", level = 30, },
	["Инстинкт смерти"]={ class = "WARRIOR", level = 30, },
	["Размашистые удары"]={ class = "WARRIOR", level = 30, },
	["Кровожадность"]={ class = "WARRIOR", level = 40, },
	["Смертельный удар"]={ class = "WARRIOR", level = 40, },
	["Сокрушение щитом"]={ class = "WARRIOR", level = 40, },
};

Spy_IgnoreList = {

};
 
