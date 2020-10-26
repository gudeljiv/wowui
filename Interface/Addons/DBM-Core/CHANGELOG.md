# Deadly Boss Mods Core

## [1.13.61-27-g8a22a8a](https://github.com/DeadlyBossMods/DBM-Classic/tree/8a22a8aedd0eba2adc3be455ebf09fdd829df52f) (2020-10-25)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Classic/compare/1.13.61...8a22a8aedd0eba2adc3be455ebf09fdd829df52f) [Previous Releases](https://github.com/DeadlyBossMods/DBM-Classic/releases)

- naxx: refine some timers from logs (#612)  
- Update localization.cn.lua (#618)  
- Noth Update  
     - Fixed adds trigger for classic, emotes don't exist, have to use yell fallback. Unfortunately this basically means no balcony phase adds timers at the moment.  
     - Adjusted some Adds timers to match classic  
     - Added Blink cast warning  
- Grobbulus Update  
     - Injection target warning will no longer be filtered.  
     - Added optional (off by default) SAY for injection  
     - Tweaked cloud timer to be a cd instead of next, it's not as precise in classic as it is in wrath  
- Thaddius Update  
     - Update thaddius arrow object to a dropdown instead of a series of confusing bool options. Also made the standard 4 group option oni by default. After seeing that PTR, classic players definitely need the handholding.  
     - Updated timers based on public logs and videos, tank throw might still need some work  
     - Fixed phase two trigger. In Classic it uses Monster Message, not raid emote  
- Update localization.fr.lua (#617)  
    * Update localization.fr.lua  
    * Update localization.fr.lua  
    Co-authored-by: QartemisT <63267788+QartemisT@users.noreply.github.com>  
- Update localization.es.lua (#616)  
    * Update localization.es.lua  
    * Update localization.es.lua  
    Co-authored-by: QartemisT <63267788+QartemisT@users.noreply.github.com>  
- Update localization.mx.lua (#615)  
- Update localization.ru.lua (#613)  
    * Update localization.ru.lua  
    * Update localization.ru.lua  
    Co-authored-by: QartemisT <63267788+QartemisT@users.noreply.github.com>  
- Update localization.ru.lua (#614)  
- just a comment  
- Merge pull request #609 from anon1231823/patch-214  
    Update localization.fr.lua  
- Update localization.fr.lua  
- Merge pull request #608 from anon1231823/patch-213  
    Update DBM-Naxx.toc  
- Merge pull request #607 from anon1231823/patch-212  
    Create localization.br.lua  
- Update DBM-Naxx.toc  
- Create localization.br.lua  
- Merge pull request #606 from anon1231823/patch-210  
    Update DBM-Naxx.toc  
- Update DBM-Naxx.toc  
- Merge pull request #605 from anon1231823/patch-209  
    Update localization.es.lua  
- Merge pull request #604 from anon1231823/patch-208  
    Create localization.mx.lua  
- Update localization.es.lua  
- Create localization.mx.lua  
- Razuvious Update  
     - Fixed a bug where shout timer did not start  
     - Updated shout timer and taunt CD timer for classic version  
     - Changed shield wall timer to correct object type  
- whitespace cleanup and added missing entries to russian auto translations  
- Fixed bug in classic branch calling a function that doesn't exist with hyperlink hook  
- prep next dev cycle  
