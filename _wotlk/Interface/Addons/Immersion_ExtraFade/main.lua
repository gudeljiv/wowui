local folderName, Addon = ...
local L = LibStub("AceAddon-3.0"):NewAddon(folderName, "AceTimer-3.0")


-- Must fit the hardcoded values of Immersion.
local fadeOutTime = 0.2
local fadeInTime = 0.5


function L:OnInitialize()
  self:InitializeSavedVariables()
  self:InitializeOptions()
end




local gossipShowFrame = CreateFrame("Frame")
gossipShowFrame:RegisterEvent("GOSSIP_SHOW")
gossipShowFrame:RegisterEvent("QUEST_COMPLETE")
gossipShowFrame:RegisterEvent("QUEST_DETAIL")
gossipShowFrame:RegisterEvent("QUEST_GREETING")
gossipShowFrame:RegisterEvent("QUEST_PROGRESS")
gossipShowFrame:SetScript("OnEvent", function(_, event)
  -- print("gossipShowFrame", ImmersionFrame:IsShown(), event)

  if not ImmersionFrame or not ImmersionFrame:IsShown() or IsOptionFrameOpen() then return end


  if IEF_Config.hideNpcPortrait then
    
    if ImmersionFrame.TalkBox.PortraitFrame:IsShown() then
      ImmersionFrame.TalkBox.PortraitFrame:Hide()
      ImmersionFrame.TalkBox.MainFrame.Model:Hide()
      ImmersionFrame.TalkBox.MainFrame.Overlay:Hide()

      -- /run print(ImmersionFrame.TalkBox.NameFrame.Name:GetPoint(1))
      ImmersionFrame.TalkBox.NameFrame.Name:SetPoint("TOPLEFT", ImmersionFrame.TalkBox.PortraitFrame.Portrait, "TOPLEFT", 24, -19)
    end
    
  else
  
    if not ImmersionFrame.TalkBox.PortraitFrame:IsShown() then 
      ImmersionFrame.TalkBox.PortraitFrame:Show()
      ImmersionFrame.TalkBox.MainFrame.Model:Show()
      ImmersionFrame.TalkBox.MainFrame.Overlay:Show()
    
      ImmersionFrame.TalkBox.NameFrame.Name:SetPoint("TOPLEFT", ImmersionFrame.TalkBox.PortraitFrame.Portrait, "TOPRIGHT", 2, -19)
    end
    
  end

  -- Immersion always fades the UI to 0.
  IEF_Config.UIParentAlpha = 0
  Addon.HideUI(fadeOutTime, IEF_Config)
end)

local gossipCloseFrame = CreateFrame("Frame")
gossipCloseFrame:RegisterEvent("GOSSIP_CLOSED")
gossipCloseFrame:RegisterEvent("QUEST_FINISHED")
gossipCloseFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
gossipCloseFrame:RegisterEvent("PLAYER_REGEN_DISABLED") -- Entering combat.
gossipCloseFrame:RegisterEvent("PLAYER_REGEN_ENABLED") -- Exiting combat.
gossipCloseFrame:SetScript("OnEvent", function(_, event)
  -- print("gossipCloseFrame", event)

  -- If combat starts and the UI is faded, we show the protected frames again,
  -- just do not raise their opacity yet.
  if event == "PLAYER_REGEN_DISABLED" then
    if ImmersionFrame and ImmersionFrame:IsShown() then
      Addon.ShowUI(0, true)
    end

  -- If combat ends while the UI is faded, we hide the protected frames again.
  elseif event == "PLAYER_REGEN_ENABLED" then
    if ImmersionFrame and ImmersionFrame:IsShown() then
      IEF_Config.UIParentAlpha = 0
      Addon.HideUI(0, IEF_Config)
    end

  else
    if ludius_UiHideModule.addonsHiddenStatus["DynamicCam"] then
      -- Do not show UI.
      ludius_UiHideModule.addonsHiddenStatus[folderName] = false
    else
      Addon.ShowUI(fadeInTime, false)
    end
  end
end)



-- Local flags.
local cinematicRunning = false
local framerateWasShown = false

-- If we somehow missed to show the frames again, we do it here!
local emergencyFrame = CreateFrame("Frame")
emergencyFrame:SetScript("OnUpdate", function()
  -- Uncomment this for debugging.
  -- if not ludius_UiHideModule.uiHiddenTime then return end
  if (not ImmersionFrame or not ImmersionFrame:IsShown())
      and ludius_UiHideModule.uiHiddenTime > 0
      and ludius_UiHideModule.uiHiddenTime < GetTime()
      and not cinematicRunning
      then
    -- print("Emergency show", ludius_UiHideModule.uiHiddenTime)
    if ludius_UiHideModule.addonsHiddenStatus["DynamicCam"] then
      -- Do not show UI.
      ludius_UiHideModule.addonsHiddenStatus[folderName] = false
    else
      Addon.ShowUI(0, false)
    end
  end
end)

local toggleFramerateFrame = CreateFrame("Frame")
toggleFramerateFrame:RegisterEvent("CINEMATIC_START")
toggleFramerateFrame:RegisterEvent("CINEMATIC_STOP")
toggleFramerateFrame:SetScript("OnEvent", function(_, event)
  if event == "CINEMATIC_START" then
    cinematicRunning = true
    if FramerateLabel and FramerateLabel:IsVisible() and IEF_Config.hideFrameRateCinematic then
      framerateWasShown = true
      ToggleFramerate()
    end
  else
    cinematicRunning = false
    if FramerateLabel and not FramerateLabel:IsVisible() and framerateWasShown then
      framerateWasShown = false
      ToggleFramerate()
    end
  end
end)
