local _, config = ...

-- if not config.autoAcceptInvite then return end

local f = CreateFrame('Frame')
f:RegisterEvent('PARTY_INVITE_REQUEST')
f:RegisterEvent('PARTY_MEMBERS_CHANGED')

local hidestatic -- used to hide static popup when auto-accepting

f:SetScript('OnEvent', function(self, event, ...)
    arg1 = ...
    local leader = arg1
    local ingroup = false

    if event == 'PARTY_INVITE_REQUEST' then
        if QueueStatusMinimapButton:IsShown() then return end -- Prevent losing queue inside LFD if someone invites you to group
        if GetNumSubgroupMembers() > 0 or GetNumGroupMembers() > 0 then return end
        hidestatic = true

        -- Update Guild and Friendlist
        if GetNumFriends() > 0 then ShowFriends() end
        if IsInGuild() then GuildRoster() end

        for friendIndex = 1, GetNumFriends() do
            local friendName = GetFriendInfo(friendIndex)
            if friendName == leader then
                AcceptGroup()
                ingroup = true
                break
            end
        end

        if not ingroup then
            for guildIndex = 1, GetNumGuildMembers(true) do
                local guildMemberName = GetGuildRosterInfo(guildIndex)
                if guildMemberName == leader then
                    AcceptGroup()
                    break
                end
            end
        end
    elseif event == 'PARTY_MEMBERS_CHANGED' and hidestatic == true then
        StaticPopup_Hide('PARTY_INVITE')
        hidestatic = false
    end
end)