
OmniCCDB = {
["profileKeys"] = {
["Mxzq - Golemagg"] = "Default",
["Dopeclaw - Living Flame"] = "Default",
["Poklopac - Thunderstrike"] = "Default",
["Vbank - Celebras"] = "Default",
["Dopesick - Stitches"] = "Default",
["Dopenac - Lone Wolf"] = "Default",
["Dopetrap - Living Flame"] = "Default",
["Dopecure - Stitches"] = "Default",
["Dopemend - Lone Wolf"] = "Default",
["Dopesnare - Stitches"] = "Default",
["Dopecure - Thunderstrike"] = "Default",
["Dopedot - Lone Wolf"] = "Default",
["Dopecoil - Lone Wolf"] = "Default",
["Lonac - Stitches"] = "Default",
["Dopestab - Living Flame"] = "Default",
["Dopebolt - Lone Wolf"] = "Default",
["Battlenac - Celebras"] = "Default",
["Moolatz - Celebras"] = "Default",
["Jutarnjedrvo - Lone Wolf"] = "Default",
["Doperage - Lone Wolf"] = "Default",
["Dopesnare - Living Flame"] = "Default",
["Mq - Celebras"] = "Default",
["Vermins - Stitches"] = "Default",
["Dopeseal - Thunderstrike"] = "Default",
["Doperage - Thunderstrike"] = "Default",
["Dopesnare - Thunderstrike"] = "Default",
["Dopeah - Stitches"] = "Default",
["Battitude - Zandalar Tribe"] = "Default",
["Dopeclaw - Thunderstrike"] = "Default",
["Dopesnare - Lone Wolf"] = "Default",
["Dopede - Stitches"] = "Default",
["Turbonac - Celebras"] = "Default",
["Vermin - Celebras"] = "Default",
["Battlenac - Zandalar Tribe"] = "Default",
["Dopecoil - Thunderstrike"] = "Default",
["Dopebolt - Living Flame"] = "Default",
["Doperage - Living Flame"] = "Default",
["Dopetrap - Lone Wolf"] = "Default",
["Vermin - Zandalar Tribe"] = "Default",
["Dopestab - Lone Wolf"] = "Default",
["Dopemend - Living Flame"] = "Default",
["Dopeclaw - Stitches"] = "Default",
["Dopeclaw - Lone Wolf"] = "Default",
["Jutarnjedrvo - Living Flame"] = "Default",
},
["global"] = {
["dbVersion"] = 6,
["addonVersion"] = "11.2.8",
},
["profiles"] = {
["Default"] = {
["rules"] = {
{
["patterns"] = {
"LossOfControl",
"TotemFrame",
},
["id"] = "Ignore",
["priority"] = 1,
["theme"] = "Ignore",
},
{
["enabled"] = false,
["patterns"] = {
"Aura",
"Buff",
"Debuff",
},
["name"] = "Auras",
["id"] = "auras",
},
{
["enabled"] = false,
["patterns"] = {
"Plate",
},
["name"] = "Unit Nameplates",
["id"] = "plates",
},
{
["enabled"] = false,
["patterns"] = {
"ActionButton",
},
["name"] = "Action Bars",
["id"] = "actions",
},
{
["patterns"] = {
"PlaterMainAuraIcon",
"PlaterSecondaryAuraIcon",
"ExtraIconRowIcon",
},
["id"] = "Plater Nameplates Rule",
["priority"] = 5,
["theme"] = "Plater Nameplates Theme",
},
},
["themes"] = {
["Plater Nameplates Theme"] = {
["textStyles"] = {
["soon"] = {
},
["seconds"] = {
},
["minutes"] = {
},
},
},
["Default"] = {
["textStyles"] = {
["soon"] = {
},
["seconds"] = {
},
["minutes"] = {
},
["charging"] = {
["r"] = 1,
["scale"] = 0.649999976158142,
["g"] = 0.98,
["b"] = 0.4,
},
["controlled"] = {
["scale"] = 1.20000004768372,
},
},
["fontFace"] = "Fonts\\ARIALN.TTF",
["spiralOpacity"] = 1.00999997742474,
["fontSize"] = 16,
},
["Ignore"] = {
["textStyles"] = {
["soon"] = {
},
["seconds"] = {
},
["minutes"] = {
},
["charging"] = {
["r"] = 1,
["scale"] = 0.65,
["g"] = 0.98,
["b"] = 0.4,
},
},
["enableText"] = false,
["spiralOpacity"] = 1,
["minDuration"] = 3,
},
},
},
},
}
OmniCC4Config = {
["groupSettings"] = {
["base"] = {
["enabled"] = true,
["fontSize"] = 18,
["yOff"] = 0,
["effect"] = "pulse",
["scaleText"] = true,
["minEffectDuration"] = 30,
["anchor"] = "CENTER",
["spiralOpacity"] = 1.00999997742474,
["minDuration"] = 2,
["xOff"] = 0,
["tenthsDuration"] = 0,
["fontOutline"] = "OUTLINE",
["minSize"] = 0.5,
["mmSSDuration"] = 0,
["styles"] = {
["seconds"] = {
["a"] = 1,
["r"] = 1,
["scale"] = 1,
["g"] = 1,
["b"] = 0.1,
},
["soon"] = {
["a"] = 1,
["r"] = 1,
["scale"] = 1.5,
["g"] = 0.1,
["b"] = 0.1,
},
["minutes"] = {
["a"] = 1,
["r"] = 1,
["scale"] = 1,
["g"] = 1,
["b"] = 1,
},
["hours"] = {
["a"] = 1,
["r"] = 0.7,
["scale"] = 0.75,
["g"] = 0.7,
["b"] = 0.7,
},
["charging"] = {
["a"] = 0.8,
["r"] = 1,
["scale"] = 0.649999976158142,
["g"] = 0.98,
["b"] = 0.4,
},
["controlled"] = {
["scale"] = 1.20000004768372,
},
},
["fontFace"] = "Fonts\\ARIALN.TTF",
},
["Ignore"] = {
["enabled"] = false,
["styles"] = {
["soon"] = {
["a"] = 1,
["r"] = 1,
["scale"] = 1.5,
["g"] = 0.1,
["b"] = 0.1,
},
["minutes"] = {
["a"] = 1,
["r"] = 1,
["scale"] = 1,
["g"] = 1,
["b"] = 1,
},
["seconds"] = {
["a"] = 1,
["r"] = 1,
["scale"] = 1,
["g"] = 1,
["b"] = 0.1,
},
["hours"] = {
["a"] = 1,
["r"] = 0.7,
["scale"] = 0.75,
["g"] = 0.7,
["b"] = 0.7,
},
["charging"] = {
["a"] = 0.8,
["r"] = 1,
["scale"] = 0.65,
["g"] = 0.98,
["b"] = 0.4,
},
["controlled"] = {
},
},
["fontSize"] = 18,
["effect"] = "pulse",
["fontFace"] = "Fonts\\FRIZQT__.TTF",
["mmSSDuration"] = 0,
["minSize"] = 0.5,
["spiralOpacity"] = 1,
["yOff"] = 0,
["xOff"] = 0,
["tenthsDuration"] = 0,
["fontOutline"] = "OUTLINE",
["anchor"] = "CENTER",
["minEffectDuration"] = 30,
["minDuration"] = 3,
["scaleText"] = true,
},
},
["version"] = "8.1.1",
["engine"] = "AniUpdater",
["groups"] = {
{
["id"] = "Ignore",
["rules"] = {
"LossOfControl",
"TotemFrame",
},
["enabled"] = true,
},
},
}
