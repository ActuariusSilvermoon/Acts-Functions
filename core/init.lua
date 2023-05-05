-----------------------
----LOCAL VARIABLES----
-----------------------

local ADDON_NAME, namespace = ...;
local functions = {};
local variables = {};
local loadFrame = CreateFrame("FRAME");

--Create a sub-namespace for the global function.
namespace.functions = functions;
namespace.variables = variables;

--Slash command
SLASH_ACTFUNCTIONS1 = "/actfunctions"
SLASH_ACTFUNCTIONS2 = "/act"

SlashCmdList.ACTFUNCTIONS = function(msg)
	msg = string.lower(msg) or "";
	local useString = "";

	if msg == nil or msg == "" then 
		print("No command received.");

		return;
	end

	if string.find(msg, "config") then
		functions.toggleActConfig();

		return;
	end

	if string.find(msg, "print") then
		for key, value in pairs(actSettings) do
			print(key);
			print(value);
		end

		print("");

		return;
	end

	if string.find(msg, "track") then
		local track = UnitCreatureType("target");

		if variables.class == "HUNTER"  then
			functions.hunterTrack(track);
		end

		return;
	end

	if string.find(msg, "mount") then
		useString = functions.getMount();

		if IsMounted() and GetMacroBody(msg):find(useString) then
			Dismount();
			useString = "";
		end
	elseif string.find(msg, "disenchant")then
		useString = functions.disenchantScan();
	elseif string.find(msg, "prospecting") then
		useString  = functions.prospectScan();
	elseif string.find(msg, "milling") then
		useString  = functions.millScan();
	elseif string.find(msg, "lockpicking") then
		useString = functions.itemScan("Lockbox");
	end

	if not (useString == nil or useString == "") then
		EditMacro(msg, nil, nil, GetMacroBody(msg):gsub("(us[e]).*","%1 " .. useString));
	else
		EditMacro(msg, nil, nil, GetMacroBody(msg):gsub("(us[e]).*","%1 "));
	end
end


-----------------------
-----EVENT HANDLING----
-----------------------

loadFrame:RegisterEvent("ADDON_LOADED");
loadFrame:SetScript("OnEvent", function(self, event, ...)
	local arg1,arg2,arg3,arg4 = ...;
    if event == "ADDON_LOADED" and arg1 == "Acts Functions" then
        ------------
        --Settings--
        ------------

		if actSettings == nil then
			actSettings = {};
		end

		if actSettings.minIlvl == nil then
			actSettings.minIlvl = 210;
		end

		if actSettings.deArmor == nil then
			actSettings.deArmor = true;
		end

		if actSettings.deWeapon == nil then
			actSettings.deWeapon = true;
		end

		if actSettings.minQuality == nil then
			actSettings.minQuality = 2;
		end

		if actSettings.maxQuality == nil then
			actSettings.maxQuality = 2;
		end


        ------------
        ---Mounts---
        ------------

		if actCharacterSettings == nil then
			actCharacterSettings = {};
		end

		if actCharacterSettings.ctrlMount == nil then
			actCharacterSettings.ctrlMount = "Grand Expedition Yak";
		end

		if actCharacterSettings.altMount == nil then
			actCharacterSettings.altMount = "Mighty Caravan Brutosaur";
		end

		if actCharacterSettings.shiftMount == nil then
			actCharacterSettings.shiftMount = "Sandstone Drake";
		end

		if actCharacterSettings.dragonFlyingMount == nil then
			actCharacterSettings.dragonFlyingMount = "Renewed Proto-Drake";
		end

		if actCharacterSettings.groundMount == nil then
			actCharacterSettings.groundMount = "Vulpine Familiar";
		end

		if actCharacterSettings.defaultMount == nil then
			actCharacterSettings.defaultMount = "Vulpine Familiar";
		end

		if actCharacterSettings.ctrlMountBool == nil then
			actCharacterSettings.ctrlMountBool = false;
		end

		if actCharacterSettings.altMountBool == nil then
			actCharacterSettings.altMountBool = false;
		end

		if actCharacterSettings.shiftMountBool == nil then
			actCharacterSettings.shiftMountBool = false;
		end

		if actCharacterSettings.dragonFlyingMountBool == nil then
			actCharacterSettings.dragonFlyingMountBool = false;
		end

		if actCharacterSettings.groundMountBool == nil then
			actCharacterSettings.groundMountBool = false;
		end


        ---------------------
        ---Local variables---
        ---------------------

		variables.class = select(2, UnitClass("player"));

		loadFrame:UnregisterEvent("ADDON_LOADED");
	end
end);