local folderName = ...
local L = LibStub("AceAddon-3.0"):GetAddon(folderName)


local defaults = {

  keepAlertFrames        = true,
  keepChatFrame          = true,
  keepPartyRaidFrame     = false,
  keepTrackingBar        = true,
  trackingBarAlpha       = 0.33,

  keepCustomFrames       = false,
  customFramesToKeep     = {
    ["BuffFrame"]    = true,
    ["DebuffFrame"]  = true,
  },

  hideNpcPortrait        = false,
  
  hideFrameRate          = true,
  hideFrameRateCinematic = true,

}


local function ModernizeProfile()
  if not IEF_Config then return end

  if IEF_Config.hideAlertFrame ~= nil then
    IEF_Config.keepAlertFrames = not IEF_Config.hideAlertFrame
    IEF_Config.hideAlertFrame = nil
  end

  if IEF_Config.hideChatFrame ~= nil then
    IEF_Config.keepChatFrame = not IEF_Config.hideChatFrame
    IEF_Config.keepChatFrame = nil
  end

  if IEF_Config.hideTrackingBar ~= nil then
    IEF_Config.keepTrackingBar = not IEF_Config.hideTrackingBar
    IEF_Config.keepTrackingBar = nil
  end
end



local optionsTable = {
  type = 'group',
  args = {

    info = {
      order = 0,
      type = "description",
      name = "Make adjustemts here to chose how additional frames should or should not be hidden during NPC interaction. \nThis only has an effect when you activate \"Hide Interface\" in Immersion's settings.\n\n",
    },

    keepAlertFrames = {
      order = 25,
      type = 'toggle',
      name = "Keep Alert Frames",
      desc = "Check this to see the alert frames (e.g. Covenant Renown or when completing achievements) during Immersion's \"Hide Interface\"!",
      width = 2,
      get = function() return IEF_Config.keepAlertFrames end,
      set = function(_, newValue) IEF_Config.keepAlertFrames = newValue end,
    },

    keepChatFrame = {
      order = 30,
      type = 'toggle',
      name = "Keep Chat Frame",
      desc = "Check this to keep the chat frame during Immersion's \"Hide Interface\"! This allows you to better track your rewards while handing in quests.",
      width = 2,
      get = function() return IEF_Config.keepChatFrame end,
      set = function(_, newValue) IEF_Config.keepChatFrame = newValue end,
    },

    keepPartyRaidFrame = {
      order = 37,
      type = 'toggle',
      name = "Keep Party/Raid Frames",
      desc = "Check this to keep the Party/Raid frame during Immersion's \"Hide Interface\"!",
      width = 2,
      get = function() return IEF_Config.keepPartyRaidFrame end,
      set = function(_, newValue) IEF_Config.keepPartyRaidFrame = newValue end,
    },

    n40 = {order = 40, type = "description", name = " ",},

    keepTrackingBar = {
      order = 50,
      type = 'toggle',
      name = "Keep Tracking Bars",
      desc = "Uncheck this to keep the tracking bars (XP, AP, Reputation) during Immersion's \"Hide Interface\"! This allows you to better track your rewards while handing in quests.",
      width = 2,
      get = function() return IEF_Config.keepTrackingBar end,
      set = function(_, newValue) IEF_Config.keepTrackingBar = newValue end,
    },

    trackingBarAlpha = {
      order = 70,
      type = 'range',
      name = "Tracking bar opacity during NPC intaraction",
      desc = "Only partially fade out the tracking bars. Hovering over them brings them to full opacity.",
      disabled = function() return not IEF_Config.keepTrackingBar end,
      min = .01,
      max = 1,
      step = .01,
      width = "double",
      get = function() return IEF_Config.trackingBarAlpha end,
      set = function(_, newValue) IEF_Config.trackingBarAlpha = newValue end,
    },

    n73 = {order = 73, type = "description", name = " ",},

    keepCustomFrames = {
      order = 74,
      type = 'toggle',
      name = "Keep additional frames",
      desc = "The text box below allows you to define any frame you want to keep during NPC interaction.\n\nUse the console command /fstack to learn the names of frames.\n\nFor example, you may want to keep the buff icons next to the Minimap to be able to dismount during NPC interaction by clicking the appropriate icon.",
      width = 2,
      get = function() return IEF_Config.keepCustomFrames end,
      set = function(_, newValue) IEF_Config.keepCustomFrames = newValue end,
    },
    customFramesToKeep = {
      order = 75,
      type = "input",
      name = "Custom frames to keep",
      desc = "Separated by commas.",
      get =
        function()
          returnString = ""
          for k, _ in pairs(IEF_Config.customFramesToKeep) do
            if returnString ~= "" then
              returnString = returnString .. ", "
            end
            returnString = returnString .. k
          end
          return returnString
        end,
      set =
        function(_, newValue)
          IEF_Config.customFramesToKeep = {}

          newValue = string.gsub(newValue, "%s+", "")
          for k, v in pairs({strsplit(",", newValue)}) do
            -- Not checking if frame exists, because some frames are only created when needed (e.g. DebuffFrame).
            IEF_Config.customFramesToKeep[v] = true
          end
        end,
      disabled = function() return not IEF_Config.keepCustomFrames end,
      multiline = 3,
      width = "double",
    },

    n80 = {order = 80, type = "description", name = " ",},

    hideNpcPortrait = {
      order = 90,
      type = 'toggle',
      name = "Hide NPC Portrait in Immersion Frame",
      desc = "Only show quest text in the Immersion frame. This can help to focus on the NPCs in the game world while interacting with them.",
      width = 2,
      get = function() return IEF_Config.hideNpcPortrait end,
      set = function(_, newValue) IEF_Config.hideNpcPortrait = newValue end,
    },

    n95 = {order = 95, type = "description", name = " ",},

    hideFrameRate = {
      order = 100,
      type = 'toggle',
      name = "Hide Frame Rate during NPC interaction",
      desc = "Check this to hide the frame rate during Immersion's \"Hide Interface\"!",
      width = 2,
      get = function() return IEF_Config.hideFrameRate end,
      set = function(_, newValue) IEF_Config.hideFrameRate = newValue end,
    },
    hideFrameRateCinematic = {
      order = 101,
      type = 'toggle',
      name = "Hide Frame Rate during cinematics",
      desc = "Check this to hide the frame rate while ingame cinematics are playing!",
      width = 1.5,
      get = function() return IEF_Config.hideFrameRateCinematic end,
      set = function(_, newValue) IEF_Config.hideFrameRateCinematic = newValue end,
    },

    nl10 = {order = 110, type = "description", name = "\n\n",},

    restoreDefaults = {
      order = 120,
      type = 'execute',
      name = "Restore defaults",
      desc = "Restore settings to the preference of the developer.",
      width = "normal",
      func = function()
              for k, v in pairs(defaults) do
                IEF_Config[k] = v
              end
            end,
    },

  },
}



function L:InitializeSavedVariables()

  if IEF_Config == nil then
    IEF_Config = {}
  end

  -- Remove keys from previous versions.
  for k, v in pairs(IEF_Config) do
    -- print (k, v)
    if defaults[k] == nil then
      -- print(k, "not in defaults")
      IEF_Config[k] = nil
    end
  end

  -- Set defaults for new key.
  for k, v in pairs(defaults) do
    -- print (k, v)
    if IEF_Config[k] == nil then
      -- print(k, "not there")
      IEF_Config[k] = v
    end
  end

end


function L:InitializeOptions()

  ModernizeProfile()

  LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("Immersion ExtraFade", optionsTable)
  self.optionsMenu = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Immersion ExtraFade", "Immersion ExtraFade")

end

