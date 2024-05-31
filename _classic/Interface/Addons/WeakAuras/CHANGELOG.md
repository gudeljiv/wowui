# [5.13.2](https://github.com/WeakAuras/WeakAuras2/tree/5.13.2) (2024-05-29)

[Full Changelog](https://github.com/WeakAuras/WeakAuras2/compare/5.13.1...5.13.2)

## Highlights

 - Initial support for TWW
- More Cata fixes and API streamlining
- Bug fixes 

## Commits

InfusOnWoW (2):

- Update Atlas File List from wago.tools
- Update Atlas File List from wago.tools

Stanzilla (4):

- Update TOC for The War Within
- Update WeakAurasModelPaths from wago.tools
- Update WeakAurasModelPaths from wago.tools
- Update WeakAurasModelPaths from wago.tools

dependabot[bot] (3):

- Bump cbrgm/mastodon-github-action from 2.1.1 to 2.1.2
- --- updated-dependencies: - dependency-name: cbrgm/mastodon-github-action   dependency-type: direct:production   update-type: version-update:semver-patch ...
- Bump cbrgm/mastodon-github-action from 2.0.6 to 2.1.0

emptyrivers (3):

- add build date to pr comment & edit isntead of recreate
- be more careful about keeping nameSource accurate
- explicitly checkout head ref

mrbuds (18):

- Update retail/tww toc files for packager
- Add texture conditions for Texture and AuraBar regions
- move Compatibility.lua functions to Private.ExecEnv
- GetItemSetInfo moved to C_Item.GetItemSetInfo
- Toc handle both 10.2.7 & 11.0.0
- Hero Talent load option
- GetMouseFocus is deprecated for GetMouseFoci
- move blizzard flipbooks to Types_Retail.lua and shorten declarations
- add some dragonflying flipbook
- remove outdated name fix in CorrectSpellName
- fix talent related errors
- C_Reputation changes
- use C_Spell.GetSpellInfo
- use C_Spell.GetSpellCooldown
- LibSpecialization support on Cataclysm
- Chat Message trigger: leader events were not added if a chatType was selected fixes #5088
- Fix item slot for thrown weapon on cataclysm, fixes #5077
- Purge wrath classic

