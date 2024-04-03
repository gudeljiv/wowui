local L = LibStub("AceLocale-3.0"):NewLocale("NovaInstanceTracker", "frFR");
if (not L) then
	return;
end

L["noTimer"] = "Pas de minuteur"; --No timer (used only in map timer frames)
L["noCurrentTimer"] = "Actuellement pas de minuteur"; --No current timer
L["noActiveTimers"] = "Pas de minuteur actif";	--No active timers
L["second"] = "seconde"; --Second (singular).
L["seconds"] = "secondes"; --Seconds (plural).
L["minute"] = "minute"; --Minute (singular).
L["minutes"] = "minutes"; --Minutes (plural).
L["hour"] = "heure"; --Hour (singular).
L["hours"] = "heures"; --Hours (plural).
L["day"] = "jour"; --Day (singular).
L["days"] = "jours"; --Days (plural).
L["secondMedium"] = "sec"; --Second (singular).
L["secondsMedium"] = "secs"; --Seconds (plural).
L["minuteMedium"] = "min"; --Minute (singular).
L["minutesMedium"] = "mins"; --Minutes (plural).
L["hourMedium"] = "hour"; --Hour (singular).
L["hoursMedium"] = "hours"; --Hours (plural).
L["dayMedium"] = "jour"; --Day (singular).
L["daysMedium"] = "jours"; --Days (plural).
L["secondShort"] = "s"; --Used in short timers like 1m30s (single letter only, usually the first letter of seconds).
L["minuteShort"] = "m"; --Used in short timers like 1m30s (single letter only, usually the first letter of minutes).
L["hourShort"] = "h"; --Used in short timers like 1h30m (single letter only, usually the first letter of hours).
L["dayShort"] = "j"; --Used in short timers like 1d8h (single letter only, usually the first letter of days).
L["startsIn"] = "Commence dans %s"; --"Starts in 1hour".
L["endsIn"] = "Fini dans %s"; --"Ends in 1hour".
L["versionOutOfDate"] = "Votre addon Nova Instance Tracker n'est plus à jour, mettez le à jour sur https://www.curseforge.com/wow/addons/nova-instance-tracker ou via l'app twitch";
L["Options"] = "Options";
L["Reset Data"] = "Réinit. les données"; --A button to Reset data.

L["Error"] = "Erreur";
L["delete"] = "Supprimer";
L["confirmInstanceDeletion"] = "Confirmer la suppression de l'instance";
L["confirmCharacterDeletion"] = "Confirmer la suppression du personnage";

-------------
---Config---
-------------
--There are 2 types of strings here, the names end in Title or Desc L["exampleTitle"] and L["exampleDesc"].
--Title must not be any longer than 21 characters (maybe less for chinese characters because they are larger).
--Desc can be any length.

---General Options---
L["generalHeaderDesc"] = "Options générales";

L["chatColorTitle"] = "Couleur des messages de discussion";
L["chatColorDesc"] = "Quelle couleur devraient avoir les messages dans la discussion ?";

L["resetColorsTitle"] = "Réinit. les couleurs";
L["resetColorsDesc"] = "Réinitialise les couleurs par défaut.";

L["timeStampFormatTitle"] = "Format de l'horodatage";
L["timeStampFormatDesc"] = "Défini quel format d'horodatage utiliser, 12 heures (1:23pm) ou 24 heures (13:23).";

L["timeStampZoneTitle"] = "Heure local / Heure du royaume";
L["timeStampZoneDesc"] = "Utilise l'heure locale ou l'heure du royaume pour les horodatages ?";

L["minimapButtonTitle"] = "Bouton de la minicarte";
L["minimapButtonDesc"] = "Affiche le bouton NIT sur la minicarte ?";

--- Sounds ---
L["soundsHeaderDesc"] = "Sons";

L["soundsTextDesc"] = "Définir le son sur 'Aucun' pour le désactiver.";

L["disableAllSoundsTitle"] = "Désactiver tous les sons";
L["disableAllSoundsDesc"] = "Désactive tous les sons de cet addon.";

L["extraSoundOptionsTitle"] = "Options de son supplémentaires";
L["extraSoundOptionsDesc"] = "Activez pour afficher tous les sons de tous vos addons à la fois dans les listes déroulantes ici.";

L["notesHeaderDesc"] = "Quelques notes :";
L["notesDesc"] = "Cet addon fait de son mieux pour déterminer quand vous pouvez entrer dans plus de donjons, mais le système de verrouillage de Blizzard a parfois des erreurs et vous pouvez être bloqué avant d'atteindre la limite correcte. Parfois, vous ne pouvez entrer que 4 par heure, mais d'autres fois, vous pouvez en entrer 6 par heure.";

L["logHeaderDesc"] = "Journal";

L["openInstanceLogFrameTitle"] = "Journal des instances";

L["logSizeTitle"] = "Combien d'instances afficher dans le journal ?";
L["logSizeDesc"] = "Combien d'instances souhaitez-vous afficher dans le journal ? Un maximum de 300 est stocké, 100 sont affichées par défaut (vous pouvez ouvrir le journal en tapant /NIT).";

L["enteredMsgTitle"] = "Message d'entrée";
L["enteredMsgDesc"] = "Cela affichera un message dans votre fenêtre de discussion principale lorsque vous entrerez dans un donjon avec une icône X pour supprimer le nouvel instance de la base de données si vous le souhaitez.";

L["instanceResetMsgTitle"] = "Réinitialisation en groupe";
L["instanceResetMsgDesc"] = "Cela affichera un message à votre groupe ou à votre raid indiquant quels donjons ont été réinitialisés correctement si vous êtes le chef du groupe. Par exemple : Les Cavernes des lamentations ont été réinitialisées.";

L["raidEnteredMsgTitle"] = "Message d'entrée en raid";
L["raidEnteredMsgDesc"] = "Cela affichera un message dans votre fenêtre de discussion principale lorsque vous entrerez dans un raid avec une icône X pour supprimer le nouvel instance de la base de données si vous le souhaitez.";

L["pvpEnteredMsgTitle"] = "Message d'entrée en JcJ";
L["pvpEnteredMsgDesc"] = "Cela affichera un message dans votre fenêtre de discussion principale lorsque vous entrerez dans un donjon JcJ avec une icône X pour supprimer le nouvel instance de la base de données si vous le souhaitez.";

L["noRaidInstanceMergeMsgTitle"] = "Cacher la fusion d'instances en raid";
L["noRaidInstanceMergeMsgDesc"] = "Cache le message de fusion des instances lorsque vous entrez dans un raid et que la même ID est détectée.";

L["showMoneyTradedChatTitle"] = "Or échangé";
L["showMoneyTradedChatDesc"] = "Affiche dans la discussion lorsque vous donnez ou recevez de l'or de quelqu'un ? (Aide à garder une trace de qui vous avez payé ou de qui vous avez reçu de l'or dans les groupes).";

L["instanceStatsHeaderDesc"] = "Sortie des statistiques à la fin du donjon";

L["instanceStatsTextDesc"] = "Sélectionnez ici quelles statistiques afficher dans la discussion de groupe ou dans votre fenêtre de discussion lorsque vous quittez un donjon.";

L["instanceStatsOutputTitle"] = "Statistiques";
L["instanceStatsOutputDesc"] = "Affiche des statistiques sur le donjon à la sortie ?";

L["instanceStatsOutputWhereTitle"] = "Où afficher les statistiques";
L["instanceStatsOutputWhereDesc"] = "Où souhaitez-vous afficher les statistiques, dans la fenêtre de discussion pour vous-même ou dans la discussion de groupe ?";

L["instanceStatsOutputMobCountTitle"] = "Nombre d'ennemis";
L["instanceStatsOutputMobCountDesc"] = "Affiche combien d'ennemis ont été tués à l'intérieur du donjon ?";

L["instanceStatsOutputXPTitle"] = "Expérience";
L["instanceStatsOutputXPDesc"] = "Affiche combien d'expérience a été obtenue à l'intérieur du donjon ?";

L["instanceStatsOutputAverageXPTitle"] = "Expérience moyenne";
L["instanceStatsOutputAverageXPDesc"] = "Affiche l'expérience moyenne par mort à l'intérieur du donjon ?";

L["instanceStatsOutputTimeTitle"] = "Temps";
L["instanceStatsOutputTimeDesc"] = "Affiche combien de temps vous avez passé à l'intérieur du donjon ?";

L["instanceStatsOutputGoldTitle"] = "Or obtenu";
L["instanceStatsOutputGoldDesc"] = "Affiche combien d'or a été obtenu des ennemis à l'intérieur du donjon ?";

L["instanceStatsOutputAverageGroupLevelTitle"] = "Niveau moyen";
L["instanceStatsOutputAverageGroupLevelDesc"] = "Affiche le niveau moyen du groupe à l'intérieur du donjon ?";

L["showAltsLogTitle"] = "Afficher les personnages alternatifs";
L["showAltsLogDesc"] = "Affiche les personnages alternatifs dans le journal des instances ?";

L["timeStringTypeTitle"] = "Type de format d'heure";
L["timeStringTypeDesc"] = "Quel format de chaîne d'heure utiliser dans le journal des instances ?\n|cFFFFFF00Long :|r 1 minute 30 secondes\n|cFFFFFF00Moyen :|r 1 min 30 s\n|cFFFFFF00Court :|r 1m30s";

L["showLockoutTimeTitle"] = "Temps d'expiration";
L["showLockoutTimeDesc"] = "Cela affichera le temps restant avant expiration dans le journal des instances pour les instances des dernières 24 heures ; si décoché, affichera l'heure d'entrée comme dans les versions précédentes.";

L["colorsHeaderDesc"] = "Couleurs";

L["mergeColorTitle"] = "Couleur de fusion d'instances";
L["mergeColorDesc"] = "De quelle couleur devrait être le message dans la discussion lorsqu'une instance identique à la précédente est détectée et que les données sont fusionnées ?";

L["detectSameInstanceTitle"] = "Détecter une instance identique";
L["detectSameInstanceDesc"] = "Détecte automatiquement si vous rentrez dans la même instance pour que l'addon ne le compte pas comme 2 instances distinctes ?";

L["showStatsInRaidTitle"] = "Statistiques en raid";
L["showStatsInRaidDesc"] = "Affiche des statistiques lorsque vous êtes en raid ? Désactivez ceci pour afficher des statistiques uniquement dans le groupe lorsque vous êtes dans un groupe de 5 personnes (cette option fonctionne uniquement lorsque la discussion de groupe est choisi comme sortie de statistiques).";

L["printRaidInsteadTitle"] = "Imprimer dans le raid";
L["printRaidInsteadDesc"] = "Si vous avez désactivé l'envoi des statistiques dans la discussion de raid, cela les affichera dans votre fenêtre de discussion pour que vous puissiez les voir.";

L["statsOnlyWhenActivityTitle"] = "Uniquement en cas d'activité";
L["statsOnlyWhenActivityDesc"] = "Affiche des statistiques uniquement lorsqu'il y a eu de l'activité à l'intérieur du donjon ? Cela signifie uniquement si vous avez tué des ennemis, gagné de l'expérience, obtenu du butin, etc. Cela évitera d'afficher des statistiques vides.";


L["show24HourOnlyTitle"] = "Dernières 24 heures";
L["show24HourOnlyDesc"] = "Affiche uniquement les instances des dernières 24 heures dans le journal des instances ?";

L["trimDataHeaderDesc"] = "Nettoyage des données";

L["trimDataBelowLevelTitle"] = "Niveau maximum à supprimer";
L["trimDataBelowLevelDesc"] = "Sélectionnez le niveau maximum des personnages à supprimer de la base de données ; tous les personnages de ce niveau et moins seront supprimés.";

L["trimDataBelowLevelButtonTitle"] = "Supprimer les personnages";
L["trimDataBelowLevelButtonDesc"] = "Cliquez sur ce bouton pour supprimer tous les personnages avec le niveau sélectionné et plus bas de cette base de données de l'addon.";

L["trimDataTextDesc"] = "Supprimer plusieurs personnages de la base de données :";
L["trimDataText2Desc"] = "Supprime un personnage de la base de données :";

L["trimDataCharInputTitle"] = "Entrée pour supprimer un personnage";
L["trimDataCharInputDesc"] = "Entrez ici un personnage à supprimer, au format Nom-Royaume (sensible à la casse). Remarque : Cela supprime définitivement les données de comptage des sorts.";

L["trimDataBelowLevelButtonConfirm"] = "Êtes-vous sûr de vouloir supprimer tous les personnages en dessous du niveau %s de la base de données ?";
L["trimDataCharInputConfirm"] = "Êtes-vous sûr de vouloir supprimer ce personnage %s de la base de données ?";

L["trimDataMsg2"] = "Suppression de tous les personnages en dessous du niveau %s.";
L["trimDataMsg3"] = "Supprimé : %s.";
L["trimDataMsg4"] = "Terminé, aucun personnage trouvé.";
L["trimDataMsg5"] = "Terminé, %s personnages ont été supprimés.";
L["trimDataMsg6"] = "Veuillez saisir un nom de personnage valide à supprimer de la base de données.";
L["trimDataMsg7"] = "Ce nom de personnage %s n'inclut pas de royaume, veuillez entrer Nom-Royaume.";
L["trimDataMsg8"] = "Erreur lors de la suppression de %s de la base de données, personnage introuvable (la casse du nom est respectée).";
L["trimDataMsg9"] = "%s a été supprimé de la base de données.";

L["instanceFrameSelectAltMsg"] = "Sélectionnez quel personnage alternatif afficher si \"Afficher alts\" n'est pas coché.\nOu quel personnage alternatif colorer si \"Afficher alts\" est coché.";

L["enteredDungeon"] = "Nouvelle instance %s %s, cliquez";
L["enteredDungeon2"] = "si ce n'est pas une nouvelle instance.";
L["enteredRaid"] = "Nouvelle instance %s, ce raid ne compte pas pour le verrouillage.";
L["loggedInDungeon"] = "Vous êtes entré dans %s %s, cliquez";
L["loggedInDungeon2"] = "pour supprimer cette instance de la base de données si ce n'est pas une nouvelle instance.";
L["reloadDungeon"] = "Un rechargement de l'interface a été détecté %s, chargement des données de la dernière instance au lieu d'en créer une nouvelle.";
L["thisHour"] = "cette heure";
L["statsError"] = "Erreur lors de la recherche des statistiques pour l'instance %s.";
L["statsMobs"] = "Ennemis :";
L["statsXP"] = "XP :";
L["statsAverageXP"] = "XP moyenne par ennemi :";
L["statsRunsPerLevel"] = "instances par niveau :";
L["statsRunsNextLevel"] = "instances jusqu'au prochain niveau :";
L["statsTime"] = "Temps :";
L["statsAverageGroupLevel"] = "Niveau moyen du groupe :";
L["statsGold"] = "Or :";
L["sameInstance"] = "Même ID d'instance que la dernière détectée %s, fusion des entrées de la base de données.";
L["deleteInstance"] = "Instance supprimée [%s] %s (%s en arrière) de la base de données.";
L["deleteInstanceError"] = "Erreur lors de la suppression de %s.";
L["countString"] = "Vous avez entré %s instances dans la dernière heure et %s dans les dernières 24 heures.";
L["countStringColorized"] = "Vous avez entré %s %s %s instances dans la dernière heure et %s %s %s dans les dernières 24 heures.";
L["now"] = "maintenant";
L["in"] = "dans";
L["active24"] = "Verrouillage de 24 heures actif";
L["nextInstanceAvailable"] = "Prochaine instance disponible";
L["gave"] = "a donné";
L["received"] = "a reçu";
L["to"] = "à";
L["from"] = "de";
L["playersStillInside"] = "a été réinitialisé (Les joueurs qui sont encore à l'intérieur de l'instance précédente peuvent sortir et entrer dans la nouvelle).";
L["Gold"] = "Or";
L["gold"] = "or";
L["silver"] = "argent";
L["copper"] = "cuivre";
L["newInstanceNow"] = "Une nouvelle instance peut être entrée maintenant";
L["thisHour"] = "cette heure";
L["thisHour24"] = "ces 24 dernières heures";
L["openInstanceFrame"] = "Journal des instances";
L["openYourChars"] = "Vos personnages";
L["openTradeLog"] = "Journal des échanges";
L["config"] = "Options";
L["thisChar"] = "Ce personnage";
L["yourChars"] = "Personnages";
L["instancesPastHour"] = "instances dans la dernière heure.";
L["instancesPastHour24"] = "instances dans les dernières 24 heures.";
L["leftOnLockout"] = "restantes sous verrouillage";


L["tradeLog"] = "Échanges";
L["pastHour"] = "Dernière heure";
L["pastHour24"] = "Dernières 24 heures";
L["older"] = "Ancien";
L["raid"] = "Raid";
L["alts"] = "Alts";
L["deleteEntry"] = "Supprimer l'entrée";
L["lastHour"] = "Dern. heure";
L["lastHour24"] = "Dern. 24h";
L["entered"] = "Entré";
L["ago"] = "il y a";
L["stillInDungeon"] = "Toujours dans le donjon";
L["leftOnLockout"] = "restantes sous verrouillage";
L["leftOnDailyLockout"] = "restante sous verrouillage quotidien";
L["noLockout"] = "Aucun verrouillage pour ce raid";
L["unknown"] = "Inconnu";
L["instance"] = "Instance";
L["timeEntered"] = "Heure d'entrée";
L["timeLeft"] = "Heure de sortie";
L["timeInside"] = "Temps passé à l'intérieur";
L["mobCount"] = "Nombre d'ennemis";
L["experience"] = "Expérience";
L["experienceShort"] = "EXP";
L["rawGoldMobs"] = "Or obtenu des ennemis";
L["enteredLevel"] = "Niveau en entrant";
L["leftLevel"] = "Niveau en sortant";
L["averageGroupLevel"] = "Niveau moyen du groupe";
L["currentLockouts"] = "Verrouillages actuels";
L["repGains"] = "Gains de réputation";
L["groupMembers"] = "Membres du groupe";
L["tradesWhileInside"] = "Échanges pendant le donjon";
L["noDataInstance"] = "Pas de données disponibles pour cette instance.";
L["restedOnlyText"] = "Seulement reposé";
L["restedOnlyTextTooltip"] = "Affiche uniquement les personnages avec de l'expérience de repos ? Décochez ceci pour afficher tous les personnages alternatifs, y compris ceux de niveau maximum et ceux sans expérience de repos.";
L["deleteEntry"] = "Supprimer l'entrée"; --Example: "Delete entry 5";
L["online"] = "En ligne";
L["maximum"] = "Max";
L["level"] = "Niveau";
L["rested"] = "Reposé";
L["realmGold"] = "Or du royaume pour";
L["total"] = "Total";
L["guild"] = "Guilde";
L["resting"] = "En train de se reposer";
L["notResting"] = "Pas en train de se reposer";
L["rested"] = "Reposé";
L["restedBubbles"] = "Bulles de repos";
L["restedState"] = "État de repos";
L["bagSlots"] = "Emplacements du sac";
L["durability"] = "Durabilité";
L["items"] = "Objets";
L["ammunition"] = "Munitions";
L["petStatus"] = "Statut du familier";
L["name"] = "Nom";
L["family"] = "Famille";
L["happiness"] = "Bonheur";
L["loyaltyRate"] = "Taux de loyauté";
L["petExperience"] = "XP du familier";
L["unspentTrainingPoints"] = "Points d'entraînement non dépensés";
L["professions"] = "Métiers";
L["lastSeenPetDetails"] = "Détails du dernier familier vu";
L["currentPet"] = "Familier actuel";
L["noPetSummoned"] = "Aucun familier invoqué";
L["lastSeenPetDetails"] = "Détails du dernier familier vu";
L["noProfessions"] = "Aucun métier trouvé.";
L["cooldowns"] = "Temps de recharge";
L["left"] = "restants"; -- This is left as in "time left";
L["ready"] = "Prêt.";
L["pvp"] = "JcJ";
L["rank"] = "Grade";
L["lastWeek"] = "La semaine dernière";
L["attunements"] = "Harmonisations";
L["currentRaidLockouts"] = "Verrouillages de raid actuels";
L["none"] = "Aucun.";

L["instanceStatsOutputRunsPerLevelTitle"] = "Courses par niveau";
L["instanceStatsOutputRunsPerLevelDesc"] = "Affiche le nombre de courses nécessaires par niveau ?";

L["instanceStatsOutputRunsNextLevelTitle"] = "Courses jusqu'au prochain niveau";
L["instanceStatsOutputRunsNextLevelDesc"] = "Affiche le nombre de courses supplémentaires nécessaires pour atteindre votre prochain niveau ?";

L["instanceWindowWidthTitle"] = "Largeur de la fenêtre de l'instance";
L["instanceWindowWidthDesc"] = "Quelle devrait être la largeur de la fenêtre de l'instance ?";

L["instanceWindowHeightTitle"] = "Hauteur de la fenêtre de l'instance";
L["instanceWindowHeightDesc"] = "Quelle devrait être la hauteur de la fenêtre de l'instance ?";

L["charsWindowWidthTitle"] = "Largeur de la fenêtre des personnages";
L["charsWindowWidthDesc"] = "Quelle devrait être la largeur de la fenêtre d'informations sur les personnages ?";

L["charsWindowHeightTitle"] = "Hauteur de la fenêtre des personnages";
L["charsWindowHeightDesc"] = "Quelle devrait être la hauteur de la fenêtre d'informations sur les personnages ?";

L["tradeWindowWidthTitle"] = "Largeur de la fenêtre de commerce";
L["tradeWindowWidthDesc"] = "Quelle devrait être la largeur de la fenêtre de commerce ?";

L["tradeWindowHeightTitle"] = "Hauteur de la fenêtre de commerce";
L["tradeWindowHeightDesc"] = "Quelle devrait être la hauteur de la fenêtre de commerce ?";

L["resetFramesTitle"] = "Réinit. les fenêtres";
L["resetFramesDesc"] = "Réinitialise toutes les fenêtres au centre de l'écran et les tailles aux valeurs par défaut.";

L["resetFramesMsg"] = "Réinitialisation de toutes les positions et tailles des fenêtres.";

L["statsRep"] = "Réputation :";

L["instanceStatsOutputRepTitle"] = "Réputation gagnée";
L["instanceStatsOutputRepDesc"] = "Affiche la quantité de réputation gagnée pendant que vous êtes dans le donjon ?";

L["instanceStatsOutputHKTitle"] = "Victoires honorables";
L["instanceStatsOutputHKDesc"] = "Affiche le nombre de victoires honorables gagnées pendant que vous êtes dans un champ de bataille ?";

L["experiencePerHour"] = "XP/heure";

L["instanceStatsOutputXpPerHourTitle"] = "Afficher XP/heure";
L["instanceStatsOutputXpPerHourDesc"] = "Affiche la quantité d'expérience gagnée par heure pendant que vous êtes dans le donjon ?";

L["autoDialogueDesc"] = "Dialogue automatique avec les PNJ";

L["autoSlavePensTitle"] = "Les enclos aux esclaves";
L["autoSlavePensDesc"] = "Dialogue automatique avec le PNJ à la fin de Les enclos aux esclaves dans la cage ?";

L["autoCavernsFlightTitle"] = "Grottes du temps";
L["autoCavernsFlightDesc"] = "Dialogue automatique avec le dragon près de la pierre d'invocation dans les Grottes du temps pour voler vers le bas ? (Uniquement si la quête \"Dans le repaire du maître\" est terminée)";

L["autoBlackMorassTitle"] = "Le Noir Marécage";
L["autoBlackMorassDesc"] = "Dialogue automatique avec le PNJ au début du Noir Marécage pour obtenir votre torche ? (Uniquement si la quête \"Héros de la progéniture\" est terminée)";

L["autoSfkDoorTitle"] = "Donjon d'Ombrecroc";
L["autoSfkDoorDesc"] = "Dialogue automatique avec le PNJ dans le Donjon d'Ombrecroc qui ouvre la porte ?";

L["honorGains"] = "Gain d'honneur";
L["Honor"] = "Honneur";
L["Won"] = "Gagné";
L["Lost"] = "Perdu";
L["Arena"] = "Arène";
L["Arena Points"] = "Points d'arène";

L["stillInArena"] = "Encore dans l'arène";
L["stillInBattleground"] = "Encore dans le champ de bataille";

L["resetAllInstancesConfirm"] = "Êtes-vous sûr de vouloir supprimer toutes les données d'instance du journal ?";
L["All Instance log data has been deleted."] = "Toutes les données de journal d'instance ont été supprimées.";

L["resetAllInstancesTitle"] = "Réinit. les données";
L["resetAllInstancesDesc"] = "Cela réinitialisera toutes les données d'instance et supprimera tout du journal. Cela n'effacera pas les échanges.";

L["autoCavernsArthasTitle"] = "L'Épuration de Stratholme";
L["autoCavernsArthasDesc"] = "Dialogue automatique avec Arthas dans L'Épuration de Stratholme dans Wrath.";

L["Mythic Plus"] = "Mythique+";
L["mythicPlusShort"] = "Mythique+";

L["noCurrentRaidLockouts"] = "Aucun verrouillage de raid en cours.";

L["weeklyQuests"] = "Quêtes hebdomadaires";
L["dailyQuests"] = "Quêtes quotidiennes";

L["openLockouts"] = "Verrouillages";

L["autoGammaBuffDesc"] = "Buff gamma";

L["autoGammaBuffTitle"] = "Buff gamma automatique";
L["autoGammaBuffDesc"] = "Obtenez automatiquement le buff gamma approprié pour votre classe lorsque vous parlez au PNJ gamma dans un donjon gamma.";

L["autoGammaBuffReminderTitle"] = "Rappel du buff gamma";
L["autoGammaBuffReminderDesc"] = "Affiche un message dans la discussion au début du donjon pour vous rappeler d'obtenir le buff si vous ne l'avez pas.";

L["autoGammaBuffTypeTitle"] = "Type de buff gamma";
L["autoGammaBuffTypeDesc"] = "Quel type de buff souhaitez-vous ? La sélection automatique choisira entre corps à corps / distance / soigneur / tank selon votre spécialisation. Ou vous pouvez le remplacer par une sélection différente. La sélection du buff est une option de configuration spécifique au personnage.";

L["dungeonPopTimerTitle"] = "Minuteur d'apparition du donjon";
L["dungeonPopTimerDesc"] = "Affiche un minuteur dans la fenêtre de file d'attente du donjon indiquant le temps restant pour cliquer sur Entrer.";

L["autoWrathDailiesTitle"] = "Obtenir automatiquement les quêtes journalières de Wrath";
L["autoWrathDailiesDesc"] = "Obtient et rend automatiquement les quêtes journalières de Wrath de l'Archimage Lan'dalock à Dalaran.";

L["gammaConfigWarning"] = "Le choix du buff gamma est spécifique au personnage, si vous le changez sur ce personnage, cela n'affectera pas vos autres personnages.";
L["autoGammaBuffReminder"] = "Obtenez le buff gamma de donjon de %s.";
L["Sunreaver Warden"] = "Gardien Saccrelame";
L["Silver Covenant Warden"] = "Gardien du Pacte de Verre";
L["note"] = "Remarque :";
L["Click an entry to post stats."] = "Cliquez sur une entrée pour afficher les statistiques.";

L["Show Alts"] = "Afficher alts";
L["showAltsTooltip"] = "Affiche tous les alts dans le journal des instances ? (Les verrouillages sont par personnage)";

L["PvE"] = "JcE"; --Must be 3 letters max to fit. (PvP already exists further up)
L["Hold to drag"] = "Maintenez pour déplacer";
L["Raid Lockouts (Including Alts)"] = "Verrouillages de raid (y compris alts)";
L["No trade logs found."] = "Aucun journal des échanges trouvé.";
L["Today"] = "Aujourd'hui";
L["Yesterday"] = "Hier";

L["Level Log"] = "Journal";
L["Mouseover log entry for more info"] = "Survolez l'entrée du journal pour plus d'informations";
L["Current Level"] = "Niveau actuel";
L["Leveling history for"] = "Historique de niveau pour";
L["Unknown Time"] = "Heure inconnue";
L["Unknown Zone"] = "Zone inconnue";
L["Zone"] = "Zone";
L["SubZone"] = "Sous-zone";

L["Ding"] = "Subir a"; --Level up.
L["Map coords"] = "Coordonnées";
L["Gold owned at start of level"] = "Or possédé au début du niveau";
L["Gold change during this level"] = "Changement d'or pendant ce niveau";
L["Quests completed during this level"] = "Quêtes terminées pendant ce niveau";
L["Mobs that gave exp during this level"] = "Monstres ayant donné de l'expérience pendant ce niveau";
L["Played time this level"] = "Temps joué à ce niveau";
L["Total Played"] = "Total joué";
L["firstTimeSeeingCharPlayed"] = "C'est la première fois que ce personnage est vu à ce niveau, il est probable que le temps joué à ce niveau soit incorrect.";
L["Left-Click"] = "Clic Gauche";
L["Right-Click"] = "Clic Droit";
L["Shift Left-Click"] = "Maj Clic Gauche";
L["Shift Right-Click"] = "Maj Clic Droit";
L["Control Left-Click"] = "Ctrl Clic Gauche";
L["Middle-Click"] = "Clic Milieu";

L["Lockouts"] = "Verrous";
L["Instance"] = "Instance";
L["ZoneID"] = "ID de zone";
L["Show dungeons and raids?"] = "Affiche les donjons et les raids ?";
L["Show battleground and arena instances?"] = "Affiche les champs de bataille et les arènes ?";
L["Party"] = "Groupe";
L["Guild"] = "Guilde";
L["Copy Paste"] = "Copier/Coller";
L["Print"] = "Imprimer";
L["Post Stats for log"] = "Publier les statistiques";
L["Alts (Mouseover names for info)"] = "Alts (Survolez les noms pour plus d'informations)";
L["Min Level"] = "Niveau minimum";
L["No guild"] = "Pas de guilde";
L["No guild rank"] = "Pas de grade dans la guilde";
L["Show leveling history for"] = "Afficher l'historique de nivellement pour";
L["Test Instance"] = "Instance de test";
L["Long"] = "Long";
L["Medium"] = "Moyen";
L["Short"] = "Court";
L["Chat Window"] = "Fenêtre de discussion";
L["Group Chat (Party/Raid)"] = "Discussion de groupe (groupe/raid)";
L["12 hour"] = "12 heures";
L["24 hour"] = "24 heures";

L["Molten Core"] = "Cœur du Magma";
L["Onyxia's Lair"] = "Repaire d'Onyxia";
L["Blackwing Lair"] = "Repaire de l'Aile noire";
L["Naxxramas"] = "Naxxramas";
L["Karazhan"] = "Karazhan";
L["The Shattered Halls"] = "Les Salles brisées";
L["Serpentshrine Cavern"] = "Caverne du sanctuaire du Serpent";
L["The Arcatraz"] = "L'Arcatraz";
L["Black Morass"] = "Le Noir Marécage";
L["Battle of Mount Hyjal"] = "La bataille du mont Hyjal";
L["Black Temple"] = "Temple noir";
L["Hellfire Citadel"] = "Citadelle des Flammes infernales";
L["Coilfang Reservoir"] = "Réservoir de Glissecroc";
L["Shadow Labyrinth"] = "Labyrinthe des ombres";
L["Auchindoun"] = "Auchindoun";
L["Tempest Keep"] = "Donjon de la Tempête";
L["Caverns of Time"] = "Grottes du temps";
L["deletedCharOnRealm"] = "Personnage %s supprimé sur le royaume [%s].";
L["deletedCharOnRealmNewInfo"] = "Personnage %s supprimé sur le royaume [%s], enregistrement de nouvelles informations.";

L["Time"] = "Temps";
L["Show time?"] = "Affiche l'heure ?";
L["Show Zone where trade happened?"] = "Affiche la zone où le commerce a eu lieu ?";
L["Time Ago"] = "Il y a";
L["Show how long ago?"] = "Affiche depuis combien de temps ?";
L["Records"] = "Enregistrements";
L["How many trade records to show?"] = "Combien d'enregistrements de commerce afficher ?";
L["Current Hour Lockouts"] = "Bloquages de l'heure actuelle";
L["Current Dungeon Stats"] = "Statistiques de donjon actuelles";
L["Log Entry"] = "Entrée de journal";
L["Local Time"] = "Heure locale";
L["Server Time"] = "Heure du royaume";
L["Example"] = "Exemple";

--Abbreviated days/months.
L["Mon"] = "Lun";
L["Tue"] = "Mar";
L["Wed"] = "Mer";
L["Thu"] = "Jeu";
L["Fri"] = "Ven";
L["Sat"] = "Sam";
L["Sun"] = "Dim";

L["Jan"] = "Jan";
L["Feb"] = "Fév";
L["Mar"] = "Mar";
L["Apr"] = "Avr";
L["May"] = "Mai";
L["Jun"] = "Juin";
L["Jul"] = "Juil";
L["Aug"] = "Août";
L["Sep"] = "Sep";
L["Oct"] = "Oct";
L["Nov"] = "Nov";
L["Dec"] = "Déc";
