# <DBM Mod> Raids (DF)

## [10.2.38](https://github.com/DeadlyBossMods/DeadlyBossMods/tree/10.2.38) (2024-05-07)
[Full Changelog](https://github.com/DeadlyBossMods/DeadlyBossMods/compare/10.2.37...10.2.38) [Previous Releases](https://github.com/DeadlyBossMods/DeadlyBossMods/releases)

- Kill off legacy prefixes so DBM can cut registered prefixes by 2. Any users still on these old versions will no longer be supported.  
    Bump ToCs for patch 10.2.7  
- Cull direct TimerTracker usage, with 10.2.7 going live tomorrow, this code is no longer needed.  
- Disable guild version check comms while in instances to reduce comms sent during version checks overall by 33%  
    Cleaned up and synced up some addon comm code to be consistent across board.  
    Added debug prints for comms that fail in 10.2.7+ and cataclysm+  
- Update koKR (#1073)  
- At first I set altOptionId to any to avoid another LuaLS bug, but i'd rather be accurate and define it as optional number and instead just disable the bad check  
- Improve private aura annotations  
- another tweak so this comment doesn't get sucked into annotation  
- tweak  
- annotate nameplate api for improved error checking and better auto complete.  
- When I get bored I note more things  
- also minor adjust this normal timer  
- Fix timer regression from https://github.com/DeadlyBossMods/DeadlyBossMods/commit/59d2cd7b94737d8d3c99f730a9028d0f51b1df5a . Didn't mean to change P2's timer. That's unchanged  
- Fix 2 GUI rendering bugs;  
    - Don't display stats frame unless it's currently targeted on mod load  
    - Fix title being too high up  
- Update localization.ru.lua (#1072)  
- improved icon validation and annotation  
- Better annotations and checks for target scanning  
- further annotation and checks improvements  
- Fix https://github.com/DeadlyBossMods/DeadlyBossMods/issues/1071  
- More stuff on common objects  
- Further class out announce objects for improved LuaLS diagnostics  
- Fix trivial filter description  
- throw in a couple more  
- Thought I annotated these  
- several more defined functions for LuaLS (i'm aware how ugly UnitAura stuff looks, but LuaLS is too picky about nil/unknown checks and required 279 mods to add redundant nil checks if I just used string|number, and "any" isn't scoped enough)  
    None the less, the new diagnostics helped find several more errors (and will prevent future ones).  
    I also am annotating lots of functions too to make DBM mod development more inviting to people who don't know what all these functions do.  
- update note for own sanity  
- Oops, it actually changed timer of all 4 abilities, not just 3 of them. darkness also increased due to the change  
- Updated 3 timers on Echo of Nelth to account for Increased cast time of sunder reality increasing time between sunder reality, ebon destruction, and Calamitous Strike by 6 seconds.  
    While at it, also add cast timer too.  
- backwards compat api cleanup.  
- I hate when i forget to hit save  
- Define a few more objects, fixed some new bugs found by new definitions  
- Improvements to sync throttling for 10.2.7  
- don't register boss unitIds in classic era (not that any mod is using blank args, but still good practice)  
- apparently no one is actually ready for the cataclysm pre patch yet (ie multi interface versions separated by ,). So revert that for now  
