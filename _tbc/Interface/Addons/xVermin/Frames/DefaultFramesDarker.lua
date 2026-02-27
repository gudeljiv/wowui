local _, xVermin = ...

for i, v in pairs({
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
	LootFramePortraitFrame,
}) do
	v:SetVertexColor(0.35, 0.35, 0.35)
end

for i, v in pairs({
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
	FocusFrameToTTextureFrameTexture,
	PlayerCastingBarFrame.Border,
	MirrorTimer1Border,
	MirrorTimer2Border,
	TargetFrameSpellBar.Border,
}) do
	v:SetVertexColor(0.05, 0.05, 0.05)
end

for i, v in pairs({
	MainMenuBarLeftEndCap,
	MainMenuBarRightEndCap,
}) do
	v:SetVertexColor(0.35, 0.35, 0.35)
end
