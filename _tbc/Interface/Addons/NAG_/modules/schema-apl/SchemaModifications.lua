--- @module "NAG.SchemaModifications"
--- Contains all schema modifications for NAG, both global and version-specific
---
--- This module provides a centralized location for all schema modifications,
--- allowing easy management and version-specific customization.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local UnitExists = _G.UnitExists
local UnitCanAttack = _G.UnitCanAttack
local UnitAffectingCombat = _G.UnitAffectingCombat
local UnitCastingInfo = _G.UnitCastingInfo
local UnitChannelInfo = _G.UnitChannelInfo
local IsInRaid = _G.IsInRaid

-- Addon references
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local Version = ns.Version
local TableUtils = ns.TableUtils

-- Additional imports for utility functions
local format = string.format
local concat = table.concat

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

--- @class SchemaModifications:CoreModule
local SchemaModifications = NAG:CreateModule("SchemaModifications", nil, {
    debugCategories = {
        ns.DEBUG_CATEGORIES.DATA,
        ns.DEBUG_CATEGORIES.FEATURES
    }
})
local module = SchemaModifications
ns.SchemaModifications = SchemaModifications

-- ~~~~~~~~~~ SCHEMA MODIFICATIONS ~~~~~~~~~~

--- Global schema modifications (apply to all versions)
---
--- MODIFICATION TYPES:
--- 1. "incremental" - Preserves existing fields and appends new ones (recommended)
---    - Only specify new fields in 'fields' table
---    - Field IDs are auto-incremented from existing fields
---    - field_order is automatically appended
---    - All other metadata is preserved from base schema
---    - Use for: Modifying existing message types in the base schema
---
--- 2. "full" (default) - Replaces entire message structure
---    - Must specify complete structure including all existing fields
---    - Requires field_order and oneofs tables
---    - Use for: Custom handlers (function_type) creating new message types from scratch
---    - Use for: Completely redefining an existing message type
---
--- FIELD ORDER MODIFICATIONS:
--- - field_order - Override the proto field_order to match NAG handler argument order
---   - Format: { "field1", "field2", "field3" }
---   - Required when proto field_order doesn't match NAG handler signature
---   - Default assumption: NAG handlers follow proto field_order (no modification needed)
---   - Example: field_order = {"aura_id", "source_unit"} -- reorder to match handler
---   - Must be explicitly specified when order differs from proto field_order
---
-- NAG function name -> proto message type mappings (merged into SchemaAccessor.nagFunctionMappings on load)
-- Use for runtime aliases like *Resolved that share the same proto as the base function
SchemaModifications.nagFunctionMappingsAdditions = {
    ["SpellCanCastResolved"] = "APLValueSpellCanCast",
    ["AuraIsActiveResolved"] = "APLValueAuraIsActive",
}

SchemaModifications.globalModifications = {
    -- ============================ INCREMENTAL MODIFICATIONS ============================
    -- These modifications use modification_type = "incremental" to preserve existing fields
    -- and append new ones. Field IDs are auto-incremented from existing fields.

    -- Field order modifications for handlers with swapped argument order
    -- Proto schema: APLValueAuraIsActive(source_unit, aura_id, include_reaction_time)
    -- NAG handler: NAG:AuraIsActive(auraId, sourceUnit, includeReactionTime)
    -- Note: Proto field_order is ["source_unit", "aura_id", "include_reaction_time"]
    -- Modified field_order: ["aura_id", "source_unit", "include_reaction_time"] to match NAG handler
    ["APLValueAuraIsActive"] = {
        modification_type = "incremental",
        fields = {},  -- Required for incremental modifications
        field_order = {"aura_id", "source_unit", "include_reaction_time"}
    },

    ["APLValueAuraIsInactive"] = {
        modification_type = "incremental",
        fields = {},  -- Required for incremental modifications
        field_order = {"aura_id", "source_unit", "include_reaction_time"}
    },

    ["APLValueAuraIsInactiveWithReactionTime"] = {
        modification_type = "incremental",
        fields = {},  -- Required for incremental modifications
        field_order = {"aura_id", "source_unit", "include_reaction_time"}
    },

    ["APLValueAuraIsActiveWithReactionTime"] = {
        modification_type = "incremental",
        fields = {},  -- Required for incremental modifications
        field_order = {"aura_id", "source_unit", "include_reaction_time"}
    },

    ["APLValueAuraIsKnown"] = {
        modification_type = "incremental",
        fields = {},  -- Required for incremental modifications
        field_order = {"aura_id", "source_unit"}
    },

    ["APLValueAuraRemainingTime"] = {
        modification_type = "incremental",
        fields = {},  -- Required for incremental modifications
        field_order = {"aura_id", "source_unit"}
    },

    ["APLValueAuraNumStacks"] = {
        modification_type = "incremental",
        fields = {},  -- Required for incremental modifications
        field_order = {"aura_id", "source_unit", "include_reaction_time"}
    },

    ["APLValueAuraInternalCooldown"] = {
        modification_type = "incremental",
        fields = {},  -- Required for incremental modifications
        field_order = {"aura_id", "source_unit"}
    },

    ["APLValueAuraICDIsReadyWithReactionTime"] = {
        modification_type = "incremental",
        fields = {},  -- Required for incremental modifications
        field_order = {"aura_id", "source_unit"}
    },

    ["APLValueAuraShouldRefresh"] = {
        modification_type = "incremental",
        fields = {},  -- Required for incremental modifications
        field_order = {"aura_id", "max_overlap", "source_unit"}
    },

    -- DOT handlers with swapped argument order
    -- Proto schema: APLValueDotIsActive(target_unit, spell_id)
    -- NAG handler: NAG:DotIsActive(spellId, targetUnit)
    -- Modified field_order: ["spell_id", "target_unit"] to match NAG handler
    ["APLValueDotIsActive"] = {
        modification_type = "incremental",
        fields = {},  -- Required for incremental modifications
        field_order = {"spell_id", "target_unit"}
    },

    ["APLValueDotRemainingTime"] = {
        modification_type = "incremental",
        fields = {},  -- Required for incremental modifications
        field_order = {"spell_id", "target_unit"}
    },

    ["APLValueDotTickFrequency"] = {
        modification_type = "incremental",
        fields = {},  -- Required for incremental modifications
        field_order = {"spell_id", "target_unit"}
    },

    ["APLValueDotTimeToNextTick"] = {
        modification_type = "incremental",
        fields = {},  -- Required for incremental modifications
        field_order = {"spell_id", "target_unit"}
    },

    ["APLValueActiveItemSwapSet"] = {
        modification_type = "incremental",
        fields = {},
        _metadata = {
            ui_label = "Active Item Swap Set"
        }
    },

    ["UUID"] = {
        modification_type = "incremental",
        fields = {},
        _metadata = {
            ui_label = "UUID",
        }
    },

    -- Cast action with tolerance and position override
    -- Handler signature: NAG:CastSpell(id, tolerance, position, hideWhileCasting)
    --   - 1st param: id (number|number[], required) - spell/item/trinket ID
    --   - 2nd param: tolerance (number|nil, default: 0) - casting tolerance in seconds
    --   - 3rd param: position (string|nil) - position override (NAG.SPELL_POSITIONS constants)
    --   - 4th param: hideWhileCasting (boolean|nil, NAG-specific) - if true, returns false if currently casting/channeling
    -- Note: hide_while_casting is NAG-specific but exposed in schema for full API compatibility
    -- Note: target field exists in base schema but is not used in NAG implementation
    -- By excluding target from field_order, any target arguments will be ignored during parsing
    -- Note: For type-based disambiguation to work, each optional field must have a unique type
    -- (one double, one enum, one bool, etc.) to enable automatic argument matching
    ["APLActionCastSpell"] = {
        modification_type = "incremental",
        fields = {
            tolerance = {
                type = "double",
                label = "optional",
                description = "Optional casting tolerance in seconds (default: 0)"
            },
            position_override = {
                type = "enum",
                label = "optional",
                enum_type = "SpellPosition",
                description = "Position override using SpellPosition enum (LEFT, RIGHT, AOE, etc.)"
            },
            hide_while_casting = {
                type = "bool",
                label = "optional",
                description = "If true, returns false if the spell is currently being cast or channeled (NAG-specific)"
            }
        },
        -- field_order excludes target - any target arguments will be ignored during parsing
        -- This ensures NAG.SPELL_POSITIONS.* strings are not incorrectly assigned to target.unit
        field_order = { "spell_id", "tolerance", "position_override", "hide_while_casting" }
    },

    -- Convenience function to cast a spell with hideWhileCasting automatically enabled.
    -- Prevents the spell from being displayed repeatedly while it's already casting/channeling.
    -- Handler signature: NAG:NotSpamCast(id, tolerance, position)
    --   - 1st param: id (number|number[], required) - spell/item/trinket ID
    --   - 2nd param: tolerance (number|nil, default: 0) - casting tolerance in seconds
    --   - 3rd param: position (string|nil) - position override (NAG.SPELL_POSITIONS constants)
    -- This is equivalent to calling NAG:CastSpell(id, tolerance, position, true).
    -- Note: hide_while_casting is always true for NotSpamCast, so it's not included in the schema.
    -- Note: field_order excludes target - any target arguments will be ignored during parsing
    ["APLActionNotSpamCast"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLAction",
        fields = {
            spell_id = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The spell, trinket, tinker, or item ID to cast"
            },
            tolerance = {
                id = 2,
                type = "double",
                label = "optional",
                description = "Optional casting tolerance in seconds (default: 0)"
            },
            position_override = {
                id = 3,
                type = "enum",
                label = "optional",
                enum_type = "SpellPosition",
                description = "Position override using SpellPosition enum (LEFT, RIGHT, AOE, etc.)"
            }
        },
        oneofs = {},
        field_order = { "spell_id", "tolerance", "position_override" },
        _metadata = {
            full_description = "Convenience function to cast a spell with hideWhileCasting automatically enabled. Prevents the spell from being displayed repeatedly while it's already casting/channeling. This is equivalent to calling CastSpell with hideWhileCasting set to true.",
            short_description = "Casts a spell without showing it if already casting/channeling.",
            submenu = { "spell" },
            ui_label = "Not Spam Cast"
        }
    },

    -- Convenience function to cast a spell with overlay text.
    -- Handler signature: NAG:CastWithOverlay(id, text, position)
    --   - 1st param: id (number|number[], required) - spell/item/trinket ID
    --   - 2nd param: text (string, required) - overlay text to display with the spell cast
    --   - 3rd param: position (string|nil, optional) - position override (NAG.SPELL_POSITIONS constants)
    -- This is equivalent to calling NAG:CastSpell(id, nil, position, nil, text).
    -- Note: field_order excludes target - any target arguments will be ignored during parsing
    ["APLActionCastWithOverlay"] = {
        function_type = "APLAction",
        fields = {
            spell_id = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The spell, trinket, tinker, or item ID to cast"
            },
            overlay_text = {
                id = 2,
                type = "string",
                label = "required",
                description = "The overlay text to display with the spell cast"
            },
            position_override = {
                id = 3,
                type = "enum",
                label = "optional",
                enum_type = "SpellPosition",
                description = "Position override using SpellPosition enum (LEFT, RIGHT, AOE, etc.)"
            }
        },
        oneofs = {},
        field_order = { "spell_id", "overlay_text", "position_override" },
        _metadata = {
            full_description = "Convenience function to cast a spell with overlay text. Displays overlay text on the spell icon when the spell is cast. For primary actions, the overlay text is shown immediately. For secondary actions, the overlay text is shown when the spell is actually displayed in the UI.",
            short_description = "Casts a spell with overlay text displayed on the icon.",
            submenu = { "spell" },
            ui_label = "Cast With Overlay"
        }
    },

    -- Convenience function for placeholder with overlay text (e.g. poison reminders).
    -- Handler signature: NAG:CastPlaceholderWithOverlay(id, text, position)
    --   - 1st param: id (number|number[], required) - spell/item ID
    --   - 2nd param: text (string, required) - overlay text to display
    --   - 3rd param: position (string|nil, optional) - position override (NAG.SPELL_POSITIONS constants)
    ["APLActionCastPlaceholderWithOverlay"] = {
        function_type = "APLAction",
        fields = {
            spell_id = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The spell or item ID for the placeholder"
            },
            overlay_text = {
                id = 2,
                type = "string",
                label = "required",
                description = "The overlay text to display with the placeholder"
            },
            position_override = {
                id = 3,
                type = "enum",
                label = "optional",
                enum_type = "SpellPosition",
                description = "Position override using SpellPosition enum (LEFT, RIGHT, AOE, etc.)"
            }
        },
        oneofs = {},
        field_order = { "spell_id", "overlay_text", "position_override" },
        _metadata = {
            full_description = "Shows a placeholder spell with overlay text (e.g. poison application reminders). Does not cast the spell; displays a reminder for the player.",
            short_description = "Placeholder with overlay text for reminders.",
            submenu = { "spell" },
            ui_label = "Cast Placeholder With Overlay"
        }
    },

    -- Convenience function to cast a spell with overlay text AND a swing-timer swipe overlay.
    -- Handler signature: NAG:CastWithSwingOverlay(id, text, position)
    --   - 1st param: id (number|number[], required) - spell/item id (typically 6603 for Auto Attack placeholders)
    --   - 2nd param: text (string, required) - overlay text to display with the spell cast
    --   - 3rd param: position (string|nil, optional) - position override (NAG.SPELL_POSITIONS constants)
    -- This is equivalent to calling NAG:CastWithOverlay(id, text, position) with a swing overlay side effect.
    ["APLActionCastWithSwingOverlay"] = {
        function_type = "APLAction",
        fields = {
            spell_id = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The spell, trinket, tinker, or item ID to cast"
            },
            overlay_text = {
                id = 2,
                type = "string",
                label = "required",
                description = "The overlay text to display with the spell cast"
            },
            position_override = {
                id = 3,
                type = "enum",
                label = "optional",
                enum_type = "SpellPosition",
                description = "Position override using SpellPosition enum (LEFT, RIGHT, AOE, etc.)"
            }
        },
        oneofs = {},
        field_order = { "spell_id", "overlay_text", "position_override" },
        _metadata = {
            full_description = "Convenience function to cast a spell with overlay text and a swing-timer swipe overlay. Intended for hold/pool placeholders where the desired visualization is 'wait until next auto attack' rather than a spell cooldown.",
            short_description = "Casts a spell with overlay text and a swing-timer swipe overlay.",
            submenu = { "spell" },
            ui_label = "Cast With Swing Overlay"
        }
    },

    -- Convenience function to show custom overlay text on the PRIMARY icon.
    -- Handler signature: NAG:ShowCustomOverlay(text)
    --   - 1st param: text (string, required) - overlay text to display on primary icon
    -- Always returns false and auto-expires unless refreshed.
    ["APLActionShowCustomOverlay"] = {
        function_type = "APLAction",
        fields = {
            overlay_text = {
                id = 1,
                type = "string",
                label = "required",
                description = "The overlay text to display on the PRIMARY icon"
            },
        },
        oneofs = {},
        field_order = { "overlay_text" },
        _metadata = {
            full_description = "Shows custom overlay text on the PRIMARY icon frame. Always returns false and auto-expires unless refreshed. Cast overlays have priority and will clear/suppress this overlay.",
            short_description = "Shows custom overlay text on the PRIMARY icon.",
            submenu = { "spell" },
            ui_label = "Show Custom Overlay"
        }
    },

    -- Handler signature: NAG:ChannelSpell(spellId, interruptCondition, recast)
    -- Note: Currently calls CastSpell internally. Field order excludes target (NAG doesn't use it).
    ["APLActionChannelSpell"] = {
        modification_type = "incremental",
        fields = {},  -- Required for incremental modifications
        -- field_order excludes target - any target arguments will be ignored during parsing
        -- This matches the NAG handler signature: ChannelSpell(spellId, interruptCondition, recast)
        field_order = { "spell_id", "interrupt_if", "allow_recast" }
    },

    -- Handler signature: NAG:Multidot(spellId, maxDots, maxOverlap, position, range)
    ["APLActionMultidot"] = {
        modification_type = "incremental",
        fields = {
            position = {
                id = 4,
                type = "enum",
                label = "optional",
                enum_type = "SpellPosition",
                description = "Position for the spell (LEFT, RIGHT, AOE, etc.)"
            },
            range = {
                id = 5,
                type = "int32",
                label = "optional",
                description = "Range in yards (overrides dynamic range calculation)"
            }
        },
        field_order = { "spell_id", "max_dots", "max_overlap", "position", "range" }
    },

    -- Handler signature: NAG:StrictMultidot(spellId, maxDots, maxOverlap, position, range)
    ["APLActionStrictMultidot"] = {
        modification_type = "incremental",
        fields = {
            position = {
                id = 4,
                type = "enum",
                label = "optional",
                enum_type = "SpellPosition",
                description = "Position for the spell (LEFT, RIGHT, AOE, etc.)"
            },
            range = {
                id = 5,
                type = "int32",
                label = "optional",
                description = "Range in yards (overrides dynamic range calculation)"
            }
        },
        field_order = { "spell_id", "max_dots", "max_overlap", "position", "range" }
    },

    -- Handler signature: NAG:Multishield(spellId, maxShields, maxOverlap, position, range)
    ["APLActionMultishield"] = {
        modification_type = "incremental",
        fields = {
            position = {
                id = 4,
                type = "enum",
                label = "optional",
                enum_type = "SpellPosition",
                description = "Position for the spell (LEFT, RIGHT, AOE, etc.)"
            },
            range = {
                id = 5,
                type = "int32",
                label = "optional",
                description = "Range in yards (overrides dynamic range calculation)"
            }
        },
        field_order = { "spell_id", "max_shields", "max_overlap", "position", "range" }
    },

    -- Sequence actions should accept ActionID values, not full APLAction messages
    -- Handler signature: NAG:Sequence(name, [forceMain], ...actions)
    ["APLActionSequence"] = {
        modification_type = "incremental",
        fields = {
            name = {
                type = "string",
                label = "required",
                description = "The name of the sequence"
            },
            force_main = {
                type = "bool",
                label = "optional",
                description = "Optional flag to force first spell into main frame (default: true)"
            },
            actions = {
                type = "message",
                label = "repeated",
                message_type = "ActionID",
                description = "Variable number of spell/item IDs to execute in sequence"
            }
        },
        field_order = { "name", "force_main", "actions" }
    },

    -- Handler signature: NAG:StrictSequence(name, [forceMain], ...actions)
    ["APLActionStrictSequence"] = {
        modification_type = "incremental",
        fields = {
            name = {
                type = "string",
                label = "required",
                description = "The name of the strict sequence"
            },
            force_main = {
                type = "bool",
                label = "optional",
                description = "Optional flag to force first spell into main frame (default: true)"
            },
            actions = {
                type = "message",
                label = "repeated",
                message_type = "ActionID",
                description = "Variable number of spell/item IDs to execute in strict sequence (all must be ready)"
            }
        },
        field_order = { "name", "force_main", "actions" }
    },

    ["APLValueUnitDistance"] = {
        modification_type = "incremental", -- NEW: Use incremental modification
        fields = {
            max_range = {
                -- id is optional - will be auto-incremented from existing fields
                type = "int32",
                label = "optional",
                description = "Optional maximum range to check (default: 100 yards)"
            }
        }
        -- field_order is automatically appended to existing field_order
        -- oneofs is preserved from base schema
        -- All other metadata is preserved from base schema
    },

    ["APLValueSpellCanCast"] = {
        modification_type = "incremental", -- NEW: Use incremental modification
        fields = {
            tolerance = {
                -- id is optional - will be auto-incremented from existing fields
                type = "double",
                label = "optional",
                description = "Optional tolerance for the spell (default: 0)"
            }
        }
        -- field_order is automatically appended to existing field_order
        -- oneofs is preserved from base schema
        -- All other metadata is preserved from base schema
    },

    ["APLValueNumberTargets"] = {
        modification_type = "incremental",
        fields = {
            range = {
                id = 1,
                type = "int32",
                label = "optional",
                description = "Range in yards to count targets within (default: dynamic range calculation)"
            },
            use_melee_fallback = {
                id = 2,
                type = "bool",
                label = "optional",
                description = "Whether to use melee fallback when no targets are found in range (default: false)"
            }
        }
        -- field_order is automatically appended to existing field_order
        -- oneofs is preserved from base schema
        -- All other metadata is preserved from base schema
    },

    ["APLActionAutocastOtherCooldowns"] = {
        modification_type = "incremental",
        fields = {
            enable_trinket_slot1 = {
                id = 1,
                type = "bool",
                label = "optional",
                description = "Whether to use trinket slot 1 (default: from settings)"
            },
            enable_trinket_slot2 = {
                id = 2,
                type = "bool",
                label = "optional",
                description = "Whether to use trinket slot 2 (default: from settings)"
            },
            enable_default_battle_potion = {
                id = 3,
                type = "bool",
                label = "optional",
                description = "Whether to use the default battle potion (default: from settings)"
            },
            enable_glove_slot = {
                id = 4,
                type = "bool",
                label = "optional",
                description = "Whether to use the glove slot item (default: true)"
            },
            enable_belt_slot = {
                id = 5,
                type = "bool",
                label = "optional",
                description = "Whether to use the belt slot item (default: false)"
            }
        },
        -- Handler signature: NAG:AutocastOtherCooldowns(enableTrinketSlot1, enableTrinketSlot2, enableDefaultBattlePotion, enableGloveSlot, enableBeltSlot)
        field_order = { "enable_trinket_slot1", "enable_trinket_slot2", "enable_default_battle_potion", "enable_glove_slot", "enable_belt_slot" },
        -- oneofs is preserved from base schema
        -- All other metadata is preserved from base schema
    },

    -- Sequence functions with variable spell IDs
    ["APLValueSequenceIsReady"] = {
        modification_type = "incremental",
        fields = {
            spell_ids = {
                -- id will be auto-incremented from existing fields
                type = "message",
                label = "repeated",
                message_type = "ActionID",
                description = "Spell IDs to check for the sequence (variable number)",
                max_occurrences = 10  -- Reasonable limit for spell IDs
            }
        }
    },

    ["APLValueSequenceTimeToReady"] = {
        modification_type = "incremental",
        fields = {
            spell_ids = {
                -- id will be auto-incremented from existing fields
                type = "message",
                label = "repeated",
                message_type = "ActionID",
                description = "Spell IDs to check for the sequence (variable number)",
                max_occurrences = 10  -- Reasonable limit for spell IDs
            }
        }
    },

    -- ============================ FULL MODIFICATIONS ============================
    -- These modifications define complete message structures (modification_type = "full" or default)

    -- Nested message types for OverlayText options
    ["FontColor"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "Message",
        fields = {
            r = {
                id = 1,
                type = "double",
                label = "optional",
                description = "Red component (0.0-1.0)"
            },
            g = {
                id = 2,
                type = "double",
                label = "optional",
                description = "Green component (0.0-1.0)"
            },
            b = {
                id = 3,
                type = "double",
                label = "optional",
                description = "Blue component (0.0-1.0)"
            },
            a = {
                id = 4,
                type = "double",
                label = "optional",
                description = "Alpha component (0.0-1.0)"
            }
        },
        oneofs = {},
        field_order = { "r", "g", "b", "a" },
        _metadata = {
            ui_label = "Font Color",
            short_description = "RGBA color values for text"
        }
    },

    ["BackgroundConfig"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "Message",
        fields = {
            enable = {
                id = 1,
                type = "bool",
                label = "optional",
                description = "Whether to enable background"
            },
            color = {
                id = 2,
                type = "message",
                label = "optional",
                message_type = "FontColor",
                description = "Background color (RGBA)"
            },
            padding = {
                id = 3,
                type = "int32",
                label = "optional",
                description = "Background padding in pixels"
            },
            texture = {
                id = 4,
                type = "string",
                label = "optional",
                description = "Background texture path"
            }
        },
        oneofs = {},
        field_order = { "enable", "color", "padding", "texture" },
        _metadata = {
            ui_label = "Background Config",
            short_description = "Background configuration options"
        }
    },

    ["OverlayTextOptions"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "Message",
        fields = {
            position = {
                id = 1,
                type = "string",
                label = "optional",
                description = "Target frame position - 'primary', 'above1', 'below1', 'left1', 'right1', etc. Can also use NAG.SPELL_POSITIONS constants"
            },
            font_size = {
                id = 2,
                type = "int32",
                label = "optional",
                description = "Font size (default: 12)"
            },
            point = {
                id = 3,
                type = "string",
                label = "optional",
                description = "Anchor point for the text - 'TOP', 'BOTTOM', 'CENTER', etc. (default: 'BOTTOM')"
            },
            relative_point = {
                id = 4,
                type = "string",
                label = "optional",
                description = "Relative anchor point on the target frame (default: 'TOP' when using default point)"
            },
            x_offset = {
                id = 5,
                type = "int32",
                label = "optional",
                description = "Horizontal offset in pixels. Positive = right, negative = left (default: 0)"
            },
            y_offset = {
                id = 6,
                type = "int32",
                label = "optional",
                description = "Vertical offset in pixels. Positive = up, negative = down (default: 10)"
            },
            font_color = {
                id = 7,
                type = "message",
                label = "optional",
                message_type = "FontColor",
                description = "RGBA color table {r, g, b, a} (default: {1, 1, 1, 1} - white)"
            },
            pulse = {
                id = 8,
                type = "bool",
                label = "optional",
                description = "Enable pulse animation (default: false)"
            },
            id = {
                id = 9,
                type = "string",
                label = "optional",
                description = "Unique identifier for overlay (default: uses text as key)"
            },
            background = {
                id = 10,
                type = "message",
                label = "optional",
                message_type = "BackgroundConfig",
                description = "Background configuration {enable, color, padding, texture}"
            }
        },
        oneofs = {},
        field_order = { "position", "font_size", "point", "relative_point", "x_offset", "y_offset", "font_color", "pulse", "id", "background" },
        _metadata = {
            ui_label = "Overlay Text Options",
            short_description = "Configuration options for text overlay display"
        }
    },
    ["APLActionOverlayText"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLAction",
        fields = {
            text = {
                id = 1,
                type = "string",
                label = "required",
                description = "The text to display (required). Supports newlines with \\n"
            },
            options = {
                id = 2,
                type = "message",
                label = "optional",
                message_type = "OverlayTextOptions",
                description = "Optional configuration table with positioning, styling, and display options"
            }
        },
        oneofs = {},
        field_order = { "text", "options" },
        _metadata = {
            ui_label = "Overlay Text",
            short_description = "Shows a text overlay on icon frames with customizable options",
            full_description = "Displays text along the top margin of the target icon by default (just above the primary icon), with options for font size, alignment, and positioning. Can target any icon frame (primary, above, below, left, right) and position text inside or outside the frame. The overlay persists until combat ends or the frame is hidden. Calling with the same text/id updates the existing overlay.",
            submenu = { "misc" }
        }
    },

    ["APLValueDotCritPercentIncrease"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            spell_id = {
                id = 1,
                type = "message",
                label = "optional",
                message_type = "ActionID"
            },
            target_unit = {
                id = 2,
                type = "message",
                label = "optional",
                message_type = "UnitReference"
            },
            use_base_value = {
                id = 3,
                type = "bool",
                label = "optional"
            }
        },
        oneofs = {},
        field_order = { "spell_id", "target_unit", "use_base_value" },
        _metadata = {
            short_description = "How much higher a new DoT's crit chance would be compared to the old.",
            submenu = { "dot" },
            ui_label = "Dot Crit Chance Increase %"
        }
    },

    ["APLValueDotTickRatePercentIncrease"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            spell_id = {
                id = 1,
                type = "message",
                label = "optional",
                message_type = "ActionID"
            },
            target_unit = {
                id = 2,
                type = "message",
                label = "optional",
                message_type = "UnitReference"
            },
            use_base_value = {
                id = 3,
                type = "bool",
                label = "optional"
            }
        },
        oneofs = {},
        field_order = { "spell_id", "target_unit", "use_base_value" },
        _metadata = {
            short_description = "How much faster a new DoT would tick compared to the old.",
            submenu = { "dot" },
            ui_label = "Dot Tick Rate Increase %"
        }
    },

    -- APLValue handlers (return values) from CommonHandlers.lua
    ["APLValueSpellIsCasting"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            spell_id = {
                id = 1,
                type = "message",
                label = "optional",
                message_type = "ActionID"
            }
        },
        oneofs = {},
        field_order = { "spell_id" },
        _metadata = {
            full_description = "Checks if the player is currently casting the specified spell. This is useful for preventing casting the same spell multiple times or for conditional logic in rotations.",
            short_description = "|cffffcc00True|r if this spell is currently being cast, otherwise |cffffcc00False|r.",
            submenu = { "spell" },
            ui_label = "Is Casting"
        }
    },

    -- APLAction handlers (perform actions) from CommonHandlers.lua

    ["APLActionSelectRotation"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLAction",
        fields = {
            rotation_name = {
                id = 1,
                type = "string",
                label = "required",
                description = "The full name of the rotation to select"
            }
        },
        oneofs = {},
        field_order = { "rotation_name" },
        _metadata = {
            full_description = "Allows APL authors to dynamically change rotations based on conditions. This is useful for switching between different rotation strategies during combat.",
            short_description = "Dynamically changes the active rotation based on conditions.",
            submenu = { "misc" },
            ui_label = "Select Rotation"
        }
    },

    ["APLActionCastWithSecondary"] = {
    modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLAction",
        fields = {
            primary_spell_id = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The primary spell to cast"
            },
            secondary_spell_id = {
                id = 2,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The secondary spell to cast alongside the primary spell"
            }
        },
        oneofs = {},
        field_order = { "primary_spell_id", "secondary_spell_id" },
        _metadata = {
            full_description = "Casts the primary spell while also applying the effects of a secondary spell. This is useful for complex spell combinations or when you need to cast multiple spells simultaneously.",
            short_description = "Casts a primary spell with a secondary spell effect.",
            submenu = { "spell" },
            ui_label = "Cast With Secondary"
        }
    },


    ["APLActionCancelBladestorm"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLAction",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            full_description = "Cancels the Bladestorm ability if the player is currently in Bladestorm. This is useful for interrupting the ability when needed for positioning or other tactical reasons.",
            include_if = {
                class_specific = true,
                classes = { "Warrior" },
                prepull_only = false,
                combat_only = false,
                spec_specific = false
            },
            short_description = "Cancels the Bladestorm ability if currently active.",
            submenu = { "misc" },
            ui_label = "Cancel Bladestorm"
        }
    },

    ["APLActionCancelAstralCommunion"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLAction",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            full_description = "Cancels the Astral Communion ability if the player is currently channeling it. This is useful for interrupting the channel when the desired eclipse energy range is reached.",
            include_if = {
                class_specific = true,
                classes = { "Druid" },
                prepull_only = false,
                combat_only = false,
                spec_specific = false
            },
            short_description = "Cancels the Astral Communion ability if currently active.",
            submenu = { "misc" },
            ui_label = "Cancel Astral Communion"
        }
    },

    ["APLActionCancelMeta"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLAction",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            full_description = "Shows a cancel prompt for Metamorphosis without cancelling automatically. Displays a cancel overlay/symbol and text; does not alter rotation result. Returns false so the APL evaluation continues.",
            include_if = {
                class_specific = true,
                classes = { "Warlock" },
                prepull_only = false,
                combat_only = false,
                spec_specific = false
            },
            short_description = "Shows a cancel prompt for Metamorphosis if currently active.",
            submenu = { "misc" },
            ui_label = "Cancel Metamorphosis"
        }
    },

    ["APLActionGuideAstralCommunion"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLAction",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            full_description = "Displays a guidance overlay indicating the target eclipse energy range (-40 to -60) and direction (moon) for Astral Communion positioning. This helps players position their eclipse energy correctly before combat.",
            include_if = {
                class_specific = true,
                classes = { "Druid" },
                prepull_only = false,
                combat_only = false,
                spec_specific = false
            },
            short_description = "Shows guidance overlay for Astral Communion positioning.",
            submenu = { "misc" },
            ui_label = "Guide Astral Communion"
        }
    },

    ["APLActionCastBuff"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLAction",
        fields = {
            spell_id = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The buff spell to cast"
            },
            tolerance = {
                id = 2,
                type = "double",
                label = "optional",
                description = "Optional casting tolerance in seconds (default: 0)"
            }
        },
        oneofs = {},
        field_order = { "spell_id", "tolerance" },
        _metadata = {
            full_description = "Attempts to cast a buff spell if available and ready, with optional tolerance. Checks for existing buffs of the same type to avoid redundancy.",
            short_description = "Casts a buff spell if available and ready.",
            submenu = { "spell" },
            ui_label = "Cast Buff"
        }
    },

    ["APLActionCastDebuff"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLAction",
        fields = {
            spell_id = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The debuff spell to cast"
            },
            tolerance = {
                id = 2,
                type = "double",
                label = "optional",
                description = "Optional casting tolerance in seconds (default: 0)"
            }
        },
        oneofs = {},
        field_order = { "spell_id", "tolerance" },
        _metadata = {
            full_description = "Attempts to cast a debuff spell if available and ready, with optional tolerance. Checks for existing debuffs of the same type to avoid redundancy.",
            short_description = "Casts a debuff spell if available and ready.",
            submenu = { "spell" },
            ui_label = "Cast Debuff"
        }
    },

    ["APLActionCastPlaceholder"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLAction",
        fields = {
            spell_id = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The spell ID to cast"
            },
            tolerance = {
                id = 2,
                type = "double",
                label = "optional",
                description = "Optional casting tolerance in seconds (default: 0)"
            },
            position = {
                id = 3,
                type = "enum",
                label = "optional",
                enum_type = "SpellPosition",
                description = "Position for the spell (LEFT, RIGHT, AOE, etc.)"
            }
        },
        oneofs = {},
        field_order = { "spell_id", "tolerance", "position" },
        _metadata = {
            full_description = "Attempts to cast the specified spell and sets it as the next spell to cast. This is a placeholder function that bypasses normal validation checks but supports position overrides.",
            short_description = "Sets a spell as the next spell to cast without validation.",
            submenu = { "spell" },
            ui_label = "Cast Placeholder"
        }
    },

    ["APLActionMoveToRange"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLAction",
        fields = {
            range = {
                id = 1,
                type = "int32",
                label = "required",
                description = "The target range to move to in yards"
            }
        },
        oneofs = {},
        field_order = { "range" },
        _metadata = {
            full_description = "Moves the player to maintain a specific range from the target. This is useful for positioning and maintaining optimal distance for spells or abilities.",
            short_description = "Moves the player to a specified range from the target.",
            submenu = { "encounter" },
            ui_label = "Move To Range"
        }
    },

    ["APLActionSmartRotationSwitch"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            full_description = "Smart rotation switching helper that automatically detects current spec and switches to optimal rotation based on context. Call this at the start of your rotation to automatically switch to the optimal rotation.",
            short_description = "Automatically switches to the optimal rotation based on context.",
            submenu = { "misc" },
            ui_label = "Smart Rotation Switch"
        }
    },

    -- APLValue handlers (return values) - Missing schema entries
    ["APLValueAvgRaidHP"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            full_description = "Calculates the average HP percentage of all raid members. Dead or offline players are excluded from both sum and count. Solo uses player only. Results are cached for 0.8 seconds.",
            short_description = "Returns the average HP percentage of all raid members.",
            submenu = { "misc" },
            ui_label = "Average Raid HP"
        }
    },

    ["APLValueAvgRemHP"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            full_description = "Calculates the average HP percentage of raid members who have Renewing Mist active on them from the player. Excludes dead/offline units. Solo considers player only. Cached for 0.8 seconds. Only meaningful for Monks.",
            short_description = "Returns the average HP percentage of raid members with Renewing Mist.",
            submenu = { "misc" },
            ui_label = "Average Remaining HP"
        }
    },

    ["APLValueBossCastTimeRemaining"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            full_description = "Gets the remaining cast time for the boss's current spell. Returns 0 if not casting or no target. Useful for timing interrupts or defensive cooldowns.",
            short_description = "Returns the remaining cast time for the boss's current spell.",
            submenu = { "boss" },
            ui_label = "Boss Cast Time Remaining"
        }
    },

    ["APLValueBossChannelTimeRemaining"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            full_description = "Gets the remaining channel time for the boss's current spell. Returns 0 if not channeling or no target. Useful for timing interrupts or defensive cooldowns.",
            short_description = "Returns the remaining channel time for the boss's current spell.",
            submenu = { "boss" },
            ui_label = "Boss Channel Time Remaining"
        }
    },

    ["APLValueCanWeave"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            spell_id = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The spell ID to check for weaving capability"
            }
        },
        oneofs = {},
        field_order = { "spell_id" },
        _metadata = {
            full_description = "Determines if a spell can be cast without clipping auto attacks. For instant cast spells, always returns true since they can't clip auto attacks. For non-instant casts, verifies that the total cast time is less than the time left until the next auto attack.",
            short_description = "Checks if a spell can be cast without clipping auto attacks.",
            submenu = { "auto" },
            ui_label = "Can Weave"
        }
    },

    ["APLValueCatOptimalRotationAction"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            full_description = "Performs the optimal rotation action for a Feral Druid (Cat form). This function is not yet fully implemented and always returns false. Intended for Feral Druid rotation optimization.",
            short_description = "Performs the optimal rotation action for a Feral Druid (Cat form).",
            submenu = { "misc" },
            ui_label = "Cat Optimal Rotation Action"
        }
    },

    ["APLValueCheckRaidBuffs"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            percent_need = {
                id = 1,
                type = "int32",
                label = "optional",
                description = "The percentage threshold of units needing buffs (0-100, default: 40)"
            }
        },
        oneofs = {},
        field_order = { "percent_need" },
        _metadata = {
            full_description = "Checks and recommends raid buffs based on missing buffs in group/raid. Recommends a raid buff if the percentage of group/raid members missing it meets or exceeds the threshold.",
            short_description = "Checks and recommends raid buffs based on missing buffs in group/raid.",
            submenu = { "misc" },
            ui_label = "Check Raid Buffs"
        }
    },

    ["APLValueCheckRaidDebuffs"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            full_description = "Checks and recommends raid debuffs based on missing debuffs on the target. Recommends a raid debuff if the target is missing any debuff type and the player can cast a relevant spell.",
            short_description = "Checks and recommends raid debuffs based on missing debuffs on the target.",
            submenu = { "misc" },
            ui_label = "Check Raid Debuffs"
        }
    },

    ["APLValueClearWeakAurasCache"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            full_description = "Clears the WeakAuras cache. Called when entering/leaving combat to ensure fresh checks. This helps maintain accurate WeakAuras state detection.",
            short_description = "Clears the WeakAuras cache.",
            submenu = { "misc" },
            ui_label = "Clear WeakAuras Cache"
        }
    },

    -- Additional missing APLValue handlers
    ["APLValueCountEnemiesInRange"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            max_range = {
                id = 1,
                type = "int32",
                label = "required",
                description = "The maximum range to check for enemies"
            },
            use_advanced_features = {
                id = 2,
                type = "bool",
                label = "optional",
                description = "Whether to use advanced features (default: true)"
            },
            use_caching = {
                id = 3,
                type = "bool",
                label = "optional",
                description = "Whether to use caching (default: true)"
            }
        },
        oneofs = {},
        field_order = { "max_range", "use_advanced_features", "use_caching" },
        _metadata = {
            full_description = "Counts the number of enemies within the specified range. Uses the unified TTDManager implementation with configurable features for performance optimization.",
            short_description = "Counts the number of enemies within the specified range.",
            submenu = { "encounter" },
            ui_label = "Count Enemies In Range"
        }
    },

    ["APLValueCountRaidMembersWithAura"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            spell_id = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The spell ID of the aura to count"
            },
            filter = {
                id = 2,
                type = "string",
                label = "optional",
                description = "Optional filter (defaults to 'HELPFUL|PLAYER')"
            }
        },
        oneofs = {},
        field_order = { "spell_id", "filter" },
        _metadata = {
            full_description = "Counts the number of unique party/raid members with the player-cast aura. Uses enhanced aura handlers for accurate counting.",
            short_description = "Counts the number of raid members with a specific aura.",
            submenu = { "misc" },
            ui_label = "Count Raid Members With Aura"
        }
    },

    ["APLValueCountTargetsWithDebuffInRange"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            debuff_id = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The debuff ID to check for"
            },
            max_range = {
                id = 2,
                type = "int32",
                label = "required",
                description = "The maximum range to check"
            }
        },
        oneofs = {},
        field_order = { "debuff_id", "max_range" },
        _metadata = {
            full_description = "Counts the number of targets with the specified debuff within the given range. Respects single target override mode for accurate counting.",
            short_description = "Counts the number of targets with a specific debuff within range.",
            submenu = { "encounter" },
            ui_label = "Count Targets With Debuff In Range"
        }
    },

    ["APLValueCurrentAlternate"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            full_description = "Gets the current alternate power of the player. This is used for special resource types that don't fit into standard categories.",
            short_description = "Returns the current alternate power of the player.",
            submenu = { "resources" },
            ui_label = "Current Alternate Power"
        }
    },

    ["APLValueCurrentArcaneCharges"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            full_description = "Gets the current number of Arcane Charges for Arcane Mages. Used for managing Arcane Charge resource management.",
            short_description = "Returns the current number of Arcane Charges.",
            submenu = { "resources" },
            ui_label = "Current Arcane Charges"
        }
    },

    ["APLValueCurrentAttackPower"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            full_description = "Gets the current attack power of the player, including base power and buffs/debuffs. Returns 0 if unavailable.",
            short_description = "Returns the current attack power of the player.",
            submenu = { "misc" },
            ui_label = "Current Attack Power"
        }
    },

    ["APLValueCurrentBurningEmbers"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            full_description = "Gets the current number of Burning Embers for Destruction Warlocks. Used for managing Burning Ember resource management.",
            short_description = "Returns the current number of Burning Embers.",
            submenu = { "resources" },
            ui_label = "Current Burning Embers"
        }
    },


    ["APLValueCurrentDemonicFury"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            full_description = "Gets the current amount of Demonic Fury for Demonology Warlocks. Used for managing Demonic Fury resource management.",
            short_description = "Returns the current amount of Demonic Fury.",
            submenu = { "resources" },
            ui_label = "Current Demonic Fury"
        }
    },

    ["APLValueCurrentMaelstrom"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            full_description = "Gets the current maelstrom of the player for Enhancement Shamans. Used for managing Maelstrom resource management.",
            short_description = "Returns the current maelstrom of the player.",
            submenu = { "resources" },
            ui_label = "Current Maelstrom"
        }
    },

    ["APLValueCurrentSoulShards"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            full_description = "Gets the current soul shards of the player for Warlocks. Used for managing Soul Shard resource management.",
            short_description = "Returns the current soul shards of the player.",
            submenu = { "resources" },
            ui_label = "Current Soul Shards"
        }
    },

    ["APLValueDamageTakenLastGlobal"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            full_description = "Gets the amount of damage taken in the last global cooldown (1.5s). Currently returns 0 as damage tracking needs to be implemented.",
            short_description = "Returns the amount of damage taken in the last global cooldown.",
            submenu = { "misc" },
            ui_label = "Damage Taken Last Global"
        }
    },

    ["APLValueDeadlyCalm"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            full_description = "Triggers Deadly Calm for warriors via WeakAuras. This function always returns false and is used for WeakAuras integration.",
            short_description = "Triggers Deadly Calm for warriors via WeakAuras.",
            submenu = { "misc" },
            ui_label = "Deadly Calm"
        }
    },

    ["APLValueDotNumStacks"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            spell_id = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The spell ID to check"
            }
        },
        oneofs = {},
        field_order = { "spell_id" },
        _metadata = {
            full_description = "Returns the number of stacks for a DoT (Damage over Time) spell on the target. Returns 0 if not found.",
            short_description = "Returns the number of stacks for a DoT on the target.",
            submenu = { "dot" },
            ui_label = "Dot Num Stacks"
        }
    },

    ["APLValueDotShouldRefresh"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            spell_id = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The spell ID to check"
            },
            overlap = {
                id = 2,
                type = "int32",
                label = "required",
                description = "The overlap time in seconds before expiration"
            }
        },
        oneofs = {},
        field_order = { "spell_id", "overlap" },
        _metadata = {
            full_description = "Checks if a DoT (Damage over Time) spell should be refreshed based on overlap time. Returns true if the DoT should be refreshed, false otherwise.",
            short_description = "Checks if a DoT should be refreshed based on overlap time.",
            submenu = { "dot" },
            ui_label = "Dot Should Refresh"
        }
    },

    ["APLValueDruidCurrentEclipsePhase"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            full_description = "Returns the current Eclipse phase for Balance Druids. Returns 'SolarPhase', 'LunarPhase', or 'NeutralPhase' based on the current Eclipse state.",
            short_description = "Returns the current Eclipse phase for Balance Druids.",
            submenu = { "misc" },
            ui_label = "Druid Current Eclipse Phase"
        }
    },

    ["APLValueDruidGetEclipseDirection"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            full_description = "Gets the current Eclipse direction for Balance Druids. Returns 'sun' (toward Solar), 'moon' (toward Lunar), or 'none' if not moving or unavailable. This is deprecated - use DruidCurrentEclipsePhase instead.",
            short_description = "Gets the current Eclipse direction for Balance Druids.",
            submenu = { "misc" },
            ui_label = "Druid Get Eclipse Direction"
        }
    },

    ["APLValueGetBattlePotion"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            full_description = "Gets the default battle potion for the current class/spec. Returns the spell ID of the appropriate battle potion, or nil if no default is configured. This is determined by the class module's GetDefaultBattlePotion() method.",
            short_description = "Gets the default battle potion for the current class/spec.",
            submenu = { "misc" },
            ui_label = "Get Battle Potion"
        }
    },

    ["APLValueGCDTimeValue"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            full_description = "Returns the last non-zero GCD duration in seconds. Uses unified API and Classic/Retail IDs. Defaults to 1.5 if never observed. Useful for timing calculations when GCD is not currently active.",
            short_description = "Returns the last non-zero GCD duration in seconds.",
            submenu = { "timing" },
            ui_label = "GCD Time Value"
        }
    },

    -- Final missing APLValue handlers
    ["APLValueGetVengeanceAP"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            full_description = "Returns the amount of attack power from Vengeance. Searches for the Vengeance aura on the player and extracts the attack power value. Returns 0 if not found.",
            short_description = "Returns the amount of attack power from Vengeance.",
            submenu = { "misc" },
            ui_label = "Get Vengeance AP"
        }
    },

    ["APLValueHasAggro"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            unit = {
                id = 1,
                type = "message",
                label = "optional",
                message_type = "UnitReference",
                description = "The unit to check threat against (defaults to 'target')"
            }
        },
        oneofs = {},
        field_order = { "unit" },
        _metadata = {
            full_description = "Checks if the player has aggro on the target. This is deprecated - use UnitIsPrimaryTarget instead. Returns true if the player is tanking, false otherwise.",
            short_description = "Checks if the player has aggro on the target.",
            submenu = { "misc" },
            ui_label = "Has Aggro"
        }
    },

    ["APLValueHasTalent"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            talent_id = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The talent ID to check"
            }
        },
        oneofs = {},
        field_order = { "talent_id" },
        _metadata = {
            full_description = "Checks if the player has a specific talent. Returns true if the talent is selected, false otherwise. Uses StateManager for efficient talent checking.",
            short_description = "Checks if the player has a specific talent.",
            submenu = { "misc" },
            ui_label = "Has Talent"
        }
    },

    ["APLValueHasGlyph"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            glyph_id = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The glyph ID to check"
            }
        },
        oneofs = {},
        field_order = { "glyph_id" },
        _metadata = {
            full_description = "Checks if the player has a specific glyph. Returns true if the glyph is active, false otherwise. Uses StateManager for efficient glyph checking.",
            short_description = "Checks if the player has a specific glyph.",
            submenu = { "misc" },
            ui_label = "Has Glyph"
        }
    },

    ["APLValueInEncounter"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            full_description = "Checks if the player is in an encounter or training dummy simulation. Returns true if in an encounter or training dummy simulation, false otherwise. Originally from TTDManager module.",
            short_description = "Checks if the player is in an encounter or training dummy simulation.",
            submenu = { "encounter" },
            ui_label = "In Encounter"
        }
    },

    ["APLValueCurrentEncounterId"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            full_description = "Gets the current encounter ID if the player is in an encounter. Returns the encounter ID from StateManager, or 0 if not in an encounter or if no encounter ID is available. Useful for encounter-specific rotation logic.",
            short_description = "Returns the current encounter ID if in an encounter, or 0 otherwise.",
            submenu = { "encounter" },
            ui_label = "Current Encounter ID"
        }
    },

    ["APLValuePlayerIsInRaid"] = {
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            full_description = "Checks if the player is currently in a raid group. RESPECTS GROUP/RAID OVERRIDES for testing purposes. Returns true if the player is in a raid, false otherwise.",
            short_description = "Returns true if the player is in a raid group, false otherwise.",
            submenu = { "encounter" },
            ui_label = "Player Is In Raid"
        }
    },

    ["APLValuePlayerIsInGroup"] = {
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            full_description = "Checks if the player is currently in a party (non-raid) group. RESPECTS GROUP/RAID OVERRIDES for testing purposes. Returns true if the player is in a party, false otherwise.",
            short_description = "Returns true if the player is in a party (non-raid) group, false otherwise.",
            submenu = { "encounter" },
            ui_label = "Player Is In Group"
        }
    },

    ["APLValueCurrentTime"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            full_description = "Get the current combat time in seconds since combat started, or 0 if not in combat. Uses StateManager to track combat start time.",
            short_description = "Returns the current combat time in seconds since combat started, or 0 if not in combat.",
            submenu = { "encounter" },
            ui_label = "Current Time"
        }
    },

    ["APLValueCurrentTimePercent"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            full_description = "Get the current time as a percentage of the total time (elapsed/total). Calculates elapsed time on current target divided by total target duration. Returns 0% if we don't have valid TTD.",
            short_description = "Returns the current time as a percentage of the total time (0-100).",
            submenu = { "encounter" },
            ui_label = "Current Time %"
        }
    },

    ["APLValueRemainingTime"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            full_description = "Get the remaining time (TTD or encounter timer) in seconds for the current target or encounter. Encounter timer/training dummy stopwatch has priority. Returns 8888 if unable to calculate (no target, fresh target, or invalid data).",
            short_description = "Returns the remaining time (TTD or encounter timer) in seconds, or 8888 if unable to calculate.",
            submenu = { "encounter" },
            ui_label = "Remaining Time"
        }
    },

    ["APLValueRemainingTimePercent"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            full_description = "Get the remaining time as a percentage of the total time (remaining/total). Calculates remaining time divided by total fight duration. Returns 100% if we don't have valid TTD.",
            short_description = "Returns the remaining time as a percentage of the total time (0-100).",
            submenu = { "encounter" },
            ui_label = "Remaining Time %"
        }
    },

    -- NOTE: Proto already defines APLValueAuraIsActive; we rely on the incremental
    -- modification above for field order. The legacy full replacements APLValueIsActive
    -- and APLValueIsActiveAura were removed to align naming with proto and avoid
    -- duplicate message definitions.

    ["APLValueIsActiveEnchant"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            spell_id = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The spell ID of the enchant to check"
            }
        },
        oneofs = {},
        field_order = { "spell_id" },
        _metadata = {
            full_description = "Checks if a spell is an active enchant on the player's weapons. Returns true if the spell is an active enchant, false otherwise.",
            short_description = "Checks if a spell is an active enchant on the player's weapons.",
            submenu = { "aura" },
            ui_label = "Is Active Enchant"
        }
    },

    ["APLValueIsDualWield"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            full_description = "Checks if the player is currently dual wielding weapons. Determines dual wielding by checking if there's an item equipped in the offhand slot (slot 17).",
            short_description = "Checks if the player is currently dual wielding weapons.",
            submenu = { "misc" },
            ui_label = "Is Dual Wield"
        }
    },

    ["APLValueIsKnownEnchant"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            spell_id = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The ID of the spell to check"
            }
        },
        oneofs = {},
        field_order = { "spell_id" },
        _metadata = {
            full_description = "Checks if a spell is a known enchant. Uses StateManager's cached enchant data for efficient checking. Falls back to IsSpellKnown for compatibility.",
            short_description = "Checks if a spell is a known enchant.",
            submenu = { "spell" },
            ui_label = "Is Known Enchant"
        }
    },

    ["APLValueIsKnownSpell"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            spell_id = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The ID of the spell to check"
            }
        },
        oneofs = {},
        field_order = { "spell_id" },
        _metadata = {
            full_description = "Checks if a spell is known, with special handling for certain classes and expansions. Supports custom behavior overrides and talent-gated spells.",
            short_description = "Checks if a spell is known, with special handling for certain classes and expansions.",
            submenu = { "spell" },
            ui_label = "Is Known Spell"
        }
    },

    ["APLValueIsKnownTierset"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            spell_id = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The ID of the tier set spell to check"
            }
        },
        oneofs = {},
        field_order = { "spell_id" },
        _metadata = {
            full_description = "Checks if a tier set spell is known (player has enough tier pieces equipped). Returns true if the player has enough tier pieces equipped for this spell, false otherwise.",
            short_description = "Checks if a tier set spell is known (player has enough tier pieces equipped).",
            submenu = { "misc" },
            ui_label = "Is Known Tierset"
        }
    },

    ["APLValueIsReady"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            id = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The ID of the spell, trinket, tinker, or item to check"
            }
        },
        oneofs = {},
        field_order = { "id" },
        _metadata = {
            full_description = "Checks if a spell, trinket, tinker, or item is ready to be used. Returns true if the ID is ready, false otherwise. Supports custom behavior overrides.",
            short_description = "Checks if a spell, trinket, tinker, or item is ready to be used.",
            submenu = { "spell" },
            ui_label = "Is Ready"
        }
    },

    ["APLValueIsReadySpell"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            spell_id = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The ID of the spell to check"
            },
            tolerance = {
                id = 2,
                type = "double",
                label = "optional",
                description = "The tolerance in seconds for the spell cooldown (default: 0)"
            }
        },
        oneofs = {},
        field_order = { "spell_id", "tolerance" },
        _metadata = {
            full_description = "Checks if a spell is ready to cast based on cooldown and optional tolerance. Returns true if the spell is ready, false otherwise. Supports custom behavior overrides.",
            short_description = "Checks if a spell is ready to cast based on cooldown and optional tolerance.",
            submenu = { "spell" },
            ui_label = "Is Ready Spell"
        }
    },

    ["APLValueIsTargetInterruptible"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            full_description = "Checks if the target is currently casting or channeling and is interruptible. This is deprecated - use UnitIsInterruptible instead. Returns true if the target is interruptible, false otherwise.",
            short_description = "Checks if the target is currently casting or channeling and is interruptible.",
            submenu = { "unit" },
            ui_label = "Is Target Interruptible"
        }
    },

    ["APLValueIsTotemActive"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            spell_id = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The spell ID of the totem to check"
            }
        },
        oneofs = {},
        field_order = { "spell_id" },
        _metadata = {
            full_description = "Tracks Fire Elemental (2894), Searing (3599), Magma (8190), and Earth Elemental (2062) totems. For Searing and Magma totems, also verifies they have attacked recently (within 10 seconds). Returns true if the totem is active and has attacked recently, false otherwise.",
            short_description = "Checks if a totem is active and has attacked recently.",
            submenu = { "misc" },
            ui_label = "Is Totem Active"
        }
    },

    ["APLValueItemRemainingTime"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            id = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The ID of the item to check"
            }
        },
        oneofs = {},
        field_order = { "id" },
        _metadata = {
            full_description = "Returns the remaining time for an item's cooldown or effect. Returns the remaining time in seconds, or false if not applicable. Uses DataManager for efficient item lookup.",
            short_description = "Returns the remaining time for an item's cooldown or effect.",
            submenu = { "misc" },
            ui_label = "Item Remaining Time"
        }
    },

    -- Unit function APLValue handlers
    ["APLValueUnitIsCasting"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            unit = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "UnitReference",
                description = "The unit to check (e.g., 'player', 'target', 'focus')"
            },
            spell_id = {
                id = 2,
                type = "message",
                label = "optional",
                message_type = "ActionID",
                description = "Optional spell ID to check for specific spell"
            }
        },
        oneofs = {},
        field_order = { "unit", "spell_id" },
        _metadata = {
            ui_label = "Unit Is Casting",
            submenu = { "unit" },
            short_description = "Checks if a unit is currently casting any spell or a specific spell.",
            full_description = "Checks if a unit is currently casting any spell or a specific spell. Returns true if the unit is casting (any spell or specific spell), false otherwise.",
        }
    },

    ["APLValueUnitIsCastingOrChanneling"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            unit = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "UnitReference",
                description = "The unit to check (e.g., 'player', 'target', 'focus')"
            }
        },
        oneofs = {},
        field_order = { "unit" },
        _metadata = {
            ui_label = "Unit Is Casting Or Channeling",
            submenu = { "unit" },
            short_description = "Checks if a unit is currently casting or channeling any spell.",
            full_description = "Checks if a unit is currently casting or channeling any spell. Returns true if the unit is casting or channeling, false otherwise.",
        }
    },

    ["APLValueUnitIsChanneling"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            unit = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "UnitReference",
                description = "The unit to check (e.g., 'player', 'target', 'focus')"
            },
            spell_id = {
                id = 2,
                type = "message",
                label = "optional",
                message_type = "ActionID",
                description = "Optional spell ID to check for specific spell"
            }
        },
        oneofs = {},
        field_order = { "unit", "spell_id" },
        _metadata = {
            ui_label = "Unit Is Channeling",
            submenu = { "unit" },
            short_description = "Checks if a unit is currently channeling any spell or a specific spell.",
            full_description = "Checks if a unit is currently channeling any spell or a specific spell. Returns true if the unit is channeling (any spell or specific spell), false otherwise.",
        }
    },

    ["APLValueUnitIsInterruptible"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            unit = {
                id = 1,
                type = "message",
                label = "optional",
                message_type = "UnitReference",
                description = "The unit to check (defaults to 'target')"
            }
        },
        oneofs = {},
        field_order = { "unit" },
        _metadata = {
            ui_label = "Unit Is Interruptible",
            submenu = { "unit" },
            short_description = "Checks if a unit is currently casting or channeling and is interruptible.",
            full_description = "Checks if a unit is currently casting or channeling and is interruptible. Returns true if the unit is currently casting or channeling and is interruptible, false otherwise.",
        }
    },

    ["APLValueUnitIsMobType"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            unit = {
                id = 1,
                type = "message",
                label = "optional",
                message_type = "UnitReference",
                description = "The unit to check (defaults to 'target')"
            },
            mob_type = {
                id = 2,
                type = "string",
                label = "required",
                description = "The type of mob to check for"
            }
        },
        oneofs = {},
        field_order = { "unit", "mob_type" },
        _metadata = {
            ui_label = "Unit Is Mob Type",
            submenu = { "unit" },
            short_description = "Checks if a unit is of a specific mob type.",
            full_description = "Checks if a unit is of a specific mob type. Returns true if the unit is of the specified mob type, false otherwise.",
        }
    },

    ["APLValueUnitIsPrimaryTarget"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            source = {
                id = 1,
                type = "message",
                label = "optional",
                message_type = "UnitReference",
                description = "The unit to check threat for (defaults to 'player')"
            },
            target = {
                id = 2,
                type = "message",
                label = "optional",
                message_type = "UnitReference",
                description = "The unit to check threat against (defaults to 'target')"
            }
        },
        oneofs = {},
        field_order = { "source", "target" },
        _metadata = {
            ui_label = "Unit Is Primary Target",
            submenu = { "unit" },
            short_description = "Checks if a source unit is the primary target (has aggro) on a target unit.",
            full_description = "Checks if a source unit is the primary target (has aggro) on a target unit. Returns true if the source unit is tanking the target, false otherwise.",
        }
    },

    ["APLValueUnitThreatPercent"] = {
        modification_type = "full",
        function_type = "APLValue",
        fields = {
            source = {
                id = 1,
                type = "message",
                label = "optional",
                message_type = "UnitReference",
                description = "The unit to check threat for (defaults to 'player')"
            },
            target = {
                id = 2,
                type = "message",
                label = "optional",
                message_type = "UnitReference",
                description = "The unit to check threat against (defaults to 'target')"
            }
        },
        oneofs = {},
        field_order = { "source", "target" },
        _metadata = {
            ui_label = "Unit Threat Percent",
            submenu = { "unit" },
            short_description = "Returns the threat percent (0-100) for a source unit on a target.",
            full_description = "Returns the threat percent (0-100) for a source unit on a target. Uses UnitDetailedThreatSituation when available and returns 0 if unavailable.",
        }
    },

    ["APLValueUnitThreatRawPercent"] = {
        modification_type = "full",
        function_type = "APLValue",
        fields = {
            source = {
                id = 1,
                type = "message",
                label = "optional",
                message_type = "UnitReference",
                description = "The unit to check threat for (defaults to 'player')"
            },
            target = {
                id = 2,
                type = "message",
                label = "optional",
                message_type = "UnitReference",
                description = "The unit to check threat against (defaults to 'target')"
            }
        },
        oneofs = {},
        field_order = { "source", "target" },
        _metadata = {
            ui_label = "Unit Threat Raw Percent",
            submenu = { "unit" },
            short_description = "Returns the raw threat percent (0-100) for a source unit on a target.",
            full_description = "Returns the raw threat percent (0-100) for a source unit on a target. Uses UnitDetailedThreatSituation when available and returns 0 if unavailable.",
        }
    },

    ["APLValueUnitThreatValue"] = {
        modification_type = "full",
        function_type = "APLValue",
        fields = {
            source = {
                id = 1,
                type = "message",
                label = "optional",
                message_type = "UnitReference",
                description = "The unit to check threat for (defaults to 'player')"
            },
            target = {
                id = 2,
                type = "message",
                label = "optional",
                message_type = "UnitReference",
                description = "The unit to check threat against (defaults to 'target')"
            }
        },
        oneofs = {},
        field_order = { "source", "target" },
        _metadata = {
            ui_label = "Unit Threat Value",
            submenu = { "unit" },
            short_description = "Returns the raw threat value for a source unit on a target.",
            full_description = "Returns the raw threat value for a source unit on a target. Uses UnitDetailedThreatSituation when available and returns 0 if unavailable.",
        }
    },

    ["APLValueUnitIsStealthed"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            unit = {
                id = 1,
                type = "message",
                label = "optional",
                message_type = "UnitReference",
                description = "The unit to check (defaults to 'player')"
            }
        },
        oneofs = {},
        field_order = { "unit" },
        _metadata = {
            ui_label = "Unit Is Stealthed",
            submenu = { "unit" },
            short_description = "Checks if a unit is currently stealthed.",
            full_description = "Checks if a unit is currently stealthed. Returns true if the unit is stealthed, false otherwise. Supports various stealth abilities including Stealth and Vanish.",
        }
    },

    -- Warrior and Weapon function APLValue handlers
    ["APLValueWarriorShouldInterrupt"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            ui_label = "Warrior Should Interrupt",
            submenu = { "misc" },
            short_description = "Determines if the warrior should proactively use interrupt based on encounter/mob history and glyph presence.",
            full_description = "Determines if the warrior should proactively use interrupt based on prior encounter/mob history and glyph presence (Glyph of Rude Interruption). Returns true if the warrior should use interrupt, false otherwise. Originally from WarriorArmsCSWindow module.",
        }
    },

    ["APLValueWarriorShouldNotSlamOverride"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            ui_label = "Warrior Should Not Slam Override",
            submenu = { "misc" },
            short_description = "Returns true when Slam should NOT override Overpower within CS window.",
            full_description = "Convenience inverse function that returns true when Slam should NOT override Overpower within the current Colossus Smash window. Returns true if standard priority (no Slam override) should apply.",
        }
    },

    ["APLValueWarriorShouldSlamOverride"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            ui_label = "Warrior Should Slam Override",
            submenu = { "misc" },
            short_description = "Returns whether Slam should override Overpower within the current Colossus Smash window.",
            full_description = "Returns whether Slam should override Overpower within the current Colossus Smash window. Uses WarriorArmsCSWindow (message-driven) and caches result for ~50ms to minimize CPU. Returns true if Slam should override Overpower for the remainder of the active CS window.",
        }
    },

    ["APLValueWeaponDamage"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            weapon = {
                id = 1,
                type = "string",
                label = "optional",
                description = "The weapon to check damage for (defaults to 'mainhand', options: 'mainhand', 'offhand')"
            }
        },
        oneofs = {},
        field_order = { "weapon" },
        _metadata = {
            ui_label = "Weapon Damage",
            submenu = { "misc" },
            short_description = "Returns the average base weapon damage for the specified weapon.",
            full_description = "Returns the average base weapon damage for the specified weapon. Calculates base weapon damage by removing attack power contribution. Returns 0 if weapon data is unavailable.",
        }
    },

    -- Encounter and Class function APLValue handlers
    ["APLValueNumberTargetsWithDRWDebuff"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            spell_id = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The ID of the debuff to check for"
            },
            range = {
                id = 2,
                type = "int32",
                label = "optional",
                description = "Optional range to use for counting targets (default: 15)"
            }
        },
        oneofs = {},
        field_order = { "spell_id", "range" },
        _metadata = {
            ui_label = "Number Targets With DRW Debuff",
            submenu = { "encounter" },
            short_description = "Counts the number of targets with a DRW-applied debuff.",
            full_description = "Counts the number of targets with a DRW-applied debuff. Returns the number of targets within the specified range that have the DRW-applied debuff.",
        }
    },

    ["APLValueNumberTargetsWithDebuff"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            spell_id = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The ID of the debuff to check for"
            },
            range = {
                id = 2,
                type = "int32",
                label = "optional",
                description = "Optional additional range to add to target distance (overrides spec-appropriate ranges)"
            }
        },
        oneofs = {},
        field_order = { "spell_id", "range" },
        _metadata = {
            ui_label = "Number Targets With Debuff",
            submenu = { "encounter" },
            short_description = "Counts the number of targets with a specified debuff.",
            full_description = "Counts the number of targets with a specified debuff. Uses spec-appropriate ranges by default, with optional range override. Returns the number of targets with the specified debuff.",
        }
    },

    ["APLValueNumberTargetsWithTTD"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            min_ttd = {
                id = 1,
                type = "double",
                label = "required",
                description = "The minimum TTD threshold in seconds"
            },
            range = {
                id = 2,
                type = "int32",
                label = "optional",
                description = "Optional range to use for counting targets (default: 15)"
            }
        },
        oneofs = {},
        field_order = { "min_ttd", "range" },
        _metadata = {
            ui_label = "Number Targets With TTD",
            submenu = { "encounter" },
            short_description = "Counts the number of targets with TTD higher than the threshold.",
            full_description = "Counts the number of targets with TTD (Time To Die) higher than the specified threshold. Returns the number of targets within the specified range that meet the TTD requirement.",
        }
    },

    ["APLValuePaladinCast"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            spell_id = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The ID of the spell to cast"
            }
        },
        oneofs = {},
        field_order = { "spell_id" },
        _metadata = {
            ui_label = "Paladin Cast",
            submenu = { "misc" },
            short_description = "Sets up a Paladin spell for casting with proper frame handling.",
            full_description = "Sets up a Paladin spell for casting with proper frame handling. Checks if spell can be cast and sets up the primary frame for casting. Returns true if the spell was set up for casting, false otherwise.",
        }
    },

    ["APLValuePaladinCastWithMacro"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            spell_id = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The ID of the spell to cast"
            },
            macro = {
                id = 2,
                type = "string",
                label = "required",
                description = "The macro type to use (options: 'STARTATTACK', 'STOPATTACK')"
            }
        },
        oneofs = {},
        field_order = { "spell_id", "macro" },
        _metadata = {
            ui_label = "Paladin Cast With Macro",
            submenu = { "misc" },
            short_description = "Sets up a Paladin spell for casting with macro support.",
            full_description = "Sets up a Paladin spell for casting with macro support. Validates macro type and sets up the primary frame for casting with the specified macro. Returns true if the spell was set up for casting, false otherwise.",
        }
    },

    ["APLValuePetIsActive"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            ui_label = "Pet Is Active",
            submenu = { "misc" },
            short_description = "Checks if a pet is currently active.",
            full_description = "Checks if a pet is currently active. Returns true if a pet exists and is not dead, false otherwise.",
        }
    },

    ["APLValueGetNumGroupMembers"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            ui_label = "Get Num Group Members",
            submenu = { "misc" },
            short_description = "Gets the number of group members (including the player).",
            full_description = "Gets the number of group members (including the player). Returns 0 if not in a group, or the number of group members if in a party/raid.",
        }
    },

    ["APLValueGetSubgroupMemberUnits"] = {
        modification_type = "full",
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            ui_label = "Get Subgroup Member Units",
            submenu = { "misc" },
            short_description = "Returns unit IDs for the player's subgroup (raid = subgroup only; party = full party; solo = player).",
            full_description = "Returns a table of unit ID strings for the player's subgroup. In raid: player's subgroup only (5 people). In party: full party. Solo: {\"player\"}. Do not store the returned table; iterate immediately.",
        }
    },

    ["APLValueGetClassCountInGroup"] = {
        modification_type = "full",
        function_type = "APLValue",
        fields = {
            class_token = {
                id = 1,
                type = "string",
                label = "optional",
                description = "Class token (e.g. HUNTER, PALADIN). Omit for player's class."
            },
            scope = {
                id = 2,
                type = "string",
                label = "optional",
                description = "\"group\" (full raid/party) or \"subgroup\" (raid = subgroup only). Default: group."
            }
        },
        oneofs = {},
        field_order = { "class_token", "scope" },
        _metadata = {
            ui_label = "Get Class Count In Group",
            submenu = { "misc" },
            short_description = "Number of units of the given class in the group or subgroup. Omit class for player's class.",
            full_description = "Returns the number of units of the given class in the group or subgroup. When class_token is omitted, uses the player's class. Scope: \"group\" (default) = full raid/party; \"subgroup\" = raid subgroup only.",
        }
    },

    ["APLValueIsOnlyClassInGroup"] = {
        modification_type = "full",
        function_type = "APLValue",
        fields = {
            class_token = {
                id = 1,
                type = "string",
                label = "optional",
                description = "Class token. Omit for player's class."
            },
            scope = {
                id = 2,
                type = "string",
                label = "optional",
                description = "\"group\" (default) or \"subgroup\"."
            }
        },
        oneofs = {},
        field_order = { "class_token", "scope" },
        _metadata = {
            ui_label = "Is Only Class In Group",
            submenu = { "misc" },
            short_description = "True when at most one unit of that class is in the group. Omit class for player's class.",
            full_description = "Returns true when at most one unit of the given class is in the group or subgroup. When class_token is omitted, uses the player's class. Default scope: group.",
        }
    },

    ["APLValueHasOtherClassInGroup"] = {
        modification_type = "full",
        function_type = "APLValue",
        fields = {
            class_token = {
                id = 1,
                type = "string",
                label = "optional",
                description = "Class token. Omit for player's class."
            },
            scope = {
                id = 2,
                type = "string",
                label = "optional",
                description = "\"subgroup\" (default) or \"group\"."
            }
        },
        oneofs = {},
        field_order = { "class_token", "scope" },
        _metadata = {
            ui_label = "Has Other Class In Group",
            submenu = { "misc" },
            short_description = "True when at least one other unit of that class (excluding player) is in the group. Omit class for player's class.",
            full_description = "Returns true when at least one other unit of the given class (excluding the player) is in the group or subgroup. When class_token is omitted, uses the player's class. Default scope: subgroup.",
        }
    },

    ["APLValueGetClassSetting"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            key = {
                id = 1,
                type = "string",
                label = "required",
                description = "The setting key path (supports dot notation, e.g., 'recommendAspects' or 'settings.size')"
            },
            default_value = {
                id = 2,
                type = "message",
                label = "optional",
                message_type = "APLValue",
                description = "Optional default value to return if the setting is not found"
            }
        },
        oneofs = {},
        field_order = { "key", "default_value" },
        _metadata = {
            ui_label = "Get Class Setting",
            submenu = { "class" },
            short_description = "Gets a class-specific setting value from the active class module's database.",
            full_description = "Gets a class-specific setting value from the active class module's database. Accesses settings from classModule.db.class namespace using dot notation. Returns the setting value if found, or the default value if provided and the setting is not found.",
            include_if = {
                class_specific = true,
                prepull_only = false,
                combat_only = false,
                spec_specific = false
            }
        }
    },

    ["APLValuePooling"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            ui_label = "Pooling",
            submenu = { "misc" },
            short_description = "Triggers pooling visual overlay and WeakAuras event.",
            full_description = "Triggers pooling visual overlay and WeakAuras event. Shows pooling overlay on primary frame and prevents multiple overlays from stacking. Returns false (always returns false).",
        }
    },

    ["APLValueResetSequence"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            name = {
                id = 1,
                type = "string",
                label = "required",
                description = "The name of the sequence to reset"
            }
        },
        oneofs = {},
        field_order = { "name" },
        _metadata = {
            ui_label = "Reset Sequence",
            submenu = { "sequences" },
            short_description = "Resets a specific sequence to its starting position.",
            full_description = "Resets a specific sequence to its starting position. Clears completed sequences tracking and resets the sequence position back to start. Returns true if successful, false otherwise.",
        }
    },

    ["APLValueResetSequences"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            ui_label = "Reset Sequences",
            submenu = { "sequences" },
            short_description = "Resets all regular sequences.",
            full_description = "Resets all regular sequences. Clears all sequence position and spell tracking data, and resets right-side sequence slots. Returns true if successful.",
        }
    },

    ["APLValueResetStrictSequence"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            name = {
                id = 1,
                type = "string",
                label = "required",
                description = "The name of the strict sequence to reset"
            }
        },
        oneofs = {},
        field_order = { "name" },
        _metadata = {
            ui_label = "Reset Strict Sequence",
            submenu = { "sequences" },
            short_description = "Resets a specific strict sequence.",
            full_description = "Resets a specific strict sequence. Clears the sequence tracking data and resets the global sequence active flag if no more sequences are active. Returns true if successful.",
        }
    },

    ["APLValueResetStrictSequences"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            ui_label = "Reset Strict Sequences",
            submenu = { "sequences" },
            short_description = "Resets all strict sequences.",
            full_description = "Resets all strict sequences. Clears all sequence tracking data and resets the global sequence active flag. Returns true if successful.",
        }
    },

    -- Final Spell and DRW function APLValue handlers
    ["APLValueSpellLastCast"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            ui_label = "Spell Last Cast",
            submenu = { "spell" },
            short_description = "Returns the ID of the last spell cast.",
            full_description = "Returns the ID of the last spell cast. Uses StateManager to track the most recently cast spell. Returns 0 if no spell has been cast yet.",
        }
    },

    ["APLValueSpellTimeToReadyWithGCD"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            spell_id = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The ID of the spell to check"
            }
        },
        oneofs = {},
        field_order = { "spell_id" },
        _metadata = {
            ui_label = "Spell Time To Ready With GCD",
            submenu = { "spell" },
            short_description = "Returns the time until a spell is ready, considering GCD.",
            full_description = "Returns the time until a spell is ready, considering GCD. Combines spell cooldown time with GCD time to ready. Returns -1 for invalid spells. Handles negative values properly (negative means spell is ready).",
        }
    },

    ["APLValueTimeToReady"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            id = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The ID of the spell, trinket, or ability to check"
            }
        },
        oneofs = {},
        field_order = { "id" },
        _metadata = {
            ui_label = "Time To Ready",
            submenu = { "spell" },
            short_description = "Returns the time until an ability is ready (generic version).",
            full_description = "Returns the time until an ability is ready. Works with spells, trinkets, and other abilities. Returns -1 for invalid IDs. This is a generic version that handles multiple entity types.",
        }
    },

    ["APLValueShouldMultidot"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            spell_id = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The spell ID to check for multidotting"
            },
            max_dots = {
                id = 2,
                type = "int32",
                label = "optional",
                description = "The maximum number of DoTs allowed"
            },
            max_overlap = {
                id = 3,
                type = "message",
                label = "optional",
                message_type = "APLValue"
            },
            range = {
                id = 4,
                type = "double",
                label = "optional",
                description = "Optional range for target counting"
            }
        },
        oneofs = {},
        field_order = { "spell_id", "max_dots", "max_overlap", "range" },
        _metadata = {
            ui_label = "Should Multidot",
            submenu = { "dot" },
            short_description = "Determines if a spell should be used for multidotting.",
            full_description = "Determines if a spell should be used for multidotting without casting it. Checks if applying the DoT to multiple targets is beneficial based on max dots, overlap time, and range constraints.",
        }
    },

    ["APLValueSwingTimeDifference"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            ui_label = "Swing Time Difference",
            submenu = { "auto" },
            short_description = "Returns the difference in swing times between main hand and off hand.",
            full_description = "Returns the difference in swing times between main hand and off hand. Uses swing timer library to track swing timing. Returns 0 if swing timer library is not available or not initialized.",
        }
    },

    ["APLValueTargetDRWDebuffRemainingTime"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            spell_id = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The ID of the DRW debuff to check for"
            }
        },
        oneofs = {},
        field_order = { "spell_id" },
        _metadata = {
            ui_label = "Target DRW Debuff Remaining Time",
            submenu = { "death_knight" },
            short_description = "Gets the remaining time for a DRW-applied debuff on the current target.",
            full_description = "Gets the remaining time for a DRW-applied debuff on the current target. Uses DRW_Tracking to get the remaining time for the specific debuff. Returns 0 if not found or if no target exists.",
        }
    },

    ["APLValueTargetHasDRWDebuff"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            spell_id = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The ID of the DRW debuff to check for"
            }
        },
        oneofs = {},
        field_order = { "spell_id" },
        _metadata = {
            ui_label = "Target Has DRW Debuff",
            submenu = { "death_knight" },
            short_description = "Checks if the current target has a DRW-applied debuff.",
            full_description = "Checks if the current target has a DRW-applied debuff. Uses DRW_Tracking to check if the target has the specific DRW-applied debuff. Returns false if no target exists or if the debuff is not found.",
        }
    },

    -- Raid, Snapshot, and SelectRotation function APLValue handlers
    ["APLValueRaidBuffIsActive"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            buff_type = {
                id = 1,
                type = "string",
                label = "required",
                description = "The buff type to check from Types:GetType('BuffType')"
            }
        },
        oneofs = {},
        field_order = { "buff_type" },
        _metadata = {
            ui_label = "Raid Buff Is Active",
            submenu = { "misc" },
            short_description = "Checks if a raid buff type is active on any group member.",
            full_description = "Checks if a raid buff type is active on any group member. Validates buff type exists in registry and checks all spells that provide this buff type. Returns true if the buff type is active, false otherwise.",
        }
    },

    ["APLValueRaidDebuffIsActive"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            debuff_type = {
                id = 1,
                type = "string",
                label = "required",
                description = "The debuff type to check from Types:GetType('DebuffType')"
            }
        },
        oneofs = {},
        field_order = { "debuff_type" },
        _metadata = {
            ui_label = "Raid Debuff Is Active",
            submenu = { "misc" },
            short_description = "Checks if a raid debuff type is active on the target.",
            full_description = "Checks if a raid debuff type is active on the target. Validates debuff type exists in registry and checks all spells of this debuff type. Returns true if the debuff type is active, false otherwise.",
        }
    },

    ["APLValueRaidUnitBuff"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            spell_input_1 = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The first spell ID to check for"
            },
            spell_input_2 = {
                id = 2,
                type = "message",
                label = "optional",
                message_type = "ActionID",
                description = "The second spell ID to check for"
            },
            spell_input_3 = {
                id = 3,
                type = "message",
                label = "optional",
                message_type = "ActionID",
                description = "The third spell ID to check for"
            },
            spell_input_4 = {
                id = 4,
                type = "message",
                label = "optional",
                message_type = "ActionID",
                description = "The fourth spell ID to check for"
            },
            spell_input_5 = {
                id = 5,
                type = "message",
                label = "optional",
                message_type = "ActionID",
                description = "The fifth spell ID to check for"
            }
        },
        oneofs = {},
        field_order = { "spell_input_1", "spell_input_2", "spell_input_3", "spell_input_4", "spell_input_5" },
        _metadata = {
            ui_label = "Raid Unit Buff",
            submenu = { "misc" },
            short_description = "Checks if any group member has any of the specified buffs.",
            full_description = "Checks if any group member has any of the specified buffs. Uses FindAuraMulti to check for multiple buff IDs on all group members. Returns true if any group member has any of the specified buffs, false otherwise.",
        }
    },

    ["APLValueRaidUnitDebuff"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            spell_input_1 = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The first spell ID to check for"
            },
            spell_input_2 = {
                id = 2,
                type = "message",
                label = "optional",
                message_type = "ActionID",
                description = "The second spell ID to check for"
            },
            spell_input_3 = {
                id = 3,
                type = "message",
                label = "optional",
                message_type = "ActionID",
                description = "The third spell ID to check for"
            },
            spell_input_4 = {
                id = 4,
                type = "message",
                label = "optional",
                message_type = "ActionID",
                description = "The fourth spell ID to check for"
            },
            spell_input_5 = {
                id = 5,
                type = "message",
                label = "optional",
                message_type = "ActionID",
                description = "The fifth spell ID to check for"
            }
        },
        oneofs = {},
        field_order = { "spell_input_1", "spell_input_2", "spell_input_3", "spell_input_4", "spell_input_5" },
        _metadata = {
            ui_label = "Raid Unit Debuff",
            submenu = { "misc" },
            short_description = "Checks if any group member has any of the specified debuffs.",
            full_description = "Checks if any group member has any of the specified debuffs. Uses FindAuraMulti to check for multiple debuff IDs on all group members. Returns true if any group member has any of the specified debuffs, false otherwise.",
        }
    },

    ["APLValueSnapshot"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            stat_input_1 = {
                id = 1,
                type = "string",
                label = "required",
                description = "The first stat to snapshot (e.g., 'ap', 'str', 'crit')"
            },
            spell_id = {
                id = 2,
                type = "message",
                label = "optional",
                message_type = "ActionID",
                description = "Optional spell ID to get snapshot from specific spell"
            },
            stat_input_2 = {
                id = 3,
                type = "string",
                label = "optional",
                description = "The second stat to snapshot (e.g., 'agi', 'haste', 'mastery')"
            },
            stat_input_3 = {
                id = 4,
                type = "string",
                label = "optional",
                description = "The third stat to snapshot"
            },
            stat_input_4 = {
                id = 5,
                type = "string",
                label = "optional",
                description = "The fourth stat to snapshot"
            }
        },
        oneofs = {},
        field_order = { "stat_input_1", "spell_id", "stat_input_2", "stat_input_3", "stat_input_4" },
        _metadata = {
            ui_label = "Snapshot",
            submenu = { "misc" },
            short_description = "Gets snapshot values for specified stats from a spell or current values.",
            full_description = "Gets snapshot values for specified stats from a spell or current values. Can get snapshot values from when a specific spell was applied, or current stat values. Returns combined stat values or 0 if Snapshotter is not available.",
        }
    },

    ["APLValueSnapshotPercent"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            spell_id = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The spell ID to get snapshot from"
            },
            stat_input_1 = {
                id = 2,
                type = "string",
                label = "required",
                description = "The first stat to compare (e.g., 'ap', 'str', 'crit')"
            },
            stat_input_2 = {
                id = 3,
                type = "string",
                label = "optional",
                description = "The second stat to compare (e.g., 'agi', 'haste', 'mastery')"
            },
            stat_input_3 = {
                id = 4,
                type = "string",
                label = "optional",
                description = "The third stat to compare"
            },
            stat_input_4 = {
                id = 5,
                type = "string",
                label = "optional",
                description = "The fourth stat to compare"
            }
        },
        oneofs = {},
        field_order = { "spell_id", "stat_input_1", "stat_input_2", "stat_input_3", "stat_input_4" },
        _metadata = {
            ui_label = "Snapshot Percent",
            submenu = { "misc" },
            short_description = "Calculates percentage increase of stats compared to snapshot values.",
            full_description = "Calculates percentage increase of stats compared to snapshot values. Compares current stat values with snapshot values from when the spell was applied. Returns percentage increase or 0 if Snapshotter is not available.",
        }
    },

    ["APLValueSelectRotation"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            rotation_name = {
                id = 1,
                type = "string",
                label = "required",
                description = "The full name of the rotation to select"
            }
        },
        oneofs = {},
        field_order = { "rotation_name" },
        _metadata = {
            ui_label = "Select Rotation",
            submenu = { "misc" },
            short_description = "Selects a rotation for the current specialization.",
            full_description = "Selects a rotation for the current specialization. Gets the class module and current specialization, then calls the class module's SelectRotation method. Returns true if successful, false otherwise with error message.",
        }
    },

    -- PvP value handlers
    ["APLValueEnemyCooldownDown"] = {
        modification_type = "full",
        function_type = "APLValue",
        fields = {
            unit = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "UnitReference",
                description = "The unit to check (e.g., 'target', 'focus', 'arena1', 'arena2', 'arena3')"
            },
            spell_id = {
                id = 2,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "Spell ID to check (e.g., 2139 for Counterspell)"
            }
        },
        oneofs = {},
        field_order = { "unit", "spell_id" },
        _metadata = {
            ui_label = "Enemy Cooldown Down",
            submenu = { "pvp" },
            short_description = "Returns true if enemy's cooldown for the spell is ready (PvPTracker).",
        }
    },

    ["APLValueTargetDRReady"] = {
        modification_type = "full",
        function_type = "APLValue",
        fields = {
            category = {
                id = 1,
                type = "string",
                label = "required",
                description = "DR category: stun, incapacitate, fear, root, silence, disorient, knockback"
            }
        },
        oneofs = {},
        field_order = { "category" },
        _metadata = {
            ui_label = "Target DR Ready",
            submenu = { "pvp" },
            short_description = "Returns true if target's diminishing returns for the category have reset.",
        }
    },

    ["APLValueIsInPvP"] = {
        modification_type = "full",
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            ui_label = "Is In PvP",
            submenu = { "pvp" },
            short_description = "Returns true if the player is in an arena or battleground.",
        }
    },

    ["APLValueArenaUnitExists"] = {
        modification_type = "full",
        function_type = "APLValue",
        fields = {
            arena_index = {
                id = 1,
                type = "int32",
                label = "required",
                description = "Arena slot (1-5)"
            }
        },
        oneofs = {},
        field_order = { "arena_index" },
        _metadata = {
            ui_label = "Arena Unit Exists",
            submenu = { "pvp" },
            short_description = "Returns true if the specified arena opponent exists.",
        }
    },

    ["APLValueTargetImmune"] = {
        modification_type = "full",
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            ui_label = "Target Immune",
            submenu = { "pvp" },
            short_description = "Returns true if target has immunity buff (Ice Block, Divine Shield, etc.). Suppress offensive suggestions when true.",
        }
    },

    ["APLValueUnitImmune"] = {
        modification_type = "full",
        function_type = "APLValue",
        fields = {
            unit = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "UnitReference",
                description = "The unit to check (e.g., 'target', 'focus', 'arena1')"
            }
        },
        oneofs = {},
        field_order = { "unit" },
        _metadata = {
            ui_label = "Unit Immune",
            submenu = { "pvp" },
            short_description = "Returns true if the unit has immunity buff. Suppress offensive suggestions when true.",
        }
    },

    ["APLValueTargetSafeToCast"] = {
        modification_type = "full",
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            ui_label = "Target Safe To Cast",
            submenu = { "pvp" },
            short_description = "Returns true when target's interrupts are on cooldown. Use before hard casts.",
        }
    },

    ["APLValueSafeToCast"] = {
        modification_type = "full",
        function_type = "APLValue",
        fields = {
            unit = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "UnitReference",
                description = "The unit to check (e.g., 'target', 'focus', 'arena1')"
            }
        },
        oneofs = {},
        field_order = { "unit" },
        _metadata = {
            ui_label = "Safe To Cast",
            submenu = { "pvp" },
            short_description = "Returns true when the unit's interrupts are on cooldown. Use before hard casts.",
        }
    },

    ["APLValueSuggestedKillTarget"] = {
        modification_type = "full",
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            ui_label = "Suggested Kill Target",
            submenu = { "pvp" },
            short_description = "Returns arena unit with no defensives (e.g. 'arena2'), or nil. Ideal swap target.",
        }
    },

    ["APLValueUnitOutOfDefensives"] = {
        modification_type = "full",
        function_type = "APLValue",
        fields = {
            unit = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "UnitReference",
                description = "The unit to check (e.g., 'target', 'focus', 'arena1')"
            }
        },
        oneofs = {},
        field_order = { "unit" },
        _metadata = {
            ui_label = "Unit Out Of Defensives",
            submenu = { "pvp" },
            short_description = "Returns true if the unit has no defensives remaining.",
        }
    },

    ["APLValueHealerInCC"] = {
        modification_type = "full",
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            ui_label = "Healer In CC",
            submenu = { "pvp" },
            short_description = "Returns true if the party healer has a CC debuff. Promote self-sustain when true.",
        }
    },

    ["APLValueBurstWindowOpen"] = {
        modification_type = "full",
        function_type = "APLValue",
        fields = {
            unit = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "UnitReference",
                description = "The target unit (e.g., 'target', 'arena1')"
            }
        },
        oneofs = {},
        field_order = { "unit" },
        _metadata = {
            ui_label = "Burst Window Open",
            submenu = { "pvp" },
            short_description = "Composite: healer CC'd, target out of defensives, DR ready, interrupts on CD.",
        }
    },

    ["APLValueTargetTrinketReady"] = {
        modification_type = "full",
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            ui_label = "Target Trinket Ready",
            submenu = { "pvp" },
            short_description = "Returns true if target's PvP trinket is ready. Suppress CC if true.",
        }
    },

    ["APLValueEnemyTrinketReady"] = {
        modification_type = "full",
        function_type = "APLValue",
        fields = {
            unit = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "UnitReference",
                description = "The unit to check (e.g., 'target', 'arena1')"
            }
        },
        oneofs = {},
        field_order = { "unit" },
        _metadata = {
            ui_label = "Enemy Trinket Ready",
            submenu = { "pvp" },
            short_description = "Returns true if the unit's PvP trinket is ready. Suppress CC if true.",
        }
    },

    ["APLValuePlayerTrinketReady"] = {
        modification_type = "full",
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            ui_label = "Player Trinket Ready",
            submenu = { "pvp" },
            short_description = "Returns true if player's PvP trinket is ready. Use when CC'd.",
        }
    },

    ["APLValueDampeningPercent"] = {
        modification_type = "full",
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            ui_label = "Dampening Percent",
            submenu = { "pvp" },
            short_description = "Returns arena dampening 0-100, or nil. Use for dampening strategy (e.g. >= 30).",
        }
    },

    ["APLValueHasPVPTalent"] = {
        modification_type = "full",
        function_type = "APLValue",
        fields = {
            talent_id = {
                id = 1,
                type = "int32",
                label = "required",
                description = "PvP talent spell ID (e.g., Gladiator's Medallion)"
            }
        },
        oneofs = {},
        field_order = { "talent_id" },
        _metadata = {
            ui_label = "Has PVP Talent",
            submenu = { "pvp" },
            short_description = "Returns true if player has the PvP talent selected. Retail/BfA+ only.",
        }
    },

    -- Final Unit and Time function APLValue handlers
    ["APLValueUnitCastTimeRemaining"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            unit = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "UnitReference",
                description = "The unit to check (e.g., 'player', 'target', 'focus')"
            }
        },
        oneofs = {},
        field_order = { "unit" },
        _metadata = {
            ui_label = "Unit Cast Time Remaining",
            submenu = { "unit" },
            short_description = "Returns the remaining cast time for a unit's current spell.",
            full_description = "Returns the remaining cast time for a unit's current spell. Uses UnitCastingInfo to get cast information and calculates remaining time. Returns 0 if unit doesn't exist or is not casting.",
        }
    },

    ["APLValueUnitChannelTimeRemaining"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            unit = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "UnitReference",
                description = "The unit to check (e.g., 'player', 'target', 'focus')"
            }
        },
        oneofs = {},
        field_order = { "unit" },
        _metadata = {
            ui_label = "Unit Channel Time Remaining",
            submenu = { "unit" },
            short_description = "Returns the remaining channel time for a unit's current spell.",
            full_description = "Returns the remaining channel time for a unit's current spell. Uses UnitChannelInfo to get channel information and calculates remaining time. Returns 0 if unit doesn't exist or is not channeling.",
        }
    },

    ["APLValueUnitDebuffGlobal"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            unit = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "UnitReference",
                description = "The unit to check (e.g., 'player', 'target', 'focus')"
            },
            spell_id = {
                id = 2,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The spell ID or name to check"
            }
        },
        oneofs = {},
        field_order = { "unit", "spell_id" },
        _metadata = {
            ui_label = "Unit Debuff Global",
            submenu = { "aura" },
            short_description = "Checks for a debuff on a unit (global search).",
            full_description = "Checks for a debuff on a unit using global aura search. Returns AuraData table if found, false if not found. This is part of the enhanced aura handlers system for checking debuffs across all units.",
        }
    },

    ["APLValueTimeOnTarget"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            ui_label = "Time On Target",
            submenu = { "encounter" },
            short_description = "Returns the time spent on the current target in seconds.",
            full_description = "Returns the time spent on the current target in seconds. Calculates time elapsed since target start time was recorded. Returns 0 if not in combat, no target, or no start time recorded.",
        }
    },

    -- Tier Set function APLValue handler
    ["APLValueTierSetEquipped"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            tier = {
                id = 1,
                type = "string",
                label = "required",
                description = "The tier set identifier to check (e.g., 'Druid_T30')"
            },
            count = {
                id = 2,
                type = "int32",
                label = "required",
                description = "The minimum number of pieces required (1-6)"
            }
        },
        oneofs = {},
        field_order = { "tier", "count" },
        _metadata = {
            ui_label = "Tier Set Equipped",
            submenu = { "aura" },
            short_description = "Checks if a specific tier set is equipped with the required number of pieces.",
            full_description = "Checks if a specific tier set is equipped with the required number of pieces. Determines if the player has at least the specified number of pieces for a given tier set. Returns true if the player has at least 'count' pieces of the specified tier set, false otherwise.",
        }
    },

    -- Strict Sequence function APLValue handlers
    ["APLValueStrictSequenceIsReady"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            sequence = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The spells in the strict sequence (comma-separated spell IDs)"
            }
        },
        oneofs = {},
        field_order = { "sequence" },
        _metadata = {
            ui_label = "Strict Sequence Is Ready",
            submenu = { "sequences" },
            short_description = "Checks if a strict sequence is ready to be executed (all spells off cooldown).",
            full_description = "Checks if a strict sequence is ready to be executed (all spells off cooldown). Returns true if the strict sequence is ready, false otherwise. Uses StrictSequenceTimeToReady internally to determine readiness.",
        }
    },

    ["APLValueStrictSequenceTimeToReady"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            sequence = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The spells in the strict sequence (comma-separated spell IDs)"
            }
        },
        oneofs = {},
        field_order = { "sequence" },
        _metadata = {
            ui_label = "Strict Sequence Time To Ready",
            submenu = { "sequences" },
            short_description = "Returns the maximum time to ready for a strict sequence (seconds until all spells are available).",
            full_description = "Returns the maximum time to ready for a strict sequence (seconds until all spells are available). Calculates the maximum time to ready across all spells in the sequence. Returns the maximum time to ready for the strict sequence.",
        }
    },

    -- APLValue handlers (return values) from CommonHandlers.lua
    ["APLValueUnitExists"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            unit = {
                id = 1,
                type = "message",
                label = "optional",
                message_type = "UnitReference",
                description = "The unit to check (defaults to 'target')"
            }
        },
        oneofs = {},
        field_order = { "unit" },
        _metadata = {
            ui_label = "Unit Exists",
            submenu = { "unit" },
            short_description = "Checks if a unit exists and is valid.",
            full_description = "Checks if a unit exists and is valid. Returns true if the unit exists and can be queried, false otherwise. Defaults to checking 'target' if no unit is specified.",
        }
    },

    ["APLValueUnitCanAttack"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            source_unit = {
                id = 1,
                type = "message",
                label = "optional",
                message_type = "UnitReference",
                description = "The source unit (defaults to 'player')"
            },
            target_unit = {
                id = 2,
                type = "message",
                label = "optional",
                message_type = "UnitReference",
                description = "The target unit (defaults to 'target')"
            }
        },
        oneofs = {},
        field_order = { "source_unit", "target_unit" },
        _metadata = {
            ui_label = "Unit Can Attack",
            submenu = { "unit" },
            short_description = "Checks if a source unit can attack a target unit.",
            full_description = "Checks if a source unit can attack a target unit. Returns true if the source unit can attack the target unit (target exists, is hostile, and in range), false otherwise. Defaults to checking if 'player' can attack 'target' if no units are specified.",
        }
    },

    ["APLValueTimeToPercent"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            target_percent = {
                id = 1,
                type = "int32",
                label = "required",
                description = "The target health percentage (0-100)"
            }
        },
        oneofs = {},
        field_order = { "target_percent" },
        _metadata = {
            ui_label = "Time to Percent",
            submenu = { "unit" },
            short_description = "Returns the time remaining until the target reaches the specified health percentage.",
            full_description = "Calculates the time remaining in seconds until the target reaches the specified health percentage. Useful for execute phase logic and timing-based decisions.",
        }
    },

    -- Healing APL values (mouseover and group; state from HealingStateManager)
    ["APLValueMouseoverFriendlyExists"] = {
        modification_type = "full",
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            ui_label = "Mouseover Friendly Exists",
            submenu = { "healing" },
            short_description = "True if mouseover unit exists and is friendly.",
            full_description = "Returns true if the mouseover unit exists and is a friendly unit. Used for healing rotations to check if a valid heal target is under the cursor.",
        }
    },
    ["APLValueMouseoverHealthPercent"] = {
        modification_type = "full",
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            ui_label = "Mouseover Health Percent",
            submenu = { "healing" },
            short_description = "Mouseover unit health as 0-100%.",
            full_description = "Returns the mouseover unit's current health as a percentage (0-100). Returns 100 if no mouseover.",
        }
    },
    ["APLValueMouseoverIsTank"] = {
        modification_type = "full",
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            ui_label = "Mouseover Is Tank",
            submenu = { "healing" },
            short_description = "True if mouseover unit is assigned as tank.",
            full_description = "Returns true if the mouseover unit has the tank role. Used for tank-priority healing.",
        }
    },
    ["APLValueMouseoverIsSelf"] = {
        modification_type = "full",
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            ui_label = "Mouseover Is Self",
            submenu = { "healing" },
            short_description = "True if mouseover unit is the player.",
            full_description = "Returns true if the mouseover unit is the player. Use with Earth Shield etc. to avoid recommending it on self.",
        }
    },
    ["APLValueMouseoverHasBuff"] = {
        modification_type = "full",
        function_type = "APLValue",
        fields = {
            aura_id = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The buff spell ID to check on mouseover"
            }
        },
        oneofs = {},
        field_order = { "aura_id" },
        _metadata = {
            ui_label = "Mouseover Has Buff",
            submenu = { "healing" },
            short_description = "True if mouseover has the given buff.",
            full_description = "Returns true if the mouseover unit has the specified buff. Returns false if no mouseover.",
        }
    },
    ["APLValueMouseoverBuffRemains"] = {
        modification_type = "full",
        function_type = "APLValue",
        fields = {
            aura_id = {
                id = 1,
                type = "message",
                label = "required",
                message_type = "ActionID",
                description = "The buff spell ID to check on mouseover"
            }
        },
        oneofs = {},
        field_order = { "aura_id" },
        _metadata = {
            ui_label = "Mouseover Buff Remains",
            submenu = { "healing" },
            short_description = "Remaining duration of buff on mouseover in seconds.",
            full_description = "Returns the remaining duration in seconds of the specified buff on the mouseover unit. Returns 0 if no mouseover or buff missing.",
        }
    },
    ["APLValueMouseoverNeedsDispel"] = {
        modification_type = "full",
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            ui_label = "Mouseover Needs Dispel",
            submenu = { "healing" },
            short_description = "True if mouseover has a dispellable debuff.",
            full_description = "Returns true if the mouseover unit has a debuff that the player can dispel (Magic, Curse, Disease, Poison by class).",
        }
    },
    ["APLValueMouseoverEffectiveHealthPercent"] = {
        modification_type = "full",
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            ui_label = "Mouseover Effective Health Percent",
            submenu = { "healing" },
            short_description = "Mouseover effective health 0-100% (after absorb; MoP+ when available).",
            full_description = "Returns the mouseover unit's effective health as 0-100 (health after absorb). Falls back to MouseoverHealthPercent when effective health is not in state.",
        }
    },
    ["APLValueMouseoverDispelType"] = {
        modification_type = "full",
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            ui_label = "Mouseover Dispel Type",
            submenu = { "healing" },
            short_description = "Dispel type of first dispellable debuff (Magic, Curse, Disease, Poison).",
            full_description = "Returns the dispel type of the first dispellable debuff on mouseover so rotations can choose the correct spell (e.g. Cure Disease vs Purify). Returns nil if none.",
        }
    },
    ["APLValueGroupNeedsHealing"] = {
        modification_type = "full",
        function_type = "APLValue",
        fields = {
            health_threshold = {
                id = 1,
                type = "int32",
                label = "optional",
                description = "Health % below which unit needs healing (0-100, default from settings)"
            }
        },
        oneofs = {},
        field_order = { "health_threshold" },
        _metadata = {
            ui_label = "Group Needs Healing",
            submenu = { "healing" },
            short_description = "True if any group member is below health threshold.",
            full_description = "Returns true if any group or raid member is below the given health percentage. Uses HealingStateManager threshold if not specified.",
        }
    },
    ["APLValueLowHealthMemberCount"] = {
        modification_type = "full",
        function_type = "APLValue",
        fields = {
            health_threshold = {
                id = 1,
                type = "int32",
                label = "optional",
                description = "Health % threshold (0-100, default from settings)"
            }
        },
        oneofs = {},
        field_order = { "health_threshold" },
        _metadata = {
            ui_label = "Low Health Member Count",
            submenu = { "healing" },
            short_description = "Number of group members below health threshold.",
            full_description = "Returns the number of group or raid members below the given health percentage. Uses HealingStateManager threshold if not specified.",
        }
    },

    -- Rogue-specific combo point storage functionality
    ["APLValueCurrentStoredComboPoints"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            ui_label = "Current Stored Combo Points",
            submenu = { "resources" },
            short_description = "Returns the number of stored combo points from the previous target.",
            full_description = "Returns the number of combo points that were stored when switching targets. This allows efficient use of Redirect by checking if stored combo points are available before spending energy on combo point generation.",
            include_if = {
                class_specific = true,
                classes = { "Rogue" },
                prepull_only = false,
                combat_only = false,
                spec_specific = false
            }
        }
    },

    -- Combat detection functionality
    ["APLValueInCombat"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {
            unit = {
                id = 1,
                type = "message",
                label = "optional",
                message_type = "UnitReference",
                description = "Unit to check (defaults to 'player' if not specified)"
            }
        },
        oneofs = {},
        field_order = { "unit" },
        _metadata = {
            ui_label = "In Combat",
            submenu = { "encounter" },
            short_description = "Returns |cffffcc00True|r if the unit is in combat, |cffffcc00False|r otherwise.",
            full_description = "Checks if a unit is currently in combat. If no unit is specified, defaults to 'player'. Uses UnitAffectingCombat for most units and InCombatLockdown as a fallback for player-specific UI-level combat detection.",
        }
    },

    ["APLValuePrepullActive"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            ui_label = "Prepull Active",
            submenu = { "encounter" },
            short_description = "Checks if a pre-pull timer is currently active.",
            full_description = "Checks if a pre-pull timer is currently active. Returns true if a pre-pull timer is active (e.g., from a pull timer addon), false otherwise. Useful for executing pre-pull actions before combat begins.",
        }
    },

    ["APLValuePrepullSecondsRemaining"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            ui_label = "Prepull Seconds Remaining",
            submenu = { "encounter" },
            short_description = "Gets the number of seconds until pull.",
            full_description = "Gets the number of seconds until pull (negative means pull has happened). Returns 0 if no active pull timer. Useful for timing pre-pull actions.",
        }
    },

    -- Returns true when the player is >10y from target and not currently auto-attacking.
    -- Handler signature: NAG:NeedsToStartAttacking()
    ["APLValueNeedsToStartAttacking"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            ui_label = "Needs To Start Attacking",
            submenu = { "unit" },
            short_description = "True if target is >10y and player is not auto-attacking.",
            full_description = "Returns true when the current target exists, is attackable, is farther than 10 yards away, and the player is not currently auto-attacking (IsCurrentSpell(6603) is false). Useful for detecting when the player hasn't started attacking while at range.",
        }
    },

    -- Returns true when the player is currently auto-attacking the target.
    -- Handler signature: NAG:IsAttacking()
    ["APLValueIsAttacking"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            ui_label = "Is Attacking",
            submenu = { "unit" },
            short_description = "True if player is currently auto-attacking the target.",
            full_description = "Returns true when the current target exists, is attackable, and the player is currently auto-attacking (IsCurrentSpell(6603) is true). Useful for detecting if the player has started attacking the target.",
        }
    },

    -- Hidden function to disable clauses while preserving structure
    -- Handler signature: NAG:Hidden()
    -- Returns false to disable a clause while preserving structure.
    -- Used to hide/disable rotation clauses without removing them from the rotation string.
    -- Hidden clauses can be toggled in the RotationEditor UI.
    ["APLValueHidden"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
        fields = {},
        oneofs = {},
        field_order = {},
        _metadata = {
            ui_label = "Hidden",
            submenu = { "misc" },
            short_description = "Returns false to disable a clause while preserving structure.",
            full_description = "Returns false to disable a clause while preserving structure. Used to hide/disable rotation clauses without removing them from the rotation string. Hidden clauses can be toggled in the RotationEditor UI. When prepended to an action with 'and', it prevents the action from being evaluated.",
        }
    }
}

--- Version-specific schema modifications
SchemaModifications.versionSpecificModifications = {
    --[[
    -- Mists of Pandaria Classic specific modifications
    [Version.EXPANSIONS.CATA] = {
                -- or --
    [Version.EXPANSIONS.MISTS] = {
                -- or --
    [Version.EXPANSIONS.MAINLINE] = {
        -- Retail-specific modern handlers
        ["APLValueModernCombat"] = {
        modification_type = "full",  -- Custom handler creating new message type
        function_type = "APLValue",
            fields = {
                combat_type = {
                    id = 1,
                    type = "enum",
                    label = "required",
                    enum_type = "CombatType",
                    description = "Type of combat to check"
                }
            },
            oneofs = {},
            field_order = { "combat_type" },
        _metadata = {
            ui_label = "Modern Combat",
            submenu = { "misc" },
            short_description = "Modern combat detection for retail WoW.",
            full_description = "Detects modern combat types available in retail WoW.",
        }
        }
    }]]
}

-- ~~~~~~~~~~ PUBLIC API ~~~~~~~~~~

--- Get all schema modifications for the current version
--- @return table All schema modifications (global + version-specific)
function SchemaModifications:GetAllModifications()
    local allModifications = {}

    -- Start with global modifications
    for messageType, modification in pairs(SchemaModifications.globalModifications) do
        allModifications[messageType] = modification
    end

    -- Add version-specific modifications
    local currentExpansion = Version:GetExpansion()
    local versionMods = self.versionSpecificModifications[currentExpansion]

    if versionMods then
        for messageType, modification in pairs(versionMods) do
            -- If there's a conflict, version-specific takes precedence
            allModifications[messageType] = modification
            if self.debug then
                self:Debug("Applied version-specific modification for %s (expansion: %s)",
                    messageType, currentExpansion)
            end
        end
    end

    return allModifications
end

--- Get global schema modifications only
--- @return table Global schema modifications
function SchemaModifications:GetGlobalModifications()
    return SchemaModifications.globalModifications
end

--- Get version-specific modifications for a specific expansion
--- @param expansion string The expansion to get modifications for
--- @return table|nil Version-specific modifications or nil if none exist
function SchemaModifications:GetVersionSpecificModifications(expansion)
    return self.versionSpecificModifications[expansion]
end

--- Get version-specific modifications for the current expansion
--- @return table|nil Current version-specific modifications or nil if none exist
function SchemaModifications:GetCurrentVersionModifications()
    local currentExpansion = Version:GetExpansion()
    return self.versionSpecificModifications[currentExpansion]
end

--- Get a specific modification by message type
--- @param messageType string The message type to get
--- @return table|nil The modification or nil if not found
function SchemaModifications:GetModification(messageType)
    -- Check version-specific first (takes precedence)
    local currentExpansion = Version:GetExpansion()
    local versionMods = self.versionSpecificModifications[currentExpansion]

    if versionMods and versionMods[messageType] then
        return versionMods[messageType]
    end

    -- Fall back to global
    return SchemaModifications.globalModifications[messageType]
end

--- Get the total count of modifications for the current version
--- @return number Total modification count
function SchemaModifications:GetModificationCount()
    local allMods = self:GetAllModifications()
    return TableUtils.Size(allMods)
end

--- Get the count of global modifications
--- @return number Global modification count
function SchemaModifications:GetGlobalModificationCount()
    return TableUtils.Size(SchemaModifications.globalModifications)
end

--- Get the count of version-specific modifications for current expansion
--- @return number Version-specific modification count
function SchemaModifications:GetVersionSpecificModificationCount()
    local currentExpansion = Version:GetExpansion()
    local versionMods = self.versionSpecificModifications[currentExpansion]
    return versionMods and TableUtils.Size(versionMods) or 0
end

--- Check if a modification exists for the current version
--- @param messageType string The message type to check
--- @return boolean True if the modification exists
function SchemaModifications:HasModification(messageType)
    return self:GetModification(messageType) ~= nil
end

--- Get information about modifications for debugging
--- @return table Debug information about modifications
function SchemaModifications:GetDebugInfo()
    local currentExpansion = Version:GetExpansion()
    local versionMods = self.versionSpecificModifications[currentExpansion]

    return {
        currentExpansion = currentExpansion,
        globalCount = self:GetGlobalModificationCount(),
        versionSpecificCount = self:GetVersionSpecificModificationCount(),
        totalCount = self:GetModificationCount(),
        hasVersionSpecific = versionMods ~= nil,
        versionSpecificKeys = versionMods and TableUtils.Keys(versionMods) or {}
    }
end

--- Print debug information about modifications
function SchemaModifications:PrintDebugInfo()
    local info = self:GetDebugInfo()

    self:Print("=== SchemaModifications Debug Info ===")
    self:Print(format("Current Expansion: %s", info.currentExpansion))
    self:Print(format("Global Modifications: %d", info.globalCount))
    self:Print(format("Version-Specific Modifications: %d", info.versionSpecificCount))
    self:Print(format("Total Modifications: %d", info.totalCount))
    self:Print(format("Has Version-Specific: %s", tostring(info.hasVersionSpecific)))

    if info.hasVersionSpecific and #info.versionSpecificKeys > 0 then
        self:Print("Version-Specific Keys: " .. concat(info.versionSpecificKeys, ", "))
    end
end
