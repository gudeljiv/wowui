
FreebgridDB = {
	["namespaces"] = {
		["LibDualSpec-1.0"] = {
			["char"] = {
				["Verminz - Genesis"] = {
					["profile"] = "Default",
					["enabled"] = true,
					["specGroup"] = 1,
				},
				["Mulatz - Genesis"] = {
					["profile"] = "Healer",
					["enabled"] = false,
					["specGroup"] = 2,
				},
			},
		},
	},
	["profileKeys"] = {
		["Blooq - Genesis"] = "Default",
		["Tukac - Genesis"] = "Default",
		["Verminz - Genesis"] = "Default",
		["Vermins - Dreadmist"] = "Vermins - Dreadmist",
		["Konza - Genesis"] = "Default",
		["Malinac - Genesis"] = "Healer",
		["Govance - Dentarg"] = "Default",
		["Mulatz - Genesis"] = "Default",
		["Pepecocorita - Genesis"] = "Default",
		["Handrmandr - Genesis"] = "Default",
		["Spija - Genesis"] = "Default",
		["Nacova - Genesis"] = "Healer",
		["Korupcija - Genesis"] = "Default",
	},
	["profiles"] = {
		["Vermins - Dreadmist"] = {
			["framesposition"] = {
				["__INITIAL"] = {
					["Freebgrid"] = {
						["oUF_FreebgridRaidFrame"] = "LEFTUIParent80",
						["oUF_FreebgridPetFrame"] = "LEFTUIParent2500",
						["oUF_FreebgridMTFrame"] = "TOPLEFTUIParent8-60",
					},
				},
			},
		},
		["Default"] = {
			["roleicon"] = true,
			["afk"] = false,
			["pets"] = true,
			["fontsize"] = 12,
			["texturePath"] = "Interface\\Addons\\Skada\\statusbar\\normTex",
			["texture"] = "TukTex",
			["porientation"] = "HORIZONTAL",
			["reversecolors"] = true,
			["solo"] = false,
			["healbar"] = false,
			["outsideRange"] = 0.3,
			["tooltip"] = false,
			["growth"] = "DOWN",
			["width"] = 60,
			["smooth"] = true,
			["font"] = "Expressway",
			["healoverflow"] = false,
			["framesposition"] = {
				["__INITIAL"] = {
					["Freebgrid"] = {
						["oUF_FreebgridRaidFrame"] = "LEFTUIParent80",
						["oUF_FreebgridPetFrame"] = "LEFTUIParent2500",
						["oUF_FreebgridMTFrame"] = "TOPLEFTUIParent8-60",
					},
				},
				["Freebgrid"] = {
					["oUF_FreebgridPetFrame"] = "LEFTUIParent344-1",
				},
			},
			["height"] = 35,
			["horizontal"] = true,
			["fontPath"] = "Interface\\AddOns\\oUF_Freebgrid\\media\\expressway.ttf",
			["colorSmooth"] = true,
		},
		["Healer"] = {
			["highlight"] = false,
			["roleicon"] = true,
			["texture"] = "TukTex",
			["pets"] = true,
			["petUnits"] = 20,
			["fontsize"] = 12,
			["horizontal"] = true,
			["font"] = "Expressway",
			["fontPath"] = "Interface\\AddOns\\oUF_Freebgrid\\media\\expressway.ttf",
			["texturePath"] = "Interface\\Addons\\Skada\\statusbar\\normTex",
			["smooth"] = true,
			["porientation"] = "HORIZONTAL",
			["tborder"] = false,
			["solo"] = false,
			["petgrowth"] = "DOWN",
			["outsideRange"] = 0.3,
			["tooltip"] = false,
			["growth"] = "DOWN",
			["width"] = 60,
			["colorSmooth"] = true,
			["fborder"] = false,
			["healoverflow"] = false,
			["reversecolors"] = true,
			["height"] = 35,
			["framesposition"] = {
				["__INITIAL"] = {
					["Freebgrid"] = {
						["oUF_FreebgridRaidFrame"] = "LEFTUIParent80",
						["oUF_FreebgridPetFrame"] = "LEFTUIParent2500",
						["oUF_FreebgridMTFrame"] = "TOPLEFTUIParent8-60",
					},
				},
				["Freebgrid"] = {
					["oUF_FreebgridPetFrame"] = "LEFTUIParent62080",
					["oUF_FreebgridRaidFrame"] = "CENTERUIParent-130-149",
				},
			},
			["healbar"] = false,
			["pethorizontal"] = true,
		},
	},
}
