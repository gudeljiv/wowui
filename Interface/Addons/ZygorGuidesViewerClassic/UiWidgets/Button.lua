local ZGV = ZygorGuidesViewer
if not (ZGV and ZGV.UI) then return end

local tinsert,tremove,print,ipairs,pairs,wipe=tinsert,tremove,print,ipairs,pairs,wipe

local FONT=ZGV.Font
local FONTBOLD=ZGV.FontBold
local L = ZGV.L
local CHAIN = ZGV.ChainCall

local Button = {}
ZGV.UI:RegisterWidget("Button",Button)

local SkinData = ZGV.UI.SkinData

local DEFAULTWIDTH = 80
local DEFAULTHEIGHT = 20
local TEXTBUFFER = 5

--[[
	Class for a nice button. Shortcut for setting font/textcolor of the fontstring in the button.

	Size defaults to 80,20
	No text by default.
	Can automatically create a texture for the button by calling button:SetTexture()

	Style 1/nil	= grey button / white border
	Style 2		= orange button

	Sample Use:
		local button = CHAIN(ZGV.Ui:Create("Button",MYFRAME,"nameofButton"))
			:SetPoint("LEFT",25,0)
			:SetSize(100,50)
			:SetFont(FONTBOLD,20)
			:SetTextColor(1)
			:SetText("I am a button!")
			:SetScript("OnClick",func)
		.__END

	Known Issues:
		Only uses stealth skin.
		Does not do anything with sizing
		No tooltips available
--]]

function Button:New(parent,name,style)
	style = style or 1
	local buttonBackdrop, buttonBackdropColor, buttonBackdropEdgeColor, buttonHighlightColor

	if style == 1 then
		buttonBackdrop, buttonBackdropColor, buttonBackdropEdgeColor, buttonHighlightColor = "ButtonBackdrop1", "ButtonColor1", "ButtonBorderColor1", "ButtonHighlightColor1"
	elseif style == 2 then
		buttonBackdrop, buttonBackdropColor, buttonHighlightColor = "ButtonBackdrop2", "ButtonColor2", "ButtonHighlightColor2"
	else
		error(("Style %s not supported"):format(style))
	end

	local button = CHAIN(CreateFrame("Button", name, parent))
		:SetBackdrop(SkinData(buttonBackdrop))
		:SetBackdropColor(unpack(SkinData(buttonBackdropColor)))
		:SetSize(DEFAULTWIDTH,DEFAULTHEIGHT)
		:SetText(" ") -- Creates the fontstring for a button. Can't be nil or ""
		:RegisterForClicks("LeftButtonUp")
		-- No Highlight texture because it looks funny with text on the button.
		:EnableMouse(true)
		:SetScript("OnEnter",function(self)
			self:SetBackdropColor(unpack(self.bdhcolor or SkinData(buttonHighlightColor)))
			if self.tooltip then
				GameTooltip:SetOwner(self,"ANCHOR_BOTTOMLEFT")
				GameTooltip:ClearAllPoints()
				GameTooltip:ClearLines()
				GameTooltip:SetText(type(self.tooltip)=="function" and self.tooltip(self) or self.tooltip)
				GameTooltip:Show()
				GameTooltip:SetWidth(300)
				GameTooltip:Show()
			end
		end)
		:SetScript("OnLeave",function(self)
			self:SetBackdropColor(unpack(self.bdcolor or SkinData(buttonBackdropColor)))
			if self.tooltip then GameTooltip:Hide() end
		end)
	.__END

	if buttonBackdropEdgeColor then button:SetBackdropBorderColor(unpack(SkinData(buttonBackdropEdgeColor))) end

	button.super = {}
	for f,fun in pairs(self) do  if type(fun)=="function" then
		if button[f] then button.super[f]=button[f] end
		button[f]=fun
	end end

	CHAIN(button:GetFontString())
		:SetFont(FONT,12)
		:SetTextColor(1.0,1.0,1.0)

	return button
end

function Button:ShowIf(condition)
	if condition then self:Show() else self:Hide() end 
end

function Button:EnableIf(condition)
	if condition then self:Enable() else self:Disable() end 
end

function Button:SetEnabledIf(set)
	self:GetNormalTexture():SetDesaturated(not set)
	self.soft_disabled = not set
end


function Button:SetNormalBackdropColor(r,g,b,a)
	if not self.bdcolor then self.bdcolor={} end
	self.bdcolor[1] = r
	self.bdcolor[2] = g
	self.bdcolor[3] = b
	self.bdcolor[4] = a
	self:SetBackdropColor(r,g,b,a)
end

function Button:SetHighlightBackdropColor(r,g,b,a)
	if not self.bdhcolor then self.bdhcolor={} end
	self.bdhcolor[1] = r
	self.bdhcolor[2] = g
	self.bdhcolor[3] = b
	self.bdhcolor[4] = a
end

function Button:SetTooltip(tooltip)
	self.tooltip=tooltip
end


-- This can be used to make the button just big enough to hold the text. Updates the button size on text change.
-- Should be called before :SetText()
function Button:SetPerfectSizing(bool)
	self.matchSize = bool
end

-- A bunch of convience functions

function Button:SetFont(font,size)
	self:GetFontString():SetFont(font or FONT,size or 12)
	if self.matchSize then self:SetSize(self:GetStringWidth() + TEXTBUFFER,self:GetStringHeight() + TEXTBUFFER) end
end

function Button:SetTextColor(r,g,b,a)
	self:GetFontString():SetTextColor(r or 1, g or 1, b or 1, a or 1)
end

function Button:GetStringWidth()
	return self:GetFontString():GetStringWidth()
end

function Button:GetStringHeight()
	return self:GetFontString():GetStringHeight()
end

function Button:SetTexture(tex)
	if not tex then return end
	self.tex = CHAIN(self:CreateTexture())
		:SetAllPoints()
		:SetTexture(tex)
	.__END
end

function Button:SetText(text)
	self.super.SetText(self,text)
	if self.matchSize then self:SetSize(self:GetStringWidth() + TEXTBUFFER,self:GetStringHeight() + TEXTBUFFER) end
end

--[[
	Can be 4 or 8 arguments
--]]

function Button:SetTexCoord(ULx, ULy, LLx, LLy, URx, URy, LRx, LRy)
	if not self.tex then return end

	if URx then
		self.tex:SetTexCoord(ULx, ULy, LLx, LLy, URx, URy, LRx, LRy)
	else
		self.tex:SetTexCoord(ULx, ULy, LLx, LLy)--, URx, URy, LRx, LRy)
	end
end

--[[
	Can pass "parent" to make clicking drag the parent. otherwise any non false/nil value will drag self.

	Does not do any error checking so assumes that a parent is there if you try to drag parent.

	TODO need to develop :CanDrag(false)

	-- Copied from Frame
--]]

function Button:CanDrag(drag)
	if drag then
		CHAIN(self)
			:EnableMouse(true)
			:RegisterForDrag("LeftButton")

		if drag == "parent" then
			CHAIN(self)
				:SetScript("OnDragStart",function(me) me:GetParent():GetScript("OnDragStart")(me:GetParent()) end)
				:SetScript("OnDragStop",function(me) me:GetParent():GetScript("OnDragStop")(me:GetParent()) end)
		else
			CHAIN(self)
				:SetScript("OnDragStart",function(me) me:StartMoving() end)
				:SetScript("OnDragStop",function(me) me:StopMovingOrSizing() end)
		end
	else
		-- If we can't drag then don't need to undo dragging
		if not self:HasScript("OnDragStart") then return end

		-- Undo it.
		CHAIN(self)
			-- TODO :EnableMouse(false) maybe?
			:SetScript("OnDragStart",nil)
			:SetScript("OnDragStop",nil)
			
	end
end
