-- flyout.lua handles the secure parts of the flyout frame. updating icons, cooldowns, etc is handled
-- in ui\update.lua

local _,s = ...
s.flyout = {}

s.flyoutsNeedLoaded = nil -- becomes true if we need to fill and flyouts to define selected attributes

-- annoyingly, it seems a target of GetFrameRef() must be named; using this to uniquely name flyout closeButtons
local closeButtonID = 1

-- creates a secure flyout frame for the given list. options is a comma-delimited list of options
-- for now just flyout:<direction> such as flyout:left
function s.flyout:Create(list)
    local flyout = CreateFrame("Frame",nil,s.root,BackdropTemplateMixin and "BackdropTemplate,SecureHandlerBaseTemplate,SecureHandlerShowHideTemplate" or "SecureHandlerBaseTemplate,SecureHandlerShowHideTemplate")
    flyout:Hide()
    flyout:SetSize(120,200)
    flyout:SetClampedToScreen(true)
    flyout:EnableMouse(true)

    s.flyout:Style(flyout)

    flyout:SetAttribute("list",list)

    flyout.entries = s.flyout:GetEntries(flyout) -- ordered list of {"item1","item2","item:heal","spell:rage",etc}
    flyout.buttons = {} -- where buttons themselves will be stored, order list of {button,button,button,etc}

    -- if flyout:<dir> is used, set the direction attribute
    local direction = (list:match("flyout:(%a+)") or ""):lower()
    if direction=="left" or direction=="up" or direction=="right" or direction=="down" then
        flyout:SetAttribute("direction",direction)
    end
   
    -- to make flyouts close in combat, an override key binding will click a hidden close button parented to the flyout that will hide the parent
    flyout.closeButton = CreateFrame("Button",format("SelectFlyout%03dC",closeButtonID),flyout,"SecureHandlerClickTemplate") -- annoyingly, this button seems to need named to be a target for SetBindingClick
    closeButtonID = closeButtonID + 1
    flyout.closeButton:SetAttribute("_onclick",[[ self:GetParent():Hide() ]])
    flyout.closeButton:RegisterForClicks("AnyDown") -- so flyout hides when ESC key goes down instead of up
    flyout:SetFrameRef("closeButton",flyout.closeButton)
    flyout:SetAttribute("_onshow",[[ self:SetBindingClick(true,"ESCAPE",self:GetFrameRef("closeButton")) ]]) -- set override binding for ESC to click closeButton
    flyout:SetAttribute("_onhide",[[ self:ClearBindings() ]]) -- clear override binding for ESC key set when the flyout shown

    -- make this flyout referencable from root, so any menu can use it
    s.root:SetFrameRef(list,flyout)

    s.flyout:RestoreAttributes(flyout) -- fetch saved attributes, if any
    s.flyout:LoadDefault(flyout) -- if no saved attributes, fill flyout from first button (if cache not data loaded, this may do nothing)

    flyout:HookScript("OnShow",s.flyout.OnShow)
    flyout:SetScript("OnAttributeChanged",s.flyout.OnAttributeChanged) -- as attributes change, save them to savedvar

    return flyout
end

-- when a flyout's selected attributes change, saved them to savedvars immediately
function s.flyout:OnAttributeChanged(attrib,value)
    if attrib:lower()=="attribvalue" then -- if a new attribValue is being saved, then ready to save a whole set of attributes
        local list = self:GetAttribute("list")
        local attribClass = self:GetAttribute("attribClass")
        local attribType = self:GetAttribute("attribType")
        local attribKey = self:GetAttribute("attribKey")
        local attribValue = self:GetAttribute("attribValue")
        s.saved:Set(list,attribClass,attribType,attribKey,attribValue) -- save flyout's attributes to savedvar
    end
end

-- gets the last-selected attributes for the flyout from saved variables and sets them if found;
-- if no saved attributes for the flyout, we'll want to come back later after data cached to load them
function s.flyout:RestoreAttributes(flyout)
    local attribClass,attribType,attribKey,attribValue = s.saved:Get(flyout:GetAttribute("list"))
    if attribClass then -- if there are attributes for this flyout in savedvars, load them
        s.utils:SetAttributes(flyout,attribClass,attribType,attribKey,attribValue)
    end
end

function s.flyout:GetEntries(flyout)
    local list = flyout:GetAttribute("list")
    local entries = {}
    -- first replace commas with semicolons when they appear within double quotes ("keep, comma"), then split on remaining commas
    for _,entry in ipairs({strsplit(",",(list:gsub('"(.-)"',function(quoted) return quoted:gsub(",",";") end)))}) do
        entry = entry:gsub(";",","):trim() -- restore comma in quoted sections and trim
        local filter,search = entry:match("^(%w+):(%S.*)") -- %S requires a non-space after the : (some items have : in their name but always a space after)
        if filter and search then -- we have a filter:search entry
            tinsert(entries,{filter:lower(),s.utils:GetCaseInsensitive(s.utils:GetEscapedText(search))})
        else
            tinsert(entries,{"none",entry})
        end
    end
    return entries
end

-- goes through all flyouts and fills them. this is done on entering combat because flyouts can't change during
-- combat and that point is the last opportunity to build flyouts with the current items/spells
-- (this must be called out of combat; calling function should check for InCombatLockdown)
function s.flyout:FillAll()
    for _,flyout in pairs(s.root.flyouts) do
        if not flyout.inactive then -- only fill active flyouts
            s.flyout:Fill(flyout)
        end
    end
end

-- populates a single flyout with buttons that have attributes and positions set, but does not do
-- any visual/unsecure stuff that can wait for the flyout's OnShow
-- (this must be called out of combat; calling function should check for InCombatLockdown)
function s.flyout:Fill(flyout)
    local buttons = flyout.buttons
    s.filters:ExpandEntries(flyout.entries) -- populate s.list "results" with all items/spells from the entries
    local index = 1 -- index of button on the flyout

    local direction = flyout:GetAttribute("direction")

    local numButtons = s.list:GetSize("results")

    -- if there are no entries, then add an "empty" one
    if numButtons==0 then
        s.list:Add("results","empty","nil","nil","nil")
        numButtons = 1
    end

    -- create buttons if needed and fill each with attributes from the expanded entries
    for i=1,numButtons do
        if not buttons[i] then
            buttons[i] = s.button:Create(flyout)
        end
        s.button:SetAttributes(buttons[i],s.list:Get("results",i))
    end
    -- hide any leftover buttons
    for i=numButtons+1,#buttons do
        buttons[i]:Hide()
    end

    flyout.numButtons = numButtons

	-- now position them
    local aspectRatio = 1.62 -- 1:1.62
    local margin = s.settings:Get("UseFlatStyle") and 4 or 8
	if flyout.numButtons>150 then
		aspectRatio = 1.0 -- make flyout a big fat square if over 150 buttons
	end
	local numAcross = floor(sqrt(flyout.numButtons/aspectRatio)+.5)
	local parentWidth = numAcross*38+(margin*1.75) -- (margin+6) was 14
	local parentHeight = ceil(flyout.numButtons/numAcross)*38+(margin*1.75) -- (margin+6) was 14
	for i=1,flyout.numButtons do
        button = buttons[i]
        button:ClearAllPoints()
        if direction=="down" then
            button:SetPoint("TOPLEFT",margin+((i-1)%numAcross)*38,-(margin+(floor((i-1)/numAcross))*38))
        elseif direction=="left" then
            button:SetPoint("TOPRIGHT",-(margin+(floor((i-1)/numAcross))*38),-(margin+((i-1)%numAcross)*38))
        elseif direction=="right" then
            button:SetPoint("TOPLEFT",margin+(floor((i-1)/numAcross))*38,-(margin+((i-1)%numAcross)*38))
        else
            button:SetPoint("BOTTOMLEFT",margin+((i-1)%numAcross)*38,margin+(floor((i-1)/numAcross))*38)
        end
		button:Show()
    end
    if direction=="left" or direction=="right" then
        flyout:SetSize(parentHeight,parentWidth)
    else
        flyout:SetSize(parentWidth,parentHeight)
    end

end

-- called in the flyout's OnShow, updates the visual/unsecure bits of all buttons
function s.flyout:OnShow()
    if self.numButtons then
        for i=1,self.numButtons do
            s.button:UpdateDisplay(self.buttons[i])
        end
    end
end

-- if a flyout doesn't have default attributes, then fill the flyout and use the first button as default
-- returns true if it set a default (or already had defaults); false if cache wasn't data loaded or
-- flyout didn't have a non-empty button to choose as default
function s.flyout:LoadDefault(flyout)
    if flyout.inactive then
        return -- don't bother to load defaults for inactive flyouts
    elseif s.cache:IsDataLoaded() then
        local attribClass = flyout:GetAttribute("attribClass")
        if not attribClass or attribClass=="empty" then -- don't overwrite any existing attributes
            s.flyout:Fill(flyout)
            if flyout.numButtons>0 and flyout.buttons[1]:GetAttribute("attribClass")~="empty" then
                s.utils:CopyAttributes(flyout.buttons[1],flyout)
                return true
            end
        else
            return true
        end
    end
end

-- updates the style of the flyout depending on UseFlatStyle settings. the flyout only has a different
-- border where s.button:Style() changes several elements for the flat look
function s.flyout:Style(flyout)
    if flyout.inactive then
        return -- no need to style inactive flyouts
    elseif s.settings:Get("UseFlatStyle") then
        -- thin 1px gold border
        flyout:SetBackdrop({bgFile="Interface\\DialogFrame\\UI-DialogBox-Background", insets={left=1,right=1,top=1,bottom=1}, tileSize=16, tile=true, edgeFile="Interface\\ChatFrame\\ChatFrameBackground", edgeSize=1})
        flyout:SetBackdropBorderColor(0.5,0.41,0)
    else
        -- thick gold border with "knots" at the corners
        flyout:SetBackdrop({bgFile="Interface\\DialogFrame\\UI-DialogBox-Background", insets={left=4,right=4,top=4,bottom=4}, tileSize=16, tile=true, edgeFile="Interface\\DialogFrame\\UI-DialogBox-Gold-Border", edgeSize=16})
        flyout:SetBackdropBorderColor(1,1,1)
    end
end
