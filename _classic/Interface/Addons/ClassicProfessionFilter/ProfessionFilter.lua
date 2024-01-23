local CPF, C, L = unpack(select(2, ...))
local MODULE_NAME = "ProfessionFilter"

--[==[@debug@
print(CPF.ADDON_NAME, MODULE_NAME)
--@end-debug@]==]


---------------------------------------------
-- MIXIN: SearchBar
---------------------------------------------
ClassicProfessionFilterSearchBoxMixIn = {}
function ClassicProfessionFilterSearchBoxMixIn:OnTextChanged(...)
    SearchBoxTemplate_OnTextChanged(self, ...);
end

function ClassicProfessionFilterSearchBoxMixIn:OnChar(...)
    -- ClearFocus if too many characters are repeated (like trying to move while typing)
    BagSearch_OnChar(self, ...)
end

function ClassicProfessionFilterSearchBoxMixIn:OnEscapePressed(...)
    self:SetText("") -- clear filter
    self:ClearFocus()
end


---------------------------------------------
-- MIXIN: HaveMats
---------------------------------------------
ClassicProfessionFilterCheckButtonMixIn = {}
function ClassicProfessionFilterCheckButtonMixIn:OnClick()
    if ( self:GetChecked() ) then
        PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON, "SFX")
    else
        PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF, "SFX")
    end
end

function ClassicProfessionFilterCheckButtonMixIn:OnEnter()
    if ( self.tooltipText ) then
        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT");
        GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, true);
    end
end

function ClassicProfessionFilterCheckButtonMixIn:OnLeave()
    GameTooltip:Hide();
end
