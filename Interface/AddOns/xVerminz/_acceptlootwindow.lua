local _, config = ...

-- if not config.autoAcceptLootWindow then return end

local f = CreateFrame('Frame')
f:RegisterEvent('CONFIRM_DISENCHANT_ROLL')
f:RegisterEvent('CONFIRM_LOOT_ROLL')
f:SetScript('OnEvent', function(self, event, id, rollType)
    for i = 1, STATICPOPUP_NUMDIALOGS do
        local frame = _G['StaticPopup'..i]
        if frame.which == 'CONFIRM_LOOT_ROLL' and frame.data == id and frame.data2 == rollType and frame:IsVisible() then
            StaticPopup_OnClick(frame, 1)
        end
    end
end)