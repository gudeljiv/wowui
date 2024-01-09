# ClassicCastbars

## [v1.7.5](https://github.com/wardz/ClassicCastbars/tree/v1.7.5) (2024-01-07)
[Full Changelog](https://github.com/wardz/ClassicCastbars/compare/v1.7.4...v1.7.5) [Previous Releases](https://github.com/wardz/ClassicCastbars/releases)

- add more bfd casts to uninterruptibleList  
- typo  
- trigger target castbar auto position on UNIT\_AURA aswell, fixes it sometimes being slow to update position correctly  
- add workaround for channeled casts not being shown due to a Blizzard bug with UnitChannelInfo() for months now (#82)  
- trying possible fixes/tweaks for castbar sometimes ending prematurely, but this is most likely happening because of Blizzard not triggering UNIT\_SPELLCAST\_DELAYED correctly on the client for pushbacks  
- use same target castbar anchoring as wotlk for classic era  
- add more spells to uninterruptible list  
- fix party frame testmode not working outside of groups (raid frame testing still requires being in a group)  
- check castID here instead of UnitIsUnit player  
- code cleanup  
- show err if option module is set to disabled when typing /castbar command  
- cleanup uninterruptibleList & npcCastUninterruptibleCache  
- use spellIDs instead of spellNames for classic/tbc data  
- remove/rework more old redundant classic era pre 1.15.0 stuff  
- remove more obsolete classic era 1.15.0 stuff  
- reset player castbar font aswell when switching game client language  
- remove old classic era code no longer needed after patch 1.15.0  
