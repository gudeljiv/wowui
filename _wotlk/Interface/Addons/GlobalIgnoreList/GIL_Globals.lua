----------------------
-- GLOBAL FUNCTIONS --
----------------------

function trim (str)

	local n = str:find"%S"
	return n and str:match(".*%S", n) or ""
 
end

function dateToJulianDate (dateStr)
	
	if dateStr == nil then
		return 0
	end

	local monthList = { "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" }
	local words     = {}

	for word in dateStr:gmatch("%w+") do
		table.insert(words, word)
	end
	
	local day   = tonumber(words[1])
	local year  = tonumber(words[3])
	local month = 0

	for key, value in pairs(monthList) do
	
		if value == words[2] then
			month = tonumber(key)
			
			break
		end
	end

	--print ("monthStr="..monthStr.." month="..month.." day="..day.." year="..year)

	if (not month) or (not day) or (not year) or (month < 1) or (month > 12) or (day < 1) or (day > 31) or (year < 2014) then
		return 0
	end
	
	local calc1 = (month - 14) / 12
	local calc2 = day - 32075 + (1461 * (year + 4800 + calc1) / 4)
	
	calc2 = calc2 + (367 * (month - 2 - calc1 * 12) / 12)
	calc2 = calc2 - (3 * ((year + 4900 + calc1) / 100) / 4)
	
	return calc2
end

function daysFromToday (dateStr)

	local addDate = dateToJulianDate(dateStr)
	local today   = dateToJulianDate(date("%d %b %Y"))
	
	if addDate == 0 then
		return -1
	else
	
		if addDate < today then
			return math.floor(today - addDate)
		else
			return math.floor(addDate - today)
		end
	end
end

function strDown (str)

	local len    = strlen(str)
	local count  = 1
	local res    = ""
	local c
	local char   = string.char
	local lower  = string.lower
	
	while count <= len do
		c = strbyte(str, count)
		
		if c < 32 or c > 126 then
			res = res .. char(c)
		else
			res = res .. lower(char(c))
		end
		
		count = count + 1
	end
	
	return res
end

function Proper (name, okSpaces)

	if name == nil then return nil end

	local len    = strlen(name)
	local count  = 1
	local res    = ""
	local needUp = true
	local gotOP  = false
	local c
	local char   = string.char
	local upper  = string.upper
	local lower  = string.lower
	local sb     = strbyte
	
	while count <= len do
		c = sb(name, count)
				
		if c < 32 or c > 126 then
			res    = res .. char(c)
			needUp = false
		else
			if c ~= 32 or okSpaces == true then
				if needUp then
					res = res .. upper(char(c))
				else
					res = res .. lower(char(c))
				end
			
				gotOP  = (c == 40 or gotOP) and (c ~= 41)
				needUp = (c == 32 or c == 45 or gotOP == true)
			end
		end
		
		count  = count + 1
	end
	
	return res
end

function GetWord (str, wordnumber)

	local len     = strlen(str)
	local count   = 1
	local res     = ""
	local words   = 0
	local nextInc = true
	local c
	
	while count <= len do
		if nextInc then
			words = words + 1
			
			if words > wordnumber then
				break
			end
		end
		
		c = strbyte(str, count)
		
		nextInc = (c == 32) and nextInc == false
		
		if words == wordnumber and c ~= 32 then
			res = res .. string.char(c)
		end
		
		count = count + 1
	end
	
	return res
end

function prettyServer (origName)

	if origName == nil then return nil end

	name = origName
	
	if	name == "Ahn'qiraj"		then name = "Ahn'Qiraj"
	elseif	name == "Al'akir"		then name = "Al'Akir"
	elseif	name == "Altarofstorms"		then name = "Altar of Storms"	
	elseif	name == "Alteracmountains"	then name = "Alterac Mountains"
	elseif	name == "Aman'thul"		then name = "Aman'Thul"
	elseif	name == "Arcanitereaper" then name = "Arcanite Reaper"
	elseif	name == "Area52"		then name = "Area 52"
	elseif	name == "Argentdawn"		then name = "Argent Dawn"
	elseif	name == "Azjol-nerub"		then name = "Azjol-Nerub"
	elseif	name == "Blackdragonflight"	then name = "Black Dragonflight"
	elseif	name == "Blackwaterraiders"	then name = "Blackwater Raiders"
	elseif	name == "Blackwinglair"		then name = "Blackwing Lair"
	elseif	name == "Blade'sedge"		then name = "Blade's Edge"
	elseif	name == "Bloodfurnace"		then name = "Blood Furnace"
	elseif	name == "Bloodsailbuccaneers" then name = "Bloodsail Buccaneers"
	elseif	name == "Bleedinghollow"	then name = "Bleeding Hollow"
	elseif	name == "Boreantundra"		then name = "Borean Tundra"
	elseif	name == "Bronzedragonflight"	then name = "Bronze Dragonflight"
	elseif	name == "Burningblade"		then name = "Burning Blade"
	elseif	name == "Burninglegion"		then name = "Burning Legion"
	elseif	name == "Burningsteppes"	then name = "Burning Steppes"
	elseif	name == "Cenarioncircle"	then name = "Cenarion Circle"
	elseif	name == "Chamberofaspects"	then name = "Chamber of Aspects"
	elseif	name == "Chantséternels"	then name = "Chants éternels"
	elseif	name == "Colinaspardas"		then name = "Colinas Pardas"
	elseif	name == "Confrérieduthorium"	then name = "Confrérie du Thorium"
	elseif	name == "Conseildesombres"	then name = "Conseil des Ombres"
	elseif	name == "Cultedelarivenoire"	then name = "Culte de la Rive noire"
	elseif	name == "Darkmoonfaire"		then name = "Darkmoon Faire"
	elseif	name == "Daskonsortium"		then name = "Das Konsortium"
	elseif	name == "Dassyndikat"		then name = "Das Syndikat"
	elseif	name == "Dath'remar"		then name = "Dath'Remar"
	elseif	name == "Defiasbrotherhood"	then name = "Defias Brotherhood"
	elseif	name == "Derabyssischerat"	then name = "Der abyssische Rat"
	elseif	name == "Dermithrilorden"	then name = "Der Mithrilorden"
	elseif	name == "Derratvondalaran"	then name = "Der Rat von Dalaran"
	elseif	name == "Demonsoul"		then name = "Demon Soul"
	elseif	name == "Deviatedelight"	then name = "Deviate Delight"
	elseif	name == "Diealdor"		then name = "Die Aldor"
	elseif	name == "Diearguswacht"		then name = "Die Arguswacht"
	elseif	name == "Dieewigewacht"		then name = "Die ewige Wacht"
	elseif	name == "Dienachtwache"		then name = "Die Nachtwache"
	elseif	name == "Diesilbernehand"	then name = "Die Silberne Hand"
	elseif	name == "Dietodeskrallen"	then name = "Die Todeskrallen"
	elseif	name == "Drak'tharon"		then name = "Drak'Tharon"
	elseif	name == "Dragon'scall"	then name = "Dragon's Call"
	elseif	name == "Dunmodr"		then name = "Dun Modr"
	elseif	name == "Dunmorogh"		then name = "Dun Morogh"
	elseif	name == "Earthenring"		then name = "Earthen Ring"	
	elseif	name == "Echoisles"		then name = "Echo Isles"
	elseif	name == "Eldre'thalas"		then name = "Eldre'Thalas"
	elseif	name == "Emeralddream"		then name = "Emerald Dream"
	elseif	name == "Festungderstürme"	then name = "Festung der Stürme"
	elseif	name == "Grimbatol"		then name = "Grim Batol"
	elseif	name == "Grizzlyhills"		then name = "Grizzly Hills"
	elseif	name == "Howlingfjord"		then name = "Howling Fjord"
	elseif	name == "Hydraxianwaterlords" then name = "Hydraxian Waterlords"
	elseif	name == "Jubei'thos"		then name = "Jubei'Thos"
	elseif	name == "Kel'thuzad"		then name = "Kel'Thuzad"
	elseif	name == "Khazmodan"		then name = "Khaz Modan"
	elseif	name == "Kirintor"		then name = "Kirin Tor"
	elseif	name == "Kultiras"		then name = "Kul Tiras"
	elseif	name == "Kultderverdammten"	then name = "Kult der Verdammten"
	elseif	name == "Lacroisadeécarlate"	then name = "La Croisade écarlate"
	elseif	name == "Laughingskull"		then name = "Laughing Skull"
	elseif	name == "Lesclairvoyants"	then name = "Les Clairvoyants"
	elseif	name == "Lessentinelles"	then name = "Les Sentinelles"
	elseif	name == "Lichking"		then name = "Lich King"
	elseif	name == "Lightning'sblade"	then name = "Lightning's Blade"
	elseif	name == "Loserrantes"		then name = "Los Errantes"
	elseif	name == "Mal'ganis"		then name = "Mal'Ganis"
	elseif	name == "Marécagedezangar"	then name = "Marécage de Zangar"
	elseif	name == "Mirageraceway"	then name = "Mirage Raceway"
	elseif	name == "Mok'nathal"		then name = "Mok'Nathal"
	elseif	name == "Moonguard"		then name = "Moon Guard"
	elseif	name == "Nethergardekeep" then name = "Nethergarde Keep"
	elseif  name == "Oldblanchy"	then name = "Old Blanchy"
	elseif	name == "Pozzodell'eternità"	then name = "Pozzo dell'Eternità"
	elseif	name == "Pyrewoodvillage" then name = "Pyrewood Village"
	elseif	name == "Quel'thalas"		then name = "Quel'Thalas"
	elseif	name == "Scarletcrusade"	then name = "Scarlet Crusade"
	elseif	name == "Scarshieldlegion"	then name = "Scarshield Legion"
	elseif	name == "Shadowcouncil"		then name = "Shadow Council"
	elseif	name == "Shatteredhalls"	then name = "Shattered Halls"
	elseif	name == "Shatteredhand"		then name = "Shattered Hand"
	elseif	name == "Silverhand"		then name = "Silver Hand"
	elseif	name == "Sistersofelune"	then name = "Sisters of Elune"
	elseif	name == "Steamwheedlecartel"	then name = "Steamwheedle Cartel"
	elseif	name == "Tarrenmill"		then name = "Tarren Mill"
	elseif	name == "Templenoir"		then name = "Temple noir"
	elseif	name == "Theforgottencoast"	then name = "The Forgotten Coast"
	elseif	name == "Themaelstrom"		then name = "The Maelstrom"
	elseif	name == "Thescryers"		then name = "The Scryers"
	elseif	name == "Thesha'tar"		then name = "The Sha'tar"
	elseif	name == "Theunderbog"		then name = "The Underbog"
	elseif	name == "Theventureco"		then name = "The Venture Co"
	elseif	name == "Thoriumbrotherhood"	then name = "Thorium Brotherhood"
	elseif	name == "Throk'feroth"		then name = "Throk'Feroth"
	elseif	name == "Tolbarad"		then name = "Tol Barad"
	elseif	name == "Twilight'shammer"	then name = "Twilight's Hammer"
	elseif	name == "Twistingnether"	then name = "Twisting Nether"
	elseif	name == "Wyrmrestaccord"	then name = "Wyrmrest Accord"
	elseif	name == "Zandalartribe" then name = "Zandalar Tribe"
	elseif	name == "Zirkeldesccenarius"	then name = "Zirkel des Cenarius"
		
	else
		
		local len  = strlen(origName)
		local sb   = strbyte
		local char = string.char
		local c1
		local c
		local gotP = false
		
		name = ""
	
		for count = 1, len do
			c  = sb(origName, count)
			c1 = sb(origName, count+1) or 32
		
			if ((c1 > 47 and c1 < 58) or (c1 > 64 and c1 < 91) or (c1 == 40)) and gotP == false then
				name = name .. char(c) .. " "
			
				if (c1 == 40) or (c1 > 47 and c1 < 58) then gotP = true end
			else
				name = name .. char(c)
			end
		end

	end
	
	return name
 
end

function getServer (name, def)

	local index = string.find(name, "-", 1, true)
	
	if index ~= nil then
		return string.sub(name, index + 1, string.len(name))
	end
	
	if def then return def else return serverName end
end

function removeServer (name, strict)
	
	if name == nil then
		return nil
	end

	result = name
	
	local index = string.find(name, "-", 1, true)
	
	if strict == nil then
		strict = false
	end
	
	if index ~= nil then
		local server = Proper(string.sub(name, index + 1, string.len(name)));
		
		if strict == true or server == Proper(serverName) then
			result = string.sub(name, 1, index - 1)
		end
	end
	
	return result	
end

function addServer (name)

	if not name then return nil end

	if string.find(name, "-", 1, true) == nil then
		return name .. "-" .. serverName
	end
	
	return name
end

----------------------
-- GLOBAL VARIABLES --
----------------------

_, L		= ...
serverName	= Proper(GetRealmName())
playerName	= addServer(GetUnitName("player"), true)

