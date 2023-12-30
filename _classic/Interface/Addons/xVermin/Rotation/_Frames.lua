local _, xVermin = ...

local start = CreateFrame('BUTTON', 'RotBotF1')
local stop = CreateFrame('BUTTON', 'RotBotF2')

SetBindingClick('HOME', "RotBotF1")
SetBindingClick('END', "RotBotF2")

start:SetScript(
	'OnClick',
	function(self, event)
		RotationFrame1:SetBackdropColor(0, 1, 0, 0.9)
	end
)

stop:SetScript(
	'OnClick',
	function(self, event)
		RotationFrame1:SetBackdropColor(1, 0, 0, 0.9)
	end
)




local f

f = CreateFrame('Frame', 'RotationFrame1', UIParent, BackdropTemplateMixin and 'BackdropTemplate')
f:SetFrameStrata('TOOLTIP')
f:SetWidth(3)
f:SetHeight(35)
f:ClearAllPoints()
f:SetPoint('CENTER', UIParent, 'CENTER', -135, -90)
f:SetFrameStrata('BACKGROUND')
f:SetBackdrop(
	{
		bgFile = xVermin.Config.background.white,
		edgeFile = '',
		tile = false,
		tileSize = 0,
		edgeSize = 0,
		insets = {left = 0, right = 0, top = 0, bottom = 0}
	}
)
f:SetBackdropColor(1, 0, 0, 0.9)

f = CreateFrame('Frame', 'RotationFrame2', UIParent, BackdropTemplateMixin and 'BackdropTemplate')
f:SetFrameStrata('TOOLTIP')
f:SetWidth(7)
f:SetHeight(7)
f:ClearAllPoints()
f:SetPoint('TOPLEFT', UIParent, 'TOPLEFT', 25, 0)
f:SetFrameStrata('BACKGROUND')
f:SetBackdrop(
	{
		bgFile = xVermin.Config.background.white,
		edgeFile = '',
		tile = false,
		tileSize = 0,
		edgeSize = 0,
		insets = {left = 0, right = 0, top = 0, bottom = 0}
	}
)
f:SetBackdropColor(1, 1, 1, 1)

f = CreateFrame('Frame', 'RotationFrame3', UIParent, BackdropTemplateMixin and 'BackdropTemplate')
f:SetFrameStrata('TOOLTIP')
f:SetWidth(7)
f:SetHeight(7)
f:ClearAllPoints()
f:SetPoint('TOPLEFT', UIParent, 'TOPLEFT', 35, 0)
f:SetFrameStrata('BACKGROUND')
f:SetBackdrop(
	{
		bgFile = xVermin.Config.background.white,
		edgeFile = '',
		tile = false,
		tileSize = 0,
		edgeSize = 0,
		insets = {left = 0, right = 0, top = 0, bottom = 0}
	}
)
f:SetBackdropColor(1, 1, 1, 1)

f = CreateFrame('Frame', 'RotationFrame4', UIParent, BackdropTemplateMixin and 'BackdropTemplate')
f:SetFrameStrata('TOOLTIP')
f:SetWidth(7)
f:SetHeight(7)
f:ClearAllPoints()
f:SetPoint('TOPLEFT', UIParent, 'TOPLEFT', 45, 0)
f:SetFrameStrata('BACKGROUND')
f:SetBackdrop(
	{
		bgFile = xVermin.Config.background.white,
		edgeFile = '',
		tile = false,
		tileSize = 0,
		edgeSize = 0,
		insets = {left = 0, right = 0, top = 0, bottom = 0}
	}
)
f:SetBackdropColor(1, 1, 1, 1)

f = CreateFrame('Frame', 'RotationFrame5', UIParent, BackdropTemplateMixin and 'BackdropTemplate')
f:SetFrameStrata('TOOLTIP')
f:SetWidth(7)
f:SetHeight(7)
f:ClearAllPoints()
f:SetPoint('TOPLEFT', UIParent, 'TOPLEFT', 55, 0)
f:SetFrameStrata('BACKGROUND')
f:SetBackdrop(
	{
		bgFile = xVermin.Config.background.white,
		edgeFile = '',
		tile = false,
		tileSize = 0,
		edgeSize = 0,
		insets = {left = 0, right = 0, top = 0, bottom = 0}
	}
)
f:SetBackdropColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)

f = CreateFrame('Frame', 'RotationFrame_AOERANGECASTING', UIParent, BackdropTemplateMixin and 'BackdropTemplate')
f:SetFrameStrata('TOOLTIP')
f:SetWidth(7)
f:SetHeight(7)
f:ClearAllPoints()
f:SetPoint('TOPLEFT', UIParent, 'TOPLEFT', 65, 0)
f:SetFrameStrata('BACKGROUND')
f:SetBackdrop(
	{
		bgFile = xVermin.Config.background.white,
		edgeFile = '',
		tile = false,
		tileSize = 0,
		edgeSize = 0,
		insets = {left = 0, right = 0, top = 0, bottom = 0}
	}
)
f:SetBackdropColor(1, 1, 1, 1)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  ROTATION TEXTURE FRAMES
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local RotationTextureFrame1 = CreateFrame('Frame', 'RotationTextureFrame1', UIParent, BackdropTemplateMixin and 'BackdropTemplate')
RotationTextureFrame1:SetSize(30, 30)
RotationTextureFrame1:SetPoint('TOPLEFT', 0, 40)
RotationTextureFrame1:SetScale(0.4)
RotationTextureFrame1:CreateBeautyBorder(8)
RotationTextureFrame1:SetClampedToScreen(true)
RotationTextureFrame1.texture = RotationTextureFrame1:CreateTexture(nil, 'BACKGROUND')
RotationTextureFrame1.texture:SetSize(RotationTextureFrame1:GetSize())
RotationTextureFrame1.texture:SetPoint('CENTER')
RotationTextureFrame1.texture:SetTexture(GetSpellTexture(78))
RotationTextureFrame1:Hide()

local RotationTextureFrame2 = CreateFrame('Frame', 'RotationTextureFrame2', UIParent, BackdropTemplateMixin and 'BackdropTemplate')
RotationTextureFrame2:SetSize(30, 30)
RotationTextureFrame2:SetPoint('TOPLEFT', 30, 40)
RotationTextureFrame2:SetScale(0.4)
RotationTextureFrame2:CreateBeautyBorder(8)
RotationTextureFrame2:SetClampedToScreen(true)
RotationTextureFrame2.texture = RotationTextureFrame2:CreateTexture(nil, 'BACKGROUND')
RotationTextureFrame2.texture:SetSize(RotationTextureFrame2:GetSize())
RotationTextureFrame2.texture:SetPoint('CENTER')
RotationTextureFrame2.texture:SetTexture(GetSpellTexture(78))
RotationTextureFrame2:Hide()

local RotationTextureFrame3 = CreateFrame('Frame', 'RotationTextureFrame3', UIParent, BackdropTemplateMixin and 'BackdropTemplate')
RotationTextureFrame3:SetSize(30, 30)
RotationTextureFrame3:SetPoint('TOPLEFT', 600, 40)
RotationTextureFrame3:SetScale(0.4)
RotationTextureFrame3:CreateBeautyBorder(8)
RotationTextureFrame3:SetClampedToScreen(true)
RotationTextureFrame3.texture = RotationTextureFrame3:CreateTexture(nil, 'BACKGROUND')
RotationTextureFrame3.texture:SetSize(RotationTextureFrame3:GetSize())
RotationTextureFrame3.texture:SetPoint('CENTER')
RotationTextureFrame3.texture:SetTexture(GetSpellTexture(78))
RotationTextureFrame3:Hide()

local natf = CreateFrame('Frame', 'NEXT_ACTION_TEXT_FRAME')
natf:SetPoint('CENTER', UIParent, 'CENTER', 0, 10)
natf.text = natf:CreateFontString(f:GetName() .. '_TEXT', 'BACKGROUND')
natf.text:SetFont(xVermin.Config.font.arial, 18, 'NONE')
natf.text:SetPoint('CENTER', natf, 'CENTER', 0, 0)
natf.text:SetTextColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)
natf.text:SetShadowColor(0, 0, 0, 1.0)
natf.text:SetShadowOffset(2, -2)

local data = {}
local skills = {}
local skill = {}
skills['revenge'] = '#7bd079'

skills['HOW'] = 57623
skills['IT'] = 49909
skills['PS'] = 49921
skills['FS'] = 55268
skills['HB'] = 51411
skills['OB'] = 51425
skills['PES'] = 50842
skills['BS'] = 49930
skills['BT_full'] = 45529

local RTF = function(xframe, xtype, xid)
	local frame = _G['RotationTextureFrame' .. xframe]

	natf.text:SetText(xid)

	if xid == 'clear' then
		frame:Hide()
		return
	end

	xid = skills[xid] and skills[xid] or xid

	if xtype == 'GetSpellTexture' or xtype == 1 then
		frame.texture:SetTexture(GetSpellTexture(xid))
	end

	if xtype == 'GetItemIcon' or xtype == 2 then
		frame.texture:SetTexture(GetItemIcon(xid))
	end

	if xtype == 3 then
		frame.texture:SetTexture(xid)
	end

	frame:Show()
end
xRTF = RTF

local RTFH = function(xframe)
	local f = _G['RotationTextureFrame' .. xframe]
	f:Hide()
end
xRTFH = RTFH
