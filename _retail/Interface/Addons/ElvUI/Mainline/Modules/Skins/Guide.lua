local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule('Skins')

local _G = _G

function S:Blizzard_NewPlayerExperience()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.guide) then return end

	S:HandleButton(_G.KeyboardMouseConfirmButton)
	local frame = _G.NPE_TutorialWalk_Frame
	if frame then
		frame.ContainerFrame.TURNLEFT.KeyBind:SetTextColor(1, .8, 0)
		frame.ContainerFrame.TURNRIGHT.KeyBind:SetTextColor(1, .8, 0)
		frame.ContainerFrame.MOVEFORWARD.KeyBind:SetTextColor(1, .8, 0)
		frame.ContainerFrame.MOVEBACKWARD.KeyBind:SetTextColor(1, .8, 0)
		_G.NPE_TutorialSingleKey_Frame.ContainerFrame.KeyBind.KeyBind:SetTextColor(1, .8, 0)
	end
end

function S:Blizzard_NewPlayerExperienceGuide()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.guide) then return end

	local frame = _G.GuideFrame
	S:HandlePortraitFrame(frame)

	S:HandleScrollBar(frame.ScrollFrame.ScrollBar)
	S:HandleButton(frame.ScrollFrame.ConfirmationButton)

	frame.ScrollFrame.Child.ObjectivesFrame:StripTextures()
	frame.ScrollFrame.Child.ObjectivesFrame:SetTemplate('Transparent')

	-- Texts if parchment is enabled
	-- TO DO: Add Parchment option
	frame.Title:SetTextColor(1, 1, 1)
	frame.ScrollFrame.Child.Text:SetTextColor(1, 1, 1)
end

S:AddCallbackForAddon('Blizzard_NewPlayerExperience')
S:AddCallbackForAddon('Blizzard_NewPlayerExperienceGuide')
