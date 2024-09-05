Narci.L = {};
Narci.L.S = {};     --Statistics;

local L = Narci.L;
local S = Narci.L.S;

NARCI_GRADIENT = "|cfffcca38N|r|cfff5cb45a|r|cffeecc50r|r|cffe6cd5bc|r|cffdece65i|r|cffd6ce6es|r|cffcdce77s|r|cffc4ce80u|r|cffb9ce89s|r"

L["Developer Info"] = "Developed by Peterodox";

NARCI_NEW_ENTRY_PREFIX = "|cff40C7EB";
NARCI_COLOR_GREY_85 = "|cffd8d8d8";
NARCI_COLOR_GREY_70 = "|cffb3b3b3";
NARCI_COLOR_RED_MILD = "|cffff5050";
NARCI_COLOR_GREEN_MILD = "|cff7cc576";
NARCI_COLOR_YELLOW = "|cfffced00";
NARCI_COLOR_CYAN_DARK = "5385a5";
NARCI_COLOR_PINK_DARK = "da9bc3";

NARCI_MODIFIER_CONTROL = "Ctrl";
NARCI_MODIFIER_ALT = "Alt";   --Windows
NARCI_SHORTCUTS_COPY = "Ctrl+C";

NARCI_MOUSE_BUTTON_ICON_1 = "|TInterface\\AddOns\\Narcissus\\Art\\Keyboard\\Mouse-Small:16:16:0:0:64:16:0:16:0:16|t";   --Left Button
NARCI_MOUSE_BUTTON_ICON_2 = "|TInterface\\AddOns\\Narcissus\\Art\\Keyboard\\Mouse-Small:16:16:0:0:64:16:16:32:0:16|t";   --Right Button
NARCI_MOUSE_BUTTON_ICON_3 = "|TInterface\\AddOns\\Narcissus\\Art\\Keyboard\\Mouse-Small:16:16:0:0:64:16:32:48:0:16|t";   --Middle Button

if IsMacClient() then
    --Mac OS
    NARCI_MODIFIER_CONTROL = "Command";
    NARCI_MODIFIER_ALT = "Option";
    NARCI_SHORTCUTS_COPY = "Command+C";
end

NARCI_WORDBREAK_COMMA = ", ";

NARCI_CLASSIC_NOT_AVAILABLE = "|cffff5050Currently not available in Classic|r";

--Date--
L["Today"] = COMMUNITIES_CHAT_FRAME_TODAY_NOTIFICATION;
L["Yesterday"] = COMMUNITIES_CHAT_FRAME_YESTERDAY_NOTIFICATION;
L["Format Days Ago"] = "%d days ago";
L["A Month Ago"] = "1 month ago";
L["Format Months Ago"] = "%d months ago";
L["A Year Ago"] = "1 year ago";
L["Format Years Ago"] = "%d years ago";
L["Version Colon"] = (GAME_VERSION_LABEL or "Version")..": ";
L["Date Colon"] = "Date: ";
L["Day Plural"] = "Days";
L["Day Singular"] = "Day";
L["Hour Plural"] = "Hours";
L["Hour Singular"] = "Hour";

L["Swap items"] = "Swap items";
L["Press Copy"] = NARCI_COLOR_GREY_70.. "Press |r".. NARCI_SHORTCUTS_COPY.. NARCI_COLOR_GREY_70 .." to Copy";
L["Copied"] = NARCI_COLOR_GREEN_MILD.. "Link Copied";

L["Movement Speed"] = "MSPD";
L["Damage Reduction Percentage"] = "DR%";

L["Advanced Info"] = "Left click to toggle advanced info.";

L["Restore On Exit"] = "\nYour previous settings will be restored after exit.";

L["Photo Mode"] = "Photo Mode";
L["Photo Mode Tooltip Open"] = "Open the screenshot toolbox.";
L["Photo Mode Tooltip Close"] = "Close the screenshot toolbox.";
L["Photo Mode Tooltip Special"] = "Your captured screenshots in the WoW Screenshots folder will not include this widget.";

L["Toolbar Mog Button"] = "Photo Mode";
L["Toolbar Mog Button Tooltip"] = "Showcase your transmog or create a photo booth where you can add other players and NPCs.";

L["Toolbar Emote Button"] = "Do Emote";
L["Toolbar Emote Button Tooltip"] = "Use the emotes with unique animations.";
L["Auto Capture"] = "Auto Capture";

L["Toolbar HideTexts Button"] = "Hide Texts";
L["Toolbar HideTexts Button Tooltip"] = "Hide all names, chat bubbles and combat texts." ..L["Restore On Exit"];

L["Toolbar TopQuality Button"] = "Top Quality";
L["Toolbar TopQuality Button Tooltip"] = "Set every option in the graphics settings to max." ..L["Restore On Exit"];

L["Toolbar Location Button"] = "Player Location";
L["Toolbar Location Button Tooltip"] = "Show current zone name and player's coordinates."

L["Toolbar Camera Button"] = "Camera";
L["Toolbar Camera Button Tooltip"] = "Temporarily change camera settings."

L["Toolbar Preferences Button Tooltip"] = "Open Preferences panel.";

--Special Source--
L["Heritage Armor"] = "Heritage Armor";
L["Secret Finding"] = "Secret Finding";

--Title Manager--
L["Open Title Manager"] = "Open Title Manager";
L["Close Title Manager"] = "Close Title Manager";

--Alias--
L["Use Alias"] = "Switch to Alias";
L["Use Player Name"] = "Switch to "..CALENDAR_PLAYER_NAME;

L["Minimap Tooltip Double Click"] = "Double-tap";
L["Minimap Tooltip Left Click"] = "Left-click|r";
L["Minimap Tooltip To Open"] = "|cffffffffOpen "..CHARACTER_INFO;
L["Minimap Tooltip Module Panel"] = "|cffffffffOpen Module Panel";
L["Minimap Tooltip Right Click"] = "Right-click";
L["Minimap Tooltip Shift Left Click"] = "Shift + Left-click";
L["Minimap Tooltip Shift Right Click"] = "Shift + Right-click";
L["Minimap Tooltip Hide Button"] = "|cffffffffHide this button|r"
L["Minimap Tooltip Middle Button"] = "|CFFFF1000Middle button |cffffffffReset camera";
L["Minimap Tooltip Set Scale"] = "Set Scale: |cffffffff/narci [scale 0.8~1.2]";
L["Corrupted Item Parser"] = "|cffffffffToggle Corrupted Item Parser|r";
L["Toggle Dressing Room"] = "|cffffffffToggle "..DRESSUP_FRAME.."|r";
L["Layout"] = "Layout";
L["Symmetry"] = "Symmetry";
L["Asymmetry"] = "Asymmetry";
L["Copy Texts"] = "Copy Texts";
L["Syntax"] = "Syntax";
L["Plain Text"] = "Plain Text";
L["BB Code"] = "BB Code";
L["Markdown"] = "Markdown";
L["Export Includes"] = "Export Includes...";
L["3D Model"] = "3D Model";
L["Equipment Slots"] = "Equipment Slots";

--Preferences--
L["Override"] = "Override";
L["Invalid Key"] = "Invalid key combination.";

L["Preferences"] = "Preferences";
L["Preferences Tooltip"] = "Click to open Preferences Panel.";
L["Extensions"] = "Extensions";
L["About"] = "About";
L["Image Filter"] = "Filters";    --Image filter
L["Image Filter Description"] = "All filters except vignette will be disabled in transmog mode.";
L["Grain Effect"] = "Grain Effect";
L["Fade Music"] = "Fade Music In/Out";
L["Vignette Strength"] = "Vignette Strength";
L["Weather Effect"] = "Weather Effect";
L["Letterbox"] = "Letterbox";
L["Letterbox Ratio"] = "Ratio";
L["Letterbox Alert1"] = "The aspect ratio of your monitor exceeds the selected ratio!"
L["Letterbox Alert2"] = "It is recommend to set the UI Scale to %0.1f\n(the current scale is %0.1f)"
L["Default Layout"] = "Default Layout";
L["Transmog Layout1"] = "Symmetry, 1 Model";
L["Transmog Layout2"] = "2 Models";
L["Transmog Layout3"] = "Compact Mode";
L["Always Show Model"] = "Show 3D Model While Using Symmetry Layout";
L["AFK Screen Description"] = "Open Narcissus when yo go AFK";
L["AFK Screen Description Extra"] = "This will override ElvUI AFK Mode.";
L["AFK Screen Delay"] = "After a Cancellable Delay";
L["Item Names"] = "Item Names";
L["Open Narcissus"] = "Open Narcissus";
L["Character Panel"] = "Character Panel";
L["Screen Effects"] ="Screen Effects";

L["Gemma"] = "\"Gemma\"";   --Don't translate
L["Gemma Description"] = "Show a list of gems when socketing an item.";
L["Gem Manager"] = "Gem Manager";
L["Dressing Room"] = "Dressing Room"
L["Dressing Room Description"] = "Bigger dressing room pane with the abilities to view and copy other players' item lists and generate Wowhead dressing room links.";
L["General"] = "General";   --General options
L["Interface"] = "Interface";
L["Shortcuts"] = "Shortcuts";
L["Themes"] = "Themes";
L["Effects"] = "Effects";   --UI effect
L["Camera"] = "Camera";
L["Transmog"] = "Transmog";
L["Credits"] = "Credits";
L["Border Theme Header"] = "Border Theme";
L["Border Theme Bright"] = "Bright";
L["Border Theme Dark"] = "Dark";
L["Text Width"] = "Text Width";
L["Truncate Text"] = "Truncate Text";
L["Stat Sheet"] = "Stat Sheet";
L["Minimap Button"] = "Minimap Button";
L["Fade Out"] = "Fade Out On Mouseout";
L["Fade Out Description"] = "Fades Out When Mouseout";
L["Hotkey"] = "Hotkey";
L["Double Tap"] = "Enable Double-tap";
L["Double Tap Description"] = "Double-tap the key bound to Character Pane to open Narcissus.";
L["Show Detailed Stats"] = "Show Detailed Stats";
L["Tooltip Color"] = "Tooltip Color";
L["Entrance Visual"] = "Entrance Visual";
L["Entrance Visual Description"] = "Play spell visuals when your model shows up.";
L["Panel Scale"] = "Panel Scale";
L["Exit Confirmation"] = "Exit Confirmation";
L["Exit Confirmation Texts"] = "Quit group photo?";
L["Exit Confirmation Leave"] = "Yes";
L["Exit Confirmation Cancel"] = "No";
L["Ultra-wide"] = "Ultra-wide";
L["Ultra-wide Optimization"] = "Ultra-wide Optimization";
L["Baseline Offset"] = "Baseline Offset";
L["Ultra-wide Tooltip"] = "You can see this option because you are using a %s:9 monitor.";
L["Interactive Area"] = "Interactable  Area";
L["Item Socketing Tooltip"] = "Click and hold to embed";
L["No Available Gem"] = "|cffd8d8d8No available gem|r";
L["Use Bust Shot"] = "Zoom to Upper Body";
L["Use Escape Button"] = "Exit Narcissus By Pressing |cffffdd10(Esc)|r";
L["Use Escape Button Description"] = "Alternatively, you can click the hidden X button on the top-right of your screen to exit.";
L["Show Module Panel Gesture"] = "Show Module Panel On Mouseover";
L["Independent Minimap Button"] = "Unaffected By Other Addons";
L["AFK Screen"] = "AFK Screen";
L["None"] = "None";
L["NPC"] = "NPC";
L["Database"] = "Database";
L["Creature Tooltip"] = "Creature Tooltip";
L["RAM Usage"] = "RAM Usage";
L["Others"] = "Others";
L["Find Relatives"] = "Find Relatives";
L["Find Related Creatures Description"] = "Search for creatures with the same last name.";
L["Find Relatives Hotkey Format"] = "Press %s to find relatives.";
L["Translate Names"] = "Translate Names";
L["Translate Names Description On"] = "Show unit's translated name(s) on...";
L["Translate Names Description Off"] = "";
L["Select A Language"] = "Selected languge:";
L["Select Multiple Languages"] = "Selected languges:";
L["Load on Demand"] = "Load on Demand";
L["Load on Demand Description On"] = "Don't load database until using search functions.";
L["Load on Demand Description Off"] = "Load creature database when you log in.";
L["Load on Demand Description Disabled"] = NARCI_COLOR_YELLOW.. "This toggle is locked because you have enabled creature tooltip.";
L["Tooltip"] = "Tooltip";
L["Name Plate"] = "Name Plate";
L["Y Offset"] = "Y Offset";
L["Sceenshot Quality"] = "Sceenshot Quality";
L["Screenshot Quality Description"] = "Higher quality results in bigger file size.";
L["Camera Movement"] = "Camera Movement";
L["Orbit Camera"] = "Orbit Camera";
L["Orbit Camera Description On"] = "When you open this character panel, the camera will be rotated to your front and begin orbiting.";
L["Orbit Camera Description Off"] = "When you open this character panel, the camera will be zoomed in without rotation";
L["Camera Safe Mode"] = "Camera Safe Mode";
L["Camera Safe Mode Description"] = "Fully disable ActionCam feature after closing this addon.";
L["Camera Safe Mode Description Extra"] = "Untoggled because you are using DynamicCam."
L["Camera Transition"] = "Camera Transition";
L["Camera Transition Description On"] = "Camera will move smoothly to the predetermined position when you open this character panel.";
L["Camera Transition Description Off"] = "Camera transition becomes instant. Starts from the second time you use this character panel.\nInstant transition will override camera preset #4.";
L["Interface Options Tab Description"] = "You can also access the this panel by clicking the gear button next to the toolbar on the bottom left of your screen while using Narcissus.";
L["Soulbinds"] = COVENANT_PREVIEW_SOULBINDS;
L["Item Tooltip"] = "Item Tooltip";
L["Style"] = "Style";
L["Tooltip Style 1"] = "Next Generation";
L["Tooltip Style 2"] = "The Original";
L["Addtional Info"] = "Additional Info";
L["Item ID"] = "Item ID";
L["Paperdoll"] = "Paper Doll";
L["Equipment Manager Description"] = "Save Equipment Sets to switch items quickly.";
L["Equipment Manager Replacement"] = NARCI_COLOR_YELLOW.. "This button will not show up because you have enabled WoW's own equipment manager.|r";    --WotLK: Notify user that the toggle won't show up if they enable game's own Equipment Manager
L["Item Flyout"] = "Item Flyout";
L["Item Flyout Description"] = string.format("Show compatible items when you mouse over equipment slots and press [%s].", NARCI_MODIFIER_ALT);
L["Camera Reset Notification"] = "Camera offset has been reset to zero. If you wish to disable this feature, go to Preferences - Camera, then toggle off Camera Safe Mode.";
L["Binding Name Open Narcissus"] = "Open Narcissus Character Panel";
L["Developer Colon"] = "Developer: ";
L["Project Page"] = "Project Page";
L["Press Copy Yellow"] = "Press |cffffd100".. NARCI_SHORTCUTS_COPY .."|r to Copy";
L["New Option"] = NARCI_NEW_ENTRY_PREFIX.." NEW".."|r"
L["Expansion Features"] = "Expansion Features";
L["Loop Animation"] = "Loop Animation";
L["Speedy Screenshot Alert"] = "Remove \"UI Hidden\" Message";

--Model Control--
L["Ranged Weapon"] = "Ranged Weapon";
L["Melee Animation"] = "Melee Animation";
L["Spellcasting"] = "Spellcasting";
L["Link Light Sources"] = "Link Light Sources";
L["Link Model Scales"] = "Link Model Scales";
L["Hidden"] = "Hidden";
L["Light Types"] = "Directional/Ambient Light";
L["Light Types Tooltip"] = "Switch between\n- Directional light that can be blocked by object and cast shadow\n- Ambient light that influences the entire model";

L["Group Photo"] = "Group Photo";
L["Reset"] = "Reset";
L["Actor Index"] = "Index";
L["Move To Font"] = "|cff40c7ebFront|r";
L["Actor Index Tooltip"] = "Drag an index button to change the model's layer.";
L["Play Button Tooltip"] = NARCI_MOUSE_BUTTON_ICON_1.."Play this animation\n"..NARCI_MOUSE_BUTTON_ICON_2.."Resume all models\' animations";
L["Pause Button Tooltip"] = NARCI_MOUSE_BUTTON_ICON_1.."Pause this animation\n"..NARCI_MOUSE_BUTTON_ICON_2.."Pause all models\' animations";
L["Save Layers"] = "Save Layers";
L["Save Layers Tooltip"] = "Automatically capture 6 screenshots for picture compositing.\nPlease do not move your cursor or click any buttons during this process. Otherwise, your character could becomes invisible after exiting the addon. Should it happen, use this command:\n/console showplayer";
L["Ground Shadow"] = "Ground Shadow";
L["Ground Shadow Tooltip"] = "Add a movable ground shadow beneath you model.";
L["Hide Player"] = "Hide Player";
L["Hide Player Tooltip"] = "Make your character invisible to yourself.";
L["Virtual Actor"] = "Virtual";
L["Virtual Actor Tooltip"] = "Only the spell visual on this model is visible."
L["Self"] = "Self";
L["Target"] = "Target";
L["Compact Mode Tooltip"] = "Only use the left part of your screen to present your transmog.";
L["Toggle Equipment Slots"] = "Toggle equipment slots";
L["Toggle Text Mask"] = "Toggle text mask";
L["Toggle 3D Model"] = "Toggle 3D model";
L["Toggle Model Mask"] = "Toggle model mask";
L["Show Color Sliders"] = "Show color sliders";
L["Show Color Presets"] = "Show color presets";
L["Keep Current Form"] = "Hold "..NARCI_MODIFIER_ALT.." to keep shapeshift form.";
L["Race Change Tooltip"] = "Change to another playerable race";
L["Sex Change Tooltip"] = "Change sex";
L["Show More options"] = "Show More options";
L["Show Less Options"] = "Show Less Options";
L["Shadow"] = "Shadow";
L["Light Source"] = "Light Source";
L["Light Source Independent"] = "Independent";
L["Light Source Interconnected"] = "Interconnected";


--Animation Browser--
L["Animation"] = "Animation";
L["Animation Tooltip"] = "Browse, search animations";
L["Animation Variation"] = "Variation";
L["Reset Slider"] = "Reset to zero";


--Spell Visual Browser--
L["Visuals"] = "Visuals";
L["Visual ID"] = "Visual ID";
L["Animation ID Abbre"] = "Anim. ID";
L["Category"] = "Category";
L["Sub-category"] = "Sub-category";
L["My Favorites"] = "My Favorites";
L["Reset Visual Tooltip"] = "Remove unapplied visuals";
L["Remove Visual Tooltip"] = "Left-click: Remove a selected visual\nLong-click: Remove all applied visuals";
L["Apply"] = "Apply";
L["Applied"] = "Applied";   --Viusals that were "Applied" to the model
L["Remove"] = "Remove";
L["Rename"] = "Rename";
L["Refresh Model"] = "Refresh Model";
L["Toggle Browser"] = "Toggle spell visual browser";
L["Next And Previous"] = NARCI_MOUSE_BUTTON_ICON_1.."Go to next\n"..NARCI_MOUSE_BUTTON_ICON_2.."Go to previous";
L["New Favorite"] = "New Favorite";
L["Favorites Add"] = "Add to My Favorites";
L["Favorites Remove"] = "Remove from Favorites";
L["Auto-play"] = "Auto-play";   --Auto-play suggested animation
L["Auto-play Tooltip"] = "Auto-play the animation\nthat is tied to the selected visual.";
L["Delete Entry Plural"] = "Will delete %s entries";
L["Delete Entry Singular"] = "Will delete %s entry";
L["History Panel Note"] = "Applied visuals will be shown here";
L["Return"] = "Return";
L["Close"] = "Close";
L["Change Pack"] = "Change Pack";

--Dressing Room--
L["Undress"] = "Undress";
L["Favorited"] = "Favorited";
L["Unfavorited"] = "Unfavorited";
L["Item List"] = "Item List";
L["Use Target Model"] = "Use Target's Model";
L["Use Your Model"] = "Use Your Model";
L["Cannot Inspect Target"] = "Cannot Inspect Target"
L["External Link"] = "External Link";
L["Add to MogIt Wishlist"] = "Add to MogIt Wishlist";
L["Show Taint Solution"] = "How to solve this issue?";
L["Taint Solution Step1"] = "1. Reload your UI.";
L["Taint Solution Step2"] = "2. "..NARCI_MODIFIER_CONTROL.." + Left-click on an item to open the dressing room.";

--NPC Browser--
NARCI_NPC_BROWSER_TITLE_LEVEL = ".*%?%?.?";      --Level ?? --Use this to check if the second line of the tooltip is NPC's title or unit type
L["NPC Browser"] = "NPC Browser";
L["NPC Browser Tooltip"] = "Choose an NPC from the list.";
L["Search for NPC"] = "Search for NPC";
L["Name or ID"] = "Name or ID";
L["NPC Has Weapons"] = "Has Signiture Weapons";
L["Retrieving NPC Info"] = "Retrieving NPC Info";
L["Loading Database"] = "Loading Database...\nYour screen could freeze for a few seconds.";
L["Other Last Name Format"] = "Other "..NARCI_COLOR_GREY_70.."%s(s)|r:\n";
L["Too Many Matches Format"] = "\nOver %s matches.";

--Solving Lower-case or Abbreviation Issue--
NARCI_STAT_STRENGTH = SPEC_FRAME_PRIMARY_STAT_STRENGTH;
NARCI_STAT_AGILITY = SPEC_FRAME_PRIMARY_STAT_AGILITY;
NARCI_STAT_INTELLECT = SPEC_FRAME_PRIMARY_STAT_INTELLECT;
NARCI_CRITICAL_STRIKE = STAT_CRITICAL_STRIKE;


--Equipment Comparison--
NARCI_AZERITE_POWERS = "Azerite Powers";
L["Gem Tooltip Format1"] = "%s and %s";
L["Gem Tooltip Format2"] = "%s, %s and %s more...";

--Equipment Set Manager
L["Equipped Item Level Format"] = "Equipped %s";
L["Equipped Item Level Tooltip"] = "The average item level of your currently equipped items.";
L["Equipment Manager"] = EQUIPMENT_MANAGER;
L["Toggle Equipment Set Manager"] = "Click to toggle Equipment Manager.";
L["Duplicated Set"] = "Duplicated Set";
L["Low Item Level"] = "Low item level";
L["1 Missing Item"] = "1 missing item";
L["n Missing Items"] = "%s missing items";
L["Update Items"] = "Update Items";
L["Don't Update Items"] = "Don't Update Items";
L["Update Talents"] = "Update Talents";
L["Don't Update Talents"] = "Don't Update Talents";
L["Old Icon"] = "Old Icon";
L["NavBar Saved Sets"] = "Saved";   --A Saved Equipment Set
L["NavBar Incomplete Sets"] = INCOMPLETE;
L["Cannot Unequip Combat"] = "Cannot change equip status while in combat";
L["Equipment Gesture Use"] = "Double-click to Use";
L["Equipment Gesture Edit"] = "Right-click to Edit";
L["Equipment Gesture Create"] = "Click to Create";
L["Equipment Overwrite"] = "Overwrite";     --overwrite items
L["Equipment Overwrite Items"] = "Overwrite Items";
L["Equipment Overwrite Tooltip"] = "Click and hold to overwrite this set using current equipment.";
L["Equipment Overwrite Same"] = "No equipment is changed.";
L["Equipment Delete Set"] = "Delete Set";
L["Equipment Delete Tooltip"] = "Click and hold to delete this set.";
L["Equipment Save Name"] = "Save name and icon.";
L["Item Switching In Progress"] = "Switching...";


NARCI_ICON_SELECTOR = "Icon Selector";
NARCI_DELETE_SET_WITH_LONG_CLICK = "Delete Set\n|cff808080(click and hold)|r";

--Corruption System
L["Corruption System"] = "Corruption";
L["Eye Color"] = "Eye Color";
L["Blizzard UI"] = "Blizzard UI";
L["Corruption Bar"] = "Corruption Bar";
L["Corruption Bar Description"] = "Enable the corruption bar next to the Character Pane.";
L["Corruption Debuff Tooltip"] = "Debuff Tooltip";
L["Corruption Debuff Tooltip Description"] = "Replace the default negative effects tooltip with its numeric counterpart.";
L["No Corrupted Item"] = "You haven't equipped any corrupted item.";

L["Crit Gained"] = CRIT_ABBR.." Gained";
L["Haste Gained"] = STAT_HASTE.." Gained";
L["Mastery Gained"] = STAT_MASTERY.." Gained";
L["Versatility Gained"] = STAT_VERSATILITY.." Gained";

L["Proc Crit"] = "Proc "..CRIT_ABBR;
L["Proc Haste"] = "Proc "..STAT_HASTE;
L["Proc Mastery"] = "Proc "..STAT_MASTERY;
L["Proc Versatility"] =  "Proc "..STAT_VERSATILITY;

L["Critical Damage"] = CRIT_ABBR.."DMG";

L["Corruption Effect Format1"] = "|cffffffff%s%%|r speed reduced";
L["Corruption Effect Format2"] = "|cffffffff%s|r initial damage\n|cffffffff%s yd|r radius";
L["Corruption Effect Format3"] = "|cffffffff%s|r damage\n|cffffffff%s%%|r of your HP";
L["Corruption Effect Format4"] = "Struck by the Thing From Beyond triggers other debuffs";
L["Corruption Effect Format5"] = "|cffffffff%s%%|r damage\\healing taken modified";

--Text Overlay Frame
L["Text Overlay Button Tooltip1"] = "Simple Speech Balloon";
L["Text Overlay Button Tooltip2"] = "Advanced Speech Balloon";
L["Text Overlay Button Tooltip3"] = "Talking Head";
L["Text Overlay Button Tooltip4"] = "Floating Subtitle";
L["Text Overlay Button Tooltip5"] = "Black Bar Subtitle";
L["Visibility"] = "Visibility";

--Achievement Frame--
L["Use Achievement Panel"] = "Use As Primary Achievement Panel";
L["Use Achievement Panel Description"] = "Replace the default achievement toast. Enable tooltip enhancement. Click tracked achievements to open this panel.";
L["Incomplete First"] = "Incomplete First";
L["Earned First"] = "Earned First";
L["Settings"] = "Settings";
L["Next Prev Card"] = "Next/Prev Card";
L["Track"] = "Track";   --Track achievements
L["Show Unearned Mark"] = "Show Unearned Mark";
L["Show Unearned Mark Description"] = "Mark the achievements that were not earned by me with a red X.";
L["Show Dates"] = "Show Dates";
L["Hide Dates"] = "Hide Dates";
L["Pinned Entries"] = "Pinned Entries";
L["Pinned Entry Format"] = "Pinned  %d/%d";

--Barbershop--
L["Save New Look"] = "Save New Look";
L["No Available Slot"] = "No Available Slot";
L["Look Saved"] = "Look Saved";
L["Cannot Save Forms"] = "Cannot Save Forms";
L["Profiles"] = "Profiles";
L["Save Notify"] = "Notify You to Save New Appearance";
L["Show Randomize Button"] = "Show Randomize Appearance Button";
L["Coins Spent"] = "Coins Spent";
L["Locations"] = "Locations";
L["Location"] = "Location";
L["Visits"] = "Visits";     --number of visits
L["Duration"] = "Duration";
L["Edit Name"] = "Edit Name";
L["Delete Look"] = "Delete Look\n(Click and Hold)";

--Tutorial--
L["Alert"] = "Warning";
L["Race Change"] = "Race/Gender Change";
L["Race Change Line1"] = "You can again change your race and gender. But there are some limitations:\n1. Your weapons will disappear.\n2. Spell visuals can no longer be removed.\n3. It does not work on other players or NPC.";
L["Guide Spell Headline"] = "Try or Apply";
L["Guide Spell Criteria1"] = "Left-click to TRY";
L["Guide Spell Criteria2"] = "Right-click to APPLY";
L["Guide Spell Line1"] = "Most spell visuals that you add by clicking left button will fade away in seconds, while those you add by clicking right button will not.\n\nNow please move to an entry then:";
L["Guide Spell Choose Category"] = "You can add spell visuals to your model. Choose any category you like. Then choose a subcategory.";
L["Guide History Headline"] = "History Panel";
L["Guide History Line1"] = "At most 5 recently applied visuals can retain here. You can select one and delete it by clicking the Remove button on the right end.";
L["Guide Refresh Line1"] = "Use this button to remove all unapplied spell visuals. Those that were in the history panel will be reapplied.";
L["Guide Input Headline"] = "Manual Input";
L["Guide Input Line1"] = "You may also input a SpellVisualKitID yourself. As of 9.0, Its cap is around 155,000.\nYou can use your mousewheel to try the next/previous ID.\nVery few IDs can crash the game.";
L["Guide Equipment Manager Line1"] = "Double-click: Use a set\nRight-click: Edit a set.\n\nThis button's previous function has been moved to Preferences.";
L["Guide Model Control Headline"] = "Model Control";
L["Guide Model Control Line1"] = string.format("This model shares the same mouse actions you use in the dressing room, plus:\n\n1.Hold %s and Left Button: Rotate model around Y-axis.\n2.Hold %s and Right Button: Execute scrubby zoom.", NARCI_MODIFIER_ALT, NARCI_MODIFIER_ALT);
L["Guide Minimap Button Headline"] = "Minimap Button";
L["Guide Minimap Button Line1"] = "Narcissus minimap button can now be handled by other addons.\nYou can change this option in the Preferences Panel. It may require a UI reload."
L["Guide NPC Entrance Line1"] = "You can add any NPC into your scene."
L["Guide NPC Browser Line1"] = "Notable NPCs are listed in the catalog below.\nYou can also search for ANY creatures by name or ID.\nNotice that the first time you use the search function this login, it could take a few seconds to build the search table and your screen might freeze as well.\nYou may untoggle the \"Load on Demand\" option in the Preference Pane so that the database will be constructed right after you log in.";

--Splash--
L["See Ads"] = "See ads from our authentic sponsor";    --Not real ads!
L["Splash Category1"] = L["Photo Mode"];
L["Splash Content1 Name"] = "Weapon Browser";
L["Splash Content1 Description"] = "-View and use all weapons in the database, including those that are not obtainable by players.";
L["Splash Content2 Name"] = "Character Select Screen";
L["Splash Content2 Description"] = "-Add a decorative frame to create (fake) your own character select screen.";
L["Splash Content3 Name"] = "Dressing Room";
L["Splash Content3 Description"] = "-The dressing room module has been redesigned.\n-The item list now includes unpaired shoulders and weapon illusions.";
L["Splash Content4 Name"] = "Pet Stable";
L["Splash Content4 Description"] = "-Hunters can select and add pets using a new Stable UI in the group photo mode.";
L["Splash Category2"] = "Character Frame";
L["Splash Content5 Name"] = "Shard of Domination";
L["Splash Content5 Description"] = "-The Shard of Domination indicator will show up if you equip relevant items.\n-A list of available shards will be presented to you when you socket domination items.\n-Extract shards with a single click.";
L["Splash Content6 Name"] = "Soulbinds";
L["Splash Content6 Description"] = "-The Soulbinds UI has been updated. You can check the conduit effects of higher ranks.";
L["Splash Content7 Name"] = "Visuals";
L["Splash Content7 Description"] = "-The hexagon item border gets a new look. Certain items have unique appearances.";

--Credits--
L["Credit List Extra"] = "Marlamin | WoW.tools\nKeyboardturner | Avid Bug Finder(Generator)\nHubbotu | Translator - Russian\nMeorawr | Wondrous Wisdomball";

--Conversation--
L["Q1"] = "What is this?";
L["Q2"] = "I know. But why is this so huge?";
L["Q3"] = "That's not funny. I just need a regular one.";
L["Q4"] = "Good. What if I want to disable it?";
L["Q5"] = "One more thing, could you promise me no more pranks?";
L["A1"] = "Apparently, this is an exit confirmation dialog. It pops up when you try to exit group photo mode by pressing hotkey.";
L["A2"] = "Ha, that's what she said.";
L["A3"] = "Fine...fine..."
L["A4"] = "Sorry, you can't. It's for safety you know.";

--Search--
L["Search Result Singular"] = "%s result";
L["Search Result Plural"] = "%s results";
L["Search Result Overflow"] = "%s+ results";
L["Search Result None"] = CLUB_FINDER_APPLICANT_LIST_NO_MATCHING_SPECS;

--Weapon Browser--
L["Draw Weapon"] = "Draw Weapon";
L["Unequip Item"] = "Unequip";
L["WeaponBrowser Guide Hotkey"] = "Specify which hand to hold the weapon:";
L["WeaponBrowser Guide ModelType"] = "Some items are limited to certain type of model:";
L["WeaponBrowser Guide DressUpModel"] = "This will be the default type if your target is a player unless you are holding <%s> while creating it.";
L["WeaponBrowser Guide CinematicModel"] = "The model type will always be Cinematic if the creature is an NPC. You cannot sheathe weapons.";

--Pet Stables--
L["PetStable Tooltip"] = "Choose a pet from your stable";
L["PetStable Loading"] = "Retrieving Pet Info";
L["PetStable Alert NoData"] = "Visit a Stable Master to cache pet data.";

--Domination Item--
L["Item Bonus"] = "Bonus:";
L["Combat Error"] = NARCI_COLOR_RED_MILD.."Leave combat to continue".."|r";
L["Extract Shard"] = "Extract Shard";
L["No Service"] = "No Service";
L["Shards Disabled"] = "Shards of Domination are disabled outside the Maw.";

--Mythic+ Leaderboard--
L["Mythic Plus"] = "Mythic+";
L["Mythic Plus Abbrev"] = "M+";
L["Total Runs"] = "Total Runs: ";
L["Complete In Time"] = "In time";
L["Complete Over Time"] = "Over time";
L["Runs"] = "Runs";

--Equipment Upgrade--
L["Temp Enchant"] = "Temporary Enchants";       --ERR_TRADE_TEMP_ENCHANT_BOUND
L["Owned"] = "Owned";                           --Only show owned items
L["At Level"] = "At level %d:";                 --Enchants scale with player level
L["No Item Alert"] = "No compatible items";
L["Click To Insert"] = "Click to Insert";       --Insert a gem
L["Click To Apply"] = "Click to Apply";         --Apply enchant
L["No Socket"] = "No socket";
L["No Other Item For Slot"] = "No other item for %s";       --where %s is the slot name
L["In Bags"] = "In bags";

--Statistics--
S["Narcissus Played"] = "Total time spent in Narcissus";
S["Format Since"] = "(since %s)";
S["Screenshots"] = "Screenshots Taken In Narcissus";

--Turntable Showcase--
L["Turntable"] = "Turntable";
L["Picture"] = "Picture";
L["Elapse"] = "Elapse";
L["Turntable Tab Animation"] = "Animation";
L["Turntable Tab Image"] = "Image";
L["Turntable Tab Quality"] = "Quality";
L["Turntable Tab Background"] = "Background";
L["Spin"] = "Spin";
L["Sync"] = "Sync";
L["Rotation Period"] = "Period";
L["Period Tooltip"] = "The time it takes to complete one spin.\nIt should also be the |cffcccccccut duration|r of your GIF or video.";
L["MSAA Tooltip"] = "Temporarily modify anti-aliasing to smooth out jaggy edges at the cost of performance.";
L["Image Size"] = "Image Size";
L["Font Size"] = FONT_SIZE;
L["Item Name Show"] = "Show item names";
L["Item Name Hide"] = "Hide item names";
L["Outline Show"] = "Click to show outline";
L["Outline Hide"] = "Click to hide outline";
L["Preset"] = "Preset";
L["File"] = "File";     --File Name
L["File Tooltip"] = "Put your own image under |cffccccccWorld of Warcraft\\retail\\Interface\\AddOns|r and insert the file name in this box.\nThe image must be a |cffcccccc512x512|r or |cffcccccc1024x1024|r |cffccccccJPG|r file";
L["Raise Level"] = "Bring to front";
L["Lower Level"] = "Send to back";
L["Click To Continue"] = "click to continue";
L["Showcase Splash 1"] = "Create turntable animations to showcase your transmog with Narcissus and screen recorder.";
L["Showcase Splash 2"] = "Click the button below to copy items from the Dressing Room.";
L["Showcase Splash 3"] = "Click the button below to spin your character.";
L["Showcase Splash 4"] = "Record the screen with video recording software then convert it to GIF.";

--Item Sets--
L["Cycle Spec"] = "Press Tab to cycle through specs";
L["Paperdoll Splash 1"] = "Enable class set indicator?";
L["Paperdoll Splash 2"] = "Choose a theme";

--Outfit Select--
L["Outfit"] = "Outfit";
L["Models"] = "Models";
L["Origin Outfits"] = "Original outfits";
L["Outfit Owner Format"] = "%s's outfits";
L["SortMethod Recent"] = "Recent";
L["SortMethod Name"] = "Name";


--Classic--
L["Wardrobe"] = "Wardrobe";
L["Outfit Saved"] = "Saved";
L["Select Outfit"] = "Select Outfit";
L["Default Outfit Name"] = "Outfit";
L["Module Transmog Name"] = TRANSMOGRIFICATION or "Transmogrification";
L["Module Transmog Desc"] = "Save and load outfits when you are at a Transmogrifier."

---- Character UI ----
L["Ammo Slot No Alternative"] = "No other available ammos";