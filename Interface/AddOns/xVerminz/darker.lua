
for i,v in pairs({
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
 v:SetVertexColor(.35, .35, .35)
end

for i,v in pairs({
	LootFrameInsetBg,
	LootFrameTitleBg,
}) do
 v:SetVertexColor(.05, .05, .05)
end	



for i,v in pairs({
	MainMenuBarLeftEndCap,
	MainMenuBarRightEndCap
}) do
	v:SetVertexColor(.35, .35, .35)
end