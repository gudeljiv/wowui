
OmniCCDB = {
["profileKeys"] = {
["Dopeclaw - Lone Wolf"] = "Default",
["Jutarnjedrvo - Lone Wolf"] = "Default",
["Dopesick - Stitches"] = "Default",
["Dopenac - Lone Wolf"] = "Default",
["Dopede - Stitches"] = "Default",
["Vermins - Stitches"] = "Default",
["Dopecure - Stitches"] = "Default",
["Dopemend - Lone Wolf"] = "Default",
["Battitude - Zandalar Tribe"] = "Default",
["Dopesnare - Stitches"] = "Default",
["Vermin - Zandalar Tribe"] = "Default",
["Dopedot - Lone Wolf"] = "Default",
["Battlenac - Zandalar Tribe"] = "Default",
["Mxzq - Golemagg"] = "Default",
["Dopecoil - Lone Wolf"] = "Default",
["Dopesnare - Lone Wolf"] = "Default",
["Lonac - Stitches"] = "Default",
["Doperage - Lone Wolf"] = "Default",
["Dopestab - Lone Wolf"] = "Default",
["Dopeah - Stitches"] = "Default",
["Dopeclaw - Stitches"] = "Default",
["Dopebolt - Lone Wolf"] = "Default",
["Dopetrap - Lone Wolf"] = "Default",
},
["global"] = {
["dbVersion"] = 6,
["addonVersion"] = "10.2.9",
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
["fontSize"] = 16,
["spiralOpacity"] = 1.00999997742474,
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
