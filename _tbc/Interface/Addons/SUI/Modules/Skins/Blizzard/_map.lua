local Module = SUI:NewModule("Skins.Map");

function Module:OnEnable()
    if (SUI:Color()) then
        local function SafeSkin(frame)
            if frame then
                SUI:Skin(frame, true)
            end
        end

        SafeSkin(WorldMapFrame)
        SafeSkin(WorldMapFrame and WorldMapFrame.BorderFrame)
        SafeSkin(WorldMapFrame and WorldMapFrame.BorderFrame and WorldMapFrame.BorderFrame.NineSlice)
        SafeSkin(WorldMapFrame and WorldMapFrame.NavBar)
        SafeSkin(WorldMapFrame and WorldMapFrame.NavBar and WorldMapFrame.NavBar.overlay)
    end
end
