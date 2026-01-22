local Module = SUI:NewModule("UnitFrames.Boss");
function Module:OnEnable()
    local db = SUI.db.profile.general
    function SUIBossFrames(self, event)
        if self then
            if self.healthbar then
                self.healthbar:SetStatusBarTexture(db.texture)
            end

            if SUI:Color() then
                local reputationBar
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
        end
    end

    --hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", SUIBossFramesText)
    local function HookBossFrame(frame)
        if frame and frame.HookScript then
            frame:HookScript("OnEvent", function(self, event)
                SUIBossFrames(self, event)
            end)
        end
    end

    HookBossFrame(Boss1TargetFrame)
    HookBossFrame(Boss2TargetFrame)
    HookBossFrame(Boss3TargetFrame)
    HookBossFrame(Boss4TargetFrame)
    HookBossFrame(Boss5TargetFrame)
end
