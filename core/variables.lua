-----------------------
----LOCAL VARIABLES----
-----------------------

local _, namespace = ...;
local functions = namespace.functions;
local variables = namespace.variables;


-----------------------
--VARIABLE DEFINITIONS-
-----------------------

--Item Quality array to be used for disenchant macro.
variables.itemQuality = {
	{
		name = "|cFF00FF00Uncommon|r",
		number = 2
	},
	{
		name = "|cFF0000FFRare|r",
		number = 3
	},
	{
		name = "|cFFA335EEEpic|r",
		number = 4
	}
};

--Array to keep tracking types for hunter tracking macro.
variables.trackingArray = {
	Beast = 0,
	Demon = 0,
	Dragonkin = 0,
	Elemental = 0,
	Giant = 0,
	Humanoid = 0,
	Mechanical = 0,
	Undead = 0
};