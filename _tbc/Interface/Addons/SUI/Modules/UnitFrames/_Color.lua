local Module = SUI:NewModule("UnitFrames.Colors")

function Module:OnEnable()
    local function GetReputationColor(frame)
        if not frame then return nil end
        if frame.TargetFrameContent and frame.TargetFrameContent.TargetFrameContentMain then
            return frame.TargetFrameContent.TargetFrameContentMain.ReputationColor
        end
        local textureFrame = frame.TargetFrameTextureFrame or frame.TextureFrame
        if textureFrame and textureFrame.ReputationColor then
            return textureFrame.ReputationColor
        end
        return frame.ReputationColor
    end

    local function HideReputationColor(frame)
        local repColor = GetReputationColor(frame)
        if repColor and repColor.Hide then
            repColor:Hide()
        end
    end

    HideReputationColor(TargetFrame)
    HideReputationColor(FocusFrame)

    local db = SUI.db.profile.unitframes
    local texture = SUI.db.profile.general.texture
    if (db) then
        if (db.classcolor) then
            function SUIUnitColor(healthbar, unit)
                healthbar:SetStatusBarDesaturated(1)
                if UnitIsPlayer(unit) and UnitIsConnected(unit) and UnitClass(unit) then
                    _, class = UnitClass(unit)
                    local color = RAID_CLASS_COLORS[class]
                    healthbar:SetStatusBarColor(color.r, color.g, color.b)
                elseif UnitIsPlayer(unit) and (not UnitIsConnected(unit)) then
                    healthbar:SetStatusBarColor(0.5, 0.5, 0.5);
                else
                    if UnitExists(unit) then
                        if (UnitIsTapDenied(unit)) and not UnitPlayerControlled(unit) then
                            healthbar:SetStatusBarColor(0.5, 0.5, 0.5)
                        elseif (not UnitIsTapDenied(unit)) then
                            local reaction = FACTION_BAR_COLORS[UnitReaction(unit, "player")];
                            if reaction then
                                healthbar:SetStatusBarColor(reaction.r, reaction.g, reaction.b);
                            end
                        end
                    end
                end
            end

            hooksecurefunc("UnitFrameHealthBar_Update", function(self)
                SUIUnitColor(self, self.unit)
            end)
            hooksecurefunc("HealthBar_OnValueChanged", function(self)
                SUIUnitColor(self, self.unit)
            end)
        elseif not db.classcolor and texture ~= [[Interface\Default]] then
            function SUIUnitColor(healthbar, unit)
                healthbar:SetStatusBarColor(0, 0.7, 0)
            end

            hooksecurefunc("UnitFrameHealthBar_Update", function(self)
                SUIUnitColor(self, self.unit)
            end)
            hooksecurefunc("HealthBar_OnValueChanged", function(self)
                SUIUnitColor(self, self.unit)
            end)
        end
    end
end
