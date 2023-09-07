local _, GAD, staticSpecs, unpackedSpecs, GetCreateTable, PackStrings

local DGV = DugisGuideViewer
local GAD = DGV:RegisterModule("GearAdvisorData")
GAD.essential = true


function GAD:Initialize()
    function GAD:Load()
        GetCreateTable, PackStrings = DGV.GetCreateTable, DGV.PackStrings

        staticSpecs = GetCreateTable()
		staticSpecs["DRUID:Balance"] = "INT,1:SPELL_POWER,11:ARCANE_SPELL_POWER,5.5:NATURE_SPELL_POWER,5:SPELL_CRIT_CHANCE,74:SPELL_HIT_CHANCE,100,.5,0:MANA_REGEN,3:SPI,0.5:STA,0.1:DPS,0.1:ARMOR,0.1"
		staticSpecs["DRUID:Feral"] = "FERAL_ATTACK_POWER,5:HIT_CHANCE,68,.5,0:CRIT_CHANCE,100:ATTACK_POWER,5:AGI,10:STR,11:STA,0.1:DPS,0.1:ARMOR,0.1"
		staticSpecs["DRUID:Feral Tank"] = "DODGE_CHANCE,100:DEFENSE,12:ARMOR,2:STA,16:AGI,6:DPS,0.1"
		staticSpecs["DRUID:Restoration"] = "SPELL_POWER,10:MANA_REGEN,30:HEALING_SPELL_POWER,10:SPELL_CRIT_CHANCE,100:SPI,5:INT,3:STA,0.1:DPS,0.1:ARMOR,0.1"
        staticSpecs["HUNTER:Beast Mastery"] = "DAMAGE,11:RANGED_ATTACK_POWER,1:DPS,14:HIT_CHANCE,22:CRIT_CHANCE,29:ATTACK_POWER,1:AGI,3:STA,0.1:MANA_REGEN,0.1:ARMOR,0.1"
        staticSpecs["HUNTER:Marksmanship"] = "DAMAGE,11:RANGED_ATTACK_POWER,1:DPS,14:HIT_CHANCE,22:CRIT_CHANCE,29:ATTACK_POWER,1:AGI,3:STA,0.1:MANA_REGEN,0.1:ARMOR,0.1"
        staticSpecs["HUNTER:Survival"] = "DAMAGE,11:RANGED_ATTACK_POWER,1:DPS,14:HIT_CHANCE,22:CRIT_CHANCE,29:ATTACK_POWER,1:AGI,3:STA,0.1:MANA_REGEN,0.1:ARMOR,0.1"
		staticSpecs["MAGE:Arcane"] = "SPELL_POWER,7:SPELL_PENETRATION,30:ARCANE_SPELL_POWER,7:SPELL_CRIT_CHANCE,81:SPELL_HIT_CHANCE,100,.5,0:INT,1:STA,0.1:MANA_REGEN,2:SPI,0.5:DPS,0.1:ARMOR,0.1"
		staticSpecs["MAGE:Fire"] = "SPELL_POWER,7:SPELL_PENETRATION,30:FIRE_SPELL_POWER,7:SPELL_CRIT_CHANCE,81:SPELL_HIT_CHANCE,100,.5,0:INT,1:STA,0.1:MANA_REGEN,2:SPI,0.5:DPS,0.1:ARMOR,0.1"
		staticSpecs["MAGE:Frost"] = "SPELL_POWER,7:SPELL_PENETRATION,30:FROST_SPELL_POWER,7:SPELL_CRIT_CHANCE,81:SPELL_HIT_CHANCE,100,.5,0:INT,1:STA,0.1:MANA_REGEN,2:SPI,0.5:DPS,0.1:ARMOR,0.1"
		staticSpecs["PALADIN:Holy"] = "SPELL_POWER,5:MANA_REGEN,15:HEALING_SPELL_POWER,5:SPELL_CRIT_CHANCE,100:INT,5:STA,0.1:DPS,0.1:ARMOR,0.1"
		staticSpecs["PALADIN:Retribution"] = "DAMAGE,11:DPS,28:HIT_CHANCE,40,.5,0:CRIT_CHANCE,30:ATTACK_POWER,2:AGI,2:STR,4:STA,0.1:ARMOR,0.1"
		staticSpecs["PALADIN:Protection"] = "DODGE_CHANCE,100:DEFENSE,12:ARMOR,2:STA,16:AGI,2:STR,4:ATTACK_POWER,2:DPS,28:HIT_CHANCE,40"
		staticSpecs["PRIEST:Discipline"] = "SPELL_POWER,29:MANA_REGEN,100:HEALING_SPELL_POWER,29:SPI,24:INT,33:STA,0.1:DPS,0.1:ARMOR,0.1"
		staticSpecs["PRIEST:Holy"] = "SPELL_POWER,29:MANA_REGEN,100:HEALING_SPELL_POWER,29:SPI,24:INT,33:STA,0.1:DPS,0.1:ARMOR,0.1"
		staticSpecs["PRIEST:Shadow"] = "SPELL_POWER,10:SHADOW_SPELL_POWER,10:MANA_REGEN,3:SPELL_HIT_CHANCE,100,.5,0:SPELL_CRIT_CHANCE,24:SPI,0.5:INT,1:STA,0.1:DPS,0.1:ARMOR,0.1"
        staticSpecs["ROGUE:Assassination"] = "DAMAGE,11:DPS,28:HIT_CHANCE,36:CRIT_CHANCE,46,.12,0:ATTACK_POWER,2:AGI,4:STR,2:STA,0.1:ARMOR,0.1"
        staticSpecs["ROGUE:Combat"] = "DAMAGE,11:DPS,28:HIT_CHANCE,36:CRIT_CHANCE,46,.12,0:ATTACK_POWER,2:AGI,4:STR,2:STA,0.1:ARMOR,0.1"
        staticSpecs["ROGUE:Subtlety"] = "DAMAGE,11:DPS,28:HIT_CHANCE,36:CRIT_CHANCE,46,.12,0:ATTACK_POWER,2:AGI,4:STR,2:STA,0.1:ARMOR,0.1"	
		staticSpecs["SHAMAN:Elemental"] = "SPELL_POWER,10:SPELL_PENETRATION,27:NATURE_SPELL_POWER,10:SPELL_CRIT_CHANCE,80:SPELL_HIT_CHANCE,100,.5,0:INT,1:STA,0.1:MANA_REGEN,3:DPS,0.1:ARMOR,0.1"
		staticSpecs["SHAMAN:Enchance Two-Hand"] = "DAMAGE,11:DPS,28:HIT_CHANCE,48:CRIT_CHANCE,47:ATTACK_POWER,2:AGI,2:STR,4:STA,0.1:MANA_REGEN,1:ARMOR,0.1"
		staticSpecs["SHAMAN:Enchance Dual Wield"] = "DPS,28:HIT_CHANCE,48:CRIT_CHANCE,47:ATTACK_POWER,2:AGI,2:STR,4:STA,0.1:MANA_REGEN,1:ARMOR,0.5:BLOCK_VALUE,0.5"		
		staticSpecs["SHAMAN:Restoration"] = "SPELL_POWER,17:HEALING_SPELL_POWER,17:INT,20:MANA_REGEN,100:INT,20:STA,0.1:DPS,0.1:ARMOR,0.1"
        staticSpecs["WARLOCK:Affliction"] = "SPELL_POWER,5:SHADOW_SPELL_POWER,5:SPELL_CRIT_CHANCE,65:SPELL_HIT_CHANCE,100,.5,0:INT,1:STA,0.1:MANA_REGEN,1:DPS,0.1:ARMOR,0.1"
        staticSpecs["WARLOCK:Demonology"] = "SPELL_POWER,5:SHADOW_SPELL_POWER,5:SPELL_CRIT_CHANCE,65:SPELL_HIT_CHANCE,100,.5,0:INT,1:STA,0.1:MANA_REGEN,1:DPS,0.1:ARMOR,0.1"
        staticSpecs["WARLOCK:Destruction"] = "SPELL_POWER,5:SHADOW_SPELL_POWER,5:SPELL_CRIT_CHANCE,65:SPELL_HIT_CHANCE,100,.5,0:INT,1:STA,0.1:MANA_REGEN,1:DPS,0.1:ARMOR,0.1"	
		staticSpecs["WARRIOR:One-Hand Shield"] = "DPS,28:HIT_CHANCE,100,.5,0:CRIT_CHANCE,81:ATTACK_POWER,4:PARRY_CHANCE,28:DODGE_CHANCE,28:BLOCK_VALUE,3:DEFENSE,1:AGI,4:STR,7:STA,1:ARMOR,1"
		staticSpecs["WARRIOR:Dual Wield"] = "DPS,28:HIT_CHANCE,40,.12,0:CRIT_CHANCE,40:ATTACK_POWER,2:AGI,2:STR,4:STA,0.5:ARMOR,0.1"
		staticSpecs["WARRIOR:Two-Hand"] = "DPS,28:DAMAGE,11:HIT_CHANCE,40,.5,0:CRIT_CHANCE,40:ATTACK_POWER,2:AGI,2:STR,4:STA,0.5:ARMOR,0.1"
		staticSpecs["WARRIOR:Tanking"] = "PARRY_CHANCE,100:DODGE_CHANCE,100:BLOCK_VALUE,3:DEFENSE,16:ARMOR,1:STA,6:AGI,6:STR,3:ATTACK_POWER,1:DPS,28:HIT_CHANCE,50,.5,0:CRIT_CHANCE,40"
        staticSpecs["FISHING"] = "FISHING,100"

        DGV.staticSpecs = staticSpecs
        unpackedSpecs = GetCreateTable()

        local function StoreKeyValues(statTable, statKey, ...)
            statTable[statKey] = GetCreateTable(...)
        end

        local function GetAllCSV(...)
            local tbl = GetCreateTable()
            for i=1,select("#", ...) do
                StoreKeyValues(tbl, strsplit(",", (select(i,...))))
            end
            return tbl
        end

        local function EnsureCustomSpecs()
            local options = DGV.db.global[DGV_GAWEIGHTSCUSTOM].options
            if not options then
                options = {}
                DGV.db.global[DGV_GAWEIGHTSCUSTOM].options = options
            end
            return options
        end

        local function GetSpecString(specKey)
            local str = EnsureCustomSpecs()[specKey]
            if not str then
                return staticSpecs[specKey]
            end
            return str
        end

        local function GetSpecData(specKey)
            local specData = unpackedSpecs[specKey]
            if not specData then
                local str = GetSpecString(specKey)
                if str and str ~= "" then
                    specData = GetAllCSV(strsplit(":", str))
                    unpackedSpecs[specKey] = specData
                end
            end
            return specData
        end

        local function ClearUnpackedSpec(specKey)
            if unpackedSpecs[specKey] then
                unpackedSpecs[specKey]:Pool()
            end
            unpackedSpecs[specKey] = nil
        end

        function ResetSpecData(specKey)
            ClearUnpackedSpec(specKey)
            EnsureCustomSpecs()[specKey] = nil
        end
        GAD.ResetSpecData = ResetSpecData

        function GAD.IterateSpecData(specKey, statKey)
            local specData = GetSpecData(specKey)
            if specData then
                local statKey, statTable = next(specData, statKey)
                return statKey, statTable
            end
        end

        function GAD.IterateClassSpecs(class, specKey)
            if not class then _, class = UnitClass("player") end
            local specClass, specName
            repeat 
                specKey = next(staticSpecs, specKey)
                if specKey then
                    specClass, specName = string.split(':', specKey)
                end
            until(not specKey or specClass == class)
            return specKey, specName
        end

        local function PackSpec(specData)
            local accumulate = nil
            for statKey, statData in next, specData do
                local join = table.concat(statData, ',')
                if not accumulate then
                    accumulate = string.format("%s,%s", statKey, join)
                else
                    accumulate = string.format("%s:%s,%s", accumulate, statKey, join)
                end
            end
            return accumulate
        end

        function GAD.SetCustomValue(specKey, statKey, value, refreshEditbox)
            local options = EnsureCustomSpecs()
            if not options[specKey] then
                options[specKey] = staticSpecs[specKey]
            end
            ClearUnpackedSpec(specKey)
            local specData = GetSpecData(specKey)
            if not specData[statKey] and value then
                specData[statKey] = GetCreateTable()
            elseif specData[statKey] then
                wipe(specData[statKey])
            end
            if value then
                tinsert(specData[statKey], value)
            elseif specData[statKey] then
                specData[statKey]:Pool()
                specData[statKey] = nil
            end
            options[specKey] = PackSpec(specData)
            ClearUnpackedSpec(specKey)

            if refreshEditbox and value then
                for i=1, 50 do
                   local control =  _G["DugisStatWeight"..i]
                   if control then
                        local dropdown = control.StatDropDown
                        local WeightEdit = control.WeightEdit
                        if dropdown.selectedValue == statKey then
                           WeightEdit:SetText(value)
                        end
                   end
                end
            end

        end

        function GAD.IterateClasses(invariant, control)
            if not control then control = 1
            else control = control + 1 end
            if control > 12 then return end
            local info = C_CreatureInfo.GetClassInfo(control)
            if not info then
                return GAD.IterateClasses(invariant, control)
            else
                return control, info.classFile, info.className, "|c"..RAID_CLASS_COLORS[info.classFile].colorStr
            end
        end
    end

    function GAD:Unload()
        for _, specTable in next, unpackedSpecs do
            if type(specTable)=="table" then
                for _, statTable in next, specTable do
                    if type(statTable)=="table" then
                        statTable:Pool()
                    end
                end
				specTable:Pool()
			end
        end
        unpackedSpecs:Pool()
		staticSpecs:Pool()
    end
end