local AddonName, SAO = ...
local GetSpellInfo = GetSpellInfo
local IsSpellKnownOrOverridesKnown = IsSpellKnownOrOverridesKnown
if C_SpellBook and C_SpellBook.IsSpellInBook then
IsSpellKnownOrOverridesKnown = function(spellID)
return C_SpellBook.IsSpellInBook(spellID, false, true)
end
end
SAO.SpellIDsByName = {}
function SAO.GetSpellIDsByName(self, name)
local cached = self.SpellIDsByName[name]
if (cached) then
return cached
end
self:RefreshSpellIDsByName(name)
return self.SpellIDsByName[name]
end
function SAO.RefreshSpellIDsByName(self, name, awaken)
local homonyms = self:GetHomonymSpellIDs(name)
self.SpellIDsByName[name] = homonyms
if (awaken) then
for _, spellID in ipairs(homonyms) do
if (not self.RegisteredGlowSpellIDs[spellID]) then
self.RegisteredGlowSpellIDs[spellID] = true
self:AwakeButtonsBySpellID(spellID)
end
end
end
end
function SAO.LearnNewSpell(self, spellID)
local name = GetSpellInfo(spellID)
if (not name) then
return
end
local cached = self.SpellIDsByName[name]
if (not cached) then
return
end
for _, id in ipairs(cached) do
if (id == spellID) then
return
end
end
table.insert(self.SpellIDsByName[name], spellID)
if (self.RegisteredGlowSpellNames[name]) then
self.RegisteredGlowSpellIDs[spellID] = true
self:AwakeButtonsBySpellID(spellID)
end
end
function SAO.IsSpellIdentical(self, spellID, spellName, referenceID)
if spellID ~= 0 then
return spellID == referenceID
else
return spellName == GetSpellInfo(referenceID)
end
end
local canHaveMultipleRanks = SAO.IsProject(SAO.ALL_PROJECTS - SAO.CATA_AND_ONWARD)
function SAO.IsSpellLearned(self, spellID)
if IsSpellKnownOrOverridesKnown(spellID) then
return true
end
if canHaveMultipleRanks then
local spellName = GetSpellInfo(spellID)
for _, spellID in ipairs(self.SpellIDsByName[spellName] or {}) do
if IsSpellKnownOrOverridesKnown(spellID) then
return true
end
end
end
return false
end
function SAO.GetSpellEndTime(self, spellID, suggestedEndTime)
if type(suggestedEndTime) == 'number'
or type(suggestedEndTime) == 'table' and type(suggestedEndTime.endTime) == 'number' then
return suggestedEndTime
end
if (not self.Frame.useTimer) then
return
end
local duration, expirationTime = self:GetPlayerAuraDurationExpirationTimBySpellIdOrName(spellID)
if type(duration) == 'number' and type(expirationTime) == 'number' then
local startTime, endTime = expirationTime-duration, expirationTime
return { startTime=startTime, endTime=endTime }
elseif type(expirationTime) == 'number' then
return expirationTime
end
end
function SAO.IsFakeSpell(self, spellID)
if spellID >= 1000000 then
return true
end
if (self.IsEra() or self.IsTBC() or self.IsWrath() or self.IsCata()) and spellID == 48107 then
return true
end
if spellID == 96215 then
return true
end
return false
end
