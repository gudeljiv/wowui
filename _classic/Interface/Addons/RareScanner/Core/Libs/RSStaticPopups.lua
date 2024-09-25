-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local LibStub = _G.LibStub
local ADDON_NAME, private = ...

local LibDialog = LibStub("LibDialog-1.0RS")

-- Locales
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner");

-- RareScanner database libraries
local RSConfigDB = private.ImportLib("RareScannerConfigDB")

-- RareScanner internal libraries
local RSConstants = private.ImportLib("RareScannerConstants")
local RSLogger = private.ImportLib("RareScannerLogger")

---============================================================================
-- TargetUnit tracker warning
---============================================================================

LibDialog:Register(RSConstants.TARGET_UNIT_WARNING, {
	text = AL["TARGET_UNIT_WARNING"],
	no_close_button = true,
    buttons = {
        {
            text = YES,
            on_click = function(self, mouseButton, down)
            	RSConfigDB.SetScanningTargetUnit(true)
            	LibStub("AceConfigRegistry-3.0"):NotifyChange("RareScanner General")
            end,
        },
        {
            text = NO,
            on_click = function(self, mouseButton, down)
            	RSConfigDB.SetScanningTargetUnit(false)
            	LibDialog:Dismiss(RSConstants.TARGET_UNIT_WARNING)
            end,
        },
    },          
})