local Module = SUI:NewModule("Chat.Core")

function Module:OnEnable()
	local db = SUI.db.profile.chat
	if db.style == "Custom" then
		CHAT_FRAME_FADE_TIME = 0.3
		CHAT_FRAME_FADE_OUT_TIME = 1
		CHAT_TAB_HIDE_DELAY = 0.3
		CHAT_FRAME_TAB_ALERTING_MOUSEOVER_ALPHA = 1
		CHAT_FRAME_TAB_ALERTING_NOMOUSE_ALPHA = 1
		--CHAT_FRAME_TAB_SELECTED_MOUSEOVER_ALPHA = 1
		--CHAT_FRAME_TAB_SELECTED_NOMOUSE_ALPHA = 0
		--CHAT_FRAME_TAB_NORMAL_MOUSEOVER_ALPHA = 1
		--CHAT_FRAME_TAB_NORMAL_NOMOUSE_ALPHA = 0

		-- Set chat style
		local function SetChatStyle(frame)
			local id = frame:GetID()
			local chat = frame:GetName()

			_G[chat]:SetFrameLevel(5)

			-- Removes crap from the bottom of the chatbox so it can go to the bottom of the screen
			_G[chat]:SetClampedToScreen(false)

			-- Stop the chat chat from fading out
			_G[chat]:SetFading(true)

			-- Move the chat edit box
			_G[chat .. "EditBox"]:ClearAllPoints()

			if db.top then
				_G[chat .. "EditBox"]:SetPoint("BOTTOMLEFT", ChatFrame1, "TOPLEFT", -7, 25)
				_G[chat .. "EditBox"]:SetPoint("BOTTOMRIGHT", ChatFrame1, "TOPRIGHT", 10, 25)
			else
				_G[chat .. "EditBox"]:SetPoint("TOPLEFT", ChatFrame1, "BOTTOMLEFT", -7, -5)
				_G[chat .. "EditBox"]:SetPoint("TOPRIGHT", ChatFrame1, "BOTTOMRIGHT", 10, -5)
			end

			-- Hide textures
			for j = 1, #CHAT_FRAME_TEXTURES do
				if chat .. CHAT_FRAME_TEXTURES[j] ~= chat .. "Background" then
					_G[chat .. CHAT_FRAME_TEXTURES[j]]:SetTexture(nil)
				end
			end

			local function SafeHide(frame)
				if frame and frame.Hide then
					frame:Hide()
				end
			end

			local function SafeSetTexture(region)
				if region and region.SetTexture then
					region:SetTexture(nil)
				end
			end

			-- Removes Default ChatFrame Tabs texture
			local tabName = format("ChatFrame%sTab", id)
			local tab = _G[tabName]
			local function ClearTabTexture(suffix)
				local region = (tab and tab[suffix]) or _G[tabName .. suffix]
				SafeSetTexture(region)
			end

			ClearTabTexture("Left")
			ClearTabTexture("Middle")
			ClearTabTexture("Right")

			ClearTabTexture("ActiveLeft")
			ClearTabTexture("ActiveMiddle")
			ClearTabTexture("ActiveRight")

			ClearTabTexture("HighlightLeft")
			ClearTabTexture("HighlightMiddle")
			ClearTabTexture("HighlightRight")

			-- Hiding off the new chat tab selected feature
			SafeHide(_G[format("ChatFrame%sButtonFrameMinimizeButton", id)])
			SafeHide(_G[format("ChatFrame%sButtonFrame", id)])

			-- Hides off the retarded new circle around the editbox
			SafeHide(_G[format("ChatFrame%sEditBoxLeft", id)])
			SafeHide(_G[format("ChatFrame%sEditBoxMid", id)])
			SafeHide(_G[format("ChatFrame%sEditBoxRight", id)])

			SafeHide(_G[format("ChatFrame%sTabGlow", id)])

			-- Hide scroll bar
			local scrollBar = _G[format("ChatFrame%s", id)].ScrollBar
			if scrollBar then
				SafeHide(scrollBar.Back)
				SafeHide(scrollBar.Forward)
				SafeHide(scrollBar)
				SafeHide(scrollBar.Track)
				SafeHide(scrollBar.Track and scrollBar.Track.Begin)
				SafeHide(scrollBar.Track and scrollBar.Track.Middle)
				SafeHide(scrollBar.Track and scrollBar.Track.End)
				SafeHide(scrollBar.Track and scrollBar.Track.Thumb)
				SafeHide(scrollBar.Track and scrollBar.Track.Thumb.Begin)
				SafeHide(scrollBar.Track and scrollBar.Track.Thumb.Middle)
				SafeHide(scrollBar.Track and scrollBar.Track.Thumb.End)
			end

			-- Hide off editbox artwork
			local a, b, c = select(6, _G[chat .. "EditBox"]:GetRegions())
			SafeHide(a)
			SafeHide(b)
			SafeHide(c)

			-- Hide bubble tex/glow
			if _G[chat .. "Tab"].conversationIcon then
				_G[chat .. "Tab"].conversationIcon:Hide()
			end

			-- Disable alt key usage
			_G[chat .. "EditBox"]:SetAltArrowKeyMode(false)

			-- Hide editbox on login
			_G[chat .. "EditBox"]:Hide()

			-- Script to hide editbox instead of fading editbox to 0.35 alpha via IM Style
			_G[chat .. "EditBox"]:HookScript("OnEditFocusGained", function(self)
				self:Show()
			end)
			_G[chat .. "EditBox"]:HookScript("OnEditFocusLost", function(self)
				if self:GetText() == "" then
					self:Hide()
				end
			end)

			-- Hide edit box every time we click on a tab
			_G[chat .. "Tab"]:HookScript("OnClick", function()
				_G[chat .. "EditBox"]:Hide()
			end)

			frame.skinned = true
		end

		-- Setup chatframes 1 to 10 on login
		local function SetupChat()
			for i = 1, NUM_CHAT_WINDOWS do
				local frame = _G[format("ChatFrame%s", i)]
				SetChatStyle(frame)
			end
		end

		local function SetupChatPosAndFont()
			for i = 1, NUM_CHAT_WINDOWS do
				local chat = _G[format("ChatFrame%s", i)]
				local id = chat:GetID()
				local _, fontSize = FCF_GetChatWindowInfo(id)

				-- Min. size for chat font
				if fontSize < 11 then
					FCF_SetChatWindowFontSize(nil, chat, 11)
				else
					FCF_SetChatWindowFontSize(nil, chat, fontSize)
				end

				-- Font and font style for chat
				chat:SetFont(STANDARD_TEXT_FONT, fontSize, "")
			end
		end

		-- Setup temp chat (BN, WHISPER) when needed
		local function SetupTempChat()
			local frame = FCF_GetCurrentChatFrame()
			if frame.skinned then
				return
			end
			SetChatStyle(frame)
		end

		hooksecurefunc("FCF_OpenTemporaryWindow", SetupTempChat)

		--	Loot icons
		if db.looticons then
			local function AddLootIcons(_, _, message, ...)
				local function Icon(link)
					local texture = GetItemIcon(link)
					return "\124T" .. texture .. ":12:12:0:0:64:64:5:59:5:59\124t" .. link
				end

				message = message:gsub("(\124c%x+\124Hitem:.-\124h\124r)", Icon)
				return false, message, ...
			end

			ChatFrame_AddMessageEventFilter("CHAT_MSG_LOOT", AddLootIcons)
		end

		-- init
		SetupChat()
		SetupChatPosAndFont()
	end
end
