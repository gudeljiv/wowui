
ItemRack – TBC Classic Anniversary Fix
====================================

This is a fixed version of the ItemRack addon for World of Warcraft
TBC Classic Anniversary.

PROBLEM
-------
ItemRack is broken on TBC Anniversary due to API changes.
Common errors include:
- C_Container is nil
- GetContainerItemInfo is nil
- EquipSet is nil
- ItemRackEquip.lua errors

SOLUTION
--------
This version includes compatibility fixes so ItemRack works correctly
on TBC Classic Anniversary.

INSTALLATION
------------
1. Close World of Warcraft.
2. Go to:
   Interface\AddOns\
3. Rename your old ItemRack folder to:
   ItemRack_backup
4. Extract this ItemRack folder here so the final path is:
   Interface\AddOns\ItemRack\
5. Launch WoW.
6. At character select, click AddOns and enable:
   - ItemRack
   - Load out of date AddOns

CONFIRMED WORKING ON
--------------------
- WoW TBC Classic Anniversary

NOTES
-----
- If you previously edited ItemRack yourself, delete the old folder first.
- If you get errors from other addons (GatherLite, etc.), they are unrelated.

CREDITS
-------
SmokeFurty, ZacZaur, and ChatGPT.

Fix created by community debugging.
Shared to help others avoid hours of troubleshooting.

Have fun and enjoy your time in Azeroth!
