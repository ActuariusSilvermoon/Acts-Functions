-----------------------
----LOCAL VARIABLES----
-----------------------

local ADDON_NAME, namespace = ...;
local functions = namespace.functions;
local variables = namespace.variables;
local loadFrame = CreateFrame("FRAME");


-----------------------
--FUNCTION DEFINITIONS-
-----------------------

--Fill tracking array.
local function fillTrackingArray()
	for i = 1 , C_Minimap.GetNumTrackingTypes() do
		local name, _, _, category = C_Minimap.GetTrackingInfo(i);
		local s1, type, _ = strsplit(" ", name, 3);

		if
			category == "spell" and
			s1 == "Track" and
			type ~= nil
		then
			if string.match(type, "s", -1) then
				type = type:sub(1, -2);
			end

			table.foreach(
				variables.trackingArray,
				function(key, value)
					if key == type and value ~= i then
						variables.trackingArray[key] = i;
					end
				end
			);
		end
	end
end


-----------------------
-----EVENT HANDLING----
-----------------------

loadFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
loadFrame:SetScript("OnEvent", function(_, event, _)
	if event == "PLAYER_ENTERING_WORLD" then
		fillTrackingArray();

		loadFrame:UnregisterEvent("PLAYER_ENTERING_WORLD");
	end
end);