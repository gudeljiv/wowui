
## v10.0.9
* The "Buff - Number Of" and "Debuff - Number Of" conditions now support tracking multiple units (e.g. `group 1-40`). (#1989)
* Fix #2066 - Enrage effects were not being stored properly when fetching auras for noncached units.
* Fix #2059 - Condition update were not happening at the proper time for spell cooldown conditions.
* Fix #2038 - Fix more scenarios in which talent loadout name is not available immediately after talent events fire.
* Fix #2075 - Spell cast percent completion was not filtering by name.
* Fix #2072 - Swing timer monitors were not initializing dual-wield state until an equipment change was observed.
* Fix #2071 - Tooltip Number conditions not working on retail. Also switched these conditions to use modern APIs, resulting in substantially better performance.
* Workaround #1978, #2055  - Add hardcoded workarounds for a few reported covenant abilities that can't be tracked properly by name (Soul Rot, Adaptive Swarm).
* Workaround #2065 - Blizzard's cooldown bling effect ignores opacity, so suppress it for hidden icons.


[View Full Changelog](https://github.com/ascott18/TellMeWhen/blob/ce566e49c59e0373879075b0d0270bf0d471b1c3/CHANGELOG.md)
