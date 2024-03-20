# <DBM Core> Main Core

## [10.2.30](https://github.com/DeadlyBossMods/DeadlyBossMods/tree/10.2.30) (2024-03-19)
[Full Changelog](https://github.com/DeadlyBossMods/DeadlyBossMods/compare/10.2.29...10.2.30) [Previous Releases](https://github.com/DeadlyBossMods/DeadlyBossMods/releases)

- BUMP retail TOC  
- Only fire DBM\_TimerUpdate if bar exists.  
- Add `DBM\_TimerUpdateIcon` event.  
- Fix https://github.com/DeadlyBossMods/DeadlyBossMods/issues/1004  
- Fix GUI panel button issue Mystical found.  
- Update koKR (#1003)  
- Custom file naming  
- Add package ID's to core toc  
- Sync in latest changes, woopsie.  
- File changes;  
    - Unified merged back into single repo  
    - Builds core using matrixes  
    - Everyone happy again  
- Update config.yml  
- Update localization.br.lua (#478)  
- Update localization.fr.lua (#477)  
- Update localization.es.lua (#475) * Update localization.es.lua  * Update localization.es.lua  
- Update localization.br.lua (#476)  
- Update localization.fr.lua (#474)  
- Update localization.br.lua (#473)  
- Update localization.es.lua (#472)  
- Stop using alternate sync channels for classic flavors, it's unified now, but support backwards compat for a short while on listener  
- Update localization.tw.lua (#470)  
- Update localization.es.lua (#467)  
- Update localization.ru.lua (#468)  
- Update localization.ru.lua (#469)  
- Oh I thought I pushed this. use the string on classic if missing  
- activate classicSubVersion sooner, to prevent it being 0 in early version checks  
- - Prepare Core for unified mod packaging that has both retail and classic now use same sub modules and no longer use custom packaging for classic servers (now that it's getting more complicated with cataclysm) - Added a new versioning system for classic that lets dbm version checks also show sub module versions for cataclysm, wrath, TBC, and vanilla raid mods - Core version will now only use retail versioning in unified structuring. - Core download will no longer include classic raid modules per the unified modules. Classic users will need to download those modules separately but once done will be able to update them more easily going forward. It'll even be possible to just sync retail mods over to classic with unification. All fragmentation is finally eliminated.  
- remove banned mod for azeroth  
- Add post cata utility function  
- tweak last  
- revert forced rename  
- Start using Mainline only toc format for retail only modules  
- need an external cata function  
- update banned mods  
- cataclysm compat fixes  
- bump alphas  
