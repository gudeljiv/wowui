local _, addon = ...

local CloseSocketingFrame = addon.CloseSocketingFrame;

local FadeFrame = NarciFadeUI.Fade;
local GetSocketTypes = GetSocketTypes;
local SocketInventoryItem = SocketInventoryItem;

local MainFrame;
local SocketButtons = {};

local SIZE_REGULAR = 16;
local SIZE_SELECTED = 18;

local GetPixelByScale = NarciAPI.GetPixelByScale;
local PIXEL = 1;

local PixelPerfectController = {};
addon.PixelPerfectController = PixelPerfectController;
PixelPerfectController.objects = {};

function PixelPerfectController:SetScale(scale)
    local pixel = GetPixelByScale(scale, 1);
    PIXEL = pixel;
    for _, object in pairs(self.objects) do
        object:UpdatePixel(pixel);
    end
end


NarciEquipmentSharedSquareButtonMixin = {};

function NarciEquipmentSharedSquareButtonMixin:OnLoad()
    self.Exclusion:SetTexture("Interface\\AddOns\\Narcissus\\Art\\Masks\\Exclusion", "CLAMPTOWHITE", "CLAMPTOWHITE", "NEAREST");
    tinsert(PixelPerfectController.objects, self);
end

function NarciEquipmentSharedSquareButtonMixin:UpdatePixel(pixel)
    local sizeInPixel = math.floor( (self.size or SIZE_REGULAR) / pixel + 0.5);
    sizeInPixel = sizeInPixel + sizeInPixel % 2;
    local size = sizeInPixel * pixel;
    local borderSize = size - 4 * pixel;
    local innerSize = borderSize - 2 * pixel;
    self:SetSize(SIZE_REGULAR, SIZE_REGULAR);
    self.Stroke:SetSize(size, size);
    self.Border:SetSize(borderSize, borderSize)
    self.Exclusion:SetSize(innerSize, innerSize);
end

function NarciEquipmentSharedSquareButtonMixin:SetBorderColor(r, g, b)
    self.Border:SetColorTexture(r, g, b);
end

function NarciEquipmentSharedSquareButtonMixin:SetStrokeColor(r, g, b)
    self.Stroke:SetColorTexture(r, g, b);
end



NarciSocketSelectButtonMixin = CreateFromMixins(NarciEquipmentSharedSquareButtonMixin);

function NarciSocketSelectButtonMixin:OnLoad()
    self.Exclusion:SetTexture("Interface\\AddOns\\Narcissus\\Art\\Masks\\Exclusion", "CLAMPTOWHITE", "CLAMPTOWHITE", "NEAREST");
    self.Border:SetTexture("Interface\\AddOns\\Narcissus\\Art\\EquipmentOption\\SocketTexture");
    self:SetBorderColor(0.25, 0.25, 0.25);
end

function NarciSocketSelectButtonMixin:OnShow()
    self:UpdatePixel(PIXEL);
end

function NarciSocketSelectButtonMixin:OnEnter()
    self:SetBorderColor(1, 1, 1);
    local fontString = self:GetParent().SocketName;
    if self.gemName then
        local r, g, b = NarciAPI.GetItemQualityColorByItemID(self.gemLink);
        fontString:SetTextColor(r, g, b);
        fontString:SetText(string.format("%s\n|cffcccccc#%d %s|r", self.gemName, self.id, self.localizedName));
    else
        fontString:SetText(string.format("#%d %s", self.id, self.localizedName));
        fontString:SetTextColor(0.92, 0.92, 0.92);
    end
    fontString:Show();
    FadeFrame(fontString, 0.15, 1);
    FadeFrame(self:GetParent().TextShadow, 0.15, 1);
end

function NarciSocketSelectButtonMixin:OnLeave()
    if not self.selected then
        self:SetBorderColor(0.25, 0.25, 0.25);
    end

    FadeFrame(self:GetParent().SocketName, 0.2, 0);
    FadeFrame(self:GetParent().TextShadow, 0.2, 0);
end

function NarciSocketSelectButtonMixin:Select()
    for _, button in pairs(SocketButtons) do
        if button == self then
            button.selected = true;
            button.size = SIZE_SELECTED;
            button:SetBorderColor(1, 1, 1);
        else
            button.selected = nil;
            button.size = SIZE_REGULAR;
            button:SetBorderColor(0.25, 0.25, 0.25);
        end
        button:UpdatePixel(PIXEL);
    end
end

function NarciSocketSelectButtonMixin:OnClick()
    self:Select();
    MainFrame:ShowGemList(self.socketTypeName);
    MainFrame:SetSocketOrderID(self.id);
end

function NarciSocketSelectButtonMixin:SetSocketTypeByName(englishName)
    local typeName;
    if englishName then
        typeName = _G["EMPTY_SOCKET_"..string.upper(englishName)];
    end
    self.localizedName = typeName or englishName;
    self.socketTypeName = englishName;
end



NarciSocketSelectMixin = {};

function NarciSocketSelectMixin:OnLoad()
    MainFrame = self:GetParent():GetParent();
end

function NarciSocketSelectMixin:OnHide()
    self.anySelection = nil;
    self.lastItem = nil;
end

function NarciSocketSelectMixin:SetupFromItemLink(itemLink)
    local anyPending;
    local selectedSocketType;

    local socektInfo = NarciAPI.GetItemSocketInfo(itemLink);
    local numSockets = (socektInfo and #socektInfo) or 0;

    if itemLink ~= self.lastItem then
        self.lastItem = itemLink;
        self.anySelection = false;
    end

    if numSockets > 0 then
        local socketType, icon, gemLink;

        for i = 1, numSockets do
            if not SocketButtons[i] then
                SocketButtons[i] = CreateFrame("Button", nil, self, "NarciSocketSelectButtonTemplate");
                SocketButtons[i].id = i;
                SocketButtons[i]:SetPoint("CENTER", self, "LEFT", 8 + 24 * (i - 1), 0);
            end
            socketType, icon, gemLink = unpack(socektInfo[i]);
            SocketButtons[i].Icon:SetTexture(icon);
            if gemLink then
                SocketButtons[i].Icon:SetTexCoord(0.075, 0.925, 0.075, 0.925);
                SocketButtons[i].gemName = socketType;
                SocketButtons[i].gemLink = gemLink;
                anyPending = true;
            else
                SocketButtons[i].Icon:SetTexCoord(0, 1, 0, 1);
                SocketButtons[i].gemName = nil;
                SocketButtons[i].gemLink = nil;
                SocketButtons[i]:SetSocketTypeByName(socketType);
                if not selectedSocketType then
                    selectedSocketType = socketType;
                end
            end
            SocketButtons[i]:Show();
        end

        for i = numSockets + 1, 3 do
            if SocketButtons[i] then
                SocketButtons[i]:Hide();
                SocketButtons[i].gemName = nil;
                SocketButtons[i].gemLink = nil;
            end
        end

        if numSockets > 1 then
            self:Show();
        else
            self:Hide();
        end
        MainFrame:SetSocketOrderID(1);
    else
        MainFrame:SetSocketOrderID(1);
        self:Hide();
        return
    end

    if not self.anySelection then
        self.anySelection = true;
        --MainFrame:SetSocketOrderID(1);
        SocketButtons[1]:Click();
    end

    if anyPending then
        --use ItemSocketingFrame to get socket type order
        local isNarcissusUI = MainFrame.isNarcissusUI;
        if isNarcissusUI then
            SocketInventoryItem(MainFrame.slotID);
        end
        local socketType;
        for i = 1, numSockets do
            if SocketButtons[i] then
                socketType = GetSocketTypes(i);
                SocketButtons[i]:SetSocketTypeByName(socketType);
            end
        end

        local selectedSocketID = MainFrame:GetSocketOrderID();
        if selectedSocketID then
            selectedSocketType = GetSocketTypes(selectedSocketID);
        end

        if isNarcissusUI then
            CloseSocketingFrame();
        end
    end



    return selectedSocketType
end

function NarciSocketSelectMixin:SetTypeHomogeneous(numSockets, typeName)
    for i = 1, numSockets do
        if SocketButtons[i] then
            SocketButtons[i]:SetSocketTypeByName(typeName);
        end
    end
    for i = numSockets + 1, 3 do
        if SocketButtons[i] then
            SocketButtons[i]:Hide();
        end
    end
    self:Show();
end