# <DBM Mod> World Bosses (DF)

## [10.1.25](https://github.com/DeadlyBossMods/DBM-Retail/tree/10.1.25) (2023-08-29)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Retail/compare/10.1.24...10.1.25) [Previous Releases](https://github.com/DeadlyBossMods/DBM-Retail/releases)

- Push new DBM update out for some bugfixes  
- tweak timer classifications on kurog  
- Make the test bars a mix of next timers and cd timers  
- DBT Update: - Simplified Timer type will now be stored in timer object directly so it doesn't have to be re-generated every time a timer starts and fires a new callback - cooldown timer objects will no longer store ~ in timer text and instead use unified timer text. the ~ will now be displayed in timer itself to signify cooldown bars, same way Bigwigs does it. - Timer start callback no longer needs to strip ~ from timer text since it's not in timer text anymore, making unified timer  
- Move monk over to spec based spell check so interrupt available (or unavailable) to all 3 specs based on whether or not the talent was picked up. Note, this still only really applies to initial/default settings.  
- bigwigs now uses a unified core as well, so same version for all games  
- update retail bw version detection, which was a bit dated  
- Fix countdown override so it actually sends dbm pull timer  
- slight timer tweaks  
- Eliminate backwards compat with old bnet apis, since that's actually dead too as of 1.14.4 (well not dead, it still works, but the new ones now exist in classic flavors)  
- Bump alphas  
