# FlightReady Changelog

## [1.1.0] - 2026-01-21

### New Features

- **Full Map Addon Support**:
  - **Leatrix Maps Support**: Automatically detects `Leatrix_Plus` and switches to a high-precision profile optimized for its zoom level.
  - **Custom Profiles**: Added a new `CUSTOM` profile that allows full manual control over offsets and spacing for users with other map addons.
- **Precision Anchoring**:
  - Overlays are now anchored directly to the **Map Frame** (TaxiRouteMap).
  - This ensures the click-buttons move perfectly with the window, even when using addons like **MoveAny**.
- **Enhanced Calibration UI**:
  - Added **Spread (Abstand)** slider to control the gap between flight nodes.
  - Added Profile Cycler (Standard -> Leatrix -> Custom).
  - Restricted Edit Mode to only open when the Flight Map is visible to prevent errors.

### Improvements

- **Localization**: Added translations for "Custom" and "Spread" in all 8 supported languages.
- **Cleanup**: Overlays and Calibration Menu now automatically close when the Flight Map is closed.

## [1.0.1]

- Fixed several issues where Druids would not automatically shift out of forms when taking a flight.
- Improved reliability of form cancellation and dismounting by ensuring secure overlays track frame movement.
