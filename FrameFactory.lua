local addonName, addon = ...

local insert = table.insert

addon.FrameFactoryPrototype = {}

local FrameFactory = addon.FrameFactoryPrototype
FrameFactory.__index = FrameFactory

function FrameFactory:New()
    local instance = setmetatable({}, self)

    instance.framePrototypes = {
        emptyUnitFrame = addon.EmptyUnitFramePrototype,
    }
    
    instance.frames = {}

    return instance
end

function FrameFactory:AcquireFrame(frameType, ...)
    if not self.framePrototypes[frameType] then
        error("Unknown frame type: " .. frameType)
    end

    if not self.frames[frameType] then
        self.frames[frameType] = {}
    end

    local hasFrameArgs = select("#", ...)

    -- We only look for a reused frame if no frame constructor args are passed
    if not hasFrameArgs then    
        for _, frame in ipairs(self.frames[frameType]) do
            if not frame._acquired then
                frame._acquired = true
                frame:GetFrameUnsafe():Show()

                if frame.OnAcquire then
                    frame:OnAcquire()
                end

                return frame
            end
        end
    end

    local frame = self.framePrototypes[frameType]:New(...)

    if not hasFrameArgs then
        insert(self.frames[frameType], frame)
    end
    
    frame._acquired = true

    if frame.OnAcquire then
        frame:OnAcquire()
    end

    function frame:Release()
        self._acquired = false

        if self.OnRelease then
            self:OnRelease()
        end

        -- Reset frame points and parent here cause why not
        self:GetFrameUnsafe():ClearAllPoints()
        self:GetFrameUnsafe():SetParent(nil)

        self:GetFrameUnsafe():Hide()
    end

    return frame
end
