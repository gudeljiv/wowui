local ADDON = ...

local prgname = "|cffffd200gmMoney|r"
local string_format = string.format
local math_floor = math.floor
local tooltip

local playerName = UnitName("player")
local realmName = GetRealmName()
local _, class = UnitClass("player")

local StartGold

GMMONEYSET = {	
	FULLDISP = true,
	TEXTMODE = true,
}
		
local function classcolor(name,class)
	local color = _G["RAID_CLASS_COLORS"][class]
	return string_format("\124cff%02x%02x%02x%s\124r", color.r*255, color.g*255, color.b*255, name)
end

local function printmoney(value)

	if GMMONEYSET["TEXTMODE"] then 	
		if value == 0 then return 0 end
		local gold = math_floor(value / 10000)
		local silver = mod(math_floor(value / 100), 100)
		local copper = mod(value, 100)
		return string_format("|cffffd700%i|r.|cffc7c7cf%02i|r.|cffeda55f%02i|r", gold, silver, copper)
	else
		return GetCoinTextureString(value)
	end
	
end

local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
local dataobj = ldb:NewDataObject("gmMoney", {
	type = "data source",
	icon = "Interface\\Addons\\"..ADDON.."\\icon.tga",
	text = "none yet"
})

local function UpdateLDB()

	if GMMONEYSET["TEXTMODE"] == false and GMMONEYSET["FULLDISP"] == false then
		dataobj.text = string_format("%d", GMMONEY[realmName][playerName]["GOLD"] / 10000)
	elseif GMMONEYSET["TEXTMODE"] == false and GMMONEYSET["FULLDISP"] == true then
		dataobj.text = GetCoinTextureString(GMMONEY[realmName][playerName]["GOLD"])
	elseif GMMONEYSET["TEXTMODE"] == true and GMMONEYSET["FULLDISP"] == false then
		dataobj.text = string_format("|cffffd700%i|r ", GMMONEY[realmName][playerName]["GOLD"] / 10000)
	elseif GMMONEYSET["TEXTMODE"] == true and GMMONEYSET["FULLDISP"] == true then
		dataobj.text = printmoney(GMMONEY[realmName][playerName]["GOLD"])
	end
	
end

local function spairs(t)
	local keys = {}
	for k in pairs(t) do keys[#keys+1] = k end
	table.sort(keys)
	local i = 0
	return function()
		i = i + 1
		if keys[i] then return keys[i], t[keys[i]] end
	end
end


local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_MONEY")
frame:RegisterEvent("PLAYER_TRADE_MONEY")
frame:RegisterEvent("TRADE_MONEY_CHANGED")
frame:RegisterEvent("SEND_MAIL_MONEY_CHANGED")
frame:RegisterEvent("SEND_MAIL_COD_CHANGED")
frame:RegisterEvent("PLAYER_LOGIN")

frame:SetScript("OnEvent", function(self, event, ...)

	GMMONEY = GMMONEY or {}
	GMMONEY[realmName] = GMMONEY[realmName] or {}
	GMMONEY[realmName][playerName] = {}
	GMMONEY[realmName][playerName]["GOLD"] = GetMoney() 
	GMMONEY[realmName][playerName]["CLASS"] = class 

	if event == "PLAYER_LOGIN" then 
		StartGold = GMMONEY[realmName][playerName]["GOLD"]
	end

	UpdateLDB()
	
end)	


dataobj.OnClick = function(self, button)  

	if 		button == "RightButton" then  GMMONEYSET["FULLDISP"]  = not  GMMONEYSET["FULLDISP"] 
	
	elseif 	button == "MiddleButton" then GMMONEYSET["TEXTMODE"] = not GMMONEYSET["TEXTMODE"]
	
	elseif 	button == "LeftButton" then ToggleCharacter("TokenFrame")	

	end
		
	UpdateLDB()

end


function dataobj.OnTooltipShow(tooltip)

	local TotalGold = 0

	tooltip:AddLine(ADDON)
	tooltip:AddLine(" ")
	
	for idx in spairs(GMMONEY[realmName]) do	
		tooltip:AddDoubleLine(classcolor(idx,GMMONEY[realmName][idx]["CLASS"]), printmoney(GMMONEY[realmName][idx]["GOLD"]))
		TotalGold = TotalGold + GMMONEY[realmName][idx]["GOLD"]
	end	

	tooltip:AddLine(" ")

	if StartGold <= GMMONEY[realmName][playerName]["GOLD"]  then 
		tooltip:AddDoubleLine("This session balance", printmoney(GMMONEY[realmName][playerName]["GOLD"] - StartGold ), 0,1,0,1,1,1)
	else 
		tooltip:AddDoubleLine("This session balance", "- " .. printmoney(StartGold - GMMONEY[realmName][playerName]["GOLD"]), 1,0,0,1,1,1)
	end
	
	tooltip:AddDoubleLine("Total gold on " .. realmName , printmoney(TotalGold), 1,1,1,1,1,1)
	tooltip:AddLine(" ")
	
	tooltip:AddDoubleLine("Left Click", "Toggle currency frame")
	tooltip:AddDoubleLine("Right Click", "Toggle short LDB display")
	tooltip:AddDoubleLine("Middle Click", "Toggle text mode")
	tooltip:AddLine(" ")
	tooltip:AddDoubleLine("/gmmoney", "For cli mode", 1,1,1,1,1,1)

end

SLASH_GMMONEY1 = "/gmmoney"
SlashCmdList["GMMONEY"] = function(args) 	

	local name=SecureCmdOptionParse(args)
		
	if name == "" then 
		print(prgname .. " help")
		print("/gmmoney name - Remove a pg of this realm from DB")
		print("/gmmoney RESET! - Reset the DB ('RESET!' is case sensitive)")
		return
	
	elseif  name == "RESET!" then 
		GMMONEY = {}
		GMMONEYSET = {	FULLDISP = true, TEXTMODE = true}
		ReloadUI()
	
	else		
		if playerName == name:gsub("^%l", string.upper) then 
			print(prgname .. ": " .. playerName .. " is active and can't be removed")
			return
		else
			GMMONEY[realmName][name:gsub("^%l", string.upper)]=nil
			print(prgname .. ": " .. name:gsub("^%l", string.upper) .. " succesfully removed if present")
			UpdateLDB()
		end
	end
	
end