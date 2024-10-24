if select(2, UnitClass("player")) ~= "SHAMAN" then
    return
end

local L = LibStub("AceLocale-3.0"):GetLocale("TotemTimers")

local Timers = XiTimers.timers

local SpellNames = TotemTimers.SpellNames
local SpellIDs = TotemTimers.SpellIDs
local SpellTextures = TotemTimers.SpellTextures
local AvailableSpells = TotemTimers.AvailableSpells
local AvailableTalents = TotemTimers.AvailableTalents
local NameToSpellID = TotemTimers.NameToSpellID

local weapon = nil

function TotemTimers.CreateWeaponTracker()
    weapon = XiTimers:new(2)

    weapon.button.icons[1]:SetTexture(SpellTextures[SpellIDs.RockbiterWeapon])
    weapon.button.icons[2]:SetTexture(SpellTextures[SpellIDs.RockbiterWeapon])

    weapon.button.anchorframe = TotemTimers_TrackerFrame
    weapon.timeStyle = "blizz"
    weapon.button:SetAttribute("*type*", "spell")
    weapon.button:SetAttribute("ctrl-spell1", ATTRIBUTE_NOOP)
    weapon.Update = TotemTimers.WeaponUpdate
    weapon.button:RegisterForClicks("LeftButtonDown", "RightButtonDown", "MiddleButtonDown")
    weapon.timerBars[1]:SetMinMaxValues(0, 1800)
    weapon.flashall = true
    weapon.warningPoint = 30
    weapon.numButtonTimers = 2

    weapon.Activate = function(self)
        XiTimers.Activate(self)
        if not TotemTimers.ActiveProfile.WeaponTracker then
            self.button:Hide()
        end
    end
    TotemTimers.SetNumWeaponTimers()

    weapon.actionBar = TTActionBars:new(8, weapon.button, nil, TotemTimers_TrackerFrame, "weapontimer")

    weapon.button.tooltip = TotemTimers.Tooltips.WeaponTimer:new(weapon.button)

    weapon.button.SaveLastEnchant = function(self, name)
        if name == "spell1" then
            TotemTimers.ActiveProfile.LastWeaponEnchant = self:GetAttribute("spell1")
        elseif name == "spell2" or name == "spell3" then
            TotemTimers.ActiveProfile.LastWeaponEnchant2 = self:GetAttribute("spell2") or self:GetAttribute("spell3")
        elseif name == "spell4" then
            TotemTimers.ActiveProfile.LastWeaponEnchant3 = self:GetAttribute("spell4")
        elseif name == "doublespell2" then
            local ds2 = self:GetAttribute("doublespell2")
            if ds2 then
                local ds1 = self:GetAttribute("doublespell1")
                if ds1 ~= SpellNames[SpellIDs.WindfuryWeapon] then
                    TotemTimers.ActiveProfile.LastWeaponEnchant = 7
                elseif ds2 == SpellNames[SpellIDs.FlametongueWeapon] then
                    TotemTimers.ActiveProfile.LastWeaponEnchant = 5
                elseif ds2 == SpellNames[SpellIDs.FrostbrandWeapon] then
                    TotemTimers.ActiveProfile.LastWeaponEnchant = 6
                elseif ds2 == SpellNames[SpellIDs.RockbiterWeapon] then
                    TotemTimers.ActiveProfile.LastWeaponEnchant = 8
                end
            end
        end
        local spellType = name:sub(1, -2)
        for i=1,2 do
            if not self.timer.timersRunning[i] then
            local spell = self:GetAttribute(spellType..i)
                if not spell and i == 2 then spell = self:GetAttribute(spellType..1) end
                if spell then
                    self.icons[i]:SetTexture(GetSpellTexture(spell))
                end
            end
        end
    end


    weapon.button:SetAttribute("_onattributechanged", [[ if name == "spell1" or name == "doublespell1" or name == "doublespell2" or name == "spell2" or name == "spell3" then
                                                             control:CallMethod("SaveLastEnchant", name)
                                                         end
                                                         if name == "doublespell1" or name == "doublespell2" then
                                                            if self:GetAttribute(name) then self:SetAttribute("ds", 1) end
                                                         elseif name == "ds" then
                                                            local ds = self:GetAttribute("ds")
                                                            self:SetAttribute("macrotext", "/cast [@none] "..self:GetAttribute("doublespell"..ds).."\n/use "..(15+ds).."\n/click StaticPopup1Button1")
                                                         end]])

    weapon.button:WrapScript(weapon.button, "PostClick", [[ if button == "LeftButton" then
                                                                 local ds1 = self:GetAttribute("doublespell1")
                                                                 if ds1 then
                                                                     if IsControlKeyDown() or self:GetAttribute("ds") ~= 1 then
 																		 self:SetAttribute("ds",1)
                                                                     else
 																		 self:SetAttribute("ds",2)
                                                                     end
                                                                 end
                                                            end]])

    weapon.button:SetAttribute("ctrl-type1", "cancelaura")
    weapon.button:SetAttribute("ctrl-target-slot1", GetInventorySlotInfo("MainHandSlot"))
    weapon.button:SetAttribute("ctrl-type2", "cancelaura")
    weapon.button:SetAttribute("ctrl-target-slot2", GetInventorySlotInfo("SecondaryHandSlot"))
    weapon.button:SetScript("OnDragStop", function(self)
        XiTimers.StopMoving(self)
        if not InCombatLockdown() then
            --self:SetAttribute("hide", true)
        end
        TotemTimers.ProcessSetting("WeaponBarDirection")
    end)
    weapon.nobars = true
    weapon.Stop = function(self, timer)
        XiTimers.Stop(self, timer)
        self.button.bar:Show()
    end
    weapon.button.bar:Show()
    weapon.button.bar:SetStatusBarColor(0.7, 1, 0.7, 0.7)

    weapon.Start = function(self, ...)
        XiTimers.Start(self, ...)
        self.running = 1
    end
    weapon.Stop = function(self, ...)
        XiTimers.Stop(self, ...)
        self.running = 1
    end
    weapon.running = 1
    weapon.slotChanged = {}

    for i = 1,weapon.actionBar.numbuttons do
        weapon.actionBar.buttons[i].useSpellNames = true
    end
    weapon.events = { "PLAYER_EQUIPMENT_CHANGED" }

    weapon.button:SetScript("OnEvent", function(self, event, slot, ...)
        if (slot == 16) then weapon.slotChanged[1] = true
        elseif (slot == 17) then weapon.slotChanged[2] = true
        end
    end)

    TotemTimers.WeaponTracker = weapon
end

table.insert(TotemTimers.Modules, TotemTimers.CreateWeaponTracker)


function TotemTimers.SetWeaponTrackerSpells()
    weapon.actionBar:ResetSpells()
    for i = 1,weapon.actionBar.numbuttons do
        local button = weapon.actionBar.buttons[i]
        button.icons[1]:ClearAllPoints()
        button.icons[2]:ClearAllPoints()
        button.icons[1]:SetPoint("LEFT", button)
        button.icons[2]:SetPoint("LEFT", button, "CENTER")
    end

    for _,spellID in pairs({SpellIDs.WindfuryWeapon, SpellIDs.RockbiterWeapon,
                SpellIDs.FlametongueWeapon, SpellIDs.FrostbrandWeapon, SpellIDs.EarthlivingWeapon}) do
        if AvailableSpells[spellID] then
            weapon.actionBar:AddSpell(spellID)
        end
    end

    if AvailableTalents.DualWield then
        if AvailableSpells[SpellIDs.WindfuryWeapon] and AvailableSpells[SpellIDs.FlametongueWeapon] then
            weapon.actionBar:AddDoubleSpell(SpellIDs.WindfuryWeapon, SpellIDs.FlametongueWeapon)
        end
        if AvailableSpells[SpellIDs.WindfuryWeapon] and AvailableSpells[SpellIDs.FrostbrandWeapon] then
            weapon.actionBar:AddDoubleSpell(SpellIDs.WindfuryWeapon, SpellIDs.FrostbrandWeapon)
        end
        if AvailableSpells[SpellIDs.FlametongueWeapon]
                and SpellIDs.FlametongueWeapon  ~= select(7, GetSpellInfo(SpellNames[SpellIDs.FlametongueWeapon])) then
            weapon.actionBar:AddDoubleSpell(SpellIDs.FlametongueWeapon, SpellIDs.FlametongueWeapon)
            --set ft-1/ft-button visually apart from ft-button by switching texture positions
            local button = weapon.actionBar.buttons[weapon.actionBar.numspells]
            button.icons[1]:ClearAllPoints()
            button.icons[2]:ClearAllPoints()
            button.icons[1]:SetPoint("LEFT", button, "CENTER")
            button.icons[2]:SetPoint("LEFT", button)
        end
    end
end

local mainMsg = ""
local offMsg = ""

local WeaponEnchants = TotemTimers.WeaponEnchants
local GetWeaponEnchantInfo = GetWeaponEnchantInfo
local weaponTextures = {}

local maxDurations ={}

function TotemTimers.WeaponUpdate(self, elapsed)
    local enchant, expiration, _, mainID, offenchant, offExpiration, _, offID = GetWeaponEnchantInfo()
    local enchants = { { enchant, expiration and expiration/1000 or 0, mainID }, { offenchant, offExpiration and offExpiration/1000 or 0, offID } }

    local hands = weapon.numtimers or 1
    local showGlow = false
    for hand = 1,hands do
        local checkEnchant = enchants[hand]
        if checkEnchant[1] then
            if weapon.slotChanged[hand] or checkEnchant[2] > self.timers[hand] then
                if not maxDurations[checkEnchant[3]] or maxDurations[checkEnchant[3]] < checkEnchant[2] then
                    maxDurations[checkEnchant[3]] = checkEnchant[2]
                end
                weapon.slotChanged[hand] = false
                local texture, spell
                self:Start(hand, checkEnchant[2], maxDurations[checkEnchant[3]])
                if WeaponEnchants[checkEnchant[3]] then
                    texture = SpellTextures[WeaponEnchants[checkEnchant[3]]]
                    spell = SpellNames[WeaponEnchants[checkEnchant[3]]]
                else
                    spell, _, _, _, _, _, _, _, _, texture = GetItemInfo(GetInventoryItemID("player", 15 + hand))
                end

                self["enchant"..hand] = spell
                self.button.icons[hand]:SetTexture(texture)
                self.warningIcons[hand] = texture
                self.warningSpells[hand] = spell
                self.expirationMsgs[hand] = "Weapon"
                self.earlyExpirationMsgs[hand] = "Weapon"
            end
            if checkEnchant[2] == 0 then
                self:Stop(hand)
            else
                self.timers[hand] = checkEnchant[2]
            end
        elseif self.timers[hand] > 0 then
            self:Stop(hand)
        end
        if InCombatLockdown() and self.timers[hand] < self.warningPoint then
            showGlow = true
        end
    end

    if showGlow and TotemTimers.Specialization == 2 and TotemTimers.ActiveProfile.WeaponGlow then
        ActionButton_ShowOverlayGlow(self.button)
    else
        ActionButton_HideOverlayGlow(self.button)
    end

    XiTimers.Update(self, 0)
end

function TotemTimers.SetNumWeaponTimers()
    weapon.handsToCheck = AvailableTalents.DualWield and 2 or 1
    TotemTimers.SetDoubleTexture(weapon.button,  AvailableTalents.DualWield, true)
    weapon.numtimers = AvailableTalents.DualWield and 2 or 1
    weapon:SetTimerBarPos(weapon.timerBarPos)
    if not AvailableTalents.DualWield then weapon:Stop(2) end
end

table.insert(TotemTimers.SpellUpdaters, TotemTimers.SetNumWeaponTimers)
