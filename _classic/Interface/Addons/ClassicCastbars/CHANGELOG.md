# ClassicCastbars

## [v1.7.7](https://github.com/wardz/ClassicCastbars/tree/v1.7.7) (2024-02-14)
[Full Changelog](https://github.com/wardz/ClassicCastbars/compare/v1.7.6...v1.7.7) [Previous Releases](https://github.com/wardz/ClassicCastbars/releases)

- fix incorrect border thickness for LSM border  
- minor var name cleanup  
- fix finish flash not always displaying for channeled casts  
- remove old TODO comment  
- activeGUIDs is no longer needed  
- bind cast data directly to frame instead of table & use OnUpdate elapsed instead of GetTime() for cast time values  
- remove showInterruptSchool option, keep always enabled  
- add retail empowered cast support for target (basic, currently doesnt include stages)  
- fix typo  
- set player module default enabled for retail  
- upvalue C\_NamePlate.GetNamePlateForUnit  
- more code cleanup  
- bump lib versions  
- Move 'npcCastUninterruptibleCache' from savedvar into local var as its no longer needed. Cleanup CheckCastModifiers()  
- minor cleanups  
- OnOptionChanged() force update all visible frames, not just active testing ones  
- bump toc versions  
- merge position XY localization text into one  
- update README.md  
