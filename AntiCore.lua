local addonName, addon = ...

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
    self:RegisterMessage("ANTI_CORE_REGISTER_UNIT_FRAME_REGION")
    self:RegisterChatCommand("anti", "HandleChatCommand")

    CastingBarFrame:UnregisterAllEvents()
    CastingBarFrame:Hide()
end

function addon:OnDisable()
    self:UnregisterMessage("ANTI_CORE_REGISTER_UNIT_FRAME_REGION")
    self:UnregisterChatCommand("anti")

    for i = #self.frames, 1, -1 do
        self.frames[i]:Release()
        self.frames[i] = nil
    end
end

function addon:ANTI_CORE_REGISTER_UNIT_FRAME_REGION(_, region, unit)
    -- TODO: Support registering an existing frame
    if self.frames[unitId] then
        error("AntiCore does not yet support registering an existing unit frame. unit: " .. unit)
        return
    end

    local frame = self.frameFactory:AcquireFrame("transparentUnitFrame")

    local width, height = region:GetSize()
    local left, bottom = region:GetRect()

    print(unit, width, height, left , bottom)
    frame:SetData(unit, width, height, left, bottom)

    self.frames[unit] = frame
end
