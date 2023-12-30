local AS = unpack(AddOnSkins)

local _G = _G
local unpack = unpack
local pairs = pairs
local select = select
local type = type
local next = next
local abs = abs
local strlower, strfind = strlower, strfind
local CopyTable, tremove = CopyTable, tremove
local hooksecurefunc = hooksecurefunc

local CreateFrame = CreateFrame
local EnumerateFrames = EnumerateFrames

-- Add texture id's to be stripped
-- 137056 -- Interface\\Tooltips\\UI-Tooltip-Background
-- 137057 -- Interface\\Tooltips\\UI-Tooltip-Border
-- 131080 -- Interface\\DialogFrame\\UI-DialogBox-Header
-- 130838 -- Interface\\Buttons\\UI-PlusButton-UP
-- 130836 -- Interface\\Buttons\\UI-PlusButton-DOWN
-- 130821 -- Interface\\Buttons\\UI-MinusButton-UP
-- 130820 -- Interface\\Buttons\\UI-MinusButton-DOWN
-- 251966 -- Interface\\PaperDollInfoFrame\\UI-GearManager-Title-Background
-- 251963 -- Interface\\PaperDollInfoFrame\\UI-GearManager-Border
-- 130843 -- Interface\\Buttons\\UI-RadioButton
-- 130755 -- Interface\\Buttons\\UI-CheckBox-Up
-- 130751 -- Interface\\Buttons\\UI-CheckBox-Check
-- 130753 -- Interface\\Buttons\\UI-CheckBox-Highlight

AS.Blizzard = {}

AS.Blizzard.Regions = { 'Left', 'Middle', 'Right', 'Top', 'Bottom', 'Tab', 'Cover', 'Border', 'Background', 'Center', 'Mid' }
AS.Blizzard.Frames = { '[iI]nset', 'NineSlice', 'Border', 'bg', 'FilligreeOverlay' }
AS.Blizzard.Tooltip = { 'Background', 'Delimiter', 'Border' }

AS.RegisterTemplates = {}

local invertedShadow = { bgFile = [[Interface\AddOns\AddOnSkins\Media\Textures\InvertedShadow]] }
local shadow = { edgeFile = [[Interface\AddOns\AddOnSkins\Media\Textures\Shadows]], edgeSize = 3 }

function AS:UpdateSettings()
	for Frame in pairs(AS.RegisterTemplates) do
		AS:SetTemplate(Frame)
	end
end

function AS:Kill(Object)
	if Object.UnregisterAllEvents then
		Object:UnregisterAllEvents()
		Object:SetParent(AS.Hider)
	else
		Object.Show = Object.Hide
	end

	Object:Hide()
end

function AS:SetInside(obj, anchor, xOffset, yOffset, anchor2)
	xOffset, yOffset, anchor = xOffset or 1, yOffset or 1, anchor or obj:GetParent()

	if obj:GetPoint() then obj:ClearAllPoints() end

	obj:SetPoint('TOPLEFT', anchor, 'TOPLEFT', xOffset, -yOffset)
	obj:SetPoint('BOTTOMRIGHT', anchor2 or anchor, 'BOTTOMRIGHT', -xOffset, yOffset)
end

function AS:SetOutside(obj, anchor, xOffset, yOffset, anchor2)
	xOffset, yOffset, anchor = xOffset or 1, yOffset or 1, anchor or obj:GetParent()

	if obj:GetPoint() then obj:ClearAllPoints() end

	obj:SetPoint('TOPLEFT', anchor, 'TOPLEFT', -xOffset, yOffset)
	obj:SetPoint('BOTTOMRIGHT', anchor2 or anchor, 'BOTTOMRIGHT', xOffset, -yOffset)
end

function AS:CleanTexture(Object, Kill, Alpha)
	if Kill then
		AS:Kill(Object)
	elseif Alpha then
		Object:SetAlpha(0)
	else
		Object:SetTexture('')
	end
end

function AS:StripTextures(Object, Kill, Alpha)
	if Object.IsObjectType and Object:IsObjectType('Texture') then
		AS:CleanTexture(Object, Kill, Alpha)
	else
		local FrameName = Object.GetName and Object:GetName()

		for objectName, objectType in pairs(Object) do
			for _, Blizzard in pairs(AS.Blizzard.Frames) do
				if type(objectName) == 'string' and (type(objectType) == 'string' or type(objectType) == 'table') and strfind(objectName, Blizzard) then
					local BlizzFrame = Object[objectName] or FrameName and _G[FrameName..objectName]
					if BlizzFrame then
						AS:StripTextures(BlizzFrame, Kill)
					end
				end
			end
		end

		if Object.GetNumRegions then
			for i = 1, Object:GetNumRegions() do
				local Region = select(i, Object:GetRegions())
				if Region and Region:IsObjectType('Texture') then
					AS:CleanTexture(Region, Kill, Alpha)
				end
			end
		end
	end
end

function AS:StripTexture(Object, Texture, Kill, Alpha)
	if Object:IsObjectType('Texture') and type(Object:GetTexture()) == 'string' and strlower(Object:GetTexture()) == strlower(Texture) then
		AS:CleanTexture(Object, Kill, Alpha)
	else
		if Object.GetNumRegions then
			for i = 1, Object:GetNumRegions() do
				local Region = select(i, Object:GetRegions())
				if Region and Region:IsObjectType('Texture') and type(Region:GetTexture()) == 'string' and strlower(Region:GetTexture()) == strlower(Texture) then
					AS:CleanTexture(Region, Kill, Alpha)
				end
			end
		end
	end
end

function AS:CreateBackdrop(Frame, Template, Texture)
	if Frame.Backdrop then return end

	local Parent = Frame.IsObjectType and Frame:IsObjectType('Texture') and Frame:GetParent() or Frame

	local Backdrop = CreateFrame('Frame', nil, Parent)
	if not Backdrop.SetBackdrop then _G.Mixin(Backdrop, _G.BackdropTemplateMixin) end
	AS:SetOutside(Backdrop, Frame)
	AS:SetTemplate(Backdrop, Template, Texture)

	if (Parent:GetFrameLevel() - 1) >= 0 then
		Backdrop:SetFrameLevel(Parent:GetFrameLevel() - 1)
	else
		Backdrop:SetFrameLevel(0)
	end

	Frame.Backdrop = Backdrop
end

function AS:CreateShadow(Frame, NoRegister, Inverted)
	if (not AS:CheckOption('Shadows')) or Frame.Shadow then return end

	local Shadow = CreateFrame('Frame', nil, Frame)
	if not Shadow.SetBackdrop then _G.Mixin(Shadow, _G.BackdropTemplateMixin) end
	Shadow:SetFrameStrata(Frame:GetFrameStrata())

	local FrameLevel = Frame:GetFrameLevel() > 1 and Frame:GetFrameLevel() or 1

	if Inverted then
		Shadow:SetBackdrop(invertedShadow)
		Shadow:SetFrameLevel(FrameLevel + 1)
		AS:SetInside(Shadow, Frame)
	else
		Shadow:SetBackdrop(shadow)
		Shadow:SetFrameLevel(FrameLevel)
		AS:SetOutside(Shadow, Frame)
	end

	Shadow.Inverted = Inverted
	Shadow:SetBackdropColor(0, 0, 0, .8)
	Shadow:SetBackdropBorderColor(0, 0, 0, .8)

	if (not NoRegister) and AS.ES then
		AS.ES:RegisterShadow(Shadow)
	end

	Frame.Shadow = Shadow
end

function AS:GradientHighlight(frame, layer, color)
	if frame.SetHighlightTexture then
		frame:SetHighlightTexture('')
	end

	local r, g, b = .9, .9, .9
	if color then
		r, g, b = color.r or color[1], color.g or color[2], color.b or color[3]
	end

	local leftGrad = frame:CreateTexture(nil, layer or 'HIGHLIGHT')
	leftGrad:SetSize(frame:GetWidth() * 0.5, frame:GetHeight() * 0.95)
	leftGrad:SetPoint('LEFT', frame, 'CENTER')
	leftGrad:SetTexture(AS.Blank)
	leftGrad:SetGradientAlpha('Horizontal', r, g, b, 0.35, r, g, b, 0)

	local rightGrad = frame:CreateTexture(nil, layer or 'HIGHLIGHT')
	rightGrad:SetSize(frame:GetWidth() * 0.5, frame:GetHeight() * 0.95)
	rightGrad:SetPoint('RIGHT', frame, 'CENTER')
	rightGrad:SetTexture(AS.Blank)
	rightGrad:SetGradientAlpha('Horizontal', r, g, b, 0, r, g, b, 0.35)
end

local function Desaturate(self, value)
	if value ~= true then self:SetDesaturated(true) end
end

function AS:Desaturate(frame)
	if frame.GetNumRegions then
		for i = 1, frame:GetNumRegions() do
			local region = select(i, frame:GetRegions())
			if region:IsObjectType('Texture') then
				local Texture = region:GetTexture()
				if type(Texture) == 'string' and strlower(Texture) == 'interface\\dialogframe\\ui-dialogbox-corner' then
					region:SetTexture()
					AS:Kill(region)
				else
					region:SetDesaturated(true)
				end
			end
		end
	end

	if frame.IsObjectType and (frame:IsObjectType('Button') or frame:IsObjectType('CheckButton')) then
		local Normal, Pushed, Highlight = frame:GetNormalTexture(), frame:GetPushedTexture(), frame:GetHighlightTexture()

		if Normal then
			Normal:SetDesaturated(true)
			hooksecurefunc(Normal, 'SetDesaturated', Desaturate)
		end

		if Pushed then
			Pushed:SetDesaturated(true)
			hooksecurefunc(Pushed, 'SetDesaturated', Desaturate)
		end

		if Highlight then
			Highlight:SetDesaturated(true)
			hooksecurefunc(Highlight, 'SetDesaturated', Desaturate)
		end
	end
end

function AS:SetTemplate(Frame, Template, Texture)
	Texture = Texture or AS.Libs.LSM:Fetch('statusbar', AS:CheckOption('BackgroundTexture'))
	Template = Template or AS:CheckOption('SkinTemplate')

	local R, G, B = unpack(AS.BackdropColor)
	local Alpha = (Template == 'Default' and 1 or .8)
	local ElvUIStyle = AS:CheckOption('ElvUIStyle', 'ElvUI')

	if ElvUIStyle then
		Texture = Frame:IsObjectType('Button') and _G.ElvUI[1].media.glossTex or _G.ElvUI[1].media.blankTex

		if Template == 'Default' then
			R, G, B = unpack(_G.ElvUI[1].media.backdropcolor)
			AS.BackdropColor = _G.ElvUI[1].media.backdropcolor
		else
			R, G, B, Alpha = unpack(_G.ElvUI[1].media.backdropfadecolor)
			AS.BackdropColor = _G.ElvUI[1].media.backdropfadecolor
		end

		Frame.template = Template or 'Default'
		_G.ElvUI[1].frames[Frame] = true
	end

	if not Frame.SetBackdrop then _G.Mixin(Frame, _G.BackdropTemplateMixin) end

	local Backdrop = { edgeFile = AS.Blank, bgFile = Texture, edgeSize = 1 }

	if Template == 'NoBackdrop' then
		Backdrop.bgFile = nil
	elseif Template == 'NoBorder' then
		Backdrop.edgeFile = nil
	end

	if AS:CheckOption('Theme') == 'ThickBorder' or AS:CheckOption('Theme') == 'TwoPixel' then
		for _, Inset in pairs({ 'InsideBorder', 'OutsideBorder' }) do
			Frame[Inset] = CreateFrame('Frame', nil, Frame)
			if not Frame[Inset].SetBackdrop then _G.Mixin(Frame[Inset], _G.BackdropTemplateMixin) end
			Frame[Inset]:SetBackdrop({ edgeFile = AS.Blank, edgeSize = 1 })
			Frame[Inset]:SetBackdropBorderColor(0, 0, 0, 1)
		end

		AS:SetInside(Frame.InsideBorder, Frame, 1, 1)
		Frame.InsideBorder:SetFrameLevel(Frame:GetFrameLevel() + 1)

		if AS:CheckOption('Theme') == 'TwoPixel' then
			AS:SetOutside(Frame.OutsideBorder, Frame, 0, 0)
		else
			AS:SetOutside(Frame.OutsideBorder, Frame, 1, 1)
		end
	end

	Frame:SetBackdrop(Backdrop)

	if Template == 'Custom' then
		Frame:SetBackdropColor(unpack(AS:CheckOption('CustomBackdropColor')))
		Frame:SetBackdropBorderColor(unpack(AS:CheckOption('CustomBorderColor')))
	else
		if Template == 'ClassColor' then
			Frame:SetBackdropBorderColor(unpack(AS.ClassColor))
		else
			Frame:SetBackdropBorderColor(unpack(AS.BorderColor))
		end

		Frame:SetBackdropColor(R, G, B, Alpha)
	end

	if ElvUIStyle then
		if (Template == 'MerathilisUI' and AS:CheckAddOn('ElvUI_MerathilisUI')) then
			Frame:Styling()
		end
	end
end

AS.ArrowRotation = { up = 0, down = 3.14, left = 1.57, right = -1.57 }

function AS:SkinArrowButton(object, Arrow)
	if Arrow then
		Arrow = strlower(Arrow)
	else
		Arrow = 'down'
		local Name = object:GetDebugName() and object:GetDebugName():lower()
		if Name then
			if (strfind(Name, 'left') or strfind(Name, 'prev') or strfind(Name, 'decrement') or strfind(Name, 'back')) then
				Arrow = 'left'
			elseif (strfind(Name, 'right') or strfind(Name, 'next') or strfind(Name, 'increment') or strfind(Name, 'forward')) then
				Arrow = 'right'
			elseif (strfind(Name, 'upbutton') or strfind(Name, 'top') or strfind(Name, 'asc') or strfind(Name, 'home') or strfind(Name, 'maximize')) then
				Arrow = 'up'
			end
		end
	end

	if object:IsObjectType('Button') then
		local Button = object

		if not Button.Mask then
			AS:SkinFrame(Button)

			local Mask = Button:CreateMaskTexture()
			Mask:SetTexture([[Interface\AddOns\AddOnSkins\Media\Textures\Arrow]], 'CLAMPTOBLACKADDITIVE', 'CLAMPTOBLACKADDITIVE')
			Mask:SetRotation(AS.ArrowRotation[Arrow])
			Mask:SetSize(Button:GetWidth() / 1.5, Button:GetHeight() / 1.5)
			Mask:SetPoint('CENTER')

			Button.Mask = Mask

			Button:SetNormalTexture(AS.NormTex)
			Button:SetDisabledTexture(AS.NormTex)
			Button:SetPushedTexture(AS.NormTex)

			local Normal, Disabled, Pushed = Button:GetNormalTexture(), Button:GetDisabledTexture(), Button:GetPushedTexture()

			AS:SetInside(Normal)
			Normal:SetTexCoord(0, 1, 0, 1)
			Normal.SetTexCoord = AS.Noop
			Normal:SetVertexColor(1, 1, 1)
			Normal:AddMaskTexture(Mask)

			AS:SetInside(Disabled)
			Disabled:SetTexCoord(0, 1, 0, 1)
			Disabled.SetTexCoord = AS.Noop
			Disabled:SetVertexColor(.3, .3, .3)
			Disabled:AddMaskTexture(Mask)

			AS:SetInside(Pushed)
			Pushed:SetTexCoord(0, 1, 0, 1)
			Pushed.SetTexCoord = AS.Noop
			Pushed:SetVertexColor(unpack(AS.Color))
			Pushed:AddMaskTexture(Mask)

			Button:HookScript('OnEnter', function(s) s:SetBackdropBorderColor(unpack(AS.Color)) Normal:SetVertexColor(unpack(AS.Color)) end)
			Button:HookScript('OnLeave', function(s) s:SetBackdropBorderColor(unpack(AS.BorderColor)) Normal:SetVertexColor(1, 1, 1) end)
		end

		Button.Mask:SetRotation(AS.ArrowRotation[Arrow])
	elseif object:IsObjectType('Texture') then
		object:SetTexture([[Interface\AddOns\AddOnSkins\Media\Textures\Arrow]], 'CLAMPTOBLACKADDITIVE', 'CLAMPTOBLACKADDITIVE')
		object:SetRotation(AS.ArrowRotation[Arrow])
	end
end

function AS:SkinButton(Button, Strip)
	if Button.isSkinned then return end

	local ButtonName = Button.GetName and Button:GetName()
	local foundArrow

	if Button.Icon then
		local Texture = Button.Icon:GetTexture()
		if Texture and (type(Texture) == 'string' and strfind(Texture, [[Interface\ChatFrame\ChatFrameExpandArrow]])) then
			foundArrow = true
		end
	end

	if Strip then
		AS:StripTextures(Button)
	end

	for objectName, objectType in pairs(Button) do
		for _, Region in pairs(AS.Blizzard.Regions) do
			if type(objectName) == 'string' and (type(objectType) == 'string' or type(objectType) == 'table') and strfind(objectName, Region) then
				local obj = ButtonName and _G[ButtonName..Region] or Button[Region]
				if obj then
					obj:SetAlpha(0)
				end
			end
		end
	end

	if foundArrow then
		Button.Icon:SetTexture([[Interface\AddOns\AddOnSkins\Media\Textures\Arrow]])
		Button.Icon:SetSnapToPixelGrid(false)
		Button.Icon:SetTexelSnappingBias(0)
		Button.Icon:SetVertexColor(1, 1, 1)
		Button.Icon:SetRotation(AS.ArrowRotation['right'])
	end

	if Button.SetNormalTexture then Button:SetNormalTexture('') end
	if Button.SetHighlightTexture then Button:SetHighlightTexture('') end
	if Button.SetPushedTexture then Button:SetPushedTexture('') end
	if Button.SetDisabledTexture then Button:SetDisabledTexture('') end

	AS:SetTemplate(Button, AS:CheckOption('ElvUIStyle', 'ElvUI') and 'Default' or nil)

	if Button.GetFontString and Button:GetFontString() ~= nil then
		Button:HookScript('OnEnable', function(s) s:GetFontString():SetTextColor(1, 1, 1) end)
		Button:HookScript('OnDisable', function(s) s:GetFontString():SetTextColor(.5, .5, .5) end)

		if Button:IsEnabled() then
			Button:GetFontString():SetTextColor(1, 1, 1)
		else
			Button:GetFontString():SetTextColor(.5, .5, .5)
		end
	end

	Button:HookScript('OnEnter', function(s) s:SetBackdropBorderColor(unpack(AS.Color)) end)
	Button:HookScript('OnLeave', function(s) s:SetBackdropBorderColor(unpack(AS.BorderColor)) end)

	--if Button.Flash then
	--	Button.Flash:SetColorTexture(0, 0, 0, 0)
	--	AS:CreateBackdrop(Button.Flash)
	--	Button.Flash.Backdrop:SetOutside(Button)
	--	Button.Flash.Backdrop:SetBackdropBorderColor(1, 0, 0, 1)
	--	Button.Flash.Backdrop:SetBackdropColor(0, 0, 0, 0)
	--	Button.Flash.Backdrop:Hide()
	--end
end

function AS:SkinCheckBox(CheckBox)
	if CheckBox.isSkinned then return end
	AS:SkinBackdropFrame(CheckBox, AS:CheckOption('ElvUIStyle', 'ElvUI') and 'Default' or nil)

	AS:SetInside(CheckBox.Backdrop, CheckBox, 4, 4)

	CheckBox:SetCheckedTexture('Interface\\Buttons\\UI-CheckBox-Check')
	CheckBox:SetDisabledCheckedTexture('Interface\\Buttons\\UI-CheckBox-Check-Disabled')

	CheckBox:HookScript('OnDisable', function(s)
		if not s.SetDisabledTexture then return end

		if s:GetChecked() then
			s:SetDisabledTexture('Interface\\Buttons\\UI-CheckBox-Check-Disabled')
		else
			s:SetDisabledTexture('')
		end
	end)

	hooksecurefunc(CheckBox, 'SetNormalTexture', function(f, t) if t ~= '' then f:SetNormalTexture('') end end)
	hooksecurefunc(CheckBox, 'SetPushedTexture', function(f, t) if t ~= '' then f:SetPushedTexture('') end end)
	hooksecurefunc(CheckBox, 'SetHighlightTexture', function(f, t) if t ~= '' then f:SetDisabledTexture('') end end)

	CheckBox.isSkinned = true
end

function AS:SkinCloseButton(Button, Reposition)
	if Button.Backdrop then return end

	AS:SkinBackdropFrame(Button)

	Button.Backdrop:SetPoint('TOPLEFT', 7, -8)
	Button.Backdrop:SetPoint('BOTTOMRIGHT', -7, 8)

	Button:SetHitRectInsets(6, 6, 7, 7)

	Button:HookScript('OnEnter', function(s)
		s:GetNormalTexture():SetVertexColor(1, .2, .2)
		if AS:CheckOption('ElvUIStyle', 'ElvUI') then
			s.Backdrop:SetBackdropBorderColor(unpack(AS.Color))
		else
			s.Backdrop:SetBackdropBorderColor(1, .2, .2)
		end
	end)

	Button:HookScript('OnLeave', function(s)
		s:GetNormalTexture():SetVertexColor(1, 1, 1)
		s.Backdrop:SetBackdropBorderColor(unpack(AS.BorderColor))
	end)

	local Mask = Button:CreateMaskTexture()
	Mask:SetTexture([[Interface\AddOns\AddOnSkins\Media\Textures\Close]], 'CLAMPTOBLACKADDITIVE', 'CLAMPTOBLACKADDITIVE')
	Mask:SetSize(10, 10)
	Mask:SetPoint('CENTER')

	Button.Mask = Mask

	Button:SetNormalTexture(AS.NormTex)
	Button:SetPushedTexture(AS.NormTex)

	local Normal, Pushed = Button:GetNormalTexture(), Button:GetPushedTexture()

	AS:SetInside(Normal, Button.Backdrop)
	Normal:SetVertexColor(1, 1, 1)
	Normal:AddMaskTexture(Mask)

	AS:SetInside(Pushed, Button.Backdrop)
	Pushed:SetVertexColor(1, .2, .2)
	Pushed:AddMaskTexture(Mask)

	if Reposition then
		Button:SetPoint('TOPRIGHT', Reposition, 'TOPRIGHT', 2, 2)
	end
end

function AS:SkinDropDownBox(Frame, Width, Pos)
	if Frame.Backdrop then return end

	local FrameName = Frame.GetName and Frame:GetName()
	local Button = Frame.Button or FrameName and (_G[FrameName..'Button'] or _G[FrameName..'_Button'])
	local Text = FrameName and _G[FrameName..'Text'] or Frame.Text
	local Icon = Frame.Icon

	if not Width then
		Width = 155
	end

	AS:StripTextures(Frame)
	Frame:SetWidth(Width)

	AS:CreateBackdrop(Frame, AS:CheckOption('ElvUIStyle', 'ElvUI') and 'Default' or nil)
	Frame.Backdrop:SetPoint('TOPLEFT', 20, -2)
	Frame.Backdrop:SetPoint('BOTTOMRIGHT', Button, 'BOTTOMRIGHT', 2, -2)

	Button:ClearAllPoints()

	if Pos then
		Button:SetPoint('TOPRIGHT', Frame.Right, -20, -21)
	else
		Button:SetPoint('RIGHT', Frame, 'RIGHT', -10, 0)
	end

	Button.SetPoint = AS.noop
	AS:SkinArrowButton(Button, 'DOWN')

	if Text then
		Text:ClearAllPoints()
		Text:SetPoint('RIGHT', Button, 'LEFT', -2, 0)
	end

	if Icon then
		Icon:SetPoint('LEFT', 23, 0)
	end
end

function AS:SkinEditBox(EditBox, Width, Height)
	if EditBox.Backdrop then return end

	local EditBoxName = EditBox.GetName and EditBox:GetName()

	for objectName, objectType in pairs(EditBox) do
		for _, Region in pairs(AS.Blizzard.Regions) do
			if type(objectName) == 'string' and (type(objectType) == 'string' or type(objectType) == 'table') and strfind(objectName, Region) then
				local obj = EditBoxName and _G[EditBoxName..Region] or EditBox[Region]
				if obj then
					obj:SetAlpha(0)
				end
			end
		end
	end

	AS:CreateBackdrop(EditBox, AS:CheckOption('ElvUIStyle', 'ElvUI') and 'Default' or nil)
	EditBox.Backdrop:SetFrameLevel(EditBox:GetFrameLevel())

	if EditBox.GetTextInsets and EditBox.SetTextInsets then
		local Left, Right, Top, Bottom = EditBox:GetTextInsets()
		if (Left == 0 and Right == 0 and Top == 0 and Bottom == 0) then
			EditBox:SetTextInsets(3, 3, 0, 0)
		end
	end

	if Width then EditBox:SetWidth(Width) end
	if Height then EditBox:SetHeight(Height) end

	if EditBoxName and (EditBoxName:find('Silver') or EditBoxName:find('Copper')) then
		EditBox.Backdrop:SetPoint('BOTTOMRIGHT', -12, -2)
	end
end

function AS:SkinIconButton(Button)
	if Button.isSkinned then return end

	local ButtonName = Button.GetName and Button:GetName()
	local Icon, Texture = Button.icon or Button.Icon or ButtonName and (_G[ButtonName..'Icon'] or _G[ButtonName..'IconTexture'])

	if Icon then
		Texture = Icon:GetTexture()
		AS:SkinButton(Button, true)
		Icon:SetTexture(Texture)
		AS:SkinTexture(Icon)
		AS:SetInside(Icon, Button)
		Button.isSkinned = true
	end
end

function AS:SkinMaxMinFrame(frame)
	AS:StripTextures(frame, true)

	for Name, Direction in pairs({ MaximizeButton = 'up', MinimizeButton = 'down' }) do
		local Button = frame[Name]

		if Button then
			Button:SetSize(16, 16)
			Button:ClearAllPoints()
			Button:SetPoint('CENTER')
			Button:SetHitRectInsets(1, 1, 1, 1)

			AS:SkinButton(Button)

			Button:SetNormalTexture([[Interface\AddOns\AddOnSkins\Media\Textures\Arrow]])
			Button:GetNormalTexture():SetRotation(AS.ArrowRotation[Direction])
			AS:SetInside(Button:GetNormalTexture(), Button, 2, 2)

			Button:SetPushedTexture([[Interface\AddOns\AddOnSkins\Media\Textures\Arrow]])
			Button:GetPushedTexture():SetRotation(AS.ArrowRotation[Direction])
			AS:SetInside(Button:GetPushedTexture())

			Button:HookScript('OnEnter', function(s)
				s:SetBackdropBorderColor(unpack(AS.Color))
				s:GetNormalTexture():SetVertexColor(unpack(AS.Color))
			end)

			Button:HookScript('OnLeave', function(s)
				s:SetBackdropBorderColor(unpack(AS.BorderColor))
				s:GetNormalTexture():SetVertexColor(1, 1, 1)
			end)
		end
	end
end

function AS:SkinRadioButton(Button)
	if Button.isSkinned then return end

	local InsideMask = Button:CreateMaskTexture()
	InsideMask:SetTexture([[Interface\Minimap\UI-Minimap-Background]], 'CLAMPTOBLACKADDITIVE', 'CLAMPTOBLACKADDITIVE')
	InsideMask:SetSize(10, 10)
	InsideMask:SetPoint('CENTER')

	Button.InsideMask = InsideMask

	local OutsideMask = Button:CreateMaskTexture()
	OutsideMask:SetTexture([[Interface\Minimap\UI-Minimap-Background]], 'CLAMPTOBLACKADDITIVE', 'CLAMPTOBLACKADDITIVE')
	OutsideMask:SetSize(13, 13)
	OutsideMask:SetPoint('CENTER')

	Button.OutsideMask = OutsideMask

	Button:SetCheckedTexture(AS.NormTex)
	Button:SetNormalTexture(AS.NormTex)
	Button:SetHighlightTexture(AS.NormTex)
	Button:SetDisabledTexture(AS.NormTex)

	local Check, Highlight, Normal, Disabled = Button:GetCheckedTexture(), Button:GetHighlightTexture(), Button:GetNormalTexture(), Button:GetDisabledTexture()

	Check:SetVertexColor(unpack(AS.Color))
	Check:SetTexCoord(0, 1, 0, 1)
	AS:SetInside(Check)
	Check:AddMaskTexture(InsideMask)

	Highlight:SetTexCoord(0, 1, 0, 1)
	Highlight:SetVertexColor(1, 1, 1)
	Highlight:AddMaskTexture(InsideMask)

	AS:SetOutside(Normal)
	Normal:SetTexCoord(0, 1, 0, 1)
	Normal:SetVertexColor(unpack(AS.BorderColor))
	Normal:AddMaskTexture(OutsideMask)

	Disabled:SetVertexColor(.3, .3, .3)
	Disabled:AddMaskTexture(OutsideMask)

	hooksecurefunc(Button, 'SetNormalTexture', function(f, t) if t ~= '' then f:SetNormalTexture('') end end)
	hooksecurefunc(Button, 'SetPushedTexture', function(f, t) if t ~= '' then f:SetPushedTexture('') end end)
	hooksecurefunc(Button, 'SetHighlightTexture', function(f, t) if t ~= '' then f:SetHighlightTexture('') end end)
	hooksecurefunc(Button, 'SetDisabledTexture', function(f, t) if t ~= '' then f:SetDisabledTexture('') end end)

	Button.isSkinned = true
end

local function GrabScrollBarElement(frame, element)
	local FrameName = frame:GetName() or frame:GetDebugName()
	return frame[element] or FrameName and (_G[FrameName..element] or strfind(FrameName, element)) or nil
end

function AS:SkinScrollBar(Frame)
	if Frame.Backdrop then return end
	local Parent = Frame:GetParent()

	local ScrollUpButton = GrabScrollBarElement(Frame, 'ScrollUpButton') or GrabScrollBarElement(Frame, 'UpButton') or GrabScrollBarElement(Frame, 'ScrollUp') or GrabScrollBarElement(Parent, 'scrollUp')
	local ScrollDownButton = GrabScrollBarElement(Frame, 'ScrollDownButton') or GrabScrollBarElement(Frame, 'DownButton') or GrabScrollBarElement(Frame, 'ScrollDown') or GrabScrollBarElement(Parent, 'scrollDown')
	local Thumb = GrabScrollBarElement(Frame, 'ThumbTexture') or GrabScrollBarElement(Frame, 'thumbTexture') or Frame.GetThumbTexture and Frame:GetThumbTexture()

	AS:SkinBackdropFrame(Frame)
	Frame.Backdrop:SetPoint('TOPLEFT', ScrollUpButton or Frame, ScrollUpButton and 'BOTTOMLEFT' or 'TOPLEFT', 0, -1)
	Frame.Backdrop:SetPoint('BOTTOMRIGHT', ScrollDownButton or Frame, ScrollUpButton and 'TOPRIGHT' or 'BOTTOMRIGHT', 0, 1)
	Frame.Backdrop:SetFrameLevel(Frame.Backdrop:GetFrameLevel() + 1)

	for _, Button in pairs({ ScrollUpButton, ScrollDownButton }) do
		if Button then
			AS:SkinArrowButton(Button, Button == ScrollUpButton and 'up' or 'down')
		end
	end

	if Thumb then
		Thumb:SetTexture('')
		AS:CreateBackdrop(Thumb)
		Thumb.Backdrop:SetPoint('TOPLEFT', Thumb, 'TOPLEFT', 2, -4)
		Thumb.Backdrop:SetPoint('BOTTOMRIGHT', Thumb, 'BOTTOMRIGHT', -2, 4)
		Thumb.Backdrop:SetFrameLevel(Parent:GetFrameLevel() + 2)
		Frame:HookScript('OnEnter', function(s) if s.Thumb:IsMouseOver() then s.Thumb.Backdrop:SetBackdropBorderColor(unpack(AS.Color)) end end)
		Frame:HookScript('OnLeave', function(s) s.Thumb.Backdrop:SetBackdropBorderColor(unpack(AS.BorderColor)) end)
		Thumb.Backdrop:EnableMouse(false)

		Frame.Thumb = Thumb

		if AS:CheckAddOn('ElvUI') then
			Thumb.Backdrop:SetBackdropColor(0.6, 0.6, 0.6)
		end
	end
end

-- WoWTrimScrollBar (from the amazing Simpy aka Shrimpy)
local function ReskinScrollBarArrow(frame, direction)
	AS:SkinArrowButton(frame, direction)
	frame.Overlay:SetAlpha(0)
	frame.Texture:Hide()
end

function AS:SkinTrimScrollBar(frame)
	frame.Background:Hide()
	frame:StripTextures()

	local track = frame.Track
	track:SetTemplate('Transparent')
	track:ClearAllPoints()
	track:Point('TOPLEFT', 4, -21)
	track:Point('BOTTOMRIGHT', -3, 21)

	local thumb = track.Thumb
	thumb.Middle:Hide()
	thumb.Begin:Hide()
	thumb.End:Hide()
	thumb:SetTemplate(nil, true, true)
	thumb:SetBackdropColor(unpack(AS.Color))
	ReskinScrollBarArrow(frame.Back, 'up')
	ReskinScrollBarArrow(frame.Forward, 'down')
end

function AS:SkinTab(Tab)
	if Tab.Backdrop then return end

	AS:StripTextures(Tab)

	if Tab.GetHighlightTexture and Tab:GetHighlightTexture() then
		Tab:GetHighlightTexture():SetTexture()
	end

	AS:CreateBackdrop(Tab, AS:CheckOption('ElvUIStyle', 'ElvUI') and 'Default' or nil)

	if Tab.GetFontString and Tab:GetFontString() ~= nil then
		Tab:HookScript('OnEnable', function(s) s:GetFontString():SetTextColor(1, 1, 1) end)
		Tab:HookScript('OnDisable', function(s) s:GetFontString():SetTextColor(.5, .5, .5) end)

		if Tab:IsEnabled() then
			Tab:GetFontString():SetTextColor(1, 1, 1)
		else
			Tab:GetFontString():SetTextColor(.5, .5, .5)
		end
	end

	Tab:HookScript('OnEnter', function(s) s.Backdrop:SetBackdropBorderColor(unpack(AS.Color)) end)
	Tab:HookScript('OnLeave', function(s) s.Backdrop:SetBackdropBorderColor(unpack(AS.BorderColor)) end)

	if AS:CheckAddOn('ElvUI') or AS:CheckOption('ElvUIStyle', 'ElvUI') then
		if Tab.backdrop then -- Check if ElvUI already provides the backdrop. Otherwise we have two backdrops (e.g. Auctionhouse)
			Tab.Backdrop:Hide()
		end
	end

	Tab.Backdrop:SetPoint('TOPLEFT', 10, AS:AdjustForTheme(-1))
	Tab.Backdrop:SetPoint('BOTTOMRIGHT', -10, 3)
end

function AS:SkinSlideBar(Frame, MoveText)
	AS:SkinBackdropFrame(Frame, AS:CheckOption('ElvUIStyle', 'ElvUI') and 'Default' or nil)
	Frame.Backdrop:SetAllPoints()
	Frame.Backdrop:SetFrameLevel(Frame:GetFrameLevel())

	if Frame.SetBackdrop then
		hooksecurefunc(Frame, 'SetBackdrop', function(s, backdrop) if backdrop ~= nil then s:SetBackdrop(nil) end end)
	end

	if MoveText then
		for i = 1, Frame:GetNumRegions() do
			local Region = select(i, Frame:GetRegions())
			if Region:IsObjectType('FontString') then
				local a, b, c, d, e = Region:GetPoint()
				if a == 'BOTTOM' then e = e + 4 end
				if a == 'LEFT' then d = d + 3 e = e - 1 end
				if a == 'RIGHT' then d = d - 3 end
				if a == 'TOP' then e = e - 3 end
				if a == 'TOPLEFT' then d = d + 5 if e > -3 then e = e - 6 end end
				if a == 'TOPRIGHT' then d = d - 3 e = e - 6 end
				Region:SetPoint(a, b, c, d, e)
			end
		end
	end

	Frame.ThumbBG = CreateFrame('Frame', nil, Frame)
	Frame.ThumbBG:SetPoint('TOPLEFT', Frame:GetThumbTexture(), 'TOPLEFT', 2, -2)
	Frame.ThumbBG:SetPoint('BOTTOMRIGHT', Frame:GetThumbTexture(), 'BOTTOMRIGHT', -2, 2)
	AS:SetTemplate(Frame.ThumbBG, 'Default')

	local Orientation = Frame:GetOrientation()
	if Orientation == 'VERTICAL' then
		Frame:GetThumbTexture():SetSize(Frame:GetWidth(), Frame:GetWidth() + 4)
	else
		Frame:GetThumbTexture():SetSize(Frame:GetHeight() + 4, Frame:GetHeight())
	end
end

function AS:StyleButton(Button)
	if Button.HasStyle then return end

	if Button.SetHighlightTexture then
		Button:SetHighlightTexture(AS.Blank)
		Button:GetHighlightTexture():SetVertexColor(1, 1, 1, .2)
		AS:SetInside(Button:GetHighlightTexture())
		hooksecurefunc(Button, 'SetHighlightTexture', function(_, t)
			if t ~= AS.Blank then
				Button:SetHighlightTexture(AS.Blank)
				Button:GetHighlightTexture():SetVertexColor(1, 1, 1, .2)
				AS:SetInside(Button:GetHighlightTexture())
			end
		end)
	end

	if Button.SetPushedTexture then
		Button:SetPushedTexture(AS.Blank)
		Button:GetPushedTexture():SetVertexColor(.9, .8, .1, .5)
		AS:SetInside(Button:GetPushedTexture())
		hooksecurefunc(Button, 'SetPushedTexture', function(_, t)
			if t ~= AS.Blank then
				Button:SetPushedTexture(AS.Blank)
				Button:GetPushedTexture():SetVertexColor(.9, .8, .1, .5)
				AS:SetInside(Button:GetPushedTexture())
			end
		end)
	end

	if Button.GetCheckedTexture then
		Button:SetCheckedTexture(AS.Blank)
		Button:GetCheckedTexture():SetVertexColor(0, 1, 0, .5)
		AS:SetInside(Button:GetCheckedTexture())
		hooksecurefunc(Button, 'SetCheckedTexture', function(_, t)
			if t ~= AS.Blank then
				Button:SetCheckedTexture(AS.Blank)
				Button:GetCheckedTexture():SetVertexColor(0, 1, 0, .5)
				AS:SetInside(Button:GetCheckedTexture())
			end
		end)
	end

	local Cooldown = Button:GetName() and _G[Button:GetName()..'Cooldown'] or Button.Cooldown or Button.cooldown or nil

	if Cooldown then
		AS:SetInside(Cooldown)
		if Cooldown.SetSwipeColor then
			Cooldown:SetSwipeColor(0, 0, 0, 1)
		end
	end

	Button.HasStyle = true
end

-- Helpers

function AS:SkinFrame(frame, template, override, kill)
	local name = frame and frame.GetName and frame:GetName()
	local insetFrame = name and _G[name..'Inset'] or frame.Inset
	local closeButton = name and _G[name..'CloseButton'] or frame.CloseButton

	if not override then
		AS:StripTextures(frame, kill)
	end

	AS:SetTemplate(frame, template)

	if insetFrame then
		AS:SkinFrame(insetFrame)
	end

	if closeButton then
		AS:SkinCloseButton(closeButton)
	end
end

function AS:SkinBackdropFrame(frame, template, override, kill)
	local name = frame and frame.GetName and frame:GetName()
	local insetFrame = name and _G[name..'Inset'] or frame.Inset
	local closeButton = name and _G[name..'CloseButton'] or frame.CloseButton

	if not override then
		AS:StripTextures(frame, kill)
	end

	AS:CreateBackdrop(frame, template)
	AS:SetOutside(frame.Backdrop)

	if insetFrame then
		AS:SkinFrame(insetFrame)
	end

	if closeButton then
		AS:SkinCloseButton(closeButton)
	end
end

function AS:SkinStatusBar(Frame, Color)
	Frame:SetFrameLevel(Frame:GetFrameLevel() + 1)
	AS:SkinBackdropFrame(Frame)
	Frame:SetStatusBarTexture(AS.NormTex)
	Frame:SetStatusBarColor(unpack(Color or AS:CheckOption('StatusBarColor')))
	if AS:CheckOption('ElvUIStyle', 'ElvUI') then
		_G.ElvUI[1]:RegisterStatusBar(Frame)
	end
end

function AS:SkinTooltip(tooltip, scale)
	for _, Region in pairs(AS.Blizzard.Tooltip) do
		for objectName, objectType in pairs(tooltip) do
			if type(objectName) == 'string' and (type(objectType) == 'string' or type(objectType) == 'table') and strfind(objectName, Region) then
				local obj = tooltip[Region]
				if obj then
					obj:SetTexture()
				end
			end
		end
	end

	AS:SkinFrame(tooltip)

	if scale then
		tooltip:SetScale(AS.UIScale)
	end
end

function AS:SkinTexture(icon, backdrop)
	if AS:CheckOption('CropIcons') then
		icon:SetTexCoord(unpack(AS.TexCoords))
	end

	if icon:GetDrawLayer() ~= 'ARTWORK' then
		icon:SetDrawLayer('ARTWORK')
	end

	icon:SetSnapToPixelGrid(false)
	icon:SetTexelSnappingBias(0)

	if backdrop then
		AS:CreateBackdrop(icon)
	end
end

function AS:AdjustForTheme(number, offset)
	local Theme = AS:CheckOption('Theme')
	local isNegative = number < 0

	number = abs(number)

	if Theme == 'TwoPixel' then
		number = number + (offset or 1)
	elseif Theme == 'ThickBorder' then
		number = number + (offset or 2)
	end

	return isNegative and -number or number
end

local function EnumObjectsHelper(enumFuncs, yieldFunc, iobj)
	local depth = #enumFuncs
	local i = 1
	local obj
	repeat
		if (iobj) then
			obj = enumFuncs[1](iobj, i)
		else
			obj = enumFuncs[1](i)
		end
		if (obj) then
			if (depth == 1) then
				yieldFunc(obj)
			else
				local innerEnumFuncs = CopyTable(enumFuncs)
				tremove(innerEnumFuncs, 1)
				EnumObjectsHelper(innerEnumFuncs, yieldFunc, obj)
			end
		end
		i = i + 1
	until not obj
end

function AS:EnumObjects(enumFuncs, yieldFunc)
	if (type(enumFuncs) == 'function') then
		enumFuncs = {enumFuncs}
	end

	EnumObjectsHelper(enumFuncs, yieldFunc)
end

function AS:FindChildFrameByPoint(parent, objType, point1, relativeTo, point2, x, y)
	local childPoint1, childParent, childPoint2, childX, childY
	local childs = {parent:GetChildren()}

	x = AS:Round(x)
	y = AS:Round(y)

	for _, child in pairs(childs) do
		if not child:GetName() then
			if not objType or (objType and child:IsObjectType(objType)) then
				childPoint1, childParent, childPoint2, childX, childY = child:GetPoint()
				childX = childX and AS:Round(childX) or 0
				childY = childY and AS:Round(childY) or 0

				if childPoint1 == point1
				and childParent == relativeTo
				and (not point2 or (childPoint2 == point2))
				and x == childX
				and y == childY
				then
					return child
				end
			end
		end
	end
end

function AS:FindChildFrameBySize(parent, objType, width, height)
	local childs = {parent:GetChildren()}

	width = AS:Round(width)
	height = AS:Round(height)

	for _, child in pairs(childs) do
		if not child:GetName() then
			if not objType or (objType and child:IsObjectType(objType)) then
				if AS:Round(child:GetWidth()) == width and AS:Round(child:GetHeight()) == height then
					return child
				end
			end
		end
	end
end

function AS:FindFrameBySizeChild(childTypes, width, height)
	local obj = EnumerateFrames()

	width = AS:Round(width)
	height = AS:Round(height)

	while obj do
		if obj.IsObjectType and obj:IsObjectType('Frame') then
			if not (obj:GetName() and obj:GetParent()) then
				if AS:Round(obj:GetWidth()) == width and AS:Round(obj:GetHeight()) == height then
					local childs = {}
					for _, child in pairs({obj:GetChildren()}) do
						childs[#childs + 1] = child:GetObjectType()
					end

					local matched = 0
					for _, cType in pairs(childTypes) do
						for _, type in pairs(childs) do
							if cType == type then
								matched = matched + 1
							end
						end
					end

					if matched == #childTypes then
						return obj
					end
				end
			end
		end

		obj = EnumerateFrames(obj)
	end
end

function AS:FindFrameByPoint(point1, relativeTo, point2, x, y, multipleFrames)
	if not relativeTo then return end

	local frame
	if multipleFrames then
		frame = {}
	end

	local childPoint1, childParent, childPoint2, childX, childY
	local obj = EnumerateFrames()

	x = AS:Round(x)
	y = AS:Round(y)

	while obj do
		if obj.IsObjectType and obj:IsObjectType('Frame') then
			if not (obj:GetName() and obj:GetParent()) then
				childPoint1, childParent, childPoint2, childX, childY = obj:GetPoint()
				childX = childX and AS:Round(childX) or 0
				childY = childY and AS:Round(childY) or 0

				if childPoint1 == point1
				and childParent == relativeTo
				and (not point2 or (childPoint2 == point2))
				and x == childX
				and y == childY
				then
					if multipleFrames then
						frame[#frame + 1] = obj
					else
						return obj
					end
				end
			end
		end

		obj = EnumerateFrames(obj)
	end

	return frame
end

function AS:SkinStatusBarWidget(widgetFrame)
	local bar = widgetFrame.Bar;
	if not bar then return end

	if bar.BorderLeft then bar.BorderLeft:Hide() end
	if bar.BorderRight then bar.BorderRight:Hide() end
	if bar.BorderCenter then bar.BorderCenter:Hide() end
	if bar.BGLeft then bar.BGLeft:Hide() end
	if bar.BGRight then bar.BGRight:Hide() end
	if bar.BGCenter then bar.BGCenter:Hide() end

	if not bar.Backdrop then
		AS:CreateBackdrop(bar)
	end

	bar:SetStatusBarAtlas('')
	bar.SetStatusBarAtlas = AS.Noop

	bar:SetStatusBarTexture(AS.NormTex)
	bar:SetStatusBarColor(0, .8, 0)

	if bar.Spark then
		bar.Spark:SetAlpha(0)
	end
end

function AS:SkinTextWithStateWidget(widgetFrame)
	local text = widgetFrame.Text
	if text then
		text:SetTextColor(1, 1, 1)
	end
end

local W = Enum.UIWidgetVisualizationType;
AS.WidgetSkinningFuncs = {
	[W.StatusBar] = 'SkinStatusBarWidget',
	[W.TextWithState] = 'SkinTextWithStateWidget',
}

function AS:SkinWidgetContainer(widgetContainer)
	for _, child in ipairs({widgetContainer:GetChildren()}) do
		if AS.WidgetSkinningFuncs[child.widgetType] then
			AS[AS.WidgetSkinningFuncs[child.widgetType]](AS, child)
		end
	end
end
