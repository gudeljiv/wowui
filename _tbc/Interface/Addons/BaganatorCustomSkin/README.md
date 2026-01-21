# Baganator Custom Skin

A custom dark skin addon for Baganator that applies independently and won't be overwritten when Baganator updates.

## Installation

1. Download or clone this addon
2. Place the `BaganatorCustomSkin` folder in your `World of Warcraft/_retail_/Interface/AddOns/` directory
3. Make sure Baganator is installed
4. Restart WoW or reload UI (`/reload`)

## Features

This skin provides:
- **Custom dark theme** with customizable transparency
- **Square icon borders** (optional)
- **Quality-based colored borders** for items
- **Hide empty slot backgrounds** (optional)
- **Removable frame borders** (optional)

## Usage

1. Open Baganator settings (usually via `/bgr` command or the Baganator interface)
2. Navigate to the **Skins** section
3. Select **"Custom Dark"** from the skin dropdown
4. Customize the skin options:
   - **Transparency**: Adjust background transparency (0-100%)
   - **Remove Borders**: Hide frame borders for a cleaner look
   - **Hide Icon Backgrounds**: Remove background from empty slots
   - **Square Icons**: Use square borders instead of rounded (requires reload)

## Configuration Options

All settings can be found in Baganator's settings under the skin configuration:

- **Transparency Slider**: Control how transparent the bag frames appear
- **Remove Borders Checkbox**: Toggle frame borders on/off
- **Hide Icon Backgrounds Checkbox**: Show/hide empty slot backgrounds
- **Square Icons Checkbox**: Enable square item borders (requires UI reload)

## File Structure

```
BaganatorCustomSkin/
├── BaganatorCustomSkin.toc  # Addon metadata
├── Core_new.lua              # Main skin implementation
└── README.md                 # This file
```

## Compatibility

- **Requires**: Baganator addon
- **WoW Version**: 11.0.2+ (The War Within)
- **Dependencies**: Baganator must be installed and loaded

## Troubleshooting

**Skin doesn't appear in the list:**
- Make sure Baganator is installed and enabled
- Check that this addon is enabled in the AddOns list
- Try `/reload` to refresh

**Errors on load:**
- Ensure you have the latest version of Baganator
- Check that the folder name is exactly `BaganatorCustomSkin`
- Verify the TOC file matches your WoW client version

**Customization not working:**
- Some options require a UI reload (`/reload`)
- Make sure the skin is actively selected in Baganator settings

## Notes

- This is an external addon, so Baganator updates won't overwrite it
- The skin ID is `custom_dark` to avoid conflicts with built-in skins
- If you use Masque, some features may be overridden by Masque's button styling

## Credits

Based on the Baganator dark skin implementation, adapted as an external addon for easier maintenance and customization.

## License

Feel free to modify and redistribute as needed.
