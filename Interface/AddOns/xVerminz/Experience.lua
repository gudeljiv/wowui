--local font = "Interface\\AddOns\\xVerminz\\media\\fontAtari.ttf"
local font = "Fonts\\ARIALN.ttf"
local _, class, _ = UnitClass("player");

if class == "HUNTER" and UnitExists("pet") then
    local PetExpFrame = CreateFrame("Frame", "PetExpFrame", UIParent)
    PetExpFrame:SetWidth(1)
    PetExpFrame:SetHeight(1)
    PetExpFrame:SetAlpha(0.9);
    PetExpFrame:SetPoint("BOTTOMLEFT", ChatFrame1, "BOTTOMRIGHT", 5, 40)
    PetExpFrame.text = PetExpFrame:CreateFontString(nil,"ARTWORK")
    PetExpFrame.text:SetJustifyH("LEFT")
    PetExpFrame.text:SetJustifyV("TOP")
    PetExpFrame.text:SetFont(font, 12, "THINOUTLINE")
    PetExpFrame.text:SetPoint("LEFT", PetExpFrame, "LEFT", 0, 0)
    PetExpFrame:SetFrameStrata("MEDIUM")
    PetExpFrame:Hide()
end

local PlayerExpFrame = CreateFrame("Frame", "PlayerExpFrame", UIParent)
PlayerExpFrame:SetWidth(1)
PlayerExpFrame:SetHeight(1)
PlayerExpFrame:SetAlpha(0.9);
PlayerExpFrame:SetPoint("BOTTOMLEFT", ChatFrame1, "BOTTOMRIGHT", 5, 10)
PlayerExpFrame.text = PlayerExpFrame:CreateFontString(nil,"ARTWORK")
PlayerExpFrame.text:SetJustifyH("LEFT")
PlayerExpFrame.text:SetJustifyV("TOP")
PlayerExpFrame.text:SetFont(font, 12, "THINOUTLINE")
PlayerExpFrame.text:SetPoint("LEFT", PlayerExpFrame, "LEFT", 0, 0)
PlayerExpFrame:SetFrameStrata("MEDIUM")

MainMenuExpBar:HookScript('OnUpdate', function()
    local currentXP = UnitXP("player")
    local maxXP = UnitXPMax("player")
    local percent = floor((currentXP/maxXP)*100)
    PlayerExpFrame.text:SetText("player ("..UnitLevel("player").."):\n"..currentXP.." / "..maxXP.." ("..percent.."%)")

    if class == "HUNTER" and UnitExists("pet") then
        local petCurrentXP, petMaxXP = GetPetExperience()
        local petPercent = floor((petCurrentXP/petMaxXP)*100)
        PetExpFrame.text:SetText("pet ("..UnitLevel("pet").."):\n"..petCurrentXP.." / "..petMaxXP.." ("..petPercent.."%)")
        PetExpFrame:Show()
    else
        PetExpFrame:Hide()
    end
end)
