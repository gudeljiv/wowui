local _, T = ...

if select(4, GetBuildInfo()) >= 10e4 then
	local pv = {}
	local function PreClick(self, _, down)
		local pa = pv[self] or {}
		pv[self], pa[#pa+1] = pa, GetCVar("ActionButtonUseKeyDown")
		SetCVar("ActionButtonUseKeyDown", down and 1 or 0)
	end
	local function PostClick(self)
		local pa, lv = pv[self]
		if pa and pa[1] ~= nil then
			lv, pa[#pa] = pa[#pa], nil
			SetCVar("ActionButtonUseKeyDown", lv)
		end
	end
	function T.TenSABT(self)
		self[self:GetScript("PreClick") and "HookScript" or "SetScript"](self, "PreClick", PreClick)
		self[self:GetScript("PostClick") and "HookScript" or "SetScript"](self, "PostClick", PostClick)
		return self
	end
else
	function T.TenSABT(self)
		return self
	end
end