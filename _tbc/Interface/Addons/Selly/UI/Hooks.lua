local _, Addon = ...
local UI = Addon.UI
local Functions = Addon.Functions
local Items = Addon.Items
local Colors = Addon.Colors
local UI = Addon.UI

--------------------------------------------
-- ITEM SHIFT-CLICK INFO
--------------------------------------------

local function HookItemTooltip(Tooltip)
	if (not Tooltip) then return end
	if (not UI or not UI:IsVisible("SellyManager")) then return end

    Tooltip:AddLine("\n")
    Tooltip:AddLine("Selly:\n")
    Tooltip:AddLine(Functions:PrintColor(Functions:PrintColor("Shift-Click:", Colors.blue).." Add to whitelist.", Colors.white))
end

if (TooltipDataProcessor) then
	TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, HookItemTooltip)
else
	GameTooltip:HookScript("OnTooltipSetItem", HookItemTooltip)
end

--------------------------------------------
-- ITEM CLICK
--------------------------------------------

local function HookItemClick(Self, Button)
	if (not IsLeftShiftKeyDown()) then return end
	if (not UI or not UI:IsVisible("SellyManager")) then return end

	local ContainerID = Self:GetParent():GetID()
	if (not ContainerID) then return end

	local SlotID = Self:GetID()
	if (not SlotID) then return end

	local ContainerInfo = C_Container.GetContainerItemInfo(ContainerID, SlotID)
	if (not ContainerInfo) then return end

	local ItemID = ContainerInfo.itemID
    if (not ItemID) then return end

	local ItemName = C_Item.GetItemInfo(ItemID)
    if (not ItemName) then return end

	local WhiteListFrameName = "SFWhitelistTextbox.Textbox"
	local CurrentWhitelistContent = UI:GetText(WhiteListFrameName)
	local LineBreak = Functions:Condition(strlen(CurrentWhitelistContent) > 0, "\n", "")

	UI:SetText(WhiteListFrameName, CurrentWhitelistContent..LineBreak..ItemName)
end

if (TooltipDataProcessor) then
	-- TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, HookItemID)
else
	hooksecurefunc("ContainerFrameItemButton_OnClick", HookItemClick)
	hooksecurefunc("ContainerFrameItemButton_OnModifiedClick", HookItemClick)
end
