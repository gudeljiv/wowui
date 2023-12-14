# Details! Damage Meter

## [Details.20231214.12109.155](https://github.com/Tercioo/Details-Damage-Meter/tree/Details.20231214.12109.155) (2023-12-14)
[Full Changelog](https://github.com/Tercioo/Details-Damage-Meter/compare/Details.20231201.12097.155...Details.20231214.12109.155) 

- General Fixes, Backend Improvements, Library Updates.  
    Release Documentation:  
    - Classic now uses the same combat log reader as retail (Flamanis).  
    - Merged Rage of Fyr'alath spells (equara).  
    - Added Rogue Ambushes to merged spells (WillowGryph).  
    - The Remove Common Segments option now also removes segments trash between raid bosses.  
    - Fixed an issue where auras applied before combat start, such as Power Infusion and Prescience, which are counted towards the target, were not being accounted for.  
    - Added to Combat Class: classCombat:GetRunTimeNoDefault(). This returns the run time of the Mythic+ if available, nil otherwise.  
    Technical Notes:  
    - Classic now uses retail parser.  
    - Combat class now have the member: classCombat:GetRunTimeNoDefault(); Returns the run time of a M+ (after completed).  
    - The Utility class's buff scan at the start of combat has been improved, and the code has been cleaned. Also, the scan runs now on the next frame after combat start.  
    - Augmentation Evoker won't track auras from the combat start aura scan, if the player isn't in combat (example: a player in the group enters in combat).  
    - Remove tier bonus for Augmentation Evoker Ebon Might damage prediction and nerfed Close as Cluthmates to 10%.  
    - Segments Container's ResetDataByCombatType() now supports multiple combat types per classification.  
    - Code cleanup on Segments menu code to use the new Mythic+ functions added to Combat class.  
    - Mythic+ start detection produced errors if a WORLD\_STATE\_TIMER\_START event triggered before the CHALLENGE\_MODE\_START event.  
    - Mythic+ finish code was bugging when 'time' returned by C\_ChallengeMode.GetCompletionInfo() wasn't being checked again nil value.  
    - Rogue's Ambush ability and Rage of Fyr'alath spellIds added to override\_spellId within the parser.  
    - Details! Framework updated.  
    - Open Raid Library updated.  
- Merged Rage of Fyr'alath spells  
- Merge pull request #636 from Flamanis/master  
    Use original cleu handler for Era.  
- Merge pull request #638 from WillowGryph/WillowGryph-patch-1  
    Update parser.lua  
- Update parser.lua  
    Added Rogue Ambushes to parser  
- Framework Update  
- Fixed an error while doing mythic+  
- The option to remove common segments now also removes trash between raid bosses  
- When a new segment starts, check for buffs to credit to the target as well (power infusion, prescience, and others)  
- Added classCombat:GetRunTimeNoDefault(): return only the mythic dungeon elapsed time, return nil if the values isn't found  
- Use original cleu handler for Era.  
