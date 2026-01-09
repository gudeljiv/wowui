local name, methods = ...

--[[
    This addon help you to track down spellbook you have bought already. You must have
    learnt the spell and summoned all your pet at least once before this addon show
    correct results. All spellbooks you have bought will be marked green in merchant
    window.

    In short this addon work in following way.

    1. Check spellIds (then summoned, or talk to deamon vendor)
    2. Use the lookup table and save ItemID for Grimoires
    3. Then Demon vendor windows opens. Check our saved itemID with the box.
    4. Color all known spells green.
]]--

local Old_MerchantFrame_UpdateMerchantInfo
methods.KnownGrimoires = {}

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED");

-- find out what spell. return index and rank
function methods:searchForSpellIDs(spellId)
    for index = 0, table.getn(methods.tableSpellRank), 1 do
        for rank = 0, table.getn(methods.tableSpellRank[index]), 1 do
            if methods.tableSpellRank[index][rank] == spellId then
                spellName = GetSpellInfo(methods.tableSpellRank[index][rank])
                return index, rank
            end
        end
    end

    return false, false
end

function methods:ParsePetSkills()
    --[[
    Saves all itemID in a table Set all items to true for easy search. All saved
    to the global variable GrimoireKeeperData.
    ]]--

    local hasPetSpells, petToken = HasPetSpells()
    if hasPetSpells and petToken == "DEMON" then
        -- Loop through all pet spells
        for index = 1, hasPetSpells, 1 do
            local name, rank = GetSpellBookItemName( index, BOOKTYPE_PET )
            local spellId = select(7, GetSpellInfo(name, rank))

            if spellId then
                index, rank = methods:searchForSpellIDs(spellId)

                if index then
                    for i = rank, 1, - 1 do
                        local spell = methods.tableSpellRank[index][i]
                        itemId = methods.tableSpellIdToItemId[spell]

                        if itemId then
                            methods.KnownGrimoires[itemId] = true
                        end
                    end
                end
            end
        end
    end
    GrimoireKeeperData = methods.KnownGrimoires
end

function methods:ColorOurbook(itemButton, merchantButton)
    --[[
        This will change spellbook button and text to a more green tone
    ]]--

    SetItemButtonNameFrameVertexColor(merchantButton, 0, 0.75, 0.75);
    SetItemButtonSlotVertexColor(merchantButton, 0, 0.75, 0.75);
    SetItemButtonTextureVertexColor(itemButton, 0, 0.65, 0.65);
    SetItemButtonNormalTextureVertexColor(itemButton, 0, 0.65, 0.65);
end

function methods:CheckMerchantType()
    --[[
        We only want to check Demon vendors, so we check for spellbook icon
    ]]--
    local texture = select(2, GetMerchantItemInfo(1))

    if texture == 'Interface\\Icons\\INV_Misc_Book_06' or texture == 133738 then
        return true
    end

    return false
end

function methods.CheckWithMerchant()
    --[[
	   Search through Deamon vendors inventory and check with the itemID we got saved.
	   If we got a match then we color the spellbook green.
	]]--

    Old_MerchantFrame_UpdateMerchantInfo();
    local total = GetMerchantNumItems();

    if methods.KnownGrimoires == nil then return end

    for i = 1, MERCHANT_ITEMS_PER_PAGE, 1 do
        -- All spellbooks got an ID from 1 to 59

        local index = (((MerchantFrame.page - 1) * MERCHANT_ITEMS_PER_PAGE) + i)
        local itemLink = GetMerchantItemLink(index)

        if not itemLink then return end

        local itemString = select(3, string.find(itemLink, "|H(.+)|h"))
        local _, itemId, _ = strsplit(":", itemString, 3)

        itemId = tonumber(itemId)

        -- button index restart on each pages...
        local index_offset = index - 10 * (MerchantFrame.page - 1)

        if methods.KnownGrimoires[itemId] then
            local itemButton = getglobal("MerchantItem"..index_offset.."ItemButton");
            local merchantButton = getglobal("MerchantItem"..index_offset);
            methods:ColorOurbook(itemButton, merchantButton)
        end
    end
end

function methods.EventHandler(self, event, arg1, ...)
    if event == "ADDON_LOADED" then
        if arg1 == methods.title then
            print(methods.title .. " " .. methods.version .." " .. methods.lang['loaded']);

            -- We are hooking on MerchantFrame update and rederect it through our function
            Old_MerchantFrame_UpdateMerchantInfo = MerchantFrame_UpdateMerchantInfo;
            MerchantFrame_UpdateMerchantInfo = methods.CheckWithMerchant;

            if not GrimoireKeeperData then
                GrimoireKeeperData = {}
            end

            methods.KnownGrimoires = GrimoireKeeperData

            eventFrame:RegisterEvent("MERCHANT_SHOW")
            eventFrame:RegisterEvent("PET_DISMISS_START")
            eventFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
        end
    elseif event == "MERCHANT_SHOW" then
        if methods:CheckMerchantType() == true then
            methods:ParsePetSkills()
            methods.CheckWithMerchant()
        end
    elseif event == "PET_DISMISS_START" then
        methods:ParsePetSkills()
    elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
        if arg1 == "player" then
            local spellId = select(2, ...)

            if methods.SummonPetIds[spellId] then
                -- Without this timer addon will crash. I think this is cos it's a slight delay
                -- then summoned a pet and then you can extract the data.
                C_Timer.After(0.5, function()
                    methods:ParsePetSkills()
                end)
            end
        end
    end
end

eventFrame:SetScript("OnEvent", methods.EventHandler);

function methods.SlashHandler(msg)
    if msg == methods.lang['list'] then
        print(methods.title .. " " .. methods.version .. " " .. methods.lang['saved'])
        for itemId, value in pairs(methods.KnownGrimoires) do
            local name, itemLink = GetItemInfo(itemId)
            if name then
                print(itemLink)
            end
        end
    elseif msg == methods.lang['reset'] then
        print(methods.title .. " " .. methods.version .. " " .. methods.lang['reseted'])
        methods.KnownGrimoires = {}
        GrimoireKeeperData = {}
    else
        print(methods.title .. " " .. methods.version .. " " .. methods.lang['usage'])
    end
end

SLASH_GRIMOIREKEEPER1 = "/gk"
SlashCmdList["GRIMOIREKEEPER"] = methods.SlashHandler
