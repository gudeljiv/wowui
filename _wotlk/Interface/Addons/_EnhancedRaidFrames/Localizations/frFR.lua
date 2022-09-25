-- Enhanced Raid Frames is a World of Warcraft® user interface addon.
-- Copyright (c) 2017-2021 Britt W. Yazel
-- This code is licensed under the MIT license (see LICENSE for details)

local L = LibStub("AceLocale-3.0"):NewLocale("EnhancedRaidFrames", "frFR", false)

if not L then return end

--[[Translation missing --]]
L["Aborting."] = "Aborting."
L["Animations"] = "Animations"
L["Attached to Cursor"] = "Attaché au curseur"
L["Aura Watch List"] = "Liste de surveillance d'aura"
L["auras_desc"] = "La liste des buffs, debuffs, et/ou caractères génériques à regarder dans cette position"
L["auras_usage"] = "N'importe quel nom d'aura ou d'ID de sort trouvé dans le jeu, épelé correctement, devrait fonctionner"
L["Background Opacity"] = "Opacité du fond"
L["backgroundAlpha_desc"] = "Le pourcentage d'opacité du fond du cadre de raid"
L["Blizzard Default"] = "Défaut Blizzard"
L["blizzardRaidOptionsButton_desc"] = "Lancez le menu de configuration de l'interface des profils de raid intégré"
L["Bottom Center"] = "En bas au centre"
L["Bottom Left"] = "En bas à gauche"
L["Bottom Right"] = "En bas à droite"
L["Color"] = "Couleur"
L["Color By Debuff Type"] = "Couleur par type de debuff"
L["Color By Remaining Time"] = "Couleur par temps restant"
L["colorByDebuff_desc"] = "Couleur déterminé par type de debuff"
L["colorByTime_desc"] = "Couleur déterminé par le temps restant"
L["colorByTime_high_desc"] = "Le temps (en secondes) pour la limite supérieure"
L["colorByTime_low_desc"] = "Le temps (en secondes) pour la limite inférieure"
L["colorOverride_desc"] = "Cela va outrepasser les couleurs régulières"
--[[Translation missing --]]
L["combatWildcard_desc"] = "if the unit is combat flagged"
L["Countdown"] = "Compte à rebours"
L["Curse"] = "Malédiction"
L["curseWildcard_desc"] = "N'importe quel malédiction"
L["customRange_desc"] = "Remplace la valeur par défaut (40 yards) de la distance de l'indicateur hors de portée"
L["customRangeCheck_desc"] = "Change la valeur par défaut de 40 yard pour l'indicateur de hors de porté à la distance spécifiée"
--[[Translation missing --]]
L["Data import Failed."] = "Data import Failed."
--[[Translation missing --]]
L["Decoding failed."] = "Decoding failed."
--[[Translation missing --]]
L["Decompression failed."] = "Decompression failed."
L["Default Icon Visibility"] = "Visibilité de l'icône par défaut"
L["Disease"] = "Maladie"
L["diseaseWildcard_desc"] = "N'importe quel debuff de maladie"
L["Example"] = "Exemple"
--[[Translation missing --]]
L["Experimental"] = "Experimental"
--[[Translation missing --]]
L["Experimental Options"] = "Experimental Options"
--[[Translation missing --]]
L["Experimental_Options_Warning"] = [=[

Warning:

Here you will fill find experimental and potentially dangerous options.

Use at your own risk.

]=]
--[[Translation missing --]]
L["Export"] = "Export"
L["frameScale_desc"] = "L'échelle du cadre de raid par rapport à la taille normale"
L["General"] = "Général"
L["General Options"] = "Options générales"
L["generalOptions_desc"] = "Configurer la façon dont l'icône du marqueur de raid doit apparaître sur les cadres de raid"
L["Glow At Countdown Time"] = "Lueur au compte à rebours"
L["glowRemainingSecs_desc1"] = "La durée (en secondes) restante sur le compte à rebours de buff ou debuff avant que le brillant commence"
L["glowRemainingSecs_desc2"] = "'0' veux dire que cela va toujours briller"
L["Horizontal Offset"] = "Décalage horizontal"
L["horizontalOffset_desc"] = "Le pourcentage de décalage horizontal par rapport à la position de départ"
L["Icon"] = "Îcone"
L["Icon and Visuals"] = "Icône et visuels"
L["Icon Opacity"] = "Opacité de l'icône"
L["Icon Options"] = "Options d'icônes"
L["Icon Position"] = "Position de l'icône"
L["Icon Size"] = "Taille de l'icône"
L["iconAlpha_desc"] = "Le pourcentage d'opacité de l'icône de raid"
--[[Translation missing --]]
L["iconOptions_desc"] = "Configure how the raid marker icon should appear on the raid frames"
L["iconPosition_desc"] = "Position de l'icône de raid par rapport au cadre"
L["iconSize_desc"] = "La taille de l'icône de raid en pixels"
--[[Translation missing --]]
L["Import"] = "Import"
--[[Translation missing --]]
L["Import or Export the current profile:"] = "Import or Export the current profile:"
--[[Translation missing --]]
L["ImportExport_Desc"] = [=[

Below you will find a text representation of your Enhanced Raid Frame profile.

To export this profile, select and copy all of the text below and paste it somewhere safe.

To import a profile, replace all of the text below and press accept.

]=]
--[[Translation missing --]]
L["ImportExport_WarningDesc"] = [=[

Copying and pasting profile data can be a time consuming experience. It may stall your game for multiple seconds.

WARNING: This will overwrite the current profile, and any changes you have made will be lost.
]=]
--[[Translation missing --]]
L["ImportWarning"] = "Are you absolutely certain you wish to import this profile? The current profile will be overwritten."
L["Indicator Color"] = "Couleur de l'indicateur"
L["Indicator Font"] = "Police de l'indicateur"
L["Indicator Glow Effect"] = "Indicateur d'effet lumineux"
L["Indicator Options"] = "Options d'indicateur"
L["Indicator Size"] = "Taille de l'indicateur"
L["indicatorAlpha_desc"] = "Le pourcentage d'opacité de l'icône de l'indicateur"
L["indicatorColor_desc1"] = "La couleur utilisée pour l'indicateur lorsqu'il n'affiche pas l'icône de buff ou de debuff"
L["indicatorColor_desc2"] = "sauf si augmenté par d'autres options de couleur (Need to verify ''augmenté'', need context of this one)"
L["indicatorFont_desc"] = "La police utilisée pour les indicateurs"
L["indicatorGlow_desc"] = "Afficher un effet d'animation de brillance sur l'indicateur pour le rendre plus facile à repérer"
L["indicatorOptions_desc"] = "Veuillez sélectionner une position pour l'indicateur dans le menu déroulant ci-dessous"
L["indicatorSize_desc"] = "La taille de l'indicateur en pixels"
L["instructions_desc1"] = "La case à droite contient la liste des auras à surveiller à la position sélectionnée"
L["instructions_desc2"] = "Tapez les noms ou l'ID de chaque aura, chacun sur une ligne distincte"
L["Magic"] = "Magie"
L["magicWildcard_desc"] = "tout debuff magique"
L["meOnly_desc"] = "Afficher uniquement cet indicateur sur moi-même"
L["Middle Center"] = "Centre du milieu"
L["Middle Left"] = "Milieu à gauche"
L["Middle Right"] = "Milieu à droite"
L["Mine Only"] = "Seulement les miens"
L["mineOnly_desc"] = "Afficher uniquement les buffs et debuffs lancés par moi"
L["missingOnly_desc"] = "Afficher uniquement lorsque le buff ou le debuff est manquant"
--[[Translation missing --]]
L["No data to import."] = "No data to import."
L["None"] = "Aucun"
L["Open the Blizzard Raid Profiles Menu"] = "Ouvrez le menu des profils de raids de Blizzard"
L["Out-of-Range"] = "Hors de portée"
L["Out-of-Range Opacity"] = "Opacité hors de portée"
L["Override Default Distance"] = "Remplacer la distance par défaut"
L["Poison"] = "Poison"
L["poisonWildcard_desc"] = "tout debuff de poison"
L["Position"] = "Position"
--[[Translation missing --]]
L["Power Bar Vertical Offset"] = "Power Bar Vertical Offset"
--[[Translation missing --]]
L["powerBarOffset_desc"] = "Apply a vertical offset to icons and indicators to keep them from overlapping the power bar (mana/rage/energy)"
--[[Translation missing --]]
L["Profile"] = "Profile"
L["Profiles"] = "Profils"
L["pvpWildcard_desc"] = "si l'unité est marquée PvP"
L["Raidframe Scale"] = "Échelle du cadre de raid"
L["rangeAlpha_desc"] = "Le pourcentage d'opacité du cadre de raid lorsqu'il est hors de portée"
L["Select a Custom Distance"] = "Sélectionnez une distance personnalisée"
L["Show Countdown Swipe"] = "Afficher le compte à rebours"
L["Show Icon"] = "Montrer l'icône"
L["Show On Me Only"] = "Afficher uniquement sur moi"
L["Show Only if Missing"] = "Afficher uniquement si manquant"
L["Show Raid Icons"] = "Afficher les icônes de raid"
L["Show Text"] = "Afficher le texte"
L["Show Tooltip"] = "Afficher l'info-bulle"
L["showBuffs_desc"] = "Afficher les icônes de buff du cadre de raid par défaut"
L["showCountdownSwipe_desc"] = "Afficher l'animation de balayage dans le sens horaire indiquant le temps restant sur le buff ou le debuff"
L["showDebuffs_desc"] = "Afficher les icônes de debuff du cadre de raid par défaut"
L["showDispellableDebuffs_desc"] = "Afficher les icônes dissipables du cadre de raid par défaut"
L["showIcon_desc1"] = "Afficher une icône si le buff ou le debuff est actuellement sur l'unité"
L["showIcon_desc2"] = "si pas cochée, une couleur unie sera utilisé pour l'indicateur "
L["showRaidIcons_desc"] = "Afficher l'icône du marqueur de raid sur les cadres de raid"
L["showText_desc"] = "Le texte à afficher sur le cadre indicateur"
L["showTooltip_desc"] = "Afficher l'info-bulle au survol de la souris"
L["Stack Size"] = "Taille de comptage"
L["Stock Buff Icons"] = "Icônes de buff originales"
L["Stock Debuff Icons"] = "Icônes de debuff originales"
L["Stock Dispellable Icons"] = "Icônes de dissipation originales"
L["Text"] = "Texte"
L["Text Color"] = "Couleur du texte"
L["Text Size"] = "Grandeur du texte"
L["textColor_desc1"] = "La couleur utilisée pour le texte de l'indicateur"
L["textColor_desc2"] = "sauf si augmenté par d'autres options de couleur de texte (Need context for augmented)"
L["textSize_desc"] = "La grandeur du texte (en pixels)"
L["Time #1"] = "Temps #1"
L["Time #2"] = "Temps #2"
L["Tooltip Location"] = "Emplacement de l'info-bulle"
L["tooltipLocation_desc"] = "L'emplacement spécifié où l'infobulle doit apparaître"
L["Tooltips"] = "Infobulle"
L["Top Center"] = "Centre supérieur"
L["Top left"] = "En haut à gauche"
L["Top Right"] = "En haut à droite"
L["totWildcard_desc"] = "si l'unité est la cible de la cible"
L["Vertical Offset"] = "Décalage vertical"
L["verticalOffset_desc"] = "Le pourcentage de décalage vertical par rapport à la position de départ"
L["Visibility and Behavior"] = "Visibilité et comportement"
L["Wildcards"] = "Caractères Génériques"
L["zeroMeansIgnored_desc"] = "'0' signifie que ce temps est ignorée"


