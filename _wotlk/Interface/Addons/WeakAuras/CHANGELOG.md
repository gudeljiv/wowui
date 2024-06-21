# [5.14.0](https://github.com/WeakAuras/WeakAuras2/tree/5.14.0) (2024-06-20)

[Full Changelog](https://github.com/WeakAuras/WeakAuras2/compare/5.13.2...5.14.0)

## Highlights

 - Performance improvements
- Better support for TWW and Cata features
- New "Search API" side panel for custom code
- Add PT Sans Narrow Regular/Bold as a font choice
- Profiling feature improvements 

## Commits

Boneshock (1):

- Reputation trigger fixes (#5122)

InfusOnWoW (19):

- Combo Ponts Trigger: Add COMBO_TARGET_CHANGED for Cataclysm
- Fix MaxProgress/MinProgress Conditions deactivation
- Power trigger: Align Soul Shard display with base UI
- Fix frame_monitor_callback to use UnitIsUnit instead of string checks
- Readd name/stacks condition accidentally removed in 42830b42b0
- Fix flavor warning for The War Within
- Fix lua error introduced inc 912246ee
- Trigger Build
- Default atlas-update/modelpaths-update to not run on forks
- Fix Hero Talent load option to be its own conjuctionGroup
- Prototypes.lua Remove most nameFunc/iconFunc/stacksFunc/durationFunc
- Spell Cooldown Tracking: Slight rework for overriding spells
- Add PT Sans Narrow Regular/Bold
- Update Atlas File List from wago.tools
- Add WeakAuras.CheckTalentForUnit based on LibSpecialization
- Options: Fix Shift+Click not selecting clipped buttons
- Fix Blessing of Summer Talent load option
- Fetching statusbar_atlas shouldn't fall back to any defaults
- Update Atlas File List from wago.tools

Stanzilla (3):

- Update WeakAurasModelPaths from wago.tools
- Update WeakAurasModelPaths from wago.tools
- Update WeakAurasModelPaths from wago.tools

dependabot[bot] (1):

- Bump cbrgm/mastodon-github-action from 2.1.2 to 2.1.3

emptyrivers (5):

- remove silly whitespace
- hide dynFrame if combat starts with living threads
- fix a missed line in stringbuild change
- add BreakUpLargeNumbers format option
- use table.concat to build various function strings

mrbuds (27):

- TextEditor: add "Search API" side panel (#5170)
- use WA_COMBO_TARGET_CHANGED
- Power Trigger: fix stagger & combo
- fix error on hero talent
- string concatenation optimization for some triggers init
- Talent Known trigger: add Hero Talent option
- Aura trigger: fix role & roleIcon on cataclysm
- Workaround incorrect wrapper for GetSpellCooldown function from deprecated addon
- better fix for GetSpellTexture compatibility
- Spell Cooldown triggers: fix paused spells on TWW
- Don't load WeakAuras when !!WWAddOnsFix is loaded
- Power Trigger spell cost overlay nil error fix
- Fix GetSpellPowerCost on TWW
- Workaround more functions move to C_* namespace on TWW
- watchUnitChange exited before stopping system profile
- Allow register some internal events without specify an ID
- Allow register some internal events with multiple IDs at once
- Enable Alternate Power trigger on cataclysm
- TWW compatibility for loadInternalEventFunc
- Remove legacy GetCurrencyInfo code for Cataclysm (#5108)
- WeakAuras.WatchUnitChange & UnitIsUnit (#5029)
- Profiling window: increase spike & time column width, and make the window resizable
- Profiling: Improve systems categorization
- Check UNIT_INVENTORY_CHANGED only for player
- typo fix
- Remove unused tables
- Optimization for running trigger function less often for following triggers:

