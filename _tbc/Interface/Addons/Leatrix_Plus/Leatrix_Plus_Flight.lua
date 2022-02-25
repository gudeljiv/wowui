
	----------------------------------------------------------------------
	-- Leatrix Plus Flight
	----------------------------------------------------------------------

	local void, Leatrix_Plus = ...
	local L = Leatrix_Plus.L

	-- Function to load flight data (load-on-demand)
	function Leatrix_Plus:LoadFlightData()

		Leatrix_Plus["FlightData"] = {

			----------------------------------------------------------------------
			--	Horde
			----------------------------------------------------------------------

			["Horde"] = {

				-- Horde: Eastern Kingdoms
				[1415] = {

					-- Horde: Booty Bay (Stranglethorn Vale)
					["0.41:0.93:0.42:0.86"] = 75, -- Booty Bay, Grom'gol
					["0.41:0.93:0.54:0.79"] = 240, -- Booty Bay, Stonard
					["0.41:0.93:0.42:0.86:0.50:0.69"] = 273, -- Booty Bay, Grom'gol, Flame Crest
					["0.41:0.93:0.50:0.66"] = 315, -- Booty Bay, Kargath
					["0.41:0.93:0.42:0.86:0.50:0.69:0.46:0.65"] = 304, -- Booty Bay, Grom'gol, Flame Crest, Thorium Point
					["0.41:0.93:0.50:0.66:0.55:0.46:0.46:0.43:0.37:0.41"] = 789, -- Booty Bay, Kargath, Hammerfall, Tarren Mill, The Sepulcher
					["0.41:0.93:0.50:0.66:0.42:0.37"] = 811, -- Booty Bay, Kargath, Undercity
					["0.41:0.93:0.50:0.66:0.55:0.46:0.46:0.43"] = 692, -- Booty Bay, Kargath, Hammerfall, Tarren Mill
					["0.41:0.93:0.50:0.66:0.55:0.46"] = 576, -- Booty Bay, Kargath, Hammerfall
					["0.41:0.93:0.50:0.66:0.55:0.46:0.59:0.45"] = 665, -- Booty Bay, Kargath, Hammerfall, Revantusk Village
					["0.41:0.93:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35"] = 804, -- Booty Bay, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel
					["0.41:0.93:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.58:0.25"] = 920, -- Booty Bay, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Tranquillien
					["0.41:0.93:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.58:0.25:0.59:0.19"] = 986, -- Booty Bay, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Tranquillien, Silvermoon City

					-- Horde: Flame Crest (Burning Steppes)
					["0.50:0.69:0.42:0.86:0.41:0.93"] = 284, -- Flame Crest, Grom'gol, Booty Bay
					["0.50:0.69:0.42:0.86"] = 207, -- Flame Crest, Grom'gol
					["0.50:0.69:0.54:0.79"] = 192, -- Flame Crest, Stonard
					["0.50:0.69:0.50:0.66"] = 81, -- Flame Crest, Kargath
					["0.50:0.69:0.46:0.65"] = 62, -- Flame Crest, Thorium Point
					["0.50:0.69:0.50:0.66:0.55:0.46:0.46:0.43:0.37:0.41"] = 557, -- Flame Crest, Kargath, Hammerfall, Tarren Mill, The Sepulcher
					["0.50:0.69:0.50:0.66:0.42:0.37"] = 578, -- Flame Crest, Kargath, Undercity
					["0.50:0.69:0.50:0.66:0.55:0.46:0.46:0.43"] = 458, -- Flame Crest, Kargath, Hammerfall, Tarren Mill
					["0.50:0.69:0.50:0.66:0.55:0.46"] = 343, -- Flame Crest, Kargath, Hammerfall
					["0.50:0.69:0.50:0.66:0.55:0.46:0.59:0.45"] = 433, -- Flame Crest, Kargath, Hammerfall, Revantusk Village
					["0.50:0.69:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35"] = 571, -- Flame Crest, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel
					["0.50:0.69:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.58:0.25"] = 687, -- Flame Crest, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Tranquillien
					["0.50:0.69:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.58:0.25:0.59:0.19"] = 754, -- Flame Crest, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Tranquillien, Silvermoon City

					-- Horde: Grom'gol (Stranglethorn Vale)
					["0.42:0.86:0.41:0.93"] = 78, -- Grom'gol, Booty Bay
					["0.42:0.86:0.54:0.79"] = 173, -- Grom'gol, Stonard
					["0.42:0.86:0.50:0.69"] = 198, -- Grom'gol, Flame Crest
					["0.42:0.86:0.50:0.66"] = 246, -- Grom'gol, Kargath
					["0.42:0.86:0.50:0.69:0.46:0.65"] = 230, -- Grom'gol, Flame Crest, Thorium Point
					["0.42:0.86:0.50:0.66:0.55:0.46:0.46:0.43:0.37:0.41"] = 722, -- Grom'gol, Kargath, Hammerfall, Tarren Mill, The Sepulcher
					["0.42:0.86:0.50:0.66:0.42:0.37"] = 743, -- Grom'gol, Kargath, Undercity
					["0.42:0.86:0.50:0.66:0.55:0.46:0.46:0.43"] = 624, -- Grom'gol, Kargath, Hammerfall, Tarren Mill
					["0.42:0.86:0.50:0.66:0.55:0.46"] = 508, -- Grom'gol, Kargath, Hammerfall
					["0.42:0.86:0.50:0.66:0.55:0.46:0.59:0.45"] = 597, -- Grom'gol, Kargath, Hammerfall, Revantusk Village
					["0.42:0.86:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35"] = 736, -- Grom'gol, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel
					["0.42:0.86:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.58:0.25"] = 851, -- Grom'gol, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Tranquillien
					["0.42:0.86:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.58:0.25:0.59:0.19"] = 918, -- Grom'gol, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Tranquillien, Silvermoon City

					-- Horde: Hammerfall (Arathi Highlands)
					["0.55:0.46:0.50:0.66:0.41:0.93"] = 556, -- Hammerfall, Kargath, Booty Bay
					["0.55:0.46:0.50:0.66:0.42:0.86"] = 497, -- Hammerfall, Kargath, Grom'gol
					["0.55:0.46:0.50:0.66:0.54:0.79"] = 482, -- Hammerfall, Kargath, Stonard
					["0.55:0.46:0.50:0.66:0.50:0.69"] = 326, -- Hammerfall, Kargath, Flame Crest
					["0.55:0.46:0.50:0.66"] = 259, -- Hammerfall, Kargath
					["0.55:0.46:0.50:0.66:0.46:0.65"] = 315, -- Hammerfall, Kargath, Thorium Point
					["0.55:0.46:0.59:0.45"] = 91, -- Hammerfall, Revantusk Village
					["0.55:0.46:0.59:0.45:0.61:0.35"] = 229, -- Hammerfall, Revantusk Village, Light's Hope Chapel
					["0.55:0.46:0.59:0.45:0.61:0.35:0.58:0.25"] = 345, -- Hammerfall, Revantusk Village, Light's Hope Chapel, Tranquillien
					["0.55:0.46:0.59:0.45:0.61:0.35:0.58:0.25:0.59:0.19"] = 411, -- Hammerfall, Revantusk Village, Light's Hope Chapel, Tranquillien, Silvermoon City
					["0.55:0.46:0.42:0.37"] = 259, -- Hammerfall, Undercity
					["0.55:0.46:0.46:0.43"] = 117, -- Hammerfall, Tarren Mill
					["0.55:0.46:0.46:0.43:0.37:0.41"] = 215, -- Hammerfall, Tarren Mill, The Sepulcher

					-- Horde: Kargath (Badlands)
					["0.50:0.66:0.41:0.93"] = 298, -- Kargath, Booty Bay
					["0.50:0.66:0.42:0.86"] = 239, -- Kargath, Grom'gol
					["0.50:0.66:0.54:0.79"] = 225, -- Kargath, Stonard
					["0.50:0.66:0.50:0.69"] = 68, -- Kargath, Flame Crest
					["0.50:0.66:0.46:0.65"] = 56, -- Kargath, Thorium Point
					["0.50:0.66:0.55:0.46:0.46:0.43:0.37:0.41"] = 477, -- Kargath, Hammerfall, Tarren Mill, The Sepulcher
					["0.50:0.66:0.42:0.37"] = 498, -- Kargath, Undercity
					["0.50:0.66:0.55:0.46:0.46:0.43"] = 379, -- Kargath, Hammerfall, Tarren Mill
					["0.50:0.66:0.55:0.46"] = 263, -- Kargath, Hammerfall
					["0.50:0.66:0.55:0.46:0.59:0.45"] = 353, -- Kargath, Hammerfall, Revantusk Village
					["0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35"] = 490, -- Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel
					["0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.58:0.25"] = 606, -- Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Tranquillien
					["0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.58:0.25:0.59:0.19"] = 673, -- Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Tranquillien, Silvermoon City

					-- Horde: Light's Hope Chapel (Eastern Plaguelands)
					["0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.41:0.93"] = 789, -- Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Booty Bay
					["0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.42:0.86"] = 730, -- Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Grom'gol
					["0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.54:0.79"] = 716, -- Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Stonard
					["0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.50:0.69"] = 560, -- Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Flame Crest
					["0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66"] = 492, -- Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath
					["0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.46:0.65"] = 548, -- Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Thorium Point
					["0.61:0.35:0.59:0.45:0.55:0.46"] = 234, -- Light's Hope Chapel, Revantusk Village, Hammerfall
					["0.61:0.35:0.59:0.45"] = 141, -- Light's Hope Chapel, Revantusk Village
					["0.61:0.35:0.58:0.25"] = 118, -- Light's Hope Chapel, Tranquillien
					["0.61:0.35:0.58:0.25:0.59:0.19"] = 184, -- Light's Hope Chapel, Tranquillien, Silvermoon City
					["0.61:0.35:0.59:0.45:0.46:0.43"] = 301, -- Light's Hope Chapel, Revantusk Village, Tarren Mill
					["0.61:0.35:0.42:0.37"] = 262, -- Light's Hope Chapel, Undercity
					["0.61:0.35:0.42:0.37:0.37:0.41"] = 294, -- Light's Hope Chapel, Undercity, The Sepulcher
					["0.61:0.35:0.42:0.37:0.46:0.43"] = 326, -- Light's Hope Chapel, Undercity, Tarren Mill 

					-- Horde: Revantusk Village (The Hinterlands)
					["0.59:0.45:0.55:0.46:0.50:0.66:0.41:0.93"] = 648, -- Revantusk Village, Hammerfall, Kargath, Booty Bay
					["0.59:0.45:0.55:0.46:0.50:0.66:0.42:0.86"] = 589, -- Revantusk Village, Hammerfall, Kargath, Grom'gol
					["0.59:0.45:0.55:0.46:0.50:0.66:0.54:0.79"] = 575, -- Revantusk Village, Hammerfall, Kargath, Stonard
					["0.59:0.45:0.55:0.46:0.50:0.66:0.50:0.69"] = 419, -- Revantusk Village, Hammerfall, Kargath, Flame Crest
					["0.59:0.45:0.55:0.46:0.50:0.66"] = 351, -- Revantusk Village, Hammerfall, Kargath
					["0.59:0.45:0.55:0.46:0.50:0.66:0.46:0.65"] = 407, -- Revantusk Village, Hammerfall, Kargath, Thorium Point
					["0.59:0.45:0.46:0.43:0.37:0.41"] = 257, -- Revantusk Village, Tarren Mill, The Sepulcher
					["0.59:0.45:0.42:0.37"] = 284, -- Revantusk Village, Undercity
					["0.59:0.45:0.46:0.43"] = 159, -- Revantusk Village, Tarren Mill
					["0.59:0.45:0.55:0.46"] = 93, -- Revantusk Village, Hammerfall
					["0.59:0.45:0.61:0.35"] = 139, -- Revantusk Village, Light's Hope Chapel
					["0.59:0.45:0.61:0.35:0.58:0.25"] = 255, -- Revantusk Village, Light's Hope Chapel, Tranquillien
					["0.59:0.45:0.61:0.35:0.58:0.25:0.59:0.19"] = 322, -- Revantusk Village, Light's Hope Chapel, Tranquillien, Silvermoon City

					-- Horde: Silvermoon City (Eversong Woods)
					["0.59:0.19:0.58:0.25:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.41:0.93"] = 963, -- Silvermoon City, Tranquillien, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Booty Bay
					["0.59:0.19:0.58:0.25:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.42:0.86"] = 904, -- Silvermoon City, Tranquillien, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Grom'gol
					["0.59:0.19:0.58:0.25:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.54:0.79"] = 890, -- Silvermoon City, Tranquillien, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Stonard
					["0.59:0.19:0.58:0.25:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.50:0.69"] = 733, -- Silvermoon City, Tranquillien, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Flame Crest
					["0.59:0.19:0.58:0.25:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66"] = 667, -- Silvermoon City, Tranquillien, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath
					["0.59:0.19:0.58:0.25:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.46:0.65"] = 722, -- Silvermoon City, Tranquillien, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Thorium Point
					["0.59:0.19:0.58:0.25:0.61:0.35:0.59:0.45:0.55:0.46"] = 408, -- Silvermoon City, Tranquillien, Light's Hope Chapel, Revantusk Village, Hammerfall
					["0.59:0.19:0.58:0.25:0.61:0.35:0.59:0.45"] = 316, -- Silvermoon City, Tranquillien, Light's Hope Chapel, Revantusk Village
					["0.59:0.19:0.58:0.25:0.61:0.35"] = 179, -- Silvermoon City, Tranquillien, Light's Hope Chapel
					["0.59:0.19:0.58:0.25"] = 65, -- Silvermoon City, Tranquillien
					["0.59:0.19:0.58:0.25:0.61:0.35:0.59:0.45:0.46:0.43"] = 475, -- Silvermoon City, Tranquillien, Light's Hope Chapel, Revantusk Village, Tarren Mill
					["0.59:0.19:0.58:0.25:0.61:0.35:0.42:0.37"] = 437, -- Silvermoon City, Tranquillien, Light's Hope Chapel, Undercity
					["0.59:0.19:0.58:0.25:0.61:0.35:0.42:0.37:0.37:0.41"] = 469, -- Silvermoon City, Tranquillien, Light's Hope Chapel, Undercity, The Sepulcher

					-- Horde: Stonard (Swamp of Sorrows)
					["0.54:0.79:0.41:0.93"] = 230, -- Stonard, Booty Bay
					["0.54:0.79:0.42:0.86"] = 179, -- Stonard, Grom'gol
					["0.54:0.79:0.50:0.69"] = 176, -- Stonard, Flame Crest
					["0.54:0.79:0.50:0.66"] = 231, -- Stonard, Kargath
					["0.54:0.79:0.50:0.69:0.46:0.65"] = 208, -- Stonard, Flame Crest, Thorium Point
					["0.54:0.79:0.50:0.66:0.55:0.46:0.46:0.43:0.37:0.41"] = 707, -- Stonard, Kargath, Hammerfall, Tarren Mill, The Sepulcher
					["0.54:0.79:0.50:0.66:0.42:0.37"] = 728, -- Stonard, Kargath, Undercity
					["0.54:0.79:0.50:0.66:0.55:0.46:0.46:0.43"] = 608, -- Stonard, Kargath, Hammerfall, Tarren Mill
					["0.54:0.79:0.50:0.66:0.55:0.46"] = 493, -- Stonard, Kargath, Hammerfall
					["0.54:0.79:0.50:0.66:0.55:0.46:0.59:0.45"] = 582, -- Stonard, Kargath, Hammerfall, Revantusk Village
					["0.54:0.79:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35"] = 720, -- Stonard, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel
					["0.54:0.79:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.58:0.25"] = 836, -- Stonard, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Tranquillien
					["0.54:0.79:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.58:0.25:0.59:0.19"] = 903, -- Stonard, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Tranquillien, Silvermoon City

					-- Horde: Tarren Mill (Hillsbrad Foothills)
					["0.46:0.43:0.55:0.46:0.50:0.66:0.41:0.93"] = 673, -- Tarren Mill, Hammerfall, Kargath, Booty Bay
					["0.46:0.43:0.55:0.46:0.50:0.66:0.42:0.86"] = 614, -- Tarren Mill, Hammerfall, Kargath, Grom'gol
					["0.46:0.43:0.55:0.46:0.50:0.66:0.54:0.79"] = 600, -- Tarren Mill, Hammerfall, Kargath, Stonard
					["0.46:0.43:0.55:0.46:0.50:0.66:0.50:0.69"] = 443, -- Tarren Mill, Hammerfall, Kargath, Flame Crest
					["0.46:0.43:0.55:0.46:0.50:0.66"] = 377, -- Tarren Mill, Hammerfall, Kargath
					["0.46:0.43:0.55:0.46:0.50:0.66:0.46:0.65"] = 432, -- Tarren Mill, Hammerfall, Kargath, Thorium Point
					["0.46:0.43:0.55:0.46"] = 118, -- Tarren Mill, Hammerfall
					["0.46:0.43:0.59:0.45"] = 160, -- Tarren Mill, Revantusk Village
					["0.46:0.43:0.59:0.45:0.61:0.35"] = 329, -- Tarren Mill, Revantusk Village, Light's Hope Chapel
					["0.46:0.43:0.59:0.45:0.61:0.35:0.58:0.25"] = 415, -- Tarren Mill, Revantusk Village, Light's Hope Chapel, Tranquillien
					["0.46:0.43:0.59:0.45:0.61:0.35:0.58:0.25:0.59:0.19"] = 481, -- Tarren Mill, Revantusk Village, Light's Hope Chapel, Tranquillien, Silvermoon City
					["0.46:0.43:0.42:0.37"] = 139, -- Tarren Mill, Undercity
					["0.46:0.43:0.37:0.41"] = 99, -- Tarren Mill, The Sepulcher

					-- Horde: The Sepulcher (Silverpine Forest)
					["0.37:0.41:0.46:0.43:0.55:0.46:0.50:0.66:0.41:0.93"] = 767, -- The Sepulcher, Tarren Mill, Hammerfall, Kargath, Booty Bay
					["0.37:0.41:0.46:0.43:0.55:0.46:0.50:0.66:0.42:0.86"] = 708, -- The Sepulcher, Tarren Mill, Hammerfall, Kargath, Grom'gol
					["0.37:0.41:0.46:0.43:0.55:0.46:0.50:0.66:0.54:0.79"] = 695, -- The Sepulcher, Tarren Mill, Hammerfall, Kargath, Stonard
					["0.37:0.41:0.46:0.43:0.55:0.46:0.50:0.66:0.50:0.69"] = 538, -- The Sepulcher, Tarren Mill, Hammerfall, Kargath, Flame Crest
					["0.37:0.41:0.46:0.43:0.55:0.46:0.50:0.66"] = 471, -- The Sepulcher, Tarren Mill, Hammerfall, Kargath
					["0.37:0.41:0.46:0.43:0.55:0.46:0.50:0.66:0.46:0.65"] = 526, -- The Sepulcher, Tarren Mill, Hammerfall, Kargath, Thorium Point
					["0.37:0.41:0.46:0.43:0.55:0.46"] = 212, -- The Sepulcher, Tarren Mill, Hammerfall
					["0.37:0.41:0.46:0.43:0.59:0.45"] = 289, -- The Sepulcher, Tarren Mill, Revantusk Village
					["0.37:0.41:0.42:0.37:0.61:0.35"] = 299, -- The Sepulcher, Undercity, Light's Hope Chapel
					["0.37:0.41:0.42:0.37:0.61:0.35:0.58:0.25"] = 415, -- The Sepulcher, Undercity, Light's Hope Chapel, Tranquillien
					["0.37:0.41:0.42:0.37:0.61:0.35:0.58:0.25:0.59:0.19"] = 483, -- The Sepulcher, Undercity, Light's Hope Chapel, Tranquillien, Silvermoon City
					["0.37:0.41:0.42:0.37"] = 112, -- The Sepulcher, Undercity
					["0.37:0.41:0.46:0.43"] = 95, -- The Sepulcher, Tarren Mill

					-- Horde: Thorium Point (Searing Gorge)
					["0.46:0.65:0.50:0.69:0.42:0.86:0.41:0.93"] = 312, -- Thorium Point, Flame Crest, Grom'gol, Booty Bay
					["0.46:0.65:0.50:0.69:0.42:0.86"] = 234, -- Thorium Point, Flame Crest, Grom'gol
					["0.46:0.65:0.50:0.69:0.54:0.79"] = 218, -- Thorium Point, Flame Crest, Stonard
					["0.46:0.65:0.50:0.69"] = 61, -- Thorium Point, Flame Crest
					["0.46:0.65:0.50:0.66"] = 70, -- Thorium Point, Kargath
					["0.46:0.65:0.50:0.66:0.55:0.46:0.46:0.43:0.37:0.41"] = 545, -- Thorium Point, Kargath, Hammerfall, Tarren Mill, The Sepulcher
					["0.46:0.65:0.50:0.66:0.42:0.37"] = 566, -- Thorium Point, Kargath, Undercity
					["0.46:0.65:0.50:0.66:0.55:0.46:0.46:0.43"] = 446, -- Thorium Point, Kargath, Hammerfall, Tarren Mill
					["0.46:0.65:0.50:0.66:0.55:0.46"] = 332, -- Thorium Point, Kargath, Hammerfall
					["0.46:0.65:0.50:0.66:0.55:0.46:0.59:0.45"] = 420, -- Thorium Point, Kargath, Hammerfall, Revantusk Village
					["0.46:0.65:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35"] = 559, -- Thorium Point, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel
					["0.46:0.65:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.58:0.25"] = 674, -- Thorium Point, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Tranquillien
					["0.46:0.65:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.58:0.25:0.59:0.19"] = 741, -- Thorium Point, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Tranquillien, Silvermoon City

					-- Horde: Tranquillien (Ghostlands)
					["0.58:0.25:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.41:0.93"] = 900, -- Tranquillien, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Booty Bay
					["0.58:0.25:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.42:0.86"] = 841, -- Tranquillien, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Grom'gol
					["0.58:0.25:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.54:0.79"] = 827, -- Tranquillien, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Stonard
					["0.58:0.25:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.50:0.69"] = 671, -- Tranquillien, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Flame Crest
					["0.58:0.25:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66"] = 604, -- Tranquillien, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath
					["0.58:0.25:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.46:0.65"] = 659, -- Tranquillien, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Thorium Point
					["0.58:0.25:0.61:0.35:0.59:0.45:0.55:0.46"] = 345, -- Tranquillien, Light's Hope Chapel, Revantusk Village, Hammerfall
					["0.58:0.25:0.61:0.35:0.59:0.45"] = 253, -- Tranquillien, Light's Hope Chapel, Revantusk Village
					["0.58:0.25:0.61:0.35"] = 116, -- Tranquillien, Light's Hope Chapel
					["0.58:0.25:0.59:0.19"] = 74, -- Tranquillien, Silvermoon City
					["0.58:0.25:0.61:0.35:0.42:0.37"] = 373, -- Tranquillien, Light's Hope Chapel, Undercity
					["0.58:0.25:0.61:0.35:0.42:0.37:0.37:0.41"] = 406, -- Tranquillien, Light's Hope Chapel, Undercity, The Sepulcher
					["0.58:0.25:0.61:0.35:0.59:0.45:0.46:0.43"] = 412, -- Tranquillien, Light's Hope Chapel, Revantusk Village, Tarren Mill

					-- Horde: Undercity (Tirisfal Glades)
					["0.42:0.37:0.50:0.66:0.41:0.93"] = 785, -- Undercity, Kargath, Booty Bay
					["0.42:0.37:0.50:0.66:0.42:0.86"] = 725, -- Undercity, Kargath, Grom'gol
					["0.42:0.37:0.50:0.66:0.54:0.79"] = 712, -- Undercity, Kargath, Stonard
					["0.42:0.37:0.50:0.66:0.50:0.69"] = 555, -- Undercity, Kargath, Flame Crest
					["0.42:0.37:0.50:0.66"] = 489, -- Undercity, Kargath
					["0.42:0.37:0.50:0.66:0.46:0.65"] = 544, -- Undercity, Kargath, Thorium Point
					["0.42:0.37:0.37:0.41"] = 106, -- Undercity, The Sepulcher
					["0.42:0.37:0.46:0.43"] = 141, -- Undercity, Tarren Mill
					["0.42:0.37:0.55:0.46"] = 301, -- Undercity, Hammerfall
					["0.42:0.37:0.59:0.45"] = 284, -- Undercity, Revantusk Village
					["0.42:0.37:0.61:0.35"] = 261, -- Undercity, Light's Hope Chapel
					["0.42:0.37:0.61:0.35:0.58:0.25"] = 378, -- Undercity, Light's Hope Chapel, Tranquillien
					["0.42:0.37:0.61:0.35:0.58:0.25:0.59:0.19"] = 444, -- Undercity, Light's Hope Chapel, Tranquillien, Silvermoon City

					-- Horde: Zul'Aman

				},

				-- Horde: Kalimdor
				[1414] = {

					-- Horde: Bloodvenom Post (Felwood)
					["0.46:0.30:0.56:0.53:0.55:0.73:0.61:0.80"] = 518, -- Bloodvenom Post, Crossroads, Freewind Post, Gadgetzan
					["0.46:0.30:0.56:0.53:0.44:0.69:0.42:0.79"] = 623, -- Bloodvenom Post, Crossroads, Camp Mojache, Cenarion Hold
					["0.46:0.30:0.56:0.53:0.55:0.73:0.61:0.80:0.50:0.76"] = 619, -- Bloodvenom Post, Crossroads, Freewind Post, Gadgetzan, Marshal's Refuge
					["0.46:0.30:0.56:0.53:0.55:0.73"] = 426, -- Bloodvenom Post, Crossroads, Freewind Post
					["0.46:0.30:0.56:0.53:0.53:0.61:0.57:0.64:0.58:0.70"] = 434, -- Bloodvenom Post, Crossroads, Camp Taurajo, Brackenwall Village, Mudsprocket
					["0.46:0.30:0.56:0.53:0.53:0.61:0.57:0.64"] = 373, -- Bloodvenom Post, Crossroads, Camp Taurajo, Brackenwall Village
					["0.46:0.30:0.56:0.53:0.53:0.61"] = 315, -- Bloodvenom Post, Crossroads, Camp Taurajo
					["0.46:0.30:0.56:0.53:0.44:0.69"] = 493, -- Bloodvenom Post, Crossroads, Camp Mojache
					["0.46:0.30:0.41:0.37:0.41:0.47:0.32:0.58"] = 398, -- Bloodvenom Post, Zoram'gar Outpost, Sun Rock Retreat, Shadowprey Village
					["0.46:0.30:0.56:0.53:0.45:0.56"] = 347, -- Bloodvenom Post, Crossroads, Thunder Bluff
					["0.46:0.30:0.56:0.53"] = 241, -- Bloodvenom Post, Crossroads
					["0.46:0.30:0.56:0.53:0.61:0.55"] = 292, -- Bloodvenom Post, Crossroads, Ratchet
					["0.46:0.30:0.63:0.44"] = 259, -- Bloodvenom Post, Orgrimmar
					["0.46:0.30:0.50:0.35:0.55:0.42"] = 151, -- Bloodvenom Post, Emerald Sanctuary, Splintertree Post
					["0.46:0.30:0.41:0.37:0.41:0.47"] = 256, -- Bloodvenom Post, Zoram'gar Outpost, Sun Rock Retreat
					["0.46:0.30:0.41:0.37"] = 136, -- Bloodvenom Post, Zoram'gar Outpost
					["0.46:0.30:0.50:0.35"] = 69, -- Bloodvenom Post, Emerald Sanctuary
					["0.46:0.30:0.63:0.36"] = 234, -- Bloodvenom Post, Valormok
					["0.46:0.30:0.64:0.23"] = 190, -- Bloodvenom Post, Everlook
					["0.46:0.30:0.54:0.21"] = 166, -- Bloodvenom Post, Moonglade

					-- Horde: Brackenwall Village (Dustwallow Marsh)
					["0.57:0.64:0.61:0.80"] = 205, -- Brackenwall Village, Gadgetzan
					["0.57:0.64:0.55:0.73:0.44:0.69:0.42:0.79"] = 357, -- Brackenwall Village, Freewind Post, Camp Mojache, Cenarion Hold
					["0.57:0.64:0.55:0.73:0.61:0.80:0.50:0.76"] = 298, -- Brackenwall Village, Freewind Post, Gadgetzan, Marshal's Refuge
					["0.57:0.64:0.55:0.73"] = 105, -- Brackenwall Village, Freewind Post
					["0.57:0.64:0.58:0.70"] = 62, -- Brackenwall Village, Mudsprocket
					["0.57:0.64:0.55:0.73:0.44:0.69"] = 227, -- Brackenwall Village, Freewind Post, Camp Mojache
					["0.57:0.64:0.53:0.61"] = 49, -- Brackenwall Village, Camp Taurajo
					["0.57:0.64:0.45:0.56"] = 225, -- Brackenwall Village, Thunder Bluff
					["0.57:0.64:0.53:0.61:0.45:0.56:0.32:0.58"] = 321, -- Brackenwall Village, Camp Taurajo, Thunder Bluff, Shadowprey Village
					["0.57:0.64:0.53:0.61:0.56:0.53:0.41:0.47"] = 276, -- Brackenwall Village, Camp Taurajo, Crossroads, Sun Rock Retreat
					["0.57:0.64:0.56:0.53"] = 162, -- Brackenwall Village, Crossroads
					["0.57:0.64:0.61:0.55"] = 90, -- Brackenwall Village, Ratchet
					["0.57:0.64:0.63:0.44"] = 217, -- Brackenwall Village, Orgrimmar
					["0.57:0.64:0.61:0.55:0.63:0.44:0.55:0.42"] = 273, -- Brackenwall Village, Ratchet, Orgrimmar, Splintertree Post
					["0.57:0.64:0.61:0.55:0.63:0.44:0.63:0.36"] = 279, -- Brackenwall Village, Ratchet, Orgrimmar, Valormok
					["0.57:0.64:0.61:0.55:0.63:0.44:0.55:0.42:0.50:0.35"] = 351, -- Brackenwall Village, Ratchet, Orgrimmar, Splintertree Post, Emerald Sanctuary
					["0.57:0.64:0.53:0.61:0.56:0.53:0.41:0.37"] = 357, -- Brackenwall Village, Camp Taurajo, Crossroads, Zoram'gar Outpost
					["0.57:0.64:0.53:0.61:0.56:0.53:0.46:0.30"] = 380, -- Brackenwall Village, Camp Taurajo, Crossroads, Bloodvenom Post
					["0.57:0.64:0.53:0.61:0.56:0.53:0.46:0.30:0.54:0.21"] = 501, -- Brackenwall Village, Camp Taurajo, Crossroads, Bloodvenom Post, Moonglade
					["0.57:0.64:0.61:0.55:0.63:0.44:0.63:0.36:0.64:0.23"] = 408, -- Brackenwall Village, Ratchet, Orgrimmar, Valormok, Everlook

					-- Horde: Camp Mojache (The Barrens)
					["0.44:0.69:0.42:0.79"] = 130, -- Camp Mojache, Cenarion Hold
					["0.44:0.69:0.42:0.79:0.50:0.76"] = 222, -- Camp Mojache, Cenarion Hold, Marshal's Refuge
					["0.44:0.69:0.61:0.80"] = 201, -- Camp Mojache, Gadgetzan
					["0.44:0.69:0.55:0.73"] = 107, -- Camp Mojache, Freewind Post
					["0.44:0.69:0.55:0.73:0.58:0.70"] = 176, -- Camp Mojache, Freewind Post, Mudsprocket
					["0.44:0.69:0.55:0.73:0.57:0.64"] = 203, -- Camp Mojache, Freewind Post, Brackenwall Village
					["0.44:0.69:0.55:0.73:0.53:0.61"] = 245, -- Camp Mojache, Freewind Post, Camp Taurajo
					["0.44:0.69:0.55:0.73:0.57:0.64:0.61:0.55"] = 290, -- Camp Mojache, Freewind Post, Brackenwall Village, Ratchet
					["0.44:0.69:0.56:0.53"] = 265, -- Camp Mojache, Crossroads
					["0.44:0.69:0.45:0.56"] = 259, -- Camp Mojache, Thunder Bluff
					["0.44:0.69:0.32:0.58"] = 200, -- Camp Mojache, Shadowprey Village
					["0.44:0.69:0.32:0.58:0.41:0.47"] = 400, -- Camp Mojache, Shadowprey Village, Sun Rock Retreat
					["0.44:0.69:0.56:0.53:0.41:0.37"] = 495, -- Camp Mojache, Crossroads, Zoram'gar Outpost
					["0.44:0.69:0.56:0.53:0.55:0.42"] = 427, -- Camp Mojache, Crossroads, Splintertree Post
					["0.44:0.69:0.56:0.53:0.63:0.44"] = 381, -- Camp Mojache, Crossroads, Orgrimmar
					["0.44:0.69:0.56:0.53:0.63:0.36"] = 428, -- Camp Mojache, Crossroads, Valormok
					["0.44:0.69:0.56:0.53:0.55:0.42:0.50:0.35"] = 505, -- Camp Mojache, Crossroads, Splintertree Post, Emerald Sanctuary
					["0.44:0.69:0.56:0.53:0.46:0.30"] = 518, -- Camp Mojache, Crossroads, Bloodvenom Post
					["0.44:0.69:0.56:0.53:0.46:0.30:0.54:0.21"] = 639, -- Camp Mojache, Crossroads, Bloodvenom Post, Moonglade
					["0.44:0.69:0.56:0.53:0.63:0.36:0.64:0.23"] = 557, -- Camp Mojache, Crossroads, Valormok, Everlook

					-- Horde: Camp Taurajo (The Barrens)
					["0.53:0.61:0.55:0.73:0.61:0.80"] = 218, -- Camp Taurajo, Freewind Post, Gadgetzan
					["0.53:0.61:0.55:0.73:0.44:0.69:0.42:0.79"] = 378, -- Camp Taurajo, Freewind Post, Camp Mojache, Cenarion Hold
					["0.53:0.61:0.55:0.73:0.61:0.80:0.50:0.76"] = 319, -- Camp Taurajo, Freewind Post, Gadgetzan, Marshal's Refuge
					["0.53:0.61:0.55:0.73"] = 125, -- Camp Taurajo, Freewind Post
					["0.53:0.61:0.57:0.64:0.58:0.70"] = 121, -- Camp Taurajo, Brackenwall Village, Mudsprocket
					["0.53:0.61:0.57:0.64"] = 60, -- Camp Taurajo, Brackenwall Village
					["0.53:0.61:0.55:0.73:0.44:0.69"] = 248, -- Camp Taurajo, Freewind Post, Camp Mojache
					["0.53:0.61:0.45:0.56:0.32:0.58"] = 273, -- Camp Taurajo, Thunder Bluff, Shadowprey Village
					["0.53:0.61:0.45:0.56"] = 114, -- Camp Taurajo, Thunder Bluff
					["0.53:0.61:0.56:0.53"] = 79, -- Camp Taurajo, Crossroads
					["0.53:0.61:0.56:0.53:0.61:0.55"] = 130, -- Camp Taurajo, Crossroads, Ratchet
					["0.53:0.61:0.56:0.53:0.63:0.44"] = 195, -- Camp Taurajo, Crossroads, Orgrimmar
					["0.53:0.61:0.56:0.53:0.55:0.42"] = 241, -- Camp Taurajo, Crossroads, Splintertree Post
					["0.53:0.61:0.56:0.53:0.41:0.47"] = 228, -- Camp Taurajo, Crossroads, Sun Rock Retreat
					["0.53:0.61:0.56:0.53:0.41:0.37"] = 309, -- Camp Taurajo, Crossroads, Zoram'gar Outpost
					["0.53:0.61:0.56:0.53:0.55:0.42:0.50:0.35"] = 319, -- Camp Taurajo, Crossroads, Splintertree Post, Emerald Sanctuary
					["0.53:0.61:0.56:0.53:0.63:0.36"] = 242, -- Camp Taurajo, Crossroads, Valormok
					["0.53:0.61:0.56:0.53:0.46:0.30"] = 332, -- Camp Taurajo, Crossroads, Bloodvenom Post
					["0.53:0.61:0.56:0.53:0.46:0.30:0.54:0.21"] = 453, -- Camp Taurajo, Crossroads, Bloodvenom Post, Moonglade
					["0.53:0.61:0.56:0.53:0.63:0.36:0.64:0.23"] = 372, -- Camp Taurajo, Crossroads, Valormok, Everlook

					-- Horde: Cenarion Hold (Silithus)
					["0.42:0.79:0.61:0.80"] = 242, -- Cenarion Hold, Gadgetzan
					["0.42:0.79:0.50:0.76"] = 97, -- Cenarion Hold, Marshal's Refuge
					["0.42:0.79:0.44:0.69:0.55:0.73"] = 237, -- Cenarion Hold, Camp Mojache, Freewind Post
					["0.42:0.79:0.44:0.69:0.55:0.73:0.58:0.70"] = 306, -- Cenarion Hold, Camp Mojache, Freewind Post, Mudsprocket
					["0.42:0.79:0.44:0.69:0.55:0.73:0.57:0.64"] = 332, -- Cenarion Hold, Camp Mojache, Freewind Post, Brackenwall Village
					["0.42:0.79:0.44:0.69:0.55:0.73:0.53:0.61"] = 374, -- Cenarion Hold, Camp Mojache, Freewind Post, Camp Taurajo
					["0.42:0.79:0.44:0.69"] = 131, -- Cenarion Hold, Camp Mojache
					["0.42:0.79:0.44:0.69:0.32:0.58"] = 330, -- Cenarion Hold, Camp Mojache, Shadowprey Village
					["0.42:0.79:0.44:0.69:0.45:0.56"] = 390, -- Cenarion Hold, Camp Mojache, Thunder Bluff
					["0.42:0.79:0.44:0.69:0.56:0.53"] = 394, -- Cenarion Hold, Camp Mojache, Crossroads
					["0.42:0.79:0.44:0.69:0.55:0.73:0.57:0.64:0.61:0.55"] = 420, -- Cenarion Hold, Camp Mojache, Freewind Post, Brackenwall Village, Ratchet
					["0.42:0.79:0.44:0.69:0.56:0.53:0.63:0.44"] = 511, -- Cenarion Hold, Camp Mojache, Crossroads, Orgrimmar
					["0.42:0.79:0.44:0.69:0.56:0.53:0.55:0.42"] = 556, -- Cenarion Hold, Camp Mojache, Crossroads, Splintertree Post
					["0.42:0.79:0.44:0.69:0.32:0.58:0.41:0.47"] = 528, -- Cenarion Hold, Camp Mojache, Shadowprey Village, Sun Rock Retreat
					["0.42:0.79:0.44:0.69:0.56:0.53:0.41:0.37"] = 624, -- Cenarion Hold, Camp Mojache, Crossroads, Zoram'gar Outpost
					["0.42:0.79:0.44:0.69:0.56:0.53:0.55:0.42:0.50:0.35"] = 634, -- Cenarion Hold, Camp Mojache, Crossroads, Splintertree Post, Emerald Sanctuary
					["0.42:0.79:0.44:0.69:0.56:0.53:0.46:0.30"] = 647, -- Cenarion Hold, Camp Mojache, Crossroads, Bloodvenom Post
					["0.42:0.79:0.44:0.69:0.56:0.53:0.63:0.36"] = 557, -- Cenarion Hold, Camp Mojache, Crossroads, Valormok
					["0.42:0.79:0.44:0.69:0.56:0.53:0.63:0.36:0.64:0.23"] = 686, -- Cenarion Hold, Camp Mojache, Crossroads, Valormok, Everlook
					["0.42:0.79:0.44:0.69:0.56:0.53:0.46:0.30:0.54:0.21"] = 769, -- Cenarion Hold, Camp Mojache, Crossroads, Bloodvenom Post, Moonglade

					-- Horde: Crossroads (The Barrens)
					["0.56:0.53:0.44:0.69:0.42:0.79"] = 382, -- Crossroads, Camp Mojache, Cenarion Hold
					["0.56:0.53:0.55:0.73:0.61:0.80:0.50:0.76"] = 379, -- Crossroads, Freewind Post, Gadgetzan, Marshal's Refuge
					["0.56:0.53:0.61:0.80"] = 303, -- Crossroads, Gadgetzan
					["0.56:0.53:0.55:0.73"] = 184, -- Crossroads, Freewind Post
					["0.56:0.53:0.53:0.61:0.57:0.64:0.58:0.70"] = 193, -- Crossroads, Camp Taurajo, Brackenwall Village, Mudsprocket
					["0.56:0.53:0.57:0.64"] = 162, -- Crossroads, Brackenwall Village
					["0.56:0.53:0.53:0.61"] = 74, -- Crossroads, Camp Taurajo
					["0.56:0.53:0.44:0.69"] = 252, -- Crossroads, Camp Mojache
					["0.56:0.53:0.45:0.56:0.32:0.58"] = 266, -- Crossroads, Thunder Bluff, Shadowprey Village
					["0.56:0.53:0.45:0.56"] = 107, -- Crossroads, Thunder Bluff
					["0.56:0.53:0.41:0.47"] = 150, -- Crossroads, Sun Rock Retreat
					["0.56:0.53:0.55:0.42"] = 162, -- Crossroads, Splintertree Post
					["0.56:0.53:0.63:0.44"] = 117, -- Crossroads, Orgrimmar
					["0.56:0.53:0.61:0.55"] = 52, -- Crossroads, Ratchet
					["0.56:0.53:0.63:0.36"] = 164, -- Crossroads, Valormok
					["0.56:0.53:0.55:0.42:0.50:0.35"] = 241, -- Crossroads, Splintertree Post, Emerald Sanctuary
					["0.56:0.53:0.41:0.37"] = 230, -- Crossroads, Zoram'gar Outpost
					["0.56:0.53:0.46:0.30"] = 254, -- Crossroads, Bloodvenom Post
					["0.56:0.53:0.46:0.30:0.54:0.21"] = 375, -- Crossroads, Bloodvenom Post, Moonglade
					["0.56:0.53:0.63:0.36:0.64:0.23"] = 293, -- Crossroads, Valormok, Everlook

					-- Horde: Emerald Sanctuary (Felwood)
					["0.50:0.35:0.55:0.42:0.56:0.53:0.55:0.73:0.61:0.80"] = 514, -- Emerald Sanctuary, Splintertree Post, Crossroads, Freewind Post, Gadgetzan
					["0.50:0.35:0.55:0.42:0.56:0.53:0.44:0.69:0.42:0.79"] = 618, -- Emerald Sanctuary, Splintertree Post, Crossroads, Camp Mojache, Cenarion Hold
					["0.50:0.35:0.55:0.42:0.56:0.53:0.55:0.73:0.61:0.80:0.50:0.76"] = 615, -- Emerald Sanctuary, Splintertree Post, Crossroads, Freewind Post, Gadgetzan, Marshal's Refuge
					["0.50:0.35:0.55:0.42:0.56:0.53:0.55:0.73"] = 421, -- Emerald Sanctuary, Splintertree Post, Crossroads, Freewind Post
					["0.50:0.35:0.55:0.42:0.56:0.53:0.53:0.61:0.57:0.64:0.58:0.70"] = 430, -- Emerald Sanctuary, Splintertree Post, Crossroads, Camp Taurajo, Brackenwall Village, Mudsprocket
					["0.50:0.35:0.55:0.42:0.56:0.53:0.53:0.61:0.57:0.64"] = 368, -- Emerald Sanctuary, Splintertree Post, Crossroads, Camp Taurajo, Brackenwall Village
					["0.50:0.35:0.55:0.42:0.56:0.53:0.53:0.61"] = 310, -- Emerald Sanctuary, Splintertree Post, Crossroads, Camp Taurajo
					["0.50:0.35:0.55:0.42:0.56:0.53:0.44:0.69"] = 489, -- Emerald Sanctuary, Splintertree Post, Crossroads, Camp Mojache
					["0.50:0.35:0.41:0.37:0.41:0.47:0.32:0.58"] = 378, -- Emerald Sanctuary, Zoram'gar Outpost, Sun Rock Retreat, Shadowprey Village
					["0.50:0.35:0.55:0.42:0.56:0.53:0.45:0.56"] = 343, -- Emerald Sanctuary, Splintertree Post, Crossroads, Thunder Bluff
					["0.50:0.35:0.55:0.42:0.56:0.53"] = 237, -- Emerald Sanctuary, Splintertree Post, Crossroads
					["0.50:0.35:0.55:0.42:0.63:0.44:0.61:0.55"] = 280, -- Emerald Sanctuary, Splintertree Post, Orgrimmar, Ratchet
					["0.50:0.35:0.55:0.42:0.63:0.44"] = 173, -- Emerald Sanctuary, Splintertree Post, Orgrimmar
					["0.50:0.35:0.55:0.42"] = 84, -- Emerald Sanctuary, Splintertree Post
					["0.50:0.35:0.41:0.37:0.41:0.47"] = 235, -- Emerald Sanctuary, Zoram'gar Outpost, Sun Rock Retreat
					["0.50:0.35:0.41:0.37"] = 115, -- Emerald Sanctuary, Zoram'gar Outpost
					["0.50:0.35:0.46:0.30"] = 80, -- Emerald Sanctuary, Bloodvenom Post
					["0.50:0.35:0.55:0.42:0.63:0.36"] = 169, -- Emerald Sanctuary, Splintertree Post, Valormok
					["0.50:0.35:0.46:0.30:0.64:0.23"] = 226, -- Emerald Sanctuary, Bloodvenom Post, Everlook
					["0.50:0.35:0.46:0.30:0.54:0.21"] = 203, -- Emerald Sanctuary, Bloodvenom Post, Moonglade

					-- Horde: Everlook (Winterspring)
					["0.64:0.23:0.63:0.36:0.56:0.53:0.55:0.73:0.61:0.80"] = 575, -- Everlook, Valormok, Crossroads, Freewind Post, Gadgetzan
					["0.64:0.23:0.63:0.36:0.56:0.53:0.55:0.73"] = 483, -- Everlook, Valormok, Crossroads, Freewind Post
					["0.64:0.23:0.63:0.36:0.56:0.53:0.55:0.73:0.61:0.80:0.50:0.76"] = 676, -- Everlook, Valormok, Crossroads, Freewind Post, Gadgetzan, Marshal's Refuge
					["0.64:0.23:0.63:0.36:0.56:0.53:0.44:0.69:0.42:0.79"] = 680, -- Everlook, Valormok, Crossroads, Camp Mojache, Cenarion Hold
					["0.64:0.23:0.63:0.36:0.56:0.53:0.53:0.61:0.57:0.64:0.58:0.70"] = 491, -- Everlook, Valormok, Crossroads, Camp Taurajo, Brackenwall Village, Mudsprocket
					["0.64:0.23:0.63:0.36:0.56:0.53:0.53:0.61:0.57:0.64"] = 430, -- Everlook, Valormok, Crossroads, Camp Taurajo, Brackenwall Village
					["0.64:0.23:0.63:0.36:0.56:0.53:0.53:0.61"] = 371, -- Everlook, Valormok, Crossroads, Camp Taurajo
					["0.64:0.23:0.63:0.36:0.56:0.53:0.44:0.69"] = 550, -- Everlook, Valormok, Crossroads, Camp Mojache
					["0.64:0.23:0.63:0.36:0.45:0.56:0.32:0.58"] = 544, -- Everlook, Valormok, Thunder Bluff, Shadowprey Village
					["0.64:0.23:0.63:0.36:0.45:0.56"] = 385, -- Everlook, Valormok, Thunder Bluff
					["0.64:0.23:0.63:0.36:0.56:0.53"] = 299, -- Everlook, Valormok, Crossroads
					["0.64:0.23:0.63:0.36:0.63:0.44:0.61:0.55"] = 342, -- Everlook, Valormok, Orgrimmar, Ratchet
					["0.64:0.23:0.63:0.44"] = 243, -- Everlook, Orgrimmar
					["0.64:0.23:0.63:0.36:0.55:0.42"] = 228, -- Everlook, Valormok, Splintertree Post
					["0.64:0.23:0.63:0.36:0.56:0.53:0.41:0.47"] = 448, -- Everlook, Valormok, Crossroads, Sun Rock Retreat
					["0.64:0.23:0.46:0.30:0.41:0.37"] = 296, -- Everlook, Bloodvenom Post, Zoram'gar Outpost
					["0.64:0.23:0.46:0.30:0.50:0.35"] = 229, -- Everlook, Bloodvenom Post, Emerald Sanctuary
					["0.64:0.23:0.63:0.36"] = 135, -- Everlook, Valormok
					["0.64:0.23:0.46:0.30"] = 195, -- Everlook, Bloodvenom Post
					["0.64:0.23:0.54:0.21"] = 135, -- Everlook, Moonglade

					-- Horde: Freewind Post (Thousand Needles)
					["0.55:0.73:0.44:0.69:0.42:0.79"] = 252, -- Freewind Post, Camp Mojache, Cenarion Hold
					["0.55:0.73:0.61:0.80:0.50:0.76"] = 194, -- Freewind Post, Gadgetzan, Marshal's Refuge
					["0.55:0.73:0.61:0.80"] = 93, -- Freewind Post, Gadgetzan
					["0.55:0.73:0.58:0.70"] = 69, -- Freewind Post, Mudsprocket
					["0.55:0.73:0.57:0.64"] = 96, -- Freewind Post, Brackenwall Village
					["0.55:0.73:0.53:0.61"] = 137, -- Freewind Post, Camp Taurajo
					["0.55:0.73:0.44:0.69"] = 123, -- Freewind Post, Camp Mojache
					["0.55:0.73:0.44:0.69:0.32:0.58"] = 323, -- Freewind Post, Camp Mojache, Shadowprey Village
					["0.55:0.73:0.45:0.56"] = 223, -- Freewind Post, Thunder Bluff
					["0.55:0.73:0.56:0.53"] = 192, -- Freewind Post, Crossroads
					["0.55:0.73:0.57:0.64:0.61:0.55"] = 184, -- Freewind Post, Brackenwall Village, Ratchet
					["0.55:0.73:0.57:0.64:0.61:0.55:0.63:0.44"] = 279, -- Freewind Post, Brackenwall Village, Ratchet, Orgrimmar
					["0.55:0.73:0.56:0.53:0.55:0.42"] = 354, -- Freewind Post, Crossroads, Splintertree Post
					["0.55:0.73:0.56:0.53:0.41:0.47"] = 342, -- Freewind Post, Crossroads, Sun Rock Retreat
					["0.55:0.73:0.56:0.53:0.41:0.37"] = 422, -- Freewind Post, Crossroads, Zoram'gar Outpost
					["0.55:0.73:0.56:0.53:0.46:0.30"] = 445, -- Freewind Post, Crossroads, Bloodvenom Post
					["0.55:0.73:0.56:0.53:0.55:0.42:0.50:0.35"] = 432, -- Freewind Post, Crossroads, Splintertree Post, Emerald Sanctuary
					["0.55:0.73:0.56:0.53:0.63:0.36"] = 355, -- Freewind Post, Crossroads, Valormok
					["0.55:0.73:0.56:0.53:0.63:0.36:0.64:0.23"] = 484, -- Freewind Post, Crossroads, Valormok, Everlook
					["0.55:0.73:0.56:0.53:0.46:0.30:0.54:0.21"] = 566, -- Freewind Post, Crossroads, Bloodvenom Post, Moonglade
					["0.55:0.73:0.56:0.53:0.63:0.44"] = 308, -- Freewind Post, Crossroads, Orgrimmar
					["0.55:0.73:0.45:0.56:0.32:0.58"] = 382, -- Freewind Post, Thunder Bluff, Shadowprey Village

					-- Horde: Gadgetzan (Tanaris)
					["0.61:0.80:0.42:0.79"] = 233, -- Gadgetzan, Cenarion Hold
					["0.61:0.80:0.50:0.76"] = 108, -- Gadgetzan, Marshal's Refuge
					["0.61:0.80:0.55:0.73"] = 87, -- Gadgetzan, Freewind Post
					["0.61:0.80:0.55:0.73:0.58:0.70"] = 155, -- Gadgetzan, Freewind Post, Mudsprocket
					["0.61:0.80:0.57:0.64"] = 194, -- Gadgetzan, Brackenwall Village
					["0.61:0.80:0.55:0.73:0.53:0.61"] = 223, -- Gadgetzan, Freewind Post, Camp Taurajo
					["0.61:0.80:0.44:0.69"] = 199, -- Gadgetzan, Camp Mojache
					["0.61:0.80:0.44:0.69:0.32:0.58"] = 399, -- Gadgetzan, Camp Mojache, Shadowprey Village
					["0.61:0.80:0.45:0.56"] = 304, -- Gadgetzan, Thunder Bluff
					["0.61:0.80:0.56:0.53"] = 300, -- Gadgetzan, Crossroads
					["0.61:0.80:0.61:0.55"] = 243, -- Gadgetzan, Ratchet
					["0.61:0.80:0.63:0.44"] = 350, -- Gadgetzan, Orgrimmar
					["0.61:0.80:0.61:0.55:0.63:0.44:0.55:0.42"] = 429, -- Gadgetzan, Ratchet, Orgrimmar, Splintertree Post
					["0.61:0.80:0.55:0.73:0.56:0.53:0.41:0.47"] = 427, -- Gadgetzan, Freewind Post, Crossroads, Sun Rock Retreat
					["0.61:0.80:0.55:0.73:0.56:0.53:0.41:0.37"] = 508, -- Gadgetzan, Freewind Post, Crossroads, Zoram'gar Outpost
					["0.61:0.80:0.61:0.55:0.63:0.44:0.55:0.42:0.50:0.35"] = 507, -- Gadgetzan, Ratchet, Orgrimmar, Splintertree Post, Emerald Sanctuary
					["0.61:0.80:0.55:0.73:0.56:0.53:0.46:0.30"] = 531, -- Gadgetzan, Freewind Post, Crossroads, Bloodvenom Post
					["0.61:0.80:0.61:0.55:0.63:0.44:0.63:0.36"] = 434, -- Gadgetzan, Ratchet, Orgrimmar, Valormok
					["0.61:0.80:0.61:0.55:0.63:0.44:0.63:0.36:0.64:0.23"] = 564, -- Gadgetzan, Ratchet, Orgrimmar, Valormok, Everlook
					["0.61:0.80:0.55:0.73:0.56:0.53:0.46:0.30:0.54:0.21"] = 652, -- Gadgetzan, Freewind Post, Crossroads, Bloodvenom Post, Moonglade

					-- Horde: Marshal's Refuge (Un'Goro Crater)
					["0.50:0.76:0.42:0.79"] = 100, -- Marshal's Refuge, Cenarion Hold
					["0.50:0.76:0.61:0.80"] = 113, -- Marshal's Refuge, Gadgetzan
					["0.50:0.76:0.61:0.80:0.55:0.73"] = 200, -- Marshal's Refuge, Gadgetzan, Freewind Post
					["0.50:0.76:0.61:0.80:0.55:0.73:0.58:0.70"] = 268, -- Marshal's Refuge, Gadgetzan, Freewind Post, Mudsprocket
					["0.50:0.76:0.61:0.80:0.55:0.73:0.57:0.64"] = 294, -- Marshal's Refuge, Gadgetzan, Freewind Post, Brackenwall Village
					["0.50:0.76:0.61:0.80:0.55:0.73:0.53:0.61"] = 336, -- Marshal's Refuge, Gadgetzan, Freewind Post, Camp Taurajo
					["0.50:0.76:0.42:0.79:0.44:0.69"] = 224, -- Marshal's Refuge, Cenarion Hold, Camp Mojache
					["0.50:0.76:0.42:0.79:0.44:0.69:0.32:0.58"] = 424, -- Marshal's Refuge, Cenarion Hold, Camp Mojache, Shadowprey Village
					["0.50:0.76:0.61:0.80:0.45:0.56"] = 416, -- Marshal's Refuge, Gadgetzan, Thunder Bluff
					["0.50:0.76:0.61:0.80:0.55:0.73:0.56:0.53"] = 392, -- Marshal's Refuge, Gadgetzan, Freewind Post, Crossroads
					["0.50:0.76:0.61:0.80:0.61:0.55"] = 354, -- Marshal's Refuge, Gadgetzan, Ratchet
					["0.50:0.76:0.61:0.80:0.61:0.55:0.63:0.44"] = 450, -- Marshal's Refuge, Gadgetzan, Ratchet, Orgrimmar
					["0.50:0.76:0.61:0.80:0.61:0.55:0.63:0.44:0.55:0.42"] = 540, -- Marshal's Refuge, Gadgetzan, Ratchet, Orgrimmar, Splintertree Post
					["0.50:0.76:0.61:0.80:0.55:0.73:0.56:0.53:0.41:0.47"] = 540, -- Marshal's Refuge, Gadgetzan, Freewind Post, Crossroads, Sun Rock Retreat
					["0.50:0.76:0.61:0.80:0.55:0.73:0.56:0.53:0.41:0.37"] = 621, -- Marshal's Refuge, Gadgetzan, Freewind Post, Crossroads, Zoram'gar Outpost
					["0.50:0.76:0.61:0.80:0.61:0.55:0.63:0.44:0.55:0.42:0.50:0.35"] = 618, -- Marshal's Refuge, Gadgetzan, Ratchet, Orgrimmar, Splintertree Post, Emerald Sanctuary
					["0.50:0.76:0.61:0.80:0.55:0.73:0.56:0.53:0.46:0.30"] = 645, -- Marshal's Refuge, Gadgetzan, Freewind Post, Crossroads, Bloodvenom Post
					["0.50:0.76:0.61:0.80:0.61:0.55:0.63:0.44:0.63:0.36"] = 546, -- Marshal's Refuge, Gadgetzan, Ratchet, Orgrimmar, Valormok
					["0.50:0.76:0.61:0.80:0.61:0.55:0.63:0.44:0.63:0.36:0.64:0.23"] = 675, -- Marshal's Refuge, Gadgetzan, Ratchet, Orgrimmar, Valormok, Everlook
					["0.50:0.76:0.61:0.80:0.55:0.73:0.56:0.53:0.46:0.30:0.54:0.21"] = 766, -- Marshal's Refuge, Gadgetzan, Freewind Post, Crossroads, Bloodvenom Post, Moonglade

					-- Horde: Moonglade (Moonglade)
					["0.54:0.21:0.46:0.30:0.56:0.53:0.44:0.69:0.42:0.79"] = 734, -- Moonglade, Bloodvenom Post, Crossroads, Camp Mojache, Cenarion Hold
					["0.54:0.21:0.46:0.30:0.56:0.53:0.55:0.73:0.61:0.80:0.50:0.76"] = 730, -- Moonglade, Bloodvenom Post, Crossroads, Freewind Post, Gadgetzan, Marshal's Refuge
					["0.54:0.21:0.46:0.30:0.56:0.53:0.55:0.73"] = 537, -- Moonglade, Bloodvenom Post, Crossroads, Freewind Post
					["0.54:0.21:0.46:0.30:0.56:0.53:0.53:0.61:0.57:0.64:0.58:0.70"] = 545, -- Moonglade, Bloodvenom Post, Crossroads, Camp Taurajo, Brackenwall Village, Mudsprocket
					["0.54:0.21:0.46:0.30:0.56:0.53:0.55:0.73:0.61:0.80"] = 629, -- Moonglade, Bloodvenom Post, Crossroads, Freewind Post, Gadgetzan
					["0.54:0.21:0.46:0.30:0.56:0.53:0.53:0.61:0.57:0.64"] = 484, -- Moonglade, Bloodvenom Post, Crossroads, Camp Taurajo, Brackenwall Village
					["0.54:0.21:0.46:0.30:0.56:0.53:0.53:0.61"] = 426, -- Moonglade, Bloodvenom Post, Crossroads, Camp Taurajo
					["0.54:0.21:0.46:0.30:0.56:0.53:0.44:0.69"] = 604, -- Moonglade, Bloodvenom Post, Crossroads, Camp Mojache
					["0.54:0.21:0.46:0.30:0.41:0.37:0.41:0.47:0.32:0.58"] = 515, -- Moonglade, Bloodvenom Post, Zoram'gar Outpost, Sun Rock Retreat, Shadowprey Village
					["0.54:0.21:0.46:0.30:0.56:0.53:0.45:0.56"] = 459, -- Moonglade, Bloodvenom Post, Crossroads, Thunder Bluff
					["0.54:0.21:0.46:0.30:0.56:0.53"] = 353, -- Moonglade, Bloodvenom Post, Crossroads
					["0.54:0.21:0.46:0.30:0.56:0.53:0.61:0.55"] = 404, -- Moonglade, Bloodvenom Post, Crossroads, Ratchet
					["0.54:0.21:0.64:0.23:0.63:0.36:0.63:0.44"] = 377, -- Moonglade, Everlook, Valormok, Orgrimmar
					["0.54:0.21:0.46:0.30:0.50:0.35:0.55:0.42"] = 269, -- Moonglade, Bloodvenom Post, Emerald Sanctuary, Splintertree Post
					["0.54:0.21:0.46:0.30:0.41:0.37:0.41:0.47"] = 373, -- Moonglade, Bloodvenom Post, Zoram'gar Outpost, Sun Rock Retreat
					["0.54:0.21:0.46:0.30:0.41:0.37"] = 253, -- Moonglade, Bloodvenom Post, Zoram'gar Outpost
					["0.54:0.21:0.46:0.30:0.50:0.35"] = 186, -- Moonglade, Bloodvenom Post, Emerald Sanctuary
					["0.54:0.21:0.64:0.23:0.63:0.36"] = 276, -- Moonglade, Everlook, Valormok
					["0.54:0.21:0.64:0.23"] = 142, -- Moonglade, Everlook
					["0.54:0.21:0.46:0.30"] = 157, -- Moonglade, Bloodvenom Post

					-- Horde: Mudsprocket (Dustwallow Marsh)
					["0.58:0.70:0.55:0.73:0.44:0.69:0.42:0.79"] = 324, -- Mudsprocket, Freewind Post, Camp Mojache, Cenarion Hold
					["0.58:0.70:0.55:0.73:0.61:0.80:0.50:0.76"] = 265, -- Mudsprocket, Freewind Post, Gadgetzan, Marshal's Refuge
					["0.58:0.70:0.55:0.73"] = 71, -- Mudsprocket, Freewind Post
					["0.58:0.70:0.55:0.73:0.61:0.80"] = 164, -- Mudsprocket, Freewind Post, Gadgetzan
					["0.58:0.70:0.55:0.73:0.44:0.69"] = 194, -- Mudsprocket, Freewind Post, Camp Mojache
					["0.58:0.70:0.57:0.64"] = 63, -- Mudsprocket, Brackenwall Village
					["0.58:0.70:0.57:0.64:0.53:0.61"] = 111, -- Mudsprocket, Brackenwall Village, Camp Taurajo
					["0.58:0.70:0.57:0.64:0.53:0.61:0.45:0.56:0.32:0.58"] = 383, -- Mudsprocket, Brackenwall Village, Camp Taurajo, Thunder Bluff, Shadowprey Village
					["0.58:0.70:0.57:0.64:0.53:0.61:0.45:0.56"] = 224, -- Mudsprocket, Brackenwall Village, Camp Taurajo, Thunder Bluff
					["0.58:0.70:0.57:0.64:0.53:0.61:0.56:0.53"] = 189, -- Mudsprocket, Brackenwall Village, Camp Taurajo, Crossroads
					["0.58:0.70:0.57:0.64:0.61:0.55"] = 150, -- Mudsprocket, Brackenwall Village, Ratchet
					["0.58:0.70:0.57:0.64:0.61:0.55:0.63:0.44"] = 245, -- Mudsprocket, Brackenwall Village, Ratchet, Orgrimmar
					["0.58:0.70:0.57:0.64:0.61:0.55:0.63:0.44:0.55:0.42"] = 334, -- Mudsprocket, Brackenwall Village, Ratchet, Orgrimmar, Splintertree Post
					["0.58:0.70:0.57:0.64:0.53:0.61:0.56:0.53:0.41:0.47"] = 338, -- Mudsprocket, Brackenwall Village, Camp Taurajo, Crossroads, Sun Rock Retreat
					["0.58:0.70:0.57:0.64:0.53:0.61:0.56:0.53:0.41:0.37"] = 419, -- Mudsprocket, Brackenwall Village, Camp Taurajo, Crossroads, Zoram'gar Outpost
					["0.58:0.70:0.57:0.64:0.61:0.55:0.63:0.44:0.55:0.42:0.50:0.35"] = 412, -- Mudsprocket, Brackenwall Village, Ratchet, Orgrimmar, Splintertree Post, Emerald Sanctuary
					["0.58:0.70:0.57:0.64:0.61:0.55:0.63:0.44:0.63:0.36"] = 340, -- Mudsprocket, Brackenwall Village, Ratchet, Orgrimmar, Valormok
					["0.58:0.70:0.57:0.64:0.53:0.61:0.56:0.53:0.46:0.30"] = 442, -- Mudsprocket, Brackenwall Village, Camp Taurajo, Crossroads, Bloodvenom Post
					["0.58:0.70:0.57:0.64:0.53:0.61:0.56:0.53:0.46:0.30:0.54:0.21"] = 563, -- Mudsprocket, Brackenwall Village, Camp Taurajo, Crossroads, Bloodvenom Post, Moonglade
					["0.58:0.70:0.57:0.64:0.61:0.55:0.63:0.44:0.63:0.36:0.64:0.23"] = 469, -- Mudsprocket, Brackenwall Village, Ratchet, Orgrimmar, Valormok, Everlook

					-- Horde: Orgrimmar (Durotar)
					["0.63:0.44:0.61:0.80"] = 417, -- Orgrimmar, Gadgetzan
					["0.63:0.44:0.56:0.53:0.44:0.69:0.42:0.79"] = 492, -- Orgrimmar, Crossroads, Camp Mojache, Cenarion Hold
					["0.63:0.44:0.61:0.55:0.61:0.80:0.50:0.76"] = 454, -- Orgrimmar, Ratchet, Gadgetzan, Marshal's Refuge
					["0.63:0.44:0.56:0.53:0.55:0.73"] = 292, -- Orgrimmar, Crossroads, Freewind Post
					["0.63:0.44:0.61:0.55:0.57:0.64:0.58:0.70"] = 268, -- Orgrimmar, Ratchet, Brackenwall Village, Mudsprocket
					["0.63:0.44:0.57:0.64"] = 229, -- Orgrimmar, Brackenwall Village
					["0.63:0.44:0.56:0.53:0.53:0.61"] = 181, -- Orgrimmar, Crossroads, Camp Taurajo
					["0.63:0.44:0.56:0.53:0.44:0.69"] = 361, -- Orgrimmar, Crossroads, Camp Mojache
					["0.63:0.44:0.56:0.53:0.45:0.56:0.32:0.58"] = 373, -- Orgrimmar, Crossroads, Thunder Bluff, Shadowprey Village
					["0.63:0.44:0.45:0.56"] = 224, -- Orgrimmar, Thunder Bluff
					["0.63:0.44:0.56:0.53"] = 110, -- Orgrimmar, Crossroads
					["0.63:0.44:0.61:0.55"] = 108, -- Orgrimmar, Ratchet
					["0.63:0.44:0.63:0.36"] = 95, -- Orgrimmar, Valormok
					["0.63:0.44:0.55:0.42"] = 90, -- Orgrimmar, Splintertree Post
					["0.63:0.44:0.56:0.53:0.41:0.47"] = 258, -- Orgrimmar, Crossroads, Sun Rock Retreat
					["0.63:0.44:0.55:0.42:0.41:0.37"] = 249, -- Orgrimmar, Splintertree Post, Zoram'gar Outpost
					["0.63:0.44:0.55:0.42:0.50:0.35"] = 168, -- Orgrimmar, Splintertree Post, Emerald Sanctuary
					["0.63:0.44:0.46:0.30"] = 252, -- Orgrimmar, Bloodvenom Post
					["0.63:0.44:0.63:0.36:0.64:0.23:0.54:0.21"] = 358, -- Orgrimmar, Valormok, Everlook, Moonglade
					["0.63:0.44:0.64:0.23"] = 240, -- Orgrimmar, Everlook
					["0.63:0.44:0.55:0.42:0.50:0.35:0.46:0.30:0.54:0.21"] = 371, -- Orgrimmar, Splintertree Post, Emerald Sanctuary, Bloodvenom Post, Moonglade
					["0.63:0.44:0.56:0.53:0.41:0.37"] = 339, -- Orgrimmar, Crossroads, Zoram'gar Outpost

					-- Horde: Ratchet (The Barrens)
					["0.61:0.55:0.61:0.80:0.50:0.76:0.42:0.79"] = 443, -- Ratchet, Gadgetzan, Marshal's Refuge, Cenarion Hold
					["0.61:0.55:0.61:0.80:0.50:0.76"] = 347, -- Ratchet, Gadgetzan, Marshal's Refuge
					["0.61:0.55:0.57:0.64:0.55:0.73"] = 204, -- Ratchet, Brackenwall Village, Freewind Post
					["0.61:0.55:0.61:0.80"] = 241, -- Ratchet, Gadgetzan
					["0.61:0.55:0.56:0.53:0.44:0.69"] = 320, -- Ratchet, Crossroads, Camp Mojache
					["0.61:0.55:0.57:0.64:0.58:0.70"] = 161, -- Ratchet, Brackenwall Village, Mudsprocket
					["0.61:0.55:0.57:0.64"] = 101, -- Ratchet, Brackenwall Village
					["0.61:0.55:0.56:0.53:0.53:0.61"] = 141, -- Ratchet, Crossroads, Camp Taurajo
					["0.61:0.55:0.56:0.53:0.45:0.56:0.32:0.58"] = 334, -- Ratchet, Crossroads, Thunder Bluff, Shadowprey Village
					["0.61:0.55:0.56:0.53:0.45:0.56"] = 175, -- Ratchet, Crossroads, Thunder Bluff
					["0.61:0.55:0.56:0.53"] = 69, -- Ratchet, Crossroads
					["0.61:0.55:0.56:0.53:0.41:0.47"] = 218, -- Ratchet, Crossroads, Sun Rock Retreat
					["0.61:0.55:0.63:0.44:0.55:0.42"] = 190, -- Ratchet, Orgrimmar, Splintertree Post
					["0.61:0.55:0.63:0.44"] = 101, -- Ratchet, Orgrimmar
					["0.61:0.55:0.63:0.44:0.63:0.36"] = 196, -- Ratchet, Orgrimmar, Valormok
					["0.61:0.55:0.63:0.44:0.55:0.42:0.50:0.35"] = 269, -- Ratchet, Orgrimmar, Splintertree Post, Emerald Sanctuary
					["0.61:0.55:0.56:0.53:0.41:0.37"] = 299, -- Ratchet, Crossroads, Zoram'gar Outpost
					["0.61:0.55:0.56:0.53:0.46:0.30"] = 321, -- Ratchet, Crossroads, Bloodvenom Post
					["0.61:0.55:0.63:0.44:0.63:0.36:0.64:0.23:0.54:0.21"] = 458, -- Ratchet, Orgrimmar, Valormok, Everlook, Moonglade
					["0.61:0.55:0.63:0.44:0.63:0.36:0.64:0.23"] = 325, -- Ratchet, Orgrimmar, Valormok, Everlook

					-- Horde: Shadowprey Village (Desolace)
					["0.32:0.58:0.44:0.69:0.42:0.79"] = 326, -- Shadowprey Village, Camp Mojache, Cenarion Hold
					["0.32:0.58:0.44:0.69:0.42:0.79:0.50:0.76"] = 417, -- Shadowprey Village, Camp Mojache, Cenarion Hold, Marshal's Refuge
					["0.32:0.58:0.44:0.69:0.55:0.73:0.61:0.80"] = 395, -- Shadowprey Village, Camp Mojache, Freewind Post, Gadgetzan
					["0.32:0.58:0.44:0.69:0.55:0.73"] = 303, -- Shadowprey Village, Camp Mojache, Freewind Post
					["0.32:0.58:0.44:0.69"] = 196, -- Shadowprey Village, Camp Mojache
					["0.32:0.58:0.44:0.69:0.55:0.73:0.58:0.70"] = 372, -- Shadowprey Village, Camp Mojache, Freewind Post, Mudsprocket
					["0.32:0.58:0.45:0.56:0.53:0.61:0.57:0.64"] = 323, -- Shadowprey Village, Thunder Bluff, Camp Taurajo, Brackenwall Village
					["0.32:0.58:0.45:0.56:0.53:0.61"] = 265, -- Shadowprey Village, Thunder Bluff, Camp Taurajo
					["0.32:0.58:0.45:0.56:0.56:0.53:0.61:0.55"] = 332, -- Shadowprey Village, Thunder Bluff, Crossroads, Ratchet
					["0.32:0.58:0.45:0.56:0.56:0.53"] = 281, -- Shadowprey Village, Thunder Bluff, Crossroads
					["0.32:0.58:0.45:0.56"] = 178, -- Shadowprey Village, Thunder Bluff
					["0.32:0.58:0.41:0.47"] = 199, -- Shadowprey Village, Sun Rock Retreat
					["0.32:0.58:0.45:0.56:0.56:0.53:0.55:0.42"] = 443, -- Shadowprey Village, Thunder Bluff, Crossroads, Splintertree Post
					["0.32:0.58:0.45:0.56:0.63:0.44"] = 386, -- Shadowprey Village, Thunder Bluff, Orgrimmar
					["0.32:0.58:0.45:0.56:0.63:0.36"] = 429, -- Shadowprey Village, Thunder Bluff, Valormok
					["0.32:0.58:0.41:0.47:0.41:0.37:0.50:0.35"] = 441, -- Shadowprey Village, Sun Rock Retreat, Zoram'gar Outpost, Emerald Sanctuary
					["0.32:0.58:0.41:0.47:0.41:0.37"] = 320, -- Shadowprey Village, Sun Rock Retreat, Zoram'gar Outpost
					["0.32:0.58:0.41:0.47:0.41:0.37:0.46:0.30"] = 457, -- Shadowprey Village, Sun Rock Retreat, Zoram'gar Outpost, Bloodvenom Post
					["0.32:0.58:0.41:0.47:0.41:0.37:0.46:0.30:0.54:0.21"] = 581, -- Shadowprey Village, Sun Rock Retreat, Zoram'gar Outpost, Bloodvenom Post, Moonglade
					["0.32:0.58:0.45:0.56:0.63:0.36:0.64:0.23"] = 558, -- Shadowprey Village, Thunder Bluff, Valormok, Everlook

					-- Horde: Splintertree Post (Ashenvale)
					["0.55:0.42:0.56:0.53:0.44:0.69:0.42:0.79"] = 541, -- Splintertree Post, Crossroads, Camp Mojache, Cenarion Hold
					["0.55:0.42:0.56:0.53:0.55:0.73:0.61:0.80:0.50:0.76"] = 538, -- Splintertree Post, Crossroads, Freewind Post, Gadgetzan, Marshal's Refuge
					["0.55:0.42:0.56:0.53:0.55:0.73"] = 345, -- Splintertree Post, Crossroads, Freewind Post
					["0.55:0.42:0.56:0.53:0.53:0.61:0.57:0.64:0.58:0.70"] = 354, -- Splintertree Post, Crossroads, Camp Taurajo, Brackenwall Village, Mudsprocket
					["0.55:0.42:0.56:0.53:0.55:0.73:0.61:0.80"] = 436, -- Splintertree Post, Crossroads, Freewind Post, Gadgetzan
					["0.55:0.42:0.56:0.53:0.53:0.61:0.57:0.64"] = 292, -- Splintertree Post, Crossroads, Camp Taurajo, Brackenwall Village
					["0.55:0.42:0.56:0.53:0.53:0.61"] = 234, -- Splintertree Post, Crossroads, Camp Taurajo
					["0.55:0.42:0.56:0.53:0.44:0.69"] = 412, -- Splintertree Post, Crossroads, Camp Mojache
					["0.55:0.42:0.56:0.53:0.45:0.56:0.32:0.58"] = 426, -- Splintertree Post, Crossroads, Thunder Bluff, Shadowprey Village
					["0.55:0.42:0.56:0.53:0.45:0.56"] = 267, -- Splintertree Post, Crossroads, Thunder Bluff
					["0.55:0.42:0.56:0.53"] = 160, -- Splintertree Post, Crossroads
					["0.55:0.42:0.63:0.44:0.61:0.55"] = 203, -- Splintertree Post, Orgrimmar, Ratchet
					["0.55:0.42:0.63:0.44"] = 96, -- Splintertree Post, Orgrimmar
					["0.55:0.42:0.63:0.36"] = 92, -- Splintertree Post, Valormok
					["0.55:0.42:0.50:0.35"] = 85, -- Splintertree Post, Emerald Sanctuary
					["0.55:0.42:0.41:0.37"] = 166, -- Splintertree Post, Zoram'gar Outpost
					["0.55:0.42:0.41:0.37:0.41:0.47"] = 287, -- Splintertree Post, Zoram'gar Outpost, Sun Rock Retreat
					["0.55:0.42:0.50:0.35:0.46:0.30"] = 163, -- Splintertree Post, Emerald Sanctuary, Bloodvenom Post
					["0.55:0.42:0.50:0.35:0.46:0.30:0.54:0.21"] = 287, -- Splintertree Post, Emerald Sanctuary, Bloodvenom Post, Moonglade
					["0.55:0.42:0.63:0.36:0.64:0.23"] = 221, -- Splintertree Post, Valormok, Everlook

					-- Horde: Sun Rock Retreat (Stonetalon Mountains)
					["0.41:0.47:0.56:0.53:0.55:0.73:0.61:0.80"] = 426, -- Sun Rock Retreat, Crossroads, Freewind Post, Gadgetzan
					["0.41:0.47:0.32:0.58:0.44:0.69:0.42:0.79"] = 469, -- Sun Rock Retreat, Shadowprey Village, Camp Mojache, Cenarion Hold
					["0.41:0.47:0.56:0.53:0.55:0.73:0.61:0.80:0.50:0.76"] = 527, -- Sun Rock Retreat, Crossroads, Freewind Post, Gadgetzan, Marshal's Refuge
					["0.41:0.47:0.56:0.53:0.55:0.73"] = 333, -- Sun Rock Retreat, Crossroads, Freewind Post
					["0.41:0.47:0.56:0.53:0.53:0.61:0.57:0.64:0.58:0.70"] = 342, -- Sun Rock Retreat, Crossroads, Camp Taurajo, Brackenwall Village, Mudsprocket
					["0.41:0.47:0.56:0.53:0.53:0.61:0.57:0.64"] = 281, -- Sun Rock Retreat, Crossroads, Camp Taurajo, Brackenwall Village
					["0.41:0.47:0.56:0.53:0.53:0.61"] = 223, -- Sun Rock Retreat, Crossroads, Camp Taurajo
					["0.41:0.47:0.32:0.58:0.44:0.69"] = 339, -- Sun Rock Retreat, Shadowprey Village, Camp Mojache
					["0.41:0.47:0.32:0.58"] = 143, -- Sun Rock Retreat, Shadowprey Village
					["0.41:0.47:0.45:0.56"] = 175, -- Sun Rock Retreat, Thunder Bluff
					["0.41:0.47:0.56:0.53"] = 150, -- Sun Rock Retreat, Crossroads
					["0.41:0.47:0.56:0.53:0.61:0.55"] = 200, -- Sun Rock Retreat, Crossroads, Ratchet
					["0.41:0.47:0.56:0.53:0.63:0.44"] = 266, -- Sun Rock Retreat, Crossroads, Orgrimmar
					["0.41:0.47:0.41:0.37:0.55:0.42"] = 294, -- Sun Rock Retreat, Zoram'gar Outpost, Splintertree Post
					["0.41:0.47:0.56:0.53:0.63:0.36"] = 313, -- Sun Rock Retreat, Crossroads, Valormok
					["0.41:0.47:0.56:0.53:0.63:0.36:0.64:0.23"] = 442, -- Sun Rock Retreat, Crossroads, Valormok, Everlook
					["0.41:0.47:0.41:0.37:0.50:0.35"] = 242, -- Sun Rock Retreat, Zoram'gar Outpost, Emerald Sanctuary
					["0.41:0.47:0.41:0.37:0.46:0.30"] = 257, -- Sun Rock Retreat, Zoram'gar Outpost, Bloodvenom Post
					["0.41:0.47:0.41:0.37:0.46:0.30:0.54:0.21"] = 382, -- Sun Rock Retreat, Zoram'gar Outpost, Bloodvenom Post, Moonglade
					["0.41:0.47:0.41:0.37"] = 121, -- Sun Rock Retreat, Zoram'gar Outpost

					-- Horde: Thunder Bluff (Mulgore)
					["0.45:0.56:0.44:0.69:0.42:0.79"] = 381, -- Thunder Bluff, Camp Mojache, Cenarion Hold
					["0.45:0.56:0.61:0.80:0.50:0.76"] = 395, -- Thunder Bluff, Gadgetzan, Marshal's Refuge
					["0.45:0.56:0.55:0.73"] = 204, -- Thunder Bluff, Freewind Post
					["0.45:0.56:0.61:0.80"] = 290, -- Thunder Bluff, Gadgetzan
					["0.45:0.56:0.53:0.61:0.57:0.64:0.58:0.70"] = 206, -- Thunder Bluff, Camp Taurajo, Brackenwall Village, Mudsprocket
					["0.45:0.56:0.57:0.64"] = 239, -- Thunder Bluff, Brackenwall Village
					["0.45:0.56:0.53:0.61"] = 87, -- Thunder Bluff, Camp Taurajo
					["0.45:0.56:0.44:0.69"] = 252, -- Thunder Bluff, Camp Mojache
					["0.45:0.56:0.32:0.58"] = 159, -- Thunder Bluff, Shadowprey Village
					["0.45:0.56:0.41:0.47"] = 182, -- Thunder Bluff, Sun Rock Retreat
					["0.45:0.56:0.56:0.53"] = 103, -- Thunder Bluff, Crossroads
					["0.45:0.56:0.56:0.53:0.61:0.55"] = 154, -- Thunder Bluff, Crossroads, Ratchet
					["0.45:0.56:0.63:0.44"] = 207, -- Thunder Bluff, Orgrimmar
					["0.45:0.56:0.56:0.53:0.55:0.42"] = 265, -- Thunder Bluff, Crossroads, Splintertree Post
					["0.45:0.56:0.63:0.36"] = 251, -- Thunder Bluff, Valormok
					["0.45:0.56:0.56:0.53:0.55:0.42:0.50:0.35"] = 343, -- Thunder Bluff, Crossroads, Splintertree Post, Emerald Sanctuary
					["0.45:0.56:0.56:0.53:0.46:0.30"] = 355, -- Thunder Bluff, Crossroads, Bloodvenom Post
					["0.45:0.56:0.41:0.37"] = 265, -- Thunder Bluff, Zoram'gar Outpost
					["0.45:0.56:0.63:0.36:0.64:0.23:0.54:0.21"] = 513, -- Thunder Bluff, Valormok, Everlook, Moonglade
					["0.45:0.56:0.63:0.36:0.64:0.23"] = 380, -- Thunder Bluff, Valormok, Everlook

					-- Horde: Valormok (Azshara)
					["0.63:0.36:0.56:0.53:0.55:0.73:0.61:0.80"] = 441, -- Valormok, Crossroads, Freewind Post, Gadgetzan
					["0.63:0.36:0.56:0.53:0.44:0.69:0.42:0.79"] = 545, -- Valormok, Crossroads, Camp Mojache, Cenarion Hold
					["0.63:0.36:0.56:0.53:0.55:0.73:0.61:0.80:0.50:0.76"] = 541, -- Valormok, Crossroads, Freewind Post, Gadgetzan, Marshal's Refuge
					["0.63:0.36:0.56:0.53:0.55:0.73"] = 348, -- Valormok, Crossroads, Freewind Post
					["0.63:0.36:0.56:0.53:0.53:0.61:0.57:0.64:0.58:0.70"] = 356, -- Valormok, Crossroads, Camp Taurajo, Brackenwall Village, Mudsprocket
					["0.63:0.36:0.56:0.53:0.53:0.61:0.57:0.64"] = 295, -- Valormok, Crossroads, Camp Taurajo, Brackenwall Village
					["0.63:0.36:0.56:0.53:0.53:0.61"] = 237, -- Valormok, Crossroads, Camp Taurajo
					["0.63:0.36:0.56:0.53:0.44:0.69"] = 415, -- Valormok, Crossroads, Camp Mojache
					["0.63:0.36:0.45:0.56:0.32:0.58"] = 409, -- Valormok, Thunder Bluff, Shadowprey Village
					["0.63:0.36:0.45:0.56"] = 250, -- Valormok, Thunder Bluff
					["0.63:0.36:0.56:0.53"] = 164, -- Valormok, Crossroads
					["0.63:0.36:0.63:0.44:0.61:0.55"] = 208, -- Valormok, Orgrimmar, Ratchet
					["0.63:0.36:0.63:0.44"] = 101, -- Valormok, Orgrimmar
					["0.63:0.36:0.55:0.42"] = 94, -- Valormok, Splintertree Post
					["0.63:0.36:0.56:0.53:0.41:0.47"] = 313, -- Valormok, Crossroads, Sun Rock Retreat
					["0.63:0.36:0.55:0.42:0.41:0.37"] = 253, -- Valormok, Splintertree Post, Zoram'gar Outpost
					["0.63:0.36:0.55:0.42:0.50:0.35"] = 172, -- Valormok, Splintertree Post, Emerald Sanctuary
					["0.63:0.36:0.46:0.30"] = 233, -- Valormok, Bloodvenom Post
					["0.63:0.36:0.64:0.23:0.54:0.21"] = 264, -- Valormok, Everlook, Moonglade
					["0.63:0.36:0.64:0.23"] = 131, -- Valormok, Everlook

					-- Horde: Zoram'gar Outpost (Ashenvale)
					["0.41:0.37:0.56:0.53:0.55:0.73:0.61:0.80"] = 512, -- Zoram'gar Outpost, Crossroads, Freewind Post, Gadgetzan
					["0.41:0.37:0.41:0.47:0.32:0.58:0.44:0.69:0.42:0.79"] = 589, -- Zoram'gar Outpost, Sun Rock Retreat, Shadowprey Village, Camp Mojache, Cenarion Hold
					["0.41:0.37:0.56:0.53:0.55:0.73:0.61:0.80:0.50:0.76"] = 611, -- Zoram'gar Outpost, Crossroads, Freewind Post, Gadgetzan, Marshal's Refuge
					["0.41:0.37:0.56:0.53:0.55:0.73"] = 419, -- Zoram'gar Outpost, Crossroads, Freewind Post
					["0.41:0.37:0.56:0.53:0.53:0.61:0.57:0.64:0.58:0.70"] = 428, -- Zoram'gar Outpost, Crossroads, Camp Taurajo, Brackenwall Village, Mudsprocket
					["0.41:0.37:0.56:0.53:0.53:0.61:0.57:0.64"] = 366, -- Zoram'gar Outpost, Crossroads, Camp Taurajo, Brackenwall Village
					["0.41:0.37:0.56:0.53:0.53:0.61"] = 309, -- Zoram'gar Outpost, Crossroads, Camp Taurajo
					["0.41:0.37:0.41:0.47:0.32:0.58:0.44:0.69"] = 459, -- Zoram'gar Outpost, Sun Rock Retreat, Shadowprey Village, Camp Mojache
					["0.41:0.37:0.41:0.47:0.32:0.58"] = 264, -- Zoram'gar Outpost, Sun Rock Retreat, Shadowprey Village
					["0.41:0.37:0.45:0.56"] = 247, -- Zoram'gar Outpost, Thunder Bluff
					["0.41:0.37:0.56:0.53"] = 235, -- Zoram'gar Outpost, Crossroads
					["0.41:0.37:0.56:0.53:0.61:0.55"] = 287, -- Zoram'gar Outpost, Crossroads, Ratchet
					["0.41:0.37:0.55:0.42:0.63:0.44"] = 262, -- Zoram'gar Outpost, Splintertree Post, Orgrimmar
					["0.41:0.37:0.55:0.42"] = 173, -- Zoram'gar Outpost, Splintertree Post
					["0.41:0.37:0.41:0.47"] = 121, -- Zoram'gar Outpost, Sun Rock Retreat
					["0.41:0.37:0.50:0.35"] = 122, -- Zoram'gar Outpost, Emerald Sanctuary
					["0.41:0.37:0.46:0.30"] = 138, -- Zoram'gar Outpost, Bloodvenom Post
					["0.41:0.37:0.55:0.42:0.63:0.36"] = 258, -- Zoram'gar Outpost, Splintertree Post, Valormok
					["0.41:0.37:0.46:0.30:0.64:0.23"] = 285, -- Zoram'gar Outpost, Bloodvenom Post, Everlook
					["0.41:0.37:0.46:0.30:0.54:0.21"] = 263, -- Zoram'gar Outpost, Bloodvenom Post, Moonglade

				},

				-- Horde: Outland
				[1945] = {

					-- Horde: Altar of Sha'tar (Shadowmoon Valley)
					["0.81:0.77:0.66:0.77"] = 67, -- Altar of Sha'tar, Shadowmoon Village
					["0.81:0.77:0.51:0.73:0.44:0.67"] = 193, -- Altar of Sha'tar, Stonebreaker Hold, Shattrath
					["0.81:0.77:0.51:0.73"] = 140, -- Altar of Sha'tar, Stonebreaker Hold 

					-- Horde: Area 52 (Netherstorm)
					["0.58:0.27:0.49:0.36:0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77"] = 357, -- Area 52, Mok'Nathal Village, Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village
					["0.58:0.27:0.49:0.36:0.44:0.51:0.54:0.57:0.65:0.50:0.68:0.63"] = 342, -- Area 52, Mok'Nathal Village, Swamprat Post, Falcon Watch, Thrallmar, Spinebreaker Ridge
					["0.58:0.27:0.49:0.36:0.44:0.51:0.54:0.57:0.65:0.50:0.79:0.54"] = 343, -- Area 52, Mok'Nathal Village, Swamprat Post, Falcon Watch, Thrallmar, Hellfire Peninsula
					["0.58:0.27:0.49:0.36:0.44:0.51:0.54:0.57:0.65:0.50"] = 273, -- Area 52, Mok'Nathal Village, Swamprat Post, Falcon Watch, Thrallmar
					["0.58:0.27:0.49:0.36:0.44:0.51:0.54:0.57"] = 204, -- Area 52, Mok'Nathal Village, Swamprat Post, Falcon Watch
					["0.58:0.27:0.49:0.36:0.44:0.51:0.44:0.67:0.51:0.73"] = 292, -- Area 52, Mok'Nathal Village, Swamprat Post, Shattrath, Stonebreaker Hold
					["0.58:0.27:0.49:0.36:0.44:0.51:0.44:0.67"] = 224, -- Area 52, Mok'Nathal Village, Swamprat Post, Shattrath
					["0.58:0.27:0.49:0.36:0.44:0.51"] = 137, -- Area 52, Mok'Nathal Village, Swamprat Post
					["0.58:0.27:0.49:0.36:0.44:0.51:0.44:0.67:0.29:0.62"] = 306, -- Area 52, Mok'Nathal Village, Swamprat Post, Shattrath, Garadar
					["0.58:0.27:0.49:0.36:0.44:0.51:0.23:0.50"] = 248, -- Area 52, Mok'Nathal Village, Swamprat Post, Zabra'jin
					["0.58:0.27:0.38:0.32"] = 108, -- Area 52, Thunderlord Stronghold
					["0.58:0.27:0.49:0.36"] = 64, -- Area 52, Mok'Nathal Village
					["0.58:0.27:0.42:0.28"] = 80, -- Area 52, Evergrove
					["0.58:0.27:0.63:0.18"] = 47, -- Area 52, The Stormspire
					["0.58:0.27:0.72:0.28"] = 66, -- Area 52, Cosmowrench
					["0.58:0.27:0.49:0.36:0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77:0.81:0.77"] = 437, -- Area 52, Mok'Nathal Village, Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village, Altar of Sha'tar
					["0.58:0.27:0.38:0.32:0.44:0.51:0.54:0.57"] = 287, -- Area 52, Thunderlord Stronghold, Swamprat Post, Falcon Watch 
					["0.58:0.27:0.49:0.36:0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77:0.78:0.85"] = 421, -- Area 52, Mok'Nathal Village, Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village, Sanctum of the Stars
					["0.58:0.27:0.38:0.32:0.44:0.51:0.44:0.67"] = 311, -- Area 52, Thunderlord Stronghold, Swamprat Post, Shattrath

					-- Horde: Cosmowrench (Netherstorm)
					["0.72:0.28:0.58:0.27:0.49:0.36:0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77"] = 420, -- Cosmowrench, Area 52, Mok'Nathal Village, Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village
					["0.72:0.28:0.58:0.27:0.49:0.36:0.44:0.51:0.54:0.57:0.65:0.50:0.68:0.63"] = 401, -- Cosmowrench, Area 52, Mok'Nathal Village, Swamprat Post, Falcon Watch, Thrallmar, Spinebreaker Ridge
					["0.72:0.28:0.58:0.27:0.49:0.36:0.44:0.51:0.54:0.57:0.65:0.50:0.79:0.54"] = 406, -- Cosmowrench, Area 52, Mok'Nathal Village, Swamprat Post, Falcon Watch, Thrallmar, Hellfire Peninsula
					["0.72:0.28:0.58:0.27:0.49:0.36:0.44:0.51:0.54:0.57:0.65:0.50"] = 336, -- Cosmowrench, Area 52, Mok'Nathal Village, Swamprat Post, Falcon Watch, Thrallmar
					["0.72:0.28:0.58:0.27:0.49:0.36:0.44:0.51:0.54:0.57"] = 264, -- Cosmowrench, Area 52, Mok'Nathal Village, Swamprat Post, Falcon Watch
					["0.72:0.28:0.58:0.27:0.49:0.36:0.44:0.51:0.44:0.67:0.51:0.73"] = 355, -- Cosmowrench, Area 52, Mok'Nathal Village, Swamprat Post, Shattrath, Stonebreaker Hold
					["0.72:0.28:0.58:0.27:0.49:0.36:0.44:0.51:0.44:0.67"] = 287, -- Cosmowrench, Area 52, Mok'Nathal Village, Swamprat Post, Shattrath
					["0.72:0.28:0.58:0.27:0.49:0.36:0.44:0.51"] = 204, -- Cosmowrench, Area 52, Mok'Nathal Village, Swamprat Post
					["0.72:0.28:0.58:0.27:0.49:0.36:0.44:0.51:0.44:0.67:0.29:0.62"] = 371, -- Cosmowrench, Area 52, Mok'Nathal Village, Swamprat Post, Shattrath, Garadar
					["0.72:0.28:0.58:0.27:0.49:0.36:0.44:0.51:0.23:0.50"] = 312, -- Cosmowrench, Area 52, Mok'Nathal Village, Swamprat Post, Zabra'jin
					["0.72:0.28:0.58:0.27:0.38:0.32"] = 173, -- Cosmowrench, Area 52, Thunderlord Stronghold
					["0.72:0.28:0.58:0.27:0.49:0.36"] = 129, -- Cosmowrench, Area 52, Mok'Nathal Village
					["0.72:0.28:0.58:0.27:0.42:0.28"] = 146, -- Cosmowrench, Area 52, Evergrove
					["0.72:0.28:0.58:0.27"] = 64, -- Cosmowrench, Area 52
					["0.72:0.28:0.63:0.18"] = 61, -- Cosmowrench, The Stormspire
					["0.72:0.28:0.58:0.27:0.49:0.36:0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77:0.78:0.85"] = 484, -- Cosmowrench, Area 52, Mok'Nathal Village, Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village, Sanctum of the Stars

					-- Horde: Evergrove (Blade's Edge Mountains)
					["0.42:0.28:0.38:0.32:0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77"] = 371, -- Evergrove, Thunderlord Stronghold, Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village
					["0.42:0.28:0.38:0.32:0.44:0.51:0.54:0.57:0.65:0.50:0.68:0.63"] = 353, -- Evergrove, Thunderlord Stronghold, Swamprat Post, Falcon Watch, Thrallmar, Spinebreaker Ridge
					["0.42:0.28:0.38:0.32:0.44:0.51:0.54:0.57:0.65:0.50:0.79:0.54"] = 358, -- Evergrove, Thunderlord Stronghold, Swamprat Post, Falcon Watch, Thrallmar, Hellfire Peninsula
					["0.42:0.28:0.38:0.32:0.44:0.51:0.54:0.57:0.65:0.50"] = 287, -- Evergrove, Thunderlord Stronghold, Swamprat Post, Falcon Watch, Thrallmar
					["0.42:0.28:0.38:0.32:0.44:0.51:0.54:0.57"] = 215, -- Evergrove, Thunderlord Stronghold, Swamprat Post, Falcon Watch
					["0.42:0.28:0.38:0.32:0.44:0.51:0.44:0.67:0.51:0.73"] = 306, -- Evergrove, Thunderlord Stronghold, Swamprat Post, Shattrath, Stonebreaker Hold
					["0.42:0.28:0.38:0.32:0.44:0.51:0.44:0.67"] = 238, -- Evergrove, Thunderlord Stronghold, Swamprat Post, Shattrath
					["0.42:0.28:0.38:0.32:0.44:0.51"] = 152, -- Evergrove, Thunderlord Stronghold, Swamprat Post
					["0.42:0.28:0.38:0.32:0.23:0.50:0.29:0.62"] = 262, -- Evergrove, Thunderlord Stronghold, Zabra'jin, Garadar
					["0.42:0.28:0.38:0.32:0.23:0.50"] = 184, -- Evergrove, Thunderlord Stronghold, Zabra'jin
					["0.42:0.28:0.38:0.32"] = 36, -- Evergrove, Thunderlord Stronghold
					["0.42:0.28:0.38:0.32:0.49:0.36"] = 91, -- Evergrove, Thunderlord Stronghold, Mok'Nathal Village
					["0.42:0.28:0.58:0.27"] = 78, -- Evergrove, Area 52
					["0.42:0.28:0.58:0.27:0.72:0.28"] = 143, -- Evergrove, Area 52, Cosmowrench
					["0.42:0.28:0.58:0.27:0.63:0.18"] = 125, -- Evergrove, Area 52, The Stormspire
					["0.42:0.28:0.38:0.32:0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77:0.78:0.85"] = 435, -- Evergrove, Thunderlord Stronghold, Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village, Sanctum of the Stars

					-- Horde: Falcon Watch (Hellfire Peninsula)
					["0.54:0.57:0.44:0.67:0.51:0.73:0.66:0.77"] = 204, -- Falcon Watch, Shattrath, Stonebreaker Hold, Shadowmoon Village
					["0.54:0.57:0.65:0.50:0.68:0.63"] = 138, -- Falcon Watch, Thrallmar, Spinebreaker Ridge
					["0.54:0.57:0.65:0.50:0.79:0.54"] = 143, -- Falcon Watch, Thrallmar, Hellfire Peninsula
					["0.54:0.57:0.65:0.50"] = 73, -- Falcon Watch, Thrallmar
					["0.54:0.57:0.44:0.67:0.51:0.73"] = 139, -- Falcon Watch, Shattrath, Stonebreaker Hold
					["0.54:0.57:0.44:0.67"] = 71, -- Falcon Watch, Shattrath
					["0.54:0.57:0.44:0.51"] = 69, -- Falcon Watch, Swamprat Post
					["0.54:0.57:0.29:0.62"] = 132, -- Falcon Watch, Garadar
					["0.54:0.57:0.23:0.50"] = 150, -- Falcon Watch, Zabra'jin
					["0.54:0.57:0.44:0.51:0.38:0.32"] = 174, -- Falcon Watch, Swamprat Post, Thunderlord Stronghold
					["0.54:0.57:0.44:0.51:0.38:0.32:0.42:0.28"] = 201, -- Falcon Watch, Swamprat Post, Thunderlord Stronghold, Evergrove
					["0.54:0.57:0.44:0.51:0.49:0.36"] = 139, -- Falcon Watch, Swamprat Post, Mok'Nathal Village
					["0.54:0.57:0.44:0.51:0.49:0.36:0.58:0.27"] = 199, -- Falcon Watch, Swamprat Post, Mok'Nathal Village, Area 52
					["0.54:0.57:0.44:0.51:0.49:0.36:0.58:0.27:0.72:0.28"] = 260, -- Falcon Watch, Swamprat Post, Mok'Nathal Village, Area 52, Cosmowrench
					["0.54:0.57:0.44:0.51:0.49:0.36:0.58:0.27:0.63:0.18"] = 242, -- Falcon Watch, Swamprat Post, Mok'Nathal Village, Area 52, The Stormspire

					-- Horde: Garadar (Nagrand)
					["0.29:0.62:0.44:0.67:0.51:0.73:0.66:0.77"] = 210, -- Garadar, Shattrath, Stonebreaker Hold, Shadowmoon Village
					["0.29:0.62:0.44:0.67:0.51:0.73"] = 145, -- Garadar, Shattrath, Stonebreaker Hold
					["0.29:0.62:0.44:0.67"] = 77, -- Garadar, Shattrath
					["0.29:0.62:0.54:0.57:0.65:0.50:0.68:0.63"] = 266, -- Garadar, Falcon Watch, Thrallmar, Spinebreaker Ridge
					["0.29:0.62:0.54:0.57:0.65:0.50:0.79:0.54"] = 270, -- Garadar, Falcon Watch, Thrallmar, Hellfire Peninsula
					["0.29:0.62:0.54:0.57:0.65:0.50"] = 199, -- Garadar, Falcon Watch, Thrallmar
					["0.29:0.62:0.54:0.57"] = 126, -- Garadar, Falcon Watch
					["0.29:0.62:0.44:0.67:0.44:0.51"] = 156, -- Garadar, Shattrath, Swamprat Post
					["0.29:0.62:0.23:0.50"] = 67, -- Garadar, Zabra'jin
					["0.29:0.62:0.23:0.50:0.38:0.32"] = 177, -- Garadar, Zabra'jin, Thunderlord Stronghold
					["0.29:0.62:0.23:0.50:0.38:0.32:0.42:0.28"] = 203, -- Garadar, Zabra'jin, Thunderlord Stronghold, Evergrove
					["0.29:0.62:0.44:0.67:0.44:0.51:0.49:0.36"] = 227, -- Garadar, Shattrath, Swamprat Post, Mok'Nathal Village
					["0.29:0.62:0.23:0.50:0.38:0.32:0.58:0.27"] = 274, -- Garadar, Zabra'jin, Thunderlord Stronghold, Area 52
					["0.29:0.62:0.23:0.50:0.38:0.32:0.58:0.27:0.72:0.28"] = 339, -- Garadar, Zabra'jin, Thunderlord Stronghold, Area 52, Cosmowrench
					["0.29:0.62:0.23:0.50:0.38:0.32:0.58:0.27:0.63:0.18"] = 322, -- Garadar, Zabra'jin, Thunderlord Stronghold, Area 52, The Stormspire
					["0.29:0.62:0.44:0.67:0.51:0.73:0.66:0.77:0.81:0.77"] = 291, -- Garadar, Shattrath, Stonebreaker Hold, Shadowmoon Village, Altar of Sha'tar
					["0.29:0.62:0.44:0.67:0.51:0.73:0.66:0.77:0.78:0.85"] = 274, -- Garadar, Shattrath, Stonebreaker Hold, Shadowmoon Village, Sanctum of the Stars

					-- Horde: Hellfire Peninsula (Hellfire Peninsula) (Dark Portal)
					["0.79:0.54:0.65:0.50:0.51:0.73:0.66:0.77"] = 252, -- Hellfire Peninsula, Thrallmar, Stonebreaker Hold, Shadowmoon Village
					["0.79:0.54:0.65:0.50:0.68:0.63"] = 125, -- Hellfire Peninsula, Thrallmar, Spinebreaker Ridge
					["0.79:0.54:0.65:0.50"] = 59, -- Hellfire Peninsula, Thrallmar
					["0.79:0.54:0.54:0.57"] = 122, -- Hellfire Peninsula, Falcon Watch
					["0.79:0.54:0.65:0.50:0.51:0.73"] = 188, -- Hellfire Peninsula, Thrallmar, Stonebreaker Hold
					["0.79:0.54:0.54:0.57:0.44:0.67"] = 193, -- Hellfire Peninsula, Falcon Watch, Shattrath
					["0.79:0.54:0.54:0.57:0.44:0.51"] = 190, -- Hellfire Peninsula, Falcon Watch, Swamprat Post
					["0.79:0.54:0.54:0.57:0.29:0.62"] = 253, -- Hellfire Peninsula, Falcon Watch, Garadar
					["0.79:0.54:0.54:0.57:0.23:0.50"] = 271, -- Hellfire Peninsula, Falcon Watch, Zabra'jin
					["0.79:0.54:0.54:0.57:0.44:0.51:0.38:0.32"] = 295, -- Hellfire Peninsula, Falcon Watch, Swamprat Post, Thunderlord Stronghold
					["0.79:0.54:0.54:0.57:0.44:0.51:0.38:0.32:0.42:0.28"] = 321, -- Hellfire Peninsula, Falcon Watch, Swamprat Post, Thunderlord Stronghold, Evergrove
					["0.79:0.54:0.54:0.57:0.44:0.51:0.49:0.36"] = 261, -- Hellfire Peninsula, Falcon Watch, Swamprat Post, Mok'Nathal Village
					["0.79:0.54:0.54:0.57:0.44:0.51:0.49:0.36:0.58:0.27"] = 316, -- Hellfire Peninsula, Falcon Watch, Swamprat Post, Mok'Nathal Village, Area 52
					["0.79:0.54:0.54:0.57:0.44:0.51:0.49:0.36:0.58:0.27:0.72:0.28"] = 381, -- Hellfire Peninsula, Falcon Watch, Swamprat Post, Mok'Nathal Village, Area 52, Cosmowrench
					["0.79:0.54:0.54:0.57:0.44:0.51:0.49:0.36:0.58:0.27:0.63:0.18"] = 364, -- Hellfire Peninsula, Falcon Watch, Swamprat Post, Mok'Nathal Village, Area 52, The Stormspire
					["0.79:0.54:0.65:0.50:0.51:0.73:0.66:0.77:0.78:0.85"] = 316, -- Hellfire Peninsula, Thrallmar, Stonebreaker Hold, Shadowmoon Village, Sanctum of the Stars

					-- Horde: Mok'Nathal Village (Blade's Edge Mountains)
					["0.49:0.36:0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77"] = 292, -- Mok'Nathal Village, Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village
					["0.49:0.36:0.44:0.51:0.54:0.57:0.65:0.50:0.68:0.63"] = 274, -- Mok'Nathal Village, Swamprat Post, Falcon Watch, Thrallmar, Spinebreaker Ridge
					["0.49:0.36:0.44:0.51:0.54:0.57:0.65:0.50:0.79:0.54"] = 279, -- Mok'Nathal Village, Swamprat Post, Falcon Watch, Thrallmar, Hellfire Peninsula
					["0.49:0.36:0.44:0.51:0.54:0.57:0.65:0.50"] = 208, -- Mok'Nathal Village, Swamprat Post, Falcon Watch, Thrallmar
					["0.49:0.36:0.44:0.51:0.54:0.57"] = 136, -- Mok'Nathal Village, Swamprat Post, Falcon Watch
					["0.49:0.36:0.44:0.51:0.44:0.67:0.51:0.73"] = 228, -- Mok'Nathal Village, Swamprat Post, Shattrath, Stonebreaker Hold
					["0.49:0.36:0.44:0.51:0.44:0.67"] = 160, -- Mok'Nathal Village, Swamprat Post, Shattrath
					["0.49:0.36:0.44:0.51"] = 74, -- Mok'Nathal Village, Swamprat Post
					["0.49:0.36:0.44:0.51:0.44:0.67:0.29:0.62"] = 243, -- Mok'Nathal Village, Swamprat Post, Shattrath, Garadar
					["0.49:0.36:0.44:0.51:0.23:0.50"] = 185, -- Mok'Nathal Village, Swamprat Post, Zabra'jin
					["0.49:0.36:0.38:0.32"] = 63, -- Mok'Nathal Village, Thunderlord Stronghold
					["0.49:0.36:0.38:0.32:0.42:0.28"] = 88, -- Mok'Nathal Village, Thunderlord Stronghold, Evergrove
					["0.49:0.36:0.58:0.27"] = 57, -- Mok'Nathal Village, Area 52
					["0.49:0.36:0.58:0.27:0.72:0.28"] = 122, -- Mok'Nathal Village, Area 52, Cosmowrench
					["0.49:0.36:0.58:0.27:0.63:0.18"] = 104, -- Mok'Nathal Village, Area 52, The Stormspire

					-- Horde: Sanctum of the Stars (Shadowmoon Valley)
					["0.78:0.85:0.66:0.77"] = 61, -- Sanctum of the Stars, Shadowmoon Village
					["0.78:0.85:0.51:0.73"] = 134, -- Sanctum of the Stars, Stonebreaker Hold
					["0.78:0.85:0.51:0.73:0.44:0.67:0.44:0.51:0.38:0.32:0.42:0.28"] = 397, -- Sanctum of the Stars, Stonebreaker Hold, Shattrath, Swamprat Post, Thunderlord Stronghold, Evergrove
					["0.78:0.85:0.51:0.73:0.44:0.67"] = 187, -- Sanctum of the Stars, Stonebreaker Hold, Shattrath
					["0.78:0.85:0.51:0.73:0.65:0.50:0.68:0.63"] = 322, -- Sanctum of the Stars, Stonebreaker Hold, Thrallmar, Spinebreaker Ridge
					["0.78:0.85:0.51:0.73:0.44:0.67:0.29:0.62"] = 268, -- Sanctum of the Stars, Stonebreaker Hold, Shattrath, Garadar
					["0.78:0.85:0.51:0.73:0.65:0.50"] = 257, -- Sanctum of the Stars, Stonebreaker Hold, Thrallmar
					["0.78:0.85:0.51:0.73:0.44:0.67:0.23:0.50"] = 323, -- Sanctum of the Stars, Stonebreaker Hold, Shattrath, Zabra'jin
					["0.78:0.85:0.51:0.73:0.44:0.67:0.44:0.51:0.49:0.36:0.58:0.27:0.63:0.18"] = 439, -- Sanctum of the Stars, Stonebreaker Hold, Shattrath, Swamprat Post, Mok'Nathal Village, Area 52, The Stormspire
					["0.78:0.85:0.51:0.73:0.44:0.67:0.44:0.51:0.49:0.36:0.58:0.27:0.72:0.28"] = 457, -- Sanctum of the Stars, Stonebreaker Hold, Shattrath, Swamprat Post, Mok'Nathal Village, Area 52, Cosmowrench
					["0.78:0.85:0.51:0.73:0.65:0.50:0.79:0.54"] = 327, -- Sanctum of the Stars, Stonebreaker Hold, Thrallmar, Hellfire Peninsula
					["0.78:0.85:0.51:0.73:0.44:0.67:0.44:0.51"] = 266, -- Sanctum of the Stars, Stonebreaker Hold, Shattrath, Swamprat Post
					["0.78:0.85:0.51:0.73:0.44:0.67:0.44:0.51:0.49:0.36:0.58:0.27"] = 392, -- Sanctum of the Stars, Stonebreaker Hold, Shattrath, Swamprat Post, Mok'Nathal Village, Area 52

					-- Horde: Shadowmoon Village (Shadowmoon Valley)
					["0.66:0.77:0.51:0.73"] = 73, -- Shadowmoon Village, Stonebreaker Hold
					["0.66:0.77:0.51:0.73:0.44:0.67"] = 126, -- Shadowmoon Village, Stonebreaker Hold, Shattrath
					["0.66:0.77:0.51:0.73:0.44:0.67:0.29:0.62"] = 207, -- Shadowmoon Village, Stonebreaker Hold, Shattrath, Garadar
					["0.66:0.77:0.51:0.73:0.44:0.67:0.23:0.50"] = 262, -- Shadowmoon Village, Stonebreaker Hold, Shattrath, Zabra'jin
					["0.66:0.77:0.51:0.73:0.44:0.67:0.44:0.51"] = 205, -- Shadowmoon Village, Stonebreaker Hold, Shattrath, Swamprat Post
					["0.66:0.77:0.51:0.73:0.44:0.67:0.54:0.57"] = 202, -- Shadowmoon Village, Stonebreaker Hold, Shattrath, Falcon Watch
					["0.66:0.77:0.51:0.73:0.65:0.50:0.68:0.63"] = 262, -- Shadowmoon Village, Stonebreaker Hold, Thrallmar, Spinebreaker Ridge
					["0.66:0.77:0.51:0.73:0.65:0.50:0.79:0.54"] = 267, -- Shadowmoon Village, Stonebreaker Hold, Thrallmar, Hellfire Peninsula
					["0.66:0.77:0.51:0.73:0.65:0.50"] = 196, -- Shadowmoon Village, Stonebreaker Hold, Thrallmar
					["0.66:0.77:0.51:0.73:0.44:0.67:0.44:0.51:0.49:0.36"] = 276, -- Shadowmoon Village, Stonebreaker Hold, Shattrath, Swamprat Post, Mok'Nathal Village
					["0.66:0.77:0.51:0.73:0.44:0.67:0.44:0.51:0.38:0.32"] = 311, -- Shadowmoon Village, Stonebreaker Hold, Shattrath, Swamprat Post, Thunderlord Stronghold
					["0.66:0.77:0.51:0.73:0.44:0.67:0.44:0.51:0.38:0.32:0.42:0.28"] = 336, -- Shadowmoon Village, Stonebreaker Hold, Shattrath, Swamprat Post, Thunderlord Stronghold, Evergrove
					["0.66:0.77:0.51:0.73:0.44:0.67:0.44:0.51:0.49:0.36:0.58:0.27"] = 331, -- Shadowmoon Village, Stonebreaker Hold, Shattrath, Swamprat Post, Mok'Nathal Village, Area 52
					["0.66:0.77:0.51:0.73:0.44:0.67:0.44:0.51:0.49:0.36:0.58:0.27:0.72:0.28"] = 397, -- Shadowmoon Village, Stonebreaker Hold, Shattrath, Swamprat Post, Mok'Nathal Village, Area 52, Cosmowrench
					["0.66:0.77:0.51:0.73:0.44:0.67:0.44:0.51:0.49:0.36:0.58:0.27:0.63:0.18"] = 384, -- Shadowmoon Village, Stonebreaker Hold, Shattrath, Swamprat Post, Mok'Nathal Village, Area 52, The Stormspire
					["0.66:0.77:0.78:0.85"] = 66, -- Shadowmoon Village, Sanctum of the Stars
					["0.66:0.77:0.51:0.73:0.44:0.67:0.44:0.51:0.38:0.32:0.58:0.27"] = 407, -- Shadowmoon Village, Stonebreaker Hold, Shattrath, Swamprat Post, Thunderlord Stronghold, Area 52

					-- Horde: Shattrath (Terokkar Forest)
					["0.44:0.67:0.23:0.50"] = 136, -- Shattrath, Zabra'jin
					["0.44:0.67:0.29:0.62"] = 81, -- Shattrath, Garadar
					["0.44:0.67:0.44:0.51"] = 79, -- Shattrath, Swamprat Post
					["0.44:0.67:0.54:0.57"] = 77, -- Shattrath, Falcon Watch
					["0.44:0.67:0.51:0.73"] = 69, -- Shattrath, Stonebreaker Hold
					["0.44:0.67:0.51:0.73:0.66:0.77"] = 133, -- Shattrath, Stonebreaker Hold, Shadowmoon Village
					["0.44:0.67:0.54:0.57:0.65:0.50:0.68:0.63"] = 215, -- Shattrath, Falcon Watch, Thrallmar, Spinebreaker Ridge
					["0.44:0.67:0.54:0.57:0.65:0.50:0.79:0.54"] = 220, -- Shattrath, Falcon Watch, Thrallmar, Hellfire Peninsula
					["0.44:0.67:0.54:0.57:0.65:0.50"] = 150, -- Shattrath, Falcon Watch, Thrallmar
					["0.44:0.67:0.44:0.51:0.49:0.36"] = 150, -- Shattrath, Swamprat Post, Mok'Nathal Village
					["0.44:0.67:0.44:0.51:0.38:0.32:0.42:0.28"] = 211, -- Shattrath, Swamprat Post, Thunderlord Stronghold, Evergrove
					["0.44:0.67:0.44:0.51:0.38:0.32"] = 185, -- Shattrath, Swamprat Post, Thunderlord Stronghold
					["0.44:0.67:0.44:0.51:0.49:0.36:0.58:0.27"] = 205, -- Shattrath, Swamprat Post, Mok'Nathal Village, Area 52
					["0.44:0.67:0.44:0.51:0.49:0.36:0.58:0.27:0.63:0.18"] = 253, -- Shattrath, Swamprat Post, Mok'Nathal Village, Area 52, The Stormspire
					["0.44:0.67:0.44:0.51:0.49:0.36:0.58:0.27:0.72:0.28"] = 270, -- Shattrath, Swamprat Post, Mok'Nathal Village, Area 52, Cosmowrench
					["0.44:0.67:0.51:0.73:0.66:0.77:0.81:0.77"] = 215, -- Shattrath, Stonebreaker Hold, Shadowmoon Village, Altar of Sha'tar
					["0.44:0.67:0.44:0.51:0.38:0.32:0.58:0.27:0.72:0.28"] = 347, -- Shattrath, Swamprat Post, Thunderlord Stronghold, Area 52, Cosmowrench 
					["0.44:0.67:0.51:0.73:0.66:0.77:0.78:0.85"] = 198, -- Shattrath, Stonebreaker Hold, Shadowmoon Village, Sanctum of the Stars
					["0.44:0.67:0.44:0.51:0.38:0.32:0.58:0.27"] = 282, -- Shattrath, Swamprat Post, Thunderlord Stronghold, Area 52

					-- Horde: Spinebreaker Ridge (Hellfire Peninsula)
					["0.68:0.63:0.65:0.50:0.54:0.57:0.29:0.62"] = 263, -- Spinebreaker Ridge, Thrallmar, Falcon Watch, Garadar
					["0.68:0.63:0.65:0.50:0.54:0.57:0.44:0.67"] = 200, -- Spinebreaker Ridge, Thrallmar, Falcon Watch, Shattrath
					["0.68:0.63:0.65:0.50:0.51:0.73"] = 190, -- Spinebreaker Ridge, Thrallmar, Stonebreaker Hold
					["0.68:0.63:0.65:0.50:0.51:0.73:0.66:0.77"] = 255, -- Spinebreaker Ridge, Thrallmar, Stonebreaker Hold, Shadowmoon Village
					["0.68:0.63:0.65:0.50:0.79:0.54"] = 133, -- Spinebreaker Ridge, Thrallmar, Hellfire Peninsula
					["0.68:0.63:0.65:0.50"] = 62, -- Spinebreaker Ridge, Thrallmar
					["0.68:0.63:0.65:0.50:0.54:0.57"] = 129, -- Spinebreaker Ridge, Thrallmar, Falcon Watch
					["0.68:0.63:0.65:0.50:0.54:0.57:0.44:0.51"] = 198, -- Spinebreaker Ridge, Thrallmar, Falcon Watch, Swamprat Post
					["0.68:0.63:0.65:0.50:0.54:0.57:0.23:0.50"] = 280, -- Spinebreaker Ridge, Thrallmar, Falcon Watch, Zabra'jin
					["0.68:0.63:0.65:0.50:0.54:0.57:0.44:0.51:0.38:0.32"] = 303, -- Spinebreaker Ridge, Thrallmar, Falcon Watch, Swamprat Post, Thunderlord Stronghold
					["0.68:0.63:0.65:0.50:0.54:0.57:0.44:0.51:0.38:0.32:0.42:0.28"] = 330, -- Spinebreaker Ridge, Thrallmar, Falcon Watch, Swamprat Post, Thunderlord Stronghold, Evergrove
					["0.68:0.63:0.65:0.50:0.54:0.57:0.44:0.51:0.49:0.36"] = 268, -- Spinebreaker Ridge, Thrallmar, Falcon Watch, Swamprat Post, Mok'Nathal Village
					["0.68:0.63:0.65:0.50:0.54:0.57:0.44:0.51:0.49:0.36:0.58:0.27"] = 327, -- Spinebreaker Ridge, Thrallmar, Falcon Watch, Swamprat Post, Mok'Nathal Village, Area 52
					["0.68:0.63:0.65:0.50:0.54:0.57:0.44:0.51:0.49:0.36:0.58:0.27:0.72:0.28"] = 389, -- Spinebreaker Ridge, Thrallmar, Falcon Watch, Swamprat Post, Mok'Nathal Village, Area 52, Cosmowrench
					["0.68:0.63:0.65:0.50:0.54:0.57:0.44:0.51:0.49:0.36:0.58:0.27:0.63:0.18"] = 373, -- Spinebreaker Ridge, Thrallmar, Falcon Watch, Swamprat Post, Mok'Nathal Village, Area 52, The Stormspire
					["0.68:0.63:0.65:0.50:0.51:0.73:0.66:0.77:0.78:0.85"] = 319, -- Spinebreaker Ridge, Thrallmar, Stonebreaker Hold, Shadowmoon Village, Sanctum of the Stars

					-- Horde: Stonebreaker Hold (Terokkar Forest)
					["0.51:0.73:0.66:0.77"] = 68, -- Stonebreaker Hold, Shadowmoon Village
					["0.51:0.73:0.65:0.50:0.68:0.63"] = 191, -- Stonebreaker Hold, Thrallmar, Spinebreaker Ridge
					["0.51:0.73:0.65:0.50:0.79:0.54"] = 195, -- Stonebreaker Hold, Thrallmar, Hellfire Peninsula
					["0.51:0.73:0.65:0.50"] = 125, -- Stonebreaker Hold, Thrallmar
					["0.51:0.73:0.44:0.67:0.54:0.57"] = 132, -- Stonebreaker Hold, Shattrath, Falcon Watch
					["0.51:0.73:0.44:0.67"] = 56, -- Stonebreaker Hold, Shattrath
					["0.51:0.73:0.44:0.67:0.29:0.62"] = 137, -- Stonebreaker Hold, Shattrath, Garadar
					["0.51:0.73:0.44:0.67:0.44:0.51"] = 135, -- Stonebreaker Hold, Shattrath, Swamprat Post
					["0.51:0.73:0.44:0.67:0.23:0.50"] = 193, -- Stonebreaker Hold, Shattrath, Zabra'jin
					["0.51:0.73:0.44:0.67:0.44:0.51:0.38:0.32"] = 242, -- Stonebreaker Hold, Shattrath, Swamprat Post, Thunderlord Stronghold
					["0.51:0.73:0.44:0.67:0.44:0.51:0.38:0.32:0.42:0.28"] = 266, -- Stonebreaker Hold, Shattrath, Swamprat Post, Thunderlord Stronghold, Evergrove
					["0.51:0.73:0.44:0.67:0.44:0.51:0.49:0.36"] = 207, -- Stonebreaker Hold, Shattrath, Swamprat Post, Mok'Nathal Village
					["0.51:0.73:0.44:0.67:0.44:0.51:0.49:0.36:0.58:0.27"] = 261, -- Stonebreaker Hold, Shattrath, Swamprat Post, Mok'Nathal Village, Area 52
					["0.51:0.73:0.44:0.67:0.44:0.51:0.49:0.36:0.58:0.27:0.72:0.28"] = 330, -- Stonebreaker Hold, Shattrath, Swamprat Post, Mok'Nathal Village, Area 52, Cosmowrench
					["0.51:0.73:0.44:0.67:0.44:0.51:0.49:0.36:0.58:0.27:0.63:0.18"] = 313, -- Stonebreaker Hold, Shattrath, Swamprat Post, Mok'Nathal Village, Area 52, The Stormspire
					["0.51:0.73:0.66:0.77:0.78:0.85"] = 133, -- Stonebreaker Hold, Shadowmoon Village, Sanctum of the Stars

					-- Horde: Swamprat Post (Zangarmarsh)
					["0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77"] = 220, -- Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village
					["0.44:0.51:0.54:0.57:0.65:0.50:0.68:0.63"] = 201, -- Swamprat Post, Falcon Watch, Thrallmar, Spinebreaker Ridge
					["0.44:0.51:0.54:0.57:0.65:0.50:0.79:0.54"] = 206, -- Swamprat Post, Falcon Watch, Thrallmar, Hellfire Peninsula
					["0.44:0.51:0.54:0.57:0.65:0.50"] = 136, -- Swamprat Post, Falcon Watch, Thrallmar
					["0.44:0.51:0.54:0.57"] = 61, -- Swamprat Post, Falcon Watch
					["0.44:0.51:0.44:0.67:0.51:0.73"] = 155, -- Swamprat Post, Shattrath, Stonebreaker Hold
					["0.44:0.51:0.44:0.67"] = 86, -- Swamprat Post, Shattrath
					["0.44:0.51:0.44:0.67:0.29:0.62"] = 168, -- Swamprat Post, Shattrath, Garadar
					["0.44:0.51:0.23:0.50"] = 111, -- Swamprat Post, Zabra'jin
					["0.44:0.51:0.38:0.32"] = 106, -- Swamprat Post, Thunderlord Stronghold
					["0.44:0.51:0.38:0.32:0.42:0.28"] = 132, -- Swamprat Post, Thunderlord Stronghold, Evergrove
					["0.44:0.51:0.49:0.36"] = 71, -- Swamprat Post, Mok'Nathal Village
					["0.44:0.51:0.49:0.36:0.58:0.27"] = 126, -- Swamprat Post, Mok'Nathal Village, Area 52
					["0.44:0.51:0.49:0.36:0.58:0.27:0.72:0.28"] = 193, -- Swamprat Post, Mok'Nathal Village, Area 52, Cosmowrench
					["0.44:0.51:0.49:0.36:0.58:0.27:0.63:0.18"] = 174, -- Swamprat Post, Mok'Nathal Village, Area 52, The Stormspire
					["0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77:0.78:0.85"] = 284, -- Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village, Sanctum of the Stars
					["0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77:0.81:0.77"] = 301, -- Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village, Altar of Sha'tar

					-- Horde: The Stormspire (Netherstorm)
					["0.63:0.18:0.58:0.27:0.49:0.36:0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77"] = 410, -- The Stormspire, Area 52, Mok'Nathal Village, Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village
					["0.63:0.18:0.58:0.27:0.49:0.36:0.44:0.51:0.54:0.57:0.65:0.50:0.68:0.63"] = 390, -- The Stormspire, Area 52, Mok'Nathal Village, Swamprat Post, Falcon Watch, Thrallmar, Spinebreaker Ridge
					["0.63:0.18:0.58:0.27:0.49:0.36:0.44:0.51:0.54:0.57:0.65:0.50:0.79:0.54"] = 395, -- The Stormspire, Area 52, Mok'Nathal Village, Swamprat Post, Falcon Watch, Thrallmar, Hellfire Peninsula
					["0.63:0.18:0.58:0.27:0.49:0.36:0.44:0.51:0.54:0.57:0.65:0.50"] = 326, -- The Stormspire, Area 52, Mok'Nathal Village, Swamprat Post, Falcon Watch, Thrallmar
					["0.63:0.18:0.58:0.27:0.49:0.36:0.44:0.51:0.54:0.57"] = 254, -- The Stormspire, Area 52, Mok'Nathal Village, Swamprat Post, Falcon Watch
					["0.63:0.18:0.58:0.27:0.49:0.36:0.44:0.51:0.44:0.67:0.51:0.73"] = 345, -- The Stormspire, Area 52, Mok'Nathal Village, Swamprat Post, Shattrath, Stonebreaker Hold
					["0.63:0.18:0.58:0.27:0.49:0.36:0.44:0.51:0.44:0.67"] = 277, -- The Stormspire, Area 52, Mok'Nathal Village, Swamprat Post, Shattrath
					["0.63:0.18:0.58:0.27:0.49:0.36:0.44:0.51"] = 191, -- The Stormspire, Area 52, Mok'Nathal Village, Swamprat Post
					["0.63:0.18:0.58:0.27:0.49:0.36:0.44:0.51:0.44:0.67:0.29:0.62"] = 359, -- The Stormspire, Area 52, Mok'Nathal Village, Swamprat Post, Shattrath, Garadar
					["0.63:0.18:0.38:0.32:0.23:0.50"] = 294, -- The Stormspire, Thunderlord Stronghold, Zabra'jin
					["0.63:0.18:0.58:0.27:0.49:0.36"] = 118, -- The Stormspire, Area 52, Mok'Nathal Village
					["0.63:0.18:0.38:0.32"] = 147, -- The Stormspire, Thunderlord Stronghold
					["0.63:0.18:0.58:0.27:0.42:0.28"] = 132, -- The Stormspire, Area 52, Evergrove
					["0.63:0.18:0.58:0.27"] = 53, -- The Stormspire, Area 52
					["0.63:0.18:0.72:0.28"] = 69, -- The Stormspire, Cosmowrench
					["0.63:0.18:0.58:0.27:0.49:0.36:0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77:0.78:0.85"] = 474, -- The Stormspire, Area 52, Mok'Nathal Village, Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village, Sanctum of the Stars

					-- Horde: Thrallmar (Hellfire Peninsula)
					["0.65:0.50:0.51:0.73:0.66:0.77"] = 192, -- Thrallmar, Stonebreaker Hold, Shadowmoon Village
					["0.65:0.50:0.68:0.63"] = 66, -- Thrallmar, Spinebreaker Ridge
					["0.65:0.50:0.79:0.54"] = 70, -- Thrallmar, Hellfire Peninsula
					["0.65:0.50:0.54:0.57"] = 66, -- Thrallmar, Falcon Watch
					["0.65:0.50:0.51:0.73"] = 129, -- Thrallmar, Stonebreaker Hold
					["0.65:0.50:0.54:0.57:0.44:0.67"] = 138, -- Thrallmar, Falcon Watch, Shattrath
					["0.65:0.50:0.54:0.57:0.44:0.51"] = 135, -- Thrallmar, Falcon Watch, Swamprat Post
					["0.65:0.50:0.54:0.57:0.29:0.62"] = 199, -- Thrallmar, Falcon Watch, Garadar
					["0.65:0.50:0.54:0.57:0.23:0.50"] = 217, -- Thrallmar, Falcon Watch, Zabra'jin
					["0.65:0.50:0.54:0.57:0.44:0.51:0.38:0.32"] = 242, -- Thrallmar, Falcon Watch, Swamprat Post, Thunderlord Stronghold
					["0.65:0.50:0.54:0.57:0.44:0.51:0.38:0.32:0.42:0.28"] = 267, -- Thrallmar, Falcon Watch, Swamprat Post, Thunderlord Stronghold, Evergrove
					["0.65:0.50:0.54:0.57:0.44:0.51:0.49:0.36"] = 206, -- Thrallmar, Falcon Watch, Swamprat Post, Mok'Nathal Village
					["0.65:0.50:0.54:0.57:0.44:0.51:0.49:0.36:0.58:0.27"] = 262, -- Thrallmar, Falcon Watch, Swamprat Post, Mok'Nathal Village, Area 52
					["0.65:0.50:0.54:0.57:0.44:0.51:0.49:0.36:0.58:0.27:0.63:0.18"] = 309, -- Thrallmar, Falcon Watch, Swamprat Post, Mok'Nathal Village, Area 52, The Stormspire
					["0.65:0.50:0.54:0.57:0.44:0.51:0.49:0.36:0.58:0.27:0.72:0.28"] = 327, -- Thrallmar, Falcon Watch, Swamprat Post, Mok'Nathal Village, Area 52, Cosmowrench
					["0.65:0.50:0.51:0.73:0.66:0.77:0.78:0.85"] = 257, -- Thrallmar, Stonebreaker Hold, Shadowmoon Village, Sanctum of the Stars
					["0.65:0.50:0.54:0.57:0.44:0.51:0.38:0.32:0.58:0.27"] = 338, -- Thrallmar, Falcon Watch, Swamprat Post, Thunderlord Stronghold, Area 52

					-- Horde: Thunderlord Stronghold (Blade's Edge Mountains)
					["0.38:0.32:0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77"] = 335, -- Thunderlord Stronghold, Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village
					["0.38:0.32:0.44:0.51:0.54:0.57:0.65:0.50:0.68:0.63"] = 316, -- Thunderlord Stronghold, Swamprat Post, Falcon Watch, Thrallmar, Spinebreaker Ridge
					["0.38:0.32:0.44:0.51:0.54:0.57:0.65:0.50:0.79:0.54"] = 322, -- Thunderlord Stronghold, Swamprat Post, Falcon Watch, Thrallmar, Hellfire Peninsula
					["0.38:0.32:0.44:0.51:0.54:0.57:0.65:0.50"] = 251, -- Thunderlord Stronghold, Swamprat Post, Falcon Watch, Thrallmar
					["0.38:0.32:0.44:0.51:0.54:0.57"] = 179, -- Thunderlord Stronghold, Swamprat Post, Falcon Watch
					["0.38:0.32:0.44:0.51:0.44:0.67:0.51:0.73"] = 271, -- Thunderlord Stronghold, Swamprat Post, Shattrath, Stonebreaker Hold
					["0.38:0.32:0.44:0.51:0.44:0.67"] = 202, -- Thunderlord Stronghold, Swamprat Post, Shattrath
					["0.38:0.32:0.44:0.51"] = 116, -- Thunderlord Stronghold, Swamprat Post
					["0.38:0.32:0.23:0.50:0.29:0.62"] = 227, -- Thunderlord Stronghold, Zabra'jin, Garadar
					["0.38:0.32:0.23:0.50"] = 149, -- Thunderlord Stronghold, Zabra'jin
					["0.38:0.32:0.49:0.36"] = 55, -- Thunderlord Stronghold, Mok'Nathal Village
					["0.38:0.32:0.42:0.28"] = 26, -- Thunderlord Stronghold, Evergrove
					["0.38:0.32:0.58:0.27"] = 97, -- Thunderlord Stronghold, Area 52
					["0.38:0.32:0.58:0.27:0.72:0.28"] = 163, -- Thunderlord Stronghold, Area 52, Cosmowrench
					["0.38:0.32:0.63:0.18"] = 158, -- Thunderlord Stronghold, The Stormspire

					-- Horde: Zabra'jin (Zangarmarsh)
					["0.23:0.50:0.29:0.62"] = 81, -- Zabra'jin, Garadar
					["0.23:0.50:0.44:0.67"] = 151, -- Zabra'jin, Shattrath
					["0.23:0.50:0.44:0.67:0.51:0.73"] = 220, -- Zabra'jin, Shattrath, Stonebreaker Hold
					["0.23:0.50:0.44:0.67:0.51:0.73:0.66:0.77"] = 284, -- Zabra'jin, Shattrath, Stonebreaker Hold, Shadowmoon Village
					["0.23:0.50:0.54:0.57:0.65:0.50:0.68:0.63"] = 287, -- Zabra'jin, Falcon Watch, Thrallmar, Spinebreaker Ridge
					["0.23:0.50:0.54:0.57:0.65:0.50:0.79:0.54"] = 290, -- Zabra'jin, Falcon Watch, Thrallmar, Hellfire Peninsula
					["0.23:0.50:0.54:0.57:0.65:0.50"] = 220, -- Zabra'jin, Falcon Watch, Thrallmar
					["0.23:0.50:0.54:0.57"] = 147, -- Zabra'jin, Falcon Watch
					["0.23:0.50:0.44:0.51"] = 112, -- Zabra'jin, Swamprat Post
					["0.23:0.50:0.38:0.32"] = 113, -- Zabra'jin, Thunderlord Stronghold
					["0.23:0.50:0.38:0.32:0.42:0.28"] = 139, -- Zabra'jin, Thunderlord Stronghold, Evergrove
					["0.23:0.50:0.38:0.32:0.49:0.36"] = 168, -- Zabra'jin, Thunderlord Stronghold, Mok'Nathal Village
					["0.23:0.50:0.38:0.32:0.58:0.27"] = 209, -- Zabra'jin, Thunderlord Stronghold, Area 52
					["0.23:0.50:0.38:0.32:0.58:0.27:0.63:0.18"] = 257, -- Zabra'jin, Thunderlord Stronghold, Area 52, The Stormspire
					["0.23:0.50:0.38:0.32:0.58:0.27:0.72:0.28"] = 275, -- Zabra'jin, Thunderlord Stronghold, Area 52, Cosmowrench
					["0.23:0.50:0.44:0.67:0.51:0.73:0.66:0.77:0.78:0.85"] = 349, -- Zabra'jin, Shattrath, Stonebreaker Hold, Shadowmoon Village, Sanctum of the Stars

				},

			},

			----------------------------------------------------------------------
			--	Alliance
			----------------------------------------------------------------------

			["Alliance"] = {

				[1415] = {

					-- Alliance: Aerie Peak (The Hinterlands)
					["0.50:0.42:0.51:0.47:0.53:0.61:0.47:0.65:0.41:0.73:0.41:0.93"] = 633, -- Aerie Peak, Refuge Pointe, Thelsamar, Thorium Point, Stormwind, Booty Bay
					["0.50:0.42:0.51:0.47:0.53:0.61:0.47:0.65:0.41:0.73:0.43:0.82"] = 527, -- Aerie Peak, Refuge Pointe, Thelsamar, Thorium Point, Stormwind, Rebel Camp
					["0.50:0.42:0.51:0.47:0.53:0.61:0.47:0.65:0.41:0.73:0.39:0.80"] = 512, -- Aerie Peak, Refuge Pointe, Thelsamar, Thorium Point, Stormwind, Sentinel Hill
					["0.50:0.42:0.51:0.47:0.53:0.61:0.47:0.65:0.41:0.73"] = 448, -- Aerie Peak, Refuge Pointe, Thelsamar, Thorium Point, Stormwind
					["0.50:0.42:0.51:0.47:0.53:0.61:0.47:0.65:0.52:0.72:0.50:0.75:0.47:0.79"] = 504, -- Aerie Peak, Refuge Pointe, Thelsamar, Thorium Point, Morgan's Vigil, Lakeshire, Darkshire
					["0.50:0.42:0.51:0.47:0.53:0.61:0.47:0.65:0.52:0.72:0.55:0.81"] = 583, -- Aerie Peak, Refuge Pointe, Thelsamar, Thorium Point, Morgan's Vigil, Nethergarde Keep
					["0.50:0.42:0.51:0.47:0.53:0.61:0.47:0.65:0.52:0.72:0.50:0.75"] = 446, -- Aerie Peak, Refuge Pointe, Thelsamar, Thorium Point, Morgan's Vigil, Lakeshire
					["0.50:0.42:0.51:0.47:0.53:0.61:0.47:0.65:0.52:0.72"] = 414, -- Aerie Peak, Refuge Pointe, Thelsamar, Thorium Point, Morgan's Vigil
					["0.50:0.42:0.51:0.47:0.53:0.61:0.47:0.65"] = 324, -- Aerie Peak, Refuge Pointe, Thelsamar, Thorium Point
					["0.50:0.42:0.51:0.47:0.53:0.61"] = 246, -- Aerie Peak, Refuge Pointe, Thelsamar
					["0.50:0.42:0.47:0.59"] = 256, -- Aerie Peak, Ironforge
					["0.50:0.42:0.44:0.45:0.45:0.56"] = 176, -- Aerie Peak, Southshore, Menethil Harbor
					["0.50:0.42:0.51:0.47"] = 75, -- Aerie Peak, Refuge Pointe
					["0.50:0.42:0.44:0.45"] = 68, -- Aerie Peak, Southshore
					["0.50:0.42:0.48:0.39"] = 53, -- Aerie Peak, Chillwind Camp
					["0.50:0.42:0.61:0.35"] = 164, -- Aerie Peak, Light's Hope Chapel
					["0.50:0.42:0.51:0.47:0.53:0.61:0.47:0.65:0.41:0.73:0.50:0.75"] = 547, -- Aerie Peak, Refuge Pointe, Thelsamar, Thorium Point, Stormwind, Lakeshire

					-- Alliance: Booty Bay (Stranglethorn Vale)
					["0.41:0.93:0.39:0.80"] = 181, -- Booty Bay, Sentinel Hill
					["0.41:0.93:0.43:0.82"] = 118, -- Booty Bay, Rebel Camp
					["0.41:0.93:0.47:0.79"] = 167, -- Booty Bay, Darkshire
					["0.41:0.93:0.43:0.82:0.47:0.79:0.55:0.81"] = 252, -- Booty Bay, Rebel Camp, Darkshire, Nethergarde Keep
					["0.41:0.93:0.43:0.82:0.47:0.79:0.50:0.75"] = 230, -- Booty Bay, Rebel Camp, Darkshire, Lakeshire
					["0.41:0.93:0.43:0.82:0.47:0.79:0.50:0.75:0.52:0.72"] = 291, -- Booty Bay, Rebel Camp, Darkshire, Lakeshire, Morgan's Vigil
					["0.41:0.93:0.41:0.73"] = 200, -- Booty Bay, Stormwind
					["0.41:0.93:0.41:0.73:0.47:0.65"] = 318, -- Booty Bay, Stormwind, Thorium Point
					["0.41:0.93:0.41:0.73:0.47:0.65:0.53:0.61"] = 397, -- Booty Bay, Stormwind, Thorium Point, Thelsamar
					["0.41:0.93:0.41:0.73:0.47:0.59"] = 401, -- Booty Bay, Stormwind, Ironforge
					["0.41:0.93:0.41:0.73:0.47:0.59:0.45:0.56"] = 472, -- Booty Bay, Stormwind, Ironforge, Menethil Harbor
					["0.41:0.93:0.41:0.73:0.47:0.65:0.53:0.61:0.51:0.47"] = 560, -- Booty Bay, Stormwind, Thorium Point, Thelsamar, Refuge Pointe
					["0.41:0.93:0.41:0.73:0.47:0.59:0.44:0.45"] = 649, -- Booty Bay, Stormwind, Ironforge, Southshore
					["0.41:0.93:0.41:0.73:0.47:0.65:0.53:0.61:0.51:0.47:0.50:0.42"] = 489, -- Booty Bay, Stormwind, Thorium Point, Thelsamar, Refuge Pointe, Aerie Peak
					["0.41:0.93:0.41:0.73:0.47:0.59:0.48:0.39"] = 712, -- Booty Bay, Stormwind, Ironforge, Chillwind Camp
					["0.41:0.93:0.41:0.73:0.47:0.59:0.61:0.35"] = 777, -- Booty Bay, Stormwind, Ironforge, Light's Hope Chapel
					["0.41:0.93:0.41:0.73:0.47:0.59:0.61:0.35:0.61:0.28"] = 806, -- Booty Bay, Stormwind, Ironforge, Light's Hope Chapel, Zul'Aman
					["0.41:0.93:0.41:0.73:0.47:0.59:0.51:0.47"] = 562, -- Booty Bay, Stormwind, Ironforge, Refuge Pointe

					-- Alliance: Chillwind Camp (Western Plaguelands)
					["0.48:0.39:0.47:0.59:0.47:0.65:0.41:0.73:0.41:0.93"] = 662, -- Chillwind Camp, Ironforge, Thorium Point, Stormwind, Booty Bay
					["0.48:0.39:0.47:0.59:0.47:0.65:0.41:0.73:0.39:0.80"] = 495, -- Chillwind Camp, Ironforge, Thorium Point, Stormwind, Sentinel Hill
					["0.48:0.39:0.47:0.59:0.47:0.65:0.41:0.73:0.43:0.82"] = 497, -- Chillwind Camp, Ironforge, Thorium Point, Stormwind, Rebel Camp
					["0.48:0.39:0.47:0.59:0.47:0.65:0.52:0.72:0.50:0.75:0.47:0.79"] = 482, -- Chillwind Camp, Ironforge, Thorium Point, Morgan's Vigil, Lakeshire, Darkshire
					["0.48:0.39:0.47:0.59:0.47:0.65:0.52:0.72:0.55:0.81"] = 560, -- Chillwind Camp, Ironforge, Thorium Point, Morgan's Vigil, Nethergarde Keep
					["0.48:0.39:0.47:0.59:0.47:0.65:0.52:0.72:0.50:0.75"] = 423, -- Chillwind Camp, Ironforge, Thorium Point, Morgan's Vigil, Lakeshire
					["0.48:0.39:0.47:0.59:0.47:0.65:0.52:0.72"] = 395, -- Chillwind Camp, Ironforge, Thorium Point, Morgan's Vigil
					["0.48:0.39:0.47:0.59:0.47:0.65:0.41:0.73"] = 418, -- Chillwind Camp, Ironforge, Thorium Point, Stormwind
					["0.48:0.39:0.47:0.59:0.47:0.65"] = 309, -- Chillwind Camp, Ironforge, Thorium Point
					["0.48:0.39:0.50:0.42:0.51:0.47:0.53:0.61"] = 308, -- Chillwind Camp, Aerie Peak, Refuge Pointe, Thelsamar
					["0.48:0.39:0.47:0.59"] = 259, -- Chillwind Camp, Ironforge
					["0.48:0.39:0.44:0.45:0.45:0.56"] = 193, -- Chillwind Camp, Southshore, Menethil Harbor
					["0.48:0.39:0.50:0.42:0.51:0.47"] = 138, -- Chillwind Camp, Aerie Peak, Refuge Pointe
					["0.48:0.39:0.44:0.45"] = 86, -- Chillwind Camp, Southshore
					["0.48:0.39:0.50:0.42"] = 66, -- Chillwind Camp, Aerie Peak
					["0.48:0.39:0.61:0.35"] = 146, -- Chillwind Camp, Light's Hope Chapel

					-- Alliance: Darkshire (Duskwood)
					["0.47:0.79:0.41:0.93"] = 171, -- Darkshire, Booty Bay
					["0.47:0.79:0.43:0.82"] = 48, -- Darkshire, Rebel Camp
					["0.47:0.79:0.39:0.80"] = 93, -- Darkshire, Sentinel Hill
					["0.47:0.79:0.41:0.73"] = 88, -- Darkshire, Stormwind
					["0.47:0.79:0.50:0.75"] = 60, -- Darkshire, Lakeshire
					["0.47:0.79:0.55:0.81"] = 97, -- Darkshire, Nethergarde Keep
					["0.47:0.79:0.50:0.75:0.52:0.72"] = 120, -- Darkshire, Lakeshire, Morgan's Vigil
					["0.47:0.79:0.50:0.75:0.52:0.72:0.47:0.65:0.53:0.61"] = 270, -- Darkshire, Lakeshire, Morgan's Vigil, Thorium Point, Thelsamar
					["0.47:0.79:0.50:0.75:0.52:0.72:0.47:0.65"] = 188, -- Darkshire, Lakeshire, Morgan's Vigil, Thorium Point
					["0.47:0.79:0.50:0.75:0.52:0.72:0.47:0.65:0.47:0.59"] = 268, -- Darkshire, Lakeshire, Morgan's Vigil, Thorium Point, Ironforge
					["0.47:0.79:0.50:0.75:0.52:0.72:0.47:0.65:0.47:0.59:0.45:0.56"] = 417, -- Darkshire, Lakeshire, Morgan's Vigil, Thorium Point, Ironforge, Menethil Harbor
					["0.47:0.79:0.50:0.75:0.52:0.72:0.47:0.65:0.53:0.61:0.51:0.47"] = 432, -- Darkshire, Lakeshire, Morgan's Vigil, Thorium Point, Thelsamar, Refuge Pointe
					["0.47:0.79:0.50:0.75:0.52:0.72:0.47:0.65:0.47:0.59:0.44:0.45"] = 517, -- Darkshire, Lakeshire, Morgan's Vigil, Thorium Point, Ironforge, Southshore
					["0.47:0.79:0.50:0.75:0.52:0.72:0.47:0.65:0.53:0.61:0.51:0.47:0.50:0.42"] = 582, -- Darkshire, Lakeshire, Morgan's Vigil, Thorium Point, Thelsamar, Refuge Pointe, Aerie Peak
					["0.47:0.79:0.50:0.75:0.52:0.72:0.47:0.65:0.47:0.59:0.48:0.39"] = 534, -- Darkshire, Lakeshire, Morgan's Vigil, Thorium Point, Ironforge, Chillwind Camp
					["0.47:0.79:0.50:0.75:0.52:0.72:0.47:0.65:0.47:0.59:0.61:0.35"] = 642, -- Darkshire, Lakeshire, Morgan's Vigil, Thorium Point, Ironforge, Light's Hope Chapel
					["0.47:0.79:0.50:0.75:0.52:0.72:0.47:0.65:0.47:0.59:0.50:0.42:0.44:0.45"] = 548, -- Darkshire, Lakeshire, Morgan's Vigil, Thorium Point, Ironforge, Aerie Peak, Southshore
					["0.47:0.79:0.50:0.75:0.52:0.72:0.47:0.65:0.47:0.59:0.61:0.35:0.61:0.28"] = 674, -- Darkshire, Lakeshire, Morgan's Vigil, Thorium Point, Ironforge, Light's Hope Chapel, Zul'Aman
					["0.47:0.79:0.41:0.73:0.47:0.59:0.45:0.56"] = 360, -- Darkshire, Stormwind, Ironforge, Menethil Harbor

					-- Alliance: Ironforge (Dun Morogh)
					["0.47:0.59:0.47:0.65:0.41:0.73:0.41:0.93"] = 381, -- Ironforge, Thorium Point, Stormwind, Booty Bay
					["0.47:0.59:0.47:0.65:0.41:0.73:0.39:0.80"] = 260, -- Ironforge, Thorium Point, Stormwind, Sentinel Hill
					["0.47:0.59:0.47:0.65:0.41:0.73:0.43:0.82"] = 275, -- Ironforge, Thorium Point, Stormwind, Rebel Camp
					["0.47:0.59:0.47:0.65:0.52:0.72:0.50:0.75:0.47:0.79"] = 260, -- Ironforge, Thorium Point, Morgan's Vigil, Lakeshire, Darkshire
					["0.47:0.59:0.47:0.65:0.52:0.72:0.55:0.81"] = 338, -- Ironforge, Thorium Point, Morgan's Vigil, Nethergarde Keep
					["0.47:0.59:0.47:0.65:0.52:0.72:0.50:0.75"] = 201, -- Ironforge, Thorium Point, Morgan's Vigil, Lakeshire
					["0.47:0.59:0.47:0.65:0.52:0.72"] = 173, -- Ironforge, Thorium Point, Morgan's Vigil
					["0.47:0.59:0.41:0.73"] = 210, -- Ironforge, Stormwind
					["0.47:0.59:0.47:0.65"] = 87, -- Ironforge, Thorium Point
					["0.47:0.59:0.53:0.61"] = 101, -- Ironforge, Thelsamar
					["0.47:0.59:0.45:0.56"] = 115, -- Ironforge, Menethil Harbor
					["0.47:0.59:0.51:0.47"] = 204, -- Ironforge, Refuge Pointe
					["0.47:0.59:0.44:0.45"] = 216, -- Ironforge, Southshore
					["0.47:0.59:0.50:0.42"] = 240, -- Ironforge, Aerie Peak
					["0.47:0.59:0.48:0.39"] = 258, -- Ironforge, Chillwind Camp
					["0.47:0.59:0.61:0.35"] = 349, -- Ironforge, Light's Hope Chapel
					["0.47:0.59:0.61:0.35:0.61:0.28"] = 446, -- Ironforge, Light's Hope Chapel, Zul'Aman
					["0.47:0.59:0.41:0.73:0.43:0.82"] = 290, -- Ironforge, Stormwind, Rebel Camp
					["0.47:0.59:0.41:0.73:0.39:0.80"] = 274, -- Ironforge, Stormwind, Sentinel Hill
					["0.47:0.59:0.41:0.73:0.50:0.75"] = 309, -- Ironforge, Stormwind, Lakeshire
					["0.47:0.59:0.41:0.73:0.55:0.81"] = 373, -- Ironforge, Stormwind, Nethergarde Keep

					-- Alliance: Lakeshire (Redridge Mountains)
					["0.50:0.75:0.47:0.79:0.43:0.82:0.41:0.93"] = 227, -- Lakeshire, Darkshire, Rebel Camp, Booty Bay
					["0.50:0.75:0.47:0.79:0.55:0.81"] = 148, -- Lakeshire, Darkshire, Nethergarde Keep
					["0.50:0.75:0.47:0.79"] = 60, -- Lakeshire, Darkshire
					["0.50:0.75:0.47:0.79:0.43:0.82"] = 104, -- Lakeshire, Darkshire, Rebel Camp
					["0.50:0.75:0.39:0.80"] = 133, -- Lakeshire, Sentinel Hill
					["0.50:0.75:0.41:0.73"] = 113, -- Lakeshire, Stormwind
					["0.50:0.75:0.52:0.72"] = 61, -- Lakeshire, Morgan's Vigil
					["0.50:0.75:0.52:0.72:0.47:0.65"] = 129, -- Lakeshire, Morgan's Vigil, Thorium Point
					["0.50:0.75:0.52:0.72:0.47:0.65:0.53:0.61"] = 210, -- Lakeshire, Morgan's Vigil, Thorium Point, Thelsamar
					["0.50:0.75:0.52:0.72:0.47:0.65:0.47:0.59"] = 209, -- Lakeshire, Morgan's Vigil, Thorium Point, Ironforge
					["0.50:0.75:0.52:0.72:0.47:0.65:0.47:0.59:0.45:0.56"] = 278, -- Lakeshire, Morgan's Vigil, Thorium Point, Ironforge, Menethil Harbor
					["0.50:0.75:0.52:0.72:0.47:0.65:0.53:0.61:0.51:0.47"] = 374, -- Lakeshire, Morgan's Vigil, Thorium Point, Thelsamar, Refuge Pointe
					["0.50:0.75:0.52:0.72:0.47:0.65:0.47:0.59:0.44:0.45"] = 489, -- Lakeshire, Morgan's Vigil, Thorium Point, Ironforge, Southshore
					["0.50:0.75:0.52:0.72:0.47:0.65:0.53:0.61:0.51:0.47:0.50:0.42"] = 296, -- Lakeshire, Morgan's Vigil, Thorium Point, Thelsamar, Refuge Pointe, Aerie Peak
					["0.50:0.75:0.52:0.72:0.47:0.65:0.47:0.59:0.48:0.39"] = 475, -- Lakeshire, Morgan's Vigil, Thorium Point, Ironforge, Chillwind Camp
					["0.50:0.75:0.52:0.72:0.47:0.65:0.47:0.59:0.61:0.35"] = 540, -- Lakeshire, Morgan's Vigil, Thorium Point, Ironforge, Light's Hope Chapel
					["0.50:0.75:0.52:0.72:0.47:0.65:0.47:0.59:0.50:0.42:0.44:0.45"] = 489, -- Lakeshire, Morgan's Vigil, Thorium Point, Ironforge, Aerie Peak, Southshore
					["0.50:0.75:0.52:0.72:0.47:0.65:0.47:0.59:0.61:0.35:0.61:0.28"] = 614, -- Lakeshire, Morgan's Vigil, Thorium Point, Ironforge, Light's Hope Chapel, Zul'Aman
					["0.50:0.75:0.41:0.73:0.47:0.59"] = 315, -- Lakeshire, Stormwind, Ironforge
					["0.50:0.75:0.41:0.73:0.47:0.59:0.45:0.56"] = 385, -- Lakeshire, Stormwind, Ironforge, Menethil Harbor

					-- Alliance: Light's Hope Chapel (Eastern Plaguelands)
					["0.61:0.35:0.47:0.59:0.47:0.65:0.41:0.73:0.41:0.93"] = 712, -- Light's Hope Chapel, Ironforge, Thorium Point, Stormwind, Booty Bay
					["0.61:0.35:0.47:0.59:0.47:0.65:0.41:0.73:0.39:0.80"] = 590, -- Light's Hope Chapel, Ironforge, Thorium Point, Stormwind, Sentinel Hill
					["0.61:0.35:0.47:0.59:0.47:0.65:0.41:0.73:0.43:0.82"] = 606, -- Light's Hope Chapel, Ironforge, Thorium Point, Stormwind, Rebel Camp
					["0.61:0.35:0.47:0.59:0.47:0.65:0.52:0.72:0.50:0.75:0.47:0.79"] = 591, -- Light's Hope Chapel, Ironforge, Thorium Point, Morgan's Vigil, Lakeshire, Darkshire
					["0.61:0.35:0.47:0.59:0.47:0.65:0.52:0.72:0.55:0.81"] = 669, -- Light's Hope Chapel, Ironforge, Thorium Point, Morgan's Vigil, Nethergarde Keep
					["0.61:0.35:0.47:0.59:0.47:0.65:0.52:0.72:0.50:0.75"] = 532, -- Light's Hope Chapel, Ironforge, Thorium Point, Morgan's Vigil, Lakeshire
					["0.61:0.35:0.47:0.59:0.47:0.65:0.52:0.72"] = 503, -- Light's Hope Chapel, Ironforge, Thorium Point, Morgan's Vigil
					["0.61:0.35:0.47:0.59:0.47:0.65:0.41:0.73"] = 527, -- Light's Hope Chapel, Ironforge, Thorium Point, Stormwind
					["0.61:0.35:0.47:0.59:0.47:0.65"] = 417, -- Light's Hope Chapel, Ironforge, Thorium Point
					["0.61:0.35:0.50:0.42:0.51:0.47:0.53:0.61"] = 403, -- Light's Hope Chapel, Aerie Peak, Refuge Pointe, Thelsamar
					["0.61:0.35:0.47:0.59"] = 369, -- Light's Hope Chapel, Ironforge
					["0.61:0.35:0.50:0.42:0.44:0.45:0.45:0.56"] = 333, -- Light's Hope Chapel, Aerie Peak, Southshore, Menethil Harbor
					["0.61:0.35:0.50:0.42:0.51:0.47"] = 232, -- Light's Hope Chapel, Aerie Peak, Refuge Pointe
					["0.61:0.35:0.50:0.42:0.44:0.45"] = 225, -- Light's Hope Chapel, Aerie Peak, Southshore
					["0.61:0.35:0.50:0.42"] = 163, -- Light's Hope Chapel, Aerie Peak
					["0.61:0.35:0.48:0.39"] = 149, -- Light's Hope Chapel, Chillwind Camp
					["0.61:0.35:0.61:0.28"] = 104, -- Light's Hope Chapel, Zul'Aman

					-- Alliance: Menethil Harbor (Wetlands)
					["0.45:0.56:0.47:0.59:0.47:0.65:0.41:0.73:0.41:0.93"] = 429, -- Menethil Harbor, Ironforge, Thorium Point, Stormwind, Booty Bay
					["0.45:0.56:0.47:0.59:0.47:0.65:0.41:0.73:0.43:0.82"] = 323, -- Menethil Harbor, Ironforge, Thorium Point, Stormwind, Rebel Camp
					["0.45:0.56:0.47:0.59:0.47:0.65:0.41:0.73:0.39:0.80"] = 324, -- Menethil Harbor, Ironforge, Thorium Point, Stormwind, Sentinel Hill
					["0.45:0.56:0.47:0.59:0.47:0.65:0.41:0.73"] = 261, -- Menethil Harbor, Ironforge, Thorium Point, Stormwind
					["0.45:0.56:0.47:0.59:0.47:0.65:0.52:0.72:0.50:0.75:0.47:0.79"] = 309, -- Menethil Harbor, Ironforge, Thorium Point, Morgan's Vigil, Lakeshire, Darkshire
					["0.45:0.56:0.47:0.59:0.47:0.65:0.52:0.72:0.55:0.81"] = 386, -- Menethil Harbor, Ironforge, Thorium Point, Morgan's Vigil, Nethergarde Keep
					["0.45:0.56:0.47:0.59:0.47:0.65:0.52:0.72:0.50:0.75"] = 250, -- Menethil Harbor, Ironforge, Thorium Point, Morgan's Vigil, Lakeshire
					["0.45:0.56:0.47:0.59:0.47:0.65:0.52:0.72"] = 221, -- Menethil Harbor, Ironforge, Thorium Point, Morgan's Vigil
					["0.45:0.56:0.47:0.59:0.47:0.65"] = 135, -- Menethil Harbor, Ironforge, Thorium Point
					["0.45:0.56:0.53:0.61"] = 163, -- Menethil Harbor, Thelsamar
					["0.45:0.56:0.47:0.59"] = 89, -- Menethil Harbor, Ironforge
					["0.45:0.56:0.51:0.47"] = 114, -- Menethil Harbor, Refuge Pointe
					["0.45:0.56:0.44:0.45"] = 107, -- Menethil Harbor, Southshore
					["0.45:0.56:0.44:0.45:0.50:0.42"] = 176, -- Menethil Harbor, Southshore, Aerie Peak
					["0.45:0.56:0.44:0.45:0.48:0.39"] = 186, -- Menethil Harbor, Southshore, Chillwind Camp
					["0.45:0.56:0.44:0.45:0.48:0.39:0.61:0.35"] = 324, -- Menethil Harbor, Southshore, Chillwind Camp, Light's Hope Chapel
					["0.45:0.56:0.47:0.59:0.41:0.73:0.41:0.93"] = 445, -- Menethil Harbor, Ironforge, Stormwind, Booty Bay
					["0.45:0.56:0.47:0.59:0.41:0.73"] = 260, -- Menethil Harbor, Ironforge, Stormwind
					["0.45:0.56:0.47:0.59:0.47:0.65:0.41:0.73:0.55:0.81"] = 407, -- Menethil Harbor, Ironforge, Thorium Point, Stormwind, Nethergarde Keep

					-- Alliance: Morgan's Vigil (Burning Steppes)
					["0.52:0.72:0.50:0.75:0.47:0.79:0.43:0.82:0.41:0.93"] = 278, -- Morgan's Vigil, Lakeshire, Darkshire, Rebel Camp, Booty Bay
					["0.52:0.72:0.50:0.75:0.47:0.79:0.43:0.82"] = 165, -- Morgan's Vigil, Lakeshire, Darkshire, Rebel Camp
					["0.52:0.72:0.50:0.75:0.39:0.80"] = 195, -- Morgan's Vigil, Lakeshire, Sentinel Hill
					["0.52:0.72:0.41:0.73"] = 151, -- Morgan's Vigil, Stormwind
					["0.52:0.72:0.50:0.75:0.47:0.79"] = 121, -- Morgan's Vigil, Lakeshire, Darkshire
					["0.52:0.72:0.55:0.81"] = 198, -- Morgan's Vigil, Nethergarde Keep
					["0.52:0.72:0.50:0.75"] = 64, -- Morgan's Vigil, Lakeshire
					["0.52:0.72:0.47:0.65:0.53:0.61"] = 172, -- Morgan's Vigil, Thorium Point, Thelsamar
					["0.52:0.72:0.47:0.65"] = 91, -- Morgan's Vigil, Thorium Point
					["0.52:0.72:0.47:0.65:0.47:0.59"] = 187, -- Morgan's Vigil, Thorium Point, Ironforge
					["0.52:0.72:0.47:0.65:0.47:0.59:0.45:0.56"] = 240, -- Morgan's Vigil, Thorium Point, Ironforge, Menethil Harbor
					["0.52:0.72:0.47:0.65:0.53:0.61:0.51:0.47"] = 335, -- Morgan's Vigil, Thorium Point, Thelsamar, Refuge Pointe
					["0.52:0.72:0.47:0.65:0.47:0.59:0.44:0.45"] = 342, -- Morgan's Vigil, Thorium Point, Ironforge, Southshore
					["0.52:0.72:0.47:0.65:0.53:0.61:0.51:0.47:0.50:0.42"] = 436, -- Morgan's Vigil, Thorium Point, Thelsamar, Refuge Pointe, Aerie Peak
					["0.52:0.72:0.47:0.65:0.47:0.59:0.48:0.39"] = 435, -- Morgan's Vigil, Thorium Point, Ironforge, Chillwind Camp
					["0.52:0.72:0.47:0.65:0.47:0.59:0.61:0.35"] = 491, -- Morgan's Vigil, Thorium Point, Ironforge, Light's Hope Chapel
					["0.52:0.72:0.47:0.65:0.47:0.59:0.50:0.42:0.48:0.39"] = 437, -- Morgan's Vigil, Thorium Point, Ironforge, Aerie Peak, Chillwind Camp

					-- Alliance: Nethergarde Keep (Blasted Lands)
					["0.55:0.81:0.47:0.79:0.43:0.82:0.41:0.93"] = 251, -- Nethergarde Keep, Darkshire, Rebel Camp, Booty Bay
					["0.55:0.81:0.47:0.79:0.43:0.82"] = 138, -- Nethergarde Keep, Darkshire, Rebel Camp
					["0.55:0.81:0.47:0.79:0.39:0.80"] = 183, -- Nethergarde Keep, Darkshire, Sentinel Hill
					["0.55:0.81:0.41:0.73"] = 189, -- Nethergarde Keep, Stormwind
					["0.55:0.81:0.47:0.79"] = 91, -- Nethergarde Keep, Darkshire
					["0.55:0.81:0.47:0.79:0.50:0.75"] = 150, -- Nethergarde Keep, Darkshire, Lakeshire
					["0.55:0.81:0.52:0.72"] = 207, -- Nethergarde Keep, Morgan's Vigil
					["0.55:0.81:0.52:0.72:0.47:0.65:0.53:0.61"] = 359, -- Nethergarde Keep, Morgan's Vigil, Thorium Point, Thelsamar
					["0.55:0.81:0.52:0.72:0.47:0.65"] = 278, -- Nethergarde Keep, Morgan's Vigil, Thorium Point
					["0.55:0.81:0.52:0.72:0.47:0.65:0.47:0.59"] = 382, -- Nethergarde Keep, Morgan's Vigil, Thorium Point, Ironforge
					["0.55:0.81:0.52:0.72:0.47:0.65:0.47:0.59:0.45:0.56"] = 426, -- Nethergarde Keep, Morgan's Vigil, Thorium Point, Ironforge, Menethil Harbor
					["0.55:0.81:0.52:0.72:0.47:0.65:0.53:0.61:0.51:0.47"] = 522, -- Nethergarde Keep, Morgan's Vigil, Thorium Point, Thelsamar, Refuge Pointe
					["0.55:0.81:0.52:0.72:0.47:0.65:0.47:0.59:0.44:0.45"] = 638, -- Nethergarde Keep, Morgan's Vigil, Thorium Point, Ironforge, Southshore
					["0.55:0.81:0.52:0.72:0.47:0.65:0.53:0.61:0.51:0.47:0.50:0.42"] = 444, -- Nethergarde Keep, Morgan's Vigil, Thorium Point, Thelsamar, Refuge Pointe, Aerie Peak
					["0.55:0.81:0.52:0.72:0.47:0.65:0.47:0.59:0.48:0.39"] = 631, -- Nethergarde Keep, Morgan's Vigil, Thorium Point, Ironforge, Chillwind Camp
					["0.55:0.81:0.52:0.72:0.47:0.65:0.47:0.59:0.61:0.35"] = 687, -- Nethergarde Keep, Morgan's Vigil, Thorium Point, Ironforge, Light's Hope Chapel
					["0.55:0.81:0.52:0.72:0.47:0.65:0.47:0.59:0.61:0.35:0.61:0.28"] = 763, -- Nethergarde Keep, Morgan's Vigil, Thorium Point, Ironforge, Light's Hope Chapel, Zul'Aman
					["0.55:0.81:0.47:0.79:0.41:0.93"] = 262, -- Nethergarde Keep, Darkshire, Booty Bay

					-- Alliance: Rebel Camp (Stranglethorn Vale)
					["0.43:0.82:0.41:0.93"] = 116, -- Rebel Camp, Booty Bay
					["0.43:0.82:0.39:0.80"] = 66, -- Rebel Camp, Sentinel Hill
					["0.43:0.82:0.41:0.73"] = 98, -- Rebel Camp, Stormwind
					["0.43:0.82:0.47:0.79:0.55:0.81"] = 139, -- Rebel Camp, Darkshire, Nethergarde Keep
					["0.43:0.82:0.47:0.79"] = 48, -- Rebel Camp, Darkshire
					["0.43:0.82:0.47:0.79:0.50:0.75"] = 102, -- Rebel Camp, Darkshire, Lakeshire
					["0.43:0.82:0.47:0.79:0.50:0.75:0.52:0.72"] = 163, -- Rebel Camp, Darkshire, Lakeshire, Morgan's Vigil
					["0.43:0.82:0.41:0.73:0.47:0.65"] = 218, -- Rebel Camp, Stormwind, Thorium Point
					["0.43:0.82:0.41:0.73:0.47:0.65:0.53:0.61"] = 296, -- Rebel Camp, Stormwind, Thorium Point, Thelsamar
					["0.43:0.82:0.41:0.73:0.47:0.59"] = 300, -- Rebel Camp, Stormwind, Ironforge
					["0.43:0.82:0.41:0.73:0.47:0.59:0.45:0.56"] = 370, -- Rebel Camp, Stormwind, Ironforge, Menethil Harbor
					["0.43:0.82:0.41:0.73:0.47:0.65:0.53:0.61:0.51:0.47"] = 459, -- Rebel Camp, Stormwind, Thorium Point, Thelsamar, Refuge Pointe
					["0.43:0.82:0.41:0.73:0.47:0.59:0.44:0.45"] = 581, -- Rebel Camp, Stormwind, Ironforge, Southshore
					["0.43:0.82:0.41:0.73:0.47:0.65:0.53:0.61:0.51:0.47:0.50:0.42"] = 388, -- Rebel Camp, Stormwind, Thorium Point, Thelsamar, Refuge Pointe, Aerie Peak
					["0.43:0.82:0.41:0.73:0.47:0.59:0.48:0.39"] = 567, -- Rebel Camp, Stormwind, Ironforge, Chillwind Camp
					["0.43:0.82:0.41:0.73:0.47:0.59:0.61:0.35"] = 676, -- Rebel Camp, Stormwind, Ironforge, Light's Hope Chapel
					["0.43:0.82:0.41:0.73:0.47:0.59:0.61:0.35:0.61:0.28"] = 704, -- Rebel Camp, Stormwind, Ironforge, Light's Hope Chapel, Zul'Aman

					-- Alliance: Refuge Pointe (Arathi Highlands)
					["0.51:0.47:0.53:0.61:0.47:0.65:0.41:0.73:0.41:0.93"] = 558, -- Refuge Pointe, Thelsamar, Thorium Point, Stormwind, Booty Bay
					["0.51:0.47:0.53:0.61:0.47:0.65:0.41:0.73:0.39:0.80"] = 436, -- Refuge Pointe, Thelsamar, Thorium Point, Stormwind, Sentinel Hill
					["0.51:0.47:0.53:0.61:0.47:0.65:0.41:0.73:0.43:0.82"] = 452, -- Refuge Pointe, Thelsamar, Thorium Point, Stormwind, Rebel Camp
					["0.51:0.47:0.53:0.61:0.47:0.65:0.52:0.72:0.50:0.75:0.47:0.79"] = 429, -- Refuge Pointe, Thelsamar, Thorium Point, Morgan's Vigil, Lakeshire, Darkshire
					["0.51:0.47:0.53:0.61:0.47:0.65:0.52:0.72:0.55:0.81"] = 509, -- Refuge Pointe, Thelsamar, Thorium Point, Morgan's Vigil, Nethergarde Keep
					["0.51:0.47:0.53:0.61:0.47:0.65:0.52:0.72:0.50:0.75"] = 371, -- Refuge Pointe, Thelsamar, Thorium Point, Morgan's Vigil, Lakeshire
					["0.51:0.47:0.53:0.61:0.47:0.65:0.52:0.72"] = 339, -- Refuge Pointe, Thelsamar, Thorium Point, Morgan's Vigil
					["0.51:0.47:0.53:0.61:0.47:0.65:0.41:0.73"] = 373, -- Refuge Pointe, Thelsamar, Thorium Point, Stormwind
					["0.51:0.47:0.53:0.61:0.47:0.65"] = 249, -- Refuge Pointe, Thelsamar, Thorium Point
					["0.51:0.47:0.53:0.61"] = 171, -- Refuge Pointe, Thelsamar
					["0.51:0.47:0.47:0.59"] = 270, -- Refuge Pointe, Ironforge
					["0.51:0.47:0.45:0.56"] = 126, -- Refuge Pointe, Menethil Harbor
					["0.51:0.47:0.44:0.45"] = 87, -- Refuge Pointe, Southshore
					["0.51:0.47:0.50:0.42"] = 72, -- Refuge Pointe, Aerie Peak
					["0.51:0.47:0.50:0.42:0.48:0.39"] = 123, -- Refuge Pointe, Aerie Peak, Chillwind Camp
					["0.51:0.47:0.50:0.42:0.61:0.35"] = 233, -- Refuge Pointe, Aerie Peak, Light's Hope Chapel
					["0.51:0.47:0.45:0.56:0.47:0.59:0.41:0.73:0.41:0.93"] = 570, -- Refuge Pointe, Menethil Harbor, Ironforge, Stormwind, Booty Bay

					-- Alliance: Sentinel Hill (Westfall)
					["0.39:0.80:0.41:0.93"] = 185, -- Sentinel Hill, Booty Bay
					["0.39:0.80:0.43:0.82"] = 62, -- Sentinel Hill, Rebel Camp
					["0.39:0.80:0.47:0.79:0.55:0.81"] = 186, -- Sentinel Hill, Darkshire, Nethergarde Keep
					["0.39:0.80:0.47:0.79"] = 97, -- Sentinel Hill, Darkshire
					["0.39:0.80:0.50:0.75"] = 130, -- Sentinel Hill, Lakeshire
					["0.39:0.80:0.50:0.75:0.52:0.72"] = 190, -- Sentinel Hill, Lakeshire, Morgan's Vigil
					["0.39:0.80:0.41:0.73"] = 86, -- Sentinel Hill, Stormwind
					["0.39:0.80:0.41:0.73:0.47:0.65"] = 205, -- Sentinel Hill, Stormwind, Thorium Point
					["0.39:0.80:0.41:0.73:0.47:0.65:0.53:0.61"] = 284, -- Sentinel Hill, Stormwind, Thorium Point, Thelsamar
					["0.39:0.80:0.41:0.73:0.47:0.59"] = 288, -- Sentinel Hill, Stormwind, Ironforge
					["0.39:0.80:0.41:0.73:0.47:0.59:0.45:0.56"] = 414, -- Sentinel Hill, Stormwind, Ironforge, Menethil Harbor
					["0.39:0.80:0.41:0.73:0.47:0.65:0.53:0.61:0.51:0.47"] = 447, -- Sentinel Hill, Stormwind, Thorium Point, Thelsamar, Refuge Pointe
					["0.39:0.80:0.41:0.73:0.47:0.59:0.44:0.45"] = 569, -- Sentinel Hill, Stormwind, Ironforge, Southshore
					["0.39:0.80:0.41:0.73:0.47:0.65:0.53:0.61:0.51:0.47:0.50:0.42"] = 376, -- Sentinel Hill, Stormwind, Thorium Point, Thelsamar, Refuge Pointe, Aerie Peak
					["0.39:0.80:0.41:0.73:0.47:0.59:0.48:0.39"] = 555, -- Sentinel Hill, Stormwind, Ironforge, Chillwind Camp
					["0.39:0.80:0.41:0.73:0.47:0.59:0.61:0.35"] = 664, -- Sentinel Hill, Stormwind, Ironforge, Light's Hope Chapel
					["0.39:0.80:0.41:0.73:0.47:0.59:0.53:0.61"] = 346, -- Sentinel Hill, Stormwind, Ironforge, Thelsamar
					["0.39:0.80:0.41:0.73:0.47:0.59:0.61:0.35:0.61:0.28"] = 693, -- Sentinel Hill, Stormwind, Ironforge, Light's Hope Chapel, Zul'Aman

					-- Alliance: Southshore (Hillsbrad Foothills)
					["0.44:0.45:0.45:0.56:0.47:0.59:0.47:0.65:0.41:0.73:0.41:0.93"] = 597, -- Southshore, Menethil Harbor, Ironforge, Thorium Point, Stormwind, Booty Bay
					["0.44:0.45:0.45:0.56:0.47:0.59:0.47:0.65:0.41:0.73:0.39:0.80"] = 430, -- Southshore, Menethil Harbor, Ironforge, Thorium Point, Stormwind, Sentinel Hill
					["0.44:0.45:0.45:0.56:0.47:0.59:0.47:0.65:0.41:0.73:0.43:0.82"] = 433, -- Southshore, Menethil Harbor, Ironforge, Thorium Point, Stormwind, Rebel Camp
					["0.44:0.45:0.45:0.56:0.47:0.59:0.47:0.65:0.52:0.72:0.50:0.75:0.47:0.79"] = 417, -- Southshore, Menethil Harbor, Ironforge, Thorium Point, Morgan's Vigil, Lakeshire, Darkshire
					["0.44:0.45:0.45:0.56:0.47:0.59:0.47:0.65:0.52:0.72:0.55:0.81"] = 496, -- Southshore, Menethil Harbor, Ironforge, Thorium Point, Morgan's Vigil, Nethergarde Keep
					["0.44:0.45:0.45:0.56:0.47:0.59:0.47:0.65:0.52:0.72:0.50:0.75"] = 359, -- Southshore, Menethil Harbor, Ironforge, Thorium Point, Morgan's Vigil, Lakeshire
					["0.44:0.45:0.45:0.56:0.47:0.59:0.47:0.65:0.52:0.72"] = 327, -- Southshore, Menethil Harbor, Ironforge, Thorium Point, Morgan's Vigil
					["0.44:0.45:0.45:0.56:0.47:0.59:0.47:0.65:0.41:0.73"] = 354, -- Southshore, Menethil Harbor, Ironforge, Thorium Point, Stormwind
					["0.44:0.45:0.45:0.56:0.47:0.59:0.47:0.65"] = 243, -- Southshore, Menethil Harbor, Ironforge, Thorium Point
					["0.44:0.45:0.51:0.47:0.53:0.61"] = 244, -- Southshore, Refuge Pointe, Thelsamar
					["0.44:0.45:0.47:0.59"] = 207, -- Southshore, Ironforge
					["0.44:0.45:0.45:0.56"] = 110, -- Southshore, Menethil Harbor
					["0.44:0.45:0.51:0.47"] = 74, -- Southshore, Refuge Pointe
					["0.44:0.45:0.50:0.42"] = 71, -- Southshore, Aerie Peak
					["0.44:0.45:0.48:0.39"] = 81, -- Southshore, Chillwind Camp
					["0.44:0.45:0.48:0.39:0.61:0.35"] = 219, -- Southshore, Chillwind Camp, Light's Hope Chapel
					["0.44:0.45:0.45:0.56:0.47:0.59:0.41:0.73"] = 370, -- Southshore, Menethil Harbor, Ironforge, Stormwind
					["0.44:0.45:0.45:0.56:0.47:0.59:0.47:0.65:0.41:0.73:0.55:0.81"] = 517, -- Southshore, Menethil Harbor, Ironforge, Thorium Point, Stormwind, Nethergarde Keep

					-- Alliance: Stormwind (Elwynn Forest)
					["0.41:0.73:0.41:0.93"] = 200, -- Stormwind, Booty Bay
					["0.41:0.73:0.55:0.81"] = 176, -- Stormwind, Nethergarde Keep
					["0.41:0.73:0.43:0.82"] = 93, -- Stormwind, Rebel Camp
					["0.41:0.73:0.39:0.80"] = 78, -- Stormwind, Sentinel Hill
					["0.41:0.73:0.47:0.79"] = 116, -- Stormwind, Darkshire
					["0.41:0.73:0.50:0.75"] = 113, -- Stormwind, Lakeshire
					["0.41:0.73:0.52:0.72"] = 157, -- Stormwind, Morgan's Vigil
					["0.41:0.73:0.47:0.65"] = 133, -- Stormwind, Thorium Point
					["0.41:0.73:0.47:0.65:0.53:0.61"] = 212, -- Stormwind, Thorium Point, Thelsamar
					["0.41:0.73:0.47:0.59"] = 216, -- Stormwind, Ironforge
					["0.41:0.73:0.47:0.59:0.45:0.56"] = 286, -- Stormwind, Ironforge, Menethil Harbor
					["0.41:0.73:0.47:0.65:0.53:0.61:0.51:0.47"] = 375, -- Stormwind, Thorium Point, Thelsamar, Refuge Pointe
					["0.41:0.73:0.47:0.59:0.44:0.45"] = 387, -- Stormwind, Ironforge, Southshore
					["0.41:0.73:0.47:0.65:0.53:0.61:0.51:0.47:0.50:0.42"] = 446, -- Stormwind, Thorium Point, Thelsamar, Refuge Pointe, Aerie Peak
					["0.41:0.73:0.47:0.59:0.48:0.39"] = 429, -- Stormwind, Ironforge, Chillwind Camp
					["0.41:0.73:0.47:0.59:0.61:0.35"] = 523, -- Stormwind, Ironforge, Light's Hope Chapel
					["0.41:0.73:0.47:0.59:0.61:0.35:0.61:0.28"] = 621, -- Stormwind, Ironforge, Light's Hope Chapel, Zul'Aman
					["0.41:0.73:0.47:0.59:0.53:0.61"] = 274, -- Stormwind, Ironforge, Thelsamar
					["0.41:0.73:0.47:0.59:0.51:0.47"] = 377, -- Stormwind, Ironforge, Refuge Pointe
					["0.41:0.73:0.47:0.59:0.50:0.42:0.44:0.45"] = 497, -- Stormwind, Ironforge, Aerie Peak, Southshore
					["0.41:0.73:0.47:0.59:0.50:0.42"] = 304, -- Stormwind, Ironforge, Aerie Peak
					["0.41:0.73:0.47:0.59:0.50:0.42:0.48:0.39"] = 484, -- Stormwind, Ironforge, Aerie Peak, Chillwind Camp

					-- Alliance: Thelsamar (Loch Modan)
					["0.53:0.61:0.47:0.65:0.41:0.73:0.41:0.93"] = 390, -- Thelsamar, Thorium Point, Stormwind, Booty Bay
					["0.53:0.61:0.47:0.65:0.41:0.73:0.43:0.82"] = 284, -- Thelsamar, Thorium Point, Stormwind, Rebel Camp
					["0.53:0.61:0.47:0.65:0.41:0.73:0.39:0.80"] = 269, -- Thelsamar, Thorium Point, Stormwind, Sentinel Hill
					["0.53:0.61:0.47:0.65:0.41:0.73"] = 206, -- Thelsamar, Thorium Point, Stormwind
					["0.53:0.61:0.47:0.65:0.52:0.72:0.50:0.75:0.47:0.79"] = 262, -- Thelsamar, Thorium Point, Morgan's Vigil, Lakeshire, Darkshire
					["0.53:0.61:0.47:0.65:0.52:0.72:0.55:0.81"] = 341, -- Thelsamar, Thorium Point, Morgan's Vigil, Nethergarde Keep
					["0.53:0.61:0.47:0.65:0.52:0.72:0.50:0.75"] = 204, -- Thelsamar, Thorium Point, Morgan's Vigil, Lakeshire
					["0.53:0.61:0.47:0.65:0.52:0.72"] = 172, -- Thelsamar, Thorium Point, Morgan's Vigil
					["0.53:0.61:0.47:0.65"] = 82, -- Thelsamar, Thorium Point
					["0.53:0.61:0.47:0.59"] = 109, -- Thelsamar, Ironforge
					["0.53:0.61:0.45:0.56"] = 153, -- Thelsamar, Menethil Harbor
					["0.53:0.61:0.51:0.47"] = 164, -- Thelsamar, Refuge Pointe
					["0.53:0.61:0.51:0.47:0.44:0.45"] = 250, -- Thelsamar, Refuge Pointe, Southshore
					["0.53:0.61:0.51:0.47:0.50:0.42"] = 235, -- Thelsamar, Refuge Pointe, Aerie Peak
					["0.53:0.61:0.51:0.47:0.50:0.42:0.48:0.39"] = 285, -- Thelsamar, Refuge Pointe, Aerie Peak, Chillwind Camp
					["0.53:0.61:0.51:0.47:0.50:0.42:0.61:0.35"] = 396, -- Thelsamar, Refuge Pointe, Aerie Peak, Light's Hope Chapel
					["0.53:0.61:0.47:0.59:0.41:0.73:0.39:0.80"] = 340, -- Thelsamar, Ironforge, Stormwind, Sentinel Hill
					["0.53:0.61:0.47:0.59:0.41:0.73"] = 277, -- Thelsamar, Ironforge, Stormwind
					["0.53:0.61:0.51:0.47:0.50:0.42:0.61:0.35:0.61:0.28"] = 495, -- Thelsamar, Refuge Pointe, Aerie Peak, Light's Hope Chapel, Zul'Aman

					-- Alliance: Thorium Point (Searing Gorge)
					["0.47:0.65:0.41:0.73:0.41:0.93"] = 310, -- Thorium Point, Stormwind, Booty Bay
					["0.47:0.65:0.41:0.73:0.43:0.82"] = 206, -- Thorium Point, Stormwind, Rebel Camp
					["0.47:0.65:0.41:0.73:0.39:0.80"] = 190, -- Thorium Point, Stormwind, Sentinel Hill
					["0.47:0.65:0.41:0.73"] = 126, -- Thorium Point, Stormwind
					["0.47:0.65:0.52:0.72:0.50:0.75:0.47:0.79"] = 181, -- Thorium Point, Morgan's Vigil, Lakeshire, Darkshire
					["0.47:0.65:0.52:0.72:0.55:0.81"] = 260, -- Thorium Point, Morgan's Vigil, Nethergarde Keep
					["0.47:0.65:0.52:0.72:0.50:0.75"] = 122, -- Thorium Point, Morgan's Vigil, Lakeshire
					["0.47:0.65:0.52:0.72"] = 90, -- Thorium Point, Morgan's Vigil
					["0.47:0.65:0.53:0.61"] = 88, -- Thorium Point, Thelsamar
					["0.47:0.65:0.47:0.59"] = 94, -- Thorium Point, Ironforge
					["0.47:0.65:0.47:0.59:0.45:0.56"] = 178, -- Thorium Point, Ironforge, Menethil Harbor
					["0.47:0.65:0.53:0.61:0.51:0.47"] = 251, -- Thorium Point, Thelsamar, Refuge Pointe
					["0.47:0.65:0.47:0.59:0.44:0.45"] = 370, -- Thorium Point, Ironforge, Southshore
					["0.47:0.65:0.53:0.61:0.51:0.47:0.50:0.42"] = 177, -- Thorium Point, Thelsamar, Refuge Pointe, Aerie Peak
					["0.47:0.65:0.47:0.59:0.48:0.39"] = 342, -- Thorium Point, Ironforge, Chillwind Camp
					["0.47:0.65:0.47:0.59:0.61:0.35"] = 398, -- Thorium Point, Ironforge, Light's Hope Chapel
					["0.47:0.65:0.47:0.59:0.61:0.35:0.61:0.28"] = 495, -- Thorium Point, Ironforge, Light's Hope Chapel, Zul'Aman

					-- Alliance: Zul'Aman (Ghostlands) (drop-off only)
		
				},

				-- Alliance: Kalimdor
				[1414] = {

					-- Alliance: Blood Watch (Bloodmyst Isle)
					["0.22:0.18:0.21:0.26"] = 77, -- Blood Watch, The Exodar

					-- Alliance: The Exodar (The Exodar)
					["0.21:0.26:0.22:0.18"] = 77, -- The Exodar, Blood Watch

					-- Alliance: Astranaar (Ashenvale)
					["0.46:0.40:0.39:0.40:0.40:0.51:0.31:0.69"] = 511, -- Astranaar, Stonetalon Peak, Nijel's Point, Feathermoon
					["0.46:0.40:0.61:0.55:0.60:0.81:0.42:0.79"] = 631, -- Astranaar, Ratchet, Gadgetzan, Cenarion Hold
					["0.46:0.40:0.61:0.55:0.60:0.81:0.50:0.76"] = 538, -- Astranaar, Ratchet, Gadgetzan, Marshal's Refuge
					["0.46:0.40:0.61:0.55:0.64:0.67:0.48:0.70"] = 457, -- Astranaar, Ratchet, Theramore, Thalanaar
					["0.46:0.40:0.61:0.55:0.64:0.67:0.58:0.70"] = 357, -- Astranaar, Ratchet, Theramore, Mudsprocket
					["0.46:0.40:0.64:0.67"] = 388, -- Astranaar, Theramore
					["0.46:0.40:0.61:0.55:0.60:0.81"] = 434, -- Astranaar, Ratchet, Gadgetzan
					["0.46:0.40:0.61:0.55"] = 194, -- Astranaar, Ratchet
					["0.46:0.40:0.39:0.40:0.40:0.51"] = 279, -- Astranaar, Stonetalon Peak, Nijel's Point
					["0.46:0.40:0.39:0.40"] = 153, -- Astranaar, Stonetalon Peak
					["0.46:0.40:0.61:0.40"] = 148, -- Astranaar, Talrendis Point
					["0.46:0.40:0.58:0.39"] = 134, -- Astranaar, Forest Song
					["0.46:0.40:0.50:0.35"] = 79, -- Astranaar, Emerald Sanctuary
					["0.46:0.40:0.50:0.35:0.53:0.26:0.65:0.23"] = 296, -- Astranaar, Emerald Sanctuary, Talonbranch Glade, Everlook
					["0.46:0.40:0.50:0.35:0.53:0.26"] = 206, -- Astranaar, Emerald Sanctuary, Talonbranch Glade
					["0.46:0.40:0.50:0.35:0.53:0.26:0.55:0.21"] = 265, -- Astranaar, Emerald Sanctuary, Talonbranch Glade, Moonglade
					["0.46:0.40:0.43:0.25"] = 149, -- Astranaar, Auberdine
					["0.46:0.40:0.43:0.25:0.42:0.16"] = 233, -- Astranaar, Auberdine, Rut'theran Village

					-- Alliance: Auberdine (Darkshore)
					["0.43:0.25:0.31:0.69"] = 473, -- Auberdine, Feathermoon
					["0.43:0.25:0.31:0.69:0.42:0.79"] = 623, -- Auberdine, Feathermoon, Cenarion Hold
					["0.43:0.25:0.64:0.67:0.60:0.81:0.50:0.76"] = 700, -- Auberdine, Theramore, Gadgetzan, Marshal's Refuge
					["0.43:0.25:0.64:0.67:0.48:0.70"] = 602, -- Auberdine, Theramore, Thalanaar
					["0.43:0.25:0.64:0.67:0.58:0.70"] = 503, -- Auberdine, Theramore, Mudsprocket
					["0.43:0.25:0.64:0.67"] = 443, -- Auberdine, Theramore
					["0.43:0.25:0.64:0.67:0.60:0.81"] = 596, -- Auberdine, Theramore, Gadgetzan
					["0.43:0.25:0.46:0.40:0.61:0.55"] = 361, -- Auberdine, Astranaar, Ratchet
					["0.43:0.25:0.40:0.51"] = 291, -- Auberdine, Nijel's Point
					["0.43:0.25:0.39:0.40"] = 181, -- Auberdine, Stonetalon Peak
					["0.43:0.25:0.46:0.40"] = 168, -- Auberdine, Astranaar
					["0.43:0.25:0.46:0.40:0.50:0.35"] = 246, -- Auberdine, Astranaar, Emerald Sanctuary
					["0.43:0.25:0.46:0.40:0.58:0.39"] = 302, -- Auberdine, Astranaar, Forest Song
					["0.43:0.25:0.61:0.40"] = 300, -- Auberdine, Talrendis Point
					["0.43:0.25:0.55:0.21:0.65:0.23"] = 270, -- Auberdine, Moonglade, Everlook
					["0.43:0.25:0.53:0.26"] = 190, -- Auberdine, Talonbranch Glade
					["0.43:0.25:0.55:0.21"] = 151, -- Auberdine, Moonglade
					["0.43:0.25:0.42:0.16"] = 84, -- Auberdine, Rut'theran Village
					["0.43:0.25:0.53:0.26:0.65:0.23"] = 279, -- Auberdine, Talonbranch Glade, Everlook

					-- Alliance: Cenarion Hold (Silithus)
					["0.42:0.79:0.31:0.69"] = 175, -- Cenarion Hold, Feathermoon
					["0.42:0.79:0.31:0.69:0.48:0.70"] = 329, -- Cenarion Hold, Feathermoon, Thalanaar
					["0.42:0.79:0.50:0.76"] = 92, -- Cenarion Hold, Marshal's Refuge
					["0.42:0.79:0.60:0.81"] = 189, -- Cenarion Hold, Gadgetzan
					["0.42:0.79:0.60:0.81:0.64:0.67:0.58:0.70"] = 399, -- Cenarion Hold, Gadgetzan, Theramore, Mudsprocket
					["0.42:0.79:0.60:0.81:0.64:0.67"] = 342, -- Cenarion Hold, Gadgetzan, Theramore
					["0.42:0.79:0.60:0.81:0.61:0.55"] = 435, -- Cenarion Hold, Gadgetzan, Ratchet
					["0.42:0.79:0.31:0.69:0.40:0.51"] = 402, -- Cenarion Hold, Feathermoon, Nijel's Point
					["0.42:0.79:0.31:0.69:0.40:0.51:0.39:0.40"] = 521, -- Cenarion Hold, Feathermoon, Nijel's Point, Stonetalon Peak
					["0.42:0.79:0.60:0.81:0.61:0.55:0.46:0.40"] = 630, -- Cenarion Hold, Gadgetzan, Ratchet, Astranaar
					["0.42:0.79:0.60:0.81:0.61:0.55:0.61:0.40:0.58:0.39:0.50:0.35"] = 694, -- Cenarion Hold, Gadgetzan, Ratchet, Talrendis Point, Forest Song, Emerald Sanctuary
					["0.42:0.79:0.60:0.81:0.61:0.55:0.61:0.40:0.58:0.39"] = 587, -- Cenarion Hold, Gadgetzan, Ratchet, Talrendis Point, Forest Song
					["0.42:0.79:0.60:0.81:0.61:0.55:0.61:0.40"] = 562, -- Cenarion Hold, Gadgetzan, Ratchet, Talrendis Point
					["0.42:0.79:0.60:0.81:0.61:0.55:0.61:0.40:0.65:0.23"] = 740, -- Cenarion Hold, Gadgetzan, Ratchet, Talrendis Point, Everlook
					["0.42:0.79:0.60:0.81:0.61:0.55:0.61:0.40:0.58:0.39:0.50:0.35:0.53:0.26"] = 821, -- Cenarion Hold, Gadgetzan, Ratchet, Talrendis Point, Forest Song, Emerald Sanctuary, Talonbranch Glade
					["0.42:0.79:0.31:0.69:0.43:0.25:0.55:0.21"] = 793, -- Cenarion Hold, Feathermoon, Auberdine, Moonglade
					["0.42:0.79:0.31:0.69:0.43:0.25"] = 642, -- Cenarion Hold, Feathermoon, Auberdine
					["0.42:0.79:0.31:0.69:0.43:0.25:0.42:0.16"] = 726, -- Cenarion Hold, Feathermoon, Auberdine, Rut'theran Village

					-- Alliance: Emerald Sanctuary (Felwood)
					["0.50:0.35:0.46:0.40:0.39:0.40:0.40:0.51:0.31:0.69"] = 592, -- Emerald Sanctuary, Astranaar, Stonetalon Peak, Nijel's Point, Feathermoon
					["0.50:0.35:0.58:0.39:0.61:0.40:0.61:0.55:0.60:0.81:0.42:0.79"] = 696, -- Emerald Sanctuary, Forest Song, Talrendis Point, Ratchet, Gadgetzan, Cenarion Hold
					["0.50:0.35:0.58:0.39:0.61:0.40:0.61:0.55:0.60:0.81:0.50:0.76"] = 602, -- Emerald Sanctuary, Forest Song, Talrendis Point, Ratchet, Gadgetzan, Marshal's Refuge
					["0.50:0.35:0.58:0.39:0.61:0.40:0.61:0.55:0.64:0.67:0.48:0.70"] = 523, -- Emerald Sanctuary, Forest Song, Talrendis Point, Ratchet, Theramore, Thalanaar
					["0.50:0.35:0.58:0.39:0.61:0.40:0.61:0.55:0.60:0.81"] = 499, -- Emerald Sanctuary, Forest Song, Talrendis Point, Ratchet, Gadgetzan
					["0.50:0.35:0.58:0.39:0.61:0.40:0.61:0.55:0.64:0.67:0.58:0.70"] = 424, -- Emerald Sanctuary, Forest Song, Talrendis Point, Ratchet, Theramore, Mudsprocket
					["0.50:0.35:0.58:0.39:0.61:0.40:0.61:0.55:0.64:0.67"] = 361, -- Emerald Sanctuary, Forest Song, Talrendis Point, Ratchet, Theramore
					["0.50:0.35:0.58:0.39:0.61:0.40:0.61:0.55"] = 263, -- Emerald Sanctuary, Forest Song, Talrendis Point, Ratchet
					["0.50:0.35:0.46:0.40:0.39:0.40:0.40:0.51"] = 361, -- Emerald Sanctuary, Astranaar, Stonetalon Peak, Nijel's Point
					["0.50:0.35:0.46:0.40:0.39:0.40"] = 234, -- Emerald Sanctuary, Astranaar, Stonetalon Peak
					["0.50:0.35:0.46:0.40"] = 81, -- Emerald Sanctuary, Astranaar
					["0.50:0.35:0.58:0.39"] = 103, -- Emerald Sanctuary, Forest Song
					["0.50:0.35:0.58:0.39:0.61:0.40"] = 128, -- Emerald Sanctuary, Forest Song, Talrendis Point
					["0.50:0.35:0.53:0.26:0.65:0.23"] = 218, -- Emerald Sanctuary, Talonbranch Glade, Everlook
					["0.50:0.35:0.53:0.26:0.55:0.21"] = 187, -- Emerald Sanctuary, Talonbranch Glade, Moonglade
					["0.50:0.35:0.53:0.26"] = 128, -- Emerald Sanctuary, Talonbranch Glade
					["0.50:0.35:0.46:0.40:0.43:0.25"] = 229, -- Emerald Sanctuary, Astranaar, Auberdine
					["0.50:0.35:0.46:0.40:0.43:0.25:0.42:0.16"] = 313, -- Emerald Sanctuary, Astranaar, Auberdine, Rut'theran Village

					-- Alliance: Everlook (Winterspring)
					["0.65:0.23:0.55:0.21:0.43:0.25:0.31:0.69"] = 724, -- Everlook, Moonglade, Auberdine, Feathermoon
					["0.65:0.23:0.61:0.40:0.61:0.55:0.60:0.81:0.42:0.79"] = 734, -- Everlook, Talrendis Point, Ratchet, Gadgetzan, Cenarion Hold
					["0.65:0.23:0.61:0.40:0.61:0.55:0.60:0.81:0.50:0.76"] = 641, -- Everlook, Talrendis Point, Ratchet, Gadgetzan, Marshal's Refuge
					["0.65:0.23:0.61:0.40:0.61:0.55:0.64:0.67:0.48:0.70"] = 562, -- Everlook, Talrendis Point, Ratchet, Theramore, Thalanaar
					["0.65:0.23:0.61:0.40:0.61:0.55:0.64:0.67:0.58:0.70"] = 462, -- Everlook, Talrendis Point, Ratchet, Theramore, Mudsprocket
					["0.65:0.23:0.61:0.40:0.61:0.55:0.64:0.67"] = 399, -- Everlook, Talrendis Point, Ratchet, Theramore
					["0.65:0.23:0.61:0.40:0.61:0.55:0.60:0.81"] = 537, -- Everlook, Talrendis Point, Ratchet, Gadgetzan
					["0.65:0.23:0.61:0.40:0.61:0.55"] = 301, -- Everlook, Talrendis Point, Ratchet
					["0.65:0.23:0.55:0.21:0.43:0.25:0.40:0.51"] = 542, -- Everlook, Moonglade, Auberdine, Nijel's Point
					["0.65:0.23:0.55:0.21:0.43:0.25:0.39:0.40"] = 433, -- Everlook, Moonglade, Auberdine, Stonetalon Peak
					["0.65:0.23:0.53:0.26:0.50:0.35:0.46:0.40"] = 295, -- Everlook, Talonbranch Glade, Emerald Sanctuary, Astranaar
					["0.65:0.23:0.53:0.26:0.50:0.35"] = 216, -- Everlook, Talonbranch Glade, Emerald Sanctuary
					["0.65:0.23:0.61:0.40:0.58:0.39"] = 191, -- Everlook, Talrendis Point, Forest Song
					["0.65:0.23:0.61:0.40"] = 167, -- Everlook, Talrendis Point
					["0.65:0.23:0.55:0.21"] = 111, -- Everlook, Moonglade
					["0.65:0.23:0.53:0.26"] = 107, -- Everlook, Talonbranch Glade
					["0.65:0.23:0.55:0.21:0.43:0.25"] = 252, -- Everlook, Moonglade, Auberdine
					["0.65:0.23:0.55:0.21:0.43:0.25:0.42:0.16"] = 335, -- Everlook, Moonglade, Auberdine, Rut'theran Village

					-- Alliance: Feathermoon (Feralas)
					["0.31:0.69:0.42:0.79"] = 153, -- Feathermoon, Cenarion Hold
					["0.31:0.69:0.42:0.79:0.50:0.76"] = 242, -- Feathermoon, Cenarion Hold, Marshal's Refuge
					["0.31:0.69:0.48:0.70"] = 155, -- Feathermoon, Thalanaar
					["0.31:0.69:0.48:0.70:0.58:0.70"] = 240, -- Feathermoon, Thalanaar, Mudsprocket
					["0.31:0.69:0.48:0.70:0.58:0.70:0.64:0.67"] = 292, -- Feathermoon, Thalanaar, Mudsprocket, Theramore
					["0.31:0.69:0.48:0.70:0.60:0.81"] = 326, -- Feathermoon, Thalanaar, Gadgetzan
					["0.31:0.69:0.48:0.70:0.58:0.70:0.64:0.67:0.61:0.55"] = 406, -- Feathermoon, Thalanaar, Mudsprocket, Theramore, Ratchet
					["0.31:0.69:0.40:0.51"] = 227, -- Feathermoon, Nijel's Point
					["0.31:0.69:0.40:0.51:0.39:0.40"] = 346, -- Feathermoon, Nijel's Point, Stonetalon Peak
					["0.31:0.69:0.40:0.51:0.39:0.40:0.46:0.40"] = 500, -- Feathermoon, Nijel's Point, Stonetalon Peak, Astranaar
					["0.31:0.69:0.40:0.51:0.39:0.40:0.46:0.40:0.50:0.35"] = 578, -- Feathermoon, Nijel's Point, Stonetalon Peak, Astranaar, Emerald Sanctuary
					["0.31:0.69:0.48:0.70:0.58:0.70:0.64:0.67:0.61:0.40:0.58:0.39"] = 550, -- Feathermoon, Thalanaar, Mudsprocket, Theramore, Talrendis Point, Forest Song
					["0.31:0.69:0.48:0.70:0.58:0.70:0.64:0.67:0.61:0.40"] = 524, -- Feathermoon, Thalanaar, Mudsprocket, Theramore, Talrendis Point
					["0.31:0.69:0.48:0.70:0.58:0.70:0.64:0.67:0.61:0.40:0.65:0.23"] = 703, -- Feathermoon, Thalanaar, Mudsprocket, Theramore, Talrendis Point, Everlook
					["0.31:0.69:0.43:0.25:0.55:0.21"] = 618, -- Feathermoon, Auberdine, Moonglade
					["0.31:0.69:0.43:0.25:0.53:0.26"] = 657, -- Feathermoon, Auberdine, Talonbranch Glade
					["0.31:0.69:0.43:0.25"] = 468, -- Feathermoon, Auberdine
					["0.31:0.69:0.43:0.25:0.42:0.16"] = 552, -- Feathermoon, Auberdine, Rut'theran Village
					["0.31:0.69:0.48:0.70:0.64:0.67:0.61:0.55"] = 429, -- Feathermoon, Thalanaar, Theramore, Ratchet
					["0.31:0.69:0.40:0.51:0.64:0.67"] = 535, -- Feathermoon, Nijel's Point, Theramore
					["0.31:0.69:0.40:0.51:0.64:0.67:0.60:0.81"] = 690, -- Feathermoon, Nijel's Point, Theramore, Gadgetzan 

					-- Alliance: Forest Song (Ashenvale)
					["0.58:0.39:0.61:0.40:0.61:0.55:0.64:0.67:0.48:0.70:0.31:0.69"] = 602, -- Forest Song, Talrendis Point, Ratchet, Theramore, Thalanaar, Feathermoon
					["0.58:0.39:0.61:0.40:0.61:0.55:0.60:0.81:0.42:0.79"] = 596, -- Forest Song, Talrendis Point, Ratchet, Gadgetzan, Cenarion Hold
					["0.58:0.39:0.61:0.40:0.61:0.55:0.60:0.81:0.50:0.76"] = 503, -- Forest Song, Talrendis Point, Ratchet, Gadgetzan, Marshal's Refuge
					["0.58:0.39:0.61:0.40:0.61:0.55:0.64:0.67:0.48:0.70"] = 424, -- Forest Song, Talrendis Point, Ratchet, Theramore, Thalanaar
					["0.58:0.39:0.61:0.40:0.61:0.55:0.64:0.67:0.58:0.70"] = 324, -- Forest Song, Talrendis Point, Ratchet, Theramore, Mudsprocket
					["0.58:0.39:0.61:0.40:0.61:0.55:0.64:0.67"] = 261, -- Forest Song, Talrendis Point, Ratchet, Theramore
					["0.58:0.39:0.61:0.40:0.61:0.55:0.60:0.81"] = 400, -- Forest Song, Talrendis Point, Ratchet, Gadgetzan
					["0.58:0.39:0.61:0.40:0.61:0.55"] = 163, -- Forest Song, Talrendis Point, Ratchet
					["0.58:0.39:0.46:0.40:0.39:0.40:0.40:0.51"] = 421, -- Forest Song, Astranaar, Stonetalon Peak, Nijel's Point
					["0.58:0.39:0.46:0.40:0.39:0.40"] = 295, -- Forest Song, Astranaar, Stonetalon Peak
					["0.58:0.39:0.46:0.40"] = 141, -- Forest Song, Astranaar
					["0.58:0.39:0.50:0.35"] = 111, -- Forest Song, Emerald Sanctuary
					["0.58:0.39:0.61:0.40"] = 28, -- Forest Song, Talrendis Point
					["0.58:0.39:0.61:0.40:0.65:0.23"] = 207, -- Forest Song, Talrendis Point, Everlook
					["0.58:0.39:0.50:0.35:0.53:0.26"] = 238, -- Forest Song, Emerald Sanctuary, Talonbranch Glade
					["0.58:0.39:0.50:0.35:0.53:0.26:0.55:0.21"] = 297, -- Forest Song, Emerald Sanctuary, Talonbranch Glade, Moonglade
					["0.58:0.39:0.46:0.40:0.43:0.25"] = 290, -- Forest Song, Astranaar, Auberdine
					["0.58:0.39:0.46:0.40:0.43:0.25:0.42:0.16"] = 374, -- Forest Song, Astranaar, Auberdine, Rut'theran Village

					-- Alliance: Gadgetzan (Tanaris)
					["0.60:0.81:0.48:0.70:0.31:0.69"] = 354, -- Gadgetzan, Thalanaar, Feathermoon
					["0.60:0.81:0.42:0.79"] = 197, -- Gadgetzan, Cenarion Hold
					["0.60:0.81:0.50:0.76"] = 104, -- Gadgetzan, Marshal's Refuge
					["0.60:0.81:0.48:0.70"] = 177, -- Gadgetzan, Thalanaar
					["0.60:0.81:0.64:0.67:0.58:0.70"] = 212, -- Gadgetzan, Theramore, Mudsprocket
					["0.60:0.81:0.64:0.67"] = 154, -- Gadgetzan, Theramore
					["0.60:0.81:0.61:0.55"] = 247, -- Gadgetzan, Ratchet
					["0.60:0.81:0.64:0.67:0.40:0.51"] = 481, -- Gadgetzan, Theramore, Nijel's Point
					["0.60:0.81:0.61:0.55:0.46:0.40:0.39:0.40"] = 596, -- Gadgetzan, Ratchet, Astranaar, Stonetalon Peak
					["0.60:0.81:0.61:0.55:0.46:0.40"] = 442, -- Gadgetzan, Ratchet, Astranaar
					["0.60:0.81:0.61:0.55:0.61:0.40:0.58:0.39:0.50:0.35"] = 506, -- Gadgetzan, Ratchet, Talrendis Point, Forest Song, Emerald Sanctuary
					["0.60:0.81:0.61:0.55:0.61:0.40:0.58:0.39"] = 400, -- Gadgetzan, Ratchet, Talrendis Point, Forest Song
					["0.60:0.81:0.61:0.55:0.61:0.40"] = 374, -- Gadgetzan, Ratchet, Talrendis Point
					["0.60:0.81:0.61:0.55:0.61:0.40:0.65:0.23"] = 553, -- Gadgetzan, Ratchet, Talrendis Point, Everlook
					["0.60:0.81:0.61:0.55:0.61:0.40:0.58:0.39:0.50:0.35:0.53:0.26"] = 634, -- Gadgetzan, Ratchet, Talrendis Point, Forest Song, Emerald Sanctuary, Talonbranch Glade
					["0.60:0.81:0.61:0.55:0.61:0.40:0.65:0.23:0.55:0.21"] = 663, -- Gadgetzan, Ratchet, Talrendis Point, Everlook, Moonglade
					["0.60:0.81:0.61:0.55:0.46:0.40:0.43:0.25"] = 591, -- Gadgetzan, Ratchet, Astranaar, Auberdine
					["0.60:0.81:0.61:0.55:0.46:0.40:0.43:0.25:0.42:0.16"] = 675, -- Gadgetzan, Ratchet, Astranaar, Auberdine, Rut'theran Village

					-- Alliance: Marshal's Refuge (Un'Goro Crater)
					["0.50:0.76:0.42:0.79:0.31:0.69"] = 258, -- Marshal's Refuge, Cenarion Hold, Feathermoon
					["0.50:0.76:0.42:0.79"] = 94, -- Marshal's Refuge, Cenarion Hold
					["0.50:0.76:0.60:0.81:0.48:0.70"] = 281, -- Marshal's Refuge, Gadgetzan, Thalanaar
					["0.50:0.76:0.60:0.81:0.64:0.67:0.58:0.70"] = 315, -- Marshal's Refuge, Gadgetzan, Theramore, Mudsprocket
					["0.50:0.76:0.60:0.81:0.64:0.67"] = 257, -- Marshal's Refuge, Gadgetzan, Theramore
					["0.50:0.76:0.60:0.81"] = 104, -- Marshal's Refuge, Gadgetzan
					["0.50:0.76:0.60:0.81:0.61:0.55"] = 351, -- Marshal's Refuge, Gadgetzan, Ratchet
					["0.50:0.76:0.42:0.79:0.31:0.69:0.40:0.51"] = 485, -- Marshal's Refuge, Cenarion Hold, Feathermoon, Nijel's Point
					["0.50:0.76:0.42:0.79:0.31:0.69:0.40:0.51:0.39:0.40"] = 605, -- Marshal's Refuge, Cenarion Hold, Feathermoon, Nijel's Point, Stonetalon Peak
					["0.50:0.76:0.60:0.81:0.61:0.55:0.46:0.40"] = 545, -- Marshal's Refuge, Gadgetzan, Ratchet, Astranaar
					["0.50:0.76:0.60:0.81:0.61:0.55:0.61:0.40:0.58:0.39:0.50:0.35"] = 609, -- Marshal's Refuge, Gadgetzan, Ratchet, Talrendis Point, Forest Song, Emerald Sanctuary
					["0.50:0.76:0.60:0.81:0.61:0.55:0.61:0.40:0.58:0.39"] = 503, -- Marshal's Refuge, Gadgetzan, Ratchet, Talrendis Point, Forest Song
					["0.50:0.76:0.60:0.81:0.61:0.55:0.61:0.40"] = 477, -- Marshal's Refuge, Gadgetzan, Ratchet, Talrendis Point
					["0.50:0.76:0.60:0.81:0.61:0.55:0.61:0.40:0.65:0.23"] = 656, -- Marshal's Refuge, Gadgetzan, Ratchet, Talrendis Point, Everlook
					["0.50:0.76:0.60:0.81:0.61:0.55:0.61:0.40:0.65:0.23:0.55:0.21"] = 765, -- Marshal's Refuge, Gadgetzan, Ratchet, Talrendis Point, Everlook, Moonglade
					["0.50:0.76:0.60:0.81:0.61:0.55:0.61:0.40:0.58:0.39:0.50:0.35:0.53:0.26"] = 737, -- Marshal's Refuge, Gadgetzan, Ratchet, Talrendis Point, Forest Song, Emerald Sanctuary, Talonbranch Glade
					["0.50:0.76:0.60:0.81:0.61:0.55:0.46:0.40:0.43:0.25"] = 694, -- Marshal's Refuge, Gadgetzan, Ratchet, Astranaar, Auberdine
					["0.50:0.76:0.60:0.81:0.61:0.55:0.46:0.40:0.43:0.25:0.42:0.16"] = 778, -- Marshal's Refuge, Gadgetzan, Ratchet, Astranaar, Auberdine, Rut'theran Village

					-- Alliance: Moonglade (Moonglade)
					["0.55:0.21:0.43:0.25:0.31:0.69"] = 614, -- Moonglade, Auberdine, Feathermoon
					["0.55:0.21:0.43:0.25:0.31:0.69:0.42:0.79"] = 764, -- Moonglade, Auberdine, Feathermoon, Cenarion Hold
					["0.55:0.21:0.65:0.23:0.61:0.40:0.61:0.55:0.60:0.81:0.50:0.76"] = 755, -- Moonglade, Everlook, Talrendis Point, Ratchet, Gadgetzan, Marshal's Refuge
					["0.55:0.21:0.65:0.23:0.61:0.40:0.61:0.55:0.60:0.81"] = 651, -- Moonglade, Everlook, Talrendis Point, Ratchet, Gadgetzan
					["0.55:0.21:0.65:0.23:0.61:0.40:0.61:0.55:0.64:0.67:0.58:0.70"] = 576, -- Moonglade, Everlook, Talrendis Point, Ratchet, Theramore, Mudsprocket
					["0.55:0.21:0.65:0.23:0.61:0.40:0.61:0.55:0.64:0.67"] = 513, -- Moonglade, Everlook, Talrendis Point, Ratchet, Theramore
					["0.55:0.21:0.65:0.23:0.61:0.40:0.61:0.55:0.64:0.67:0.48:0.70"] = 675, -- Moonglade, Everlook, Talrendis Point, Ratchet, Theramore, Thalanaar
					["0.55:0.21:0.65:0.23:0.61:0.40:0.61:0.55"] = 415, -- Moonglade, Everlook, Talrendis Point, Ratchet
					["0.55:0.21:0.43:0.25:0.40:0.51"] = 433, -- Moonglade, Auberdine, Nijel's Point
					["0.55:0.21:0.43:0.25:0.39:0.40"] = 323, -- Moonglade, Auberdine, Stonetalon Peak
					["0.55:0.21:0.53:0.26:0.50:0.35:0.46:0.40"] = 253, -- Moonglade, Talonbranch Glade, Emerald Sanctuary, Astranaar
					["0.55:0.21:0.53:0.26:0.50:0.35"] = 174, -- Moonglade, Talonbranch Glade, Emerald Sanctuary
					["0.55:0.21:0.53:0.26:0.50:0.35:0.58:0.39"] = 277, -- Moonglade, Talonbranch Glade, Emerald Sanctuary, Forest Song
					["0.55:0.21:0.65:0.23:0.61:0.40"] = 281, -- Moonglade, Everlook, Talrendis Point
					["0.55:0.21:0.65:0.23"] = 119, -- Moonglade, Everlook
					["0.55:0.21:0.53:0.26"] = 62, -- Moonglade, Talonbranch Glade
					["0.55:0.21:0.43:0.25"] = 142, -- Moonglade, Auberdine
					["0.55:0.21:0.43:0.25:0.42:0.16"] = 226, -- Moonglade, Auberdine, Rut'theran Village

					-- Alliance: Mudsprocket (Dustwallow Marsh)
					["0.58:0.70:0.48:0.70:0.31:0.69"] = 283, -- Mudsprocket, Thalanaar, Feathermoon
					["0.58:0.70:0.64:0.67:0.60:0.81:0.42:0.79"] = 405, -- Mudsprocket, Theramore, Gadgetzan, Cenarion Hold
					["0.58:0.70:0.64:0.67:0.60:0.81:0.50:0.76"] = 312, -- Mudsprocket, Theramore, Gadgetzan, Marshal's Refuge
					["0.58:0.70:0.48:0.70"] = 105, -- Mudsprocket, Thalanaar
					["0.58:0.70:0.64:0.67"] = 52, -- Mudsprocket, Theramore
					["0.58:0.70:0.64:0.67:0.60:0.81"] = 209, -- Mudsprocket, Theramore, Gadgetzan
					["0.58:0.70:0.64:0.67:0.61:0.55"] = 167, -- Mudsprocket, Theramore, Ratchet
					["0.58:0.70:0.64:0.67:0.40:0.51"] = 386, -- Mudsprocket, Theramore, Nijel's Point
					["0.58:0.70:0.64:0.67:0.40:0.51:0.39:0.40"] = 505, -- Mudsprocket, Theramore, Nijel's Point, Stonetalon Peak
					["0.58:0.70:0.64:0.67:0.61:0.55:0.46:0.40"] = 361, -- Mudsprocket, Theramore, Ratchet, Astranaar
					["0.58:0.70:0.64:0.67:0.61:0.40:0.58:0.39:0.50:0.35"] = 416, -- Mudsprocket, Theramore, Talrendis Point, Forest Song, Emerald Sanctuary
					["0.58:0.70:0.64:0.67:0.61:0.40:0.58:0.39"] = 310, -- Mudsprocket, Theramore, Talrendis Point, Forest Song
					["0.58:0.70:0.64:0.67:0.61:0.40"] = 285, -- Mudsprocket, Theramore, Talrendis Point
					["0.58:0.70:0.64:0.67:0.61:0.40:0.65:0.23"] = 463, -- Mudsprocket, Theramore, Talrendis Point, Everlook
					["0.58:0.70:0.64:0.67:0.61:0.40:0.58:0.39:0.50:0.35:0.53:0.26"] = 544, -- Mudsprocket, Theramore, Talrendis Point, Forest Song, Emerald Sanctuary, Talonbranch Glade
					["0.58:0.70:0.64:0.67:0.61:0.40:0.65:0.23:0.55:0.21"] = 573, -- Mudsprocket, Theramore, Talrendis Point, Everlook, Moonglade
					["0.58:0.70:0.64:0.67:0.43:0.25"] = 492, -- Mudsprocket, Theramore, Auberdine
					["0.58:0.70:0.64:0.67:0.43:0.25:0.42:0.16"] = 576, -- Mudsprocket, Theramore, Auberdine, Rut'theran Village

					-- Alliance: Nijel's Point (Desolace)
					["0.40:0.51:0.31:0.69"] = 232, -- Nijel's Point, Feathermoon
					["0.40:0.51:0.31:0.69:0.42:0.79"] = 381, -- Nijel's Point, Feathermoon, Cenarion Hold
					["0.40:0.51:0.31:0.69:0.42:0.79:0.50:0.76"] = 470, -- Nijel's Point, Feathermoon, Cenarion Hold, Marshal's Refuge
					["0.40:0.51:0.31:0.69:0.48:0.70"] = 472, -- Nijel's Point, Feathermoon, Thalanaar
					["0.40:0.51:0.64:0.67:0.58:0.70"] = 370, -- Nijel's Point, Theramore, Mudsprocket
					["0.40:0.51:0.64:0.67"] = 308, -- Nijel's Point, Theramore
					["0.40:0.51:0.64:0.67:0.60:0.81"] = 464, -- Nijel's Point, Theramore, Gadgetzan
					["0.40:0.51:0.64:0.67:0.61:0.55"] = 422, -- Nijel's Point, Theramore, Ratchet
					["0.40:0.51:0.39:0.40:0.46:0.40:0.61:0.40"] = 421, -- Nijel's Point, Stonetalon Peak, Astranaar, Talrendis Point
					["0.40:0.51:0.39:0.40:0.46:0.40:0.58:0.39"] = 408, -- Nijel's Point, Stonetalon Peak, Astranaar, Forest Song
					["0.40:0.51:0.39:0.40:0.46:0.40:0.50:0.35"] = 351, -- Nijel's Point, Stonetalon Peak, Astranaar, Emerald Sanctuary
					["0.40:0.51:0.39:0.40:0.46:0.40"] = 274, -- Nijel's Point, Stonetalon Peak, Astranaar
					["0.40:0.51:0.39:0.40"] = 120, -- Nijel's Point, Stonetalon Peak
					["0.40:0.51:0.43:0.25"] = 282, -- Nijel's Point, Auberdine
					["0.40:0.51:0.43:0.25:0.42:0.16"] = 367, -- Nijel's Point, Auberdine, Rut'theran Village
					["0.40:0.51:0.43:0.25:0.53:0.26"] = 471, -- Nijel's Point, Auberdine, Talonbranch Glade
					["0.40:0.51:0.43:0.25:0.55:0.21"] = 433, -- Nijel's Point, Auberdine, Moonglade
					["0.40:0.51:0.43:0.25:0.55:0.21:0.65:0.23"] = 552, -- Nijel's Point, Auberdine, Moonglade, Everlook

					-- Alliance: Ratchet (The Barrens)
					["0.61:0.55:0.64:0.67:0.48:0.70:0.31:0.69"] = 446, -- Ratchet, Theramore, Thalanaar, Feathermoon
					["0.61:0.55:0.60:0.81:0.42:0.79"] = 442, -- Ratchet, Gadgetzan, Cenarion Hold
					["0.61:0.55:0.60:0.81:0.50:0.76"] = 349, -- Ratchet, Gadgetzan, Marshal's Refuge
					["0.61:0.55:0.64:0.67:0.48:0.70"] = 268, -- Ratchet, Theramore, Thalanaar
					["0.61:0.55:0.64:0.67:0.58:0.70"] = 168, -- Ratchet, Theramore, Mudsprocket
					["0.61:0.55:0.64:0.67"] = 106, -- Ratchet, Theramore
					["0.61:0.55:0.60:0.81"] = 245, -- Ratchet, Gadgetzan
					["0.61:0.55:0.61:0.40"] = 130, -- Ratchet, Talrendis Point
					["0.61:0.55:0.61:0.40:0.58:0.39"] = 155, -- Ratchet, Talrendis Point, Forest Song
					["0.61:0.55:0.61:0.40:0.58:0.39:0.50:0.35"] = 262, -- Ratchet, Talrendis Point, Forest Song, Emerald Sanctuary
					["0.61:0.55:0.46:0.40"] = 197, -- Ratchet, Astranaar
					["0.61:0.55:0.46:0.40:0.39:0.40"] = 352, -- Ratchet, Astranaar, Stonetalon Peak
					["0.61:0.55:0.64:0.67:0.40:0.51"] = 439, -- Ratchet, Theramore, Nijel's Point
					["0.61:0.55:0.46:0.40:0.43:0.25:0.42:0.16"] = 430, -- Ratchet, Astranaar, Auberdine, Rut'theran Village
					["0.61:0.55:0.46:0.40:0.43:0.25"] = 345, -- Ratchet, Astranaar, Auberdine
					["0.61:0.55:0.61:0.40:0.58:0.39:0.50:0.35:0.53:0.26"] = 389, -- Ratchet, Talrendis Point, Forest Song, Emerald Sanctuary, Talonbranch Glade
					["0.61:0.55:0.61:0.40:0.65:0.23:0.55:0.21"] = 420, -- Ratchet, Talrendis Point, Everlook, Moonglade
					["0.61:0.55:0.61:0.40:0.65:0.23"] = 310, -- Ratchet, Talrendis Point, Everlook
					["0.61:0.55:0.46:0.40:0.50:0.35"] = 276, -- Ratchet, Astranaar, Emerald Sanctuary
					["0.61:0.55:0.46:0.40:0.58:0.39"] = 332, -- Ratchet, Astranaar, Forest Song

					-- Alliance: Rut'theran Village (Teldrassil)
					["0.42:0.16:0.43:0.25:0.31:0.69"] = 557, -- Rut'theran Village, Auberdine, Feathermoon
					["0.42:0.16:0.43:0.25:0.31:0.69:0.42:0.79"] = 708, -- Rut'theran Village, Auberdine, Feathermoon, Cenarion Hold
					["0.42:0.16:0.43:0.25:0.64:0.67:0.60:0.81:0.50:0.76"] = 785, -- Rut'theran Village, Auberdine, Theramore, Gadgetzan, Marshal's Refuge
					["0.42:0.16:0.43:0.25:0.64:0.67:0.48:0.70"] = 687, -- Rut'theran Village, Auberdine, Theramore, Thalanaar
					["0.42:0.16:0.43:0.25:0.64:0.67:0.60:0.81"] = 681, -- Rut'theran Village, Auberdine, Theramore, Gadgetzan
					["0.42:0.16:0.43:0.25:0.64:0.67:0.58:0.70"] = 587, -- Rut'theran Village, Auberdine, Theramore, Mudsprocket
					["0.42:0.16:0.43:0.25:0.64:0.67"] = 528, -- Rut'theran Village, Auberdine, Theramore
					["0.42:0.16:0.43:0.25:0.46:0.40:0.61:0.55"] = 446, -- Rut'theran Village, Auberdine, Astranaar, Ratchet
					["0.42:0.16:0.43:0.25:0.40:0.51"] = 376, -- Rut'theran Village, Auberdine, Nijel's Point
					["0.42:0.16:0.43:0.25:0.61:0.40"] = 385, -- Rut'theran Village, Auberdine, Talrendis Point
					["0.42:0.16:0.43:0.25:0.46:0.40:0.58:0.39"] = 387, -- Rut'theran Village, Auberdine, Astranaar, Forest Song
					["0.42:0.16:0.43:0.25:0.46:0.40:0.50:0.35"] = 331, -- Rut'theran Village, Auberdine, Astranaar, Emerald Sanctuary
					["0.42:0.16:0.43:0.25:0.46:0.40"] = 252, -- Rut'theran Village, Auberdine, Astranaar
					["0.42:0.16:0.43:0.25:0.39:0.40"] = 267, -- Rut'theran Village, Auberdine, Stonetalon Peak
					["0.42:0.16:0.43:0.25"] = 86, -- Rut'theran Village, Auberdine
					["0.42:0.16:0.43:0.25:0.53:0.26"] = 274, -- Rut'theran Village, Auberdine, Talonbranch Glade
					["0.42:0.16:0.43:0.25:0.55:0.21"] = 236, -- Rut'theran Village, Auberdine, Moonglade
					["0.42:0.16:0.43:0.25:0.55:0.21:0.65:0.23"] = 355, -- Rut'theran Village, Auberdine, Moonglade, Everlook

					-- Alliance: Stonetalon Peak (Stonetalon Mountains)
					["0.39:0.40:0.40:0.51:0.31:0.69"] = 359, -- Stonetalon Peak, Nijel's Point, Feathermoon
					["0.39:0.40:0.40:0.51:0.31:0.69:0.42:0.79"] = 508, -- Stonetalon Peak, Nijel's Point, Feathermoon, Cenarion Hold
					["0.39:0.40:0.40:0.51:0.31:0.69:0.42:0.79:0.50:0.76"] = 596, -- Stonetalon Peak, Nijel's Point, Feathermoon, Cenarion Hold, Marshal's Refuge
					["0.39:0.40:0.40:0.51:0.31:0.69:0.48:0.70"] = 513, -- Stonetalon Peak, Nijel's Point, Feathermoon, Thalanaar
					["0.39:0.40:0.40:0.51:0.64:0.67:0.58:0.70"] = 497, -- Stonetalon Peak, Nijel's Point, Theramore, Mudsprocket
					["0.39:0.40:0.40:0.51:0.64:0.67"] = 434, -- Stonetalon Peak, Nijel's Point, Theramore
					["0.39:0.40:0.40:0.51:0.64:0.67:0.60:0.81"] = 591, -- Stonetalon Peak, Nijel's Point, Theramore, Gadgetzan
					["0.39:0.40:0.46:0.40:0.61:0.55"] = 348, -- Stonetalon Peak, Astranaar, Ratchet
					["0.39:0.40:0.40:0.51"] = 126, -- Stonetalon Peak, Nijel's Point
					["0.39:0.40:0.46:0.40"] = 154, -- Stonetalon Peak, Astranaar
					["0.39:0.40:0.46:0.40:0.50:0.35"] = 234, -- Stonetalon Peak, Astranaar, Emerald Sanctuary
					["0.39:0.40:0.46:0.40:0.58:0.39"] = 288, -- Stonetalon Peak, Astranaar, Forest Song
					["0.39:0.40:0.46:0.40:0.61:0.40"] = 303, -- Stonetalon Peak, Astranaar, Talrendis Point
					["0.39:0.40:0.43:0.25:0.55:0.21:0.65:0.23"] = 447, -- Stonetalon Peak, Auberdine, Moonglade, Everlook
					["0.39:0.40:0.46:0.40:0.50:0.35:0.53:0.26"] = 361, -- Stonetalon Peak, Astranaar, Emerald Sanctuary, Talonbranch Glade
					["0.39:0.40:0.43:0.25:0.55:0.21"] = 328, -- Stonetalon Peak, Auberdine, Moonglade
					["0.39:0.40:0.43:0.25"] = 177, -- Stonetalon Peak, Auberdine
					["0.39:0.40:0.43:0.25:0.42:0.16"] = 261, -- Stonetalon Peak, Auberdine, Rut'theran Village

					-- Alliance: Talonbranch Glade (Felwood)
					["0.53:0.26:0.43:0.25:0.31:0.69"] = 660, -- Talonbranch Glade, Auberdine, Feathermoon
					["0.53:0.26:0.43:0.25:0.31:0.69:0.42:0.79"] = 810, -- Talonbranch Glade, Auberdine, Feathermoon, Cenarion Hold
					["0.53:0.26:0.50:0.35:0.58:0.39:0.61:0.40:0.61:0.55:0.60:0.81:0.50:0.76"] = 731, -- Talonbranch Glade, Emerald Sanctuary, Forest Song, Talrendis Point, Ratchet, Gadgetzan, Marshal's Refuge
					["0.53:0.26:0.50:0.35:0.58:0.39:0.61:0.40:0.61:0.55:0.64:0.67:0.48:0.70"] = 652, -- Talonbranch Glade, Emerald Sanctuary, Forest Song, Talrendis Point, Ratchet, Theramore, Thalanaar
					["0.53:0.26:0.50:0.35:0.58:0.39:0.61:0.40:0.61:0.55:0.64:0.67:0.58:0.70"] = 552, -- Talonbranch Glade, Emerald Sanctuary, Forest Song, Talrendis Point, Ratchet, Theramore, Mudsprocket
					["0.53:0.26:0.50:0.35:0.58:0.39:0.61:0.40:0.61:0.55:0.64:0.67"] = 489, -- Talonbranch Glade, Emerald Sanctuary, Forest Song, Talrendis Point, Ratchet, Theramore
					["0.53:0.26:0.50:0.35:0.58:0.39:0.61:0.40:0.61:0.55:0.60:0.81"] = 627, -- Talonbranch Glade, Emerald Sanctuary, Forest Song, Talrendis Point, Ratchet, Gadgetzan
					["0.53:0.26:0.50:0.35:0.58:0.39:0.61:0.40:0.61:0.55"] = 391, -- Talonbranch Glade, Emerald Sanctuary, Forest Song, Talrendis Point, Ratchet
					["0.53:0.26:0.43:0.25:0.40:0.51"] = 478, -- Talonbranch Glade, Auberdine, Nijel's Point
					["0.53:0.26:0.50:0.35:0.46:0.40:0.39:0.40"] = 363, -- Talonbranch Glade, Emerald Sanctuary, Astranaar, Stonetalon Peak
					["0.53:0.26:0.50:0.35:0.46:0.40"] = 209, -- Talonbranch Glade, Emerald Sanctuary, Astranaar
					["0.53:0.26:0.50:0.35"] = 129, -- Talonbranch Glade, Emerald Sanctuary
					["0.53:0.26:0.50:0.35:0.58:0.39"] = 232, -- Talonbranch Glade, Emerald Sanctuary, Forest Song
					["0.53:0.26:0.61:0.40"] = 283, -- Talonbranch Glade, Talrendis Point
					["0.53:0.26:0.65:0.23"] = 107, -- Talonbranch Glade, Everlook
					["0.53:0.26:0.55:0.21"] = 67, -- Talonbranch Glade, Moonglade
					["0.53:0.26:0.43:0.25:0.42:0.16"] = 272, -- Talonbranch Glade, Auberdine, Rut'theran Village
					["0.53:0.26:0.43:0.25"] = 188, -- Talonbranch Glade, Auberdine

					-- Alliance: Talrendis Point (Azshara)
					["0.61:0.40:0.61:0.55:0.64:0.67:0.48:0.70:0.31:0.69"] = 574, -- Talrendis Point, Ratchet, Theramore, Thalanaar, Feathermoon
					["0.61:0.40:0.61:0.55:0.60:0.81:0.42:0.79"] = 569, -- Talrendis Point, Ratchet, Gadgetzan, Cenarion Hold
					["0.61:0.40:0.61:0.55:0.60:0.81:0.50:0.76"] = 476, -- Talrendis Point, Ratchet, Gadgetzan, Marshal's Refuge
					["0.61:0.40:0.61:0.55:0.64:0.67:0.48:0.70"] = 397, -- Talrendis Point, Ratchet, Theramore, Thalanaar
					["0.61:0.40:0.61:0.55:0.64:0.67:0.58:0.70"] = 297, -- Talrendis Point, Ratchet, Theramore, Mudsprocket
					["0.61:0.40:0.64:0.67"] = 241, -- Talrendis Point, Theramore
					["0.61:0.40:0.61:0.55:0.60:0.81"] = 373, -- Talrendis Point, Ratchet, Gadgetzan
					["0.61:0.40:0.61:0.55"] = 135, -- Talrendis Point, Ratchet
					["0.61:0.40:0.46:0.40:0.39:0.40:0.40:0.51"] = 431, -- Talrendis Point, Astranaar, Stonetalon Peak, Nijel's Point
					["0.61:0.40:0.46:0.40:0.39:0.40"] = 305, -- Talrendis Point, Astranaar, Stonetalon Peak
					["0.61:0.40:0.46:0.40"] = 153, -- Talrendis Point, Astranaar
					["0.61:0.40:0.58:0.39:0.50:0.35"] = 132, -- Talrendis Point, Forest Song, Emerald Sanctuary
					["0.61:0.40:0.58:0.39"] = 26, -- Talrendis Point, Forest Song
					["0.61:0.40:0.53:0.26"] = 284, -- Talrendis Point, Talonbranch Glade
					["0.61:0.40:0.65:0.23:0.55:0.21"] = 289, -- Talrendis Point, Everlook, Moonglade
					["0.61:0.40:0.65:0.23"] = 179, -- Talrendis Point, Everlook
					["0.61:0.40:0.46:0.40:0.43:0.25:0.42:0.16"] = 383, -- Talrendis Point, Astranaar, Auberdine, Rut'theran Village
					["0.61:0.40:0.43:0.25"] = 301, -- Talrendis Point, Auberdine

					-- Alliance: Thalanaar
					["0.48:0.70:0.31:0.69"] = 179, -- Thalanaar, Feathermoon
					["0.48:0.70:0.31:0.69:0.42:0.79"] = 329, -- Thalanaar, Feathermoon, Cenarion Hold
					["0.48:0.70:0.60:0.81:0.50:0.76"] = 274, -- Thalanaar, Gadgetzan, Marshal's Refuge
					["0.48:0.70:0.60:0.81"] = 171, -- Thalanaar, Gadgetzan
					["0.48:0.70:0.58:0.70"] = 86, -- Thalanaar, Mudsprocket
					["0.48:0.70:0.64:0.67"] = 159, -- Thalanaar, Theramore
					["0.48:0.70:0.58:0.70:0.64:0.67:0.61:0.55"] = 274, -- Thalanaar, Mudsprocket, Theramore, Ratchet
					["0.48:0.70:0.31:0.69:0.40:0.51"] = 405, -- Thalanaar, Feathermoon, Nijel's Point
					["0.48:0.70:0.31:0.69:0.40:0.51:0.39:0.40"] = 524, -- Thalanaar, Feathermoon, Nijel's Point, Stonetalon Peak
					["0.48:0.70:0.58:0.70:0.64:0.67:0.61:0.55:0.46:0.40"] = 447, -- Thalanaar, Mudsprocket, Theramore, Ratchet, Astranaar
					["0.48:0.70:0.58:0.70:0.64:0.67:0.61:0.40:0.58:0.39:0.50:0.35"] = 502, -- Thalanaar, Mudsprocket, Theramore, Talrendis Point, Forest Song, Emerald Sanctuary
					["0.48:0.70:0.58:0.70:0.64:0.67:0.61:0.40:0.58:0.39"] = 396, -- Thalanaar, Mudsprocket, Theramore, Talrendis Point, Forest Song
					["0.48:0.70:0.58:0.70:0.64:0.67:0.61:0.40"] = 370, -- Thalanaar, Mudsprocket, Theramore, Talrendis Point
					["0.48:0.70:0.58:0.70:0.64:0.67:0.61:0.40:0.65:0.23"] = 548, -- Thalanaar, Mudsprocket, Theramore, Talrendis Point, Everlook
					["0.48:0.70:0.58:0.70:0.64:0.67:0.61:0.40:0.58:0.39:0.50:0.35:0.53:0.26"] = 629, -- Thalanaar, Mudsprocket, Theramore, Talrendis Point, Forest Song, Emerald Sanctuary, Talonbranch Glade
					["0.48:0.70:0.58:0.70:0.64:0.67:0.61:0.40:0.65:0.23:0.55:0.21"] = 658, -- Thalanaar, Mudsprocket, Theramore, Talrendis Point, Everlook, Moonglade
					["0.48:0.70:0.58:0.70:0.64:0.67:0.43:0.25"] = 577, -- Thalanaar, Mudsprocket, Theramore, Auberdine
					["0.48:0.70:0.58:0.70:0.64:0.67:0.43:0.25:0.42:0.16"] = 661, -- Thalanaar, Mudsprocket, Theramore, Auberdine, Rut'theran Village
					["0.48:0.70:0.64:0.67:0.61:0.55"] = 275, -- Thalanaar, Theramore, Ratchet

					-- Alliance: Theramore (Dustwallow Marsh)
					["0.64:0.67:0.48:0.70:0.31:0.69"] = 340, -- Theramore, Thalanaar, Feathermoon
					["0.64:0.67:0.60:0.81:0.42:0.79"] = 354, -- Theramore, Gadgetzan, Cenarion Hold
					["0.64:0.67:0.60:0.81:0.50:0.76"] = 261, -- Theramore, Gadgetzan, Marshal's Refuge
					["0.64:0.67:0.48:0.70"] = 162, -- Theramore, Thalanaar
					["0.64:0.67:0.58:0.70"] = 64, -- Theramore, Mudsprocket
					["0.64:0.67:0.60:0.81"] = 157, -- Theramore, Gadgetzan
					["0.64:0.67:0.61:0.55"] = 115, -- Theramore, Ratchet
					["0.64:0.67:0.40:0.51"] = 334, -- Theramore, Nijel's Point
					["0.64:0.67:0.40:0.51:0.39:0.40"] = 453, -- Theramore, Nijel's Point, Stonetalon Peak
					["0.64:0.67:0.46:0.40"] = 369, -- Theramore, Astranaar
					["0.64:0.67:0.61:0.40:0.58:0.39:0.50:0.35"] = 366, -- Theramore, Talrendis Point, Forest Song, Emerald Sanctuary
					["0.64:0.67:0.61:0.40:0.58:0.39"] = 259, -- Theramore, Talrendis Point, Forest Song
					["0.64:0.67:0.61:0.40"] = 234, -- Theramore, Talrendis Point
					["0.64:0.67:0.61:0.40:0.65:0.23"] = 412, -- Theramore, Talrendis Point, Everlook
					["0.64:0.67:0.61:0.40:0.58:0.39:0.50:0.35:0.53:0.26"] = 494, -- Theramore, Talrendis Point, Forest Song, Emerald Sanctuary, Talonbranch Glade
					["0.64:0.67:0.61:0.40:0.65:0.23:0.55:0.21"] = 523, -- Theramore, Talrendis Point, Everlook, Moonglade
					["0.64:0.67:0.43:0.25"] = 440, -- Theramore, Auberdine
					["0.64:0.67:0.43:0.25:0.42:0.16"] = 524, -- Theramore, Auberdine, Rut'theran Village
					["0.64:0.67:0.61:0.55:0.46:0.40:0.39:0.40"] = 464, -- Theramore, Ratchet, Astranaar, Stonetalon Peak
					["0.64:0.67:0.40:0.51:0.31:0.69"] = 567, -- Theramore, Nijel's Point, Feathermoon

				},

				-- Alliance: Outland
				[1945] = {

					-- Alliance: Allerian Stronghold (Terokkar Forest)
					["0.55:0.77:0.27:0.74"] = 149, -- Allerian Stronghold, Telaar
					["0.55:0.77:0.44:0.67"] = 75, -- Allerian Stronghold, Shattrath
					["0.55:0.77:0.69:0.85"] = 79, -- Allerian Stronghold, Wildhammer Stronghold
					["0.55:0.77:0.65:0.58"] = 96, -- Allerian Stronghold, Honor Hold
					["0.55:0.77:0.65:0.58:0.79:0.55"] = 156, -- Allerian Stronghold, Honor Hold, Hellfire Peninsula
					["0.55:0.77:0.65:0.58:0.52:0.51"] = 170, -- Allerian Stronghold, Honor Hold, Temple of Telhamat
					["0.55:0.77:0.44:0.67:0.38:0.50"] = 158, -- Allerian Stronghold, Shattrath, Telredor
					["0.55:0.77:0.44:0.67:0.38:0.50:0.27:0.44"] = 221, -- Allerian Stronghold, Shattrath, Telredor, Orebor Harborage
					["0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37"] = 227, -- Allerian Stronghold, Shattrath, Telredor, Toshley's Station
					["0.55:0.77:0.44:0.67:0.38:0.50:0.32:0.34"] = 249, -- Allerian Stronghold, Shattrath, Telredor, Sylvanaar
					["0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37:0.42:0.28"] = 280, -- Allerian Stronghold, Shattrath, Telredor, Toshley's Station, Evergrove
					["0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37:0.58:0.27"] = 311, -- Allerian Stronghold, Shattrath, Telredor, Toshley's Station, Area 52
					["0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37:0.58:0.27:0.63:0.18"] = 358, -- Allerian Stronghold, Shattrath, Telredor, Toshley's Station, Area 52, The Stormspire
					["0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37:0.58:0.27:0.72:0.28"] = 375, -- Allerian Stronghold, Shattrath, Telredor, Toshley's Station, Area 52, Cosmowrench
					["0.55:0.77:0.69:0.85:0.81:0.77"] = 161, -- Allerian Stronghold, Wildhammer Stronghold, Altar of Sha'tar
					["0.55:0.77:0.69:0.85:0.78:0.85"] = 121, -- Allerian Stronghold, Wildhammer Stronghold, Sanctum of the Stars

					-- Alliance: Altar of Sha'tar (Shadowmoon Valley)
					["0.81:0.77:0.69:0.85"] = 81, -- Altar of Sha'tar, Wildhammer Stronghold
					["0.81:0.77:0.55:0.77:0.44:0.67"] = 254, -- Altar of Sha'tar, Allerian Stronghold, Shattrath
					["0.81:0.77:0.55:0.77:0.65:0.58:0.75:0.50"] = 330, -- Altar of Sha'tar, Allerian Stronghold, Honor Hold, Shatter Point
					["0.81:0.77:0.55:0.77:0.65:0.58:0.79:0.55"] = 336, -- Altar of Sha'tar, Allerian Stronghold, Honor Hold, Hellfire Peninsula
					["0.81:0.77:0.55:0.77"] = 182, -- Altar of Sha'tar, Allerian Stronghold
					["0.81:0.77:0.55:0.77:0.65:0.58"] = 276, -- Altar of Sha'tar, Allerian Stronghold, Honor Hold
					["0.81:0.77:0.55:0.77:0.27:0.74"] = 330, -- Altar of Sha'tar, Allerian Stronghold, Telaar
					["0.81:0.77:0.55:0.77:0.65:0.58:0.52:0.51"] = 351, -- Altar of Sha'tar, Allerian Stronghold, Honor Hold, Temple of Telhamat
					["0.81:0.77:0.55:0.77:0.44:0.67:0.38:0.50"] = 338, -- Altar of Sha'tar, Allerian Stronghold, Shattrath, Telredor
					["0.81:0.77:0.55:0.77:0.44:0.67:0.38:0.50:0.27:0.44"] = 400, -- Altar of Sha'tar, Allerian Stronghold, Shattrath, Telredor, Orebor Harborage
					["0.81:0.77:0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37:0.58:0.27:0.72:0.28"] = 555, -- Altar of Sha'tar, Allerian Stronghold, Shattrath, Telredor, Toshley's Station, Area 52, Cosmowrench
					["0.81:0.77:0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37:0.58:0.27:0.63:0.18"] = 537, -- Altar of Sha'tar, Allerian Stronghold, Shattrath, Telredor, Toshley's Station, Area 52, The Stormspire

					-- Alliance: Area 52 (Netherstorm)
					["0.58:0.27:0.42:0.37:0.38:0.50:0.27:0.74"] = 290, -- Area 52, Toshley's Station, Telredor, Telaar
					["0.58:0.27:0.42:0.37:0.38:0.50:0.44:0.67"] = 262, -- Area 52, Toshley's Station, Telredor, Shattrath
					["0.58:0.27:0.42:0.37:0.38:0.50:0.44:0.67:0.55:0.77"] = 337, -- Area 52, Toshley's Station, Telredor, Shattrath, Allerian Stronghold
					["0.58:0.27:0.42:0.37:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85"] = 414, -- Area 52, Toshley's Station, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold
					["0.58:0.27:0.42:0.37:0.38:0.50:0.52:0.51:0.65:0.58"] = 333, -- Area 52, Toshley's Station, Telredor, Temple of Telhamat, Honor Hold
					["0.58:0.27:0.42:0.37:0.38:0.50:0.52:0.51:0.65:0.58:0.79:0.55"] = 395, -- Area 52, Toshley's Station, Telredor, Temple of Telhamat, Honor Hold, Hellfire Peninsula
					["0.58:0.27:0.42:0.37:0.38:0.50:0.52:0.51"] = 247, -- Area 52, Toshley's Station, Telredor, Temple of Telhamat
					["0.58:0.27:0.42:0.37:0.38:0.50"] = 165, -- Area 52, Toshley's Station, Telredor
					["0.58:0.27:0.32:0.34:0.27:0.44"] = 229, -- Area 52, Sylvanaar, Orebor Harborage
					["0.58:0.27:0.32:0.34"] = 127, -- Area 52, Sylvanaar
					["0.58:0.27:0.42:0.37"] = 93, -- Area 52, Toshley's Station
					["0.58:0.27:0.42:0.28"] = 80, -- Area 52, Evergrove
					["0.58:0.27:0.72:0.28"] = 66, -- Area 52, Cosmowrench
					["0.58:0.27:0.63:0.18"] = 47, -- Area 52, The Stormspire
					["0.58:0.27:0.42:0.37:0.38:0.50:0.52:0.51:0.65:0.58:0.75:0.50"] = 388, -- Area 52, Toshley's Station, Telredor, Temple of Telhamat, Honor Hold, Shatter Point
					["0.58:0.27:0.42:0.37:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85:0.81:0.77"] = 495, -- Area 52, Toshley's Station, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold, Altar of Sha'tar
					["0.58:0.27:0.42:0.37:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85:0.78:0.85"] = 456, -- Area 52, Toshley's Station, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold, Sanctum of the Stars

					-- Alliance: Cosmowrench (Netherstorm)
					["0.72:0.28:0.58:0.27:0.42:0.37:0.38:0.50:0.27:0.74"] = 353, -- Cosmowrench, Area 52, Toshley's Station, Telredor, Telaar
					["0.72:0.28:0.58:0.27:0.42:0.37:0.38:0.50:0.44:0.67"] = 326, -- Cosmowrench, Area 52, Toshley's Station, Telredor, Shattrath
					["0.72:0.28:0.58:0.27:0.42:0.37:0.38:0.50:0.44:0.67:0.55:0.77"] = 401, -- Cosmowrench, Area 52, Toshley's Station, Telredor, Shattrath, Allerian Stronghold
					["0.72:0.28:0.58:0.27:0.42:0.37:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85"] = 478, -- Cosmowrench, Area 52, Toshley's Station, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold
					["0.72:0.28:0.58:0.27:0.42:0.37:0.38:0.50:0.52:0.51:0.65:0.58"] = 396, -- Cosmowrench, Area 52, Toshley's Station, Telredor, Temple of Telhamat, Honor Hold
					["0.72:0.28:0.58:0.27:0.42:0.37:0.38:0.50:0.52:0.51:0.65:0.58:0.79:0.55"] = 458, -- Cosmowrench, Area 52, Toshley's Station, Telredor, Temple of Telhamat, Honor Hold, Hellfire Peninsula
					["0.72:0.28:0.58:0.27:0.42:0.37:0.38:0.50:0.52:0.51"] = 310, -- Cosmowrench, Area 52, Toshley's Station, Telredor, Temple of Telhamat
					["0.72:0.28:0.58:0.27:0.42:0.37:0.38:0.50"] = 229, -- Cosmowrench, Area 52, Toshley's Station, Telredor
					["0.72:0.28:0.58:0.27:0.32:0.34:0.27:0.44"] = 266, -- Cosmowrench, Area 52, Sylvanaar, Orebor Harborage
					["0.72:0.28:0.58:0.27:0.42:0.37"] = 157, -- Cosmowrench, Area 52, Toshley's Station
					["0.72:0.28:0.58:0.27:0.32:0.34"] = 192, -- Cosmowrench, Area 52, Sylvanaar
					["0.72:0.28:0.58:0.27:0.42:0.28"] = 145, -- Cosmowrench, Area 52, Evergrove
					["0.72:0.28:0.58:0.27"] = 64, -- Cosmowrench, Area 52
					["0.72:0.28:0.63:0.18"] = 61, -- Cosmowrench, The Stormspire
					["0.72:0.28:0.58:0.27:0.42:0.37:0.38:0.50:0.52:0.51:0.65:0.58:0.75:0.50"] = 451, -- Cosmowrench, Area 52, Toshley's Station, Telredor, Temple of Telhamat, Honor Hold, Shatter Point
					["0.72:0.28:0.58:0.27:0.42:0.37:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85:0.81:0.77"] = 559, -- Cosmowrench, Area 52, Toshley's Station, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold, Altar of Sha'tar
					["0.72:0.28:0.58:0.27:0.42:0.37:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85:0.78:0.85"] = 520, -- Cosmowrench, Area 52, Toshley's Station, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold, Sanctum of the Stars

					-- Alliance: Evergrove (Blade's Edge Mountains)
					["0.42:0.28:0.42:0.37:0.38:0.50:0.27:0.74"] = 240, -- Evergrove, Toshley's Station, Telredor, Telaar
					["0.42:0.28:0.42:0.37:0.38:0.50:0.44:0.67"] = 213, -- Evergrove, Toshley's Station, Telredor, Shattrath
					["0.42:0.28:0.42:0.37:0.38:0.50:0.44:0.67:0.55:0.77"] = 287, -- Evergrove, Toshley's Station, Telredor, Shattrath, Allerian Stronghold
					["0.42:0.28:0.42:0.37:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85"] = 366, -- Evergrove, Toshley's Station, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold
					["0.42:0.28:0.42:0.37:0.38:0.50:0.52:0.51:0.65:0.58"] = 284, -- Evergrove, Toshley's Station, Telredor, Temple of Telhamat, Honor Hold
					["0.42:0.28:0.42:0.37:0.38:0.50:0.52:0.51:0.65:0.58:0.79:0.55"] = 346, -- Evergrove, Toshley's Station, Telredor, Temple of Telhamat, Honor Hold, Hellfire Peninsula
					["0.42:0.28:0.42:0.37:0.38:0.50:0.52:0.51"] = 197, -- Evergrove, Toshley's Station, Telredor, Temple of Telhamat
					["0.42:0.28:0.42:0.37:0.38:0.50"] = 116, -- Evergrove, Toshley's Station, Telredor
					["0.42:0.28:0.32:0.34:0.27:0.44"] = 130, -- Evergrove, Sylvanaar, Orebor Harborage
					["0.42:0.28:0.42:0.37"] = 44, -- Evergrove, Toshley's Station
					["0.42:0.28:0.32:0.34"] = 54, -- Evergrove, Sylvanaar
					["0.42:0.28:0.58:0.27"] = 73, -- Evergrove, Area 52
					["0.42:0.28:0.58:0.27:0.63:0.18"] = 124, -- Evergrove, Area 52, The Stormspire
					["0.42:0.28:0.58:0.27:0.72:0.28"] = 143, -- Evergrove, Area 52, Cosmowrench

					-- Alliance: Hellfire Peninsula (Hellfire Peninsula) (Dark Portal)
					["0.79:0.55:0.65:0.58:0.44:0.67:0.27:0.74"] = 277, -- Hellfire Peninsula, Honor Hold, Shattrath, Telaar
					["0.79:0.55:0.65:0.58:0.44:0.67"] = 190, -- Hellfire Peninsula, Honor Hold, Shattrath
					["0.79:0.55:0.65:0.58:0.55:0.77"] = 188, -- Hellfire Peninsula, Honor Hold, Allerian Stronghold
					["0.79:0.55:0.65:0.58:0.55:0.77:0.69:0.85"] = 266, -- Hellfire Peninsula, Honor Hold, Allerian Stronghold, Wildhammer Stronghold
					["0.79:0.55:0.65:0.58"] = 73, -- Hellfire Peninsula, Honor Hold
					["0.79:0.55:0.52:0.51"] = 115, -- Hellfire Peninsula, Temple of Telhamat
					["0.79:0.55:0.52:0.51:0.38:0.50"] = 196, -- Hellfire Peninsula, Temple of Telhamat, Telredor
					["0.79:0.55:0.52:0.51:0.38:0.50:0.27:0.44"] = 259, -- Hellfire Peninsula, Temple of Telhamat, Telredor, Orebor Harborage
					["0.79:0.55:0.52:0.51:0.38:0.50:0.42:0.37"] = 265, -- Hellfire Peninsula, Temple of Telhamat, Telredor, Toshley's Station
					["0.79:0.55:0.52:0.51:0.38:0.50:0.32:0.34"] = 287, -- Hellfire Peninsula, Temple of Telhamat, Telredor, Sylvanaar
					["0.79:0.55:0.52:0.51:0.38:0.50:0.42:0.37:0.42:0.28"] = 317, -- Hellfire Peninsula, Temple of Telhamat, Telredor, Toshley's Station, Evergrove
					["0.79:0.55:0.52:0.51:0.38:0.50:0.42:0.37:0.58:0.27"] = 348, -- Hellfire Peninsula, Temple of Telhamat, Telredor, Toshley's Station, Area 52
					["0.79:0.55:0.52:0.51:0.38:0.50:0.42:0.37:0.58:0.27:0.72:0.28"] = 413, -- Hellfire Peninsula, Temple of Telhamat, Telredor, Toshley's Station, Area 52, Cosmowrench
					["0.79:0.55:0.52:0.51:0.38:0.50:0.42:0.37:0.58:0.27:0.63:0.18"] = 396, -- Hellfire Peninsula, Temple of Telhamat, Telredor, Toshley's Station, Area 52, The Stormspire
					["0.79:0.55:0.75:0.50"] = 28, -- Hellfire Peninsula, Shatter Point
					["0.79:0.55:0.65:0.58:0.55:0.77:0.69:0.85:0.81:0.77"] = 348, -- Hellfire Peninsula, Honor Hold, Allerian Stronghold, Wildhammer Stronghold, Altar of Sha'tar
					["0.79:0.55:0.65:0.58:0.55:0.77:0.69:0.85:0.78:0.85"] = 308, -- Hellfire Peninsula, Honor Hold, Allerian Stronghold, Wildhammer Stronghold, Sanctum of the Stars

					-- Alliance: Honor Hold (Hellfire Peninsula)
					["0.65:0.58:0.44:0.67:0.27:0.74"] = 207, -- Honor Hold, Shattrath, Telaar
					["0.65:0.58:0.44:0.67"] = 120, -- Honor Hold, Shattrath
					["0.65:0.58:0.55:0.77"] = 118, -- Honor Hold, Allerian Stronghold
					["0.65:0.58:0.55:0.77:0.69:0.85"] = 196, -- Honor Hold, Allerian Stronghold, Wildhammer Stronghold
					["0.65:0.58:0.79:0.55"] = 64, -- Honor Hold, Hellfire Peninsula
					["0.65:0.58:0.52:0.51"] = 76, -- Honor Hold, Temple of Telhamat
					["0.65:0.58:0.52:0.51:0.38:0.50"] = 156, -- Honor Hold, Temple of Telhamat, Telredor
					["0.65:0.58:0.52:0.51:0.38:0.50:0.27:0.44"] = 219, -- Honor Hold, Temple of Telhamat, Telredor, Orebor Harborage
					["0.65:0.58:0.52:0.51:0.38:0.50:0.42:0.37"] = 225, -- Honor Hold, Temple of Telhamat, Telredor, Toshley's Station
					["0.65:0.58:0.52:0.51:0.38:0.50:0.32:0.34"] = 248, -- Honor Hold, Temple of Telhamat, Telredor, Sylvanaar
					["0.65:0.58:0.52:0.51:0.38:0.50:0.42:0.37:0.42:0.28"] = 278, -- Honor Hold, Temple of Telhamat, Telredor, Toshley's Station, Evergrove
					["0.65:0.58:0.52:0.51:0.38:0.50:0.42:0.37:0.58:0.27"] = 309, -- Honor Hold, Temple of Telhamat, Telredor, Toshley's Station, Area 52
					["0.65:0.58:0.52:0.51:0.38:0.50:0.42:0.37:0.58:0.27:0.63:0.18"] = 356, -- Honor Hold, Temple of Telhamat, Telredor, Toshley's Station, Area 52, The Stormspire
					["0.65:0.58:0.52:0.51:0.38:0.50:0.42:0.37:0.58:0.27:0.72:0.28"] = 374, -- Honor Hold, Temple of Telhamat, Telredor, Toshley's Station, Area 52, Cosmowrench
					["0.65:0.58:0.75:0.50"] = 57, -- Honor Hold, Shatter Point
					["0.65:0.58:0.55:0.77:0.69:0.85:0.81:0.77"] = 278, -- Honor Hold, Allerian Stronghold, Wildhammer Stronghold, Altar of Sha'tar
					["0.65:0.58:0.55:0.77:0.69:0.85:0.78:0.85"] = 238, -- Honor Hold, Allerian Stronghold, Wildhammer Stronghold, Sanctum of the Stars

					-- Alliance: Orebor Harborage (Zangarmarsh)
					["0.27:0.44:0.38:0.50:0.27:0.74"] = 177, -- Orebor Harborage, Telredor, Telaar
					["0.27:0.44:0.38:0.50:0.44:0.67"] = 150, -- Orebor Harborage, Telredor, Shattrath
					["0.27:0.44:0.38:0.50:0.44:0.67:0.55:0.77"] = 225, -- Orebor Harborage, Telredor, Shattrath, Allerian Stronghold
					["0.27:0.44:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85"] = 302, -- Orebor Harborage, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold
					["0.27:0.44:0.38:0.50:0.52:0.51:0.65:0.58"] = 221, -- Orebor Harborage, Telredor, Temple of Telhamat, Honor Hold
					["0.27:0.44:0.38:0.50:0.52:0.51:0.65:0.58:0.79:0.55"] = 282, -- Orebor Harborage, Telredor, Temple of Telhamat, Honor Hold, Hellfire Peninsula
					["0.27:0.44:0.38:0.50:0.52:0.51"] = 134, -- Orebor Harborage, Telredor, Temple of Telhamat
					["0.27:0.44:0.38:0.50"] = 53, -- Orebor Harborage, Telredor
					["0.27:0.44:0.32:0.34"] = 65, -- Orebor Harborage, Sylvanaar
					["0.27:0.44:0.32:0.34:0.42:0.37"] = 122, -- Orebor Harborage, Sylvanaar, Toshley's Station
					["0.27:0.44:0.32:0.34:0.42:0.28"] = 116, -- Orebor Harborage, Sylvanaar, Evergrove
					["0.27:0.44:0.32:0.34:0.58:0.27"] = 184, -- Orebor Harborage, Sylvanaar, Area 52
					["0.27:0.44:0.32:0.34:0.58:0.27:0.72:0.28"] = 249, -- Orebor Harborage, Sylvanaar, Area 52, Cosmowrench
					["0.27:0.44:0.32:0.34:0.63:0.18"] = 219, -- Orebor Harborage, Sylvanaar, The Stormspire
					["0.27:0.44:0.38:0.50:0.52:0.51:0.65:0.58:0.75:0.50"] = 275, -- Orebor Harborage, Telredor, Temple of Telhamat, Honor Hold, Shatter Point
					["0.27:0.44:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85:0.81:0.77"] = 384, -- Orebor Harborage, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold, Altar of Sha'tar
					["0.27:0.44:0.38:0.50:0.42:0.37:0.58:0.27:0.63:0.18"] = 253, -- Orebor Harborage, Telredor, Toshley's Station, Area 52, The Stormspire

					-- Alliance: Sanctum of the Stars (Shadowmoon Valley)
					["0.78:0.85:0.55:0.77:0.44:0.67"] = 215, -- Sanctum of the Stars, Allerian Stronghold, Shattrath
					["0.78:0.85:0.55:0.77"] = 142, -- Sanctum of the Stars, Allerian Stronghold
					["0.78:0.85:0.69:0.85"] = 42, -- Sanctum of the Stars, Wildhammer Stronghold
					["0.78:0.85:0.55:0.77:0.27:0.74"] = 290, -- Sanctum of the Stars, Allerian Stronghold, Telaar
					["0.78:0.85:0.55:0.77:0.65:0.58"] = 237, -- Sanctum of the Stars, Allerian Stronghold, Honor Hold
					["0.78:0.85:0.55:0.77:0.65:0.58:0.79:0.55"] = 296, -- Sanctum of the Stars, Allerian Stronghold, Honor Hold, Hellfire Peninsula
					["0.78:0.85:0.55:0.77:0.65:0.58:0.75:0.50"] = 290, -- Sanctum of the Stars, Allerian Stronghold, Honor Hold, Shatter Point
					["0.78:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37:0.58:0.27"] = 450, -- Sanctum of the Stars, Allerian Stronghold, Shattrath, Telredor, Toshley's Station, Area 52
					["0.78:0.85:0.55:0.77:0.65:0.58:0.52:0.51"] = 311, -- Sanctum of the Stars, Allerian Stronghold, Honor Hold, Temple of Telhamat
					["0.78:0.85:0.55:0.77:0.44:0.67:0.38:0.50"] = 298, -- Sanctum of the Stars, Allerian Stronghold, Shattrath, Telredor
					["0.78:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37:0.58:0.27:0.72:0.28"] = 515, -- Sanctum of the Stars, Allerian Stronghold, Shattrath, Telredor, Toshley's Station, Area 52, Cosmowrench

					-- Alliance: Shatter Point (Hellfire Peninsula)
					["0.75:0.50:0.79:0.55"] = 33, -- Shatter Point, Hellfire Peninsula
					["0.75:0.50:0.65:0.58"] = 57, -- Shatter Point, Honor Hold
					["0.75:0.50:0.65:0.58:0.55:0.77:0.69:0.85:0.81:0.77"] = 334, -- Shatter Point, Honor Hold, Allerian Stronghold, Wildhammer Stronghold, Altar of Sha'tar
					["0.75:0.50:0.65:0.58:0.55:0.77:0.69:0.85"] = 252, -- Shatter Point, Honor Hold, Allerian Stronghold, Wildhammer Stronghold
					["0.75:0.50:0.65:0.58:0.55:0.77"] = 174, -- Shatter Point, Honor Hold, Allerian Stronghold
					["0.75:0.50:0.65:0.58:0.52:0.51"] = 132, -- Shatter Point, Honor Hold, Temple of Telhamat
					["0.75:0.50:0.65:0.58:0.52:0.51:0.38:0.50"] = 213, -- Shatter Point, Honor Hold, Temple of Telhamat, Telredor
					["0.75:0.50:0.65:0.58:0.44:0.67"] = 175, -- Shatter Point, Honor Hold, Shattrath
					["0.75:0.50:0.65:0.58:0.44:0.67:0.27:0.74"] = 263, -- Shatter Point, Honor Hold, Shattrath, Telaar
					["0.75:0.50:0.65:0.58:0.52:0.51:0.38:0.50:0.42:0.37:0.58:0.27:0.72:0.28"] = 430, -- Shatter Point, Honor Hold, Temple of Telhamat, Telredor, Toshley's Station, Area 52, Cosmowrench
					["0.75:0.50:0.65:0.58:0.52:0.51:0.38:0.50:0.42:0.37:0.58:0.27"] = 364, -- Shatter Point, Honor Hold, Temple of Telhamat, Telredor, Toshley's Station, Area 52
					["0.75:0.50:0.65:0.58:0.52:0.51:0.38:0.50:0.27:0.44"] = 275, -- Shatter Point, Honor Hold, Temple of Telhamat, Telredor, Orebor Harborage
					["0.75:0.50:0.65:0.58:0.52:0.51:0.38:0.50:0.42:0.37:0.58:0.27:0.63:0.18"] = 412, -- Shatter Point, Honor Hold, Temple of Telhamat, Telredor, Toshley's Station, Area 52, The Stormspire
					["0.75:0.50:0.65:0.58:0.55:0.77:0.69:0.85:0.78:0.85"] = 294, -- Shatter Point, Honor Hold, Allerian Stronghold, Wildhammer Stronghold, Sanctum of the Stars

					-- Alliance: Shattrath (Terokkar Forest)
					["0.44:0.67:0.27:0.74"] = 88, -- Shattrath, Telaar
					["0.44:0.67:0.55:0.77"] = 75, -- Shattrath, Allerian Stronghold
					["0.44:0.67:0.55:0.77:0.69:0.85"] = 153, -- Shattrath, Allerian Stronghold, Wildhammer Stronghold
					["0.44:0.67:0.65:0.58:0.79:0.55"] = 172, -- Shattrath, Honor Hold, Hellfire Peninsula
					["0.44:0.67:0.65:0.58"] = 111, -- Shattrath, Honor Hold
					["0.44:0.67:0.38:0.50:0.52:0.51"] = 165, -- Shattrath, Telredor, Temple of Telhamat
					["0.44:0.67:0.38:0.50"] = 84, -- Shattrath, Telredor
					["0.44:0.67:0.38:0.50:0.27:0.44"] = 146, -- Shattrath, Telredor, Orebor Harborage
					["0.44:0.67:0.38:0.50:0.42:0.37"] = 152, -- Shattrath, Telredor, Toshley's Station
					["0.44:0.67:0.38:0.50:0.32:0.34"] = 175, -- Shattrath, Telredor, Sylvanaar
					["0.44:0.67:0.38:0.50:0.42:0.37:0.42:0.28"] = 205, -- Shattrath, Telredor, Toshley's Station, Evergrove
					["0.44:0.67:0.38:0.50:0.42:0.37:0.58:0.27"] = 235, -- Shattrath, Telredor, Toshley's Station, Area 52
					["0.44:0.67:0.38:0.50:0.42:0.37:0.58:0.27:0.72:0.28"] = 301, -- Shattrath, Telredor, Toshley's Station, Area 52, Cosmowrench
					["0.44:0.67:0.38:0.50:0.42:0.37:0.58:0.27:0.63:0.18"] = 284, -- Shattrath, Telredor, Toshley's Station, Area 52, The Stormspire
					["0.44:0.67:0.55:0.77:0.69:0.85:0.81:0.77"] =  235, -- Shattrath, Allerian Stronghold, Wildhammer Stronghold, Altar of Sha'tar
					["0.44:0.67:0.65:0.58:0.75:0.50"] = 165, -- Shattrath, Honor Hold, Shatter Point
					["0.44:0.67:0.55:0.77:0.69:0.85:0.78:0.85"] = 195, -- Shattrath, Allerian Stronghold, Wildhammer Stronghold, Sanctum of the Stars
					["0.44:0.67:0.38:0.50:0.32:0.34:0.58:0.27:0.72:0.28"] = 359, -- Shattrath, Telredor, Sylvanaar, Area 52, Cosmowrench
					["0.44:0.67:0.65:0.58:0.52:0.51"] = 185, -- Shattrath, Honor Hold, Temple of Telhamat 
					["0.44:0.67:0.38:0.50:0.32:0.34:0.63:0.18"] = 329, -- Shattrath, Telredor, Sylvanaar, The Stormspire

					-- Alliance: Sylvanaar (Blade's Edge Mountains)
					["0.32:0.34:0.38:0.50:0.27:0.74"] = 207, -- Sylvanaar, Telredor, Telaar
					["0.32:0.34:0.38:0.50:0.44:0.67"] = 179, -- Sylvanaar, Telredor, Shattrath
					["0.32:0.34:0.38:0.50:0.44:0.67:0.55:0.77"] = 255, -- Sylvanaar, Telredor, Shattrath, Allerian Stronghold
					["0.32:0.34:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85"] = 332, -- Sylvanaar, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold
					["0.32:0.34:0.38:0.50:0.52:0.51:0.65:0.58"] = 251, -- Sylvanaar, Telredor, Temple of Telhamat, Honor Hold
					["0.32:0.34:0.38:0.50:0.52:0.51:0.65:0.58:0.79:0.55"] = 312, -- Sylvanaar, Telredor, Temple of Telhamat, Honor Hold, Hellfire Peninsula
					["0.32:0.34:0.38:0.50:0.52:0.51"] = 164, -- Sylvanaar, Telredor, Temple of Telhamat
					["0.32:0.34:0.38:0.50"] = 82, -- Sylvanaar, Telredor
					["0.32:0.34:0.27:0.44"] = 76, -- Sylvanaar, Orebor Harborage
					["0.32:0.34:0.42:0.37"] = 57, -- Sylvanaar, Toshley's Station
					["0.32:0.34:0.42:0.28"] = 51, -- Sylvanaar, Evergrove
					["0.32:0.34:0.58:0.27"] = 119, -- Sylvanaar, Area 52
					["0.32:0.34:0.63:0.18"] = 155, -- Sylvanaar, The Stormspire
					["0.32:0.34:0.58:0.27:0.72:0.28"] = 185, -- Sylvanaar, Area 52, Cosmowrench

					-- Alliance: Telaar (Nagrand)
					["0.27:0.74:0.44:0.67"] = 88, -- Telaar, Shattrath
					["0.27:0.74:0.55:0.77"] = 122, -- Telaar, Allerian Stronghold
					["0.27:0.74:0.55:0.77:0.69:0.85"] = 200, -- Telaar, Allerian Stronghold, Wildhammer Stronghold
					["0.27:0.74:0.44:0.67:0.65:0.58:0.79:0.55"] = 260, -- Telaar, Shattrath, Honor Hold, Hellfire Peninsula
					["0.27:0.74:0.44:0.67:0.65:0.58"] = 199, -- Telaar, Shattrath, Honor Hold
					["0.27:0.74:0.38:0.50:0.52:0.51"] = 208, -- Telaar, Telredor, Temple of Telhamat
					["0.27:0.74:0.38:0.50"] = 126, -- Telaar, Telredor
					["0.27:0.74:0.38:0.50:0.27:0.44"] = 189, -- Telaar, Telredor, Orebor Harborage
					["0.27:0.74:0.38:0.50:0.42:0.37"] = 195, -- Telaar, Telredor, Toshley's Station
					["0.27:0.74:0.38:0.50:0.32:0.34"] = 217, -- Telaar, Telredor, Sylvanaar
					["0.27:0.74:0.38:0.50:0.42:0.37:0.42:0.28"] = 248, -- Telaar, Telredor, Toshley's Station, Evergrove
					["0.27:0.74:0.38:0.50:0.42:0.37:0.58:0.27"] = 280, -- Telaar, Telredor, Toshley's Station, Area 52
					["0.27:0.74:0.38:0.50:0.42:0.37:0.58:0.27:0.72:0.28"] = 344, -- Telaar, Telredor, Toshley's Station, Area 52, Cosmowrench
					["0.27:0.74:0.38:0.50:0.42:0.37:0.58:0.27:0.63:0.18"] = 327, -- Telaar, Telredor, Toshley's Station, Area 52, The Stormspire
					["0.27:0.74:0.55:0.77:0.69:0.85:0.81:0.77"] = 281, -- Telaar, Allerian Stronghold, Wildhammer Stronghold, Altar of Sha'tar
					["0.27:0.74:0.44:0.67:0.65:0.58:0.75:0.50"] = 253, -- Telaar, Shattrath, Honor Hold, Shatter Point
					["0.27:0.74:0.55:0.77:0.69:0.85:0.78:0.85"] = 241, -- Telaar, Allerian Stronghold, Wildhammer Stronghold, Sanctum of the Stars
					["0.27:0.74:0.38:0.50:0.32:0.34:0.42:0.28"] = 269, -- Telaar, Telredor, Sylvanaar, Evergrove

					-- Alliance: Telredor (Zangarmarsh)
					["0.38:0.50:0.27:0.74"] = 125, -- Telredor, Telaar
					["0.38:0.50:0.44:0.67"] = 97, -- Telredor, Shattrath
					["0.38:0.50:0.44:0.67:0.55:0.77"] = 172, -- Telredor, Shattrath, Allerian Stronghold
					["0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85"] = 250, -- Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold
					["0.38:0.50:0.52:0.51:0.65:0.58"] = 169, -- Telredor, Temple of Telhamat, Honor Hold
					["0.38:0.50:0.52:0.51:0.65:0.58:0.79:0.55"] = 230, -- Telredor, Temple of Telhamat, Honor Hold, Hellfire Peninsula
					["0.38:0.50:0.52:0.51"] = 82, -- Telredor, Temple of Telhamat
					["0.38:0.50:0.27:0.44"] = 63, -- Telredor, Orebor Harborage
					["0.38:0.50:0.32:0.34"] = 91, -- Telredor, Sylvanaar
					["0.38:0.50:0.42:0.37"] = 69, -- Telredor, Toshley's Station
					["0.38:0.50:0.42:0.37:0.42:0.28"] = 121, -- Telredor, Toshley's Station, Evergrove
					["0.38:0.50:0.42:0.37:0.58:0.27"] = 153, -- Telredor, Toshley's Station, Area 52
					["0.38:0.50:0.42:0.37:0.58:0.27:0.72:0.28"] = 219, -- Telredor, Toshley's Station, Area 52, Cosmowrench
					["0.38:0.50:0.42:0.37:0.58:0.27:0.63:0.18"] = 200, -- Telredor, Toshley's Station, Area 52, The Stormspire
					["0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85:0.81:0.77"] = 331, -- Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold, Altar of Sha'tar
					["0.38:0.50:0.52:0.51:0.65:0.58:0.75:0.50"] = 223, -- Telredor, Temple of Telhamat, Honor Hold, Shatter Point
					["0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85:0.78:0.85"] = 292, -- Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold, Sanctum of the Stars

					-- Alliance: Temple of Telhamat (Hellfire Peninsula)
					["0.52:0.51:0.38:0.50:0.27:0.74"] = 206, -- Temple of Telhamat, Telredor, Telaar
					["0.52:0.51:0.38:0.50:0.44:0.67"] = 178, -- Temple of Telhamat, Telredor, Shattrath
					["0.52:0.51:0.65:0.58:0.55:0.77"] = 203, -- Temple of Telhamat, Honor Hold, Allerian Stronghold
					["0.52:0.51:0.65:0.58:0.55:0.77:0.69:0.85"] = 281, -- Temple of Telhamat, Honor Hold, Allerian Stronghold, Wildhammer Stronghold
					["0.52:0.51:0.65:0.58"] = 88, -- Temple of Telhamat, Honor Hold
					["0.52:0.51:0.65:0.58:0.79:0.55"] = 149, -- Temple of Telhamat, Honor Hold, Hellfire Peninsula
					["0.52:0.51:0.38:0.50"] = 81, -- Temple of Telhamat, Telredor
					["0.52:0.51:0.38:0.50:0.27:0.44"] = 144, -- Temple of Telhamat, Telredor, Orebor Harborage
					["0.52:0.51:0.38:0.50:0.42:0.37"] = 150, -- Temple of Telhamat, Telredor, Toshley's Station
					["0.52:0.51:0.38:0.50:0.32:0.34"] = 172, -- Temple of Telhamat, Telredor, Sylvanaar
					["0.52:0.51:0.38:0.50:0.42:0.37:0.42:0.28"] = 203, -- Temple of Telhamat, Telredor, Toshley's Station, Evergrove
					["0.52:0.51:0.38:0.50:0.42:0.37:0.58:0.27"] = 233, -- Temple of Telhamat, Telredor, Toshley's Station, Area 52
					["0.52:0.51:0.38:0.50:0.42:0.37:0.58:0.27:0.63:0.18"] = 280, -- Temple of Telhamat, Telredor, Toshley's Station, Area 52, The Stormspire
					["0.52:0.51:0.38:0.50:0.42:0.37:0.58:0.27:0.72:0.28"] = 298, -- Temple of Telhamat, Telredor, Toshley's Station, Area 52, Cosmowrench
					["0.52:0.51:0.65:0.58:0.75:0.50"] = 142, -- Temple of Telhamat, Honor Hold, Shatter Point
					["0.52:0.51:0.65:0.58:0.55:0.77:0.69:0.85:0.81:0.77"] = 362, -- Temple of Telhamat, Honor Hold, Allerian Stronghold, Wildhammer Stronghold, Altar of Sha'tar
					["0.52:0.51:0.65:0.58:0.55:0.77:0.69:0.85:0.78:0.85"] = 323, -- Temple of Telhamat, Honor Hold, Allerian Stronghold, Wildhammer Stronghold, Sanctum of the Stars

					-- Alliance: The Stormspire (Netherstorm)
					["0.63:0.18:0.58:0.27:0.42:0.37:0.38:0.50:0.27:0.74"] = 341, -- The Stormspire, Area 52, Toshley's Station, Telredor, Telaar
					["0.63:0.18:0.58:0.27:0.42:0.37:0.38:0.50:0.44:0.67"] = 315, -- The Stormspire, Area 52, Toshley's Station, Telredor, Shattrath
					["0.63:0.18:0.58:0.27:0.42:0.37:0.38:0.50:0.44:0.67:0.55:0.77"] = 390, -- The Stormspire, Area 52, Toshley's Station, Telredor, Shattrath, Allerian Stronghold
					["0.63:0.18:0.58:0.27:0.42:0.37:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85"] = 467, -- The Stormspire, Area 52, Toshley's Station, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold
					["0.63:0.18:0.58:0.27:0.42:0.37:0.38:0.50:0.52:0.51:0.65:0.58"] = 386, -- The Stormspire, Area 52, Toshley's Station, Telredor, Temple of Telhamat, Honor Hold
					["0.63:0.18:0.58:0.27:0.42:0.37:0.38:0.50:0.52:0.51:0.65:0.58:0.79:0.55"] = 448, -- The Stormspire, Area 52, Toshley's Station, Telredor, Temple of Telhamat, Honor Hold, Hellfire Peninsula
					["0.63:0.18:0.58:0.27:0.42:0.37:0.38:0.50:0.52:0.51"] = 302, -- The Stormspire, Area 52, Toshley's Station, Telredor, Temple of Telhamat
					["0.63:0.18:0.58:0.27:0.42:0.37:0.38:0.50"] = 220, -- The Stormspire, Area 52, Toshley's Station, Telredor
					["0.63:0.18:0.32:0.34:0.27:0.44"] = 230, -- The Stormspire, Sylvanaar, Orebor Harborage
					["0.63:0.18:0.58:0.27:0.42:0.37"] = 146, -- The Stormspire, Area 52, Toshley's Station
					["0.63:0.18:0.32:0.34"] = 154, -- The Stormspire, Sylvanaar
					["0.63:0.18:0.58:0.27:0.42:0.28"] = 132, -- The Stormspire, Area 52, Evergrove
					["0.63:0.18:0.58:0.27"] = 53, -- The Stormspire, Area 52
					["0.63:0.18:0.72:0.28"] = 69, -- The Stormspire, Cosmowrench
					["0.63:0.18:0.58:0.27:0.42:0.37:0.38:0.50:0.52:0.51:0.65:0.58:0.75:0.50"] = 440, -- The Stormspire, Area 52, Toshley's Station, Telredor, Temple of Telhamat, Honor Hold, Shatter Point
					["0.63:0.18:0.58:0.27:0.42:0.37:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85:0.81:0.77"] = 549, -- The Stormspire, Area 52, Toshley's Station, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold, Altar of Sha'tar

					-- Alliance: Toshley's Station (Blade's Edge Mountains)
					["0.42:0.37:0.38:0.50:0.27:0.74"] = 265, -- Toshley's Station, Telredor, Telaar
					["0.42:0.37:0.38:0.50:0.44:0.67"] = 170, -- Toshley's Station, Telredor, Shattrath
					["0.42:0.37:0.38:0.50:0.44:0.67:0.55:0.77"] = 245, -- Toshley's Station, Telredor, Shattrath, Allerian Stronghold
					["0.42:0.37:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85"] = 321, -- Toshley's Station, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold
					["0.42:0.37:0.38:0.50:0.52:0.51:0.65:0.58:0.79:0.55"] = 302, -- Toshley's Station, Telredor, Temple of Telhamat, Honor Hold, Hellfire Peninsula
					["0.42:0.37:0.38:0.50:0.52:0.51:0.65:0.58"] = 241, -- Toshley's Station, Telredor, Temple of Telhamat, Honor Hold
					["0.42:0.37:0.38:0.50:0.52:0.51"] = 154, -- Toshley's Station, Telredor, Temple of Telhamat
					["0.42:0.37:0.38:0.50"] = 73, -- Toshley's Station, Telredor
					["0.42:0.37:0.32:0.34:0.27:0.44"] = 134, -- Toshley's Station, Sylvanaar, Orebor Harborage
					["0.42:0.37:0.32:0.34"] = 60, -- Toshley's Station, Sylvanaar
					["0.42:0.37:0.42:0.28"] = 53, -- Toshley's Station, Evergrove
					["0.42:0.37:0.58:0.27"] = 84, -- Toshley's Station, Area 52
					["0.42:0.37:0.58:0.27:0.63:0.18"] = 132, -- Toshley's Station, Area 52, The Stormspire
					["0.42:0.37:0.58:0.27:0.72:0.28"] = 150, -- Toshley's Station, Area 52, Cosmowrench

					-- Alliance: Wildhammer Stronghold (Shadowmoon Valley)
					["0.69:0.85:0.55:0.77:0.27:0.74"] = 249, -- Wildhammer Stronghold, Allerian Stronghold, Telaar
					["0.69:0.85:0.55:0.77:0.44:0.67"] = 174, -- Wildhammer Stronghold, Allerian Stronghold, Shattrath
					["0.69:0.85:0.55:0.77"] = 101, -- Wildhammer Stronghold, Allerian Stronghold
					["0.69:0.85:0.55:0.77:0.65:0.58"] = 196, -- Wildhammer Stronghold, Allerian Stronghold, Honor Hold
					["0.69:0.85:0.55:0.77:0.65:0.58:0.79:0.55"] = 256, -- Wildhammer Stronghold, Allerian Stronghold, Honor Hold, Hellfire Peninsula
					["0.69:0.85:0.55:0.77:0.65:0.58:0.52:0.51"] = 270, -- Wildhammer Stronghold, Allerian Stronghold, Honor Hold, Temple of Telhamat
					["0.69:0.85:0.55:0.77:0.44:0.67:0.38:0.50"] = 257, -- Wildhammer Stronghold, Allerian Stronghold, Shattrath, Telredor
					["0.69:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.27:0.44"] = 320, -- Wildhammer Stronghold, Allerian Stronghold, Shattrath, Telredor, Orebor Harborage
					["0.69:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37"] = 326, -- Wildhammer Stronghold, Allerian Stronghold, Shattrath, Telredor, Toshley's Station
					["0.69:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.32:0.34"] = 348, -- Wildhammer Stronghold, Allerian Stronghold, Shattrath, Telredor, Sylvanaar
					["0.69:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37:0.42:0.28"] = 379, -- Wildhammer Stronghold, Allerian Stronghold, Shattrath, Telredor, Toshley's Station, Evergrove
					["0.69:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37:0.58:0.27"] = 409, -- Wildhammer Stronghold, Allerian Stronghold, Shattrath, Telredor, Toshley's Station, Area 52
					["0.69:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37:0.58:0.27:0.72:0.28"] = 475, -- Wildhammer Stronghold, Allerian Stronghold, Shattrath, Telredor, Toshley's Station, Area 52, Cosmowrench
					["0.69:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37:0.58:0.27:0.63:0.18"] = 457, -- Wildhammer Stronghold, Allerian Stronghold, Shattrath, Telredor, Toshley's Station, Area 52, The Stormspire
					["0.69:0.85:0.81:0.77"] = 84, -- Wildhammer Stronghold, Altar of Sha'tar
					["0.69:0.85:0.55:0.77:0.65:0.58:0.75:0.50"] = 250, -- Wildhammer Stronghold, Allerian Stronghold, Honor Hold, Shatter Point
					["0.69:0.85:0.78:0.85"] = 43, -- Wildhammer Stronghold, Sanctum of the Stars

				},

			},
		}

	end
