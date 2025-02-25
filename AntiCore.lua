local addonName, addon = ...

local LGF = LibStub("LibGetFrame-1.0")

addon = LibStub("AceAddon-3.0"):NewAddon(addon, addonName, "AceConsole-3.0", "AceEvent-3.0")

addon.VERSION = GetAddOnMetadata("AntiCore", "Version")
addon.IS_DEV = addon.VERSION == '\@project-version\@'
addon.DEBUG = false

-- AceDB defaults
addon.defaults = {
    profile = {
        v1 = {}
    },
}

function addon:OnInitialize()
    self.db = self.db or LibStub("AceDB-3.0"):New(addonName, self.defaults)

    self.utils = self.UtilsPrototype:New()
    self.frameFactory = self.FrameFactoryPrototype:New()

    self.frames = {}
end

function addon:OnEnable()
    self:RegisterChatCommand("anti", "HandleChatCommand")

    self:RegisterMessage("ANTI_REGISTER_UNIT_FRAME_REGION")

    CastingBarFrame:UnregisterAllEvents()
    CastingBarFrame:Hide()
end

function addon:OnDisable()
    self:UnregisterChatCommand("anti")

    self:UnregisterAllMessages()

    for i = #self.frames, 1, -1 do
        self.frames[i]:Release()
        self.frames[i] = nil
    end
end

-- Create a new unit frame from an event
function addon:ANTI_REGISTER_UNIT_FRAME_REGION(_, region, unit)
    -- TODO: Support registering an existing frame
    if self.frames[unit] then
        error("AntiCore does not yet support registering an existing unit frame. unit: " .. unit)
        return
    end

    local frame = self.frameFactory:AcquireFrame("emptyUnitFrame", unit)

    local left, bottom, width, height = region:GetRect()

    frame:SetData(unit, width, height, left, bottom)

    self.frames[unit] = frame

    LGF:ScanForUnitFrames()
end
