local addonName, addon = ...

local AceEvent = LibStub("AceEvent-3.0")

addon.TransparentUnitFramePrototype = {}

local TransparentUnitFrame = addon.TransparentUnitFramePrototype
TransparentUnitFrame.__index = TransparentUnitFrame

function TransparentUnitFrame:New()
    local instance = setmetatable({}, self)

    AceEvent:Embed(instance)

    instance.frame = CreateFrame("Button", nil, UIParent, "SecureUnitButtonTemplate")
    instance.frame:SetFrameStrata("HIGH")
    instance.frame:RegisterForClicks("AnyUp")
    instance.frame:SetAttribute("*type1", "target")
    instance.frame:SetAttribute("*type2", "menu")
	instance.frame.menu = Anti_CompactUnitFrame_OpenMenu

    instance.tainted = false

    return instance
end

function TransparentUnitFrame:GetFrameUnsafe()
    return self.frame
end

function TransparentUnitFrame:SetData(unit, width, height, left, bottom)
    self.unit = unit
    self.width = width
    self.height = height
    self.left = left
    self.bottom = bottom

    self:Update()
end

function TransparentUnitFrame:OnRelease()
    self.unit = nil
    self.width = nil
    self.height = nil
    self.left = nil
    self.bottom = nil

    self.frame:Hide()
end

function TransparentUnitFrame:Update()
    -- Since this frame is secure, there are restictions on how it can be updated. For now we set it as tainted
    -- and only allow configuration once.
    -- TODO: Handle updates with in combat checks, RegisterStateDriver?
    if not self.tainted then
        self.frame.unit = self.unit
        self.frame:SetAttribute("unit", self.unit)
        self.frame:SetSize(self.width, self.height)
        self.frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", self.left, self.bottom)
        
        self.tainted = true
    end
end
