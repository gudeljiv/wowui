# [5.7.2](https://github.com/WeakAuras/WeakAuras2/tree/5.7.2) (2023-10-02)

[Full Changelog](https://github.com/WeakAuras/WeakAuras2/compare/5.7.1...5.7.2)

## Highlights

 - Add a few new Fonts
- Improve Trigger UI/UX
- Bug fixes
- Enable boss units in WoTLK 

## Commits

InfusOnWoW (17):

- Fonts: Add a selection of Fira fonts
- BTW: Handle TOOLTIP_DATA_UPDATE which fixes tooltip data after first login
- Fix tooltip calls for old BT2 UnitAura usage
- Make some lua annotations
- Introduce GenericTrigger.GetPrototype and use it
- Fix multi-selection with new trigger/load layout
- TTS: Use a better fallback for voiceId
- TTS: Use correct destination
- TTS: Update voices on VOICE_CHAT_TTS_VOICES_UPDATE event
- Fix pvp flag not restting after leaving BG
- BT2: Add InRange check
- Add UnitInRange filter for Health/Power and similar triggers
- Optimize drag and drop some more
- Dynamic Groups: Fix anchorByFrame handling
- Options: Make Dropping and Deleting use a corotinue
- Also use %q for IsSpellKnownForLoad
- Remove unused getWithFocus

mrbuds (19):

- Fix remaining time condition with modRate < 1
- Wotlk: enable boss units
- Fix error in cast trigger's GetNameAndIcon
- Move regionPrototype to Private
- Add tooltip to inRange option and update on ignoreInvisible tooltip
- UI+++ (#4592)
- Use MultiLineEditBoxWithEnter for custom trigger's events field
- Automatic Repair: add strong warning that user should backup their WTF
- Do not let install auras made with internalVersion higher than installed version of WeakAuras
- Dynamic Groups: fix "set parent to anchor" applied when it shouldn't, fixes #4600
- Boss Mod Announce trigger: add Count filter, fixes #4562
- Fix issue with a trigger with a delay converted to custom trigger #4596
- Dynamic Groups: proper fix for anchorByFrame handling
- Support multiple entries for various triggers & load condition
- fix spell's get on focus
- Disable Evoker Essence trigger on classic
- Classic Era: enable zone id option
- Classic Era: enable soft targetting options
- Classic Era: show TTS voice list in actions

