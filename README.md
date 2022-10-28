<p><span style="font-size: 18px;"><strong>Description</strong></span></p>
<p>Act's functions is a simple Addon that allows for creation of handy macroes that each time you click will perform an action.</p>
<p>The macroes are as follows:</p>
<p><strong>Disenchant:</strong></p>
<p><strong>The macro has to be named "disenchant" for this to work.</strong></p>
<p>#showtooltip<br />/cast disenchant<br />/actfunctions disenchant<br />/use</p>
<p>Once clicked the addon will edit the use part of the macro to the location of the first item that fits the parameters set in the addon settings (see settings section further down).</p>
<p><strong>Prospecting:</strong></p>
<p><strong>The macro has to be named "prospecting" for this to work.</strong></p>
<p>#showtooltip<br />/cast prospecting<br />/actfunctions prospecting<br />/use</p>
<p>Once clicked this will also edit the use part of the macro to the first stack of ores in the users bags. Currently it looks for any stack of ore that has 5 or more items.</p>
<p><strong>Lockpicking:</strong></p>
<p><strong>The macro has to be named "lockpicking" for this to work.</strong></p>
<p>#showtooltip <br />/cast pick lock<br />/actfunctions lockpicking<br />/use</p>
<p>This also changes the use section of the macro, but the scan functionality of this function looks for any item with the string "Lockbox" in their name.</p>
<p><strong>Note:</strong> if any of the macroes does not find any item matching their searches, the addon will blank out the use part of the macro, and print out an error message.</p>
<p><strong>Tracking:</strong></p>
<p><strong>Can be named whatever</strong></p>
<p>/actfunctions track</p>
<p>This macro will toggle tracking of the creature you are currently targeting. Meaning if you target a beast it will track beasts, a player/humanoid it will track humanoids and so on. If you currently do not have a target it will clear all tracking, and if you use the macro on a mob type you are already tracking, it will untrack that type.</p>
<p><strong>Note:</strong>This only works for hunter's naturally.</p>
<p><strong>Mounting:</strong></p>
<p><strong>Can be named whatever</strong></p>
<p>/actfunctions mount</p>
<p>This macro will summon a mount based on current key modifiers. The mounts that can be summoned can be edited from the config window.</p>
<p><span style="font-size: 18px;"><strong>Settings:</strong></span></p>
<p>You can find the settings under the addon tab in the wow interface settings menu.</p>
<p>Here you can set the minimum ilvl of the item to DE, the minimum quality of the item (Uncommon, Rare or Epic) and the max quality of the item (Uncommon, Rare or Epic). You can also make it not disenchant weapons or armor pieces.</p>
<p>The mounts used for the mount macro is also set here, write in the name of the mount as it stands in the mount journal and press enter. If you typed it correctly you should be able to press save and have it be set to that. Otherwise the addon will tell you in the default chat pane that the name was invalid.</p>
