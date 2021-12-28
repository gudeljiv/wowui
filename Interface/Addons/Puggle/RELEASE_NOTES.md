RELEASE NOTES:
  - v1.0: 
    Basic list of players sending LFG requests in channels
	
  - v1.1: 
    Sound on open/close 
	Close button
	Minimap button
	Settings tab, options to show/hide minimap button, show a message on new group request parsed , play a sound on new group request parsed
	Changed Idle timeout to 5min
	Added this Readme file
	
  - v1.2
    Updated sounds
	2-pass parsing of request for better recognition of actual group requests
	Miscellaneous bucket for non-instance groups (Hogger!)
	Instance Level brackets
	Color coding for instances not in player's level bracket
	Settings option for color coding
	Updated /who request to return unique results
	Truncated request text to prevent time overlap
	Fixed issue with Scarlet Monastery requests all ending in SM:Graveyard
	Updated credits 
	
  - v1.3
    Made the frame moveable
	Color coding changed to have green and red for lower and higher instances
	fixed an issue where players were shown in "Temple of Ahn'Qiraj" instead of "Sunken Temple" 
	
  - v1.4 
    Fixed an issue with a missing lib  >.< sorry about that
	Externalized the search tags and instance names ta make them easy to localize
  
  - v1.5
	Fixed an issue where special characters in chat requests were being problematic
	Fixed an issue where the class icon would not appear on non english clients
	Added a setting to hide all request that are not level appropriate
	Removed a potential leak in frame creation
	
  - v1.6
    Requests listing several instances will now appear in the various instance lists (ex "LFG lib/cath")
	The chat command "/pug sound" now toggles the notification sound
	The Puggle window has been enlarged to fit more information
	Hovering a request now shows the full request message, as well as when the initial request was made, and when the last 'refresh' of this request was made
	Fixed an issue where the minimap button would reappear even when toggled off
	Chat alert messages now include the dungeon
	Several more special characted are now handled in requests (ex "LFG RFC? anyone?" will now correctly go under RDC, not Misc)
	There is a new setting option to change the sort order (newest request at the top or the bottom)
	A couple keybindings have been added (toggle UI, toggle notification sound)
	The "Idle Timeout" is now available in settings. You can configure how long a request stays before it gets cleaned up. Note, this idle timeout is reset whenever a refresh request (same player/dungeon) is received.

  - v1.7
     A new button has appeared in the settings, giving you the option to add/remove/translate/adjust your own search tags. 
	 The tags are still saved in your SavedVariables file, to make them easy to share with others if needed.
	 You can now disable the automatic /who request that retrieves class and level of players sending group requests. 
	 This was done as it can queue up at peak times and cause interference with other addons.
	 A "/who" button next to the chat requests is now available to send the /who request manually. This is only really applicable while the automatic /who is disabled. The button will show as disabled while the /who request is pending
	 Some group requests were creating duplicates under the same dungeon. This has been fixed.
	 Some players with unicode characters in their name could not be retrieved with /who. This has been fixed
	 Selecting "Only show level-appropriate requests" will now also filter out requests from players that are over or under 5 levels from yours. Obvisously this will only work once the level of the requester is known.
  
  - v1.8
	following a hotfix from Blizzard preventing /who commands to be called repeatedly b addon:
	The auto /who option has been removed
	The manual who button now has a cooldown of 10seconds.
	
  - v1.9
	A new option to select which dungeons to show can be found in the Settings, next to the dungeon name and tags. Untick the checkbox to skip those dungeons.
	Note that this setting is "Per character". All other settings are "Per Account"
	There are now 3 "User Defined" groupings you can use to define your own searches. For example you can make the addon flag all "LF enchanter" requests.


  - v2.0
	Big changes in this version: 
	- The who libraries have been abandoned, and replaced by a manual call to the /who command. This can still be done by the addon, but if it remains problematic you can untick the box in settings to only have the addon prepare the /who command for you.
	New tabs have appeared: "My Groups" and "Players"
	"My groups" records all the groups you have taken part in. It lists the players, their class/race/gender, their level (at the time) and their guild (at the time)
	That tab also lets you put a rating on players ou grouped with,  and comment on how they did or comment on the whole run. You can come back to this screen later and check on people you grouped with in case you don't really want to group with them or ginvite or whatever.
	"Players" gives you a sortable list of players you have grouped with, and their latest rating (i.e. the rating you gave them in *last* time you grouped with them)

  - v2.1
	The search tag customization now has its own tab
	The addon window is now resizable vertically (right click / drag)
	The duration shown next to the LFG request is now the time "since last request", not "total time in queue"
	Fixed an issue where Night Elves would not show properly in /who results
	Fixed an issue where some debug prints were still showing in chat
	Fixed an issue where sound and chat notifications would still show for unselected instances

  - 2.2
    Fixed an issue were players from deleted groups would still show in the player list, with a level of 0
	Added an option to toggle all dungeons on or off
	Added keybinds to open the groups or players list directly, and one to toggle all dungeons on/off
	Added a broker interface to quickly access Puggle from your bar addon (only tested on Titan - feedback about others welcome)
	Fixed an issue where interface for groups would show even though no groups were made on current realm

  - 2.3
	Export your player ratings data to http://warcraftratings.com/puggle to see everybody's ratings on your realm
	Head to the 'Players' tab and click the export button. Copy the data that pops up and paste it in http://warcraftratings.com/puggle/upload
	The players' guild information should now be correctly recorded and saved
	A new option to not see the Miscellaneous category has been added
	The "RaidFrame" error caused by UIDropDown tainting should have disappeared.
	The groups dropdown list now breaks down the groups by date first.
	The ratings you have given to players now show under the LFG requests tooltips
	A new checkbox in settings to toggle the tracking of groups

 - 2.4
	The MISC options will now correctly show inside the settings frame
	Fixed an issue where the sound and chat notifications were still occuring for unselected dungeons
	The requests and who buttons will now still reset themselves correctly when the Minimap button is hidden
	The LFG request tooltip now give the star rating of players if available

 - 2.5
	Changing the 'track groups' setting while in a group should no longer cause a lua error
	Fixed an issue where a lua eror would occur upon joining a group

 - 2.6
	Automatic disable when in an instance
	Tracking of requests coming through guild chat
	A Blacklist is now available to disregard requests containing specific keywords.

 - 2.7
	Fixed an issue where some LFG requests were not being picked up.