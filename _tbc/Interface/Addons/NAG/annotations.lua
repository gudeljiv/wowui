--- @meta
--- Type definitions for NAG addon - Lua Language Server annotations
---
--- IMPORTANT: This file is ONLY for the Lua Language Server (IDE/editor support)
--- - DO NOT add this file to any .toc file
--- - DO NOT require() or load this file in WoW
--- - It is marked with @meta to indicate it's only for type checking
---
--- This file provides type information for:
--- - Ace3 library types (AceAddon, AceDB, AceEvent, etc.)
--- - NAG addon core types
--- - Common WoW API types
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

--- @class AceAddon
--- Base AceAddon class - all addons and modules created via AceAddon-3.0
--- @field NewAddon function Create a new addon
--- @field GetAddon function Get an existing addon
--- @field GetModule function Get a module from this addon
--- @field NewModule function Create a new module
--- @field CreateModule function Create a module (NAG custom)
--- @field IterateAddons function Iterate over all addons
--- @field IterateModules function Iterate over all modules
--- @field Enable function Enable the addon
--- @field Disable function Disable the addon
--- @field IsEnabled function Check if addon is enabled
--- @field SetDefaultModuleLibraries function Set default libraries for modules
--- @field SetDefaultModuleState function Set default state for modules
--- @field SetDefaultModulePrototype function Set default prototype for modules
--- @field OnInitialize function Lifecycle callback (override in addon)
--- @field OnEnable function Lifecycle callback (override in addon)
--- @field OnDisable function Lifecycle callback (override in addon)

--- @class NAG : AceAddon
--- The main NAG addon instance
--- @field x table Namespace table (ns)
--- @field Class table Current player's class module
--- @field Debug function Debug logging
--- @field Info function Info logging
--- @field Warn function Warning logging
--- @field Error function Error logging
--- @field Trace function Trace logging
--- @field Log function General logging
--- @field DebugLog function Debug-specific logging
--- @field ThrottledDebug function Throttled debug logging
--- @field ThrottledInfo function Throttled info logging
--- @field ThrottledWarn function Throttled warning logging
--- @field ThrottledError function Throttled error logging
--- @field ThrottledTrace function Throttled trace logging
--- @field CreateModule function Create a new NAG module with zero-boilerplate configuration
--- @field GetModule function Get an existing NAG module
--- @field IsDevModeEnabled function Check if development mode is enabled
--- @field db table Main database reference

--- @class AceDB-3.0
--- @field RegisterNamespace function Register a database namespace
--- @field GetNamespace function Get an existing namespace
--- @field ResetProfile function Reset current profile
--- @field ResetDB function Reset entire database
--- @field CopyProfile function Copy profile data
--- @field DeleteProfile function Delete a profile

--- @class AceConfigRegistry-3.0
--- @field RegisterOptionsTable function Register an options table
--- @field GetOptionsTable function Get a registered options table
--- @field IterateOptionsTables function Iterate over all options tables
--- @field NotifyChange function Notify that an options table has changed
--- @field ValidateOptionsTable function Validate an options table structure

--- @class AceConfigDialog-3.0
--- @field Open function Open an options dialog
--- @field Close function Close an options dialog
--- @field CloseAll function Close all open options dialogs
--- @field AddToBlizOptions function Add options to Blizzard interface options
--- @field SetDefaultSize function Set default size for options dialog
--- @field SelectGroup function Select a specific group in options

--- @class AceConfig-3.0
--- @field RegisterOptionsTable function Register options table with slash command

--- @class AceDBOptions-3.0
--- @field GetOptionsTable function Get options table for database configuration

--- @class AceLocale-3.0
--- @field GetLocale function Get current locale
--- @field RegisterLocale function Register locale data
--- @field Get function Get localized string
--- @field SetLocale function Set locale

--- @class AceEvent-3.0
--- @field RegisterEvent function Register for a WoW event
--- @field UnregisterEvent function Unregister from a WoW event
--- @field RegisterMessage function Register for addon messages
--- @field UnregisterMessage function Unregister from addon messages
--- @field UnregisterAllEvents function Unregister from all events
--- @field UnregisterAllMessages function Unregister from all messages
--- @field SendMessage function Send addon message

--- @class AceTimer-3.0
--- @field ScheduleTimer function Schedule a one-shot timer
--- @field ScheduleRepeatingTimer function Schedule a repeating timer
--- @field CancelTimer function Cancel a timer
--- @field CancelAllTimers function Cancel all timers
--- @field CancelCategoryTimers function Cancel timers by category
--- @field GetTimerTimeLeft function Get time remaining on a timer

--- @class AceConsole-3.0
--- @field RegisterChatCommand function Register a slash command
--- @field UnregisterChatCommand function Unregister a slash command
--- @field Print function Print to chat
--- @field PrintColored function Print colored text to chat

--- @class AceGUI-3.0
--- @field Create function Create a GUI widget
--- @field Release function Release a GUI widget
--- @field GetWidgetVersion function Get widget version
--- @field GetWidget function Get widget by type

--- @class AceGUI.Frame
--- AceGUI Frame widget type
--- @field SetTitle function Set frame title
--- @field SetLayout function Set frame layout
--- @field AddChild function Add child widget
--- @field ReleaseChildren function Release all child widgets
--- @field SetCallback function Set widget callback
--- @field Show function Show frame
--- @field Hide function Hide frame

--- @class AceHook-3.0
--- @field HookScript function Hook a frame script
--- @field UnhookScript function Unhook a frame script
--- @field Hook function Hook a function
--- @field Unhook function Unhook a function
--- @field SecureHook function Secure hook a function
--- @field UnhookAll function Unhook all hooks

--- @class AceSerializer-3.0
--- @field Serialize function Serialize data to string
--- @field Deserialize function Deserialize string to data
--- @field SerializeTable function Serialize table to string
--- @field DeserializeTable function Deserialize string to table

--- @class AceBucket-3.0
--- @field RegisterBucketEvent function Register event bucket
--- @field RegisterBucketMessage function Register message bucket
--- @field UnregisterBucket function Unregister a bucket
--- @field UnregisterAllBuckets function Unregister all buckets

--- @class AceTab-3.0
--- @field RegisterTabCompletion function Register tab completion
--- @field UnregisterTabCompletion function Unregister tab completion

--- ============================================================================
--- NAG-Specific Type Definitions
--- ============================================================================

--- @class AceModule
--- Base Ace3 module class - modules created via NAG:CreateModule()
--- @field Enable function Enable the module
--- @field Disable function Disable the module
--- @field IsEnabled function Check if module is enabled
--- @field GetName function Get module name
--- @field SetEnabledState function Set enabled state
--- @field RegisterEvent function Register for WoW event
--- @field UnregisterEvent function Unregister from WoW event
--- @field RegisterMessage function Register for addon message
--- @field UnregisterMessage function Unregister from addon message
--- @field SendMessage function Send addon message
--- @field OnInitialize function Lifecycle callback
--- @field OnEnable function Lifecycle callback
--- @field OnDisable function Lifecycle callback

--- @class ClassBase : CoreModule
--- Base class for class-specific modules
--- Note: CoreModule is defined in NAG/modules/Prototypes/CoreModule.lua
--- @field GetRotation fun(self: ClassBase, specID: number, rotationName: string): table|nil Get a specific rotation
--- @field GetAllRotations fun(self: ClassBase, specID: number): table Get all rotations for a spec
--- @field GetAvailableRotations fun(self: ClassBase, specID?: number, showAllSpecs?: boolean): table, table Get available rotations
--- @field GetCurrentRotation fun(self: ClassBase, specID?: number): table|nil, string|nil Get current active rotation
--- @field SaveRotation fun(self: ClassBase, specID: number, rotationName: string, config: table): boolean Save a rotation
--- @field DeleteRotation fun(self: ClassBase, specID: number, rotationName: string): boolean Delete a rotation
--- @field HasRotation fun(self: ClassBase, specID: number, rotationName: string): boolean Check if rotation exists
--- @field SelectRotation fun(self: ClassBase, specID: number, rotationName: string): boolean Select a rotation

--- @class DataManager : CoreModule
--- Manages data loading and caching for NAG
--- @field GetRotations function Get available rotations
--- @field GetRotation function Get specific rotation
--- @field GetSpellData function Get spell information
--- @field GetItemData function Get item information

--- @class StateManager : CoreModule
--- Manages game state tracking for NAG
--- @field IsInCombat function Check if player is in combat
--- @field GetCurrentSpec function Get player's current specialization
--- @field GetPlayerLevel function Get player level
--- @field GetTarget function Get current target information

--- @class Snapshotter : CoreModule
--- Handles combat log snapshotting for NAG

--- @class EnhancedAuraHandlers : CoreModule
--- Provides enhanced aura handling functionality

--- @class APLValidator : CoreModule
--- Validates APL (Action Priority List) syntax and structure

--- @class TableUtils
--- Utility functions for table manipulation
--- @field Keys function Get table keys
--- @field Size function Get table size
--- @field Merge function Merge tables
--- @field DeepCopy function Deep copy table

--- @class DebugFrameUtil
--- Utility for creating debug UI frames

--- @class DebugModule : CoreModule
--- Base class for debug-only modules

--- @class SpellLearnerStateManager : CoreModule
--- State manager for spell learning system

--- @class APLExecutor : CoreModule
--- Executes APL (Action Priority List) rotations

--- @class MigrationManager : CoreModule
--- Handles data migration between addon versions

--- @class Types : CoreModule
--- Defines type constants and type checking for NAG

--- @class OverlayManager : CoreModule
--- Manages overlay UI elements for NAG

--- @class SpellTrackingManager : CoreModule
--- Tracks spell cooldowns and availability

--- @class TooltipParser : CoreModule
--- Parses tooltip information for spells and items

--- @class RequirementsChecker : CoreModule
--- Checks if spell/ability requirements are met

--- @class TrinketTrackingManager : CoreModule
--- Tracks trinket cooldowns and usage

--- @class SpellbookManager : CoreModule
--- Manages spellbook data and spell positioning

--- @class TimerManager : CoreModule
--- Centralized timer management system

--- @class DisplayManager : CoreModule
--- Manages display frames and icon updates
--- @field ShouldShowDisplay function Check if display should be shown
--- @field IsGroupDisplayMode function Check if group display mode is enabled
--- @field IsLegacyFrameEnabled function Check if legacy frame is enabled
--- @field UpdateGroupIcons function Update icons for a specific group
--- @field UpdateIcons function Update icons for legacy display
--- @field UpdateSequenceGroupIcons function Update sequence group icons
--- @field PositionToGroup function Convert spell position to frame group
--- @field InitializeParentFrame function Initialize the parent frame

--- @class RotationManager : CoreModule
--- Manages rotation selection, storage, and lifecycle

--- @class APLEvaluationCache : CoreModule
--- Caches APL evaluation results for performance

--- @class Totem_Tracking
--- Totem tracking data structure

--- @class AceDBObject-3.0
--- AceDB database object
--- @field RegisterNamespace function Register a database namespace
--- @field ResetProfile function Reset current profile
--- @field SetProfile function Set active profile
--- @field GetProfiles function Get available profiles

--- ============================================================================
--- WoW API Type Definitions
--- ============================================================================

--- @class Frame
--- WoW UI Frame object
--- @field SetPoint function Set frame position
--- @field Show function Show frame
--- @field Hide function Hide frame
--- @field SetSize function Set frame size
--- @field SetParent function Set frame parent
--- @field CreateTexture function Create texture
--- @field CreateFontString function Create font string

--- @class ItemLocationMixin
--- WoW item location mixin
--- @field IsValid function Check if location is valid
--- @field HasAnyLocation function Check if has any location
--- @field GetBagAndSlot function Get bag and slot

--- @class Enum
--- WoW enums namespace

--- @class Enum.PowerType
--- WoW power type enum values

