local L = LibStub("AceLocale-3.0"):NewLocale("Postal", "frFR")
if not L then return end
L["|cffeda55fAlt-Click|r to send this item to %s."] = "|cffeda55fAlt+clic gauche|r pour envoyer cet objet à %s."
L["|cffeda55fControl-Click|r to attach similar items."] = "|cffeda55fCtrl+clic|r pour joindre les objets similaires."
L["|cffeda55fCtrl-Click|r to return it to sender."] = "|cffeda55fCtrl+clic gauche|r pour renvoyer à l'expéditeur."
L["|cffeda55fShift-Click|r to take the contents."] = "|cffeda55fMaj+clic gauche|r pour récupérer le contenu."
L[ [=[|cFFFFCC00*|r Selected mail will be batch opened or returned to sender by clicking Open or Return.
|cFFFFCC00*|r You can Shift-Click 2 checkboxes to mass select every mail between the 2 checkboxes.
|cFFFFCC00*|r You can Ctrl-Click a checkbox to mass select or unselect every mail from that sender.
|cFFFFCC00*|r Select will never delete any mail (mail without text is auto-deleted by the game when all attached items and gold are taken).
|cFFFFCC00*|r Select will skip CoD mails and mails from Blizzard.
|cFFFFCC00*|r Disable the Verbose option to stop the chat spam while opening mail.]=] ] = [=[|cFFFFCC00*|r Les courriers sélectionnés seront ouverts ou renvoyés selon si vous avez cliqué sur Ouvrir ou Renvoi.
|cFFFFCC00*|r Vous pouvez faire Maj+clic gauche sur 2 cases à cocher afin de sélectionner tous les courriers présents entre ces 2 cases.
|cFFFFCC00*|r Vous pouvez faire Ctrl+clic gauche sur une case à cocher pour (dé)sélectionner tous les courriers de cet expéditeur.
|cFFFFCC00*|r Select ne supprimera jamais aucun courrier (les courriers sans texte sont automatiquement supprimés par le jeu quand tous les objets joints et tout l'argent ont été pris).
|cFFFFCC00*|r Select n'ouvrira pas les courriers C.R. ainsi que ceux provenant de Blizzard.
|cFFFFCC00*|r Désactiver l'option Bavard pour enlever le spam dans le chat pendant l'ouverture du courrier.]=]
L[ [=[|cFFFFCC00*|r Shift-Click to take item/money from mail.
|cFFFFCC00*|r Ctrl-Click to return mail.
|cFFFFCC00*|r Alt-Click to move an item from your inventory to the current outgoing mail (same as right click in default UI).]=] ] = [=[|cFFFFCC00*|r Maj+clic gauche pour récupérer le contenu du courrier.
|cFFFFCC00*|r Ctrl+clic gauche pour renvoyer le courrier.
|cFFFFCC00*|r Alt+clic gauche pour déplacer un objet de votre inventaire vers le courrier sortant actuel (même comportement que le clic droit dans l'IU par défaut).]=]
L[ [=[|cFFFFCC00*|r Simple filters are available for various mail types.
|cFFFFCC00*|r Shift-Click the Open All button to override the filters and take ALL mail.
|cFFFFCC00*|r OpenAll will never delete any mail (mail without text is auto-deleted by the game when all attached items and gold are taken).
|cFFFFCC00*|r OpenAll will skip CoD mails and mails from Blizzard.
|cFFFFCC00*|r Disable the Verbose option to stop the chat spam while opening mail.]=] ] = [=[|cFFFFCC00*|r Des filtres sont disponibles pour les différents types de courrier.
|cFFFFCC00*|r Maj+clic gauche sur le bouton "Tout ouvrir" outrepassera les filtres et ouvrira TOUS les courriers.
|cFFFFCC00*|r Tout Ouvrir ne supprimera jamais un courrier (les courriers sans texte sont automatiquement supprimés par le jeu quand tous les objets joints et tout l'argent ont été récupérés).
|cFFFFCC00*|r Tout Ouvrir n'ouvrira pas les courriers C.R. ainsi que ceux provenant de Blizzard.
|cFFFFCC00*|r Désactiver l'option Bavard pour enlever le spam de la fenêtre de discussion pendant l'ouverture du courrier.]=]
L[ [=[|cFFFFCC00*|r This module will list your contacts, friends, guild mates, alts and track the last 10 people you mailed.
|cFFFFCC00*|r It will also autocomplete all names in your BlackBook.]=] ] = [=[|cFFFFCC00*|r Ce module affichera vos contacts, amis, membres de guilde, rerolls ainsi que les 10 dernières personnes contactées.
|cFFFFCC00*|r De plus il complétera automatiquement tous les noms présents dans votre Répertoire.]=]
L["A button that collects all attachments and coins from mail."] = "Un bouton qui récupère toutes les pièces jointes et l'argent des courriers."
L["Add check boxes to the inbox for multiple mail operations."] = "Ajoute des cases à cocher à la boîte de réception pour gérer plusieurs courriers en même temps."
L["Add Contact"] = "Ajouter un contact"
L["Add multiple item mail tooltips"] = "Afficher plusieurs objets dans l'infobulle du courrier"
L["Adds a contact list next to the To: field."] = "Ajoute une liste des contacts à côté du champ \"À :\"."
L["AH-related mail"] = "Courriers relatifs à l'HV"
L["All Alts"] = "Tous les rerolls"
L["Allows you to copy the contents of a mail."] = "Permet de copier le contenu d'un courrier."
L["Alts"] = "Rerolls"
L["Auto-Attach similar items on Control-Click"] = "Joindre les objets similaires avec Ctrl+clic"
L["Autofill last person mailed"] = "Saisie auto. de la dernière personne contactée"
L["Auto-Send on Alt-Click"] = "Envoi auto. avec Alt+clic gauche"
L["BlackBook"] = "Répertoire"
L["Block incoming trade requests while in a mail session."] = "Bloque les demandes d'échanges lors de la consultation du courrier."
L["CarbonCopy"] = "Copie conforme"
L["Chat Output"] = "Sortie dans le chat"
L["Choose"] = "Choisir"
L["Clear list"] = "Effacer la liste"
L["Collected"] = "Récupéré"
L["Contacts"] = "Contacts"
L["Copy From"] = "Copier à partir de"
L["Copy this mail"] = "Copier ce courrier"
L["Delete"] = "Supprimer"
L["Disable Blizzard's auto-completion popup menu"] = "Désactiver le pop-up de saisie intuitive de Blizzard"
L["DoNotWant"] = "Ne Veux Pas"
L["Enable Alt-Click to send mail"] = "Activer Alt+clic gauche pour envoyer le courrier"
L["Exclude randoms you interacted with"] = "Exclure les inconnus avec qui vous avez interagi"
L["Express"] = "Express"
L["Friends"] = "Amis"
L["Guild"] = "Guilde"
L["Help"] = "Aide"
L["In Progress"] = "En cours"
L["Keep free space"] = "Garder de l'espace libre"
L["Mouse click short cuts for mail."] = "Raccourcis souris pour le courrier."
L["Name auto-completion options"] = "Options de la saisie intuitive des noms"
L["New Profile"] = "Nouveau profil"
L["New Profile Name:"] = "Nom du nouveau profil :"
L["Non-AH related mail"] = "Courriers non relatifs à l'HV"
L["Not all messages are shown, refreshing mailbox soon to continue Open All..."] = "Tous les courriers ne sont pas affichés, réouvrir la boîte aux lettres dans quelques secondes pour pouvoir tous les ouvrir..."
L["Not taking more items as there are now only %d regular bagslots free."] = "N'accepte pas plus d'objets car il n'y a plus que %d espace(s) libre(s) dans vos sacs."
L["Open"] = "Ouvrir"
L["Open All"] = "Tout ouvrir"
L["Open all Auction cancelled mail"] = "Ouvrir tous les courriers des enchères annulées"
L["Open all Auction expired mail"] = "Ouvrir tous les courriers des enchères expirées"
L["Open all Auction successful mail"] = "Ouvrir tous les courriers des enchères réussies"
L["Open all Auction won mail"] = "Ouvrir tous les courriers des enchères gagnées"
L["Open all mail with attachments"] = "Ouvrir tous les courriers avec pièces jointes"
L["Open all Outbid on mail"] = "Ouvrir tous les courriers des enchères surenchéries"
L["Open mail from the Postmaster"] = "Ouvrir tous les courriers du maître de poste"
L["OpenAll"] = "Tout Ouvrir"
L["Opening Speed"] = "Vitesse d'ouverture"
L["Other options"] = "Autres options"
L["Part %d"] = "Partie %d"
L["Please post bugs or suggestions at the wowace forums thread at |cFF00FFFFhttp://forums.wowace.com/showthread.php?t=3909|r. When posting bugs, indicate your locale and Postal's version number v%s."] = "Merci de signaler les bogues ou de faire part de vos suggestions sur le sujet du forum WoWAce dédié à Postal : |cFF00FFFFhttp://forums.wowace.com/showthread.php?t=3909|r. Lors du signalement d'un bogue, indiquez la langue de votre jeu ainsi que le numéro de version de Postal v%s."
L["Prints the amount of money collected during a mail session."] = "Indique la quantité d'argent récoltée pendant la consultation du courrier."
L["Processing Message"] = "En cours"
L["Profile"] = "Profil"
L["Rake"] = "Râteau"
L["Recently Mailed"] = "Récents"
L["Refreshing mailbox..."] = "Rafraichir la boîte aux lettres..."
L["Remove Contact"] = "Supprimer un contact"
L["Reset Profile"] = "Réinitialiser le profil"
L["Return"] = "Renvoi"
L["Select"] = "Sélectionner"
L["Set subject field to value of coins sent if subject is blank."] = "Indique dans le sujet le montant d'argent envoyé si le sujet est vide."
L["Shows a clickable visual icon as to whether a mail will be returned or deleted on expiry."] = "Affiche une icône visuelle cliquable indiquant si le courrier sera renvoyé ou supprimé à son expiration."
L["Skipping"] = "Passe"
L["Some Messages May Have Been Skipped."] = "Certains messages n'ont peut-être pas été ouverts."
L["Thaumaturge Vashreen"] = "Thaumaturge Vashreen"
L["The Postmaster"] = "Le maître de poste"
L["There are %i more messages not currently shown."] = "%i messages supplémentaires ne sont pas affichés."
L["There are %i more messages not currently shown. More should become available in %i seconds."] = "%i messages supplémentaires ne sont pas affichés. D'autres devraient devenir disponible d'ici %i secondes."
L["TradeBlock"] = "Bloqueur d'échanges"
L["Use Mr.Plow after opening"] = "Utilisez Mr.Plow après l'ouverture"
L["Use Postal's auto-complete"] = "Utiliser la saisie intuitive de Postal"
L["Verbose mode"] = "Mode Bavard"
L["Wire"] = "Câbler"
