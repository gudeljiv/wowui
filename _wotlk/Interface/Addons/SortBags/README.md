# SortBags
Bag sorting for Classic WoW (1.13).<br/>
__IMPORTANT: The folder name must be "SortBags"__<br/>
__IMPORTANT: If you want buttons then get this too: https://github.com/shirsig/Cleanup__

```
/run SortBags() -- Sort bags
/run SortBankBags() -- Sort bank
/run SetSortBagsRightToLeft(Boolean) -- Set sort direction
/run GetSortBagsRightToLeft(): Boolean -- Get sort direction
/run C_Container.SetBagSlotFlag(bagId, LE_BAG_FILTER_FLAG_IGNORE_CLEANUP, Boolean) -- Set bag ignore status - 
--bagId in (1, 2, 3, 4) for character bags, does not work for main bag.
--bagId in (5, 6, 7, 8, 9, 10, 11) for bank bags, does not work for main bank bag.
/run C_Container.GetBagSlotFlag(bagId, LE_BAG_FILTER_FLAG_IGNORE_CLEANUP): Boolean -- Get bag ignore status
```
