# ClassicCastbars

## [v1.7.8](https://github.com/wardz/ClassicCastbars/tree/v1.7.8) (2024-02-18)
[Full Changelog](https://github.com/wardz/ClassicCastbars/compare/v1.7.7...v1.7.8) [Previous Releases](https://github.com/wardz/ClassicCastbars/releases)

- ensure db.textPoint etc gets updated on recycled frame with same spellname  
- add missing border id entry  
- always show 50% cast when testing no matter what  
- remove obsolete code  
- fix lua error on fresh login when using libsharedmedia border texture  
- add option for changing libsharedmedia's border edgesize  
- C\_UnitAuras doesnt exist in wotlk yet  
- small optimization for isUninterruptible check  
- sanity check  
- switch UnitAura to C\_UnitAuras.GetBuffDataByIndex & slightly optimize logic handling  
- set castbar minmax values immediately on display, instead of waiting for OnUpdate tick  
- remove obsolete if block  
- set these too just incase  
- minor cleanup & performance improvements  
- fix typo  
- move this section into its own function  
