local _, xVermin = ...
local f

f = CreateFrame('Frame', 'RotationFrame_AOE', UIParent, BackdropTemplateMixin and 'BackdropTemplate')
f:SetFrameStrata('TOOLTIP')
f:SetWidth(7)
f:SetHeight(7)
f:ClearAllPoints()
f:SetPoint('TOPLEFT', UIParent, 'TOPLEFT', 15, 0)
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

f = CreateFrame('Frame', 'RotationFrame_INTERRUPT', UIParent, BackdropTemplateMixin and 'BackdropTemplate')
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

f = CreateFrame('Frame', 'RotationFrame_SCRIPT', UIParent, BackdropTemplateMixin and 'BackdropTemplate')
f:SetFrameStrata('TOOLTIP')
f:SetWidth(3)
f:SetHeight(40)
f:ClearAllPoints()
f:SetPoint('LEFT', PlayerFrame, 'RIGHT', 0, 6)
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

f = CreateFrame('Frame', 'RotationFrame_BEHIND', UIParent, BackdropTemplateMixin and 'BackdropTemplate')
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

f = CreateFrame('Frame', 'RotationFrame_UNUSED', UIParent, BackdropTemplateMixin and 'BackdropTemplate')
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
f:SetBackdropColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)

f = CreateFrame('Frame', 'RotationFrame_AOERANGECASTING', UIParent, BackdropTemplateMixin and 'BackdropTemplate')
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
f:SetBackdropColor(1, 1, 1, 1)
