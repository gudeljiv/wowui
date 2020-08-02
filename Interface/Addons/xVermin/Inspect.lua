local btn = CreateFrame("BUTTON", "MyBindingInspectTargetButton")
SetBindingClick("I", btn:GetName())
btn:SetScript(
	"OnClick",
	function(self, button, down)
		-- 1 = Inspect, 28 yards
		-- 2 = Trade, 11.11 yards
		-- 3 = Duel, 9.9 yards
		-- 4 = Follow, 28 yards
		if (TargetFrame:IsShown()) then
			if (CheckInteractDistance("target", 1)) then
				InspectUnit("target")
			else
				print("Can't inspect. Target too far.")
			end
		else
			print("No target")
		end
	end
)
