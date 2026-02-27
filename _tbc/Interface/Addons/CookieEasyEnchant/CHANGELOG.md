# Cookie Easy Enchant

## [v3.2.3](https://github.com/afrugalpenguin/cookieeasyenchant/tree/v3.2.3) (2026-02-16)
[Full Changelog](https://github.com/afrugalpenguin/cookieeasyenchant/compare/v3.2.2...v3.2.3) [Previous Releases](https://github.com/afrugalpenguin/cookieeasyenchant/releases)

- chore(release): bump version to 3.2.3  
- fix(enchant): remove auto-confirm for Replace Enchant dialog  
    ReplaceEnchant() is a protected function requiring a hardware click  
    event. Programmatically clicking the dialog button via C\_Timer caused  
    ADDON\_ACTION\_FORBIDDEN errors. Users must now manually confirm.  
