== GLOBAL IGNORE LIST AND SPAM FILTER

Global Ignore List is a quality of life addon that provides a greatly enhanced (unlimited) character ignore system, and has a robust chat/spam filtering engine to eliminate gold sellers/spammers, guild recruitment, community recruitment, annoying trends like Thunderfury, non-latin text, and more. All of these can be enabled or disabled as you please or you can even create your own:

Global Ignore also gives you full access to its chat filtering engine so you can create your own filters whether they are as simple as a single word or complex statements that requirement boolean evaluations.

* Unlimited ignore list size, synchronized across all characters, factions, and servers
* Account wide ignore system
* Ability to ignore players, NPCs, monsters, and entire servers
* Ability to set notes for ignored entries, and expiration times for automatic removal from ignore
* Chat spam filtering with robust chat spam filter editor, allowing players to create their own custom filters.
* Default spam filters catch the majority of gold sellers and spammers (defaults for English servers) including gold spam, Guild recruitment, community invites, Asian languages, and so on.
* Warnings to prevent inviting or being a member of a group with a player on your ignore list
* Automatic decline of duels and party invites from ignored players
* Greatly improved UI over the default
* Enhancements to existing UI such as being able to ignore by right clicking target or from raid frames
* Small and efficient created with pure WoW API only (no libs like ACE)

Type /gi in game for chat help, or open your ignore list for features and options

**NOTES AND KNOWN ISSUES:**

* There is a bug where WoW sometimes reports all members of the ignore list as "Unknown" during login which prevents GIL from synchronizing your character ignore lists. If this happens, GIL will print a message duing login and then attempt to synchronize when you open the GIL UI. You can also force a sync by a chat command line.

* There is an issue where WoW reports the wrong server name when ignoring someone from right clicking chat. When a character with no server name is reported, GIL will search the members of your current raid, battlegroud, instance, and so on to try to find someone with that name. It wlll check your chat tab history and search for any reference of the name in order to determine the server. If no data is found during this search, GIL will ultimately assume the person is on your server.

* Account wide ignore only works for up to 50 accounts per character due to a WoW limitation. GIL uses logic to select the "best" 50 players on a per-character basis, in an attempt to maximize usefulness of account wide ignore limitations. No other ignore addon can do this. This is significant because it prevents you from messages, duel requests, being grouped in a dungeon, BG, or LFR queue system for not only their main character but for their alts that you don't know about too. GIL will also perform all of those same checks and warnings for non-account wide ignore. 


----


== HOW TO CREATE SPAM FILTERS

GIL has a series of default spam filters that will be periodically updated as
new annoying chat spam is encountered, but it also allows you to create your
own custom chat filters! Filters can be edited by double clicking them, or
added and deleted with UI buttons.

Each chat filter consists of a series of tags which define what to "search" for
in each chat message. When one of these tags is "TRUE" in a chat message, then
the message will be filtered. The filter system also allows for built in logic
to create complex filters, but more on that later.

Tags are enclosed within [] characters and can be used to filter items, spells,
achievements, word matches, partial word matches, and any link. The following
tags are available to perform each of those types of filtering:

**[word]**

The word tag looks for a whole word within the chat message. The word to search
for must be provided within the tag with an equals sign such as: "[word=anal]".

Word and partial word matches are case insensitive, so ANAL anal and AnAL will
all match the tag shown above.

**[contains]**

The contains tag is similar to the word filter, but performs a partial match of
a word instead of a whole word match. If for example, you see people spamming
analanalanal [Thunderfury], then you might want to add a tag with something like
[contains=analan] so that it will catch people who do that sort of spam.

**[link]**

The link tag matches if the chat contains any linked content at all, which can
mean a spell, item, achievement, etc.

**[spell]**

The spell tag allows one to filter out specific spell links or all spell links
from chat. If the spell tag exists with no equals, then it will filter when
the message contains ANY spell link at all. For example "[spell]". If the
equals sign is provided and followed by a Spell ID, then only that specific
spell ID will be filtered. Such as "[spell=17]" would filter any message with
the Power Word Shield spell linked in it.

**[item]**

The item tag allows one to filter out all item links or specific item links.
This tag works in the same way that the spell tag does. For example "[item]"
will filter if any item at all is linked, whereas "[item=19019]" would filter
any chat message that contained a link for Thunderfury.

**[talent]**

The talent tag works just the same as the spell and item tags.

**[achievement]**

The achievement tag works just the same as the spell and item tags. For the
sake of trying to keep this short and refer you to the item and spell examples
above.

**[pet]**

The pet tag works just the same as the spell and item tags. For the
sake of trying to keep this short and refer you to the item and spell examples
above.

**[icon]**

The icon tag allows filtering based on raid icons in the chat text. The
"[icon]" tag by itself will result in a filtered message if the chat message
has any icon at all in the text. A number can also be provided to filter
based on if a message has a specific number or greater of raid icons. For
example "[icon=3]" would filter if the message has 3 or more raid icons in
it.

**[community]**

This tag allows filters to be created to filter out community Join requests.
No other data is used for this tag; If you wish to filter anything that
contains a Join request, simply include this tag

**[nonlatin]**

This tag allows filters messages that contain Chinese/Japanese/Korean characters
for those who play on English servers that have a strong native Asian speaking
community

**[words]**

This tag allows filters to test that a line of text contains only a specific number
of words.  For example: [words=2] would be true only if the text contained only two
words.

**[channel]**

This tag allows filters to test that a line of text sourced from a specific channel
number.  For example, channel 1 would be zone, 2 would be city/trade, and so on.  If
you wanted a filter to apply only to trade chat you could do "[channel=2]" somewhere
in your filter.

**USING LOGICAL EVALUATION:**

Chat filters can include some logical evaluations by enclosing tags within
parenthesis and using boolean "and or not" keywords. This is really what can
tie everything together and allow for some pretty nice filters to be created.

For example, here is the default "Anal" spam filter which comes with GIL:

([word=anal] or [contains=analan]) and [link]

The parenthesis and the or keyword allow the filter to specify that if the
chat message has a complete word match of "anal" OR it contains a partial
word match with "analan" AND the chat message contains any link meaning
any item spell or achievement, then the filter is TRUE and the message
will be filtered by GIL.

=> CHAT COMMANDS

The following commands are accessible by typing /gignore or /gi in the chat box:

/gi - Show a list of available chat commands

/gi gui - Open GIL ignore list GUI

/gi list [days] - Show a list of all players on the global ignore list, along with their server, faction, and the date they were added to the list.  An optional number of days can be added if you'd like to only show people who have been on the list for [days] or more days

/gi clear - Clear the global ignore list.  Please understand that clearing this list means that you are clearing everything on all characters that you've previous logged in as!  You will need to provide a follow up confirmation command before the clear will work

/gi add player_name - This provides a way to add a player to the list, but the Blizzard UI and /ignore works too!  You can optionally add a reason as well.  If a server name is involved all spaces should be removed.  For example: /gi add mytoon-Area52 this is an ignore reason

/gi ignore player_name - This provides a way to add a player to the list, but the Blizzard UI and /ignore works too!  You can optionally add a reason as well.  If a server name is involved all spaces should be removed.  For example: /gi add mytoon-Area52 this is an ignore reason

/gi remove player_name - This provides a way to remove a player from the list, but the Blizzard UI and /unignore works too!  GIL also applies a number to each person on the list (see the list function) and the number can be used to remove too.

/gi delete player_name - This provides a way to remove a player from the list, but the Blizzard UI and /unignore works too!  GIL also applies a number to each person on the list (see the list function) and the number can be used to remove too.

/gi filter on|off - If on, GIL will check all incoming chat messages and compare them to the ignore list.  If a message is found from someone on the ignore list, the chat message will be filtered.  This provides a "simulated" ignore effect if the ignore list grows beyond 50 characters.

/gi showmsg on|off - GIL will synchronize the list upon logging into a character, and any actions taken will be printed into the chat window unless this option is turned off.  For example, if a person is added or removed from the ignore list a message will be printed in the chat.

/gi sameserver on|off - Synchronize only with same-server characters.  If on, only characters on the same server and faction will share ignore lists.  If off, characters on the same faction but on different servers will share ignore lists.  Remember!  There is a limit of 50 ignored players, so using cross-server ignore lists can really make you hit the limit quickly if you have an itchy ignore finger!

/gi prune days - This will remove all persons from the list that have been on the list more than [days] days.  For example "/gi prune 90" would remove anyone who has been ignored for 90 or more days.  You will need to provide a follow up confirmation command before the clear will work

/gi expire character days - Sets expiration for [character] after a number of [days]

/gi npc npcname - Toggle NPC ignore for npcname

/gi server servername - Add or remove a whole-server ignore

=> VERSION HISTORY

=> 8.2.2 retail (1.13.2 classic)

Swapped the create and remove filter button in the chat filter editor, and added a confirmation dialog box when a filter is requested to be removed

Added the new "[words=#]" tag which can be used to compare the number of words in the chat text

Added new "[channel=#]" tag which allows a filter to be applied only to a specific channel

Added the ability to disable filtering of party chat.  This includes, party, raid, instance, and battleground channels.  This open is off by default.

Added the ability to disable or enable filtering of private messages.  This option is on by default.

Updated the default "Anal" spam filter to utilize the words count, to address people who do not link a spell or item and instead type the name

=> 8.2.1 retail (1.13.1 classic)

Added option to never apply spam filters to Guild chat.  This option is turned on by default in the options tab.

=> 8.2.0

Fixed a residual 8.1 issue that was causing GIL to fail to remove players on synchronization

Updated to 8.2

=> 8.1.4

Spaces can now be used in a [Contains] tag by escaping the character similar to parenthesis, brackets, and backslashes ie "[contains=Filter\ This]"

=> 8.1.3

More updates related to the annoying undocumented changes Blizzard made in 8.1

=> 8.1.2

Fixed Blizzard UI ignore button and chat command for ignore which was broken by the 8.1 update

=> 8.1.1

Added a new UI hack to work around Blizzard's new "feature" that no longer creates ignore events when you're at 50 ignores and you try to ignore by right clicking chat.

=> 8.1.0

Updated for WOW 8.1

=> 8.0.3

Changed the way the Synchronization list works on login.  In the past there was a lot of strange things going on to avoid some WoW bugs but I am hoping those have been fixed now.  The worst that could happen is you may get more messages that the list could not Synchronize on login.

Changed the way some of the message filtering works upon login to hopefully make things slightly cleaner.

Major changes when adding people to ignore by right clicking chat.  WoW has a bug where it sometimes does not report the server name which causes almost all complaints with the addon. I reported it during Legion but it was not fixed for BFA and I was not in Beta to know before release.  So now whenever GIL gets an add/remove ignore request without a server name, it will search the members of your current group, raid, battleground, and current chat tab text for any evidence of the person.  If a reference to their name is found it will use that server. This was a lot of work and there may be issues so please be aware that this version could either be buggy or it could fix all known issues in a single swoop lol :)

=> 8.0.2

GIL will now pop up a dialog box to warn you when an ignored player joins a party you are in, or you join a party with an ignored player.  This dialog box will automatically close after 15 seconds if it is not closed before that since people can join in mid-combat.

GIL will print a warning and list of players to the chat window if you join a party with ignored players, or if an ignored player joins a party you're already in.

Fixed a bug which could cause the ignore functions to not work properly when ignoring from the party frames

Fixed a bug that could cause the "You are inviting an ignored person to your party" confirmation box to not display when inviting by typing a chat command

=> 8.0.1

Added a new tag [community] which can be used to block Community Join requests in chat.  A new default filter has been created for this, but it will default to being turned off.

By request: Added a new tag [nonlatin] which can be used to block Japanese/Chinese/Korean language.  This was requested to add the functionality of another addon called "BlockChinese" by Ketho.  If you're not interested in all of the features of GIL and just want the Chinese blocking, be sure to check out their addon!  Added a default spam filter to do this, but it will be disabled by default.

Filters can now include brackets and parenthesis in the contains and word tags but prefixing them with a forward slash.

Updated the default Guild Recruitment filter to be better at doing its job

=> 8.0.0

Updated for Battle for Azeroth expansion

=> 7.1.4

GIL was not filtering the "Instance" chat channel

=> 7.1.3

GIL now has a "sync" chat command to force the ignore list to synchronize.  IE: /gi sync

If the ignore list is unavailable for synchronization during login, GIL will now detect it, print a message, and attempt to automatically sync the ignore list whenever the GUI is opened.

Filters now can be enabled or disabled within the filter editor

Added new filter for guild recruitment spam which defaults to being turned off.  If you want to use it, edit the filter and turn it on in the filters tab.

More localization work completed

Updated for 7.3 release

=> 7.1.2

Ignored players who attempt to invite you to a group will now be automatically declined by GIL even when not on the account wide ignore list

Ignored players who attempt to duel you will now be automatically declined by GIL even when not on the account wide ignore list

Players are now given a warning and confirmation box when sending party invites to an ignored player

Fixed some issues when ignoring by right clicking on a target frame or raid frame which could cause GIL to ignore the target instead of the right clicked person.

Minor localization work

=> 7.1.1

Updated default spam filters

Fixed a problem where the Test button in the filter editor was not case insensitive, causing some tests to report the wrong result

Added a help button into the filter editor for the filter box

=> 7.1.0

Updated default spam filter
Fixed a problem where NPCs with inconsistant casing in their names would not be properly be ignored

=> 7.0.6

Fixed a problem where a filter that had an error in it could cause all chat to not be filtered

Updated default spam filters

=> 7.0.5

Fixes problems with shift click linking

=> 7.0.4

Updates to default spam filters

Completely redid the Spam Filter editor!  So many shiny new things:

When editing a spam filter, the total number of spammers blocked by that filter will now be shown

Reworked the Filter input box in the filter editor to allow for a larger input area

Cleaned up the display of the filters in the Chat Spam tab so they do not wrap down to the next line.

Added a chat link resolover where items can be linked into the box and converted into a GIL tag

Shift clicking any chat link inside the Spam Filter box will automatically insert a GIL tag for that particular item, spell, achievement, pet, etc.

Added an awesome filter testing system built right into the Spam Filter editor!  You can now enter examples of chat text and press the Test button to test applications of the filter you're building.  It will also tell you if it thinks there is an error in your filter.

=> 7.0.3

Added the [talent] tag to the spam filter and into [link] tag

=> 7.0.2

Accidentally left some debug stuff turned on

Fixed a typo which could have caused some issues on startup

=> 7.0.1

Added a new [icon] tag that can be used to evaluate raid icons

Added a new [pet] tag that can be used to evaluate battlepet links in chat

Rewrote the word matching to fix many situations where the word matching would fail, such as when icons and words were used together like {star}test{star}.  GIL will now see "test" as its own word even though its sandwitched in between two icons with no space.  The same works for all link types (spells, items, achievements, etc)

Statistical tracking for the various chat filters is now completely accurate.  In the past it was overestimating a bit.

Now should use about 250% less memory when under high stress and overall less CPU cycles in general

Added some more startup code to try to work around the "Unknown" problem with WoW's API.  This problem could have caused the ignore list to get deleted, or the addon not to load

=> 7.0.0

Updated for new expansion and pre-patch 7.0!

Added some more code to hopefully prevent the "Unknown" problem in non English languages.

Words will now have punctuation stripped from the end of them before applying the word-matching chat filters to them

=> 6.2.19

Added back in the old startup code which seemed to better prevent things from turning bad better than the new approach whenever Blizzard's API returns Unknown for everyone

Updated default spam filters to fix a typo

=> 6.2.18

This update adds some new default spam filters.  I sat on a high pop server in Orgrimmar and created filters until I saw no spam.  I blocked 1283 spammers during that time!

=> 6.2.17

Fixed a bug in the chat filter system which could cause an error when certain items are linked

=> 6.2.16

Fixed a typo in a variable name that could allow "Unknown" characters to be added to the ignore list and maybe other unknown things.

=> 6.2.15

Fixed an conflict with some other addons which could cause some errors since the 6.2.12 release

=> 6.2.14

Changed the way the addon starts up.  This may end up causing problems but it also may end up fixing a problem that a couple people seem to have with the latest couple of versions.  If anyone experiences problems please let me know so that they can be addressed!

When editing a spam filter, GIL will now always save the contents of the editor when the Save Filter button is clicked, even if you haven't pressed ENTER yet.

New option to "Automatically Synchronize Default Spam Filters" will create or update your spam filters to include all of the latest default spam filters.  I will be creating new default filters as I encounter spammers that are not already covered.

=> 6.2.13

Just a small update that may or may not fix an error someone seems to be getting

=> 6.2.12

I've begun doing some more localization work, starting with German but that is not in this version.  I hope to have it done by the 7.0 patch update.  If anyone would like to help with a translation please let me know.

Added a chat spam filter system that allows you to define your own chat filters so that only exactly what you want to filter is filtered!  This of course can be disabled if it is not desired.

Completely revamped all of the code to be much cleaner and easy to work with

=> 6.2.11

Removed the "Attach window to friends list UI" option because it wasn't very useful and some found its reason to be confusing

Removed the ability to disable chat filtering

When responding with the "You are being ignored" message, GIL was sending one message "You are being ignored" message back to the person on ignore for each chat tab you had.  If you had many tabs, it would basically spam the person you have on ignore! :P  This has been fixed so it only sends the message once.

I hope to have fixed an EPIC bug that was prevent the addon for filtering chat on some servers that have two or more words in their name.

Added a server name translator for all US/EU servers to make the server name column look pretty, instead of things like "Theforgottencoast" you should now see "The Forgotten Coast".

=> 6.2.10

Redesigned the way GIL detects deleted characters when maintaining the account-wide ignore list.  This is a big improvement over the old system assuming there are no quirks!

=> 6.2.9

Relaxed the automatic character deleted removal from the ignore list, just in case there are quirks after someone mentioned weirdness.

Began work on the spam filtering but I've disabled it for now until its in better shape.  But you'll still see the tab in the UI for now.

=> 6.2.8

Fixed problem where a person could still show up in chat when on the same server and with a larger ignore list size.  I broke this during the UI revamp but wasn't able to get to it do to holidays.  Sorry everyone.

=> 6.2.7

The /gi npc chat command can now remove NPCs by list number

The GIL UI ignore list wasn't always being updated when ignoring NPCs and entire servers.  These quirks should be fixed now.

=> 6.2.6

GIL can now track character name changes and characters who've been deleted from the *account wide* ignore list.  Players will be added added to and removed from the Global ignore list as expected when these situations are identified.  Blizzard doesn't have a mechanism for this type of tracking within addons, so GIL does it own historical tracking to determine these things.  Because of this, it may take a couple of logins before GIL decides to take certain actions against certain character names.

Added a new option to toggle off name change and deletion tracking just in case anyone wants it to work like it did before this version.  But this option may go away in the future if the new system is a hit.

GIL now filters "Player is already ignored" messages for the first 60 seconds of login

Fixed some bugs that could cause the GIL UI list not to be updated when adding/removing players

=> 6.2.5

Fixed a error that would occur after setting the default expiration using the Options tab (chat command still worked).  If you've changed it from the default 0 value then please double check the value again after installing this version, as GIL may reset the value if it was stored incorrectly in the settings by the previous version.

=> 6.2.4

The "Open/attach window with Blizzard Ignore list" options were always set to true regardless of what you changed it to.  It should now work as expected.

=> 6.2.3

NPCs can now be added and removed from Ignore by clicking on their portraits!

Renamed "server" chat option to "sameserver" and better described what it actually does

GIL can now ignore entire servers.  Use /gi server servername to add or remove a server by name or list number

GIL now responds with a "You are being ignored" message in cases when WoW itself will not.

Fixed a small display bug on the ignore list UI

NEW GUI!  By default the new GUI opens with the Friends/Ignore list but this can be changed in the options.  The GUI can also be started by typing /gi gui in chat too.

=> 6.2.2

Fixed a bug with removing players using right click on their portrait

Added a filter for the "You can't ignore more players" message but I was not able to properly test this.

=> 6.2.1

Localization!  All text has been localized, which means that GIL can be translated to languages other than English!  I will need volunteers though, as I only speak English and broken Spanish.

Possibly fixed some weirdness with right clicking a portrait to ignore

Extended the amount of time GIL filters the "ignore" messages on login to 60 seconds, up from 15.  This should help with any spam some people would randomly get during login but be aware all ignore messages will be filtered for the first 1 minute of each login

You can now set expiration time using list numbers instead of name.  So /gi expire 40 365 will expire the 40th person on the /gi list after 365 days.

=> 6.2.0

Updated for Patch 6.2

=> 6.1.8

Right clicking a target UI and selecting "set focus" was causing an error.  Focus worked when using /focus or hotkey or macro, but not from the unit right click menu.  I had to completely redo the way the target ignore option works but it should be fixed.

Fixed a bug when attempting to ignore by typing /ignore with a current target

=> 6.1.7

By request, the list chat command now shows the reason/notes for each player if there is one

=> 6.1.6

GIL can now optionally ask you for the ignore note when a person is ignored.  This is on by default but it can be turned off by with /gi asknote off and turned on with /gi asknote on

The right click menu in the ignore UI now has a "Reset expiration" option

Pressing enter while editing the ignore note now does the same thing as the Save button

Pressing escape while editing the ignore note now does the same thing as the Cancel button

Pressing enter while editing the expiration days now does the same thing as the Save button

Pressing escape while editing the expiration days now does the same thing as the Cancel button

=> 6.1.5

/gi add now checks the current target and will ignore them if there is no player name supplied

/gi npc now checks the current target and will ignore it if there is no NPC player supplied

=> 6.1.4

The speed of the screen updating when scrolling around the ignore list UI has been greatly improved

GIL now ignores the "Player not found" chat messages for 10 seconds after GIL is loaded, instead of the first 10 seconds after login

GIL can now ignore non player characters (NPC and monsters) yells, emotes, says, tells, and party chat

New command /gi npc npcname adds or removes an NPC character from the ignore list.  Example: "/gi npc snurk bucksquick"

New /gi list option "NPC" will show a list of all ignored NPC characers.  Here are some examples of the list command:

	"/gi list"  List all characters on global ignore list
	"/gi list npc"  List all NPC characters on global ignore list
	"/gi list 30"  List all characters on ignore list from 30 days or more
	"/gi list server"  List all characters ignored from the current server
	"/gi list Area52" List all characters ignored from the Area 52 server

=> 6.1.3

An "Ignore" option is now added to the targeted player menu while in a Raid group

An "Ignore" option is now added to the targeted player menu while in a party

GIL now has an automated expiration system which allows players to be automatically removed after a specified number of days.  This can be set using the UI or chat commands, and a default value for all newly added ignored players can be set too!

"/gi defexpire days" can now be used to set the number of days that newly ignored players will remain on the list before they are automatically removed.

"/gi expire character days" sets the number of days in which the character should remain on the list.  So for example "/gi expire mytoon 30" will set character mytoon to be automatically removed after being on the list for 30 days.

Right clicking in the ignore tab UI now brings up a drop down menu that allows the note to be edited, the expiration days to be set, or the person to be removed from the list.  Double clicking still provides a quick way to set their note.

The /ignore and /gi add commands now allow a note and expiration days to be supplied.  A simple /ignore works as it always has, but now you can also supply the days after the name followed by a note.  Here are some examples:

	"/ignore mytoon" This will ignore mytoon with the default configured expiration time
	"/ignore mytoon 30" This will ignore mytoon with a 30 day expiration time
	"/ignore mytoon this person is mean!"  This will ignore mytoon and set their note to "This person is mean!"
	"/ignore mytoon 30 this person is mean!" This will ignore mytoon, removing them after 30 days, and setting their note to "this person is mean"

GIL has now been tested and fixed to work with multiple language character sets and unicode/high ASCII characters!

GIL now longer shows "You can't ignore more players" when ignoring a character when the list is larger than the Blizzard maximum

GIL will no longer show itself adding characters during each login when the list is larger than the Blizzard maximum number of ignores

GIL should no longer spam your chat window with "Removing Unknown" on some occasions during login

GIL will now filter out the ignore "Player not found" message from chat during the first 10 seconds of logging in

=> 6.1.2

The ignore by clicking on portraits option had to be scaled back due to Blizzard blocking the add-on when it attempts to modify Blizzard's internal menus.  This happened during dismissing pets, preventing hunters from dismissing until they disabled the addon.  The ignore feature is still there and works, but it just always says "Ignore" now, and serves to toggle the state of ignore for that person.  Better than nothing I suppose, but not as nice as it was.

=> 6.1.1

/gil now works same as /gi and /gignore

The /gignore add and /ignore functions can now specify a reason for ignore, for example 
"/ignore mytoon-Area52 this person is annoying".  If a server has a space in the name just leave the space out.

The default ignore list UI now shows the days a person has been in the ignore list

The default ignore list UI now shows the reason/note in the ignore list

Double clicking on a character name in the ignore list UI allows the note to be edited

Mousing over a name in the ignore list UI now shows a tooltip with character name, faction, how long they've been ignored, their note/reason, etc.

/gi ignore now does the same as /gi add 

/gi delete now does the same thing as /gi remove

Right clicking a target portait now gives an "Ignore" option in the option list

=> 6.1.0

Updated for new 6.1 patch.  I'm also working on some UI stuff too for future versions but progress has been slow mostly due to raiding! :)

=> 6.0.4
The /gi list command will now round the number of days a person has been on the ignore list to the nearest whole number

If you try to ignore yourself, you will now get a message telling you that you can't!

GIL should now be able to ignore login and logout messages even when you have more than 50 people on your ignore list!

The /gi list command now assigns a number to each person in the list and the /gi remove command can now remove people by number making things much easier when you have to deal with people using special characters in their name.  Removing by name should still work too!

=> 6.0.3
Added a chat filtering option which (if enabled) will filter chat messages and remove people on the ignore list if a message from them is found.  This allows a way to get around the 50 player ignore limit per character!  This feature will be on my default but it can be turned off by typing /gi filter off.

=> 6.0.2
When ignoring a player by right clicking their name in chat and selecting ignore on a server that has a space in the server name, the addon would fail to synchronize and ignore the player.  Sorry :(

The gi list chat command can now have the server name passed to it.  Here are some examples:

/gi list : Shows all people on the ignore list
/gi list 90 : Shows a list of all people on the list for 90 or more days
/gi list Area 52 : Shows a list of all people on the list from server Area 52
/gi list server : Shows a list of all people on the list on the current server

=> 6.0.1
The list command now shows the number of days the person has been on the ignore list instead of a date

The list command now optionally can take a number of days and it will only list players on ignore for that many days or longer.  For example "/gi list 30" would list only people who have been on the list for 30 or more days while "/gi list" would show all people on the list.

Added a new command called prune.  This will allow you to remove people in bulk who have been ignored for a specified number of days.  For example "/gi prune 30" removes all people who have been ignored for 30 or more days.


=> 6.0.0
First release of Global Ignore List
