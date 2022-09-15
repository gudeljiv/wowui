hooksecurefunc(
	'CompactUnitFrame_SetMaxBuffs',
	function(frame, numbuffs)
		local buffscale = 1.25
		local debuffscale = 1.1
		local maxbuffs = 3 -- default: 3;

		for i = 1, #frame.buffFrames do
			frame.buffFrames[i]:SetScale(buffscale)
		end

		for i = 1, #frame.debuffFrames do
			frame.debuffFrames[i]:SetScale(debuffscale)
		end

		frame.maxBuffs = maxbuffs
	end
)

hooksecurefunc(
	'CompactUnitFrame_UpdateName',
	function(frame)
		local name = frame.name
		local playerName = GetUnitName(frame.unit, true)

		name:ClearAllPoints()
		name:SetPoint('TOPLEFT', 5, -5)

		if (playerName) then
			local nameWithoutRealm = gsub(playerName, '%-[^|]+', '')
			name:SetText(nameWithoutRealm)
		end

		if InCombatLockdown() then
			-- name:Hide(1);
			name:SetAlpha(0.15)
		else
			-- name:Show();
			name:SetAlpha(1)
		end
	end
)

hooksecurefunc(
	'CompactUnitFrame_UpdateRoleIcon',
	function(frame)
		local icon = frame.roleIcon
		if not icon then
			return
		end

		local offset = icon:GetWidth() / 4

		icon:ClearAllPoints()
		icon:SetPoint('TOPLEFT', -offset, offset)

		local role = UnitGroupRolesAssigned(frame.unit)

		if (role == 'DAMAGER') then
			icon:Hide()
		end
	end
)
