local _, data = ...

local adi = LibStub('AceAddon-3.0'):GetAddon('AdiBags')

local filter = adi:RegisterFilter('BetterCategories', 25, 'ABEvent-1.0')

filter.uiName = 'Better Item Categories'
filter.uiDesc = 'Sets more granular categories (from WowHead) for items.'

function filter:OnInitialize()
    self.db = adi.db:RegisterNamespace('BetterCategories', {})
end

function filter:GetOptions()
    return {}, adi:GetOptionHandler(self, true)
end

function filter:GetClassIds(itemId)
    local entry = data.overrides[itemId]

    if entry == nil then
        entry = data.items[itemId]
    end

    if entry == nil then
        return nil
    end

    return entry.class, entry.subclass
end

function filter:GetClassName(classId, subclassId)
    local class = data.classes[classId]

    if class == nil then
        return nil
    end

    local subclass = class.subclasses[subclassId]

    if subclass == nil then
        return class.name
    end

    return subclass, class.name
end

function filter:Filter(slot)
    local classId, subclassId = self:GetClassIds(slot.itemId)

    if classId == nil then
        return nil
    end

    return self:GetClassName(classId, subclassId)
end
