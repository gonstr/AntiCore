local addonName, addon = ...

local LSM = LibStub("LibSharedMedia-3.0")

addon = LibStub("AceAddon-3.0"):NewAddon(addon, addonName)

addon.VERSION = GetAddOnMetadata("AntiCore", "Version")
addon.IS_DEV = addon.VERSION == '\@project-version\@'
addon.DEBUG = false

function addon:OnInitialize()
    --LSM:Register("sound", "Anti Spend Holy Power", [[Interface\AddOns\AntiCore\Sounds\SpendPower.ogg]])
    --LSM:Register("sound", "Anti Inquisition Expiring", [[Interface\AddOns\AntiCore\Sounds\InquisitionExpiring.ogg]])
end
