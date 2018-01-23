local AddonName, Addon = ...
local AceDB = LibStub("AceDB-3.0")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")

_G[AddonName] = LibStub("AceAddon-3.0"):NewAddon(Addon, AddonName, "AceConsole-3.0")
local Addon = Addon

local OptionTable = {
  name = "CastBarz Options",
  type = "group",
  childGroups = "tab",
  handler = Addon,
  args = {
    player = {
      name = "General",
      type = "group",
      desc = "Enable/Disable",
      args = {
        testMode = {name = "Enable test Mode"},
        width = {
          name = "Width",
          type = "range",
          min = 1,
          softMax = 500,
          step = 1,
          order = 1,
          set = "SetWidth",
          get = "GetWidth",
          width = "full"
        },
        height = {
          name = "Height",
          type = "range",
          min = 0,
          softMax = 50,
          step = 1,
          order = 2,
          set = "SetHeight",
          get = "GetHeight",
          width = "full"
        },
        xoffset = {
          name = "X offset",
          type = "range",
          softMin = -2000,
          softMax = 2000,
          step = 1,
          order = 3,
          set = "SetXOffset",
          get = "GetXOffset",
          width = "double"
        },
        yoffset = {
          name = "Y offet",
          type = "range",
          softMin = -2000,
          softMax = 2000,
          step = 1,
          order = 4,
          set = "SetYOffset",
          get = "GetYOffset",
          width = "double"
        }
      }
    }
  }
}

local defaults = {
  profile = {
    player = {
      show_name = true,
      show_timer = true,
      show_latency = true,
      status_bar_texture = "",
      status_bar_color = {r = 0, g = 0.4, b = 0.8, a = 1},
      background_color = {r = 0, g = 0, b = 0, a = 1},
      width = 220,
      height = 24,
      xoffset = 0,
      yoffset = 190
    }
  }
}

function Addon:OnInitialize()
  _G.CastingBarFrame:UnregisterAllEvents()

  self.db = AceDB:New(AddonName .. "DB", defaults)
  AceConfigRegistry:RegisterOptionsTable("CastBarz", OptionTable)
  self:RegisterChatCommand("Castbarz", "ChatCommand")
  self.testMode = false

  if LoadAddOn("GuemUI_Config") then
  end
end

function Addon:OnEnable()
  self.player = self:CreateCastingBar3D("player")
end

function Addon:ChatCommand(input)
  LibStub("AceConfigCmd-3.0").HandleCommand(Addon, "Castbarz", "CastBarz", input)
end

-- Callbacks only support player castbar right now

function Addon:SetWidth(info, value)
  self.db.profile.player.width = value
  self.player:SetWidth(value)
end

function Addon:SetHeight(info, value)
  self.db.profile.player.height = value
  self.player:SetHeight(value)
end

function Addon:SetXOffset(info, value)
  self.db.profile.player.xoffset = value
  point, relativeTo, relativePoint, _, yOfs = self.player:GetPoint()
  self.player:SetPoint(point, relativeTo, relativePoint, value, yOfs)
end

function Addon:SetYOffset(info, value)
  self.db.profile.player.yoffset = value
  point, relativeTo, relativePoint, xOfs = self.player:GetPoint()
  self.player:SetPoint(point, relativeTo, relativePoint, xOfs, value)
end

function Addon:GetWidth(info)
  return self.db.profile.player.width
end

function Addon:GetHeight(info)
  return self.db.profile.player.height
end

function Addon:GetXOffset(info)
  return self.db.profile.player.xoffset
end

function Addon:GetYOffset(info)
  return self.db.profile.player.yoffset
end
