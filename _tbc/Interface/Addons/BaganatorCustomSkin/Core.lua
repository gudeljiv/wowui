-- BaganatorCustomSkin - External skin addon for Baganator
-- This addon registers a custom skin with Baganator after it loads

local addonName, addonTable = ...

-- Create frame to listen for Baganator load event
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")

local function GetBaganatorTable()
	-- Since Baganator uses select(2, ...) pattern, we need to access it differently
	-- The best way is through Baganator's global API or saved variables

	-- Check various ways Baganator might expose its table
	if Baganator then
		return Baganator
	elseif BAGANATOR_DATA then
		-- Might be exposed through saved variables namespace
		return BAGANATOR_DATA
	elseif _G["Baganator"] then
		return _G["Baganator"]
	end

	return nil
end

frame:SetScript("OnEvent", function(self, event)
	if C_AddOns.IsAddOnLoaded("Baganator") then
		print("LOADED:")

		self:UnregisterAllEvents()

		-- print(loadedAddonName)
		-- if loadedAddonName ~= "Baganator" then
		-- 	return
		-- end
		-- print(loadedAddonName)

		-- Give Baganator time to initialize
		C_Timer.After(1, function()
			local Baganator = GetBaganatorTable()
			for k, v in pairs(Baganator) do
				print(k, v)
			end

			if not Baganator or not Baganator.Skins or not Baganator.Skins.RegisterSkin then
				print("|cFFFF4444BaganatorCustomSkin Error:|r Could not find Baganator API")
				print("|cFFFFAA00This might be due to Baganator version incompatibility.|r")
				return
			end

			-- Now register our custom skin
			RegisterSkin(Baganator)
		end)
	end
end)

function RegisterSkin(Baganator)
	-- Color manipulation functions
	local function ToHSL(r, g, b)
		local M = math.max(r, g, b)
		local m = math.min(r, g, b)
		local c = M - m

		local h_dash
		if c == 0 then
			h_dash = 0
		elseif M == r then
			h_dash = ((g - b) / c) % 6
		elseif M == g then
			h_dash = (b - r) / c + 2
		elseif M == b then
			h_dash = (r - g) / c + 4
		end
		local h = h_dash * 60

		local l = 1 / 2 * (M + m)

		local s
		if l == 1 or l == 0 then
			s = 0
		else
			s = c / (1 - math.abs(2 * l - 1))
		end

		return h, s, l
	end

	local function FromHSL(h, s, l)
		local function f(n)
			local k = (n + h / 30) % 12
			local a = s * math.min(l, 1 - l)
			return l - a * math.max(-1, math.min(k - 3, 9 - k, 1))
		end
		return f(0), f(8), f(4)
	end

	local function Lighten(r, g, b, shift)
		local h, s, l = ToHSL(r, g, b)
		l = math.max(0, math.min(1, l + shift))
		return FromHSL(h, s, l)
	end

	local function ConvertTags(tags)
		local res = {}
		for _, tag in ipairs(tags) do
			res[tag] = true
		end
		return res
	end

	-- Backdrop configurations
	local backdropInfo = {
		bgFile = "Interface/AddOns/Baganator/Assets/Skins/dark-backgroundfile",
		edgeFile = "Interface/AddOns/Baganator/Assets/Skins/dark-edgefile",
		tile = true,
		tileEdge = true,
		tileSize = 32,
		edgeSize = 6,
	}

	local frameBackdropInfo = {
		bgFile = "Interface/AddOns/Baganator/Assets/Skins/dark-backgroundfile",
		edgeFile = "Interface/AddOns/Baganator/Assets/Skins/dark-edgefile",
		tile = true,
		tileEdge = true,
		tileSize = 32,
		edgeSize = 9,
	}

	local color = CreateColor(0.05, 0.05, 0.05) -- black

	local possibleVisuals = {
		"BotLeftCorner",
		"BotRightCorner",
		"BottomBorder",
		"LeftBorder",
		"RightBorder",
		"TopRightCorner",
		"TopLeftCorner",
		"TopBorder",
		"TitleBg",
		"Bg",
		"TopTileStreaks",
	}

	local function RemoveFrameTextures(frame)
		for _, key in ipairs(possibleVisuals) do
			if frame[key] then
				frame[key]:Hide()
				frame[key]:SetTexture()
				frame[key] = nil
			end
		end
		if frame.NineSlice then
			for _, region in ipairs({ frame.NineSlice:GetRegions() }) do
				region:Hide()
			end
		end
	end

	local texCoords = { 0.08, 0.92, 0.08, 0.92 }

	local function ItemButtonQualityHook(frame, quality)
		if frame.bgrSimpleHooked then
			frame:CreateBeautyBorder(8)

			local c = ITEM_QUALITY_COLORS[quality]

			if frame.BGRUpdateQuests then
				local questTexture = frame:GetName() and _G[frame:GetName() .. "IconQuestTexture"]
					or frame.IconQuestTexture
				hooksecurefunc(frame, "BGRUpdateQuests", function()
					if questTexture then
						local textureID = questTexture:GetTexture()
						if textureID then
							questTexture:Hide()
							frame:SetBeautyBorderTexture("Interface\\AddOns\\xVermin\\media\\textureWhite")
							frame:SetBeautyBorderColor(1, 0.964, 0, 1)
						end
					end
				end)
			end

			if c and quality and quality > 1 then
				frame:SetBeautyBorderTexture("Interface\\AddOns\\xVermin\\media\\textureWhite")
				frame:SetBeautyBorderColor(c.r or 1, c.g or 1, c.b or 1)
			else
				frame:SetBeautyBorderTexture("Interface\\AddOns\\xVermin\\media\\textureNormal")
				frame:SetBeautyBorderColor(1, 1, 1)
			end
		end
	end

	local function ItemButtonTextureHook(frame)
		if frame.bgrSimpleHooked then
			frame.icon:SetTexCoord(unpack(texCoords))
		end
	end

	local function StyleButton(button)
		if not button.Left or not button.Right or not button.Middle then
			return
		end

		button.Left:Hide()
		button.Right:Hide()
		button.Middle:Hide()
		button:ClearHighlightTexture()

		Mixin(button, BackdropTemplateMixin)
		button:SetBackdrop(backdropInfo)
		local btnColor = CreateColor(Lighten(color.r, color.g, color.b, -0.20))
		button:SetBackdropColor(btnColor.r, btnColor.g, btnColor.b, 0.5)
		button:SetBackdropBorderColor(btnColor.r, btnColor.g, btnColor.b, 1)

		button:HookScript("OnEnter", function()
			if button:IsEnabled() then
				local r, g, b = Lighten(btnColor.r, btnColor.g, btnColor.b, 0.3)
				button:SetBackdropColor(r, g, b, 0.8)
				button:SetBackdropBorderColor(r, g, b, 1)
			end
		end)
		button:HookScript("OnMouseDown", function()
			if button:IsEnabled() then
				local r, g, b = Lighten(btnColor.r, btnColor.g, btnColor.b, 0.2)
				button:SetBackdropColor(r, g, b, 0.8)
				button:SetBackdropBorderColor(r, g, b, 1)
			end
		end)
		button:HookScript("OnMouseUp", function()
			if button:IsEnabled() and button:IsMouseOver() then
				local r, g, b = Lighten(btnColor.r, btnColor.g, btnColor.b, 0.3)
				button:SetBackdropColor(r, g, b, 0.8)
				button:SetBackdropBorderColor(r, g, b, 1)
			end
		end)
		button:HookScript("OnLeave", function()
			button:SetBackdropColor(btnColor.r, btnColor.g, btnColor.b, 0.5)
			button:SetBackdropBorderColor(btnColor.r, btnColor.g, btnColor.b, 1)
		end)
		button:HookScript("OnDisable", function()
			button:SetBackdropColor(btnColor.r, btnColor.g, btnColor.b, 0.1)
		end)
		button:HookScript("OnEnable", function()
			button:SetBackdropColor(btnColor.r, btnColor.g, btnColor.b, 0.5)
		end)
	end

	local function StyleButtonFrameBorder(frame)
		if Baganator.Config.Get("skins.custom_dark.no_frame_borders") then
			frame:SetBackdropBorderColor(1, 1, 1, 0)
		else
			local r, g, b = Lighten(color.r, color.g, color.b, 0.3)
			frame:SetBackdropBorderColor(r, g, b, 1)
		end
	end

	local showSlots = true
	local allItemButtons = {}

	local skinners = {
		ItemButton = function(frame, tags)
			frame.bgrSimpleHooked = true
			local r, g, b = Lighten(color.r, color.g, color.b, -0.2)
			if not tags.containerBag then
				table.insert(allItemButtons, frame)
				if frame.SlotBackground then
					frame.SlotBackground:SetColorTexture(r, g, b, 0.3)
					frame.SlotBackground:SetPoint("CENTER")
					frame.SlotBackground:SetSize(35, 35)
				end
			end
			if frame.SlotBackground then
				frame.SlotBackground:SetShown(showSlots)
			end
			if frame.SetItemButtonQuality then
				hooksecurefunc(frame, "SetItemButtonQuality", ItemButtonQualityHook)
			end
			if frame.SetItemButtonTexture then
				hooksecurefunc(frame, "SetItemButtonTexture", ItemButtonTextureHook)
			end
		end,
		IconButton = function(button)
			StyleButton(button)
		end,
		Button = function(button)
			StyleButton(button)
		end,
		ButtonFrame = function(frame, tags)
			RemoveFrameTextures(frame)
			Mixin(frame, BackdropTemplateMixin)
			frame:SetBackdrop(frameBackdropInfo)
			frame:SetBackdropColor(
				color.r,
				color.g,
				color.b,
				1 - Baganator.Config.Get("skins.custom_dark.view_transparency")
			)
			StyleButtonFrameBorder(frame)

			Baganator.CallbackRegistry:RegisterCallback("SettingChanged", function(_, settingName)
				if settingName == "skins.custom_dark.view_transparency" then
					frame:SetBackdropColor(
						color.r,
						color.g,
						color.b,
						1 - Baganator.Config.Get("skins.custom_dark.view_transparency")
					)
				elseif settingName == "skins.custom_dark.no_frame_borders" then
					StyleButtonFrameBorder(frame)
				end
			end, frame)

			if tags.backpack and frame.TopButtons and frame.TopButtons[1] then
				frame.TopButtons[1]:SetPoint("TOPLEFT", 1.5, -1)
			elseif tags.bank and frame.Character and frame.Character.TopButtons and frame.Character.TopButtons[1] then
				frame.Character.TopButtons[1]:SetPoint("TOPLEFT", 1.5, -1)
			elseif tags.guild and frame.ToggleTabTextButton then
				frame.ToggleTabTextButton:SetPoint("TOPLEFT", 1.5, -1)
			end
		end,
		SearchBox = function(frame) end,
		EditBox = function(frame) end,
		TabButton = function(frame) end,
		TopTabButton = function(frame) end,
		SideTabButton = function(frame) end,
		TrimScrollBar = function(frame) end,
		CheckBox = function(frame) end,
		Slider = function(frame) end,
		InsetFrame = function(frame) end,
		CornerWidget = function(frame, tags) end,
		Dropdown = function(button) end,
	}

	local function SkinFrame(details)
		local func = skinners[details.regionType]
		if func then
			func(details.region, details.tags and ConvertTags(details.tags) or {})
		end
	end

	local function SetConstants()
		Baganator.Constants.ButtonFrameOffset = 0
	end

	local function LoadSkin()
		showSlots = not Baganator.Config.Get("skins.custom_dark.empty_slot_background")
		if Baganator.API.IsMasqueApplying() or not Baganator.Config.Get("skins.custom_dark.square_icons") then
			skinners.ItemButton = function(frame, tags)
				if not tags.containerBag then
					table.insert(allItemButtons, frame)
					if frame.SlotBackground then
						frame.SlotBackground:SetShown(showSlots)
					end
				end
			end
		else
			hooksecurefunc("SetItemButtonQuality", ItemButtonQualityHook)
			hooksecurefunc("SetItemButtonTexture", ItemButtonTextureHook)
		end

		Baganator.CallbackRegistry:RegisterCallback("SettingChanged", function(_, settingName)
			if settingName == "skins.custom_dark.empty_slot_background" then
				showSlots = not Baganator.Config.Get("skins.custom_dark.empty_slot_background")
				for _, button in ipairs(allItemButtons) do
					if button.SlotBackground then
						button.SlotBackground:SetShown(showSlots)
					end
				end
			end
		end)
	end

	-- Register the skin with Baganator
	Baganator.Skins.RegisterSkin(
		"Custom Dark", -- Display name
		"custom_dark", -- Internal ID (use unique name to avoid conflicts)
		LoadSkin,
		SkinFrame,
		SetConstants,
		{
			{
				type = "slider",
				min = 0,
				max = 100,
				lowText = "0%",
				highText = "100%",
				scale = 100,
				text = "Transparency",
				valuePattern = "%d%%",
				option = "view_transparency",
				default = 0.3,
			},
			{
				type = "checkbox",
				text = "Remove Borders",
				option = "no_frame_borders",
				default = false,
			},
			{
				type = "checkbox",
				text = "Hide Icon Backgrounds",
				option = "empty_slot_background",
				default = false,
			},
			{
				type = "checkbox",
				text = "Square Icons",
				rightText = "Reload Required",
				option = "square_icons",
				default = false,
			},
		},
		false,
		true
	)

	print("|cff00ff00Baganator Custom Skin|r loaded successfully!")
end
