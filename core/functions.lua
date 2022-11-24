-----------------------
----LOCAL VARIABLES----
-----------------------


local ADDON_NAME, namespace = ...;
local functions = namespace.functions;
local variables = namespace.variables;


-----------------------
--FUNCTION DEFINITIONS-
-----------------------

--Mount function
function functions.getMount()
	if
		IsControlKeyDown() and
		actCharacterSettings.ctrlMountBool
	then
		return actCharacterSettings.ctrlMount;

	elseif
		IsAltKeyDown() and
		actCharacterSettings.altMountBool
	then
		return actCharacterSettings.altMount;

	elseif
		IsShiftKeyDown() and
		actCharacterSettings.shiftMountBool
	then
		return actCharacterSettings.shiftMount;

	elseif
		variables.dragonFlyingZones[C_Map.GetBestMapForUnit("player")] and
		actCharacterSettings.dragonFlyingMountBool
	then
		return actCharacterSettings.dragonFlyingMount;

	elseif
		not IsFlyableArea() and
		actCharacterSettings.groundMountBool
	then
		return actCharacterSettings.groundMount;

    else
		return actCharacterSettings.defaultMount;
	end
end

--Function for finding items to disenchant, they have to be disenchantable and over ilvl 230.
function functions.disenchantScan()
	for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
		for slot = 1, C_Container.GetContainerNumSlots(bag) do
			local itemTable = {GetItemInfo(C_Container.GetContainerItemLink(bag, slot) or 0)}

			if itemTable[4] then
				if
					itemTable[4] > actSettings.minIlvl and
					itemTable[3] >= actSettings.minQuality and
					itemTable[3] <= actSettings.maxQuality and
					(itemTable[6] == "Weapon" and actSettings.deWeapon) or (itemTable[6] =="Armor" and actSettings.deArmor)
				then
					print(C_Container.GetContainerItemLink(bag, slot));
					return bag .. " " .. slot;
				end
			end
		end
	end
end

--Function for finding ores in the bag and check if there's 5 or more of it.
function functions.prospectScan()
	for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
		for slot = 1, C_Container.GetContainerNumSlots(bag) do
			local itemTable = {GetItemInfo(C_Container.GetContainerItemLink(bag, slot) or 0)}

			if itemTable[7] == "Metal & Stone" and select(2, C_Container.GetContainerItemInfo(bag,slot)) >= 5 then
				print(C_Container.GetContainerItemLink(bag, slot));
				return bag .. " " .. slot;
			end
		end
	end
end

--Function for finding ores in the bag and check if there's 5 or more of it.
function functions.millScan()
	for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
		for slot = 1, C_Container.GetContainerNumSlots(bag) do
			local itemTable = {GetItemInfo(C_Container.GetContainerItemLink(bag, slot) or 0)}

			if itemTable[7] == "Herb" and select(2, C_Container.GetContainerItemInfo(bag, slot)) >= 5 then
				print(C_Container.GetContainerItemLink(bag, slot));
				return bag .. " " .. slot;
			end
		end
	end
end

--Itemscanner function to check if there is an item in the bags that contains given string.
function functions.itemScan(name)
	for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
		for slot = 1, C_Container.GetContainerNumSlots(bag) do
			local itemName = C_Container.GetContainerItemLink(bag, slot);

			if itemName and string.find(itemName, name) then
				print(C_Container.GetContainerItemLink(bag, slot));
				return bag .. " " .. slot;
			end
		end
	end
end

--Hunter tracking function.
function functions.hunterTrack(track)
	if track ~= nil then
		local id = variables.trackingArray[track];

		if id ~= nil then
			local trackingInfo = {C_Minimap.GetTrackingInfo(id)};

			C_Minimap.SetTracking(id, not trackingInfo[3]);
		end
	else
		table.foreach(
			variables.trackingArray,
			function(key, value)
				C_Minimap.SetTracking(value, false);
			end
		);
	end
end