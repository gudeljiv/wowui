local Module = SUI:NewModule("UnitFrames.Target");

function Module:OnEnable()

    local db = {
        unitframes = SUI.db.profile.unitframes,
        texture = SUI.db.profile.general.texture,
        theme = SUI.db.profile.general.theme
    }

    -- Set Target/Focus Textures
    local function healthTexture(self)
        if not self or self:IsForbidden() then return end
        
        -- Set Textures
        if self.healthbar then
            self.healthbar:SetStatusBarTexture(db.texture)
            self.healthbar:GetStatusBarTexture():SetDrawLayer("BORDER")
        end
        if self.myHealPrediction and self.myHealPredictionBar then
            self.myHealPredictionBar:SetTexture(db.texture)
        end
    end

    local hooked = {}
    local function UpdateFrameAuras(aura)
        if db.theme ~= 'Blizzard' then
            if not hooked[aura] then
                hooked[aura] = true

                local icon = aura.Icon
                if icon then
                    icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
                    icon:SetDrawLayer("BACKGROUND", -8)
                end

                if not aura.border then
                    local border = aura.border or
                        aura:CreateTexture(aura.border, "BACKGROUND", nil, -7)

                    border:SetTexture("Interface\\Addons\\SUI\\Media\\Textures\\Core\\gloss")
                    border:SetTexCoord(0, 1, 0, 1)
                    border:SetDrawLayer("BACKGROUND", -7)
                    border:ClearAllPoints()
                    border:SetPoint("TOPLEFT", aura, "TOPLEFT", -1, 1)
                    border:SetPoint("BOTTOMRIGHT", aura, "BOTTOMRIGHT", 1, -1)
                    aura.border = border

                    local backdrop = {
                        bgFile = nil,
                        edgeFile = "Interface\\Addons\\SUI\\Media\\Textures\\Core\\outer_shadow",
                        tile = false,
                        tileSize = 32,
                        edgeSize = 4,
                        insets = {
                            left = 4,
                            right = 4,
                            top = 4,
                            bottom = 4,
                        },
                    }
                    local back = CreateFrame("Frame", nil, aura, "BackdropTemplate")
                    back:SetPoint("TOPLEFT", aura, "TOPLEFT", -4, 4)
                    back:SetPoint("BOTTOMRIGHT", aura, "BOTTOMRIGHT", 4, -4)
                    back:SetFrameLevel(aura:GetFrameLevel() - 1)
                    back:SetBackdrop(backdrop)
                    back:SetBackdropBorderColor(unpack(SUI:Color(0.25, 0.9)))
                    aura.bg = back
                end
            end
        end
    end

    local function SUIColorRepBar(self)
        local reputationBar
        if not self then
            return
        end
        local content = self.TargetFrameContent
        if content and content.TargetFrameContentMain then
            reputationBar = content.TargetFrameContentMain.ReputationColor
        else
            local textureFrame = self.TargetFrameTextureFrame or self.TextureFrame
            reputationBar = (textureFrame and textureFrame.ReputationColor) or self.ReputationColor
        end
        if reputationBar then
            reputationBar:SetVertexColor(unpack(SUI:Color(0.15)))
        end
    end

    -- Hooks
    local function ApplyAuraStyles(frame)
        if not (frame and frame.auraPools and frame.auraPools.EnumerateActive) then
            return
        end
        for aura, _ in frame.auraPools:EnumerateActive() do
            UpdateFrameAuras(aura)
        end
    end

    if TargetFrame then
        hooksecurefunc(TargetFrame, "OnEvent", function(self)
        -- Set Health Texture
            if db.texture ~= [[Interface\Default]] then
                healthTexture(self)
            end

            -- Recolor Reputation Bar
            if (SUI:Color()) then
                SUIColorRepBar(self)
            end

            -- Style Buffs & Debuffs
            ApplyAuraStyles(self)
        end)
    end

    if FocusFrame then
        hooksecurefunc(FocusFrame, "OnEvent", function(self)
            -- Set Health Texture
            if db.texture ~= [[Interface\Default]] then
                healthTexture(self)
            end

            -- Recolor Reputation Bar
            if (SUI:Color()) then
                SUIColorRepBar(self)
            end

            -- Style Buffs & Debuffs
            ApplyAuraStyles(self)
        end)
    end

    if TargetFrameToT and TargetFrameToT.Update then
        hooksecurefunc(TargetFrameToT, "Update", function(self)
            -- Set Health Texture
            if db.texture ~= [[Interface\Default]] then
                healthTexture(self)
            end
        end)
    end

    if FocusFrameToT and FocusFrameToT.Update then
        hooksecurefunc(FocusFrameToT, "Update", function(self)
            -- Set Health Texture
            if db.texture ~= [[Interface\Default]] then
                healthTexture(self)
            end
        end)
    end

    -- Set TargetFrame Buff/Debuff SetSize
    if type(TargetFrame_UpdateBuffAnchor) == "function" then
        hooksecurefunc("TargetFrame_UpdateBuffAnchor", function(_, buff)
            buff:SetSize(db.unitframes.buffs.size, db.unitframes.buffs.size)

            if buff.Count then
                local fontSize = db.unitframes.buffs.size / 2.75
                buff.Count:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
                buff.Count:ClearAllPoints()
                buff.Count:SetPoint("BOTTOMRIGHT", buff, "BOTTOMRIGHT", 2, 0)
            end
        end)
    end

    if type(TargetFrame_UpdateDebuffAnchor) == "function" then
        hooksecurefunc("TargetFrame_UpdateDebuffAnchor", function(_, debuff)
            debuff:SetSize(db.unitframes.debuffs.size, db.unitframes.debuffs.size)

            if debuff.Count then
                local fontSize = db.unitframes.debuffs.size / 2.75
                debuff.Count:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
                debuff.Count:ClearAllPoints()
                debuff.Count:SetPoint("BOTTOMRIGHT", debuff, "BOTTOMRIGHT", 2, 0)
            end
        end)
    end
end
