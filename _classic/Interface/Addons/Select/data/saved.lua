-- saved.lua is the per-character saved settings. rather than wait until logout to update the savedvar, any changes
-- in flyout attributes (attribClass,attribType,attribKey,attribValue) should be stored as the attributes change.
-- this allows for a consistent place to retrieve defaults even in the case of flyouts being abandoned/reused

-- right now old flyout savedvars don't get deleted; but this should be a minimal impact and having old saved
-- attributes may be nice to have so keeping it for now.

local _, s = ...
s.saved = {}

SelectPerCharacterSettings = {}

-- saves the attribClass,attribType,attribKey,attribValue for the given flyout list
function s.saved:Set(list, attribClass, attribType, attribKey, attribValue)
	local saved = SelectPerCharacterSettings
	if not saved[list] then
		saved[list] = {}
	end
	saved[list][1] = attribClass
	saved[list][2] = attribType
	saved[list][3] = attribKey
	saved[list][4] = attribValue
end

-- returns the attribClass,attribType,attribKey,attribValue for the given flyout list
function s.saved:Get(list)
	local saved = SelectPerCharacterSettings[list]
	if saved then
		return saved[1], saved[2], saved[3], saved[4]
	end
end
