local _, xVermin = ...

local function RepositionLootFrames()
	local anchor = _G["GroupLootContainer"]
	anchor:ClearAllPoints()
	anchor:SetPoint("CENTER", UIParent, "CENTER", 700, 550)
	anchor:SetScale(0.8)

	for i = 1, NUM_GROUP_LOOT_FRAMES do
		frame = _G["GroupLootFrame" .. i]
		if frame and frame ~= nil then
			if i == 1 then
				frame:ClearAllPoints()
				frame:SetPoint("CENTER", UIParent, "CENTER", 700, 550)
				frame:SetScale(1)
			elseif i > 1 then
				frame:ClearAllPoints()
				frame:SetPoint("BOTTOM", "GroupLootFrame" .. (i - 1), "TOP", 0, 5)
				frame:SetScale(1)
			end
		end
	end
end

local functionsToHook = {
	"GroupLootContainer_OnLoad",
	"GroupLootContainer_RemoveFrame",
	"GroupLootContainer_Update",
	"GroupLootFrame_OnShow",
	"GroupLootFrame_OpenNewFrame",
	"GroupLootFrame_OnEvent",
}

for _, funcName in ipairs(functionsToHook) do
	if _G[funcName] then
		hooksecurefunc(funcName, RepositionLootFrames)
	end
end

_G.RepositionLootFrames = RepositionLootFrames
