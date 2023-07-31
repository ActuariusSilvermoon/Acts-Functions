-----------------------
----LOCAL VARIABLES----
-----------------------

local _, namespace = ...;
local functions = namespace.functions;
local variables = namespace.variables;
local actConfigWindow = CreateFrame("FRAME", "ActConfigWindow", UIParent);
local loadFrame = CreateFrame("FRAME");


-----------------------
--FUNCTION DEFINITIONS-
-----------------------

--Check button factory.
local function createCheckbutton(anchor, name, parent, x_loc, y_loc, displayname, tooltip)
	local checkbutton = CreateFrame("CheckButton", name, parent, "ChatConfigCheckButtonTemplate");
	checkbutton:SetPoint(anchor, x_loc, y_loc);
	_G[checkbutton:GetName() .. "Text"]:SetText(displayname);
	checkbutton.tooltip = tooltip;

	return checkbutton;
end

--Quality dropdown factory
local function qualityDropDownFactory(frame, frameDropDown, x_loc, y_loc, title)
	frame:SetPoint("TOPLEFT", x_loc, y_loc);
	frame:SetSize(100, 200);

	frame.dropDown = frameDropDown;
	frame.dropDown:SetPoint("CENTER", frame, "CENTER", 0, -20);

	frame.dropDown.displayMode = "MENU";
	UIDropDownMenu_SetText(frame.dropDown, title);

	frame.dropDown.onClick = function(self, _)
		frame.dropDown.quality = self.value;
	end

	frame.dropDown.initialize = function(self, level)
		local info = UIDropDownMenu_CreateInfo();

		for i = 1, #variables.itemQuality do
			local item = variables.itemQuality[i];
			info.text = item.name;
			info.func = self.onClick;
			info.value = item.number;
			info.checked = info.value == frame.dropDown.quality;
			UIDropDownMenu_AddButton(info, level);
		end
	end
end

--Function for creating the roll setting frames.
local function editBoxFactory(frame, frameEditbox, x, y, title)
	frame:SetPoint("TOPLEFT", actConfigWindow, "TOPLEFT", x, y);
	frame:SetSize(100,200);

	--Create and set title of the setting.
	frame.title = frame:CreateFontString(nil,"OVERLAY");
	frame.title:SetFontObject("GameFontHighLight");
	frame.title:SetPoint("CENTER", frame, "CENTER", 0, 5);
	frame.title:SetText(title);

	--Create the editbox for the setting.
	frame.editBox = frameEditbox;
	frame.editBox:SetPoint("CENTER", frame, "CENTER", 0, -15);
	frame.editBox:SetSize(40,40);
	frame.editBox:SetAutoFocus(false);
	frame.editBox:SetFontObject("GameFontHighLight");
	frame.editBox:SetNumeric(true);
	frame.editBox:SetMaxLetters(4);
end

--Function for creating the mount setting frames.
local function mountEditBoxFactory(frame, frameEditbox, x, y, title, checkName, withCheckButton)
	frame:SetPoint("TOPLEFT", actConfigWindow, "TOPLEFT", x, y);
	frame:SetSize(100,200);

	--Create and set title of the setting.
	frame.title = frame:CreateFontString(nil,"OVERLAY");
	frame.title:SetFontObject("GameFontHighLight");
	frame.title:SetPoint("CENTER", frame, "CENTER", 0, 5);
	frame.title:SetText(title);

	--Create the editbox for the setting.
	frame.editBox = frameEditbox;
	frame.editBox:SetPoint("CENTER", frame, "CENTER", 0, -15);
	frame.editBox:SetSize(130,20);
	frame.editBox:SetAutoFocus(false);
	frame.editBox:SetFontObject("GameFontHighLight");

	frame.editBox:SetScript("OnEnterPressed", function(self)
		frame.editBox.mountIdentification = frame.editBox:GetText();

		frame.editBox:ClearFocus();
	end);

	if withCheckButton then
		local checkbutton = CreateFrame("CheckButton", checkName, frame, "ChatConfigCheckButtonTemplate");
		checkbutton:SetPoint("LEFT", frame, "LEFT", -42, -15);
		checkbutton.tooltip = "Enable/Disable this setting.";
	end
end

--Updating the config windows values.
local function updateConfigWindow()
	actConfigWindow.minIlvl.editBox:SetNumber(actSettings.minIlvl)
	actConfigWindow.minQuality.dropDown.quality = actSettings.minQuality;
	actConfigWindow.maxQuality.dropDown.quality = actSettings.maxQuality;

	actConfigWindow.ctrlMount.editBox.mountIdentification = actSettings.ctrlMount;
	actConfigWindow.altMount.editBox.mountIdentification = actSettings.altMount;
	actConfigWindow.shiftMount.editBox.mountIdentification = actSettings.shiftMount;
	actConfigWindow.dragonFlyingMount.editBox.mountIdentification = actSettings.dragonFlyingMount;
	actConfigWindow.groundMount.editBox.mountIdentification = actSettings.groundMount;
	actConfigWindow.defaultMount.editBox.mountIdentification = actSettings.defaultMount;

	_G["actDeArmor"]:SetChecked(actSettings.deArmor);
	_G["actDeWeapon"]:SetChecked(actSettings.deWeapon);

	_G["actCtrlMount"]:SetChecked(actCharacterSettings.ctrlMountBool);
	_G["actAltMount"]:SetChecked(actCharacterSettings.altMountBool);
	_G["actShiftMount"]:SetChecked(actCharacterSettings.shiftMountBool);
	_G["actDragonflyingMount"]:SetChecked(actCharacterSettings.dragonFlyingMountBool);
	_G["actGroundMount"]:SetChecked(actCharacterSettings.groundMountBool);

	actConfigWindow.ctrlMount.editBox:SetText(actCharacterSettings.ctrlMount);
	actConfigWindow.altMount.editBox:SetText(actCharacterSettings.altMount);
	actConfigWindow.shiftMount.editBox:SetText(actCharacterSettings.shiftMount);
	actConfigWindow.dragonFlyingMount.editBox:SetText(actCharacterSettings.dragonFlyingMount);
	actConfigWindow.groundMount.editBox:SetText(actCharacterSettings.groundMount);
	actConfigWindow.defaultMount.editBox:SetText(actCharacterSettings.defaultMount);
end

--Function for saving data from config window and closing it.
local function saveData()
	local minIlvl = actConfigWindow.minIlvl.editBox:GetNumber();
	local minQuality = actConfigWindow.minQuality.dropDown.quality;
	local maxQuality = actConfigWindow.maxQuality.dropDown.quality;

	local ctrlMount = actConfigWindow.ctrlMount.editBox.mountIdentification;
	if not (ctrlMount == nil or ctrlMount == 0) then
		actCharacterSettings.ctrlMount = ctrlMount;
	end

	local altMount = actConfigWindow.altMount.editBox.mountIdentification;
	if not (altMount == nil or altMount == 0) then
		actCharacterSettings.altMount = altMount;
	end

	local shiftMount = actConfigWindow.shiftMount.editBox.mountIdentification;
	if not (shiftMount == nil or shiftMount == 0) then
		actCharacterSettings.shiftMount = shiftMount;
	end

	local dragonFlyingMount = actConfigWindow.dragonFlyingMount.editBox.mountIdentification;
	if not (dragonFlyingMount == nil or dragonFlyingMount == 0) then
		actCharacterSettings.dragonFlyingMount = dragonFlyingMount;
	end

	local groundMount = actConfigWindow.groundMount.editBox.mountIdentification;
	if not (groundMount == nil or groundMount == 0) then
		actCharacterSettings.groundMount = groundMount;
	end

	local defaultMount = actConfigWindow.defaultMount.editBox.mountIdentification;
	if not (defaultMount == nil or defaultMount == 0) then
		actCharacterSettings.defaultMount = defaultMount;
	end

	if
		minIlvl == 0 or
		minQuality == 0 or
		maxQuality == 0 or
		minQuality > maxQuality
	then
		print("Error, invalid values");

		return;
	end

	actSettings.minIlvl = minIlvl;
	actSettings.minQuality = minQuality;
	actSettings.maxQuality = maxQuality;
	actSettings.deArmor = _G["actDeArmor"]:GetChecked();
	actSettings.deWeapon = _G["actDeWeapon"]:GetChecked();

	SetCVar("ActionButtonUseKeyDown", actCharacterSettings.castOnPressDown);

	actCharacterSettings.ctrlMountBool = _G["actCtrlMount"]:GetChecked();
	actCharacterSettings.altMountBool = _G["actAltMount"]:GetChecked();
	actCharacterSettings.shiftMountBool = _G["actShiftMount"]:GetChecked();
	actCharacterSettings.dragonFlyingMountBool = _G["actDragonflyingMount"]:GetChecked();
	actCharacterSettings.groundMountBool = _G["actGroundMount"]:GetChecked();
end

--Function for resetting values to default.
local function setValuesToDefault()
	actConfigWindow.minIlvl.editBox:SetNumber(210);
	actConfigWindow.minQuality.dropDown.quality = 2;
	actConfigWindow.maxQuality.dropDown.quality = 2;

	_G["actDeArmor"]:SetChecked(false);
	_G["actDeWeapon"]:SetChecked(false);

	_G["actAltMount"]:SetChecked(false);
	_G["actCtrlMount"]:SetChecked(false);
	_G["actShiftMount"]:SetChecked(false);
	_G["actDragonflyingMount"]:SetChecked(false);
	_G["actGroundMount"]:SetChecked(false);

	actConfigWindow.ctrlMount.editBox:SetText("");
	actConfigWindow.altMount.editBox:SetText("");
	actConfigWindow.shiftMount.editBox:SetText("");
	actConfigWindow.dragonFlyingMount.editBox:SetText("");
	actConfigWindow.groundMount.editBox:SetText("");
	actConfigWindow.defaultMount.editBox:SetText("");
end


-----------------------
-----EVENT HANDLING----
-----------------------

loadFrame:RegisterEvent("ADDON_LOADED");
loadFrame:SetScript("OnEvent", function(_, event, ...)
	local addonName, _ = ...;
	if event == "ADDON_LOADED" and addonName == "Acts Functions" then
		updateConfigWindow();
		loadFrame:UnregisterEvent("ADDON_LOADED");
	end
end);


-----------------------
-----CONFIG WINDOW-----
-----------------------

--Add config to standard wow interface window.
local category = Settings.RegisterCanvasLayoutCategory(actConfigWindow, "Act's Functions");
Settings.RegisterAddOnCategory(category);

--Create DE checkboxes.
createCheckbutton("TOPLEFT", "actDeArmor", actConfigWindow, 12, -30, "Toggle Armor Disenchant", "If checked the addon will DE armor.");
createCheckbutton("TOPLEFT", "actDeWeapon", actConfigWindow, 12, -60, "Toggle Weapon Disenchant", "If checked the addon will DE weapons.");

--Create frames to hold the minIlvl setting.
actConfigWindow.minIlvl = CreateFrame("Frame", nil, actConfigWindow);
actConfigWindow.minIlvl.editBox = CreateFrame("EditBox", nil, actConfigWindow.minIlvl, "InputBoxTemplate");
editBoxFactory(actConfigWindow.minIlvl, actConfigWindow.minIlvl.editBox, 25, -10, "Min ilvl for DE:");

--Create quality dropdowns
actConfigWindow.minQuality = CreateFrame("frame", nil, actConfigWindow);
actConfigWindow.minQuality.dropDown = CreateFrame("frame", nil, actConfigWindow.minQuality, "UiDropDownMenuTemplate");
qualityDropDownFactory(actConfigWindow.minQuality, actConfigWindow.minQuality.dropDown, -35, -45, "Minimum Quality");

actConfigWindow.maxQuality = CreateFrame("frame", nil, actConfigWindow);
actConfigWindow.maxQuality.dropDown = CreateFrame("frame", nil, actConfigWindow.maxQuality, "UiDropDownMenuTemplate");
qualityDropDownFactory(actConfigWindow.maxQuality, actConfigWindow.maxQuality.dropDown, -35, -85, "Maximum Quality");

--Create mount editboxes

actConfigWindow.ctrlMount = CreateFrame("Frame", nil, actConfigWindow);
actConfigWindow.ctrlMount.editBox = CreateFrame("EditBox", nil, actConfigWindow.ctrlMount, "InputBoxTemplate");
mountEditBoxFactory(
	actConfigWindow.ctrlMount,
	actConfigWindow.ctrlMount.editBox,
	45,
	-130,
	"CTRL Mount:",
	"actCtrlMount",
	true
);

actConfigWindow.altMount = CreateFrame("Frame", nil, actConfigWindow);
actConfigWindow.altMount.editBox = CreateFrame("EditBox", nil, actConfigWindow.altMount, "InputBoxTemplate");
mountEditBoxFactory(
	actConfigWindow.altMount, 
	actConfigWindow.altMount.editBox,
	45,
	-170,
	"ALT Mount:",
	"actAltMount",
	true
);

actConfigWindow.shiftMount = CreateFrame("Frame", nil, actConfigWindow);
actConfigWindow.shiftMount.editBox = CreateFrame("EditBox", nil, actConfigWindow.shiftMount, "InputBoxTemplate");
mountEditBoxFactory(
	actConfigWindow.shiftMount,
	actConfigWindow.shiftMount.editBox,
	45,
	-210,
	"SHIFT Mount:",
	"actShiftMount",
	true
);

actConfigWindow.dragonFlyingMount = CreateFrame("Frame", nil, actConfigWindow);
actConfigWindow.dragonFlyingMount.editBox = CreateFrame("EditBox", nil, actConfigWindow.dragonFlyingMount, "InputBoxTemplate");
mountEditBoxFactory(
	actConfigWindow.dragonFlyingMount,
	actConfigWindow.dragonFlyingMount.editBox,
	45,
	-250,
	"Dragonflying Mount:",
	"actDragonflyingMount",
	true
);

actConfigWindow.groundMount = CreateFrame("Frame", nil, actConfigWindow);
actConfigWindow.groundMount.editBox = CreateFrame("Editbox", nil, actConfigWindow.groundMount, "InputBoxTemplate");
mountEditBoxFactory(
	actConfigWindow.groundMount,
	actConfigWindow.groundMount.editBox,
	45,
	-290,
	"Ground Mount:",
	"actGroundMount",
	true
);

actConfigWindow.defaultMount = CreateFrame("Frame", nil, actConfigWindow);
actConfigWindow.defaultMount.editBox = CreateFrame("EditBox", nil, actConfigWindow.defaultMount, "InputBoxTemplate");
mountEditBoxFactory(
	actConfigWindow.defaultMount,
	actConfigWindow.defaultMount.editBox,
	45,
	-330,
	"Default Mount:",
	"actDefaultMount"
);


--Create and set title of the setting.
actConfigWindow.title = actConfigWindow:CreateFontString(nil,"OVERLAY");
actConfigWindow.title:SetFontObject("GameFontNormalLarge");
actConfigWindow.title:SetPoint("TOPLEFT", actConfigWindow, "TOPLEFT", 15, -5);
actConfigWindow.title:SetText(GetAddOnMetadata("Acts Functions", "Title") .. " version: " .. GetAddOnMetadata("Acts Functions", "Version"));

actConfigWindow:Hide();
actConfigWindow:SetScript("OnShow", function(_) updateConfigWindow(); end);
actConfigWindow:SetScript("OnHide", function(_) saveData(); end);


-----------------------
---GLOBAL FUNCTIONS----
-----------------------

--Create a "global" config toggle function so the settings window can be opened from the init.lua file code.
function functions.toggleActConfig()
	Settings.OpenToCategory(category:GetID());
end