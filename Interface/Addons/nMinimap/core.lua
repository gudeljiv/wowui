
local _, nMinimap = ...
local cfg = nMinimap.Config

    -- A 'new' mail notification

MiniMapMailFrame:SetSize(14, 14)
MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:SetPoint('BOTTOMRIGHT', Minimap, -4, 5)

MiniMapMailBorder:SetTexture(nil)
MiniMapMailIcon:SetTexture(nil)

hooksecurefunc(MiniMapMailFrame, 'Show', function()
    MiniMapMailBorder:SetTexture(nil)
    MiniMapMailIcon:SetTexture(nil)
end)

MiniMapMailFrame.Text = MiniMapMailFrame:CreateFontString(nil, 'OVERLAY')
MiniMapMailFrame.Text:SetFont('Fonts\\ARIALN.ttf', 15, 'OUTLINE')
MiniMapMailFrame.Text:SetPoint('BOTTOMRIGHT', MiniMapMailFrame)
MiniMapMailFrame.Text:SetTextColor(1, 0, 1)
MiniMapMailFrame.Text:SetText('N')

   -- Modify the battlefield frame

MiniMapBattlefieldFrame:ClearAllPoints()
MiniMapBattlefieldFrame:SetPoint('BOTTOMLEFT', Minimap, 5, 5)
MiniMapBattlefieldFrame:SetSize(14, 14)

hooksecurefunc(MiniMapBattlefieldFrame, 'Show', function()
    MiniMapBattlefieldIcon:SetTexture(nil)
    MiniMapBattlefieldBorder:SetTexture(nil)
    BattlegroundShine:SetTexture(nil)
end)

MiniMapBattlefieldFrame.Text = MiniMapBattlefieldFrame:CreateFontString(nil, 'OVERLAY')
MiniMapBattlefieldFrame.Text:SetFont('Fonts\\ARIALN.ttf', 15, 'OUTLINE')
MiniMapBattlefieldFrame.Text:SetPoint('BOTTOMLEFT', MiniMapBattlefieldFrame)
MiniMapBattlefieldFrame.Text:SetTextColor(0, 0.75, 1)
MiniMapBattlefieldFrame.Text:SetText('P')

    -- Hide all unwanted things

MinimapZoomIn:Hide()
MinimapZoomIn:UnregisterAllEvents()

MinimapZoomOut:Hide()
MinimapZoomOut:UnregisterAllEvents()

MiniMapWorldMapButton:Hide()
MiniMapWorldMapButton:UnregisterAllEvents()

MinimapNorthTag:SetAlpha(0)

MinimapBorder:Hide()
MinimapBorderTop:Hide()

MinimapZoneText:Hide()

GameTimeFrame:Hide()

MinimapZoneTextButton:Hide()
MinimapZoneTextButton:UnregisterAllEvents()

    -- hide the durability frame (the armored man)

DurabilityFrame:Hide()
DurabilityFrame:UnregisterAllEvents()

    -- Bigger minimap

MinimapCluster:SetScale(1.1)
MinimapCluster:EnableMouse(false)

    -- New position

Minimap:ClearAllPoints()
Minimap:SetPoint('TOPRIGHT', UIParent, -26, -26)

    -- Square minimap and create a border

function GetMinimapShape()
    return 'SQUARE'
end

Minimap:SetMaskTexture("Interface\\ChatFrame\\ChatFrameBackground")
Minimap:CreateBeautyBorder(11)
Minimap:SetBeautyBorderPadding(1)

if (cfg.classColor.border) then
	local classColor = RAID_CLASS_COLORS[select(2, UnitClass('player'))]
	Minimap:SetBeautyBorderTexture("white")
	Minimap:SetBeautyBorderColor(classColor.r, classColor.g, classColor.b)
end

    -- Enable mousewheel zooming

Minimap:EnableMouseWheel(true)
Minimap:SetScript('OnMouseWheel', function(self, delta)
    if (delta > 0) then
        _G.MinimapZoomIn:Click()
    elseif delta < 0 then
        _G.MinimapZoomOut:Click()
    end
end)

    -- Skin the ticket status frame

TicketStatusFrame:ClearAllPoints()
TicketStatusFrame:SetPoint('BOTTOMRIGHT', UIParent, 0, 0)

TicketStatusFrameButton:HookScript('OnShow', function(self)
    self:SetBackdrop({
        bgFile = 'Interface\\Buttons\\WHITE8x8', 
        insets = {
            left = 3, 
            right = 3, 
            top = 3, 
            bottom = 3
        }
    })
    self:SetBackdropColor(0, 0, 0, 0.5)
    self:CreateBeautyBorder(12)
end)

local function GetZoneColor()
    local zoneType = GetZonePVPInfo()
    
    if (zoneType == 'sanctuary') then
        return 0.4, 0.8, 0.94
    elseif (zoneType == 'arena') then
        return 1, 0.1, 0.1
    elseif (zoneType == 'friendly') then
        return 0.1, 1, 0.1
    elseif (zoneType == 'hostile') then
        return 1, 0.1, 0.1
    elseif (zoneType == 'contested') then
        return 1, 0.8, 0
    else
        return 1, 1, 1
    end
end

    -- Mouseover zone text

if (cfg.mouseover.zoneText) then
    local MainZone = Minimap:CreateFontString(nil, 'OVERLAY')
    MainZone:SetFont('Fonts\\ARIALN.ttf', 16, 'THINOUTLINE')
    MainZone:SetPoint('TOP', Minimap, 0, -22)
    MainZone:SetTextColor(1, 1, 1)
    MainZone:SetAlpha(0)
    MainZone:SetSize(130, 32)
    MainZone:SetJustifyV('BOTTOM')

    local SubZone = Minimap:CreateFontString(nil, 'OVERLAY')
    SubZone:SetFont('Fonts\\ARIALN.ttf', 13, 'THINOUTLINE')
    SubZone:SetPoint('TOP', MainZone, 'BOTTOM', 0, -1)
    SubZone:SetTextColor(1, 1, 1)
    SubZone:SetAlpha(0)
    SubZone:SetSize(130, 26)
    SubZone:SetJustifyV('TOP')

    Minimap:HookScript('OnEnter', function()
        if (not IsShiftKeyDown()) then
            SubZone:SetTextColor(GetZoneColor())
            SubZone:SetText(GetSubZoneText())
            securecall('UIFrameFadeIn', SubZone, 0.235, SubZone:GetAlpha(), 1)

            MainZone:SetTextColor(GetZoneColor())
            MainZone:SetText(GetRealZoneText())
            securecall('UIFrameFadeIn', MainZone, 0.235, MainZone:GetAlpha(), 1)
        end
    end)

    Minimap:HookScript('OnLeave', function()
        securecall('UIFrameFadeOut', SubZone, 0.235, SubZone:GetAlpha(), 0)
        securecall('UIFrameFadeOut', MainZone, 0.235, MainZone:GetAlpha(), 0)
    end)
end