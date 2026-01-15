# Lib: RangeCheck-3.0

## [1.0.17-7-g367c5b4](https://github.com/WeakAuras/LibRangeCheck-3.0/tree/367c5b44f791b2072dd9d214e57680d0c43bce76) (2025-12-29)
[Full Changelog](https://github.com/WeakAuras/LibRangeCheck-3.0/compare/1.0.17...367c5b44f791b2072dd9d214e57680d0c43bce76) [Previous Releases](https://github.com/WeakAuras/LibRangeCheck-3.0/releases)

- Add TBC and Wrath support and bump TOC files  
    Added new TOC files for The Burning Crusade and Wrath of the Lich King Classic. Updated Interface versions and metadata in existing TOC files. Modified core library logic to detect TBC and adjust event registration accordingly.  
- Switch to unitID caching for Midnight  
- Disable range caching for Midnight due to secrets  
- - Basic support for Midnight (no spell changes)  
- Add Black Arrow for Dark Ranger Hunter.  
    Dar Ranger hero talent "Bleak Arrows" will unlearn Auto Shot not provide any replacement spell. Black Arrow can be used instead, as it is learned with DR.  
- Add new items (#39)  
    * Add new debug function for checking items  
    * Sourced from builds 1.15.5.57807, 4.4.1.57564, 11.0.7.57788  
- Prist: Add Mind Flay for Vanilla Classic (#41)  
    Fixes: #40  