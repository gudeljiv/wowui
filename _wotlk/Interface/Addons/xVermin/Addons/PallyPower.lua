local _, xVermin = ...
local ib, numQuests
local count = 0

C_Timer.NewTicker(
	1,
	function(self)
		if (count > xVermin.WaitTimeUntillAddonLoaded) then
			self:Cancel()
		end
		count = count + 1

		local frame = PallyPowerBlessingsFrame
		if frame then
			if not frame.SetBackdrop then
				Mixin(frame, BackdropTemplateMixin)
			end
			frame:HookScript(
				'OnLoad',
				function(self)
					self.TopEdge:Hide()
					self.BottomEdge:Hide()
					self.RightEdge:Hide()
					self.LeftEdge:Hide()
					self.TopLeftCorner:Hide()
					self.BottomLeftCorner:Hide()
					self.TopRightCorner:Hide()
					self.BottomRightCorner:Hide()
					self:CreateBeautyBorder(8)
					self:SetBackdrop(
						{
							bgFile = 'Interface\\Buttons\\WHITE8x8',
							edgeFile = '',
							tile = false,
							tileSize = 0,
							edgeSize = 0,
							insets = {left = 0, right = 0, top = 0, bottom = 0}
						}
					)
					self:SetBackdropColor(0, 0, 0, 0.6)

					-- for i = 1, 40 do
					-- 	local ag = _G[self:GetName() .. 'AuraGroup' .. i .. 'AuraHeaderIcon']
					-- 	local cg = _G[self:GetName() .. 'ClassGroup' .. i .. 'ClassButtonIcon']
					-- 	local pa = _G[self:GetName() .. 'Player' .. i .. 'Aura1Icon']
					-- 	local pc = _G[self:GetName() .. 'Player' .. i .. 'Class1Icon']
					-- 	-- print(ag:GetName())
					-- 	-- if ag then
					-- 	-- 	ag:CreateBeautyBorder(6)
					-- 	-- end
					-- 	-- if cg then
					-- 	-- 	cg:CreateBeautyBorder(6)
					-- 	-- end
					-- 	-- if pa then
					-- 	-- 	for j = 1, 40 do
					-- 	-- 		local f = _G[self:GetName() .. 'Player' .. i .. 'Aura' .. j .. 'Icon']
					-- 	-- 		if f then
					-- 	-- 			f:CreateBeautyBorder(6)
					-- 	-- 		end
					-- 	-- 	end
					-- 	-- end
					-- 	-- if pc then
					-- 	-- 	for j = 1, 40 do
					-- 	-- 		local f = _G[self:GetName() .. 'Player' .. i .. 'Class' .. j .. 'Icon']
					-- 	-- 		if f then
					-- 	-- 			f:CreateBeautyBorder(6)
					-- 	-- 		end
					-- 	-- 	end
					-- 	-- end
					-- end
				end
			)

			self:Cancel()
		end
	end
)
