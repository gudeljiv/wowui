local _, SHC = ...;

function SHC:Update()
	-- Check if there is saved data
	if not SigmaHelmAndCloak then
		SigmaHelmAndCloak = {};
	end
	-- Check if the helm is listed
	local helm = GetInventoryItemLink("player", 1);
	if helm then
		if not SigmaHelmAndCloak[helm] then
			if ShowingHelm() then
				SigmaHelmAndCloak[helm] = "On";
			else
				SigmaHelmAndCloak[helm] = "Off";
			end
		else
			ShowHelm(SigmaHelmAndCloak[helm] == "On");
		end
	end
	-- Check if the cloak is listed
	local cloak = GetInventoryItemLink("player", 15);
	if cloak then
		if not SigmaHelmAndCloak[cloak] then
			if ShowingCloak() then
				SigmaHelmAndCloak[cloak] = "On";
			else
				SigmaHelmAndCloak[cloak] = "Off";
			end
		else
			ShowCloak(SigmaHelmAndCloak[cloak] == "On");
		end
	end
end

function SHC.ShowHelm(flag)
	local helm = GetInventoryItemLink("player", 1);
	
	if helm then
		if not SigmaHelmAndCloak then
			SigmaHelmAndCloak = {};
		end
		
		if flag then
			SigmaHelmAndCloak[helm] = "On";
		else
			SigmaHelmAndCloak[helm] = "Off";
		end
	end
	SHC.HelmButton:SetChecked(flag);
	SHC.baseShowHelm(flag);
end

function SHC.ShowCloak(flag)
	local cloak = GetInventoryItemLink("player", 15);
	
	if cloak then
		if not SigmaHelmAndCloak then
			SigmaHelmAndCloak = {};
		end
		
		if flag then
			SigmaHelmAndCloak[cloak] = "On";
		else
			SigmaHelmAndCloak[cloak] = "Off";
		end
	end
	SHC.CloakButton:SetChecked(flag);
	SHC.baseShowCloak(flag);
end
