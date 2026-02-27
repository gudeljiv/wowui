local Module = SUI:NewModule("Skins.Friendlist");

function Module:OnEnable()
    if (SUI:Color()) then
        local function SafeSkin(frame)
            if frame then
                SUI:Skin(frame, true)
            end
        end

        SafeSkin(AddFriendEntryFrame)
        SafeSkin(AddFriendFrame and AddFriendFrame.Border)
        SafeSkin(FriendsFrame)
        SafeSkin(FriendsFrame and FriendsFrame.NineSlice)
        SafeSkin(FriendsFrameInset)
        SafeSkin(FriendsFrameInset and FriendsFrameInset.NineSlice)
        SafeSkin(FriendsFriendsFrame)
        SafeSkin(FriendsFriendsFrame and FriendsFriendsFrame.Border)

        if RecruitAFriendFrame then
            SafeSkin(RecruitAFriendFrame)
            SafeSkin(RecruitAFriendFrame.RecruitList)
            SafeSkin(RecruitAFriendFrame.RecruitList and RecruitAFriendFrame.RecruitList.Header)
            SafeSkin(RecruitAFriendFrame.RecruitList and RecruitAFriendFrame.RecruitList.ScrollFrameInset)
            SafeSkin(RecruitAFriendFrame.RecruitList and RecruitAFriendFrame.RecruitList.ScrollFrameInset and RecruitAFriendFrame.RecruitList.ScrollFrameInset.NineSlice)
            SafeSkin(RecruitAFriendFrame.RewardClaiming)
            SafeSkin(RecruitAFriendFrame.RewardClaiming and RecruitAFriendFrame.RewardClaiming.Inset)
            SafeSkin(RecruitAFriendFrame.RewardClaiming and RecruitAFriendFrame.RewardClaiming.Inset and RecruitAFriendFrame.RewardClaiming.Inset.NineSlice)
            SafeSkin(RecruitAFriendRecruitmentFrame)
            SafeSkin(RecruitAFriendRecruitmentFrame and RecruitAFriendRecruitmentFrame.Border)
        end
        
        -- Handle Who Frame elements (may not exist in current version)
        local whoFrameListInset = _G["WhoFrameListInset"]
        if whoFrameListInset then
            SUI:Skin(whoFrameListInset, true)
            if whoFrameListInset.NineSlice then
                SUI:Skin(whoFrameListInset.NineSlice, true)
            end
        end
        
        local whoFrameEditBoxInset = _G["WhoFrameEditBoxInset"]
        if whoFrameEditBoxInset then
            SUI:Skin(whoFrameEditBoxInset, true)
            if whoFrameEditBoxInset.NineSlice then
                SUI:Skin(whoFrameEditBoxInset.NineSlice, true)
            end
        end
        
        SafeSkin(FriendsFrameBattlenetFrame and FriendsFrameBattlenetFrame.BroadcastFrame)
        SafeSkin(FriendsFrameBattlenetFrame and FriendsFrameBattlenetFrame.BroadcastFrame and FriendsFrameBattlenetFrame.BroadcastFrame.Border)

        -- Tabs
        SafeSkin(FriendsTabHeaderTab1)
        SafeSkin(FriendsTabHeaderTab2)
        SafeSkin(FriendsTabHeaderTab3)
        SafeSkin(FriendsFrameTab1)
        SafeSkin(FriendsFrameTab2)
        SafeSkin(FriendsFrameTab3)
        SafeSkin(FriendsFrameTab4)
    end
end
