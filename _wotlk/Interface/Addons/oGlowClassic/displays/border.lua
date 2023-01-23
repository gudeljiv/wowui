local _, ns = ...
local oGlowClassic = ns.oGlowClassic

local argcheck = oGlowClassic.argcheck
local colorTable = ns.colorTable

local createBorder = function(self, point)
	local bc = self.oGlowClassicBorder
	if(not bc) then
		if(not self:IsObjectType'Frame') then
			bc = self:GetParent():CreateTexture(nil, 'OVERLAY')
		else
			bc = self:CreateTexture(nil, "OVERLAY")
		end

		bc:SetTexture"Interface\\Buttons\\UI-ActionButton-Border"
		bc:SetBlendMode"ADD"
		bc:SetAlpha(.8)

		bc:SetWidth(70)
		bc:SetHeight(70)

		bc:SetPoint("CENTER", point or self)
		self.oGlowClassicBorder = bc
	end

	return bc
end

local borderDisplay = function(frame, color)
	if(color) then
		local bc = createBorder(frame)
		local rgb = colorTable[color]

		if(rgb) then
			bc:SetVertexColor(rgb[1], rgb[2], rgb[3])
			bc:Show()
		end

		return true
	elseif(frame.oGlowClassicBorder) then
		frame.oGlowClassicBorder:Hide()
	end
end

oGlowClassic:RegisterDisplay('Border', borderDisplay)
