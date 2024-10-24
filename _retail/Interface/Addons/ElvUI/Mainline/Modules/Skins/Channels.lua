local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule('Skins')

local _G = _G
local hooksecurefunc = hooksecurefunc

function S:Blizzard_Channels()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.channels) then return end

	local ChannelFrame = _G.ChannelFrame
	local CreateChannelPopup = _G.CreateChannelPopup

	S:HandlePortraitFrame(ChannelFrame)
	CreateChannelPopup:StripTextures()
	CreateChannelPopup:SetTemplate('Transparent')

	S:HandleButton(ChannelFrame.SettingsButton) -- using -4, 4
	S:HandleButton(ChannelFrame.NewButton)
	ChannelFrame.NewButton:ClearAllPoints()
	ChannelFrame.NewButton:Point('BOTTOMLEFT', ChannelFrame, 4, 4) -- make it match settings button

	S:HandleTrimScrollBar(ChannelFrame.ChannelRoster.ScrollBar)

	S:HandleScrollBar(ChannelFrame.ChannelList.ScrollBar)
	ChannelFrame.ChannelList.ScrollBar:Point('BOTTOMLEFT', ChannelFrame.ChannelList, 'BOTTOMRIGHT', 0, 15)

	S:HandleCloseButton(CreateChannelPopup.CloseButton)
	S:HandleButton(CreateChannelPopup.OKButton)
	S:HandleButton(CreateChannelPopup.CancelButton)

	S:HandleEditBox(CreateChannelPopup.Name)
	S:HandleEditBox(CreateChannelPopup.Password)

	_G.VoiceChatPromptActivateChannel:StripTextures()
	_G.VoiceChatPromptActivateChannel:SetTemplate('Transparent')
	S:HandleButton(_G.VoiceChatPromptActivateChannel.AcceptButton)
	S:HandleCloseButton(_G.VoiceChatPromptActivateChannel.CloseButton)

	-- Hide the Channel Header Textures
	hooksecurefunc(_G.ChannelButtonHeaderMixin, 'Update', function(s)
		s:SetTemplate('Transparent')
		s.NormalTexture:SetTexture()
	end)
end

S:AddCallbackForAddon('Blizzard_Channels')
