#!/usr/local/bin/lua

local strings = {}

for i=1,#arg do
	local file = io.open(arg[i], "r")
	assert(file, "Could not open " .. arg[i])
	local text = file:read("*all")

	for match in string.gmatch(text, "L%[\"(.-)\"%]") do
		strings[match] = true
	end	
end

local work = {}

for k,v in pairs(strings) do table.insert(work, k) end
table.sort(work)

local values = {
	STATUS_ARCANEINT = "Int",
	STATUS_BLESSINGKINGS = "BoK",
	STATUS_BLESSINGLIGHT = "BoL",
	STATUS_BLESSINGMIGHT = "BoM",
	STATUS_BLESSINGSALVATION = "BoS",
	STATUS_BLESSINGSANCTUARY = "BoSn",
	STATUS_BLESSINGWISDOM = "BoW",
	STATUS_DIVINESPIRIT = "Spi",
	STATUS_FEARWARD = "FW",
	STATUS_FORT = "F",
	STATUS_INNERVATE = "Inn",
	STATUS_WILD_GROWTH = "Wg",
	STATUS_MOTW = "M",
	STATUS_POWERINFUSION = "PwI",
	STATUS_PWS = "PwS",
	STATUS_REGROWTH = "Rg",
	STATUS_LIFEBLOOM = "Lb",
	STATUS_REJUV = "Rj",
	STATUS_RENEW = "Rn",
	STATUS_SHADOWPROT = "Sh",
	STATUS_SOULSTONE = "Ss",
	STATUS_THORNS = "Th",
	STATUS_WEAKENEDSOUL = "Ws",
	STATUS_MORTALSTRIKE = "Ms",
	STATUS_CURSE = "Cu",
	STATUS_MAGIC = "Ma",
	STATUS_POISON = "Po",
	STATUS_DISEASE = "Di",
	STATUS_PRAYERMEND = "PoM",
}

print("--Localization.enUS.lua\n")
print("PerfectRaidLocals = {")
for idx,match in ipairs(work) do
	local val = values[match] or match
	print(string.format("\t[\"%s\"] = \"%s\",", match, val))
end
print("}\n")
print("setmetatable(PerfectRaidLocals, {__index=function(t,k) if not rawget(t,k) then return k else return t[k] end end})")

