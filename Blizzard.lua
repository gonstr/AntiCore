-- Blizzard_UnitFrame/CompactUnitFrame.lua:175
function Anti_CompactUnitFrame_OpenMenu(self)
	local unit = self.unit;
	if ( not unit ) then
		return;
	end
	local which;
	local name;
	if ( UnitIsUnit(unit, "player") ) then
		which = "SELF";
	elseif ( UnitIsUnit(unit, "vehicle") ) then
		-- NOTE: vehicle check must come before pet check for accuracy's sake because
		-- a vehicle may also be considered your pet
		which = "VEHICLE";
	elseif ( UnitIsUnit(unit, "pet") ) then
		which = "PET";
	elseif ( UnitIsPlayer(unit) ) then
		if ( UnitInRaid(unit) ) then
			which = "RAID_PLAYER";
		elseif ( UnitInParty(unit) ) then
			which = "ANTI_PARTY";
		else
			which = "ANTI_PLAYER";
		end
	else
		which = "TARGET";
		name = RAID_TARGET_ICON;
	end
	if ( which ) then
		local contextData = 
		{
			unit = unit,
			name = name,
		};
		UnitPopup_OpenMenu(which, contextData);
	end
end

-- Blizzard_UnitPopupShared/UnitPopupSharedMenus.lua:146
AntiUnitPopupMenuPlayer = CreateFromMixins(UnitPopupTopLevelMenuMixin)
UnitPopupManager:RegisterMenu("ANTI_PLAYER", AntiUnitPopupMenuPlayer);
function AntiUnitPopupMenuPlayer:GetEntries()
	return {
		UnitPopupMenuFriendlyPlayer, -- Submenu
		UnitPopupRafSummonButtonMixin,
		UnitPopupRafGrantLevelButtonMixin,
		UnitPopupMenuFriendlyPlayerInviteOptions, -- Submenu
		UnitPopupMenuFriendlyPlayerInteract, -- Submenu
		UnitPopupOtherSubsectionTitle,
		UnitPopupVoiceChatButtonMixin, 
		UnitPopupMovePlayerFrameButtonMixin,
		UnitPopupMoveTargetFrameButtonMixin,
		UnitPopupEnterEditModeMixin,
		UnitPopupReportInWorldButtonMixin,
		-- UnitPopupCopyCharacterNameButtonMixin, -- Copy character name is protected and can only be called from Blizz code?
	}
end

-- Custom, but source is Blizzard_UnitPopup/UnitPopupMenus.lua:28
AntiUnitPopupMenuParty = CreateFromMixins(UnitPopupTopLevelMenuMixin)
UnitPopupManager:RegisterMenu("ANTI_PARTY", AntiUnitPopupMenuParty);
function AntiUnitPopupMenuParty:GetEntries()
	return {
		UnitPopupMenuFriendlyPlayer, --This is a submenu
		UnitPopupRafSummonButtonMixin,
		UnitPopupRafGrantLevelButtonMixin,
		UnitPopupPromoteButtonMixin,
		UnitPopupPromoteGuideButtonMixin,
		UnitPopupLootPromoteButtonMixin,
		UnitPopupMenuFriendlyPlayerInteract, --This is a submenu
		UnitPopupOtherSubsectionTitle,
		UnitPopupVoiceChatButtonMixin, 
		UnitPopupMovePlayerFrameButtonMixin,
		UnitPopupMoveTargetFrameButtonMixin,
		UnitPopupReportGroupMemberButtonMixin,
		UnitPopupPvpReportGroupMemberButtonMixin,
		-- UnitPopupCopyCharacterNameButtonMixin, -- Copy character name is protected and can only be called from Blizz code?
		UnitPopupPvpReportAfkButtonMixin,
		UnitPopupVoteToKickButtonMixin,
		UnitPopupUninviteButtonMixin,
		UnitPopupCancelButtonMixin,
	}
end
