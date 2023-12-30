local _, xVermin = ...

for i, v in pairs(
	{
		LootFrameBg,
		LootFrameRightBorder,
		LootFrameLeftBorder,
		LootFrameTopBorder,
		LootFrameBottomBorder,
		LootFrameTopRightCorner,
		LootFrameTopLeftCorner,
		LootFrameBotRightCorner,
		LootFrameBotLeftCorner,
		LootFrameInsetInsetTopRightCorner,
		LootFrameInsetInsetTopLeftCorner,
		LootFrameInsetInsetBotRightCorner,
		LootFrameInsetInsetBotLeftCorner,
		LootFrameInsetInsetRightBorder,
		LootFrameInsetInsetLeftBorder,
		LootFrameInsetInsetTopBorder,
		LootFrameInsetInsetBottomBorder,
		LootFramePortraitFrame
	}
) do
	v:SetVertexColor(.35, .35, .35)
end

for i, v in pairs(
	{
		LootFrameInsetBg,
		LootFrameTitleBg,
		PlayerFrameTexture,
		PlayerFrameAlternateManaBarBorder,
		PlayerFrameAlternateManaBarLeftBorder,
		PlayerFrameAlternateManaBarRightBorder,
		AlternatePowerBarBorder,
		AlternatePowerBarLeftBorder,
		AlternatePowerBarRightBorder,
		PetFrameTexture,
		PartyMemberFrame1Texture,
		PartyMemberFrame2Texture,
		PartyMemberFrame3Texture,
		PartyMemberFrame4Texture,
		PartyMemberFrame1PetFrameTexture,
		PartyMemberFrame2PetFrameTexture,
		PartyMemberFrame3PetFrameTexture,
		PartyMemberFrame4PetFrameTexture,
		TargetFrameToTTextureFrameTexture,
		CastingBarFrame.Border,
		MirrorTimer1Border,
		MirrorTimer2Border,
		TargetFrameSpellBar.Border
	}
) do
	v:SetVertexColor(.05, .05, .05)
end

for i, v in pairs(
	{
		MainMenuBarLeftEndCap,
		MainMenuBarRightEndCap
	}
) do
	v:SetVertexColor(.35, .35, .35)
end
