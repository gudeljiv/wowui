-- AST prototype schema for classic
local _, ns = ...
ns.protoSchema = ns.protoSchema or {}
ns.protoSchema['vanilla'] = {
  version = "classic",
  messages = {
    PriestTalents = {
      fields = {
        unbreakable_will = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        wand_specialization = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        silent_resolve = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        improved_power_word_fortitude = {
          id = 4,
          type = "int32",
          label = "optional"
        },
        improved_power_word_shield = {
          id = 5,
          type = "int32",
          label = "optional"
        },
        martyrdom = {
          id = 6,
          type = "int32",
          label = "optional"
        },
        inner_focus = {
          id = 7,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "priest",
              spell_id = 14751,
              label = "Inner Focus",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
              class_token = "priest"
            },
            aura = {
              class = "priest",
              spell_id = 14751,
              label = "Inner Focus",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "priest"
            }
          }
        },
        meditation = {
          id = 8,
          type = "int32",
          label = "optional"
        },
        improved_inner_fire = {
          id = 9,
          type = "int32",
          label = "optional"
        },
        mental_agility = {
          id = 10,
          type = "int32",
          label = "optional"
        },
        improved_mana_burn = {
          id = 11,
          type = "int32",
          label = "optional"
        },
        mental_strength = {
          id = 12,
          type = "int32",
          label = "optional"
        },
        divine_spirit = {
          id = 13,
          type = "bool",
          label = "optional"
        },
        force_of_will = {
          id = 14,
          type = "int32",
          label = "optional"
        },
        power_infusion = {
          id = 15,
          type = "bool",
          label = "optional",
          _metadata = {
            aura = {
              class = "core",
              spell_id = 10060,
              label = "PowerInfusion",
              tag = "PowerInfusion",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "core"
            }
          }
        },
        healing_focus = {
          id = 16,
          type = "int32",
          label = "optional"
        },
        improved_renew = {
          id = 17,
          type = "int32",
          label = "optional"
        },
        holy_specialization = {
          id = 18,
          type = "int32",
          label = "optional"
        },
        spell_warding = {
          id = 19,
          type = "int32",
          label = "optional"
        },
        divine_fury = {
          id = 20,
          type = "int32",
          label = "optional"
        },
        holy_nova = {
          id = 21,
          type = "bool",
          label = "optional"
        },
        blessed_recovery = {
          id = 22,
          type = "int32",
          label = "optional"
        },
        inspiration = {
          id = 23,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "core",
                spell_id = 15363,
                label = "Inspiration",
                duration = {
                  raw = "time.Second * 15",
                  seconds = 15.0
                },
                class_token = "core"
              },
              {
                class = "priest",
                label = "Inspiration Talent",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "priest"
              }
            }
          }
        },
        holy_reach = {
          id = 24,
          type = "int32",
          label = "optional"
        },
        improved_healing = {
          id = 25,
          type = "int32",
          label = "optional"
        },
        searing_light = {
          id = 26,
          type = "int32",
          label = "optional"
        },
        improved_prayer_of_healing = {
          id = 27,
          type = "int32",
          label = "optional"
        },
        spirit_of_redemption = {
          id = 28,
          type = "bool",
          label = "optional"
        },
        spiritual_guidance = {
          id = 29,
          type = "int32",
          label = "optional"
        },
        spiritual_healing = {
          id = 30,
          type = "int32",
          label = "optional"
        },
        lightwell = {
          id = 31,
          type = "bool",
          label = "optional"
        },
        spirit_tap = {
          id = 32,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "priest",
              label = "Spirit Tap",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "priest"
            }
          }
        },
        blackout = {
          id = 33,
          type = "int32",
          label = "optional"
        },
        shadow_affinity = {
          id = 34,
          type = "int32",
          label = "optional"
        },
        improved_shadow_word_pain = {
          id = 35,
          type = "int32",
          label = "optional"
        },
        shadow_focus = {
          id = 36,
          type = "int32",
          label = "optional"
        },
        improved_psychic_scream = {
          id = 37,
          type = "int32",
          label = "optional"
        },
        improved_mind_blast = {
          id = 38,
          type = "int32",
          label = "optional"
        },
        mind_flay = {
          id = 39,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "priest",
              spell_id = 20303,
              label = "MindFlay",
              flags = "flags",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "priest"
            }
          }
        },
        improved_fade = {
          id = 40,
          type = "int32",
          label = "optional"
        },
        shadow_reach = {
          id = 41,
          type = "int32",
          label = "optional"
        },
        shadow_weaving = {
          id = 42,
          type = "int32",
          label = "optional",
          _metadata = {
            export = "ShadowWeaving",
            field_alias = "shadowWeaving",
            ids = {
              spell = {
                15334
              }
            },
            aura = {
              class = "core",
              spell_id = 15257,
              label = "Shadow Weaving",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              variants = {
                {
                  rank = 1,
                  spell_id = 15257
                },
                {
                  rank = 2,
                  spell_id = 15331
                },
                {
                  rank = 3,
                  spell_id = 15332
                },
                {
                  rank = 4,
                  spell_id = 15333
                },
                {
                  rank = 5,
                  spell_id = 15334
                }
              },
              class_token = "core"
            },
            spell = {
              class = "priest",
              label = "Shadow Weaving",
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagNoMetrics",
              spell_school = "SpellSchoolShadow",
              class_token = "priest"
            }
          }
        },
        silence = {
          id = 43,
          type = "bool",
          label = "optional"
        },
        vampiric_embrace = {
          id = 44,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "priest",
              spell_id = 15286,
              label = "Vampiric Embrace",
              flags = "SpellFlagPriest | core.SpellFlagAPL",
              spell_school = "SpellSchoolShadow",
              proc_mask = "2",
              class_token = "priest"
            },
            aura = {
              class = "priest",
              spell_id = 15286,
              label = "Vampiric Embrace (Health)",
              duration = {
                raw = "time.Minute * 1",
                seconds = 60.0
              },
              class_token = "priest"
            }
          }
        },
        improved_vampiric_embrace = {
          id = 45,
          type = "int32",
          label = "optional"
        },
        darkness = {
          id = 46,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "priest",
              label = "Darkness",
              class_token = "priest"
            }
          }
        },
        shadowform = {
          id = 47,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "priest",
              spell_id = 15473,
              label = "Shadowform",
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
              class_token = "priest"
            },
            aura = {
              class = "priest",
              spell_id = 15473,
              label = "Shadowform",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "priest"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "unbreakable_will",
        "wand_specialization",
        "silent_resolve",
        "improved_power_word_fortitude",
        "improved_power_word_shield",
        "martyrdom",
        "inner_focus",
        "meditation",
        "improved_inner_fire",
        "mental_agility",
        "improved_mana_burn",
        "mental_strength",
        "divine_spirit",
        "force_of_will",
        "power_infusion",
        "healing_focus",
        "improved_renew",
        "holy_specialization",
        "spell_warding",
        "divine_fury",
        "holy_nova",
        "blessed_recovery",
        "inspiration",
        "holy_reach",
        "improved_healing",
        "searing_light",
        "improved_prayer_of_healing",
        "spirit_of_redemption",
        "spiritual_guidance",
        "spiritual_healing",
        "lightwell",
        "spirit_tap",
        "blackout",
        "shadow_affinity",
        "improved_shadow_word_pain",
        "shadow_focus",
        "improved_psychic_scream",
        "improved_mind_blast",
        "mind_flay",
        "improved_fade",
        "shadow_reach",
        "shadow_weaving",
        "silence",
        "vampiric_embrace",
        "improved_vampiric_embrace",
        "darkness",
        "shadowform"
      }
    },
    Rotation = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      }
    },
    Options = {
      fields = {
        use_shadowfiend = {
          id = 1,
          type = "bool",
          label = "optional"
        },
        armor = {
          id = 2,
          type = "enum",
          label = "optional",
          enum_type = "Armor"
        },
        use_mind_blast = {
          id = 4,
          type = "bool",
          label = "optional"
        },
        power_infusion_target = {
          id = 5,
          type = "message",
          label = "optional",
          message_type = "UnitReference"
        },
        latency = {
          id = 6,
          type = "double",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "use_shadowfiend",
        "armor",
        "use_mind_blast",
        "power_infusion_target",
        "latency"
      }
    },
    ShadowPriest = {
      fields = {
        options = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "Options"
        }
      },
      oneofs = {

      },
      field_order = {
        "options"
      }
    },
    HealingPriest = {
      fields = {
        options = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "Options"
        }
      },
      oneofs = {

      },
      field_order = {
        "options"
      }
    },
    UnitStats = {
      fields = {
        stats = {
          id = 1,
          type = "double",
          label = "repeated"
        },
        pseudo_stats = {
          id = 2,
          type = "double",
          label = "repeated"
        }
      },
      oneofs = {

      },
      field_order = {
        "stats",
        "pseudo_stats"
      }
    },
    MiscConsumes = {
      fields = {
        bogling_root = {
          id = 1,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "BoglingRoot",
            field_alias = "boglingRoot",
            ids = {
              item = {
                5206
              }
            }
          }
        },
        juju_ember = {
          id = 2,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "JujuEmber",
            field_alias = "jujuEmber",
            ids = {
              item = {
                12455
              }
            }
          }
        },
        juju_chill = {
          id = 3,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "JujuChill",
            field_alias = "jujuChill",
            ids = {
              item = {
                12457
              }
            }
          }
        },
        juju_escape = {
          id = 4,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "JujuEscape",
            field_alias = "jujuEscape",
            ids = {
              item = {
                12459
              }
            }
          }
        },
        juju_flurry = {
          id = 5,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "JujuFlurry",
            field_alias = "jujuFlurry",
            ids = {
              item = {
                12450
              }
            }
          }
        },
        raptor_punch = {
          id = 6,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "RaptorPunch",
            field_alias = "raptorPunch",
            ids = {
              item = {
                5342
              }
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "bogling_root",
        "juju_ember",
        "juju_chill",
        "juju_escape",
        "juju_flurry",
        "raptor_punch"
      }
    },
    PetMiscConsumes = {
      fields = {
        juju_flurry = {
          id = 1,
          type = "bool",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "juju_flurry"
      }
    },
    RaidBuffs = {
      fields = {
        gift_of_the_wild = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            export = "GiftOfTheWild",
            field_alias = "giftOfTheWild",
            ids = {
              spell = {
                9885
              }
            },
            extras = {
              imp_id = "ActionId.fromSpellId(17055)"
            }
          }
        },
        power_word_fortitude = {
          id = 2,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect"
        },
        blood_pact = {
          id = 3,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            export = "BloodPact",
            field_alias = "bloodPact",
            ids = {
              spell = {
                11767
              }
            },
            extras = {
              imp_id = "ActionId.fromSpellId(18696)"
            }
          }
        },
        strength_of_earth_totem = {
          id = 4,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            export = "StrengthOfEarthTotem",
            field_alias = "strengthOfEarthTotem",
            ids = {
              spell = {
                25361
              }
            },
            show_when = "player => player.getFaction() === Faction.Horde",
            extras = {
              imp_id = "ActionId.fromSpellId(16295)"
            },
            spell = {
              class = "shaman",
              label = "Strength Of Earth Totem",
              flags = "SpellFlagShaman | SpellFlagTotem | core.SpellFlagAPL",
              class_token = "shaman"
            },
            aura = {
              class = "core",
              label = "Strength of Earth Totem",
              duration = {
                raw = "time.Minute * 2",
                seconds = 120.0
              },
              class_token = "core"
            }
          }
        },
        grace_of_air_totem = {
          id = 5,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            export = "GraceOfAirTotem",
            field_alias = "graceOfAirTotem",
            ids = {
              spell = {
                25359
              }
            },
            show_when = "player => player.getFaction() === Faction.Horde",
            extras = {
              imp_id = "ActionId.fromSpellId(16295)"
            },
            spell = {
              class = "shaman",
              label = "Grace Of Air Totem",
              flags = "SpellFlagShaman | SpellFlagTotem | core.SpellFlagAPL",
              class_token = "shaman"
            },
            aura = {
              class = "core",
              label = "Grace of Air Totem",
              duration = {
                raw = "time.Minute * 2",
                seconds = 120.0
              },
              class_token = "core"
            }
          }
        },
        arcane_brilliance = {
          id = 6,
          type = "bool",
          label = "optional"
        },
        divine_spirit = {
          id = 7,
          type = "bool",
          label = "optional"
        },
        battle_shout = {
          id = 8,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            export = "BattleShout",
            field_alias = "battleShout",
            ids = {
              spell = {
                25289
              }
            },
            extras = {
              imp_id = "ActionId.fromSpellId(12861)"
            },
            aura = {
              class = "core",
              spell_id = 6673,
              label = "Battle Shout",
              duration = {
                raw = "time.Duration(float64(time.Minute*2) * (1 + 0.1*float64(boomingVoicePts)))"
              },
              variants = {
                {
                  rank = 1,
                  spell_id = 6673,
                  base_ap = 20
                },
                {
                  rank = 2,
                  spell_id = 5242,
                  base_ap = 40
                },
                {
                  rank = 3,
                  spell_id = 6192,
                  base_ap = 57
                },
                {
                  rank = 4,
                  spell_id = 11549,
                  base_ap = 93
                },
                {
                  rank = 5,
                  spell_id = 11550,
                  base_ap = 138
                },
                {
                  rank = 6,
                  spell_id = 11551,
                  base_ap = 193
                },
                {
                  rank = 7,
                  spell_id = 25289,
                  base_ap = 232
                }
              },
              class_token = "core"
            }
          }
        },
        trueshot_aura = {
          id = 9,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "TrueshotAura",
            field_alias = "trueshotAura",
            ids = {
              spell = {
                20906
              }
            },
            category = "ATTACK_POWER",
            ["function"] = "TrueshotAura",
            label = "Trueshot Aura",
            spell_id = 20906,
            tags = {
              "raid"
            },
            extras = {
              functions = {
                "TrueshotAura"
              }
            }
          }
        },
        furious_howl = {
          id = 11,
          type = "bool",
          label = "optional"
        },
        leader_of_the_pack = {
          id = 12,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "LeaderOfThePack",
            field_alias = "leaderOfThePack",
            ids = {
              spell = {
                24932
              }
            }
          }
        },
        moonkin_aura = {
          id = 13,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "MoonkinAura",
            field_alias = "moonkinAura",
            ids = {
              spell = {
                24907
              }
            }
          }
        },
        mana_spring_totem = {
          id = 14,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            spell = {
              class = "shaman",
              label = "Mana Spring Totem",
              flags = "SpellFlagShaman | SpellFlagTotem | core.SpellFlagAPL",
              class_token = "shaman"
            }
          }
        },
        blessing_of_wisdom = {
          id = 15,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect"
        },
        shadow_protection = {
          id = 16,
          type = "bool",
          label = "optional"
        },
        shadow_resistance_aura = {
          id = 35,
          type = "bool",
          label = "optional"
        },
        nature_resistance_totem = {
          id = 17,
          type = "bool",
          label = "optional"
        },
        aspect_of_the_wild = {
          id = 18,
          type = "bool",
          label = "optional"
        },
        frost_resistance_aura = {
          id = 19,
          type = "bool",
          label = "optional"
        },
        frost_resistance_totem = {
          id = 20,
          type = "bool",
          label = "optional"
        },
        fire_resistance_totem = {
          id = 21,
          type = "bool",
          label = "optional"
        },
        fire_resistance_aura = {
          id = 32,
          type = "bool",
          label = "optional"
        },
        scroll_of_protection = {
          id = 26,
          type = "bool",
          label = "optional"
        },
        scroll_of_stamina = {
          id = 27,
          type = "bool",
          label = "optional"
        },
        scroll_of_strength = {
          id = 28,
          type = "bool",
          label = "optional"
        },
        scroll_of_agility = {
          id = 29,
          type = "bool",
          label = "optional"
        },
        scroll_of_intellect = {
          id = 30,
          type = "bool",
          label = "optional"
        },
        scroll_of_spirit = {
          id = 31,
          type = "bool",
          label = "optional"
        },
        thorns = {
          id = 22,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            export = "Thorns",
            field_alias = "thorns",
            ids = {
              spell = {
                9910
              }
            },
            extras = {
              imp_id = "ActionId.fromSpellId(16840)"
            },
            aura = {
              class = "core",
              spell_id = 9910,
              label = "Thorns",
              class_token = "core"
            },
            spell = {
              class = "core",
              spell_id = 9910,
              label = "Thorns",
              flags = "SpellFlagBinary | SpellFlagNoOnCastComplete | SpellFlagPassiveSpell",
              spell_school = "SpellSchoolNature",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "core"
            }
          }
        },
        devotion_aura = {
          id = 23,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            export = "DevotionAura",
            field_alias = "devotionAura",
            ids = {
              spell = {
                10293
              }
            },
            show_when = "player => player.getFaction() === Faction.Alliance",
            extras = {
              imp_id = "ActionId.fromSpellId(20142)"
            },
            aura = {
              class = "core",
              spell_id = 10293,
              label = "Devotion Aura",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "core"
            }
          }
        },
        stoneskin_totem = {
          id = 24,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            export = "StoneskinTotem",
            field_alias = "stoneskinTotem",
            ids = {
              spell = {
                10408
              }
            },
            show_when = "player => player.getFaction() === Faction.Horde",
            extras = {
              imp_id = "ActionId.fromSpellId(16293)"
            },
            spell = {
              class = "shaman",
              spell_id = 10408,
              label = "Stoneskin",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "shaman"
            },
            aura = {
              class = "core",
              spell_id = 10408,
              label = "Stoneskin",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "core"
            }
          }
        },
        retribution_aura = {
          id = 25,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            export = "RetributionAura",
            field_alias = "retributionAura",
            ids = {
              spell = {
                10301
              }
            },
            show_when = "player => player.getFaction() === Faction.Alliance",
            extras = {
              imp_id = "ActionId.fromSpellId(20092)"
            }
          }
        },
        sanctity_aura = {
          id = 33,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "SanctityAura",
            field_alias = "sanctityAura",
            ids = {
              spell = {
                20218
              }
            },
            show_when = "player => player.getFaction() === Faction.Alliance",
            aura = {
              class = "core",
              spell_id = 20218,
              label = "Sanctity Aura",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "core"
            }
          }
        },
        battle_squawk = {
          id = 34,
          type = "int32",
          label = "optional",
          _metadata = {
            export = "BattleSquawkBuff",
            field_alias = "battleSquawk",
            ids = {
              spell = {
                23060
              }
            },
            num_states = 6,
            aura = {
              class = "core",
              spell_id = 23060,
              label = "Battle Squawk",
              duration = {
                raw = "time.Minute * 4",
                seconds = 240.0
              },
              class_token = "core"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "gift_of_the_wild",
        "power_word_fortitude",
        "blood_pact",
        "strength_of_earth_totem",
        "grace_of_air_totem",
        "arcane_brilliance",
        "divine_spirit",
        "battle_shout",
        "trueshot_aura",
        "furious_howl",
        "leader_of_the_pack",
        "moonkin_aura",
        "mana_spring_totem",
        "blessing_of_wisdom",
        "shadow_protection",
        "shadow_resistance_aura",
        "nature_resistance_totem",
        "aspect_of_the_wild",
        "frost_resistance_aura",
        "frost_resistance_totem",
        "fire_resistance_totem",
        "fire_resistance_aura",
        "scroll_of_protection",
        "scroll_of_stamina",
        "scroll_of_strength",
        "scroll_of_agility",
        "scroll_of_intellect",
        "scroll_of_spirit",
        "thorns",
        "devotion_aura",
        "stoneskin_totem",
        "retribution_aura",
        "sanctity_aura",
        "battle_squawk"
      },
      _metadata = {
        spell_crit_buff = {
          source = "extern/wowsims-classic/ui/core/components/inputs/buffs_debuffs.ts",
          export = "SpellCritBuff",
          ids = {
            spell = {
              24907
            }
          },
          stats = {
            "StatSpellCrit"
          }
        },
        melee_crit_buff = {
          source = "extern/wowsims-classic/ui/core/components/inputs/buffs_debuffs.ts",
          export = "MeleeCritBuff",
          ids = {
            spell = {
              24932
            }
          },
          stats = {
            "StatMeleeCrit"
          }
        },
        mana_spring_totem = {
          source = "extern/wowsims-classic/ui/core/components/inputs/buffs_debuffs.ts",
          export = "ManaSpringTotem",
          ids = {
            spell = {
              10497
            }
          },
          stats = {
            "StatMP5"
          }
        },
        blessing_of_wisdom = {
          source = "extern/wowsims-classic/ui/core/components/inputs/buffs_debuffs.ts",
          export = "BlessingOfWisdom",
          ids = {
            spell = {
              25290
            }
          },
          stats = {
            "StatMP5"
          }
        },
        trueshot_aura_buff = {
          source = "extern/wowsims-classic/ui/core/components/inputs/buffs_debuffs.ts",
          export = "TrueshotAuraBuff",
          ids = {
            spell = {
              20906
            }
          },
          stats = {
            "StatAttackPower",
            "StatRangedAttackPower"
          }
        },
        battle_shout_buff = {
          source = "extern/wowsims-classic/ui/core/components/inputs/buffs_debuffs.ts",
          export = "BattleShoutBuff",
          ids = {
            spell = {
              25289
            }
          },
          stats = {
            "StatAttackPower"
          }
        },
        grace_of_air = {
          source = "extern/wowsims-classic/ui/core/components/inputs/buffs_debuffs.ts",
          export = "GraceOfAir",
          ids = {
            spell = {
              25359
            }
          },
          stats = {
            "StatAgility"
          }
        },
        strength_buff_horde = {
          source = "extern/wowsims-classic/ui/core/components/inputs/buffs_debuffs.ts",
          export = "StrengthBuffHorde",
          ids = {
            spell = {
              25361
            }
          },
          stats = {
            "StatStrength"
          }
        },
        blessing_of_might = {
          source = "extern/wowsims-classic/ui/core/components/inputs/buffs_debuffs.ts",
          export = "BlessingOfMight",
          ids = {
            spell = {
              25291
            }
          },
          stats = {
            "StatAgility",
            "StatAttackPower",
            "StatStrength"
          }
        },
        blood_pact_buff = {
          source = "extern/wowsims-classic/ui/core/components/inputs/buffs_debuffs.ts",
          export = "BloodPactBuff",
          ids = {
            spell = {
              11767
            }
          },
          stats = {

          }
        },
        phys_dam_reduction_buff = {
          source = "extern/wowsims-classic/ui/core/components/inputs/buffs_debuffs.ts",
          export = "PhysDamReductionBuff",
          ids = {
            spell = {
              10408
            }
          },
          stats = {
            "StatArmor"
          }
        },
        armor_buff = {
          source = "extern/wowsims-classic/ui/core/components/inputs/buffs_debuffs.ts",
          export = "ArmorBuff",
          ids = {
            spell = {
              10293
            }
          },
          stats = {
            "StatArmor"
          }
        },
        blessing_of_kings = {
          source = "extern/wowsims-classic/ui/core/components/inputs/buffs_debuffs.ts",
          export = "BlessingOfKings",
          ids = {
            spell = {
              20217
            }
          },
          stats = {

          }
        },
        all_stats_buff = {
          source = "extern/wowsims-classic/ui/core/components/inputs/buffs_debuffs.ts",
          export = "AllStatsBuff",
          ids = {
            spell = {
              9885
            }
          },
          stats = {

          }
        }
      }
    },
    PartyBuffs = {
      fields = {
        atiesh_mage = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        atiesh_warlock = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        atiesh_druid = {
          id = 4,
          type = "int32",
          label = "optional"
        },
        atiesh_priest = {
          id = 5,
          type = "int32",
          label = "optional"
        },
        mana_tide_totems = {
          id = 3,
          type = "int32",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "atiesh_mage",
        "atiesh_warlock",
        "atiesh_druid",
        "atiesh_priest",
        "mana_tide_totems"
      }
    },
    IndividualBuffs = {
      fields = {
        blessing_of_kings = {
          id = 1,
          type = "bool",
          label = "optional",
          _metadata = {
            aura = {
              class = "core",
              spell_id = 20217,
              label = "Blessing of Kings",
              class_token = "core"
            }
          }
        },
        blessing_of_wisdom = {
          id = 2,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect"
        },
        blessing_of_might = {
          id = 3,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            aura = {
              class = "core",
              label = "Blessing of Might",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "core"
            }
          }
        },
        blessing_of_sanctuary = {
          id = 4,
          type = "bool",
          label = "optional"
        },
        innervates = {
          id = 5,
          type = "int32",
          label = "optional",
          _metadata = {
            export = "Innervate",
            field_alias = "innervates",
            ids = {
              spell = {
                29166
              }
            },
            num_states = 11
          }
        },
        power_infusions = {
          id = 6,
          type = "int32",
          label = "optional",
          _metadata = {
            export = "PowerInfusion",
            field_alias = "powerInfusions",
            ids = {
              spell = {
                10060
              }
            },
            num_states = 11
          }
        },
        rallying_cry_of_the_dragonslayer = {
          id = 7,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "RallyingCryOfTheDragonslayer",
            field_alias = "rallyingCryOfTheDragonslayer",
            ids = {
              spell = {
                22888
              }
            },
            aura = {
              class = "core",
              spell_id = 22888,
              label = "Rallying Cry of the Dragonslayer",
              class_token = "core"
            }
          }
        },
        sayges_fortune = {
          id = 8,
          type = "enum",
          label = "optional",
          enum_type = "SaygesFortune"
        },
        spirit_of_zandalar = {
          id = 9,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "SpiritOfZandalar",
            field_alias = "spiritOfZandalar",
            ids = {
              spell = {
                24425
              }
            },
            aura = {
              class = "core",
              spell_id = 24425,
              label = "Spirit of Zandalar",
              class_token = "core"
            }
          }
        },
        songflower_serenade = {
          id = 10,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "SongflowerSerenade",
            field_alias = "songflowerSerenade",
            ids = {
              spell = {
                15366
              }
            },
            aura = {
              class = "core",
              spell_id = 15366,
              label = "Songflower Serenade",
              class_token = "core"
            }
          }
        },
        warchiefs_blessing = {
          id = 11,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "WarchiefsBlessing",
            field_alias = "warchiefsBlessing",
            ids = {
              spell = {
                16609
              }
            },
            aura = {
              class = "core",
              spell_id = 16609,
              label = "Warchief's Blessing",
              class_token = "core"
            }
          }
        },
        fengus_ferocity = {
          id = 12,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "FengusFerocity",
            field_alias = "fengusFerocity",
            ids = {
              spell = {
                22817
              }
            },
            aura = {
              class = "core",
              spell_id = 22817,
              label = "Fengus' Ferocity",
              class_token = "core"
            }
          }
        },
        moldars_moxie = {
          id = 13,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "MoldarsMoxie",
            field_alias = "moldarsMoxie",
            ids = {
              spell = {
                22818
              }
            },
            aura = {
              class = "core",
              spell_id = 22818,
              label = "Moldar's Moxie",
              class_token = "core"
            }
          }
        },
        slipkiks_savvy = {
          id = 14,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "SlipKiksSavvy",
            field_alias = "slipkiksSavvy",
            ids = {
              spell = {
                22820
              }
            },
            aura = {
              class = "core",
              spell_id = 22820,
              label = "Slip'kik's Savvy",
              class_token = "core"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "blessing_of_kings",
        "blessing_of_wisdom",
        "blessing_of_might",
        "blessing_of_sanctuary",
        "innervates",
        "power_infusions",
        "rallying_cry_of_the_dragonslayer",
        "sayges_fortune",
        "spirit_of_zandalar",
        "songflower_serenade",
        "warchiefs_blessing",
        "fengus_ferocity",
        "moldars_moxie",
        "slipkiks_savvy"
      }
    },
    Consumes = {
      fields = {
        flask = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "Flask",
          _metadata = {
            export = "FlaskOfTheTitans",
            field_alias = "flask",
            ids = {
              item = {
                13510
              }
            },
            value = "Flask.FlaskOfTheTitans"
          }
        },
        food = {
          id = 2,
          type = "enum",
          label = "optional",
          enum_type = "Food",
          _metadata = {
            export = "DirgesKickChimaerokChops",
            field_alias = "food",
            ids = {
              item = {
                21023
              }
            },
            value = "Food.FoodDirgesKickChimaerokChops"
          }
        },
        agility_elixir = {
          id = 3,
          type = "enum",
          label = "optional",
          enum_type = "AgilityElixir"
        },
        mana_regen_elixir = {
          id = 4,
          type = "enum",
          label = "optional",
          enum_type = "ManaRegenElixir"
        },
        strength_buff = {
          id = 5,
          type = "enum",
          label = "optional",
          enum_type = "StrengthBuff"
        },
        attack_power_buff = {
          id = 6,
          type = "enum",
          label = "optional",
          enum_type = "AttackPowerBuff"
        },
        spell_power_buff = {
          id = 7,
          type = "enum",
          label = "optional",
          enum_type = "SpellPowerBuff"
        },
        shadow_power_buff = {
          id = 8,
          type = "enum",
          label = "optional",
          enum_type = "ShadowPowerBuff"
        },
        fire_power_buff = {
          id = 9,
          type = "enum",
          label = "optional",
          enum_type = "FirePowerBuff"
        },
        frost_power_buff = {
          id = 10,
          type = "enum",
          label = "optional",
          enum_type = "FrostPowerBuff"
        },
        filler_explosive = {
          id = 11,
          type = "enum",
          label = "optional",
          enum_type = "Explosive",
          _metadata = {
            export = "ExplosiveSolidDynamite",
            field_alias = "fillerExplosive",
            ids = {
              item = {
                10507
              }
            },
            value = "Explosive.ExplosiveSolidDynamite",
            show_when = "player => player.hasProfession(Profession.Engineering)"
          }
        },
        main_hand_imbue = {
          id = 12,
          type = "enum",
          label = "optional",
          enum_type = "WeaponImbue"
        },
        off_hand_imbue = {
          id = 13,
          type = "enum",
          label = "optional",
          enum_type = "WeaponImbue"
        },
        default_potion = {
          id = 14,
          type = "enum",
          label = "optional",
          enum_type = "Potions",
          _metadata = {
            export = "GreaterHealingPotion",
            field_alias = "defaultPotion",
            ids = {
              item = {
                1710
              }
            },
            value = "Potions.GreaterHealingPotion",
            show_when = "player => player.getClass() == Class.ClassWarrior"
          }
        },
        default_conjured = {
          id = 15,
          type = "enum",
          label = "optional",
          enum_type = "Conjured",
          _metadata = {
            export = "ConjuredHealthstone",
            field_alias = "defaultConjured",
            ids = {
              item = {
                5509
              }
            },
            value = "Conjured.ConjuredHealthstone",
            show_when = "(player: Player<any>) => player.getGear().hasTrinket(4381)"
          }
        },
        bogling_root = {
          id = 16,
          type = "bool",
          label = "optional"
        },
        pet_agility_consumable = {
          id = 17,
          type = "int32",
          label = "optional"
        },
        pet_strength_consumable = {
          id = 18,
          type = "int32",
          label = "optional"
        },
        dragon_breath_chili = {
          id = 19,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "DragonBreathChili",
            field_alias = "dragonBreathChili",
            ids = {
              item = {
                12217
              }
            },
            aura = {
              class = "core",
              spell_id = 15852,
              label = "Dragonbreath Chili",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "core"
            },
            spell = {
              class = "core",
              spell_id = 15851,
              label = "Dragon Breath Chili",
              flags = "SpellFlagNoOnCastComplete | SpellFlagPassiveSpell",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamageProc | ProcMaskSpellProc",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "core"
            }
          }
        },
        misc_consumes = {
          id = 20,
          type = "message",
          label = "optional",
          message_type = "MiscConsumes",
          _metadata = {
            spell = {
              {
                class = "core",
                spell_id = 16321,
                label = "Misc Consumes",
                cooldown = {
                  raw = "time.Minute",
                  seconds = 60.0
                },
                major_cooldown = {
                  type = "CooldownTypeSurvival",
                  priority = "CooldownPriorityDefault"
                },
                proc_mask = "2",
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 16322,
                label = "Misc Consumes",
                cooldown = {
                  raw = "time.Minute",
                  seconds = 60.0
                },
                major_cooldown = {
                  type = "CooldownTypeDPS",
                  priority = "CooldownPriorityDefault"
                },
                proc_mask = "2",
                class_token = "core"
              }
            },
            aura = {
              {
                class = "core",
                spell_id = 16321,
                label = "Juju Escape",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 16322,
                label = "Juju Flurry",
                duration = {
                  raw = "time.Second * 20",
                  seconds = 20.0
                },
                class_token = "core"
              }
            }
          }
        },
        zanza_buff = {
          id = 21,
          type = "enum",
          label = "optional",
          enum_type = "ZanzaBuff"
        },
        armor_elixir = {
          id = 22,
          type = "enum",
          label = "optional",
          enum_type = "ArmorElixir"
        },
        health_elixir = {
          id = 23,
          type = "enum",
          label = "optional",
          enum_type = "HealthElixir"
        },
        alcohol = {
          id = 24,
          type = "enum",
          label = "optional",
          enum_type = "Alcohol",
          _metadata = {
            export = "RumseyRumBlackLabel",
            field_alias = "alcohol",
            ids = {
              item = {
                21151
              }
            },
            value = "Alcohol.AlcoholRumseyRumBlackLabel"
          }
        },
        pet_attack_power_consumable = {
          id = 25,
          type = "int32",
          label = "optional"
        },
        pet_misc_consumes = {
          id = 27,
          type = "message",
          label = "optional",
          message_type = "PetMiscConsumes"
        },
        sapper_explosive = {
          id = 28,
          type = "enum",
          label = "optional",
          enum_type = "SapperExplosive",
          _metadata = {
            export = "SapperGoblinSapper",
            field_alias = "sapperExplosive",
            ids = {
              item = {
                10646
              }
            },
            value = "SapperExplosive.SapperGoblinSapper",
            show_when = "player => player.hasProfession(Profession.Engineering)"
          }
        },
        hit_consumable = {
          id = 29,
          type = "enum",
          label = "optional",
          enum_type = "HitConsumable"
        }
      },
      oneofs = {

      },
      field_order = {
        "flask",
        "food",
        "agility_elixir",
        "mana_regen_elixir",
        "strength_buff",
        "attack_power_buff",
        "spell_power_buff",
        "shadow_power_buff",
        "fire_power_buff",
        "frost_power_buff",
        "filler_explosive",
        "main_hand_imbue",
        "off_hand_imbue",
        "default_potion",
        "default_conjured",
        "bogling_root",
        "pet_agility_consumable",
        "pet_strength_consumable",
        "dragon_breath_chili",
        "misc_consumes",
        "zanza_buff",
        "armor_elixir",
        "health_elixir",
        "alcohol",
        "pet_attack_power_consumable",
        "pet_misc_consumes",
        "sapper_explosive",
        "hit_consumable"
      }
    },
    Debuffs = {
      fields = {
        judgement_of_wisdom = {
          id = 1,
          type = "bool",
          label = "optional",
          _metadata = {
            aura = {
              class = "core",
              spell_id = 20355,
              label = "Judgement of Wisdom",
              tag = "Judgement",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "core"
            }
          }
        },
        judgement_of_light = {
          id = 2,
          type = "bool",
          label = "optional",
          _metadata = {
            aura = {
              class = "core",
              spell_id = 20271,
              label = "Judgement of Light",
              tag = "Judgement",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "core"
            }
          }
        },
        judgement_of_the_crusader = {
          id = 25,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            aura = {
              {
                class = "core",
                spell_id = 20303,
                label = "Judgement of the Crusader",
                tag = "Judgement",
                duration = {
                  raw = "10 * time.Second",
                  seconds = 10.0
                },
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 20303,
                label = "Judgement of the Crusader",
                tag = "Judgement",
                duration = {
                  raw = "10 * time.Second",
                  seconds = 10.0
                },
                class_token = "core"
              }
            }
          }
        },
        faerie_fire = {
          id = 3,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 9907,
              label = "Faerie Fire",
              flags = "core.SpellFlagNone",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "druid"
            },
            ["function"] = "FaerieFireAura",
            tags = {
              "raid"
            },
            extras = {
              functions = {
                "FaerieFireAura"
              }
            }
          }
        },
        curse_of_elements = {
          id = 4,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "WarlockCursesConfig",
            field_alias = "CurseOfElements",
            ids = {
              spell = {
                11722
              }
            },
            stats = {
              "Stat.StatSpellDamage",
              "Stat.StatSpellPower"
            },
            values = {
              "CurseOfElements",
              "CurseOfShadow"
            },
            aura = {
              class = "core",
              spell_id = 11722,
              label = "Curse of Elements",
              duration = {
                raw = "time.Minute * 5",
                seconds = 300.0
              },
              class_token = "core"
            },
            spell = {
              class = "warlock",
              label = "Curse Of Elements",
              flags = "core.SpellFlagAPL | WarlockFlagAffliction",
              spell_school = "SpellSchoolShadow",
              proc_mask = "2",
              threat_multiplier = "1",
              class_token = "warlock"
            },
            ["function"] = "CurseOfElementsAura",
            label = "Curse of Elements",
            spell_id = 11722,
            tags = {
              "raid"
            },
            extras = {
              functions = {
                "CurseOfElementsAura"
              }
            }
          }
        },
        curse_of_shadow = {
          id = 5,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "WarlockCursesConfig",
            field_alias = "CurseOfShadow",
            ids = {
              spell = {
                17937
              }
            },
            stats = {
              "Stat.StatSpellDamage",
              "Stat.StatSpellPower"
            },
            values = {
              "CurseOfElements",
              "CurseOfShadow"
            },
            aura = {
              class = "core",
              spell_id = 17937,
              label = "Curse of Shadow",
              duration = {
                raw = "time.Minute * 5",
                seconds = 300.0
              },
              class_token = "core"
            },
            spell = {
              class = "warlock",
              label = "Curse Of Shadow",
              flags = "core.SpellFlagAPL | WarlockFlagAffliction",
              spell_school = "SpellSchoolShadow",
              proc_mask = "2",
              threat_multiplier = "1",
              class_token = "warlock"
            },
            ["function"] = "CurseOfShadowAura",
            label = "Curse of Shadow",
            spell_id = 17937,
            tags = {
              "raid"
            },
            extras = {
              functions = {
                "CurseOfShadowAura"
              }
            }
          }
        },
        winters_chill = {
          id = 6,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "WintersChill",
            field_alias = "wintersChill",
            ids = {
              spell = {
                28595
              }
            },
            aura = {
              class = "core",
              spell_id = 28593,
              label = "Winter's Chill",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "core"
            }
          }
        },
        improved_shadow_bolt = {
          id = 7,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "ImprovedShadowBolt",
            field_alias = "improvedShadowBolt",
            ids = {
              spell = {
                17803
              }
            },
            aura = {
              class = "core",
              spell_id = 17800,
              label = "Improved Shadow Bolt",
              duration = {
                raw = "12 * time.Second",
                seconds = 12.0
              },
              class_token = "core"
            }
          }
        },
        improved_scorch = {
          id = 8,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "ImprovedScorch",
            field_alias = "improvedScorch",
            ids = {
              spell = {
                12873
              }
            },
            aura = {
              class = "core",
              spell_id = 12873,
              label = "Improved Scorch",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "core"
            }
          }
        },
        shadow_weaving = {
          id = 22,
          type = "bool",
          label = "optional",
          _metadata = {
            ["function"] = "ShadowWeavingAura",
            label = "Shadow Weaving",
            tags = {
              "raid"
            },
            extras = {
              functions = {
                "SchedulePeriodicDebuffApplication",
                "ShadowWeavingAura"
              }
            }
          }
        },
        stormstrike = {
          id = 23,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "Stormstrike",
            field_alias = "stormstrike",
            ids = {
              spell = {
                17364
              }
            },
            aura = {
              class = "core",
              spell_id = 17364,
              label = "Stormstrike",
              duration = {
                raw = "time.Second * 12",
                seconds = 12.0
              },
              class_token = "core"
            }
          }
        },
        expose_armor = {
          id = 10,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            spell = {
              class = "rogue",
              label = "Expose Armor",
              flags = "rogue.finisherFlags()",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              threat_multiplier = "1",
              class_token = "rogue"
            },
            aura = {
              class = "core",
              spell_id = 11198,
              label = "ExposeArmor",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "core"
            }
          }
        },
        sunder_armor = {
          id = 11,
          type = "bool",
          label = "optional",
          _metadata = {
            aura = {
              class = "core",
              spell_id = 11597,
              label = "Sunder Armor",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "core"
            },
            spell = {
              class = "warrior",
              spell_id = 11597,
              label = "Sunder Armor",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | SpellFlagOffensive",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              threat_multiplier = "1",
              class_token = "warrior"
            },
            ["function"] = "SunderArmorAura",
            label = "Sunder Armor",
            spell_id = 11597,
            tags = {
              "raid"
            },
            extras = {
              functions = {
                "SchedulePeriodicDebuffApplication",
                "SunderArmorAura"
              }
            }
          }
        },
        curse_of_weakness = {
          id = 12,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            export = "CurseOfWeakness",
            field_alias = "curseOfWeakness",
            ids = {
              spell = {
                11708
              }
            },
            extras = {
              imp_id = "ActionId.fromSpellId(18181)"
            },
            aura = {
              class = "core",
              spell_id = 11708,
              label = "Curse Of Weakness",
              label_raw = [["Curse of Weakness" + strconv.Itoa(int(points))]],
              duration = {
                raw = "time.Minute * 2",
                seconds = 120.0
              },
              class_token = "core"
            }
          }
        },
        curse_of_recklessness = {
          id = 13,
          type = "bool",
          label = "optional",
          _metadata = {
            aura = {
              class = "core",
              spell_id = 11717,
              label = "Curse of Recklessness",
              duration = {
                raw = "time.Minute * 2",
                seconds = 120.0
              },
              class_token = "core"
            },
            spell = {
              class = "warlock",
              label = "Curse Of Recklessness",
              flags = "core.SpellFlagAPL | WarlockFlagAffliction",
              spell_school = "SpellSchoolShadow",
              proc_mask = "2",
              threat_multiplier = "1",
              class_token = "warlock"
            },
            ["function"] = "CurseOfRecklessnessAura",
            label = "Curse of Recklessness",
            spell_id = 11717,
            tags = {
              "raid"
            },
            extras = {
              functions = {
                "CurseOfRecklessnessAura"
              }
            }
          }
        },
        demoralizing_roar = {
          id = 14,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 48560,
              label = "Demoralizing Roar",
              flags = "SpellFlagOmen | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "2",
              threat_multiplier = "1",
              class_token = "druid"
            },
            aura = {
              class = "core",
              spell_id = 9898,
              label = "Demoralizing Roar",
              label_raw = [["DemoralizingRoar-" + strconv.Itoa(int(points))]],
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "core"
            }
          }
        },
        demoralizing_shout = {
          id = 15,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            aura = {
              class = "core",
              spell_id = 1160,
              label = "Demoralizing Shout",
              label_raw = [["DemoralizingShout-" + strconv.Itoa(int(impDemoShoutPts))]],
              duration = {
                raw = "time.Duration(float64(time.Second*30) * (1 + 0.1*float64(boomingVoicePts)))"
              },
              variants = {
                {
                  rank = 1,
                  spell_id = 1160,
                  base_ap_reduction = 45
                },
                {
                  rank = 2,
                  spell_id = 6190,
                  base_ap_reduction = 56
                },
                {
                  rank = 3,
                  spell_id = 11554,
                  base_ap_reduction = 76
                },
                {
                  rank = 4,
                  spell_id = 11555,
                  base_ap_reduction = 111
                },
                {
                  rank = 5,
                  spell_id = 11556,
                  base_ap_reduction = 146
                }
              },
              class_token = "core"
            },
            spell = {
              class = "warrior",
              label = "Demoralizing Shout",
              flags = "core.SpellFlagAPL | SpellFlagOffensive",
              spell_school = "2",
              proc_mask = "2",
              threat_multiplier = "0.4",
              class_token = "warrior"
            }
          }
        },
        thunder_clap = {
          id = 16,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            aura = {
              class = "core",
              spell_id = 8205,
              label = "Thunder Clap",
              label_raw = [["ThunderClap-" + strconv.Itoa(int(atkSpeedReductionPercent))]],
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "core"
            },
            spell = {
              class = "warrior",
              spell_id = 11581,
              label = "Thunder Clap",
              cooldown = {
                raw = "time.Second * 4",
                seconds = 4.0
              },
              flags = "core.SpellFlagAPL | SpellFlagOffensive",
              spell_school = "2",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "core.TernaryFloat64(has5pcConq, 1.5, 1)",
              threat_multiplier = "2.5",
              class_token = "warrior"
            }
          }
        },
        thunderfury = {
          id = 24,
          type = "bool",
          label = "optional",
          _metadata = {
            aura = {
              class = "common",
              spell_id = 21992,
              label = "Thunderfury",
              duration = {
                raw = "time.Second * 12",
                seconds = 12.0
              },
              class_token = "common"
            },
            ["function"] = "ThunderfuryASAura",
            label = "Thunderfury",
            spell_id = 21992,
            tags = {
              "raid"
            },
            extras = {
              functions = {
                "ThunderfuryASAura"
              }
            }
          }
        },
        insect_swarm = {
          id = 17,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "InsectSwarm",
            field_alias = "insectSwarm",
            ids = {
              spell = {
                24977
              }
            },
            aura = {
              class = "core",
              spell_id = 24977,
              label = "InsectSwarmMiss",
              duration = {
                raw = "time.Second * 12",
                seconds = 12.0
              },
              class_token = "core"
            }
          }
        },
        scorpid_sting = {
          id = 18,
          type = "bool",
          label = "optional",
          _metadata = {
            aura = {
              class = "core",
              spell_id = 3043,
              label = "Scorpid Sting",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "core"
            }
          }
        },
        hunters_mark = {
          id = 19,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            aura = {
              class = "core",
              spell_id = 14325,
              label = "Hunters Mark",
              label_raw = [["HuntersMark-" + strconv.Itoa(int(bonus))]],
              tag = "HuntersMark",
              duration = {
                raw = "time.Minute * 2",
                seconds = 120.0
              },
              class_token = "core"
            }
          }
        },
        gift_of_arthas = {
          id = 9,
          type = "bool",
          label = "optional",
          _metadata = {
            aura = {
              class = "core",
              spell_id = 11374,
              label = "Gift of Arthas",
              duration = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              class_token = "core"
            },
            ["function"] = "GiftOfArthasAura",
            label = "Gift of Arthas",
            spell_id = 11374,
            tags = {
              "raid"
            },
            extras = {
              functions = {
                "GiftOfArthasAura"
              }
            }
          }
        },
        crystal_yield = {
          id = 20,
          type = "bool",
          label = "optional",
          _metadata = {
            aura = {
              class = "core",
              spell_id = 15235,
              label = "Crystal Yield",
              duration = {
                raw = "2 * time.Minute",
                seconds = 120.0
              },
              class_token = "core"
            },
            ["function"] = "CrystalYieldAura",
            label = "Crystal Yield",
            spell_id = 15235,
            tags = {
              "raid"
            },
            extras = {
              functions = {
                "CrystalYieldAura"
              }
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "judgement_of_wisdom",
        "judgement_of_light",
        "judgement_of_the_crusader",
        "faerie_fire",
        "curse_of_elements",
        "curse_of_shadow",
        "winters_chill",
        "improved_shadow_bolt",
        "improved_scorch",
        "shadow_weaving",
        "stormstrike",
        "expose_armor",
        "sunder_armor",
        "curse_of_weakness",
        "curse_of_recklessness",
        "demoralizing_roar",
        "demoralizing_shout",
        "thunder_clap",
        "thunderfury",
        "insect_swarm",
        "scorpid_sting",
        "hunters_mark",
        "gift_of_arthas",
        "crystal_yield"
      },
      _metadata = {
        crystal_yield = {
          source = "extern/wowsims-classic/ui/core/components/inputs/buffs_debuffs.ts",
          export = "CrystalYield",
          ids = {
            spell = {
              15235
            }
          },
          stats = {
            "StatAttackPower",
            "StatRangedAttackPower"
          }
        },
        gift_of_arthas = {
          source = "extern/wowsims-classic/ui/core/components/inputs/buffs_debuffs.ts",
          export = "GiftOfArthas",
          ids = {
            spell = {
              11374
            }
          },
          stats = {
            "StatAttackPower",
            "StatRangedAttackPower"
          }
        },
        judgement_of_light = {
          source = "extern/wowsims-classic/ui/core/components/inputs/buffs_debuffs.ts",
          export = "JudgementOfLight",
          ids = {
            spell = {
              20346
            }
          },
          stats = {
            "StatStamina"
          }
        },
        judgement_of_the_crusader = {
          source = "extern/wowsims-classic/ui/core/components/inputs/buffs_debuffs.ts",
          export = "JudgementOfTheCrusader",
          ids = {
            spell = {
              20303
            }
          },
          stats = {
            "StatHolyPower"
          }
        },
        judgement_of_wisdom = {
          source = "extern/wowsims-classic/ui/core/components/inputs/buffs_debuffs.ts",
          export = "JudgementOfWisdom",
          ids = {
            spell = {
              20355
            }
          },
          stats = {
            "StatIntellect",
            "StatMP5"
          }
        },
        hunters_mark = {
          source = "extern/wowsims-classic/ui/core/components/inputs/buffs_debuffs.ts",
          export = "HuntersMark",
          ids = {
            spell = {
              14325
            }
          },
          stats = {
            "StatRangedAttackPower"
          }
        },
        spell_shadow_weaving_debuff = {
          source = "extern/wowsims-classic/ui/core/components/inputs/buffs_debuffs.ts",
          export = "SpellShadowWeavingDebuff",
          ids = {
            spell = {
              15334
            }
          },
          stats = {
            "StatShadowPower"
          }
        },
        spell_stormstrike_debuff = {
          source = "extern/wowsims-classic/ui/core/components/inputs/buffs_debuffs.ts",
          export = "SpellStormstrikeDebuff",
          ids = {
            spell = {
              17364
            }
          },
          stats = {
            "StatNaturePower"
          }
        },
        spell_winters_chill_debuff = {
          source = "extern/wowsims-classic/ui/core/components/inputs/buffs_debuffs.ts",
          export = "SpellWintersChillDebuff",
          ids = {
            spell = {
              28595
            }
          },
          stats = {
            "StatFrostPower"
          }
        },
        spell_scorch_debuff = {
          source = "extern/wowsims-classic/ui/core/components/inputs/buffs_debuffs.ts",
          export = "SpellScorchDebuff",
          ids = {
            spell = {
              12873
            }
          },
          stats = {
            "StatFirePower"
          }
        },
        spell_isb_debuff = {
          source = "extern/wowsims-classic/ui/core/components/inputs/buffs_debuffs.ts",
          export = "SpellISBDebuff",
          ids = {
            spell = {
              17803
            }
          },
          stats = {
            "StatShadowPower"
          }
        },
        melee_hit_debuff = {
          source = "extern/wowsims-classic/ui/core/components/inputs/buffs_debuffs.ts",
          export = "MeleeHitDebuff",
          ids = {
            spell = {
              24977
            }
          },
          stats = {
            "StatDodge"
          }
        },
        faerie_fire = {
          source = "extern/wowsims-classic/ui/core/components/inputs/buffs_debuffs.ts",
          export = "FaerieFire",
          ids = {
            spell = {
              9907
            }
          },
          stats = {
            "StatAttackPower"
          }
        },
        curse_of_recklessness = {
          source = "extern/wowsims-classic/ui/core/components/inputs/buffs_debuffs.ts",
          export = "CurseOfRecklessness",
          ids = {
            spell = {
              11717
            }
          },
          stats = {
            "StatAttackPower"
          }
        }
      }
    },
    TargetInput = {
      fields = {
        input_type = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "InputType"
        },
        label = {
          id = 2,
          type = "string",
          label = "optional"
        },
        tooltip = {
          id = 5,
          type = "string",
          label = "optional"
        },
        bool_value = {
          id = 3,
          type = "bool",
          label = "optional"
        },
        number_value = {
          id = 4,
          type = "double",
          label = "optional"
        },
        enum_value = {
          id = 6,
          type = "int32",
          label = "optional"
        },
        enum_options = {
          id = 7,
          type = "string",
          label = "repeated"
        }
      },
      oneofs = {

      },
      field_order = {
        "input_type",
        "label",
        "tooltip",
        "bool_value",
        "number_value",
        "enum_value",
        "enum_options"
      }
    },
    Target = {
      fields = {
        id = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        name = {
          id = 2,
          type = "string",
          label = "optional"
        },
        level = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        mob_type = {
          id = 4,
          type = "enum",
          label = "optional",
          enum_type = "MobType"
        },
        stats = {
          id = 5,
          type = "double",
          label = "repeated"
        },
        min_base_damage = {
          id = 6,
          type = "double",
          label = "optional"
        },
        damage_spread = {
          id = 7,
          type = "double",
          label = "optional"
        },
        swing_speed = {
          id = 8,
          type = "double",
          label = "optional"
        },
        dual_wield = {
          id = 9,
          type = "bool",
          label = "optional"
        },
        dual_wield_penalty = {
          id = 10,
          type = "bool",
          label = "optional"
        },
        parry_haste = {
          id = 11,
          type = "bool",
          label = "optional",
          _metadata = {
            aura = {
              class = "core",
              label = "Parry Haste",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "core"
            }
          }
        },
        spell_school = {
          id = 12,
          type = "enum",
          label = "optional",
          enum_type = "SpellSchool"
        },
        tank_index = {
          id = 13,
          type = "int32",
          label = "optional"
        },
        target_inputs = {
          id = 14,
          type = "message",
          label = "repeated",
          message_type = "TargetInput"
        }
      },
      oneofs = {

      },
      field_order = {
        "id",
        "name",
        "level",
        "mob_type",
        "stats",
        "min_base_damage",
        "damage_spread",
        "swing_speed",
        "dual_wield",
        "dual_wield_penalty",
        "parry_haste",
        "spell_school",
        "tank_index",
        "target_inputs"
      }
    },
    Encounter = {
      fields = {
        duration = {
          id = 1,
          type = "double",
          label = "optional"
        },
        duration_variation = {
          id = 2,
          type = "double",
          label = "optional"
        },
        execute_proportion_20 = {
          id = 3,
          type = "double",
          label = "optional"
        },
        execute_proportion_25 = {
          id = 7,
          type = "double",
          label = "optional"
        },
        execute_proportion_35 = {
          id = 4,
          type = "double",
          label = "optional"
        },
        use_health = {
          id = 5,
          type = "bool",
          label = "optional"
        },
        targets = {
          id = 6,
          type = "message",
          label = "repeated",
          message_type = "Target"
        }
      },
      oneofs = {

      },
      field_order = {
        "duration",
        "duration_variation",
        "execute_proportion_20",
        "execute_proportion_25",
        "execute_proportion_35",
        "use_health",
        "targets"
      }
    },
    PresetTarget = {
      fields = {
        path = {
          id = 1,
          type = "string",
          label = "optional"
        },
        target = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "Target"
        }
      },
      oneofs = {

      },
      field_order = {
        "path",
        "target"
      }
    },
    PresetEncounter = {
      fields = {
        path = {
          id = 1,
          type = "string",
          label = "optional"
        },
        targets = {
          id = 2,
          type = "message",
          label = "repeated",
          message_type = "PresetTarget"
        }
      },
      oneofs = {

      },
      field_order = {
        "path",
        "targets"
      }
    },
    ItemRandomSuffix = {
      fields = {
        id = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        name = {
          id = 2,
          type = "string",
          label = "optional"
        },
        stats = {
          id = 3,
          type = "double",
          label = "repeated"
        }
      },
      oneofs = {

      },
      field_order = {
        "id",
        "name",
        "stats"
      }
    },
    ItemSpec = {
      fields = {
        id = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        random_suffix = {
          id = 6,
          type = "int32",
          label = "optional"
        },
        enchant = {
          id = 3,
          type = "int32",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "id",
        "random_suffix",
        "enchant"
      }
    },
    EquipmentSpec = {
      fields = {
        items = {
          id = 1,
          type = "message",
          label = "repeated",
          message_type = "ItemSpec"
        }
      },
      oneofs = {

      },
      field_order = {
        "items"
      }
    },
    SimDatabase = {
      fields = {
        items = {
          id = 1,
          type = "message",
          label = "repeated",
          message_type = "SimItem"
        },
        random_suffixes = {
          id = 5,
          type = "message",
          label = "repeated",
          message_type = "ItemRandomSuffix"
        },
        enchants = {
          id = 2,
          type = "message",
          label = "repeated",
          message_type = "SimEnchant"
        }
      },
      oneofs = {

      },
      field_order = {
        "items",
        "random_suffixes",
        "enchants"
      }
    },
    SimItem = {
      fields = {
        id = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        class_allowlist = {
          id = 17,
          type = "enum",
          label = "repeated",
          enum_type = "Class"
        },
        name = {
          id = 2,
          type = "string",
          label = "optional"
        },
        type = {
          id = 3,
          type = "enum",
          label = "optional",
          enum_type = "ItemType"
        },
        armor_type = {
          id = 4,
          type = "enum",
          label = "optional",
          enum_type = "ArmorType"
        },
        weapon_type = {
          id = 5,
          type = "enum",
          label = "optional",
          enum_type = "WeaponType"
        },
        hand_type = {
          id = 6,
          type = "enum",
          label = "optional",
          enum_type = "HandType"
        },
        ranged_weapon_type = {
          id = 7,
          type = "enum",
          label = "optional",
          enum_type = "RangedWeaponType"
        },
        stats = {
          id = 8,
          type = "double",
          label = "repeated"
        },
        weapon_damage_min = {
          id = 11,
          type = "double",
          label = "optional"
        },
        weapon_damage_max = {
          id = 12,
          type = "double",
          label = "optional"
        },
        weapon_speed = {
          id = 13,
          type = "double",
          label = "optional"
        },
        bonus_physical_damage = {
          id = 19,
          type = "double",
          label = "optional"
        },
        set_name = {
          id = 14,
          type = "string",
          label = "optional"
        },
        set_id = {
          id = 18,
          type = "int32",
          label = "optional"
        },
        weapon_skills = {
          id = 15,
          type = "double",
          label = "repeated"
        }
      },
      oneofs = {

      },
      field_order = {
        "id",
        "class_allowlist",
        "name",
        "type",
        "armor_type",
        "weapon_type",
        "hand_type",
        "ranged_weapon_type",
        "stats",
        "weapon_damage_min",
        "weapon_damage_max",
        "weapon_speed",
        "bonus_physical_damage",
        "set_name",
        "set_id",
        "weapon_skills"
      }
    },
    SimEnchant = {
      fields = {
        effect_id = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        stats = {
          id = 2,
          type = "double",
          label = "repeated"
        }
      },
      oneofs = {

      },
      field_order = {
        "effect_id",
        "stats"
      }
    },
    UnitReference = {
      fields = {
        type = {
          id = 2,
          type = "enum",
          label = "optional",
          enum_type = "UnitType"
        },
        index = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        owner = {
          id = 4,
          type = "message",
          label = "optional",
          message_type = "UnitReference"
        }
      },
      oneofs = {

      },
      field_order = {
        "type",
        "index",
        "owner"
      }
    },
    ActionID = {
      fields = {
        spell_id = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        item_id = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        other_id = {
          id = 3,
          type = "enum",
          label = "optional",
          enum_type = "OtherAction"
        },
        tag = {
          id = 4,
          type = "int32",
          label = "optional"
        },
        rank = {
          id = 5,
          type = "int32",
          label = "optional"
        }
      },
      oneofs = {
        raw_id = {
          "spell_id",
          "item_id",
          "other_id"
        }
      },
      field_order = {
        "spell_id",
        "item_id",
        "other_id",
        "tag",
        "rank"
      }
    },
    Cooldown = {
      fields = {
        id = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ActionID"
        },
        timings = {
          id = 2,
          type = "double",
          label = "repeated"
        }
      },
      oneofs = {

      },
      field_order = {
        "id",
        "timings"
      }
    },
    Cooldowns = {
      fields = {
        cooldowns = {
          id = 1,
          type = "message",
          label = "repeated",
          message_type = "Cooldown"
        },
        hp_percent_for_defensives = {
          id = 2,
          type = "double",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "cooldowns",
        "hp_percent_for_defensives"
      }
    },
    HealingModel = {
      fields = {
        hps = {
          id = 1,
          type = "double",
          label = "optional"
        },
        cadence_seconds = {
          id = 2,
          type = "double",
          label = "optional"
        },
        cadence_variation = {
          id = 5,
          type = "double",
          label = "optional"
        },
        inspiration_uptime = {
          id = 3,
          type = "double",
          label = "optional"
        },
        burst_window = {
          id = 4,
          type = "int32",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "hps",
        "cadence_seconds",
        "cadence_variation",
        "inspiration_uptime",
        "burst_window"
      }
    },
    CustomRotation = {
      fields = {
        spells = {
          id = 1,
          type = "message",
          label = "repeated",
          message_type = "CustomSpell",
          _metadata = {
            spell = {
              class = "encounters",
              spell_id = 23513,
              label = "Essence of the Red",
              cooldown = {
                raw = "time.Minute * 4",
                seconds = 240.0
              },
              proc_mask = "2",
              class_token = "encounters"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "spells"
      }
    },
    CustomSpell = {
      fields = {
        spell = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        casts_per_minute = {
          id = 2,
          type = "double",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "spell",
        "casts_per_minute"
      }
    },
    ItemSwap = {
      fields = {
        mh_item = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ItemSpec"
        },
        oh_item = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "ItemSpec"
        },
        ranged_item = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "ItemSpec"
        }
      },
      oneofs = {

      },
      field_order = {
        "mh_item",
        "oh_item",
        "ranged_item"
      }
    },
    Duration = {
      fields = {
        ms = {
          id = 1,
          type = "double",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "ms"
      }
    },
    APLRotation = {
      fields = {
        type = {
          id = 3,
          type = "enum",
          label = "optional",
          enum_type = "APLRotationType"
        },
        simple = {
          id = 4,
          type = "message",
          label = "optional",
          message_type = "SimpleRotation"
        },
        prepull_actions = {
          id = 1,
          type = "message",
          label = "repeated",
          message_type = "APLPrepullAction"
        },
        priority_list = {
          id = 2,
          type = "message",
          label = "repeated",
          message_type = "APLListItem"
        }
      },
      oneofs = {

      },
      field_order = {
        "type",
        "simple",
        "prepull_actions",
        "priority_list"
      }
    },
    SimpleRotation = {
      fields = {
        spec_rotation_json = {
          id = 1,
          type = "string",
          label = "optional"
        },
        cooldowns = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "Cooldowns"
        }
      },
      oneofs = {

      },
      field_order = {
        "spec_rotation_json",
        "cooldowns"
      }
    },
    APLPrepullAction = {
      fields = {
        action = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "APLAction"
        },
        do_at_value = {
          id = 4,
          type = "message",
          label = "optional",
          message_type = "APLValue"
        },
        hide = {
          id = 3,
          type = "bool",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "action",
        "do_at_value",
        "hide"
      }
    },
    APLListItem = {
      fields = {
        hide = {
          id = 1,
          type = "bool",
          label = "optional"
        },
        notes = {
          id = 2,
          type = "string",
          label = "optional"
        },
        action = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "APLAction"
        }
      },
      oneofs = {

      },
      field_order = {
        "hide",
        "notes",
        "action"
      }
    },
    APLAction = {
      fields = {
        condition = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "APLValue"
        },
        cast_spell = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "APLActionCastSpell",
          _metadata = {
            export = "cast_spell"
          }
        },
        channel_spell = {
          id = 16,
          type = "message",
          label = "optional",
          message_type = "APLActionChannelSpell",
          _metadata = {
            export = "channel_spell"
          }
        },
        multidot = {
          id = 8,
          type = "message",
          label = "optional",
          message_type = "APLActionMultidot",
          _metadata = {
            export = "multidot"
          }
        },
        multishield = {
          id = 12,
          type = "message",
          label = "optional",
          message_type = "APLActionMultishield",
          _metadata = {
            export = "multishield"
          }
        },
        autocast_other_cooldowns = {
          id = 7,
          type = "message",
          label = "optional",
          message_type = "APLActionAutocastOtherCooldowns",
          _metadata = {
            export = "autocast_other_cooldowns"
          }
        },
        wait = {
          id = 4,
          type = "message",
          label = "optional",
          message_type = "APLActionWait",
          _metadata = {
            export = "wait"
          }
        },
        wait_until = {
          id = 14,
          type = "message",
          label = "optional",
          message_type = "APLActionWaitUntil",
          _metadata = {
            export = "wait_until"
          }
        },
        schedule = {
          id = 15,
          type = "message",
          label = "optional",
          message_type = "APLActionSchedule",
          _metadata = {
            export = "schedule"
          }
        },
        sequence = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "APLActionSequence",
          _metadata = {
            export = "sequence"
          }
        },
        reset_sequence = {
          id = 5,
          type = "message",
          label = "optional",
          message_type = "APLActionResetSequence",
          _metadata = {
            export = "reset_sequence"
          }
        },
        strict_sequence = {
          id = 6,
          type = "message",
          label = "optional",
          message_type = "APLActionStrictSequence",
          _metadata = {
            export = "strict_sequence"
          }
        },
        change_target = {
          id = 9,
          type = "message",
          label = "optional",
          message_type = "APLActionChangeTarget",
          _metadata = {
            export = "change_target"
          }
        },
        activate_aura = {
          id = 13,
          type = "message",
          label = "optional",
          message_type = "APLActionActivateAura",
          _metadata = {
            export = "activate_aura"
          }
        },
        activate_aura_with_stacks = {
          id = 22,
          type = "message",
          label = "optional",
          message_type = "APLActionActivateAuraWithStacks",
          _metadata = {
            export = "activate_aura_with_stacks"
          }
        },
        cancel_aura = {
          id = 10,
          type = "message",
          label = "optional",
          message_type = "APLActionCancelAura",
          _metadata = {
            export = "cancel_aura"
          }
        },
        trigger_icd = {
          id = 11,
          type = "message",
          label = "optional",
          message_type = "APLActionTriggerICD",
          _metadata = {
            export = "trigger_icd"
          }
        },
        item_swap = {
          id = 17,
          type = "message",
          label = "optional",
          message_type = "APLActionItemSwap",
          _metadata = {
            export = "item_swap"
          }
        },
        move = {
          id = 18,
          type = "message",
          label = "optional",
          message_type = "APLActionMove",
          _metadata = {
            export = "move"
          }
        },
        add_combo_points = {
          id = 23,
          type = "message",
          label = "optional",
          message_type = "APLActionAddComboPoints",
          _metadata = {
            export = "add_combo_points"
          }
        },
        cat_optimal_rotation_action = {
          id = 19,
          type = "message",
          label = "optional",
          message_type = "APLActionCatOptimalRotationAction",
          _metadata = {
            export = "cat_optimal_rotation_action"
          }
        },
        cast_paladin_primary_seal = {
          id = 21,
          type = "message",
          label = "optional",
          message_type = "APLActionCastPaladinPrimarySeal",
          _metadata = {
            export = "cast_paladin_primary_seal"
          }
        },
        custom_rotation = {
          id = 20,
          type = "message",
          label = "optional",
          message_type = "APLActionCustomRotation",
          _metadata = {
            export = "custom_rotation"
          }
        }
      },
      oneofs = {
        action = {
          "cast_spell",
          "channel_spell",
          "multidot",
          "multishield",
          "autocast_other_cooldowns",
          "wait",
          "wait_until",
          "schedule",
          "sequence",
          "reset_sequence",
          "strict_sequence",
          "change_target",
          "activate_aura",
          "activate_aura_with_stacks",
          "cancel_aura",
          "trigger_icd",
          "item_swap",
          "move",
          "add_combo_points",
          "cat_optimal_rotation_action",
          "cast_paladin_primary_seal",
          "custom_rotation"
        }
      },
      field_order = {
        "condition",
        "cast_spell",
        "channel_spell",
        "multidot",
        "multishield",
        "autocast_other_cooldowns",
        "wait",
        "wait_until",
        "schedule",
        "sequence",
        "reset_sequence",
        "strict_sequence",
        "change_target",
        "activate_aura",
        "activate_aura_with_stacks",
        "cancel_aura",
        "trigger_icd",
        "item_swap",
        "move",
        "add_combo_points",
        "cat_optimal_rotation_action",
        "cast_paladin_primary_seal",
        "custom_rotation"
      }
    },
    APLValue = {
      fields = {
        const = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "APLValueConst",
          _metadata = {
            export = "const"
          }
        },
        ["and"] = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "APLValueAnd",
          _metadata = {
            export = "and"
          }
        },
        ["or"] = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "APLValueOr",
          _metadata = {
            export = "or"
          }
        },
        ["not"] = {
          id = 4,
          type = "message",
          label = "optional",
          message_type = "APLValueNot",
          _metadata = {
            export = "not"
          }
        },
        cmp = {
          id = 5,
          type = "message",
          label = "optional",
          message_type = "APLValueCompare",
          _metadata = {
            export = "cmp"
          }
        },
        math = {
          id = 38,
          type = "message",
          label = "optional",
          message_type = "APLValueMath",
          _metadata = {
            export = "math"
          }
        },
        max = {
          id = 47,
          type = "message",
          label = "optional",
          message_type = "APLValueMax",
          _metadata = {
            export = "max"
          }
        },
        min = {
          id = 48,
          type = "message",
          label = "optional",
          message_type = "APLValueMin",
          _metadata = {
            export = "min"
          }
        },
        current_time = {
          id = 7,
          type = "message",
          label = "optional",
          message_type = "APLValueCurrentTime",
          _metadata = {
            export = "current_time"
          }
        },
        current_time_percent = {
          id = 8,
          type = "message",
          label = "optional",
          message_type = "APLValueCurrentTimePercent",
          _metadata = {
            export = "current_time_percent"
          }
        },
        remaining_time = {
          id = 9,
          type = "message",
          label = "optional",
          message_type = "APLValueRemainingTime",
          _metadata = {
            export = "remaining_time"
          }
        },
        remaining_time_percent = {
          id = 10,
          type = "message",
          label = "optional",
          message_type = "APLValueRemainingTimePercent",
          _metadata = {
            export = "remaining_time_percent"
          }
        },
        is_execute_phase = {
          id = 41,
          type = "message",
          label = "optional",
          message_type = "APLValueIsExecutePhase",
          _metadata = {
            export = "is_execute_phase"
          }
        },
        number_targets = {
          id = 28,
          type = "message",
          label = "optional",
          message_type = "APLValueNumberTargets",
          _metadata = {
            export = "number_targets"
          }
        },
        current_health = {
          id = 26,
          type = "message",
          label = "optional",
          message_type = "APLValueCurrentHealth",
          _metadata = {
            export = "current_health"
          }
        },
        current_health_percent = {
          id = 27,
          type = "message",
          label = "optional",
          message_type = "APLValueCurrentHealthPercent",
          _metadata = {
            export = "current_health_percent"
          }
        },
        max_health = {
          id = 76,
          type = "message",
          label = "optional",
          message_type = "APLValueMaxHealth",
          _metadata = {
            export = "max_health"
          }
        },
        current_mana = {
          id = 11,
          type = "message",
          label = "optional",
          message_type = "APLValueCurrentMana",
          _metadata = {
            export = "current_mana"
          }
        },
        current_mana_percent = {
          id = 12,
          type = "message",
          label = "optional",
          message_type = "APLValueCurrentManaPercent",
          _metadata = {
            export = "current_mana_percent"
          }
        },
        max_mana = {
          id = 75,
          type = "message",
          label = "optional",
          message_type = "APLValueMaxMana",
          _metadata = {
            export = "max_mana"
          }
        },
        current_rage = {
          id = 14,
          type = "message",
          label = "optional",
          message_type = "APLValueCurrentRage",
          _metadata = {
            export = "current_rage"
          }
        },
        current_energy = {
          id = 15,
          type = "message",
          label = "optional",
          message_type = "APLValueCurrentEnergy",
          _metadata = {
            export = "current_energy"
          }
        },
        current_combo_points = {
          id = 16,
          type = "message",
          label = "optional",
          message_type = "APLValueCurrentComboPoints",
          _metadata = {
            export = "current_combo_points"
          }
        },
        time_to_energy_tick = {
          id = 66,
          type = "message",
          label = "optional",
          message_type = "APLValueTimeToEnergyTick",
          _metadata = {
            export = "time_to_energy_tick"
          }
        },
        energy_threshold = {
          id = 72,
          type = "message",
          label = "optional",
          message_type = "APLValueEnergyThreshold",
          _metadata = {
            export = "energy_threshold"
          }
        },
        current_attack_power = {
          id = 77,
          type = "message",
          label = "optional",
          message_type = "APLValueCurrentAttackPower",
          _metadata = {
            export = "current_attack_power"
          }
        },
        gcd_is_ready = {
          id = 17,
          type = "message",
          label = "optional",
          message_type = "APLValueGCDIsReady",
          _metadata = {
            export = "gcd_is_ready"
          }
        },
        gcd_time_to_ready = {
          id = 18,
          type = "message",
          label = "optional",
          message_type = "APLValueGCDTimeToReady",
          _metadata = {
            export = "gcd_time_to_ready"
          }
        },
        auto_time_to_next = {
          id = 40,
          type = "message",
          label = "optional",
          message_type = "APLValueAutoTimeToNext",
          _metadata = {
            export = "auto_time_to_next"
          }
        },
        auto_swing_time = {
          id = 64,
          type = "message",
          label = "optional",
          message_type = "APLValueAutoSwingTime",
          _metadata = {
            export = "auto_swing_time"
          }
        },
        spell_is_known = {
          id = 68,
          type = "message",
          label = "optional",
          message_type = "APLValueSpellIsKnown",
          _metadata = {
            export = "spell_is_known"
          }
        },
        spell_can_cast = {
          id = 19,
          type = "message",
          label = "optional",
          message_type = "APLValueSpellCanCast",
          _metadata = {
            export = "spell_can_cast"
          }
        },
        spell_is_ready = {
          id = 20,
          type = "message",
          label = "optional",
          message_type = "APLValueSpellIsReady",
          _metadata = {
            export = "spell_is_ready"
          }
        },
        spell_time_to_ready = {
          id = 21,
          type = "message",
          label = "optional",
          message_type = "APLValueSpellTimeToReady",
          _metadata = {
            export = "spell_time_to_ready"
          }
        },
        spell_cast_time = {
          id = 35,
          type = "message",
          label = "optional",
          message_type = "APLValueSpellCastTime",
          _metadata = {
            export = "spell_cast_time"
          }
        },
        spell_travel_time = {
          id = 37,
          type = "message",
          label = "optional",
          message_type = "APLValueSpellTravelTime",
          _metadata = {
            export = "spell_travel_time"
          }
        },
        spell_in_flight = {
          id = 73,
          type = "message",
          label = "optional",
          message_type = "APLValueSpellInFlight",
          _metadata = {
            export = "spell_in_flight"
          }
        },
        spell_cpm = {
          id = 42,
          type = "message",
          label = "optional",
          message_type = "APLValueSpellCPM",
          _metadata = {
            export = "spell_cpm"
          }
        },
        spell_is_channeling = {
          id = 56,
          type = "message",
          label = "optional",
          message_type = "APLValueSpellIsChanneling",
          _metadata = {
            export = "spell_is_channeling"
          }
        },
        spell_channeled_ticks = {
          id = 57,
          type = "message",
          label = "optional",
          message_type = "APLValueSpellChanneledTicks",
          _metadata = {
            export = "spell_channeled_ticks"
          }
        },
        spell_current_cost = {
          id = 62,
          type = "message",
          label = "optional",
          message_type = "APLValueSpellCurrentCost",
          _metadata = {
            export = "spell_current_cost"
          }
        },
        aura_is_known = {
          id = 67,
          type = "message",
          label = "optional",
          message_type = "APLValueAuraIsKnown",
          _metadata = {
            export = "aura_is_known"
          }
        },
        aura_is_active = {
          id = 22,
          type = "message",
          label = "optional",
          message_type = "APLValueAuraIsActive",
          _metadata = {
            export = "aura_is_active"
          }
        },
        aura_is_active_with_reaction_time = {
          id = 50,
          type = "message",
          label = "optional",
          message_type = "APLValueAuraIsActiveWithReactionTime",
          _metadata = {
            export = "aura_is_active_with_reaction_time"
          }
        },
        aura_remaining_time = {
          id = 23,
          type = "message",
          label = "optional",
          message_type = "APLValueAuraRemainingTime",
          _metadata = {
            export = "aura_remaining_time"
          }
        },
        aura_num_stacks = {
          id = 24,
          type = "message",
          label = "optional",
          message_type = "APLValueAuraNumStacks",
          _metadata = {
            export = "aura_num_stacks"
          }
        },
        aura_internal_cooldown = {
          id = 39,
          type = "message",
          label = "optional",
          message_type = "APLValueAuraInternalCooldown",
          _metadata = {
            export = "aura_internal_cooldown"
          }
        },
        aura_icd_is_ready_with_reaction_time = {
          id = 51,
          type = "message",
          label = "optional",
          message_type = "APLValueAuraICDIsReadyWithReactionTime",
          _metadata = {
            export = "aura_icd_is_ready_with_reaction_time"
          }
        },
        aura_should_refresh = {
          id = 43,
          type = "message",
          label = "optional",
          message_type = "APLValueAuraShouldRefresh",
          _metadata = {
            export = "aura_should_refresh"
          }
        },
        rune_is_equipped = {
          id = 74,
          type = "message",
          label = "optional",
          message_type = "APLValueRuneIsEquipped",
          _metadata = {
            export = "rune_is_equipped"
          }
        },
        dot_is_active = {
          id = 6,
          type = "message",
          label = "optional",
          message_type = "APLValueDotIsActive",
          _metadata = {
            export = "dot_is_active"
          }
        },
        dot_remaining_time = {
          id = 13,
          type = "message",
          label = "optional",
          message_type = "APLValueDotRemainingTime",
          _metadata = {
            export = "dot_remaining_time"
          }
        },
        sequence_is_complete = {
          id = 44,
          type = "message",
          label = "optional",
          message_type = "APLValueSequenceIsComplete",
          _metadata = {
            export = "sequence_is_complete"
          }
        },
        sequence_is_ready = {
          id = 45,
          type = "message",
          label = "optional",
          message_type = "APLValueSequenceIsReady",
          _metadata = {
            export = "sequence_is_ready"
          }
        },
        sequence_time_to_ready = {
          id = 46,
          type = "message",
          label = "optional",
          message_type = "APLValueSequenceTimeToReady",
          _metadata = {
            export = "sequence_time_to_ready"
          }
        },
        channel_clip_delay = {
          id = 58,
          type = "message",
          label = "optional",
          message_type = "APLValueChannelClipDelay",
          _metadata = {
            export = "channel_clip_delay"
          }
        },
        front_of_target = {
          id = 63,
          type = "message",
          label = "optional",
          message_type = "APLValueFrontOfTarget",
          _metadata = {
            export = "front_of_target"
          }
        },
        totem_remaining_time = {
          id = 49,
          type = "message",
          label = "optional",
          message_type = "APLValueTotemRemainingTime",
          _metadata = {
            export = "totem_remaining_time"
          }
        },
        cat_excess_energy = {
          id = 52,
          type = "message",
          label = "optional",
          message_type = "APLValueCatExcessEnergy",
          _metadata = {
            export = "cat_excess_energy"
          }
        },
        warlock_should_recast_drain_soul = {
          id = 59,
          type = "message",
          label = "optional",
          message_type = "APLValueWarlockShouldRecastDrainSoul",
          _metadata = {
            export = "warlock_should_recast_drain_soul"
          }
        },
        warlock_should_refresh_corruption = {
          id = 60,
          type = "message",
          label = "optional",
          message_type = "APLValueWarlockShouldRefreshCorruption",
          _metadata = {
            export = "warlock_should_refresh_corruption"
          }
        },
        warlock_current_pet_mana = {
          id = 69,
          type = "message",
          label = "optional",
          message_type = "APLValueWarlockCurrentPetMana",
          _metadata = {
            export = "warlock_current_pet_mana"
          }
        },
        warlock_current_pet_mana_percent = {
          id = 70,
          type = "message",
          label = "optional",
          message_type = "APLValueWarlockCurrentPetManaPercent",
          _metadata = {
            export = "warlock_current_pet_mana_percent"
          }
        },
        warlock_pet_is_active = {
          id = 71,
          type = "message",
          label = "optional",
          message_type = "APLValueWarlockPetIsActive",
          _metadata = {
            export = "warlock_pet_is_active"
          }
        },
        current_seal_remaining_time = {
          id = 65,
          type = "message",
          label = "optional",
          message_type = "APLValueCurrentSealRemainingTime",
          _metadata = {
            export = "current_seal_remaining_time"
          }
        }
      },
      oneofs = {
        value = {
          "const",
          "and",
          "or",
          "not",
          "cmp",
          "math",
          "max",
          "min",
          "current_time",
          "current_time_percent",
          "remaining_time",
          "remaining_time_percent",
          "is_execute_phase",
          "number_targets",
          "current_health",
          "current_health_percent",
          "max_health",
          "current_mana",
          "current_mana_percent",
          "max_mana",
          "current_rage",
          "current_energy",
          "current_combo_points",
          "time_to_energy_tick",
          "energy_threshold",
          "current_attack_power",
          "gcd_is_ready",
          "gcd_time_to_ready",
          "auto_time_to_next",
          "auto_swing_time",
          "spell_is_known",
          "spell_can_cast",
          "spell_is_ready",
          "spell_time_to_ready",
          "spell_cast_time",
          "spell_travel_time",
          "spell_in_flight",
          "spell_cpm",
          "spell_is_channeling",
          "spell_channeled_ticks",
          "spell_current_cost",
          "aura_is_known",
          "aura_is_active",
          "aura_is_active_with_reaction_time",
          "aura_remaining_time",
          "aura_num_stacks",
          "aura_internal_cooldown",
          "aura_icd_is_ready_with_reaction_time",
          "aura_should_refresh",
          "rune_is_equipped",
          "dot_is_active",
          "dot_remaining_time",
          "sequence_is_complete",
          "sequence_is_ready",
          "sequence_time_to_ready",
          "channel_clip_delay",
          "front_of_target",
          "totem_remaining_time",
          "cat_excess_energy",
          "warlock_should_recast_drain_soul",
          "warlock_should_refresh_corruption",
          "warlock_current_pet_mana",
          "warlock_current_pet_mana_percent",
          "warlock_pet_is_active",
          "current_seal_remaining_time"
        }
      },
      field_order = {
        "const",
        "and",
        "or",
        "not",
        "cmp",
        "math",
        "max",
        "min",
        "current_time",
        "current_time_percent",
        "remaining_time",
        "remaining_time_percent",
        "is_execute_phase",
        "number_targets",
        "current_health",
        "current_health_percent",
        "max_health",
        "current_mana",
        "current_mana_percent",
        "max_mana",
        "current_rage",
        "current_energy",
        "current_combo_points",
        "time_to_energy_tick",
        "energy_threshold",
        "current_attack_power",
        "gcd_is_ready",
        "gcd_time_to_ready",
        "auto_time_to_next",
        "auto_swing_time",
        "spell_is_known",
        "spell_can_cast",
        "spell_is_ready",
        "spell_time_to_ready",
        "spell_cast_time",
        "spell_travel_time",
        "spell_in_flight",
        "spell_cpm",
        "spell_is_channeling",
        "spell_channeled_ticks",
        "spell_current_cost",
        "aura_is_known",
        "aura_is_active",
        "aura_is_active_with_reaction_time",
        "aura_remaining_time",
        "aura_num_stacks",
        "aura_internal_cooldown",
        "aura_icd_is_ready_with_reaction_time",
        "aura_should_refresh",
        "rune_is_equipped",
        "dot_is_active",
        "dot_remaining_time",
        "sequence_is_complete",
        "sequence_is_ready",
        "sequence_time_to_ready",
        "channel_clip_delay",
        "front_of_target",
        "totem_remaining_time",
        "cat_excess_energy",
        "warlock_should_recast_drain_soul",
        "warlock_should_refresh_corruption",
        "warlock_current_pet_mana",
        "warlock_current_pet_mana_percent",
        "warlock_pet_is_active",
        "current_seal_remaining_time"
      }
    },
    APLActionCastSpell = {
      fields = {
        spell_id = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ActionID"
        },
        target = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "UnitReference"
        }
      },
      oneofs = {

      },
      field_order = {
        "spell_id",
        "target"
      },
      _metadata = {
        ui_label = "Cast",
        short_description = "Casts the spell if possible, i.e. resource/cooldown/GCD/etc requirements are all met.",
        defaults = "APLActionCastSpell.create",
        fields = {
          spell_id = {
            default = {

            }
          },
          target = {
            ui_label = "Unit",
            default = {
              type = 0
            }
          }
        }
      }
    },
    APLActionChannelSpell = {
      fields = {
        spell_id = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ActionID"
        },
        target = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "UnitReference"
        },
        interrupt_if = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "APLValue"
        },
        instant_interrupt = {
          id = 4,
          type = "bool",
          label = "optional"
        },
        allow_recast = {
          id = 5,
          type = "bool",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "spell_id",
        "target",
        "interrupt_if",
        "instant_interrupt",
        "allow_recast"
      },
      _metadata = {
        ui_label = "Channel",
        short_description = "Channels the spell if possible, i.e. resource/cooldown/GCD/etc requirements are all met.",
        full_description = [[
			<p>The difference between channeling a spell vs casting the spell is that channels can be interrupted. If the <b>Interrupt If</b> parameter is empty, this action is equivalent to <b>Cast</b>.</p>
			<p>The channel will be interrupted only if Instant Interrupt is true OR all of the following are true:</p>
			<ul>
				<li>Immediately following a tick of the channel</li>
				<li>The <b>Interrupt If</b> condition evaluates to <b>True</b></li>
				<li>Another action in the APL list is available</li>
			</ul>
			<p>Note that if you simply want to allow other actions to interrupt the channel, set <b>Interrupt If</b> to <b>True</b>.</p>
		]],
        defaults = {
          interrupt_if = {
            value = {
              oneof_kind = "gcdIsReady",
              gcd_is_ready = {

              }
            }
          }
        },
        submenu = {
          "Casting"
        },
        fields = {
          spell_id = {
            default = {

            }
          },
          target = {
            ui_label = "Unit",
            default = {
              type = 0
            }
          },
          interrupt_if = {
            ui_label = "Interrupt If",
            full_description = "Condition which must be true to allow the channel to be interrupted.",
            default = {
              value = {
                oneof_kind = "gcdIsReady",
                gcd_is_ready = {

                }
              }
            }
          },
          instant_interrupt = {
            ui_label = "Instant Interrupt",
            full_description = "If checked, interrupts of this channel will happen instantly after the cast.",
            default = false
          },
          allow_recast = {
            ui_label = "Recast",
            full_description = "If checked, interrupts of this channel will recast the spell.",
            default = false
          }
        }
      }
    },
    APLActionMultidot = {
      fields = {
        spell_id = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ActionID"
        },
        max_dots = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        max_overlap = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "APLValue"
        }
      },
      oneofs = {

      },
      field_order = {
        "spell_id",
        "max_dots",
        "max_overlap"
      },
      _metadata = {
        ui_label = "Multi Dot",
        short_description = "Keeps a DoT active on multiple targets by casting the specified spell.",
        defaults = {
          max_dots = 3,
          max_overlap = {
            value = {
              oneof_kind = "const",
              const = {
                val = "0ms"
              }
            }
          }
        },
        submenu = {
          "Casting"
        },
        include_if = {
          prepull_only = false,
          combat_only = true,
          spec_specific = false,
          class_specific = false,
          classes = {

          },
          specs = {

          },
          excluded_classes = {

          },
          excluded_specs = {

          },
          requires_group = false,
          requires_target_dummies = false,
          requires_item_swap = false,
          requires_secondary_resource = false,
          requires_healer_spec = false,
          requires_tank_spec = false,
          unparsed = false
        },
        fields = {
          spell_id = {
            default = {

            }
          },
          max_dots = {
            ui_label = "Max Dots",
            full_description = "Maximum number of DoTs to simultaneously apply.",
            default = 3
          },
          max_overlap = {
            ui_label = "Overlap",
            full_description = "Maximum amount of time before a DoT expires when it may be refreshed.",
            default = {
              value = {
                oneof_kind = "const",
                const = {
                  val = "0ms"
                }
              }
            }
          }
        }
      }
    },
    APLActionMultishield = {
      fields = {
        spell_id = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ActionID"
        },
        max_shields = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        max_overlap = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "APLValue"
        }
      },
      oneofs = {

      },
      field_order = {
        "spell_id",
        "max_shields",
        "max_overlap"
      },
      _metadata = {
        ui_label = "Multi Shield",
        short_description = "Keeps a Shield active on multiple targets by casting the specified spell.",
        defaults = {
          max_shields = 3,
          max_overlap = {
            value = {
              oneof_kind = "const",
              const = {
                val = "0ms"
              }
            }
          }
        },
        submenu = {
          "Casting"
        },
        include_if = {
          prepull_only = false,
          combat_only = true,
          spec_specific = true,
          class_specific = false,
          classes = {

          },
          specs = {

          },
          excluded_classes = {

          },
          excluded_specs = {

          },
          requires_group = false,
          requires_target_dummies = false,
          requires_item_swap = false,
          requires_secondary_resource = false,
          requires_healer_spec = false,
          requires_tank_spec = false,
          unparsed = false
        },
        fields = {
          spell_id = {
            default = {

            }
          },
          max_shields = {
            ui_label = "Max Shields",
            full_description = "Maximum number of Shields to simultaneously apply.",
            default = 3
          },
          max_overlap = {
            ui_label = "Overlap",
            full_description = "Maximum amount of time before a Shield expires when it may be refreshed.",
            default = {
              value = {
                oneof_kind = "const",
                const = {
                  val = "0ms"
                }
              }
            }
          }
        }
      }
    },
    APLActionAutocastOtherCooldowns = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Autocast Other Cooldowns",
        short_description = "Auto-casts cooldowns as soon as they are ready.",
        full_description = [[
			<ul>
				<li>Does not auto-cast cooldowns which are already controlled by other actions in the priority list.</li>
				<li>Cooldowns are usually cast immediately upon becoming ready, but there are some basic smart checks in place, e.g. don't use Mana CDs when near full mana.</li>
			</ul>
		]],
        defaults = "APLActionAutocastOtherCooldowns.create",
        submenu = {
          "Casting"
        },
        include_if = {
          prepull_only = false,
          combat_only = true,
          spec_specific = false,
          class_specific = false,
          classes = {

          },
          specs = {

          },
          excluded_classes = {

          },
          excluded_specs = {

          },
          requires_group = false,
          requires_target_dummies = false,
          requires_item_swap = false,
          requires_secondary_resource = false,
          requires_healer_spec = false,
          requires_tank_spec = false,
          unparsed = false
        }
      }
    },
    APLActionWait = {
      fields = {
        duration = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "APLValue"
        }
      },
      oneofs = {

      },
      field_order = {
        "duration"
      },
      _metadata = {
        ui_label = "Wait",
        short_description = "Pauses all APL actions for a specified amount of time.",
        defaults = {
          duration = {
            value = {
              oneof_kind = "const",
              const = {
                val = "1000ms"
              }
            }
          }
        },
        submenu = {
          "Timing"
        },
        include_if = {
          prepull_only = false,
          combat_only = true,
          spec_specific = false,
          class_specific = false,
          classes = {

          },
          specs = {

          },
          excluded_classes = {

          },
          excluded_specs = {

          },
          requires_group = false,
          requires_target_dummies = false,
          requires_item_swap = false,
          requires_secondary_resource = false,
          requires_healer_spec = false,
          requires_tank_spec = false,
          unparsed = false
        },
        fields = {
          duration = {
            ui_label = "Duration",
            default = {
              value = {
                oneof_kind = "const",
                const = {
                  val = "1000ms"
                }
              }
            }
          }
        }
      }
    },
    APLActionWaitUntil = {
      fields = {
        condition = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "APLValue"
        }
      },
      oneofs = {

      },
      field_order = {
        "condition"
      },
      _metadata = {
        ui_label = "Wait Until",
        short_description = "Pauses all APL actions until the specified condition is <b>True</b>.",
        defaults = "() => APLActionWaitUntil.create()",
        submenu = {
          "Timing"
        },
        include_if = {
          prepull_only = false,
          combat_only = true,
          spec_specific = false,
          class_specific = false,
          classes = {

          },
          specs = {

          },
          excluded_classes = {

          },
          excluded_specs = {

          },
          requires_group = false,
          requires_target_dummies = false,
          requires_item_swap = false,
          requires_secondary_resource = false,
          requires_healer_spec = false,
          requires_tank_spec = false,
          unparsed = false
        },
        fields = {
          condition = {
            ui_label = "Condition"
          }
        }
      }
    },
    APLActionSchedule = {
      fields = {
        schedule = {
          id = 1,
          type = "string",
          label = "optional"
        },
        inner_action = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "APLAction"
        }
      },
      oneofs = {

      },
      field_order = {
        "schedule",
        "inner_action"
      },
      _metadata = {
        ui_label = "Scheduled Action",
        short_description = "Executes the inner action once at each specified timing.",
        defaults = {
          schedule = "0s, 60s",
          inner_action = {
            action = {
              oneof_kind = "castSpell",
              cast_spell = {

              }
            }
          }
        },
        submenu = {
          "Timing"
        },
        include_if = {
          prepull_only = false,
          combat_only = true,
          spec_specific = false,
          class_specific = false,
          classes = {

          },
          specs = {

          },
          excluded_classes = {

          },
          excluded_specs = {

          },
          requires_group = false,
          requires_target_dummies = false,
          requires_item_swap = false,
          requires_secondary_resource = false,
          requires_healer_spec = false,
          requires_tank_spec = false,
          unparsed = false
        },
        fields = {
          schedule = {
            ui_label = "Do At",
            full_description = "Comma-separated list of timings. The inner action will be performed once at each timing.",
            default = "0s, 60s"
          },
          inner_action = {
            default = {
              action = {
                oneof_kind = "castSpell",
                cast_spell = {

                }
              }
            }
          }
        }
      }
    },
    APLActionSequence = {
      fields = {
        name = {
          id = 1,
          type = "string",
          label = "optional"
        },
        actions = {
          id = 2,
          type = "message",
          label = "repeated",
          message_type = "APLAction"
        }
      },
      oneofs = {

      },
      field_order = {
        "name",
        "actions"
      },
      _metadata = {
        ui_label = "Sequence",
        short_description = "A list of sub-actions to execute in the specified order.",
        full_description = [[
			<p>Once one of the sub-actions has been performed, the next sub-action will not necessarily be immediately executed next. The system will restart at the beginning of the whole actions list (not the sequence). If the sequence is executed again, it will perform the next sub-action.</p>
			<p>When all actions have been performed, the sequence does NOT automatically reset; instead, it will be skipped from now on. Use the <b>Reset Sequence</b> action to reset it, if desired.</p>
		]],
        defaults = "APLActionSequence.create",
        submenu = {
          "Sequences"
        },
        include_if = {
          prepull_only = false,
          combat_only = true,
          spec_specific = false,
          class_specific = false,
          classes = {

          },
          specs = {

          },
          excluded_classes = {

          },
          excluded_specs = {

          },
          requires_group = false,
          requires_target_dummies = false,
          requires_item_swap = false,
          requires_secondary_resource = false,
          requires_healer_spec = false,
          requires_tank_spec = false,
          unparsed = false
        },
        fields = {
          name = {
            ui_label = "Name",
            default = ""
          },
          actions = {
            ui_label = "Action"
          }
        }
      }
    },
    APLActionResetSequence = {
      fields = {
        sequence_name = {
          id = 1,
          type = "string",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "sequence_name"
      },
      _metadata = {
        ui_label = "Reset Sequence",
        short_description = "Restarts a sequence, so that the next time it executes it will perform its first sub-action.",
        full_description = [[
			<p>Use the <b>name</b> field to refer to the sequence to be reset. The desired sequence must have the same (non-empty) value for its <b>name</b>.</p>
		]],
        defaults = "APLActionResetSequence.create",
        submenu = {
          "Sequences"
        },
        include_if = {
          prepull_only = false,
          combat_only = true,
          spec_specific = false,
          class_specific = false,
          classes = {

          },
          specs = {

          },
          excluded_classes = {

          },
          excluded_specs = {

          },
          requires_group = false,
          requires_target_dummies = false,
          requires_item_swap = false,
          requires_secondary_resource = false,
          requires_healer_spec = false,
          requires_tank_spec = false,
          unparsed = false
        },
        fields = {
          sequence_name = {
            ui_label = "Sequence Name",
            default = ""
          }
        }
      }
    },
    APLActionStrictSequence = {
      fields = {
        actions = {
          id = 1,
          type = "message",
          label = "repeated",
          message_type = "APLAction"
        }
      },
      oneofs = {

      },
      field_order = {
        "actions"
      },
      _metadata = {
        ui_label = "Strict Sequence",
        short_description = "Like a regular <b>Sequence</b>, except all sub-actions are executed immediately after each other and the sequence resets automatically upon completion.",
        full_description = [[
			<p>Strict Sequences do not begin unless ALL sub-actions are ready.</p>
		]],
        defaults = "APLActionStrictSequence.create",
        submenu = {
          "Sequences"
        },
        include_if = {
          prepull_only = false,
          combat_only = true,
          spec_specific = false,
          class_specific = false,
          classes = {

          },
          specs = {

          },
          excluded_classes = {

          },
          excluded_specs = {

          },
          requires_group = false,
          requires_target_dummies = false,
          requires_item_swap = false,
          requires_secondary_resource = false,
          requires_healer_spec = false,
          requires_tank_spec = false,
          unparsed = false
        },
        fields = {
          actions = {
            ui_label = "Action"
          }
        }
      }
    },
    APLActionChangeTarget = {
      fields = {
        new_target = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "UnitReference"
        }
      },
      oneofs = {

      },
      field_order = {
        "new_target"
      },
      _metadata = {
        ui_label = "Change Target",
        short_description = "Sets the current target, which is the target of auto attacks and most casts by default.",
        defaults = "() => APLActionChangeTarget.create()",
        submenu = {
          "Misc"
        },
        fields = {
          new_target = {
            ui_label = "Unit",
            default = {
              type = 0
            }
          }
        }
      }
    },
    APLActionCancelAura = {
      fields = {
        aura_id = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ActionID"
        }
      },
      oneofs = {

      },
      field_order = {
        "aura_id"
      },
      _metadata = {
        ui_label = "Cancel Aura",
        short_description = "Deactivates an aura, equivalent to /cancelaura.",
        defaults = "() => APLActionCancelAura.create()",
        submenu = {
          "Misc"
        },
        fields = {
          aura_id = {
            default = {

            }
          }
        }
      }
    },
    APLActionActivateAura = {
      fields = {
        aura_id = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ActionID"
        }
      },
      oneofs = {

      },
      field_order = {
        "aura_id"
      },
      _metadata = {
        ui_label = "Activate Aura",
        short_description = "Activates an aura",
        defaults = "() => APLActionActivateAura.create()",
        submenu = {
          "Misc"
        },
        include_if = {
          prepull_only = true,
          combat_only = false,
          spec_specific = false,
          class_specific = false,
          classes = {

          },
          specs = {

          },
          excluded_classes = {

          },
          excluded_specs = {

          },
          requires_group = false,
          requires_target_dummies = false,
          requires_item_swap = false,
          requires_secondary_resource = false,
          requires_healer_spec = false,
          requires_tank_spec = false,
          unparsed = false
        },
        fields = {
          aura_id = {
            default = {

            }
          }
        }
      }
    },
    APLActionActivateAuraWithStacks = {
      fields = {
        aura_id = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ActionID"
        },
        num_stacks = {
          id = 2,
          type = "string",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "aura_id",
        "num_stacks"
      },
      _metadata = {
        ui_label = "Activate Aura With Stacks",
        short_description = "Activates an aura with the specified number of stacks",
        defaults = {
          num_stacks = "1"
        },
        submenu = {
          "Misc"
        },
        include_if = {
          prepull_only = true,
          combat_only = false,
          spec_specific = false,
          class_specific = false,
          classes = {

          },
          specs = {

          },
          excluded_classes = {

          },
          excluded_specs = {

          },
          requires_group = false,
          requires_target_dummies = false,
          requires_item_swap = false,
          requires_secondary_resource = false,
          requires_healer_spec = false,
          requires_tank_spec = false,
          unparsed = false
        },
        fields = {
          aura_id = {
            default = {

            }
          },
          num_stacks = {
            ui_label = "stacks",
            full_description = "Desired number of initial aura stacks.",
            default = "1"
          }
        }
      }
    },
    APLActionAddComboPoints = {
      fields = {
        num_points = {
          id = 2,
          type = "string",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "num_points"
      },
      _metadata = {
        ui_label = "Add Combo Points",
        short_description = "Add combo points to target.",
        defaults = {
          num_points = "1"
        },
        submenu = {
          "Misc"
        },
        include_if = {
          prepull_only = true,
          combat_only = false,
          spec_specific = false,
          class_specific = false,
          classes = {

          },
          specs = {

          },
          excluded_classes = {

          },
          excluded_specs = {

          },
          requires_group = false,
          requires_target_dummies = false,
          requires_item_swap = false,
          requires_secondary_resource = false,
          requires_healer_spec = false,
          requires_tank_spec = false,
          unparsed = false
        },
        fields = {
          num_points = {
            ui_label = "Num Points",
            full_description = "Desired number of initial combo points.",
            default = "1"
          }
        }
      }
    },
    APLActionTriggerICD = {
      fields = {
        aura_id = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ActionID"
        }
      },
      oneofs = {

      },
      field_order = {
        "aura_id"
      },
      _metadata = {
        ui_label = "Trigger ICD",
        short_description = "Triggers an aura's ICD, putting it on cooldown. Example usage would be to desync an ICD cooldown before combat starts.",
        defaults = "() => APLActionTriggerICD.create()",
        submenu = {
          "Misc"
        },
        include_if = {
          prepull_only = true,
          combat_only = false,
          spec_specific = false,
          class_specific = false,
          classes = {

          },
          specs = {

          },
          excluded_classes = {

          },
          excluded_specs = {

          },
          requires_group = false,
          requires_target_dummies = false,
          requires_item_swap = false,
          requires_secondary_resource = false,
          requires_healer_spec = false,
          requires_tank_spec = false,
          unparsed = false
        },
        fields = {
          aura_id = {
            default = {

            }
          }
        }
      }
    },
    APLActionItemSwap = {
      fields = {
        swap_set = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "SwapSet"
        }
      },
      oneofs = {

      },
      field_order = {
        "swap_set"
      },
      _metadata = {
        ui_label = "Item Swap",
        short_description = "Swaps items, using the swap set specified in Settings.",
        defaults = "() => APLActionItemSwap.create()",
        submenu = {
          "Misc"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = true,
          class_specific = false,
          classes = {

          },
          specs = {

          },
          excluded_classes = {

          },
          excluded_specs = {

          },
          requires_group = false,
          requires_target_dummies = false,
          requires_item_swap = true,
          requires_secondary_resource = false,
          requires_healer_spec = false,
          requires_tank_spec = false,
          unparsed = false
        },
        fields = {
          swap_set = {
            default = 0
          }
        }
      }
    },
    APLActionCatOptimalRotationAction = {
      fields = {
        min_combos_for_rip = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        max_wait_time = {
          id = 2,
          type = "float",
          label = "optional"
        },
        maintain_faerie_fire = {
          id = 3,
          type = "bool",
          label = "optional"
        },
        use_shred_trick = {
          id = 4,
          type = "bool",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "min_combos_for_rip",
        "max_wait_time",
        "maintain_faerie_fire",
        "use_shred_trick"
      },
      _metadata = {
        ui_label = "Optimal Rotation Action",
        short_description = "Executes optimized Feral DPS rotation using hardcoded legacy algorithm.",
        defaults = {
          min_combos_for_rip = 3,
          max_wait_time = 2.0,
          maintain_faerie_fire = false,
          use_shred_trick = false
        },
        submenu = {
          "Feral Druid"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = true,
          class_specific = true,
          classes = {
            "Druid"
          },
          specs = {
            "FeralDruid"
          },
          excluded_classes = {

          },
          excluded_specs = {

          },
          requires_group = false,
          requires_target_dummies = false,
          requires_item_swap = false,
          requires_secondary_resource = false,
          requires_healer_spec = false,
          requires_tank_spec = false,
          unparsed = false
        },
        fields = {
          min_combos_for_rip = {
            ui_label = "Min Rip CP",
            full_description = "Combo Point threshold for allowing a Rip cast",
            default = 3
          },
          max_wait_time = {
            ui_label = "Max Wait Time",
            full_description = "Max seconds to wait for an Energy tick to cast rather than powershifting",
            default = 2.0
          },
          maintain_faerie_fire = {
            ui_label = "Maintain Faerie Fire",
            full_description = "If checked, bundle Faerie Fire refreshes with powershifts. Ignored if an external Faerie Fire debuff is selected in settings.",
            default = false
          },
          use_shred_trick = {
            ui_label = "Use Shred Trick",
            full_description = [[If checked, enable the "Shred trick" micro-optimization. This should only be used on short fight lengths with full powershifting uptime.]],
            default = false
          }
        }
      }
    },
    APLActionCastPaladinPrimarySeal = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Cast Primary Seal",
        short_description = "Casts the Paladin's designated primary seal spell.",
        submenu = {
          "Paladin"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = true,
          class_specific = true,
          classes = {
            "Paladin"
          },
          specs = {
            "ProtectionPaladin",
            "RetributionPaladin"
          },
          excluded_classes = {

          },
          excluded_specs = {

          },
          requires_group = false,
          requires_target_dummies = false,
          requires_item_swap = false,
          requires_secondary_resource = false,
          requires_healer_spec = false,
          requires_tank_spec = false,
          unparsed = false
        }
      }
    },
    APLActionMove = {
      fields = {
        range_from_target = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "APLValue"
        }
      },
      oneofs = {

      },
      field_order = {
        "range_from_target"
      },
      _metadata = {
        ui_label = "Move",
        short_description = "Starts a move to the desired range from target.",
        defaults = "() => APLActionMove.create()",
        submenu = {
          "Misc"
        },
        fields = {
          range_from_target = {
            ui_label = "to Range",
            full_description = "Desired range from target."
          }
        }
      }
    },
    APLActionCustomRotation = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Custom Rotation",
        short_description = "INTERNAL ONLY",
        defaults = "() => APLActionCustomRotation.create()",
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = false,
          class_specific = false,
          classes = {

          },
          specs = {

          },
          excluded_classes = {

          },
          excluded_specs = {

          },
          requires_group = false,
          requires_target_dummies = false,
          requires_item_swap = false,
          requires_secondary_resource = false,
          requires_healer_spec = false,
          requires_tank_spec = false,
          unparsed = false
        }
      }
    },
    APLValueConst = {
      fields = {
        val = {
          id = 1,
          type = "string",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "val"
      },
      _metadata = {
        ui_label = "Const",
        short_description = "A fixed value.",
        full_description = [[
		<p>
			Examples:
			<ul>
				<li><b>Number:</b> '123', '0.5', '-10'</li>
				<li><b>Time:</b> '100ms', '5s', '3m'</li>
				<li><b>Percentage:</b> '30%'</li>
			</ul>
		</p>
		]],
        defaults = "APLValueConst.create",
        fields = {
          val = {
            ui_label = "Val",
            default = ""
          }
        }
      }
    },
    APLValueAnd = {
      fields = {
        vals = {
          id = 1,
          type = "message",
          label = "repeated",
          message_type = "APLValue"
        }
      },
      oneofs = {

      },
      field_order = {
        "vals"
      },
      _metadata = {
        ui_label = "All of",
        short_description = "Returns <b>True</b> if all of the sub-values are <b>True</b>, otherwise <b>False</b>",
        defaults = "APLValueAnd.create",
        submenu = {
          "Logic"
        },
        fields = {
          vals = {
            ui_label = "Value"
          }
        }
      }
    },
    APLValueOr = {
      fields = {
        vals = {
          id = 1,
          type = "message",
          label = "repeated",
          message_type = "APLValue"
        }
      },
      oneofs = {

      },
      field_order = {
        "vals"
      },
      _metadata = {
        ui_label = "Any of",
        short_description = "Returns <b>True</b> if any of the sub-values are <b>True</b>, otherwise <b>False</b>",
        defaults = "APLValueOr.create",
        submenu = {
          "Logic"
        },
        fields = {
          vals = {
            ui_label = "Value"
          }
        }
      }
    },
    APLValueNot = {
      fields = {
        val = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "APLValue"
        }
      },
      oneofs = {

      },
      field_order = {
        "val"
      },
      _metadata = {
        ui_label = "Not",
        short_description = "Returns the opposite of the inner value, i.e. <b>True</b> if the value is <b>False</b> and vice-versa.",
        defaults = "APLValueNot.create",
        submenu = {
          "Logic"
        },
        fields = {
          val = {
            ui_label = "Val"
          }
        }
      }
    },
    APLValueCompare = {
      fields = {
        op = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "ComparisonOperator"
        },
        lhs = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "APLValue"
        },
        rhs = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "APLValue"
        }
      },
      oneofs = {

      },
      field_order = {
        "op",
        "lhs",
        "rhs"
      },
      _metadata = {
        ui_label = "Compare",
        short_description = "Compares two values.",
        defaults = "APLValueCompare.create",
        submenu = {
          "Logic"
        },
        fields = {
          lhs = {
            ui_label = "Lhs"
          },
          op = {
            default = 0
          },
          rhs = {
            ui_label = "Rhs"
          }
        }
      }
    },
    APLValueMath = {
      fields = {
        op = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "MathOperator"
        },
        lhs = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "APLValue"
        },
        rhs = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "APLValue"
        }
      },
      oneofs = {

      },
      field_order = {
        "op",
        "lhs",
        "rhs"
      },
      _metadata = {
        ui_label = "Math",
        short_description = "Do basic math on two values.",
        defaults = "APLValueMath.create",
        submenu = {
          "Logic"
        },
        fields = {
          lhs = {
            ui_label = "Lhs"
          },
          op = {
            default = 0
          },
          rhs = {
            ui_label = "Rhs"
          }
        }
      }
    },
    APLValueMax = {
      fields = {
        vals = {
          id = 1,
          type = "message",
          label = "repeated",
          message_type = "APLValue"
        }
      },
      oneofs = {

      },
      field_order = {
        "vals"
      },
      _metadata = {
        ui_label = "Max",
        short_description = "Returns the largest value among the subvalues.",
        defaults = "APLValueMax.create",
        submenu = {
          "Logic"
        },
        fields = {
          vals = {
            ui_label = "Value"
          }
        }
      }
    },
    APLValueMin = {
      fields = {
        vals = {
          id = 1,
          type = "message",
          label = "repeated",
          message_type = "APLValue"
        }
      },
      oneofs = {

      },
      field_order = {
        "vals"
      },
      _metadata = {
        ui_label = "Min",
        short_description = "Returns the smallest value among the subvalues.",
        defaults = "APLValueMin.create",
        submenu = {
          "Logic"
        },
        fields = {
          vals = {
            ui_label = "Value"
          }
        }
      }
    },
    APLValueCurrentTime = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Current Time",
        short_description = "Elapsed time of the current sim iteration.",
        defaults = "APLValueCurrentTime.create",
        submenu = {
          "Encounter"
        }
      }
    },
    APLValueCurrentTimePercent = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Current Time (%)",
        short_description = "Elapsed time of the current sim iteration, as a percentage.",
        defaults = "APLValueCurrentTimePercent.create",
        submenu = {
          "Encounter"
        }
      }
    },
    APLValueRemainingTime = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Remaining Time",
        short_description = "Elapsed time of the remaining sim iteration.",
        defaults = "APLValueRemainingTime.create",
        submenu = {
          "Encounter"
        }
      }
    },
    APLValueRemainingTimePercent = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Remaining Time (%)",
        short_description = "Elapsed time of the remaining sim iteration, as a percentage.",
        defaults = "APLValueRemainingTimePercent.create",
        submenu = {
          "Encounter"
        }
      }
    },
    APLValueNumberTargets = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Number of Targets",
        short_description = "Count of targets in the current encounter",
        defaults = "APLValueNumberTargets.create",
        submenu = {
          "Encounter"
        }
      }
    },
    APLValueIsExecutePhase = {
      fields = {
        threshold = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "ExecutePhaseThreshold"
        }
      },
      oneofs = {

      },
      field_order = {
        "threshold"
      },
      _metadata = {
        ui_label = "Is Execute Phase",
        short_description = "<b>True</b> if the encounter is in Execute Phase, meaning the target's health is less than the given threshold, otherwise <b>False</b>.",
        defaults = "APLValueIsExecutePhase.create",
        submenu = {
          "Encounter"
        },
        fields = {
          threshold = {
            default = 0
          }
        }
      }
    },
    APLValueCurrentHealth = {
      fields = {
        source_unit = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "UnitReference"
        }
      },
      oneofs = {

      },
      field_order = {
        "source_unit"
      },
      _metadata = {
        ui_label = "Health",
        short_description = "Amount of currently available Health.",
        defaults = "APLValueCurrentHealth.create",
        submenu = {
          "Resources"
        },
        fields = {
          source_unit = {
            ui_label = "Unit",
            default = {
              type = 0
            }
          }
        }
      }
    },
    APLValueCurrentHealthPercent = {
      fields = {
        source_unit = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "UnitReference"
        }
      },
      oneofs = {

      },
      field_order = {
        "source_unit"
      },
      _metadata = {
        ui_label = "Health (%)",
        short_description = "Amount of currently available Health, as a percentage.",
        defaults = "APLValueCurrentHealthPercent.create",
        submenu = {
          "Resources"
        },
        fields = {
          source_unit = {
            ui_label = "Unit",
            default = {
              type = 0
            }
          }
        }
      }
    },
    APLValueMaxHealth = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Max Health",
        short_description = "Maximum amount of Health.",
        defaults = "APLValueMaxHealth.create",
        submenu = {
          "Resources"
        }
      }
    },
    APLValueCurrentMana = {
      fields = {
        source_unit = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "UnitReference"
        }
      },
      oneofs = {

      },
      field_order = {
        "source_unit"
      },
      _metadata = {
        ui_label = "Mana",
        short_description = "Amount of currently available Mana.",
        defaults = "APLValueCurrentMana.create",
        submenu = {
          "Resources"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = false,
          class_specific = true,
          classes = {

          },
          specs = {

          },
          excluded_classes = {
            "Rogue",
            "Warrior"
          },
          excluded_specs = {

          },
          requires_group = false,
          requires_target_dummies = false,
          requires_item_swap = false,
          requires_secondary_resource = false,
          requires_healer_spec = false,
          requires_tank_spec = false,
          unparsed = false
        }
      }
    },
    APLValueCurrentManaPercent = {
      fields = {
        source_unit = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "UnitReference"
        }
      },
      oneofs = {

      },
      field_order = {
        "source_unit"
      },
      _metadata = {
        ui_label = "Mana (%)",
        short_description = "Amount of currently available Mana, as a percentage.",
        defaults = "APLValueCurrentManaPercent.create",
        submenu = {
          "Resources"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = false,
          class_specific = true,
          classes = {

          },
          specs = {

          },
          excluded_classes = {
            "Rogue",
            "Warrior"
          },
          excluded_specs = {

          },
          requires_group = false,
          requires_target_dummies = false,
          requires_item_swap = false,
          requires_secondary_resource = false,
          requires_healer_spec = false,
          requires_tank_spec = false,
          unparsed = false
        }
      }
    },
    APLValueMaxMana = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Max Mana",
        short_description = "Maximum amount of Mana.",
        defaults = "APLValueMaxMana.create",
        submenu = {
          "Resources"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = false,
          class_specific = true,
          classes = {

          },
          specs = {

          },
          excluded_classes = {
            "Rogue",
            "Warrior"
          },
          excluded_specs = {

          },
          requires_group = false,
          requires_target_dummies = false,
          requires_item_swap = false,
          requires_secondary_resource = false,
          requires_healer_spec = false,
          requires_tank_spec = false,
          unparsed = false
        }
      }
    },
    APLValueCurrentRage = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Rage",
        short_description = "Amount of currently available Rage.",
        defaults = "APLValueCurrentRage.create",
        submenu = {
          "Resources"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = false,
          class_specific = true,
          classes = {
            "Druid",
            "Warrior"
          },
          specs = {

          },
          excluded_classes = {

          },
          excluded_specs = {

          },
          requires_group = false,
          requires_target_dummies = false,
          requires_item_swap = false,
          requires_secondary_resource = false,
          requires_healer_spec = false,
          requires_tank_spec = false,
          unparsed = false
        }
      }
    },
    APLValueCurrentEnergy = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Energy",
        short_description = "Amount of currently available Energy.",
        defaults = "APLValueCurrentEnergy.create",
        submenu = {
          "Resources"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = false,
          class_specific = true,
          classes = {
            "Druid",
            "Rogue"
          },
          specs = {

          },
          excluded_classes = {

          },
          excluded_specs = {

          },
          requires_group = false,
          requires_target_dummies = false,
          requires_item_swap = false,
          requires_secondary_resource = false,
          requires_healer_spec = false,
          requires_tank_spec = false,
          unparsed = false
        }
      }
    },
    APLValueCurrentComboPoints = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Combo Points",
        short_description = "Amount of currently available Combo Points.",
        defaults = "APLValueCurrentComboPoints.create",
        submenu = {
          "Resources"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = false,
          class_specific = true,
          classes = {
            "Druid",
            "Rogue"
          },
          specs = {

          },
          excluded_classes = {

          },
          excluded_specs = {

          },
          requires_group = false,
          requires_target_dummies = false,
          requires_item_swap = false,
          requires_secondary_resource = false,
          requires_healer_spec = false,
          requires_tank_spec = false,
          unparsed = false
        }
      }
    },
    APLValueTimeToEnergyTick = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Time to Next Energy Tick",
        short_description = "Time until the next energy regen tick will happen",
        defaults = "APLValueTimeToEnergyTick.create",
        submenu = {
          "Resources"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = false,
          class_specific = true,
          classes = {
            "Druid",
            "Rogue"
          },
          specs = {

          },
          excluded_classes = {

          },
          excluded_specs = {

          },
          requires_group = false,
          requires_target_dummies = false,
          requires_item_swap = false,
          requires_secondary_resource = false,
          requires_healer_spec = false,
          requires_tank_spec = false,
          unparsed = false
        }
      }
    },
    APLValueEnergyThreshold = {
      fields = {
        threshold = {
          id = 1,
          type = "int32",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "threshold"
      },
      _metadata = {
        ui_label = "Energy Threshold",
        short_description = "Compares current energy to a threshold value.",
        defaults = "APLValueEnergyThreshold.create",
        submenu = {
          "Resources"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = false,
          class_specific = true,
          classes = {
            "Druid",
            "Rogue"
          },
          specs = {

          },
          excluded_classes = {

          },
          excluded_specs = {

          },
          requires_group = false,
          requires_target_dummies = false,
          requires_item_swap = false,
          requires_secondary_resource = false,
          requires_healer_spec = false,
          requires_tank_spec = false,
          unparsed = false
        },
        fields = {
          threshold = {
            ui_label = ">=",
            full_description = "Energy threshold. Subtracted from maximum energy if negative.",
            default = 0
          }
        }
      }
    },
    APLValueCurrentAttackPower = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Current Attack Power",
        short_description = "Current Attack Power includuing temporary bonuses.",
        defaults = "APLValueCurrentAttackPower.create",
        submenu = {
          "Stats"
        }
      }
    },
    APLValueGCDIsReady = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "GCD Is Ready",
        short_description = "<b>True</b> if the GCD is not on cooldown, otherwise <b>False</b>.",
        defaults = "APLValueGCDIsReady.create",
        submenu = {
          "GCD"
        }
      }
    },
    APLValueGCDTimeToReady = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "GCD Time To Ready",
        short_description = "Amount of time remaining before the GCD comes off cooldown, or <b>0</b> if it is not on cooldown.",
        defaults = "APLValueGCDTimeToReady.create",
        submenu = {
          "GCD"
        }
      }
    },
    APLValueAutoTimeToNext = {
      fields = {
        auto_type = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "AttackType"
        }
      },
      oneofs = {

      },
      field_order = {
        "auto_type"
      },
      _metadata = {
        ui_label = "Time To Next Auto",
        short_description = "Amount of time remaining before the next Main-hand or Off-hand melee attack, or <b>0</b> if autoattacks are not engaged.",
        defaults = "APLValueAutoTimeToNext.create",
        submenu = {
          "Auto"
        },
        fields = {
          auto_type = {
            default = 0
          }
        }
      }
    },
    APLValueAutoSwingTime = {
      fields = {
        auto_type = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "SwingType"
        }
      },
      oneofs = {

      },
      field_order = {
        "auto_type"
      },
      _metadata = {
        ui_label = "Auto Swing Time",
        short_description = "Total swing duration including all haste buffs.",
        defaults = "APLValueAutoSwingTime.create",
        submenu = {
          "Auto"
        },
        fields = {
          auto_type = {
            default = 0
          }
        }
      }
    },
    APLValueSpellIsKnown = {
      fields = {
        spell_id = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ActionID"
        }
      },
      oneofs = {

      },
      field_order = {
        "spell_id"
      },
      _metadata = {
        ui_label = "Spell Known",
        short_description = "<b>True</b> if the spell is currently known, otherwise <b>False</b>.",
        defaults = "APLValueSpellIsKnown.create",
        submenu = {
          "Spell"
        },
        fields = {
          spell_id = {
            default = {

            }
          }
        }
      }
    },
    APLValueSpellCanCast = {
      fields = {
        spell_id = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ActionID"
        }
      },
      oneofs = {

      },
      field_order = {
        "spell_id"
      },
      _metadata = {
        ui_label = "Can Cast",
        short_description = "<b>True</b> if all requirements for casting the spell are currently met, otherwise <b>False</b>.",
        full_description = [[
			<p>The <b>Cast Spell</b> action does not need to be conditioned on this, because it applies this check automatically.</p>
		]],
        defaults = "APLValueSpellCanCast.create",
        submenu = {
          "Spell"
        },
        fields = {
          spell_id = {
            default = {

            }
          }
        }
      }
    },
    APLValueSpellIsReady = {
      fields = {
        spell_id = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ActionID"
        }
      },
      oneofs = {

      },
      field_order = {
        "spell_id"
      },
      _metadata = {
        ui_label = "Is Ready",
        short_description = "<b>True</b> if the spell is not on cooldown, otherwise <b>False</b>.",
        defaults = "APLValueSpellIsReady.create",
        submenu = {
          "Spell"
        },
        fields = {
          spell_id = {
            default = {

            }
          }
        }
      }
    },
    APLValueSpellTimeToReady = {
      fields = {
        spell_id = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ActionID"
        }
      },
      oneofs = {

      },
      field_order = {
        "spell_id"
      },
      _metadata = {
        ui_label = "Time To Ready",
        short_description = "Amount of time remaining before the spell comes off cooldown, or <b>0</b> if it is not on cooldown.",
        defaults = "APLValueSpellTimeToReady.create",
        submenu = {
          "Spell"
        },
        fields = {
          spell_id = {
            default = {

            }
          }
        }
      }
    },
    APLValueSpellCastTime = {
      fields = {
        spell_id = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ActionID"
        }
      },
      oneofs = {

      },
      field_order = {
        "spell_id"
      },
      _metadata = {
        ui_label = "Cast Time",
        short_description = "Amount of time to cast the spell including any haste and spell cast time adjustments.",
        defaults = "APLValueSpellCastTime.create",
        submenu = {
          "Spell"
        },
        fields = {
          spell_id = {
            default = {

            }
          }
        }
      }
    },
    APLValueChannelClipDelay = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Channel Clip Delay",
        short_description = "The amount of time specified by the <b>Channel Clip Delay</b> setting.",
        defaults = "APLValueChannelClipDelay.create",
        submenu = {
          "Spell"
        }
      }
    },
    APLValueFrontOfTarget = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Front of Target",
        short_description = "<b>True</b> if facing from of target",
        defaults = "APLValueFrontOfTarget.create",
        submenu = {
          "Encounter"
        }
      }
    },
    APLValueSpellTravelTime = {
      fields = {
        spell_id = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ActionID"
        }
      },
      oneofs = {

      },
      field_order = {
        "spell_id"
      },
      _metadata = {
        ui_label = "Travel Time",
        short_description = "Amount of time for the spell to travel to the target.",
        defaults = "APLValueSpellTravelTime.create",
        submenu = {
          "Spell"
        },
        fields = {
          spell_id = {
            default = {

            }
          }
        }
      }
    },
    APLValueSpellInFlight = {
      fields = {
        spell_id = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ActionID"
        }
      },
      oneofs = {

      },
      field_order = {
        "spell_id"
      },
      _metadata = {
        ui_label = "In Flight",
        short_description = "<b>True</b> if the spell has a missile in flight, otherwise <b>False</b>.",
        defaults = "APLValueSpellCPM.create",
        submenu = {
          "Spell"
        },
        fields = {
          spell_id = {
            default = {

            }
          }
        }
      }
    },
    APLValueSpellCPM = {
      fields = {
        spell_id = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ActionID"
        }
      },
      oneofs = {

      },
      field_order = {
        "spell_id"
      },
      _metadata = {
        ui_label = "CPM",
        short_description = "Casts Per Minute for the spell so far in the current iteration.",
        defaults = "APLValueSpellCPM.create",
        submenu = {
          "Spell"
        },
        fields = {
          spell_id = {
            default = {

            }
          }
        }
      }
    },
    APLValueSpellIsChanneling = {
      fields = {
        spell_id = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ActionID"
        }
      },
      oneofs = {

      },
      field_order = {
        "spell_id"
      },
      _metadata = {
        ui_label = "Is Channeling",
        short_description = "<b>True</b> if this spell is currently being channeled, otherwise <b>False</b>.",
        defaults = "APLValueSpellIsChanneling.create",
        submenu = {
          "Spell"
        },
        fields = {
          spell_id = {
            default = {

            }
          }
        }
      }
    },
    APLValueSpellChanneledTicks = {
      fields = {
        spell_id = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ActionID"
        }
      },
      oneofs = {

      },
      field_order = {
        "spell_id"
      },
      _metadata = {
        ui_label = "Channeled Ticks",
        short_description = "The number of completed ticks in the current channel of this spell, or <b>0</b> if the spell is not being channeled.",
        defaults = "APLValueSpellChanneledTicks.create",
        submenu = {
          "Spell"
        },
        fields = {
          spell_id = {
            default = {

            }
          }
        }
      }
    },
    APLValueSpellCurrentCost = {
      fields = {
        spell_id = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ActionID"
        }
      },
      oneofs = {

      },
      field_order = {
        "spell_id"
      },
      _metadata = {
        ui_label = "Current Cost",
        short_description = "Returns current resource cost of spell",
        defaults = "APLValueSpellCurrentCost.create",
        submenu = {
          "Spell"
        },
        fields = {
          spell_id = {
            default = {

            }
          }
        }
      }
    },
    APLValueAuraIsKnown = {
      fields = {
        source_unit = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "UnitReference"
        },
        aura_id = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ActionID"
        }
      },
      oneofs = {

      },
      field_order = {
        "source_unit",
        "aura_id"
      },
      _metadata = {
        ui_label = "Aura Known",
        short_description = "<b>True</b> if the aura is currently known, otherwise <b>False</b>.",
        defaults = "APLValueAuraIsKnown.create",
        submenu = {
          "Aura"
        },
        fields = {
          source_unit = {
            ui_label = "Unit",
            default = {
              type = 4
            }
          },
          aura_id = {
            default = {

            }
          }
        }
      }
    },
    APLValueAuraIsActive = {
      fields = {
        source_unit = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "UnitReference"
        },
        aura_id = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ActionID"
        }
      },
      oneofs = {

      },
      field_order = {
        "source_unit",
        "aura_id"
      },
      _metadata = {
        ui_label = "Aura Active",
        short_description = "<b>True</b> if the aura is currently active, otherwise <b>False</b>.",
        defaults = "APLValueAuraIsActive.create",
        submenu = {
          "Aura"
        },
        fields = {
          source_unit = {
            ui_label = "Unit",
            default = {
              type = 4
            }
          },
          aura_id = {
            default = {

            }
          }
        }
      }
    },
    APLValueAuraIsActiveWithReactionTime = {
      fields = {
        source_unit = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "UnitReference"
        },
        aura_id = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ActionID"
        }
      },
      oneofs = {

      },
      field_order = {
        "source_unit",
        "aura_id"
      },
      _metadata = {
        ui_label = "Aura Active (with Reaction Time)",
        short_description = "<b>True</b> if the aura is currently active AND it has been active for at least as long as the player reaction time (configured in Settings), otherwise <b>False</b>.",
        defaults = "APLValueAuraIsActiveWithReactionTime.create",
        submenu = {
          "Aura"
        },
        fields = {
          source_unit = {
            ui_label = "Unit",
            default = {
              type = 4
            }
          },
          aura_id = {
            default = {

            }
          }
        }
      }
    },
    APLValueAuraRemainingTime = {
      fields = {
        source_unit = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "UnitReference"
        },
        aura_id = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ActionID"
        }
      },
      oneofs = {

      },
      field_order = {
        "source_unit",
        "aura_id"
      },
      _metadata = {
        ui_label = "Aura Remaining Time",
        short_description = "Time remaining before this aura will expire, or 0 if the aura is not currently active.",
        defaults = "APLValueAuraRemainingTime.create",
        submenu = {
          "Aura"
        },
        fields = {
          source_unit = {
            ui_label = "Unit",
            default = {
              type = 4
            }
          },
          aura_id = {
            default = {

            }
          }
        }
      }
    },
    APLValueAuraNumStacks = {
      fields = {
        source_unit = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "UnitReference"
        },
        aura_id = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ActionID"
        }
      },
      oneofs = {

      },
      field_order = {
        "source_unit",
        "aura_id"
      },
      _metadata = {
        ui_label = "Aura Num Stacks",
        short_description = "Number of stacks of the aura.",
        defaults = "APLValueAuraNumStacks.create",
        submenu = {
          "Aura"
        },
        fields = {
          source_unit = {
            ui_label = "Unit",
            default = {
              type = 4
            }
          },
          aura_id = {
            default = {

            }
          }
        }
      }
    },
    APLValueAuraInternalCooldown = {
      fields = {
        source_unit = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "UnitReference"
        },
        aura_id = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ActionID"
        }
      },
      oneofs = {

      },
      field_order = {
        "source_unit",
        "aura_id"
      },
      _metadata = {
        ui_label = "Aura Remaining ICD",
        short_description = "Time remaining before this aura's internal cooldown will be ready, or <b>0</b> if the ICD is ready now.",
        defaults = "APLValueAuraInternalCooldown.create",
        submenu = {
          "Aura"
        },
        fields = {
          source_unit = {
            ui_label = "Unit",
            default = {
              type = 4
            }
          },
          aura_id = {
            default = {

            }
          }
        }
      }
    },
    APLValueAuraICDIsReadyWithReactionTime = {
      fields = {
        source_unit = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "UnitReference"
        },
        aura_id = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ActionID"
        }
      },
      oneofs = {

      },
      field_order = {
        "source_unit",
        "aura_id"
      },
      _metadata = {
        ui_label = "Aura ICD Is Ready (with Reaction Time)",
        short_description = "<b>True</b> if the aura's ICD is currently ready OR it was put on CD recently, within the player's reaction time (configured in Settings), otherwise <b>False</b>.",
        defaults = "APLValueAuraICDIsReadyWithReactionTime.create",
        submenu = {
          "Aura"
        },
        fields = {
          source_unit = {
            ui_label = "Unit",
            default = {
              type = 4
            }
          },
          aura_id = {
            default = {

            }
          }
        }
      }
    },
    APLValueAuraShouldRefresh = {
      fields = {
        source_unit = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "UnitReference"
        },
        aura_id = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ActionID"
        },
        max_overlap = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "APLValue"
        }
      },
      oneofs = {

      },
      field_order = {
        "source_unit",
        "aura_id",
        "max_overlap"
      },
      _metadata = {
        ui_label = "Should Refresh Aura",
        short_description = "Whether this aura should be refreshed, e.g. for the purpose of maintaining a debuff.",
        full_description = [[
		<p>This condition checks not only the specified aura but also any other auras on the same unit, including auras applied by other raid members, which apply the same debuff category.</p>
		<p>For example, 'Should Refresh Debuff(Sunder Armor)' will return <b>False</b> if the unit has an active Expose Armor aura.</p>
		]],
        defaults = {
          max_overlap = {
            value = {
              oneof_kind = "const",
              const = {
                val = "0ms"
              }
            }
          }
        },
        submenu = {
          "Aura"
        },
        fields = {
          source_unit = {
            ui_label = "Unit",
            default = {
              type = 4
            }
          },
          aura_id = {
            default = {

            }
          },
          max_overlap = {
            ui_label = "Overlap",
            full_description = "Maximum amount of time before the aura expires when it may be refreshed.",
            default = {
              value = {
                oneof_kind = "const",
                const = {
                  val = "0ms"
                }
              }
            }
          }
        }
      }
    },
    APLValueRuneIsEquipped = {
      fields = {
        rune_id = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ActionID"
        }
      },
      oneofs = {

      },
      field_order = {
        "rune_id"
      },
      _metadata = {
        ui_label = "Rune Equipped",
        short_description = "<b>True</b> if the rune is currently equipped, otherwise <b>False</b>.",
        defaults = "APLValueRuneIsEquipped.create",
        submenu = {
          "Rune"
        },
        fields = {
          rune_id = {
            default = {

            }
          }
        }
      }
    },
    APLValueDotIsActive = {
      fields = {
        target_unit = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "UnitReference"
        },
        spell_id = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ActionID"
        }
      },
      oneofs = {

      },
      field_order = {
        "target_unit",
        "spell_id"
      },
      _metadata = {
        ui_label = "Dot Is Active",
        short_description = "<b>True</b> if the specified dot is currently ticking, otherwise <b>False</b>.",
        defaults = "APLValueDotIsActive.create",
        submenu = {
          "DoT"
        },
        fields = {
          target_unit = {
            ui_label = "Unit",
            default = {
              type = 5
            }
          },
          spell_id = {
            default = {

            }
          }
        }
      }
    },
    APLValueDotRemainingTime = {
      fields = {
        target_unit = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "UnitReference"
        },
        spell_id = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ActionID"
        }
      },
      oneofs = {

      },
      field_order = {
        "target_unit",
        "spell_id"
      },
      _metadata = {
        ui_label = "Dot Remaining Time",
        short_description = "Time remaining before the last tick of this DoT will occur, or 0 if the DoT is not currently ticking.",
        defaults = "APLValueDotRemainingTime.create",
        submenu = {
          "DoT"
        },
        fields = {
          target_unit = {
            ui_label = "Unit",
            default = {
              type = 5
            }
          },
          spell_id = {
            default = {

            }
          }
        }
      }
    },
    APLValueSequenceIsComplete = {
      fields = {
        sequence_name = {
          id = 1,
          type = "string",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "sequence_name"
      },
      _metadata = {
        ui_label = "Sequence Is Complete",
        short_description = "<b>True</b> if there are no more subactions left to execute in the sequence, otherwise <b>False</b>.",
        defaults = "APLValueSequenceIsComplete.create",
        submenu = {
          "Sequence"
        },
        fields = {
          sequence_name = {
            ui_label = "Sequence Name",
            default = ""
          }
        }
      }
    },
    APLValueSequenceIsReady = {
      fields = {
        sequence_name = {
          id = 1,
          type = "string",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "sequence_name"
      },
      _metadata = {
        ui_label = "Sequence Is Ready",
        short_description = "<b>True</b> if the next subaction in the sequence is ready to be executed, otherwise <b>False</b>.",
        defaults = "APLValueSequenceIsReady.create",
        submenu = {
          "Sequence"
        },
        fields = {
          sequence_name = {
            ui_label = "Sequence Name",
            default = ""
          }
        }
      }
    },
    APLValueSequenceTimeToReady = {
      fields = {
        sequence_name = {
          id = 1,
          type = "string",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "sequence_name"
      },
      _metadata = {
        ui_label = "Sequence Time To Ready",
        short_description = "Returns the amount of time remaining until the next subaction in the sequence will be ready.",
        defaults = "APLValueSequenceTimeToReady.create",
        submenu = {
          "Sequence"
        },
        fields = {
          sequence_name = {
            ui_label = "Sequence Name",
            default = ""
          }
        }
      }
    },
    APLValueTotemRemainingTime = {
      fields = {
        totem_type = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "TotemType"
        }
      },
      oneofs = {

      },
      field_order = {
        "totem_type"
      },
      _metadata = {
        ui_label = "Totem Remaining Time",
        short_description = "Returns the amount of time remaining until the totem will expire.",
        defaults = "APLValueTotemRemainingTime.create",
        submenu = {
          "Shaman"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = false,
          class_specific = true,
          classes = {
            "Shaman"
          },
          specs = {

          },
          excluded_classes = {

          },
          excluded_specs = {

          },
          requires_group = false,
          requires_target_dummies = false,
          requires_item_swap = false,
          requires_secondary_resource = false,
          requires_healer_spec = false,
          requires_tank_spec = false,
          unparsed = false
        },
        fields = {
          totem_type = {
            default = 0
          }
        }
      }
    },
    APLValueCatExcessEnergy = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Excess Energy",
        short_description = "Returns the amount of excess energy available, after subtracting energy that will be needed to maintain DoTs.",
        defaults = "APLValueCatExcessEnergy.create",
        submenu = {
          "Feral Druid"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = true,
          class_specific = true,
          classes = {
            "Druid"
          },
          specs = {
            "FeralDruid"
          },
          excluded_classes = {

          },
          excluded_specs = {

          },
          requires_group = false,
          requires_target_dummies = false,
          requires_item_swap = false,
          requires_secondary_resource = false,
          requires_healer_spec = false,
          requires_tank_spec = false,
          unparsed = false
        }
      }
    },
    APLValueWarlockShouldRecastDrainSoul = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Should Recast Drain Soul",
        short_description = "Returns <b>True</b> if the current Drain Soul channel should be immediately recast, to get a better snapshot.",
        defaults = "APLValueWarlockShouldRecastDrainSoul.create",
        submenu = {
          "Warlock"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = false,
          class_specific = true,
          classes = {
            "Warlock"
          },
          specs = {

          },
          excluded_classes = {

          },
          excluded_specs = {

          },
          requires_group = false,
          requires_target_dummies = false,
          requires_item_swap = false,
          requires_secondary_resource = false,
          requires_healer_spec = false,
          requires_tank_spec = false,
          unparsed = false
        }
      }
    },
    APLValueWarlockShouldRefreshCorruption = {
      fields = {
        target_unit = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "UnitReference"
        }
      },
      oneofs = {

      },
      field_order = {
        "target_unit"
      },
      _metadata = {
        ui_label = "Should Refresh Corruption",
        short_description = "Returns <b>True</b> if the current Corruption has expired, or should be refreshed to get a better snapshot.",
        defaults = "APLValueWarlockShouldRefreshCorruption.create",
        submenu = {
          "Warlock"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = false,
          class_specific = true,
          classes = {
            "Warlock"
          },
          specs = {

          },
          excluded_classes = {

          },
          excluded_specs = {

          },
          requires_group = false,
          requires_target_dummies = false,
          requires_item_swap = false,
          requires_secondary_resource = false,
          requires_healer_spec = false,
          requires_tank_spec = false,
          unparsed = false
        },
        fields = {
          target_unit = {
            ui_label = "Unit",
            default = {
              type = 0
            }
          }
        }
      }
    },
    APLValueWarlockCurrentPetMana = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Pet Mana",
        short_description = "Amount of currently available pet mana.",
        defaults = "APLValueWarlockCurrentPetMana.create",
        submenu = {
          "Warlock"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = false,
          class_specific = true,
          classes = {
            "Warlock"
          },
          specs = {

          },
          excluded_classes = {

          },
          excluded_specs = {

          },
          requires_group = false,
          requires_target_dummies = false,
          requires_item_swap = false,
          requires_secondary_resource = false,
          requires_healer_spec = false,
          requires_tank_spec = false,
          unparsed = false
        }
      }
    },
    APLValueWarlockCurrentPetManaPercent = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Pet Mana (%)",
        short_description = "Amount of currently available pet mana, as a percentage.",
        defaults = "APLValueWarlockCurrentPetManaPercent.create",
        submenu = {
          "Warlock"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = false,
          class_specific = true,
          classes = {
            "Warlock"
          },
          specs = {

          },
          excluded_classes = {

          },
          excluded_specs = {

          },
          requires_group = false,
          requires_target_dummies = false,
          requires_item_swap = false,
          requires_secondary_resource = false,
          requires_healer_spec = false,
          requires_tank_spec = false,
          unparsed = false
        }
      }
    },
    APLValueWarlockPetIsActive = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Pet is Active",
        short_description = "Returns <b>True</b> if the Warlock has a pet active.",
        defaults = "APLValueWarlockPetIsActive.create",
        submenu = {
          "Warlock"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = false,
          class_specific = true,
          classes = {
            "Warlock"
          },
          specs = {

          },
          excluded_classes = {

          },
          excluded_specs = {

          },
          requires_group = false,
          requires_target_dummies = false,
          requires_item_swap = false,
          requires_secondary_resource = false,
          requires_healer_spec = false,
          requires_tank_spec = false,
          unparsed = false
        }
      }
    },
    APLValueCurrentSealRemainingTime = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Current Seal Remaining Time",
        short_description = "Returns the amount of time remaining until the Paladin's current Seal aura will expire.",
        defaults = "APLValueCurrentSealRemainingTime.create",
        submenu = {
          "Paladin"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = false,
          class_specific = true,
          classes = {
            "Paladin"
          },
          specs = {

          },
          excluded_classes = {

          },
          excluded_specs = {

          },
          requires_group = false,
          requires_target_dummies = false,
          requires_item_swap = false,
          requires_secondary_resource = false,
          requires_healer_spec = false,
          requires_tank_spec = false,
          unparsed = false
        }
      }
    },
    ShamanTalents = {
      fields = {
        convection = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        concussion = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        earths_grasp = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        elemental_warding = {
          id = 4,
          type = "int32",
          label = "optional"
        },
        call_of_flame = {
          id = 5,
          type = "int32",
          label = "optional"
        },
        elemental_focus = {
          id = 6,
          type = "bool",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "shaman",
                label = "Elemental Focus Trigger",
                class_token = "shaman"
              },
              {
                class = "shaman",
                spell_id = 16246,
                label = "Clearcasting",
                duration = {
                  raw = "time.Second * 15",
                  seconds = 15.0
                },
                class_token = "shaman"
              }
            }
          }
        },
        reverberation = {
          id = 7,
          type = "int32",
          label = "optional"
        },
        call_of_thunder = {
          id = 8,
          type = "int32",
          label = "optional"
        },
        improved_fire_totems = {
          id = 9,
          type = "int32",
          label = "optional"
        },
        eye_of_the_storm = {
          id = 10,
          type = "int32",
          label = "optional"
        },
        elemental_devastation = {
          id = 11,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "shaman",
              label = "Elemental Devastation",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "shaman"
            }
          }
        },
        storm_reach = {
          id = 12,
          type = "int32",
          label = "optional"
        },
        elemental_fury = {
          id = 13,
          type = "bool",
          label = "optional"
        },
        lightning_mastery = {
          id = 14,
          type = "int32",
          label = "optional"
        },
        elemental_mastery = {
          id = 15,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 16166,
              label = "Elemental Mastery",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              flags = "SpellFlagNoOnCastComplete",
              class_token = "shaman"
            },
            aura = {
              class = "shaman",
              spell_id = 16166,
              label = "Elemental Mastery",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "shaman"
            }
          }
        },
        ancestral_knowledge = {
          id = 16,
          type = "int32",
          label = "optional"
        },
        shield_specialization = {
          id = 17,
          type = "int32",
          label = "optional"
        },
        guardian_totems = {
          id = 18,
          type = "int32",
          label = "optional"
        },
        thundering_strikes = {
          id = 19,
          type = "int32",
          label = "optional"
        },
        improved_ghost_wolf = {
          id = 20,
          type = "int32",
          label = "optional"
        },
        improved_lightning_shield = {
          id = 21,
          type = "int32",
          label = "optional"
        },
        enhancing_totems = {
          id = 22,
          type = "int32",
          label = "optional"
        },
        two_handed_axes_and_maces = {
          id = 23,
          type = "bool",
          label = "optional"
        },
        anticipation = {
          id = 24,
          type = "int32",
          label = "optional"
        },
        flurry = {
          id = 25,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "shaman",
              label = "Flurry Proc Trigger",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "shaman"
            }
          }
        },
        toughness = {
          id = 26,
          type = "int32",
          label = "optional"
        },
        improved_weapon_totems = {
          id = 27,
          type = "int32",
          label = "optional"
        },
        elemental_weapons = {
          id = 28,
          type = "int32",
          label = "optional"
        },
        parry = {
          id = 29,
          type = "bool",
          label = "optional",
          _metadata = {
            aura = {
              class = "warrior",
              spell_id = 23548,
              label = "Parry",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "warrior"
            }
          }
        },
        weapon_mastery = {
          id = 30,
          type = "int32",
          label = "optional"
        },
        stormstrike = {
          id = 31,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 17364,
              label = "Stormstrike",
              cooldown = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              flags = "SpellFlagShaman | core.SpellFlagAPL | core.SpellFlagMeleeMetrics",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "shaman"
            }
          }
        },
        improved_healing_wave = {
          id = 32,
          type = "int32",
          label = "optional"
        },
        tidal_focus = {
          id = 33,
          type = "int32",
          label = "optional"
        },
        improved_reincarnation = {
          id = 34,
          type = "int32",
          label = "optional"
        },
        ancestral_healing = {
          id = 35,
          type = "int32",
          label = "optional"
        },
        totemic_focus = {
          id = 36,
          type = "int32",
          label = "optional"
        },
        natures_guidance = {
          id = 37,
          type = "int32",
          label = "optional"
        },
        healing_focus = {
          id = 38,
          type = "int32",
          label = "optional"
        },
        totemic_mastery = {
          id = 39,
          type = "bool",
          label = "optional"
        },
        healing_grace = {
          id = 40,
          type = "int32",
          label = "optional"
        },
        restorative_totems = {
          id = 41,
          type = "int32",
          label = "optional"
        },
        tidal_mastery = {
          id = 42,
          type = "int32",
          label = "optional"
        },
        healing_way = {
          id = 43,
          type = "int32",
          label = "optional"
        },
        natures_swiftness = {
          id = 44,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 16188,
              label = "Natures Swiftness",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              flags = "SpellFlagNoOnCastComplete",
              class_token = "shaman"
            },
            aura = {
              class = "shaman",
              spell_id = 16188,
              label = "Natures Swiftness",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "shaman"
            }
          }
        },
        purification = {
          id = 45,
          type = "int32",
          label = "optional"
        },
        mana_tide_totem = {
          id = 46,
          type = "bool",
          label = "optional",
          _metadata = {
            aura = {
              class = "core",
              label = "ManaTideTotem",
              tag = "ManaTideTotem",
              duration = {
                raw = "time.Second * 12",
                seconds = 12.0
              },
              class_token = "core"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "convection",
        "concussion",
        "earths_grasp",
        "elemental_warding",
        "call_of_flame",
        "elemental_focus",
        "reverberation",
        "call_of_thunder",
        "improved_fire_totems",
        "eye_of_the_storm",
        "elemental_devastation",
        "storm_reach",
        "elemental_fury",
        "lightning_mastery",
        "elemental_mastery",
        "ancestral_knowledge",
        "shield_specialization",
        "guardian_totems",
        "thundering_strikes",
        "improved_ghost_wolf",
        "improved_lightning_shield",
        "enhancing_totems",
        "two_handed_axes_and_maces",
        "anticipation",
        "flurry",
        "toughness",
        "improved_weapon_totems",
        "elemental_weapons",
        "parry",
        "weapon_mastery",
        "stormstrike",
        "improved_healing_wave",
        "tidal_focus",
        "improved_reincarnation",
        "ancestral_healing",
        "totemic_focus",
        "natures_guidance",
        "healing_focus",
        "totemic_mastery",
        "healing_grace",
        "restorative_totems",
        "tidal_mastery",
        "healing_way",
        "natures_swiftness",
        "purification",
        "mana_tide_totem"
      }
    },
    ShamanTotems = {
      fields = {
        earth = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "EarthTotem"
        },
        air = {
          id = 2,
          type = "enum",
          label = "optional",
          enum_type = "AirTotem"
        },
        fire = {
          id = 3,
          type = "enum",
          label = "optional",
          enum_type = "FireTotem"
        },
        water = {
          id = 4,
          type = "enum",
          label = "optional",
          enum_type = "WaterTotem"
        },
        use_mana_tide = {
          id = 5,
          type = "bool",
          label = "optional"
        },
        recall_totems = {
          id = 8,
          type = "bool",
          label = "optional"
        },
        use_fire_mcd = {
          id = 9,
          type = "bool",
          label = "optional"
        },
        bonus_spellpower = {
          id = 10,
          type = "int32",
          label = "optional"
        },
        enh_tier_ten_bonus = {
          id = 11,
          type = "bool",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "earth",
        "air",
        "fire",
        "water",
        "use_mana_tide",
        "recall_totems",
        "use_fire_mcd",
        "bonus_spellpower",
        "enh_tier_ten_bonus"
      }
    },
    ElementalShaman = {
      fields = {
        options = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "Options"
        }
      },
      oneofs = {

      },
      field_order = {
        "options"
      }
    },
    EnhancementShaman = {
      fields = {
        options = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "Options"
        }
      },
      oneofs = {

      },
      field_order = {
        "options"
      }
    },
    RestorationShaman = {
      fields = {
        options = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "Options"
        }
      },
      oneofs = {

      },
      field_order = {
        "options"
      }
    },
    WardenShaman = {
      fields = {
        options = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "Options"
        }
      },
      oneofs = {

      },
      field_order = {
        "options"
      }
    },
    WarriorTalents = {
      fields = {
        improved_heroic_strike = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        deflection = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        improved_rend = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        improved_charge = {
          id = 4,
          type = "int32",
          label = "optional"
        },
        tactical_mastery = {
          id = 5,
          type = "int32",
          label = "optional"
        },
        improved_thunder_clap = {
          id = 6,
          type = "int32",
          label = "optional"
        },
        improved_overpower = {
          id = 7,
          type = "int32",
          label = "optional"
        },
        anger_management = {
          id = 8,
          type = "bool",
          label = "optional"
        },
        deep_wounds = {
          id = 9,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "warrior",
              label = "Deep Wounds Talent",
              class_token = "warrior"
            },
            spell = {
              class = "warrior",
              label = "Deep Wounds",
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
              spell_school = "2",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "warrior"
            }
          }
        },
        two_handed_weapon_specialization = {
          id = 10,
          type = "int32",
          label = "optional"
        },
        impale = {
          id = 11,
          type = "int32",
          label = "optional"
        },
        axe_specialization = {
          id = 12,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "core",
              label = "Axe Skill Specialization",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "core"
            }
          }
        },
        sweeping_strikes = {
          id = 13,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              {
                class = "warrior",
                spell_id = 12292,
                label = "Sweeping Strikes",
                cooldown = {
                  raw = "time.Second * 30",
                  seconds = 30.0
                },
                flags = "SpellFlagHelpful",
                spell_school = "2",
                class_token = "warrior"
              },
              {
                class = "warrior",
                spell_id = 26654,
                label = "Sweeping Strikes",
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete",
                spell_school = "2",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "warrior"
              },
              {
                class = "warrior",
                spell_id = 12723,
                label = "Sweeping Strikes",
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete",
                spell_school = "2",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "warrior"
              }
            },
            aura = {
              class = "warrior",
              spell_id = 12292,
              label = "Sweeping Strikes",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "warrior"
            }
          }
        },
        mace_specialization = {
          id = 14,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "core",
              label = "Mace Skill Specialization",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "core"
            }
          }
        },
        sword_specialization = {
          id = 15,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "core",
                label = "Sword Skill Specialization",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "core"
              },
              {
                class = "warrior",
                label = "Sword Specialization",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "warrior"
              }
            }
          }
        },
        polearm_specialization = {
          id = 16,
          type = "int32",
          label = "optional"
        },
        improved_hamstring = {
          id = 17,
          type = "int32",
          label = "optional"
        },
        mortal_strike = {
          id = 18,
          type = "bool",
          label = "optional"
        },
        booming_voice = {
          id = 19,
          type = "int32",
          label = "optional"
        },
        cruelty = {
          id = 20,
          type = "int32",
          label = "optional"
        },
        improved_demoralizing_shout = {
          id = 21,
          type = "int32",
          label = "optional"
        },
        unbridled_wrath = {
          id = 22,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "warrior",
              spell_id = 12964,
              label = "Unbridled Wrath",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "warrior"
            }
          }
        },
        improved_cleave = {
          id = 23,
          type = "int32",
          label = "optional"
        },
        piercing_howl = {
          id = 24,
          type = "bool",
          label = "optional"
        },
        blood_craze = {
          id = 25,
          type = "int32",
          label = "optional"
        },
        improved_battle_shout = {
          id = 26,
          type = "int32",
          label = "optional"
        },
        dual_wield_specialization = {
          id = 27,
          type = "int32",
          label = "optional"
        },
        improved_execute = {
          id = 28,
          type = "int32",
          label = "optional"
        },
        enrage = {
          id = 29,
          type = "int32",
          label = "optional",
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 5229,
              label = "Enrage",
              cooldown = {
                raw = "time.Minute",
                seconds = 60.0
              },
              flags = "SpellFlagAPL",
              class_token = "druid"
            },
            aura = {
              {
                class = "druid",
                spell_id = 5229,
                label = "Enrage Aura",
                duration = {
                  raw = "10 * time.Second",
                  seconds = 10.0
                },
                class_token = "druid"
              },
              {
                class = "warrior",
                label = "Enrage Trigger",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "warrior"
              },
              {
                class = "warrior",
                spell_id = 13048,
                label = "Enrage",
                duration = {
                  raw = "time.Second * 12",
                  seconds = 12.0
                },
                class_token = "warrior"
              }
            }
          }
        },
        improved_slam = {
          id = 30,
          type = "int32",
          label = "optional"
        },
        death_wish = {
          id = 31,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 12328,
              label = "Death Wish",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              flags = "SpellFlagHelpful",
              class_token = "warrior"
            },
            aura = {
              class = "warrior",
              spell_id = 12328,
              label = "Death Wish",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "warrior"
            }
          }
        },
        improved_intercept = {
          id = 32,
          type = "int32",
          label = "optional"
        },
        improved_berserker_rage = {
          id = 33,
          type = "int32",
          label = "optional"
        },
        flurry = {
          id = 34,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "warrior",
              label = "Flurry Proc Trigger",
              class_token = "warrior"
            }
          }
        },
        bloodthirst = {
          id = 35,
          type = "bool",
          label = "optional"
        },
        shield_specialization = {
          id = 36,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "warrior",
              spell_id = 12727,
              label = "Shield Specialization",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "warrior"
            }
          }
        },
        anticipation = {
          id = 37,
          type = "int32",
          label = "optional"
        },
        improved_bloodrage = {
          id = 38,
          type = "int32",
          label = "optional"
        },
        toughness = {
          id = 39,
          type = "int32",
          label = "optional"
        },
        iron_will = {
          id = 40,
          type = "int32",
          label = "optional"
        },
        last_stand = {
          id = 41,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 12975,
              label = "Last Stand",
              cooldown = {
                raw = "time.Minute * 10",
                seconds = 600.0
              },
              class_token = "warrior"
            },
            aura = {
              class = "warrior",
              spell_id = 12975,
              label = "Last Stand",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "warrior"
            }
          }
        },
        improved_shield_block = {
          id = 42,
          type = "int32",
          label = "optional"
        },
        improved_revenge = {
          id = 43,
          type = "int32",
          label = "optional"
        },
        defiance = {
          id = 44,
          type = "int32",
          label = "optional"
        },
        improved_sunder_armor = {
          id = 45,
          type = "int32",
          label = "optional"
        },
        improved_disarm = {
          id = 46,
          type = "int32",
          label = "optional"
        },
        improved_taunt = {
          id = 47,
          type = "int32",
          label = "optional"
        },
        improved_shield_wall = {
          id = 48,
          type = "int32",
          label = "optional"
        },
        concussion_blow = {
          id = 49,
          type = "bool",
          label = "optional"
        },
        improved_shield_bash = {
          id = 50,
          type = "int32",
          label = "optional"
        },
        one_handed_weapon_specialization = {
          id = 51,
          type = "int32",
          label = "optional"
        },
        shield_slam = {
          id = 52,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 23925,
              label = "Shield Slam",
              cooldown = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | SpellFlagOffensive",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "warrior"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "improved_heroic_strike",
        "deflection",
        "improved_rend",
        "improved_charge",
        "tactical_mastery",
        "improved_thunder_clap",
        "improved_overpower",
        "anger_management",
        "deep_wounds",
        "two_handed_weapon_specialization",
        "impale",
        "axe_specialization",
        "sweeping_strikes",
        "mace_specialization",
        "sword_specialization",
        "polearm_specialization",
        "improved_hamstring",
        "mortal_strike",
        "booming_voice",
        "cruelty",
        "improved_demoralizing_shout",
        "unbridled_wrath",
        "improved_cleave",
        "piercing_howl",
        "blood_craze",
        "improved_battle_shout",
        "dual_wield_specialization",
        "improved_execute",
        "enrage",
        "improved_slam",
        "death_wish",
        "improved_intercept",
        "improved_berserker_rage",
        "flurry",
        "bloodthirst",
        "shield_specialization",
        "anticipation",
        "improved_bloodrage",
        "toughness",
        "iron_will",
        "last_stand",
        "improved_shield_block",
        "improved_revenge",
        "defiance",
        "improved_sunder_armor",
        "improved_disarm",
        "improved_taunt",
        "improved_shield_wall",
        "concussion_blow",
        "improved_shield_bash",
        "one_handed_weapon_specialization",
        "shield_slam"
      }
    },
    Warrior = {
      fields = {
        options = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "Options"
        }
      },
      oneofs = {

      },
      field_order = {
        "options"
      }
    },
    TankWarrior = {
      fields = {
        options = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "Options"
        }
      },
      oneofs = {

      },
      field_order = {
        "options"
      }
    },
    MageTalents = {
      fields = {
        arcane_subtlety = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        arcane_focus = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        improved_arcane_missiles = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        wand_specialization = {
          id = 4,
          type = "int32",
          label = "optional"
        },
        magic_absorption = {
          id = 5,
          type = "int32",
          label = "optional"
        },
        arcane_concentration = {
          id = 6,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "mage",
                label = "Arcane Concentration",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "mage"
              },
              {
                class = "mage",
                spell_id = 12577,
                label = "Clearcasting",
                duration = {
                  raw = "time.Second * 15",
                  seconds = 15.0
                },
                class_token = "mage"
              }
            }
          }
        },
        magic_attunement = {
          id = 7,
          type = "int32",
          label = "optional"
        },
        improved_arcane_explosion = {
          id = 8,
          type = "int32",
          label = "optional"
        },
        arcane_resilience = {
          id = 9,
          type = "bool",
          label = "optional"
        },
        improved_mana_shield = {
          id = 10,
          type = "int32",
          label = "optional"
        },
        improved_counterspell = {
          id = 11,
          type = "int32",
          label = "optional"
        },
        arcane_meditation = {
          id = 12,
          type = "int32",
          label = "optional"
        },
        presence_of_mind = {
          id = 13,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 12043,
              label = "Presence Of Mind",
              cooldown = {
                raw = "time.Second * 180",
                seconds = 180.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              flags = "SpellFlagNoOnCastComplete",
              class_token = "mage"
            },
            aura = {
              class = "mage",
              spell_id = 12043,
              label = "Presence of Mind",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "mage"
            }
          }
        },
        arcane_mind = {
          id = 14,
          type = "int32",
          label = "optional"
        },
        arcane_instability = {
          id = 15,
          type = "int32",
          label = "optional"
        },
        arcane_power = {
          id = 16,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 12042,
              label = "Arcane Power",
              cooldown = {
                raw = "time.Second * 180",
                seconds = 180.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              flags = "SpellFlagNoOnCastComplete",
              class_token = "mage"
            },
            aura = {
              class = "mage",
              spell_id = 12042,
              label = "Arcane Power",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "mage"
            }
          }
        },
        improved_fireball = {
          id = 17,
          type = "int32",
          label = "optional"
        },
        impact = {
          id = 18,
          type = "int32",
          label = "optional"
        },
        ignite = {
          id = 19,
          type = "int32",
          label = "optional",
          _metadata = {
            spell = {
              {
                class = "mage",
                spell_id = 12654,
                label = "Ignite",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell | SpellFlagMage",
                spell_school = "SpellSchoolFire",
                proc_mask = "ProcMaskSpellProc",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "mage"
              },
              {
                class = "mage",
                spell_id = 12654,
                label = "Ignite",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell | SpellFlagMage",
                class_token = "mage"
              }
            },
            aura = {
              class = "mage",
              label = "Ignite Talent",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "mage"
            }
          }
        },
        flame_throwing = {
          id = 20,
          type = "int32",
          label = "optional"
        },
        improved_fire_blast = {
          id = 21,
          type = "int32",
          label = "optional"
        },
        incinerate = {
          id = 22,
          type = "int32",
          label = "optional"
        },
        improved_flamestrike = {
          id = 23,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "mage",
              spell_id = 24491,
              label = "Improved Flamestrike",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "mage"
            }
          }
        },
        pyroblast = {
          id = 24,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 20303,
              label = "Pyroblast",
              flags = "SpellFlagMage | core.SpellFlagAPL",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "mage"
            }
          }
        },
        burning_soul = {
          id = 25,
          type = "int32",
          label = "optional"
        },
        improved_scorch = {
          id = 26,
          type = "int32",
          label = "optional"
        },
        improved_fire_ward = {
          id = 27,
          type = "int32",
          label = "optional"
        },
        master_of_elements = {
          id = 28,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "mage",
              spell_id = 29076,
              label = "Master of Elements",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "mage"
            }
          }
        },
        critical_mass = {
          id = 29,
          type = "int32",
          label = "optional"
        },
        blast_wave = {
          id = 30,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 20303,
              label = "Blast Wave",
              cooldown = {
                raw = "cooldown"
              },
              flags = "SpellFlagMage | core.SpellFlagBinary | core.SpellFlagAPL",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "mage"
            }
          }
        },
        fire_power = {
          id = 31,
          type = "int32",
          label = "optional"
        },
        combustion = {
          id = 32,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 11129,
              label = "Combustion",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              flags = "SpellFlagNoOnCastComplete",
              class_token = "mage"
            },
            aura = {
              class = "mage",
              spell_id = 11129,
              label = "Combustion",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "mage"
            }
          }
        },
        frost_warding = {
          id = 33,
          type = "int32",
          label = "optional"
        },
        improved_frostbolt = {
          id = 34,
          type = "int32",
          label = "optional"
        },
        elemental_precision = {
          id = 35,
          type = "int32",
          label = "optional"
        },
        ice_shards = {
          id = 36,
          type = "int32",
          label = "optional"
        },
        frostbite = {
          id = 37,
          type = "int32",
          label = "optional"
        },
        improved_frost_nova = {
          id = 38,
          type = "int32",
          label = "optional"
        },
        permafrost = {
          id = 39,
          type = "int32",
          label = "optional"
        },
        piercing_ice = {
          id = 40,
          type = "int32",
          label = "optional"
        },
        cold_snap = {
          id = 41,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 12472,
              label = "Cold Snap",
              cooldown = {
                raw = "time.Minute * 10",
                seconds = 600.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              flags = "SpellFlagNoOnCastComplete",
              class_token = "mage"
            }
          }
        },
        improved_blizzard = {
          id = 42,
          type = "int32",
          label = "optional"
        },
        arctic_reach = {
          id = 43,
          type = "int32",
          label = "optional"
        },
        frost_channeling = {
          id = 44,
          type = "int32",
          label = "optional"
        },
        shatter = {
          id = 45,
          type = "int32",
          label = "optional"
        },
        ice_block = {
          id = 46,
          type = "bool",
          label = "optional"
        },
        improved_cone_of_cold = {
          id = 47,
          type = "int32",
          label = "optional"
        },
        winters_chill = {
          id = 48,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "mage",
              label = "Winters Chill Talent",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "mage"
            }
          }
        },
        ice_barrier = {
          id = 49,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "mage",
              label = "Ice Barrier",
              cooldown = {
                raw = "cooldown"
              },
              flags = "core.SpellFlagAPL | core.SpellFlagNoOnCastComplete",
              spell_school = "SpellSchoolFrost",
              class_token = "mage"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "arcane_subtlety",
        "arcane_focus",
        "improved_arcane_missiles",
        "wand_specialization",
        "magic_absorption",
        "arcane_concentration",
        "magic_attunement",
        "improved_arcane_explosion",
        "arcane_resilience",
        "improved_mana_shield",
        "improved_counterspell",
        "arcane_meditation",
        "presence_of_mind",
        "arcane_mind",
        "arcane_instability",
        "arcane_power",
        "improved_fireball",
        "impact",
        "ignite",
        "flame_throwing",
        "improved_fire_blast",
        "incinerate",
        "improved_flamestrike",
        "pyroblast",
        "burning_soul",
        "improved_scorch",
        "improved_fire_ward",
        "master_of_elements",
        "critical_mass",
        "blast_wave",
        "fire_power",
        "combustion",
        "frost_warding",
        "improved_frostbolt",
        "elemental_precision",
        "ice_shards",
        "frostbite",
        "improved_frost_nova",
        "permafrost",
        "piercing_ice",
        "cold_snap",
        "improved_blizzard",
        "arctic_reach",
        "frost_channeling",
        "shatter",
        "ice_block",
        "improved_cone_of_cold",
        "winters_chill",
        "ice_barrier"
      }
    },
    Mage = {
      fields = {
        options = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "Options"
        }
      },
      oneofs = {

      },
      field_order = {
        "options"
      }
    },
    HunterTalents = {
      fields = {
        improved_aspect_of_the_hawk = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        endurance_training = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        improved_eyes_of_the_beast = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        improved_aspect_of_the_monkey = {
          id = 4,
          type = "int32",
          label = "optional"
        },
        thick_hide = {
          id = 5,
          type = "int32",
          label = "optional"
        },
        improved_revive_pet = {
          id = 6,
          type = "int32",
          label = "optional"
        },
        pathfinding = {
          id = 7,
          type = "int32",
          label = "optional"
        },
        bestial_swiftness = {
          id = 8,
          type = "bool",
          label = "optional"
        },
        unleashed_fury = {
          id = 9,
          type = "int32",
          label = "optional"
        },
        improved_mend_pet = {
          id = 10,
          type = "int32",
          label = "optional"
        },
        ferocity = {
          id = 11,
          type = "int32",
          label = "optional"
        },
        spirit_bond = {
          id = 12,
          type = "int32",
          label = "optional"
        },
        intimidation = {
          id = 13,
          type = "bool",
          label = "optional"
        },
        bestial_discipline = {
          id = 14,
          type = "int32",
          label = "optional"
        },
        frenzy = {
          id = 15,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "hunter",
                label = "Frenzy",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 19625,
                label = "Frenzy Proc",
                duration = {
                  raw = "time.Second * 8",
                  seconds = 8.0
                },
                class_token = "hunter"
              },
              {
                class = "encounters",
                spec = "naxxramas",
                spell_id = 28131,
                label = "Frenzy",
                duration = {
                  raw = "5 * time.Minute",
                  seconds = 300.0
                },
                class_token = "encounters",
                spec_token = "naxxramas"
              },
              {
                class = "encounters",
                spec = "naxxramas",
                spell_id = 28131,
                label = "Frenzy",
                duration = {
                  raw = "5 * time.Minute",
                  seconds = 300.0
                },
                class_token = "encounters",
                spec_token = "naxxramas"
              }
            },
            spell = {
              class = "encounters",
              spec = "naxxramas",
              spell_id = 28131,
              label = "Frenzy",
              cooldown = {
                raw = "time.Minute * 5",
                seconds = 300.0
              },
              flags = "SpellFlagNoOnCastComplete",
              class_token = "encounters",
              spec_token = "naxxramas"
            }
          }
        },
        bestial_wrath = {
          id = 16,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 19574,
              label = "Bestial Wrath",
              cooldown = {
                raw = "time.Minute * 2",
                seconds = 120.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              flags = "SpellFlagAPL",
              class_token = "hunter"
            },
            aura = {
              class = "hunter",
              spell_id = 19574,
              label = "Bestial Wrath Pet",
              duration = {
                raw = "time.Second * 18",
                seconds = 18.0
              },
              class_token = "hunter"
            }
          }
        },
        improved_concussive_shot = {
          id = 17,
          type = "int32",
          label = "optional"
        },
        efficiency = {
          id = 18,
          type = "int32",
          label = "optional"
        },
        improved_hunters_mark = {
          id = 19,
          type = "int32",
          label = "optional"
        },
        lethal_shots = {
          id = 20,
          type = "int32",
          label = "optional"
        },
        aimed_shot = {
          id = 21,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 20303,
              label = "Aimed Shot",
              cooldown = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | SpellFlagShot",
              spell_school = "2",
              proc_mask = "ProcMaskRangedSpecial",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "hunter"
            }
          }
        },
        improved_arcane_shot = {
          id = 22,
          type = "int32",
          label = "optional"
        },
        hawk_eye = {
          id = 23,
          type = "int32",
          label = "optional"
        },
        improved_serpent_sting = {
          id = 24,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "hunter",
              label = "Improved Serpent Sting",
              class_token = "hunter"
            }
          }
        },
        mortal_shots = {
          id = 25,
          type = "int32",
          label = "optional"
        },
        scatter_shot = {
          id = 26,
          type = "bool",
          label = "optional"
        },
        barrage = {
          id = 27,
          type = "int32",
          label = "optional"
        },
        improved_scorpid_sting = {
          id = 28,
          type = "int32",
          label = "optional"
        },
        ranged_weapon_specialization = {
          id = 29,
          type = "int32",
          label = "optional"
        },
        trueshot_aura = {
          id = 30,
          type = "bool",
          label = "optional"
        },
        monster_slaying = {
          id = 31,
          type = "int32",
          label = "optional"
        },
        humanoid_slaying = {
          id = 32,
          type = "int32",
          label = "optional"
        },
        deflection = {
          id = 33,
          type = "int32",
          label = "optional"
        },
        entrapment = {
          id = 34,
          type = "int32",
          label = "optional"
        },
        savage_strikes = {
          id = 35,
          type = "int32",
          label = "optional"
        },
        improved_wing_clip = {
          id = 36,
          type = "int32",
          label = "optional"
        },
        clever_traps = {
          id = 37,
          type = "int32",
          label = "optional"
        },
        survivalist = {
          id = 38,
          type = "int32",
          label = "optional"
        },
        deterrence = {
          id = 39,
          type = "bool",
          label = "optional"
        },
        trap_mastery = {
          id = 40,
          type = "int32",
          label = "optional"
        },
        surefooted = {
          id = 41,
          type = "int32",
          label = "optional"
        },
        improved_feign_death = {
          id = 42,
          type = "int32",
          label = "optional"
        },
        killer_instinct = {
          id = 43,
          type = "int32",
          label = "optional"
        },
        counterattack = {
          id = 44,
          type = "bool",
          label = "optional"
        },
        lightning_reflexes = {
          id = 45,
          type = "int32",
          label = "optional"
        },
        wyvern_sting = {
          id = 46,
          type = "bool",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "improved_aspect_of_the_hawk",
        "endurance_training",
        "improved_eyes_of_the_beast",
        "improved_aspect_of_the_monkey",
        "thick_hide",
        "improved_revive_pet",
        "pathfinding",
        "bestial_swiftness",
        "unleashed_fury",
        "improved_mend_pet",
        "ferocity",
        "spirit_bond",
        "intimidation",
        "bestial_discipline",
        "frenzy",
        "bestial_wrath",
        "improved_concussive_shot",
        "efficiency",
        "improved_hunters_mark",
        "lethal_shots",
        "aimed_shot",
        "improved_arcane_shot",
        "hawk_eye",
        "improved_serpent_sting",
        "mortal_shots",
        "scatter_shot",
        "barrage",
        "improved_scorpid_sting",
        "ranged_weapon_specialization",
        "trueshot_aura",
        "monster_slaying",
        "humanoid_slaying",
        "deflection",
        "entrapment",
        "savage_strikes",
        "improved_wing_clip",
        "clever_traps",
        "survivalist",
        "deterrence",
        "trap_mastery",
        "surefooted",
        "improved_feign_death",
        "killer_instinct",
        "counterattack",
        "lightning_reflexes",
        "wyvern_sting"
      }
    },
    Hunter = {
      fields = {
        options = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "Options"
        }
      },
      oneofs = {

      },
      field_order = {
        "options"
      }
    },
    DruidTalents = {
      fields = {
        improved_wrath = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        natures_grasp = {
          id = 2,
          type = "bool",
          label = "optional"
        },
        improved_natures_grasp = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        improved_entangling_roots = {
          id = 4,
          type = "int32",
          label = "optional"
        },
        improved_moonfire = {
          id = 5,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "druid",
              label = "Improved moonfire",
              class_token = "druid"
            }
          }
        },
        natural_weapons = {
          id = 6,
          type = "int32",
          label = "optional"
        },
        natural_shapeshifter = {
          id = 7,
          type = "int32",
          label = "optional"
        },
        improved_thorns = {
          id = 8,
          type = "int32",
          label = "optional"
        },
        omen_of_clarity = {
          id = 9,
          type = "bool",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "druid",
                label = "Omen of Clarity",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "druid"
              },
              {
                class = "druid",
                spell_id = 16870,
                label = "Clearcasting",
                duration = {
                  raw = "time.Second * 15",
                  seconds = 15.0
                },
                class_token = "druid"
              }
            }
          }
        },
        natures_reach = {
          id = 10,
          type = "int32",
          label = "optional"
        },
        vengeance = {
          id = 11,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "druid",
              label = "Vengeance",
              class_token = "druid"
            }
          }
        },
        improved_starfire = {
          id = 12,
          type = "int32",
          label = "optional"
        },
        natures_grace = {
          id = 13,
          type = "bool",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "druid",
                label = "Natures Grace",
                class_token = "druid"
              },
              {
                class = "druid",
                spell_id = 16886,
                label = "Natures Grace Proc",
                duration = {
                  raw = "time.Second * 15",
                  seconds = 15.0
                },
                class_token = "druid"
              }
            }
          }
        },
        moonglow = {
          id = 14,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "druid",
              label = "Moonglow",
              class_token = "druid"
            }
          }
        },
        moonfury = {
          id = 15,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "druid",
              label = "Moonfury",
              class_token = "druid"
            }
          }
        },
        moonkin_form = {
          id = 16,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 24858,
              label = "Moonkin Form",
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
              class_token = "druid"
            },
            aura = {
              class = "druid",
              spell_id = 24858,
              label = "Moonkin Form",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "druid"
            }
          }
        },
        ferocity = {
          id = 17,
          type = "int32",
          label = "optional"
        },
        feral_aggression = {
          id = 18,
          type = "int32",
          label = "optional"
        },
        feral_instinct = {
          id = 19,
          type = "int32",
          label = "optional"
        },
        brutal_impact = {
          id = 20,
          type = "int32",
          label = "optional"
        },
        thick_hide = {
          id = 21,
          type = "int32",
          label = "optional"
        },
        feline_swiftness = {
          id = 22,
          type = "int32",
          label = "optional"
        },
        feral_charge = {
          id = 23,
          type = "bool",
          label = "optional"
        },
        sharpened_claws = {
          id = 24,
          type = "int32",
          label = "optional"
        },
        improved_shred = {
          id = 25,
          type = "int32",
          label = "optional"
        },
        predatory_strikes = {
          id = 26,
          type = "int32",
          label = "optional"
        },
        blood_frenzy = {
          id = 27,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "druid",
              spell_id = 16953,
              label = "Blood Frenzy",
              class_token = "druid"
            }
          }
        },
        primal_fury = {
          id = 28,
          type = "int32",
          label = "optional"
        },
        savage_fury = {
          id = 29,
          type = "int32",
          label = "optional"
        },
        faerie_fire_feral = {
          id = 30,
          type = "bool",
          label = "optional"
        },
        heart_of_the_wild = {
          id = 31,
          type = "int32",
          label = "optional"
        },
        leader_of_the_pack = {
          id = 32,
          type = "bool",
          label = "optional"
        },
        improved_mark_of_the_wild = {
          id = 33,
          type = "int32",
          label = "optional"
        },
        furor = {
          id = 34,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "druid",
              label = "Furor",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "druid"
            }
          }
        },
        improved_healing_touch = {
          id = 35,
          type = "int32",
          label = "optional"
        },
        natures_focus = {
          id = 36,
          type = "int32",
          label = "optional"
        },
        improved_enrage = {
          id = 37,
          type = "int32",
          label = "optional"
        },
        reflection = {
          id = 38,
          type = "int32",
          label = "optional"
        },
        insect_swarm = {
          id = 39,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "druid",
              label = "Insect Swarm",
              flags = "SpellFlagOmen | core.SpellFlagAPL | core.SpellFlagBinary",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "druid"
            }
          }
        },
        subtlety = {
          id = 40,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "common",
                label = "Subtlety",
                class_token = "common"
              },
              {
                class = "mage",
                spell_id = 23545,
                label = "Subtlety",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "mage"
              }
            }
          }
        },
        tranquil_spirit = {
          id = 41,
          type = "int32",
          label = "optional"
        },
        improved_rejuvenation = {
          id = 42,
          type = "int32",
          label = "optional"
        },
        natures_swiftness = {
          id = 43,
          type = "bool",
          label = "optional"
        },
        gift_of_nature = {
          id = 44,
          type = "int32",
          label = "optional"
        },
        improved_tranquility = {
          id = 45,
          type = "int32",
          label = "optional"
        },
        improved_regrowth = {
          id = 46,
          type = "int32",
          label = "optional"
        },
        swiftmend = {
          id = 47,
          type = "bool",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "improved_wrath",
        "natures_grasp",
        "improved_natures_grasp",
        "improved_entangling_roots",
        "improved_moonfire",
        "natural_weapons",
        "natural_shapeshifter",
        "improved_thorns",
        "omen_of_clarity",
        "natures_reach",
        "vengeance",
        "improved_starfire",
        "natures_grace",
        "moonglow",
        "moonfury",
        "moonkin_form",
        "ferocity",
        "feral_aggression",
        "feral_instinct",
        "brutal_impact",
        "thick_hide",
        "feline_swiftness",
        "feral_charge",
        "sharpened_claws",
        "improved_shred",
        "predatory_strikes",
        "blood_frenzy",
        "primal_fury",
        "savage_fury",
        "faerie_fire_feral",
        "heart_of_the_wild",
        "leader_of_the_pack",
        "improved_mark_of_the_wild",
        "furor",
        "improved_healing_touch",
        "natures_focus",
        "improved_enrage",
        "reflection",
        "insect_swarm",
        "subtlety",
        "tranquil_spirit",
        "improved_rejuvenation",
        "natures_swiftness",
        "gift_of_nature",
        "improved_tranquility",
        "improved_regrowth",
        "swiftmend"
      }
    },
    BalanceDruid = {
      fields = {
        options = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "Options"
        }
      },
      oneofs = {

      },
      field_order = {
        "options"
      }
    },
    FeralDruid = {
      fields = {
        rotation = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "Rotation"
        },
        options = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "Options"
        }
      },
      oneofs = {

      },
      field_order = {
        "rotation",
        "options"
      }
    },
    FeralTankDruid = {
      fields = {
        options = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "Options"
        }
      },
      oneofs = {

      },
      field_order = {
        "options"
      }
    },
    RestorationDruid = {
      fields = {
        options = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "Options"
        }
      },
      oneofs = {

      },
      field_order = {
        "options"
      }
    },
    RogueTalents = {
      fields = {
        improved_eviscerate = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        remorseless_attacks = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        malice = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        ruthlessness = {
          id = 4,
          type = "int32",
          label = "optional"
        },
        murder = {
          id = 5,
          type = "int32",
          label = "optional"
        },
        improved_slice_and_dice = {
          id = 6,
          type = "int32",
          label = "optional"
        },
        relentless_strikes = {
          id = 7,
          type = "bool",
          label = "optional"
        },
        improved_expose_armor = {
          id = 8,
          type = "int32",
          label = "optional"
        },
        lethality = {
          id = 9,
          type = "int32",
          label = "optional"
        },
        vile_poisons = {
          id = 10,
          type = "int32",
          label = "optional"
        },
        improved_poisons = {
          id = 11,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "rogue",
              label = "Improved Poisons",
              class_token = "rogue"
            }
          }
        },
        cold_blood = {
          id = 12,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 14177,
              label = "Cold Blood",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              class_token = "rogue"
            },
            aura = {
              class = "rogue",
              spell_id = 14177,
              label = "Cold Blood",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "rogue"
            }
          }
        },
        improved_kidney_shot = {
          id = 13,
          type = "int32",
          label = "optional"
        },
        seal_fate = {
          id = 14,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "rogue",
              spell_id = 14195,
              label = "Seal Fate",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "rogue"
            }
          }
        },
        vigor = {
          id = 15,
          type = "bool",
          label = "optional"
        },
        improved_gouge = {
          id = 16,
          type = "int32",
          label = "optional"
        },
        improved_sinister_strike = {
          id = 17,
          type = "int32",
          label = "optional"
        },
        lightning_reflexes = {
          id = 18,
          type = "int32",
          label = "optional"
        },
        improved_backstab = {
          id = 19,
          type = "int32",
          label = "optional"
        },
        deflection = {
          id = 20,
          type = "int32",
          label = "optional"
        },
        precision = {
          id = 21,
          type = "int32",
          label = "optional"
        },
        endurance = {
          id = 22,
          type = "int32",
          label = "optional"
        },
        riposte = {
          id = 23,
          type = "bool",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "rogue",
                label = "Riposte Trigger",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "rogue"
              },
              {
                class = "rogue",
                label = "Riposte Ready Aura",
                duration = {
                  raw = "time.Second * 5",
                  seconds = 5.0
                },
                class_token = "rogue"
              }
            },
            spell = {
              class = "rogue",
              spell_id = 14251,
              label = "Riposte",
              cooldown = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1.5",
              threat_multiplier = "1",
              class_token = "rogue"
            }
          }
        },
        improved_sprint = {
          id = 24,
          type = "int32",
          label = "optional"
        },
        improved_kick = {
          id = 25,
          type = "int32",
          label = "optional"
        },
        dagger_specialization = {
          id = 26,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "core",
              label = "Dagger Skill Specialization",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "core"
            }
          }
        },
        dual_wield_specialization = {
          id = 27,
          type = "int32",
          label = "optional"
        },
        mace_specialization = {
          id = 28,
          type = "int32",
          label = "optional"
        },
        blade_flurry = {
          id = 29,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              {
                class = "rogue",
                spell_id = 13877,
                label = "Blade Flurry",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS",
                  priority = "core.CooldownPriorityDefault"
                },
                flags = "SpellFlagAPL",
                class_token = "rogue"
              },
              {
                class = "rogue",
                spell_id = 22482,
                label = "Blade Flurry",
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete",
                spell_school = "2",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "rogue"
              }
            },
            aura = {
              class = "rogue",
              spell_id = 13877,
              label = "Blade Flurry",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "rogue"
            }
          }
        },
        sword_specialization = {
          id = 30,
          type = "int32",
          label = "optional"
        },
        fist_weapon_specialization = {
          id = 31,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "core",
              label = "Fist Weapon Skill Specialization",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "core"
            }
          }
        },
        weapon_expertise = {
          id = 32,
          type = "int32",
          label = "optional"
        },
        aggression = {
          id = 33,
          type = "int32",
          label = "optional"
        },
        adrenaline_rush = {
          id = 34,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 13750,
              label = "Adrenaline Rush",
              cooldown = {
                raw = "time.Minute * 5",
                seconds = 300.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS",
                priority = "core.CooldownPriorityBloodlust"
              },
              class_token = "rogue"
            },
            aura = {
              {
                class = "rogue",
                spell_id = 13750,
                label = "Adrenaline Rush",
                duration = {
                  raw = "time.Second * 15",
                  seconds = 15.0
                },
                class_token = "rogue"
              },
              {
                class = "hunter",
                label = "Adrenaline Rush",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "hunter"
              }
            }
          }
        },
        master_of_deception = {
          id = 35,
          type = "int32",
          label = "optional"
        },
        opportunity = {
          id = 36,
          type = "int32",
          label = "optional"
        },
        sleight_of_hand = {
          id = 37,
          type = "int32",
          label = "optional"
        },
        elusiveness = {
          id = 38,
          type = "int32",
          label = "optional"
        },
        camouflage = {
          id = 39,
          type = "int32",
          label = "optional"
        },
        initiative = {
          id = 40,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "rogue",
              spell_id = 13980,
              label = "Initiative",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "rogue"
            }
          }
        },
        ghostly_strike = {
          id = 41,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "rogue",
              label = "Ghostly Strike",
              cooldown = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              flags = "rogue.builderFlags()",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1.25",
              threat_multiplier = "1",
              class_token = "rogue"
            },
            aura = {
              class = "rogue",
              spell_id = 14278,
              label = "Ghostly Strike Buff",
              duration = {
                raw = "time.Second * 7",
                seconds = 7.0
              },
              class_token = "rogue"
            }
          }
        },
        improved_ambush = {
          id = 42,
          type = "int32",
          label = "optional"
        },
        setup = {
          id = 43,
          type = "int32",
          label = "optional"
        },
        improved_sap = {
          id = 44,
          type = "int32",
          label = "optional"
        },
        serrated_blades = {
          id = 45,
          type = "int32",
          label = "optional"
        },
        heightened_senses = {
          id = 46,
          type = "int32",
          label = "optional"
        },
        preparation = {
          id = 47,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 14185,
              label = "Preparation",
              cooldown = {
                raw = "time.Minute * 10",
                seconds = 600.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS",
                priority = "core.CooldownPriorityDefault"
              },
              flags = "SpellFlagAPL",
              class_token = "rogue"
            }
          }
        },
        dirty_deeds = {
          id = 48,
          type = "int32",
          label = "optional"
        },
        hemorrhage = {
          id = 49,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 17348,
              label = "Hemorrhage",
              flags = "rogue.builderFlags()",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "rogue"
            },
            aura = {
              class = "core",
              spell_id = 17348,
              label = "Hemorrhage",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "core"
            }
          }
        },
        deadliness = {
          id = 50,
          type = "int32",
          label = "optional"
        },
        premeditation = {
          id = 51,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 14183,
              label = "Premeditation",
              cooldown = {
                raw = "time.Minute * 2",
                seconds = 120.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS",
                priority = "core.CooldownPriorityLow"
              },
              flags = "SpellFlagAPL",
              class_token = "rogue"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "improved_eviscerate",
        "remorseless_attacks",
        "malice",
        "ruthlessness",
        "murder",
        "improved_slice_and_dice",
        "relentless_strikes",
        "improved_expose_armor",
        "lethality",
        "vile_poisons",
        "improved_poisons",
        "cold_blood",
        "improved_kidney_shot",
        "seal_fate",
        "vigor",
        "improved_gouge",
        "improved_sinister_strike",
        "lightning_reflexes",
        "improved_backstab",
        "deflection",
        "precision",
        "endurance",
        "riposte",
        "improved_sprint",
        "improved_kick",
        "dagger_specialization",
        "dual_wield_specialization",
        "mace_specialization",
        "blade_flurry",
        "sword_specialization",
        "fist_weapon_specialization",
        "weapon_expertise",
        "aggression",
        "adrenaline_rush",
        "master_of_deception",
        "opportunity",
        "sleight_of_hand",
        "elusiveness",
        "camouflage",
        "initiative",
        "ghostly_strike",
        "improved_ambush",
        "setup",
        "improved_sap",
        "serrated_blades",
        "heightened_senses",
        "preparation",
        "dirty_deeds",
        "hemorrhage",
        "deadliness",
        "premeditation"
      }
    },
    RogueOptions = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      }
    },
    Rogue = {
      fields = {
        options = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "RogueOptions"
        }
      },
      oneofs = {

      },
      field_order = {
        "options"
      }
    },
    TankRogue = {
      fields = {
        options = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "RogueOptions"
        }
      },
      oneofs = {

      },
      field_order = {
        "options"
      }
    },
    WarlockTalents = {
      fields = {
        suppression = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        improved_corruption = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        improved_curse_of_weakness = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        improved_drain_soul = {
          id = 4,
          type = "int32",
          label = "optional"
        },
        improved_life_tap = {
          id = 5,
          type = "int32",
          label = "optional"
        },
        improved_drain_life = {
          id = 6,
          type = "int32",
          label = "optional"
        },
        improved_curse_of_agony = {
          id = 7,
          type = "int32",
          label = "optional"
        },
        fel_concentration = {
          id = 8,
          type = "int32",
          label = "optional"
        },
        amplify_curse = {
          id = 9,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 18288,
              label = "Amplify Curse",
              cooldown = {
                raw = "3 * time.Minute",
                seconds = 180.0
              },
              flags = "core.SpellFlagAPL | WarlockFlagAffliction",
              spell_school = "SpellSchoolShadow",
              class_token = "warlock"
            },
            aura = {
              class = "warlock",
              spell_id = 18288,
              label = "Amplify Curse",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "warlock"
            }
          }
        },
        grim_reach = {
          id = 10,
          type = "int32",
          label = "optional"
        },
        nightfall = {
          id = 11,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "warlock",
                label = "Nightfall Hidden Aura",
                class_token = "warlock"
              },
              {
                class = "warlock",
                spell_id = 17941,
                label = "Nightfall Shadow Trance",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "warlock"
              }
            }
          }
        },
        improved_drain_mana = {
          id = 12,
          type = "int32",
          label = "optional"
        },
        siphon_life = {
          id = 13,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 20303,
              label = "Siphon Life",
              label_raw = [["SiphonLife-" + warlock.Label + strconv.Itoa(rank)]],
              flags = "core.SpellFlagAPL | core.SpellFlagResetAttackSwing | core.SpellFlagBinary | WarlockFlagAffliction",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              damage_multiplier_additive = "1",
              threat_multiplier = "1",
              class_token = "warlock"
            }
          }
        },
        curse_of_exhaustion = {
          id = 14,
          type = "bool",
          label = "optional"
        },
        improved_curse_of_exhaustion = {
          id = 15,
          type = "int32",
          label = "optional"
        },
        shadow_mastery = {
          id = 16,
          type = "int32",
          label = "optional"
        },
        dark_pact = {
          id = 17,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 20303,
              label = "Dark Pact",
              flags = "core.SpellFlagAPL | WarlockFlagAffliction",
              spell_school = "SpellSchoolShadow",
              proc_mask = "2",
              class_token = "warlock"
            }
          }
        },
        improved_healthstone = {
          id = 18,
          type = "int32",
          label = "optional"
        },
        improved_imp = {
          id = 19,
          type = "int32",
          label = "optional"
        },
        demonic_embrace = {
          id = 20,
          type = "int32",
          label = "optional"
        },
        improved_health_funnel = {
          id = 21,
          type = "int32",
          label = "optional"
        },
        improved_voidwalker = {
          id = 22,
          type = "int32",
          label = "optional"
        },
        fel_intellect = {
          id = 23,
          type = "int32",
          label = "optional"
        },
        improved_sayaad = {
          id = 24,
          type = "int32",
          label = "optional"
        },
        fel_domination = {
          id = 25,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 18708,
              label = "Fel Domination",
              cooldown = {
                raw = "time.Minute * 15",
                seconds = 900.0
              },
              major_cooldown = {
                type = "core.CooldownTypeUnknown"
              },
              spell_school = "SpellSchoolShadow",
              proc_mask = "2",
              class_token = "warlock"
            },
            aura = {
              class = "warlock",
              spell_id = 18708,
              label = "Fel Domination",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "warlock"
            }
          }
        },
        fel_stamina = {
          id = 26,
          type = "int32",
          label = "optional"
        },
        master_summoner = {
          id = 27,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "warlock",
              label = "Master Summoner Hidden Aura",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "warlock"
            }
          }
        },
        unholy_power = {
          id = 28,
          type = "int32",
          label = "optional"
        },
        improved_subjugate_demon = {
          id = 29,
          type = "int32",
          label = "optional"
        },
        demonic_sacrifice = {
          id = 30,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 18788,
              label = "Demonic Sacrifice",
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolShadow",
              class_token = "warlock"
            },
            aura = {
              {
                class = "warlock",
                spell_id = 18792,
                label = "Fel Energy",
                duration = {
                  raw = "30 * time.Minute",
                  seconds = 1800.0
                },
                class_token = "warlock"
              },
              {
                class = "warlock",
                spell_id = 18791,
                label = "Touch of Shadow",
                duration = {
                  raw = "30 * time.Minute",
                  seconds = 1800.0
                },
                class_token = "warlock"
              },
              {
                class = "warlock",
                spell_id = 18790,
                label = "Fel Stamina",
                duration = {
                  raw = "30 * time.Minute",
                  seconds = 1800.0
                },
                class_token = "warlock"
              },
              {
                class = "warlock",
                spell_id = 18789,
                label = "Burning Wish",
                duration = {
                  raw = "30 * time.Minute",
                  seconds = 1800.0
                },
                class_token = "warlock"
              }
            }
          }
        },
        improved_firestone = {
          id = 31,
          type = "int32",
          label = "optional"
        },
        master_demonologist = {
          id = 32,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "warlock",
                spell_id = 23825,
                label = "Master Demonologist (Felhunter)",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "warlock"
              },
              {
                class = "warlock",
                spell_id = 23825,
                label = "Master Demonologist (Felhunter)",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "warlock"
              },
              {
                class = "warlock",
                spell_id = 23825,
                label = "Master Demonologist (Succubus)",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "warlock"
              },
              {
                class = "warlock",
                spell_id = 23825,
                label = "Master Demonologist (Succubus)",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "warlock"
              },
              {
                class = "warlock",
                spell_id = 23825,
                label = "Master Demonologist (Voidwalker)",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "warlock"
              },
              {
                class = "warlock",
                spell_id = 23825,
                label = "Master Demonologist (Voidwalker)",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "warlock"
              },
              {
                class = "warlock",
                spell_id = 23825,
                label = "Master Demonologist (Imp)",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "warlock"
              },
              {
                class = "warlock",
                spell_id = 23825,
                label = "Master Demonologist (Imp)",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "warlock"
              }
            }
          }
        },
        soul_link = {
          id = 33,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 19028,
              label = "Soul Link",
              flags = "SpellFlagAPL",
              class_token = "warlock"
            },
            aura = {
              {
                class = "warlock",
                spell_id = 19028,
                label = "Soul Link Aura",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "warlock"
              },
              {
                class = "warlock",
                spell_id = 19028,
                label = "Soul Link Aura",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "warlock"
              }
            }
          }
        },
        improved_spellstone = {
          id = 34,
          type = "int32",
          label = "optional"
        },
        improved_shadow_bolt = {
          id = 35,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "warlock",
              label = "ISB Trigger",
              class_token = "warlock"
            }
          }
        },
        cataclysm = {
          id = 36,
          type = "int32",
          label = "optional"
        },
        bane = {
          id = 37,
          type = "int32",
          label = "optional"
        },
        aftermath = {
          id = 38,
          type = "int32",
          label = "optional"
        },
        improved_firebolt = {
          id = 39,
          type = "int32",
          label = "optional"
        },
        improved_lash_of_pain = {
          id = 40,
          type = "int32",
          label = "optional"
        },
        devastation = {
          id = 41,
          type = "int32",
          label = "optional"
        },
        shadowburn = {
          id = 42,
          type = "bool",
          label = "optional"
        },
        intensity = {
          id = 43,
          type = "int32",
          label = "optional"
        },
        destructive_reach = {
          id = 44,
          type = "int32",
          label = "optional"
        },
        improved_searing_pain = {
          id = 45,
          type = "int32",
          label = "optional"
        },
        pyroclasm = {
          id = 46,
          type = "int32",
          label = "optional"
        },
        improved_immolate = {
          id = 47,
          type = "int32",
          label = "optional"
        },
        ruin = {
          id = 48,
          type = "bool",
          label = "optional"
        },
        emberstorm = {
          id = 49,
          type = "int32",
          label = "optional"
        },
        conflagrate = {
          id = 50,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 20303,
              label = "Conflagrate",
              cooldown = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              flags = "core.SpellFlagAPL | WarlockFlagDestruction",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "warlock"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "suppression",
        "improved_corruption",
        "improved_curse_of_weakness",
        "improved_drain_soul",
        "improved_life_tap",
        "improved_drain_life",
        "improved_curse_of_agony",
        "fel_concentration",
        "amplify_curse",
        "grim_reach",
        "nightfall",
        "improved_drain_mana",
        "siphon_life",
        "curse_of_exhaustion",
        "improved_curse_of_exhaustion",
        "shadow_mastery",
        "dark_pact",
        "improved_healthstone",
        "improved_imp",
        "demonic_embrace",
        "improved_health_funnel",
        "improved_voidwalker",
        "fel_intellect",
        "improved_sayaad",
        "fel_domination",
        "fel_stamina",
        "master_summoner",
        "unholy_power",
        "improved_subjugate_demon",
        "demonic_sacrifice",
        "improved_firestone",
        "master_demonologist",
        "soul_link",
        "improved_spellstone",
        "improved_shadow_bolt",
        "cataclysm",
        "bane",
        "aftermath",
        "improved_firebolt",
        "improved_lash_of_pain",
        "devastation",
        "shadowburn",
        "intensity",
        "destructive_reach",
        "improved_searing_pain",
        "pyroclasm",
        "improved_immolate",
        "ruin",
        "emberstorm",
        "conflagrate"
      }
    },
    WarlockRotation = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      }
    },
    WarlockOptions = {
      fields = {
        armor = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "Armor"
        },
        summon = {
          id = 2,
          type = "enum",
          label = "optional",
          enum_type = "Summon"
        },
        weapon_imbue = {
          id = 3,
          type = "enum",
          label = "optional",
          enum_type = "WeaponImbue"
        },
        max_firebolt_rank = {
          id = 4,
          type = "enum",
          label = "optional",
          enum_type = "MaxFireboltRank"
        },
        pet_pool_mana = {
          id = 5,
          type = "bool",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "armor",
        "summon",
        "weapon_imbue",
        "max_firebolt_rank",
        "pet_pool_mana"
      }
    },
    Warlock = {
      fields = {
        options = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "WarlockOptions"
        }
      },
      oneofs = {

      },
      field_order = {
        "options"
      }
    },
    TankWarlock = {
      fields = {
        options = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "WarlockOptions"
        }
      },
      oneofs = {

      },
      field_order = {
        "options"
      }
    },
    CharacterStatsTestResult = {
      fields = {
        final_stats = {
          id = 1,
          type = "double",
          label = "repeated"
        }
      },
      oneofs = {

      },
      field_order = {
        "final_stats"
      }
    },
    StatWeightsTestResult = {
      fields = {
        weights = {
          id = 1,
          type = "double",
          label = "repeated"
        }
      },
      oneofs = {

      },
      field_order = {
        "weights"
      }
    },
    DpsTestResult = {
      fields = {
        dps = {
          id = 1,
          type = "double",
          label = "optional"
        },
        tps = {
          id = 2,
          type = "double",
          label = "optional"
        },
        dtps = {
          id = 3,
          type = "double",
          label = "optional"
        },
        hps = {
          id = 4,
          type = "double",
          label = "optional"
        },
        tmi = {
          id = 5,
          type = "double",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "dps",
        "tps",
        "dtps",
        "hps",
        "tmi"
      }
    },
    CastsEntry = {
      fields = {
        key = {
          id = 1,
          type = "string",
          label = "optional"
        },
        value = {
          id = 2,
          type = "double",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "key",
        "value"
      }
    },
    CastsTestResult = {
      fields = {
        casts = {
          id = 1,
          type = "message",
          label = "repeated",
          message_type = "CastsEntry"
        }
      },
      oneofs = {

      },
      field_order = {
        "casts"
      }
    },
    CharacterStatsResultsEntry = {
      fields = {
        key = {
          id = 1,
          type = "string",
          label = "optional"
        },
        value = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "CharacterStatsTestResult"
        }
      },
      oneofs = {

      },
      field_order = {
        "key",
        "value"
      }
    },
    StatWeightsResultsEntry = {
      fields = {
        key = {
          id = 1,
          type = "string",
          label = "optional"
        },
        value = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "StatWeightsTestResult"
        }
      },
      oneofs = {

      },
      field_order = {
        "key",
        "value"
      }
    },
    DpsResultsEntry = {
      fields = {
        key = {
          id = 1,
          type = "string",
          label = "optional"
        },
        value = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "DpsTestResult"
        }
      },
      oneofs = {

      },
      field_order = {
        "key",
        "value"
      }
    },
    CastsResultsEntry = {
      fields = {
        key = {
          id = 1,
          type = "string",
          label = "optional"
        },
        value = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "CastsTestResult"
        }
      },
      oneofs = {

      },
      field_order = {
        "key",
        "value"
      }
    },
    TestSuiteResult = {
      fields = {
        character_stats_results = {
          id = 2,
          type = "message",
          label = "repeated",
          message_type = "CharacterStatsResultsEntry"
        },
        stat_weights_results = {
          id = 3,
          type = "message",
          label = "repeated",
          message_type = "StatWeightsResultsEntry"
        },
        dps_results = {
          id = 1,
          type = "message",
          label = "repeated",
          message_type = "DpsResultsEntry"
        },
        casts_results = {
          id = 4,
          type = "message",
          label = "repeated",
          message_type = "CastsResultsEntry"
        }
      },
      oneofs = {

      },
      field_order = {
        "character_stats_results",
        "stat_weights_results",
        "dps_results",
        "casts_results"
      }
    },
    PaladinTalents = {
      fields = {
        divine_strength = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        divine_intellect = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        spiritual_focus = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        improved_seal_of_righteousness = {
          id = 4,
          type = "int32",
          label = "optional"
        },
        healing_light = {
          id = 5,
          type = "int32",
          label = "optional"
        },
        consecration = {
          id = 6,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "paladin",
              label = "Consecration",
              label_raw = [["Consecration" + paladin.Label + strconv.Itoa(i+1)]],
              cooldown = {
                raw = "time.Second * 8",
                seconds = 8.0
              },
              flags = "core.SpellFlagPureDot | core.SpellFlagAPL",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "paladin"
            }
          }
        },
        improved_lay_on_hands = {
          id = 7,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "paladin",
              label = "Lay on Hands",
              duration = {
                raw = "time.Minute * 2",
                seconds = 120.0
              },
              class_token = "paladin"
            }
          }
        },
        unyielding_faith = {
          id = 8,
          type = "int32",
          label = "optional"
        },
        illumination = {
          id = 9,
          type = "int32",
          label = "optional"
        },
        improved_blessing_of_wisdom = {
          id = 10,
          type = "int32",
          label = "optional"
        },
        divine_favor = {
          id = 11,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "paladin",
              label = "Divine Favor",
              cooldown = {
                raw = "time.Minute * 2",
                seconds = 120.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              flags = "SpellFlagNoOnCastComplete",
              class_token = "paladin"
            },
            aura = {
              class = "paladin",
              spell_id = 20216,
              label = "Divine Favor",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "paladin"
            }
          }
        },
        lasting_judgement = {
          id = 12,
          type = "int32",
          label = "optional"
        },
        holy_power = {
          id = 13,
          type = "int32",
          label = "optional"
        },
        holy_shock = {
          id = 14,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "paladin",
              label = "Holy Shock",
              cooldown = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "paladin"
            }
          }
        },
        improved_devotion_aura = {
          id = 15,
          type = "int32",
          label = "optional"
        },
        redoubt = {
          id = 16,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "paladin",
                label = "Redoubt Crit Trigger",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "paladin"
              },
              {
                class = "paladin",
                spell_id = 20134,
                label = "Redoubt",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "paladin"
              }
            }
          }
        },
        precision = {
          id = 17,
          type = "int32",
          label = "optional"
        },
        guardians_favor = {
          id = 18,
          type = "int32",
          label = "optional"
        },
        toughness = {
          id = 19,
          type = "int32",
          label = "optional"
        },
        blessing_of_kings = {
          id = 20,
          type = "bool",
          label = "optional"
        },
        improved_righteous_fury = {
          id = 21,
          type = "int32",
          label = "optional"
        },
        shield_specialization = {
          id = 22,
          type = "int32",
          label = "optional"
        },
        anticipation = {
          id = 23,
          type = "int32",
          label = "optional"
        },
        improved_hammer_of_justice = {
          id = 24,
          type = "int32",
          label = "optional"
        },
        improved_concentration_aura = {
          id = 25,
          type = "int32",
          label = "optional"
        },
        blessing_of_sanctuary = {
          id = 26,
          type = "bool",
          label = "optional",
          _metadata = {
            aura = {
              class = "paladin",
              label = "Blessing of Sanctuary Trigger",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "paladin"
            },
            spell = {
              class = "paladin",
              label = "Blessing Of Sanctuary",
              flags = "2",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "paladin"
            }
          }
        },
        reckoning = {
          id = 27,
          type = "int32",
          label = "optional"
        },
        one_handed_weapon_specialization = {
          id = 28,
          type = "int32",
          label = "optional"
        },
        holy_shield = {
          id = 29,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              {
                class = "paladin",
                label = "Holy Shield",
                cooldown = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                flags = "SpellFlagAPL",
                class_token = "paladin"
              },
              {
                class = "paladin",
                label = "Holy Shield",
                spell_school = "SpellSchoolHoly",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                threat_multiplier = "1.2",
                class_token = "paladin"
              }
            },
            aura = {
              class = "paladin",
              label = "Holy Shield",
              label_raw = [["Holy Shield" + paladin.Label + strconv.Itoa(rank)]],
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "paladin"
            }
          }
        },
        improved_blessing_of_might = {
          id = 30,
          type = "int32",
          label = "optional"
        },
        benediction = {
          id = 31,
          type = "int32",
          label = "optional"
        },
        improved_judgement = {
          id = 32,
          type = "int32",
          label = "optional"
        },
        improved_seal_of_the_crusader = {
          id = 33,
          type = "int32",
          label = "optional"
        },
        deflection = {
          id = 34,
          type = "int32",
          label = "optional"
        },
        vindication = {
          id = 35,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "core",
                spell_id = 26016,
                label = "Vindication",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "core"
              },
              {
                class = "paladin",
                label = "Vindication Talent",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "paladin"
              },
              {
                class = "paladin",
                spell_id = 26021,
                label = "Vindication Proc",
                duration = {
                  raw = "time.Second * 30",
                  seconds = 30.0
                },
                class_token = "paladin"
              }
            }
          }
        },
        conviction = {
          id = 36,
          type = "int32",
          label = "optional"
        },
        seal_of_command = {
          id = 37,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              {
                class = "paladin",
                label = "Seal Of Command",
                flags = "SpellFlagAPL",
                spell_school = "SpellSchoolHoly",
                class_token = "paladin"
              },
              {
                class = "paladin",
                label = "Seal Of Command",
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNotAProc",
                spell_school = "SpellSchoolHoly",
                proc_mask = "core.ProcMaskMeleeMHSpecial | core.ProcMaskMeleeProc | core.ProcMaskMeleeDamageProc",
                damage_multiplier = "0.7 * paladin.getWeaponSpecializationModifier()",
                threat_multiplier = "1",
                class_token = "paladin"
              },
              {
                class = "paladin",
                label = "Seal Of Command",
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete",
                spell_school = "SpellSchoolHoly",
                proc_mask = "ProcMaskMeleeMHSpecial",
                damage_multiplier = "paladin.getWeaponSpecializationModifier()",
                threat_multiplier = "1",
                class_token = "paladin"
              }
            },
            aura = {
              class = "paladin",
              label = "Seal Of Command",
              label_raw = [["Seal of Command" + paladin.Label + strconv.Itoa(i+1)]],
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "paladin"
            }
          }
        },
        pursuit_of_justice = {
          id = 38,
          type = "int32",
          label = "optional"
        },
        eye_for_an_eye = {
          id = 39,
          type = "int32",
          label = "optional"
        },
        improved_retribution_aura = {
          id = 40,
          type = "int32",
          label = "optional"
        },
        two_handed_weapon_specialization = {
          id = 41,
          type = "int32",
          label = "optional"
        },
        sanctity_aura = {
          id = 42,
          type = "bool",
          label = "optional"
        },
        vengeance = {
          id = 43,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "paladin",
                label = "Vengeance",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "paladin"
              },
              {
                class = "paladin",
                spell_id = 20059,
                label = "Vengeance Proc",
                duration = {
                  raw = "time.Second * 8",
                  seconds = 8.0
                },
                class_token = "paladin"
              }
            }
          }
        },
        repentance = {
          id = 44,
          type = "bool",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "divine_strength",
        "divine_intellect",
        "spiritual_focus",
        "improved_seal_of_righteousness",
        "healing_light",
        "consecration",
        "improved_lay_on_hands",
        "unyielding_faith",
        "illumination",
        "improved_blessing_of_wisdom",
        "divine_favor",
        "lasting_judgement",
        "holy_power",
        "holy_shock",
        "improved_devotion_aura",
        "redoubt",
        "precision",
        "guardians_favor",
        "toughness",
        "blessing_of_kings",
        "improved_righteous_fury",
        "shield_specialization",
        "anticipation",
        "improved_hammer_of_justice",
        "improved_concentration_aura",
        "blessing_of_sanctuary",
        "reckoning",
        "one_handed_weapon_specialization",
        "holy_shield",
        "improved_blessing_of_might",
        "benediction",
        "improved_judgement",
        "improved_seal_of_the_crusader",
        "deflection",
        "vindication",
        "conviction",
        "seal_of_command",
        "pursuit_of_justice",
        "eye_for_an_eye",
        "improved_retribution_aura",
        "two_handed_weapon_specialization",
        "sanctity_aura",
        "vengeance",
        "repentance"
      }
    },
    PaladinOptions = {
      fields = {
        primarySeal = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "PaladinSeal"
        },
        aura = {
          id = 2,
          type = "enum",
          label = "optional",
          enum_type = "PaladinAura"
        },
        IsUsingDivineStormStopAttack = {
          id = 4,
          type = "bool",
          label = "optional"
        },
        IsUsingJudgementStopAttack = {
          id = 5,
          type = "bool",
          label = "optional"
        },
        IsUsingCrusaderStrikeStopAttack = {
          id = 6,
          type = "bool",
          label = "optional"
        },
        righteousFury = {
          id = 8,
          type = "bool",
          label = "optional"
        },
        personalBlessing = {
          id = 9,
          type = "enum",
          label = "optional",
          enum_type = "Blessings"
        }
      },
      oneofs = {

      },
      field_order = {
        "primarySeal",
        "aura",
        "IsUsingDivineStormStopAttack",
        "IsUsingJudgementStopAttack",
        "IsUsingCrusaderStrikeStopAttack",
        "righteousFury",
        "personalBlessing"
      }
    },
    RetributionPaladin = {
      fields = {
        options = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "PaladinOptions"
        }
      },
      oneofs = {

      },
      field_order = {
        "options"
      }
    },
    ProtectionPaladin = {
      fields = {
        options = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "PaladinOptions"
        }
      },
      oneofs = {

      },
      field_order = {
        "options"
      }
    },
    HolyPaladin = {
      fields = {
        options = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "PaladinOptions"
        }
      },
      oneofs = {

      },
      field_order = {
        "options"
      }
    },
    UIDatabase = {
      fields = {
        items = {
          id = 1,
          type = "message",
          label = "repeated",
          message_type = "UIItem"
        },
        random_suffixes = {
          id = 10,
          type = "message",
          label = "repeated",
          message_type = "ItemRandomSuffix"
        },
        enchants = {
          id = 2,
          type = "message",
          label = "repeated",
          message_type = "UIEnchant"
        },
        encounters = {
          id = 6,
          type = "message",
          label = "repeated",
          message_type = "PresetEncounter"
        },
        zones = {
          id = 8,
          type = "message",
          label = "repeated",
          message_type = "UIZone"
        },
        npcs = {
          id = 9,
          type = "message",
          label = "repeated",
          message_type = "UINPC"
        },
        factions = {
          id = 11,
          type = "message",
          label = "repeated",
          message_type = "UIFaction"
        },
        item_icons = {
          id = 4,
          type = "message",
          label = "repeated",
          message_type = "IconData"
        },
        spell_icons = {
          id = 5,
          type = "message",
          label = "repeated",
          message_type = "IconData"
        }
      },
      oneofs = {

      },
      field_order = {
        "items",
        "random_suffixes",
        "enchants",
        "encounters",
        "zones",
        "npcs",
        "factions",
        "item_icons",
        "spell_icons"
      }
    },
    UIZone = {
      fields = {
        id = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        name = {
          id = 2,
          type = "string",
          label = "optional"
        },
        expansion = {
          id = 3,
          type = "enum",
          label = "optional",
          enum_type = "Expansion"
        }
      },
      oneofs = {

      },
      field_order = {
        "id",
        "name",
        "expansion"
      }
    },
    UINPC = {
      fields = {
        id = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        name = {
          id = 2,
          type = "string",
          label = "optional"
        },
        zone_id = {
          id = 3,
          type = "int32",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "id",
        "name",
        "zone_id"
      }
    },
    UIFaction = {
      fields = {
        id = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        name = {
          id = 2,
          type = "string",
          label = "optional"
        },
        expansion = {
          id = 3,
          type = "enum",
          label = "optional",
          enum_type = "Expansion"
        }
      },
      oneofs = {

      },
      field_order = {
        "id",
        "name",
        "expansion"
      }
    },
    UIItem = {
      fields = {
        id = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        name = {
          id = 2,
          type = "string",
          label = "optional"
        },
        icon = {
          id = 3,
          type = "string",
          label = "optional"
        },
        type = {
          id = 4,
          type = "enum",
          label = "optional",
          enum_type = "ItemType"
        },
        armor_type = {
          id = 5,
          type = "enum",
          label = "optional",
          enum_type = "ArmorType"
        },
        weapon_type = {
          id = 6,
          type = "enum",
          label = "optional",
          enum_type = "WeaponType"
        },
        hand_type = {
          id = 7,
          type = "enum",
          label = "optional",
          enum_type = "HandType"
        },
        ranged_weapon_type = {
          id = 8,
          type = "enum",
          label = "optional",
          enum_type = "RangedWeaponType"
        },
        stats = {
          id = 10,
          type = "double",
          label = "repeated"
        },
        random_suffix_options = {
          id = 27,
          type = "int32",
          label = "repeated"
        },
        weapon_damage_min = {
          id = 13,
          type = "double",
          label = "optional"
        },
        weapon_damage_max = {
          id = 14,
          type = "double",
          label = "optional"
        },
        weapon_speed = {
          id = 15,
          type = "double",
          label = "optional"
        },
        weapon_skills = {
          id = 28,
          type = "double",
          label = "repeated"
        },
        bonus_physical_damage = {
          id = 30,
          type = "double",
          label = "optional"
        },
        ilvl = {
          id = 16,
          type = "int32",
          label = "optional"
        },
        phase = {
          id = 17,
          type = "int32",
          label = "optional"
        },
        quality = {
          id = 18,
          type = "enum",
          label = "optional",
          enum_type = "ItemQuality"
        },
        unique = {
          id = 19,
          type = "bool",
          label = "optional"
        },
        heroic = {
          id = 20,
          type = "bool",
          label = "optional"
        },
        class_allowlist = {
          id = 21,
          type = "enum",
          label = "repeated",
          enum_type = "Class"
        },
        required_profession = {
          id = 22,
          type = "enum",
          label = "optional",
          enum_type = "Profession"
        },
        set_name = {
          id = 23,
          type = "string",
          label = "optional"
        },
        set_id = {
          id = 29,
          type = "int32",
          label = "optional"
        },
        expansion = {
          id = 24,
          type = "enum",
          label = "optional",
          enum_type = "Expansion"
        },
        sources = {
          id = 25,
          type = "message",
          label = "repeated",
          message_type = "UIItemSource"
        },
        faction_restriction = {
          id = 26,
          type = "enum",
          label = "optional",
          enum_type = "FactionRestriction"
        }
      },
      oneofs = {

      },
      field_order = {
        "id",
        "name",
        "icon",
        "type",
        "armor_type",
        "weapon_type",
        "hand_type",
        "ranged_weapon_type",
        "stats",
        "random_suffix_options",
        "weapon_damage_min",
        "weapon_damage_max",
        "weapon_speed",
        "weapon_skills",
        "bonus_physical_damage",
        "ilvl",
        "phase",
        "quality",
        "unique",
        "heroic",
        "class_allowlist",
        "required_profession",
        "set_name",
        "set_id",
        "expansion",
        "sources",
        "faction_restriction"
      }
    },
    UIItemSource = {
      fields = {
        crafted = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "CraftedSource"
        },
        drop = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "DropSource"
        },
        quest = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "QuestSource"
        },
        sold_by = {
          id = 4,
          type = "message",
          label = "optional",
          message_type = "SoldBySource"
        },
        rep = {
          id = 5,
          type = "message",
          label = "optional",
          message_type = "RepSource"
        }
      },
      oneofs = {
        source = {
          "crafted",
          "drop",
          "quest",
          "sold_by",
          "rep"
        }
      },
      field_order = {
        "crafted",
        "drop",
        "quest",
        "sold_by",
        "rep"
      }
    },
    CraftedSource = {
      fields = {
        profession = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "Profession"
        },
        spell_id = {
          id = 2,
          type = "int32",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "profession",
        "spell_id"
      }
    },
    DropSource = {
      fields = {
        difficulty = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "DungeonDifficulty"
        },
        npc_id = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        zone_id = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        other_name = {
          id = 4,
          type = "string",
          label = "optional"
        },
        category = {
          id = 5,
          type = "string",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "difficulty",
        "npc_id",
        "zone_id",
        "other_name",
        "category"
      }
    },
    QuestSource = {
      fields = {
        id = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        name = {
          id = 2,
          type = "string",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "id",
        "name"
      }
    },
    SoldBySource = {
      fields = {
        npc_id = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        npc_name = {
          id = 2,
          type = "string",
          label = "optional"
        },
        zone_id = {
          id = 3,
          type = "int32",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "npc_id",
        "npc_name",
        "zone_id"
      }
    },
    RepSource = {
      fields = {
        rep_faction_id = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        rep_level = {
          id = 2,
          type = "enum",
          label = "optional",
          enum_type = "RepLevel"
        },
        player_faction = {
          id = 3,
          type = "enum",
          label = "optional",
          enum_type = "Faction"
        }
      },
      oneofs = {

      },
      field_order = {
        "rep_faction_id",
        "rep_level",
        "player_faction"
      }
    },
    UIEnchant = {
      fields = {
        effect_id = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        item_id = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        spell_id = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        name = {
          id = 4,
          type = "string",
          label = "optional"
        },
        icon = {
          id = 5,
          type = "string",
          label = "optional"
        },
        type = {
          id = 6,
          type = "enum",
          label = "optional",
          enum_type = "ItemType"
        },
        extra_types = {
          id = 13,
          type = "enum",
          label = "repeated",
          enum_type = "ItemType"
        },
        enchant_type = {
          id = 7,
          type = "enum",
          label = "optional",
          enum_type = "EnchantType"
        },
        stats = {
          id = 8,
          type = "double",
          label = "repeated"
        },
        quality = {
          id = 9,
          type = "enum",
          label = "optional",
          enum_type = "ItemQuality"
        },
        phase = {
          id = 10,
          type = "int32",
          label = "optional"
        },
        class_allowlist = {
          id = 11,
          type = "enum",
          label = "repeated",
          enum_type = "Class"
        },
        required_profession = {
          id = 12,
          type = "enum",
          label = "optional",
          enum_type = "Profession"
        }
      },
      oneofs = {

      },
      field_order = {
        "effect_id",
        "item_id",
        "spell_id",
        "name",
        "icon",
        "type",
        "extra_types",
        "enchant_type",
        "stats",
        "quality",
        "phase",
        "class_allowlist",
        "required_profession"
      }
    },
    IconData = {
      fields = {
        id = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        name = {
          id = 2,
          type = "string",
          label = "optional"
        },
        icon = {
          id = 3,
          type = "string",
          label = "optional"
        },
        rank = {
          id = 4,
          type = "int32",
          label = "optional"
        },
        has_buff = {
          id = 5,
          type = "bool",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "id",
        "name",
        "icon",
        "rank",
        "has_buff"
      }
    },
    DatabaseFilters = {
      fields = {
        armor_types = {
          id = 1,
          type = "enum",
          label = "repeated",
          enum_type = "ArmorType"
        },
        weapon_types = {
          id = 2,
          type = "enum",
          label = "repeated",
          enum_type = "WeaponType"
        },
        ranged_weapon_types = {
          id = 16,
          type = "enum",
          label = "repeated",
          enum_type = "RangedWeaponType"
        },
        sources = {
          id = 17,
          type = "enum",
          label = "repeated",
          enum_type = "SourceFilterOption"
        },
        raids = {
          id = 18,
          type = "enum",
          label = "repeated",
          enum_type = "RaidFilterOption"
        },
        faction_restriction = {
          id = 19,
          type = "enum",
          label = "optional",
          enum_type = "FactionRestriction"
        },
        min_ilvl = {
          id = 21,
          type = "int32",
          label = "optional"
        },
        max_ilvl = {
          id = 22,
          type = "int32",
          label = "optional"
        },
        min_mh_weapon_speed = {
          id = 4,
          type = "double",
          label = "optional"
        },
        max_mh_weapon_speed = {
          id = 5,
          type = "double",
          label = "optional"
        },
        min_oh_weapon_speed = {
          id = 9,
          type = "double",
          label = "optional"
        },
        max_oh_weapon_speed = {
          id = 10,
          type = "double",
          label = "optional"
        },
        min_ranged_weapon_speed = {
          id = 14,
          type = "double",
          label = "optional"
        },
        max_ranged_weapon_speed = {
          id = 15,
          type = "double",
          label = "optional"
        },
        one_handed_weapons = {
          id = 6,
          type = "bool",
          label = "optional"
        },
        two_handed_weapons = {
          id = 7,
          type = "bool",
          label = "optional"
        },
        favorite_items = {
          id = 11,
          type = "int32",
          label = "repeated"
        },
        favorite_enchants = {
          id = 13,
          type = "string",
          label = "repeated"
        },
        favorite_random_suffixes = {
          id = 20,
          type = "int32",
          label = "repeated"
        }
      },
      oneofs = {

      },
      field_order = {
        "armor_types",
        "weapon_types",
        "ranged_weapon_types",
        "sources",
        "raids",
        "faction_restriction",
        "min_ilvl",
        "max_ilvl",
        "min_mh_weapon_speed",
        "max_mh_weapon_speed",
        "min_oh_weapon_speed",
        "max_oh_weapon_speed",
        "min_ranged_weapon_speed",
        "max_ranged_weapon_speed",
        "one_handed_weapons",
        "two_handed_weapons",
        "favorite_items",
        "favorite_enchants",
        "favorite_random_suffixes"
      }
    },
    SimSettings = {
      fields = {
        iterations = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        phase = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        fixed_rng_seed = {
          id = 3,
          type = "int64",
          label = "optional"
        },
        show_damage_metrics = {
          id = 8,
          type = "bool",
          label = "optional"
        },
        show_threat_metrics = {
          id = 4,
          type = "bool",
          label = "optional"
        },
        show_healing_metrics = {
          id = 7,
          type = "bool",
          label = "optional"
        },
        show_experimental = {
          id = 5,
          type = "bool",
          label = "optional"
        },
        show_ep_values = {
          id = 11,
          type = "bool",
          label = "optional"
        },
        language = {
          id = 9,
          type = "string",
          label = "optional"
        },
        faction = {
          id = 6,
          type = "enum",
          label = "optional",
          enum_type = "Faction"
        },
        filters = {
          id = 10,
          type = "message",
          label = "optional",
          message_type = "DatabaseFilters"
        }
      },
      oneofs = {

      },
      field_order = {
        "iterations",
        "phase",
        "fixed_rng_seed",
        "show_damage_metrics",
        "show_threat_metrics",
        "show_healing_metrics",
        "show_experimental",
        "show_ep_values",
        "language",
        "faction",
        "filters"
      }
    },
    IndividualSimSettings = {
      fields = {
        settings = {
          id = 5,
          type = "message",
          label = "optional",
          message_type = "SimSettings"
        },
        raid_buffs = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "RaidBuffs"
        },
        debuffs = {
          id = 8,
          type = "message",
          label = "optional",
          message_type = "Debuffs"
        },
        tanks = {
          id = 7,
          type = "message",
          label = "repeated",
          message_type = "UnitReference"
        },
        party_buffs = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "PartyBuffs"
        },
        player = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "Player"
        },
        encounter = {
          id = 4,
          type = "message",
          label = "optional",
          message_type = "Encounter"
        },
        target_dummies = {
          id = 9,
          type = "int32",
          label = "optional"
        },
        ep_weights_stats = {
          id = 10,
          type = "message",
          label = "optional",
          message_type = "UnitStats"
        },
        ep_ratios = {
          id = 11,
          type = "double",
          label = "repeated"
        },
        dps_ref_stat = {
          id = 12,
          type = "enum",
          label = "optional",
          enum_type = "Stat"
        },
        heal_ref_stat = {
          id = 13,
          type = "enum",
          label = "optional",
          enum_type = "Stat"
        },
        tank_ref_stat = {
          id = 14,
          type = "enum",
          label = "optional",
          enum_type = "Stat"
        }
      },
      oneofs = {

      },
      field_order = {
        "settings",
        "raid_buffs",
        "debuffs",
        "tanks",
        "party_buffs",
        "player",
        "encounter",
        "target_dummies",
        "ep_weights_stats",
        "ep_ratios",
        "dps_ref_stat",
        "heal_ref_stat",
        "tank_ref_stat"
      }
    },
    SavedGearSet = {
      fields = {
        gear = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "EquipmentSpec"
        },
        bonus_stats_stats = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "UnitStats"
        }
      },
      oneofs = {

      },
      field_order = {
        "gear",
        "bonus_stats_stats"
      }
    },
    SavedSettings = {
      fields = {
        raid_buffs = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "RaidBuffs"
        },
        party_buffs = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "PartyBuffs"
        },
        debuffs = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "Debuffs"
        },
        player_buffs = {
          id = 4,
          type = "message",
          label = "optional",
          message_type = "IndividualBuffs"
        },
        consumes = {
          id = 5,
          type = "message",
          label = "optional",
          message_type = "Consumes"
        },
        race = {
          id = 6,
          type = "enum",
          label = "optional",
          enum_type = "Race"
        },
        professions = {
          id = 10,
          type = "enum",
          label = "repeated",
          enum_type = "Profession"
        },
        enable_item_swap = {
          id = 18,
          type = "bool",
          label = "optional"
        },
        item_swap = {
          id = 17,
          type = "message",
          label = "optional",
          message_type = "ItemSwap"
        },
        reaction_time_ms = {
          id = 11,
          type = "int32",
          label = "optional"
        },
        channel_clip_delay_ms = {
          id = 12,
          type = "int32",
          label = "optional"
        },
        in_front_of_target = {
          id = 13,
          type = "bool",
          label = "optional"
        },
        distance_from_target = {
          id = 14,
          type = "double",
          label = "optional"
        },
        healing_model = {
          id = 15,
          type = "message",
          label = "optional",
          message_type = "HealingModel",
          _metadata = {
            spell = {
              class = "core",
              label = "Healing Model",
              class_token = "core"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "raid_buffs",
        "party_buffs",
        "debuffs",
        "player_buffs",
        "consumes",
        "race",
        "professions",
        "enable_item_swap",
        "item_swap",
        "reaction_time_ms",
        "channel_clip_delay_ms",
        "in_front_of_target",
        "distance_from_target",
        "healing_model"
      }
    },
    SavedTalents = {
      fields = {
        talents_string = {
          id = 1,
          type = "string",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "talents_string"
      }
    },
    SavedRotation = {
      fields = {
        rotation = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "APLRotation"
        }
      },
      oneofs = {

      },
      field_order = {
        "rotation"
      }
    },
    BlessingsAssignment = {
      fields = {
        blessings = {
          id = 1,
          type = "enum",
          label = "repeated",
          enum_type = "Blessings"
        }
      },
      oneofs = {

      },
      field_order = {
        "blessings"
      }
    },
    BlessingsAssignments = {
      fields = {
        paladins = {
          id = 1,
          type = "message",
          label = "repeated",
          message_type = "BlessingsAssignment"
        }
      },
      oneofs = {

      },
      field_order = {
        "paladins"
      }
    },
    SavedEncounter = {
      fields = {
        encounter = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "Encounter"
        }
      },
      oneofs = {

      },
      field_order = {
        "encounter"
      }
    },
    SavedRaid = {
      fields = {
        raid = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "Raid"
        },
        blessings = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "BlessingsAssignments"
        },
        faction = {
          id = 4,
          type = "enum",
          label = "optional",
          enum_type = "Faction"
        },
        phase = {
          id = 5,
          type = "int32",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "raid",
        "blessings",
        "faction",
        "phase"
      }
    },
    RaidSimSettings = {
      fields = {
        settings = {
          id = 5,
          type = "message",
          label = "optional",
          message_type = "SimSettings"
        },
        raid = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "Raid"
        },
        blessings = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "BlessingsAssignments"
        },
        encounter = {
          id = 4,
          type = "message",
          label = "optional",
          message_type = "Encounter"
        }
      },
      oneofs = {

      },
      field_order = {
        "settings",
        "raid",
        "blessings",
        "encounter"
      }
    },
    SimRun = {
      fields = {
        request = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "RaidSimRequest"
        },
        result = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "RaidSimResult"
        }
      },
      oneofs = {

      },
      field_order = {
        "request",
        "result"
      }
    },
    SimRunData = {
      fields = {
        run = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "SimRun"
        },
        reference_run = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "SimRun"
        }
      },
      oneofs = {

      },
      field_order = {
        "run",
        "reference_run"
      }
    },
    DetailedResultsUpdate = {
      fields = {
        run_data = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "SimRunData"
        },
        settings = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "SimSettings"
        }
      },
      oneofs = {
        data = {
          "run_data",
          "settings"
        }
      },
      field_order = {
        "run_data",
        "settings"
      }
    },
    Player = {
      fields = {
        name = {
          id = 1,
          type = "string",
          label = "optional"
        },
        race = {
          id = 2,
          type = "enum",
          label = "optional",
          enum_type = "Race"
        },
        class = {
          id = 4,
          type = "enum",
          label = "optional",
          enum_type = "Class"
        },
        equipment = {
          id = 5,
          type = "message",
          label = "optional",
          message_type = "EquipmentSpec"
        },
        consumes = {
          id = 6,
          type = "message",
          label = "optional",
          message_type = "Consumes"
        },
        bonus_stats = {
          id = 7,
          type = "message",
          label = "optional",
          message_type = "UnitStats"
        },
        enable_item_swap = {
          id = 40,
          type = "bool",
          label = "optional"
        },
        item_swap = {
          id = 45,
          type = "message",
          label = "optional",
          message_type = "ItemSwap"
        },
        buffs = {
          id = 8,
          type = "message",
          label = "optional",
          message_type = "IndividualBuffs"
        },
        talents_string = {
          id = 9,
          type = "string",
          label = "optional"
        },
        profession1 = {
          id = 10,
          type = "enum",
          label = "optional",
          enum_type = "Profession"
        },
        profession2 = {
          id = 11,
          type = "enum",
          label = "optional",
          enum_type = "Profession"
        },
        cooldowns = {
          id = 12,
          type = "message",
          label = "optional",
          message_type = "Cooldowns"
        },
        rotation = {
          id = 13,
          type = "message",
          label = "optional",
          message_type = "APLRotation"
        },
        reaction_time_ms = {
          id = 14,
          type = "int32",
          label = "optional"
        },
        channel_clip_delay_ms = {
          id = 15,
          type = "int32",
          label = "optional"
        },
        in_front_of_target = {
          id = 16,
          type = "bool",
          label = "optional"
        },
        distance_from_target = {
          id = 17,
          type = "double",
          label = "optional"
        },
        isb_sb_frequency = {
          id = 41,
          type = "double",
          label = "optional"
        },
        isb_crit = {
          id = 42,
          type = "double",
          label = "optional"
        },
        isb_warlocks = {
          id = 43,
          type = "int32",
          label = "optional"
        },
        isb_spriests = {
          id = 44,
          type = "int32",
          label = "optional"
        },
        stormstrike_frequency = {
          id = 47,
          type = "double",
          label = "optional"
        },
        stormstrike_nature_attacker_frequency = {
          id = 48,
          type = "double",
          label = "optional"
        },
        database = {
          id = 18,
          type = "message",
          label = "optional",
          message_type = "SimDatabase"
        },
        healing_model = {
          id = 19,
          type = "message",
          label = "optional",
          message_type = "HealingModel"
        },
        balance_druid = {
          id = 20,
          type = "message",
          label = "optional",
          message_type = "BalanceDruid"
        },
        feral_druid = {
          id = 21,
          type = "message",
          label = "optional",
          message_type = "FeralDruid"
        },
        feral_tank_druid = {
          id = 22,
          type = "message",
          label = "optional",
          message_type = "FeralTankDruid"
        },
        restoration_druid = {
          id = 23,
          type = "message",
          label = "optional",
          message_type = "RestorationDruid"
        },
        hunter = {
          id = 24,
          type = "message",
          label = "optional",
          message_type = "Hunter"
        },
        mage = {
          id = 25,
          type = "message",
          label = "optional",
          message_type = "Mage"
        },
        retribution_paladin = {
          id = 26,
          type = "message",
          label = "optional",
          message_type = "RetributionPaladin"
        },
        protection_paladin = {
          id = 27,
          type = "message",
          label = "optional",
          message_type = "ProtectionPaladin"
        },
        holy_paladin = {
          id = 28,
          type = "message",
          label = "optional",
          message_type = "HolyPaladin"
        },
        healing_priest = {
          id = 29,
          type = "message",
          label = "optional",
          message_type = "HealingPriest"
        },
        shadow_priest = {
          id = 30,
          type = "message",
          label = "optional",
          message_type = "ShadowPriest"
        },
        rogue = {
          id = 32,
          type = "message",
          label = "optional",
          message_type = "Rogue"
        },
        elemental_shaman = {
          id = 33,
          type = "message",
          label = "optional",
          message_type = "ElementalShaman"
        },
        enhancement_shaman = {
          id = 34,
          type = "message",
          label = "optional",
          message_type = "EnhancementShaman"
        },
        restoration_shaman = {
          id = 35,
          type = "message",
          label = "optional",
          message_type = "RestorationShaman"
        },
        warden_shaman = {
          id = 39,
          type = "message",
          label = "optional",
          message_type = "WardenShaman"
        },
        warlock = {
          id = 36,
          type = "message",
          label = "optional",
          message_type = "Warlock"
        },
        warrior = {
          id = 37,
          type = "message",
          label = "optional",
          message_type = "Warrior"
        },
        tank_warrior = {
          id = 38,
          type = "message",
          label = "optional",
          message_type = "TankWarrior"
        }
      },
      oneofs = {
        spec = {
          "balance_druid",
          "feral_druid",
          "feral_tank_druid",
          "restoration_druid",
          "hunter",
          "mage",
          "retribution_paladin",
          "protection_paladin",
          "holy_paladin",
          "healing_priest",
          "shadow_priest",
          "rogue",
          "elemental_shaman",
          "enhancement_shaman",
          "restoration_shaman",
          "warden_shaman",
          "warlock",
          "warrior",
          "tank_warrior"
        }
      },
      field_order = {
        "name",
        "race",
        "class",
        "equipment",
        "consumes",
        "bonus_stats",
        "enable_item_swap",
        "item_swap",
        "buffs",
        "talents_string",
        "profession1",
        "profession2",
        "cooldowns",
        "rotation",
        "reaction_time_ms",
        "channel_clip_delay_ms",
        "in_front_of_target",
        "distance_from_target",
        "isb_sb_frequency",
        "isb_crit",
        "isb_warlocks",
        "isb_spriests",
        "stormstrike_frequency",
        "stormstrike_nature_attacker_frequency",
        "database",
        "healing_model",
        "balance_druid",
        "feral_druid",
        "feral_tank_druid",
        "restoration_druid",
        "hunter",
        "mage",
        "retribution_paladin",
        "protection_paladin",
        "holy_paladin",
        "healing_priest",
        "shadow_priest",
        "rogue",
        "elemental_shaman",
        "enhancement_shaman",
        "restoration_shaman",
        "warden_shaman",
        "warlock",
        "warrior",
        "tank_warrior"
      }
    },
    Party = {
      fields = {
        players = {
          id = 1,
          type = "message",
          label = "repeated",
          message_type = "Player"
        },
        buffs = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "PartyBuffs"
        }
      },
      oneofs = {

      },
      field_order = {
        "players",
        "buffs"
      }
    },
    Raid = {
      fields = {
        parties = {
          id = 1,
          type = "message",
          label = "repeated",
          message_type = "Party"
        },
        num_active_parties = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        buffs = {
          id = 7,
          type = "message",
          label = "optional",
          message_type = "RaidBuffs"
        },
        debuffs = {
          id = 5,
          type = "message",
          label = "optional",
          message_type = "Debuffs"
        },
        tanks = {
          id = 4,
          type = "message",
          label = "repeated",
          message_type = "UnitReference"
        },
        stagger_stormstrikes = {
          id = 3,
          type = "bool",
          label = "optional"
        },
        target_dummies = {
          id = 6,
          type = "int32",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "parties",
        "num_active_parties",
        "buffs",
        "debuffs",
        "tanks",
        "stagger_stormstrikes",
        "target_dummies"
      }
    },
    SimOptions = {
      fields = {
        iterations = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        random_seed = {
          id = 2,
          type = "int64",
          label = "optional"
        },
        debug = {
          id = 3,
          type = "bool",
          label = "optional"
        },
        debug_first_iteration = {
          id = 6,
          type = "bool",
          label = "optional"
        },
        is_test = {
          id = 5,
          type = "bool",
          label = "optional"
        },
        save_all_values = {
          id = 7,
          type = "bool",
          label = "optional"
        },
        interactive = {
          id = 8,
          type = "bool",
          label = "optional"
        },
        use_labeled_rands = {
          id = 9,
          type = "bool",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "iterations",
        "random_seed",
        "debug",
        "debug_first_iteration",
        "is_test",
        "save_all_values",
        "interactive",
        "use_labeled_rands"
      }
    },
    ActionMetrics = {
      fields = {
        id = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ActionID"
        },
        is_melee = {
          id = 2,
          type = "bool",
          label = "optional"
        },
        targets = {
          id = 3,
          type = "message",
          label = "repeated",
          message_type = "TargetedActionMetrics"
        },
        spell_school = {
          id = 4,
          type = "int32",
          label = "optional"
        },
        is_passive = {
          id = 5,
          type = "bool",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "id",
        "is_melee",
        "targets",
        "spell_school",
        "is_passive"
      }
    },
    TargetedActionMetrics = {
      fields = {
        unit_index = {
          id = 12,
          type = "int32",
          label = "optional"
        },
        casts = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        hits = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        resisted_hits = {
          id = 25,
          type = "int32",
          label = "optional"
        },
        crits = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        resisted_crits = {
          id = 26,
          type = "int32",
          label = "optional"
        },
        ticks = {
          id = 21,
          type = "int32",
          label = "optional"
        },
        resisted_ticks = {
          id = 27,
          type = "int32",
          label = "optional"
        },
        crit_ticks = {
          id = 22,
          type = "int32",
          label = "optional"
        },
        resisted_crit_ticks = {
          id = 28,
          type = "int32",
          label = "optional"
        },
        misses = {
          id = 4,
          type = "int32",
          label = "optional"
        },
        dodges = {
          id = 5,
          type = "int32",
          label = "optional"
        },
        parries = {
          id = 6,
          type = "int32",
          label = "optional"
        },
        blocks = {
          id = 7,
          type = "int32",
          label = "optional"
        },
        blocked_crits = {
          id = 33,
          type = "int32",
          label = "optional"
        },
        crushes = {
          id = 35,
          type = "int32",
          label = "optional"
        },
        glances = {
          id = 8,
          type = "int32",
          label = "optional"
        },
        damage = {
          id = 9,
          type = "double",
          label = "optional"
        },
        resisted_damage = {
          id = 29,
          type = "double",
          label = "optional"
        },
        crit_damage = {
          id = 15,
          type = "double",
          label = "optional"
        },
        resisted_crit_damage = {
          id = 30,
          type = "double",
          label = "optional"
        },
        tick_damage = {
          id = 23,
          type = "double",
          label = "optional"
        },
        resisted_tick_damage = {
          id = 31,
          type = "double",
          label = "optional"
        },
        crit_tick_damage = {
          id = 24,
          type = "double",
          label = "optional"
        },
        resisted_crit_tick_damage = {
          id = 32,
          type = "double",
          label = "optional"
        },
        glance_damage = {
          id = 17,
          type = "double",
          label = "optional"
        },
        crush_damage = {
          id = 36,
          type = "double",
          label = "optional"
        },
        block_damage = {
          id = 18,
          type = "double",
          label = "optional"
        },
        blocked_crit_damage = {
          id = 34,
          type = "double",
          label = "optional"
        },
        threat = {
          id = 10,
          type = "double",
          label = "optional"
        },
        healing = {
          id = 11,
          type = "double",
          label = "optional"
        },
        crit_healing = {
          id = 16,
          type = "double",
          label = "optional"
        },
        shielding = {
          id = 13,
          type = "double",
          label = "optional"
        },
        cast_time_ms = {
          id = 14,
          type = "double",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "unit_index",
        "casts",
        "hits",
        "resisted_hits",
        "crits",
        "resisted_crits",
        "ticks",
        "resisted_ticks",
        "crit_ticks",
        "resisted_crit_ticks",
        "misses",
        "dodges",
        "parries",
        "blocks",
        "blocked_crits",
        "crushes",
        "glances",
        "damage",
        "resisted_damage",
        "crit_damage",
        "resisted_crit_damage",
        "tick_damage",
        "resisted_tick_damage",
        "crit_tick_damage",
        "resisted_crit_tick_damage",
        "glance_damage",
        "crush_damage",
        "block_damage",
        "blocked_crit_damage",
        "threat",
        "healing",
        "crit_healing",
        "shielding",
        "cast_time_ms"
      }
    },
    AggregatorData = {
      fields = {
        n = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        sumSq = {
          id = 2,
          type = "double",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "n",
        "sumSq"
      }
    },
    AuraMetrics = {
      fields = {
        id = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ActionID"
        },
        uptime_seconds_avg = {
          id = 2,
          type = "double",
          label = "optional"
        },
        uptime_seconds_stdev = {
          id = 3,
          type = "double",
          label = "optional"
        },
        procs_avg = {
          id = 4,
          type = "double",
          label = "optional"
        },
        aggregator_data = {
          id = 5,
          type = "message",
          label = "optional",
          message_type = "AggregatorData"
        }
      },
      oneofs = {

      },
      field_order = {
        "id",
        "uptime_seconds_avg",
        "uptime_seconds_stdev",
        "procs_avg",
        "aggregator_data"
      }
    },
    ResourceMetrics = {
      fields = {
        id = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ActionID"
        },
        type = {
          id = 2,
          type = "enum",
          label = "optional",
          enum_type = "ResourceType"
        },
        events = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        gain = {
          id = 4,
          type = "double",
          label = "optional"
        },
        actual_gain = {
          id = 5,
          type = "double",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "id",
        "type",
        "events",
        "gain",
        "actual_gain"
      }
    },
    HistEntry = {
      fields = {
        key = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        value = {
          id = 2,
          type = "int32",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "key",
        "value"
      }
    },
    DistributionMetrics = {
      fields = {
        avg = {
          id = 1,
          type = "double",
          label = "optional"
        },
        stdev = {
          id = 2,
          type = "double",
          label = "optional"
        },
        max = {
          id = 3,
          type = "double",
          label = "optional"
        },
        max_seed = {
          id = 5,
          type = "int64",
          label = "optional"
        },
        min = {
          id = 6,
          type = "double",
          label = "optional"
        },
        min_seed = {
          id = 7,
          type = "int64",
          label = "optional"
        },
        hist = {
          id = 4,
          type = "message",
          label = "repeated",
          message_type = "HistEntry"
        },
        all_values = {
          id = 8,
          type = "double",
          label = "repeated"
        },
        aggregator_data = {
          id = 9,
          type = "message",
          label = "optional",
          message_type = "AggregatorData"
        }
      },
      oneofs = {

      },
      field_order = {
        "avg",
        "stdev",
        "max",
        "max_seed",
        "min",
        "min_seed",
        "hist",
        "all_values",
        "aggregator_data"
      }
    },
    UnitMetrics = {
      fields = {
        name = {
          id = 9,
          type = "string",
          label = "optional"
        },
        unit_index = {
          id = 13,
          type = "int32",
          label = "optional"
        },
        dps = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "DistributionMetrics"
        },
        dpasp = {
          id = 16,
          type = "message",
          label = "optional",
          message_type = "DistributionMetrics"
        },
        threat = {
          id = 8,
          type = "message",
          label = "optional",
          message_type = "DistributionMetrics"
        },
        dtps = {
          id = 11,
          type = "message",
          label = "optional",
          message_type = "DistributionMetrics"
        },
        tmi = {
          id = 17,
          type = "message",
          label = "optional",
          message_type = "DistributionMetrics"
        },
        hps = {
          id = 14,
          type = "message",
          label = "optional",
          message_type = "DistributionMetrics"
        },
        tto = {
          id = 15,
          type = "message",
          label = "optional",
          message_type = "DistributionMetrics"
        },
        seconds_oom_avg = {
          id = 3,
          type = "double",
          label = "optional"
        },
        chance_of_death = {
          id = 12,
          type = "double",
          label = "optional"
        },
        actions = {
          id = 5,
          type = "message",
          label = "repeated",
          message_type = "ActionMetrics"
        },
        auras = {
          id = 6,
          type = "message",
          label = "repeated",
          message_type = "AuraMetrics"
        },
        resources = {
          id = 10,
          type = "message",
          label = "repeated",
          message_type = "ResourceMetrics"
        },
        pets = {
          id = 7,
          type = "message",
          label = "repeated",
          message_type = "UnitMetrics"
        }
      },
      oneofs = {

      },
      field_order = {
        "name",
        "unit_index",
        "dps",
        "dpasp",
        "threat",
        "dtps",
        "tmi",
        "hps",
        "tto",
        "seconds_oom_avg",
        "chance_of_death",
        "actions",
        "auras",
        "resources",
        "pets"
      }
    },
    PartyMetrics = {
      fields = {
        dps = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "DistributionMetrics"
        },
        hps = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "DistributionMetrics"
        },
        players = {
          id = 2,
          type = "message",
          label = "repeated",
          message_type = "UnitMetrics"
        }
      },
      oneofs = {

      },
      field_order = {
        "dps",
        "hps",
        "players"
      }
    },
    RaidMetrics = {
      fields = {
        dps = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "DistributionMetrics"
        },
        hps = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "DistributionMetrics"
        },
        parties = {
          id = 2,
          type = "message",
          label = "repeated",
          message_type = "PartyMetrics"
        }
      },
      oneofs = {

      },
      field_order = {
        "dps",
        "hps",
        "parties"
      }
    },
    EncounterMetrics = {
      fields = {
        targets = {
          id = 1,
          type = "message",
          label = "repeated",
          message_type = "UnitMetrics"
        }
      },
      oneofs = {

      },
      field_order = {
        "targets"
      }
    },
    ErrorOutcome = {
      fields = {
        type = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "ErrorOutcomeType"
        },
        message = {
          id = 2,
          type = "string",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "type",
        "message"
      }
    },
    RaidSimRequest = {
      fields = {
        raid = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "Raid"
        },
        encounter = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "Encounter"
        },
        sim_options = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "SimOptions"
        }
      },
      oneofs = {

      },
      field_order = {
        "raid",
        "encounter",
        "sim_options"
      }
    },
    RaidSimResult = {
      fields = {
        raid_metrics = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "RaidMetrics"
        },
        encounter_metrics = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "EncounterMetrics"
        },
        logs = {
          id = 3,
          type = "string",
          label = "optional"
        },
        first_iteration_duration = {
          id = 4,
          type = "double",
          label = "optional"
        },
        avg_iteration_duration = {
          id = 6,
          type = "double",
          label = "optional"
        },
        error = {
          id = 5,
          type = "message",
          label = "optional",
          message_type = "ErrorOutcome"
        },
        iterations_done = {
          id = 7,
          type = "int32",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "raid_metrics",
        "encounter_metrics",
        "logs",
        "first_iteration_duration",
        "avg_iteration_duration",
        "error",
        "iterations_done"
      }
    },
    RaidSimRequestSplitRequest = {
      fields = {
        split_count = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        request = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "RaidSimRequest"
        }
      },
      oneofs = {

      },
      field_order = {
        "split_count",
        "request"
      }
    },
    RaidSimRequestSplitResult = {
      fields = {
        splits_done = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        requests = {
          id = 2,
          type = "message",
          label = "repeated",
          message_type = "RaidSimRequest"
        },
        error_result = {
          id = 3,
          type = "string",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "splits_done",
        "requests",
        "error_result"
      }
    },
    RaidSimResultCombinationRequest = {
      fields = {
        results = {
          id = 1,
          type = "message",
          label = "repeated",
          message_type = "RaidSimResult"
        }
      },
      oneofs = {

      },
      field_order = {
        "results"
      }
    },
    AbortRequest = {
      fields = {
        request_id = {
          id = 1,
          type = "string",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "request_id"
      }
    },
    AbortResponse = {
      fields = {
        request_id = {
          id = 1,
          type = "string",
          label = "optional"
        },
        was_triggered = {
          id = 2,
          type = "bool",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "request_id",
        "was_triggered"
      }
    },
    ComputeStatsRequest = {
      fields = {
        raid = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "Raid"
        },
        encounter = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "Encounter"
        }
      },
      oneofs = {

      },
      field_order = {
        "raid",
        "encounter"
      }
    },
    AuraStats = {
      fields = {
        id = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ActionID"
        },
        max_stacks = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        has_icd = {
          id = 3,
          type = "bool",
          label = "optional"
        },
        has_exclusive_effect = {
          id = 4,
          type = "bool",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "id",
        "max_stacks",
        "has_icd",
        "has_exclusive_effect"
      }
    },
    SpellStats = {
      fields = {
        id = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ActionID"
        },
        is_castable = {
          id = 2,
          type = "bool",
          label = "optional"
        },
        is_channeled = {
          id = 7,
          type = "bool",
          label = "optional"
        },
        is_major_cooldown = {
          id = 3,
          type = "bool",
          label = "optional"
        },
        has_dot = {
          id = 4,
          type = "bool",
          label = "optional"
        },
        has_shield = {
          id = 6,
          type = "bool",
          label = "optional"
        },
        prepull_only = {
          id = 5,
          type = "bool",
          label = "optional"
        },
        encounter_only = {
          id = 8,
          type = "bool",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "id",
        "is_castable",
        "is_channeled",
        "is_major_cooldown",
        "has_dot",
        "has_shield",
        "prepull_only",
        "encounter_only"
      }
    },
    APLActionStats = {
      fields = {
        warnings = {
          id = 1,
          type = "string",
          label = "repeated"
        }
      },
      oneofs = {

      },
      field_order = {
        "warnings"
      },
      _metadata = {
        ui_label = "Action Stats",
        short_description = "Contains validation information for an action in the rotation."
      }
    },
    APLStats = {
      fields = {
        prepull_actions = {
          id = 1,
          type = "message",
          label = "repeated",
          message_type = "APLActionStats"
        },
        priority_list = {
          id = 2,
          type = "message",
          label = "repeated",
          message_type = "APLActionStats"
        }
      },
      oneofs = {

      },
      field_order = {
        "prepull_actions",
        "priority_list"
      }
    },
    UnitMetadata = {
      fields = {
        name = {
          id = 3,
          type = "string",
          label = "optional"
        },
        spells = {
          id = 1,
          type = "message",
          label = "repeated",
          message_type = "SpellStats"
        },
        auras = {
          id = 2,
          type = "message",
          label = "repeated",
          message_type = "AuraStats"
        }
      },
      oneofs = {

      },
      field_order = {
        "name",
        "spells",
        "auras"
      }
    },
    PetStats = {
      fields = {
        metadata = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "UnitMetadata"
        }
      },
      oneofs = {

      },
      field_order = {
        "metadata"
      }
    },
    PlayerStats = {
      fields = {
        base_stats = {
          id = 6,
          type = "message",
          label = "optional",
          message_type = "UnitStats"
        },
        gear_stats = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "UnitStats"
        },
        talents_stats = {
          id = 7,
          type = "message",
          label = "optional",
          message_type = "UnitStats"
        },
        buffs_stats = {
          id = 8,
          type = "message",
          label = "optional",
          message_type = "UnitStats"
        },
        consumes_stats = {
          id = 9,
          type = "message",
          label = "optional",
          message_type = "UnitStats"
        },
        final_stats = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "UnitStats"
        },
        sets = {
          id = 3,
          type = "string",
          label = "repeated"
        },
        buffs = {
          id = 4,
          type = "message",
          label = "optional",
          message_type = "IndividualBuffs"
        },
        metadata = {
          id = 10,
          type = "message",
          label = "optional",
          message_type = "UnitMetadata"
        },
        rotation_stats = {
          id = 12,
          type = "message",
          label = "optional",
          message_type = "APLStats"
        },
        pets = {
          id = 11,
          type = "message",
          label = "repeated",
          message_type = "PetStats"
        }
      },
      oneofs = {

      },
      field_order = {
        "base_stats",
        "gear_stats",
        "talents_stats",
        "buffs_stats",
        "consumes_stats",
        "final_stats",
        "sets",
        "buffs",
        "metadata",
        "rotation_stats",
        "pets"
      }
    },
    PartyStats = {
      fields = {
        players = {
          id = 1,
          type = "message",
          label = "repeated",
          message_type = "PlayerStats"
        }
      },
      oneofs = {

      },
      field_order = {
        "players"
      }
    },
    RaidStats = {
      fields = {
        parties = {
          id = 1,
          type = "message",
          label = "repeated",
          message_type = "PartyStats"
        }
      },
      oneofs = {

      },
      field_order = {
        "parties"
      }
    },
    TargetStats = {
      fields = {
        metadata = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "UnitMetadata"
        }
      },
      oneofs = {

      },
      field_order = {
        "metadata"
      }
    },
    EncounterStats = {
      fields = {
        targets = {
          id = 1,
          type = "message",
          label = "repeated",
          message_type = "TargetStats"
        }
      },
      oneofs = {

      },
      field_order = {
        "targets"
      }
    },
    ComputeStatsResult = {
      fields = {
        raid_stats = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "RaidStats"
        },
        encounter_stats = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "EncounterStats"
        },
        error_result = {
          id = 2,
          type = "string",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "raid_stats",
        "encounter_stats",
        "error_result"
      }
    },
    StatWeightsRequest = {
      fields = {
        player = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "Player"
        },
        raid_buffs = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "RaidBuffs"
        },
        party_buffs = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "PartyBuffs"
        },
        debuffs = {
          id = 9,
          type = "message",
          label = "optional",
          message_type = "Debuffs"
        },
        encounter = {
          id = 4,
          type = "message",
          label = "optional",
          message_type = "Encounter"
        },
        sim_options = {
          id = 5,
          type = "message",
          label = "optional",
          message_type = "SimOptions"
        },
        tanks = {
          id = 8,
          type = "message",
          label = "repeated",
          message_type = "UnitReference"
        },
        stats_to_weigh = {
          id = 6,
          type = "enum",
          label = "repeated",
          enum_type = "Stat"
        },
        pseudo_stats_to_weigh = {
          id = 10,
          type = "enum",
          label = "repeated",
          enum_type = "PseudoStat"
        },
        ep_reference_stat = {
          id = 7,
          type = "enum",
          label = "optional",
          enum_type = "Stat"
        }
      },
      oneofs = {

      },
      field_order = {
        "player",
        "raid_buffs",
        "party_buffs",
        "debuffs",
        "encounter",
        "sim_options",
        "tanks",
        "stats_to_weigh",
        "pseudo_stats_to_weigh",
        "ep_reference_stat"
      }
    },
    StatWeightsStatData = {
      fields = {
        unit_stat = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        mod_low = {
          id = 2,
          type = "double",
          label = "optional"
        },
        mod_high = {
          id = 3,
          type = "double",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "unit_stat",
        "mod_low",
        "mod_high"
      }
    },
    StatWeightsStatRequestData = {
      fields = {
        stat_data = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "StatWeightsStatData"
        },
        request_low = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "RaidSimRequest"
        },
        request_high = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "RaidSimRequest"
        }
      },
      oneofs = {

      },
      field_order = {
        "stat_data",
        "request_low",
        "request_high"
      }
    },
    StatWeightRequestsData = {
      fields = {
        base_request = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "RaidSimRequest"
        },
        ep_reference_stat = {
          id = 2,
          type = "enum",
          label = "optional",
          enum_type = "Stat"
        },
        stat_sim_requests = {
          id = 3,
          type = "message",
          label = "repeated",
          message_type = "StatWeightsStatRequestData"
        }
      },
      oneofs = {

      },
      field_order = {
        "base_request",
        "ep_reference_stat",
        "stat_sim_requests"
      }
    },
    StatWeightsStatResultData = {
      fields = {
        stat_data = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "StatWeightsStatData"
        },
        result_low = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "RaidSimResult"
        },
        result_high = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "RaidSimResult"
        }
      },
      oneofs = {

      },
      field_order = {
        "stat_data",
        "result_low",
        "result_high"
      }
    },
    StatWeightsCalcRequest = {
      fields = {
        base_result = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "RaidSimResult"
        },
        ep_reference_stat = {
          id = 2,
          type = "enum",
          label = "optional",
          enum_type = "Stat"
        },
        stat_sim_results = {
          id = 3,
          type = "message",
          label = "repeated",
          message_type = "StatWeightsStatResultData"
        }
      },
      oneofs = {

      },
      field_order = {
        "base_result",
        "ep_reference_stat",
        "stat_sim_results"
      }
    },
    StatWeightsResult = {
      fields = {
        dps = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "StatWeightValues"
        },
        hps = {
          id = 4,
          type = "message",
          label = "optional",
          message_type = "StatWeightValues"
        },
        tps = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "StatWeightValues"
        },
        dtps = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "StatWeightValues"
        },
        tmi = {
          id = 5,
          type = "message",
          label = "optional",
          message_type = "StatWeightValues"
        },
        p_death = {
          id = 6,
          type = "message",
          label = "optional",
          message_type = "StatWeightValues"
        },
        error = {
          id = 7,
          type = "message",
          label = "optional",
          message_type = "ErrorOutcome"
        }
      },
      oneofs = {

      },
      field_order = {
        "dps",
        "hps",
        "tps",
        "dtps",
        "tmi",
        "p_death",
        "error"
      }
    },
    StatWeightValues = {
      fields = {
        weights = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "UnitStats"
        },
        weights_stdev = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "UnitStats"
        },
        ep_values = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "UnitStats"
        },
        ep_values_stdev = {
          id = 4,
          type = "message",
          label = "optional",
          message_type = "UnitStats"
        }
      },
      oneofs = {

      },
      field_order = {
        "weights",
        "weights_stdev",
        "ep_values",
        "ep_values_stdev"
      }
    },
    AsyncAPIResult = {
      fields = {
        progress_id = {
          id = 1,
          type = "string",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "progress_id"
      }
    },
    ProgressMetrics = {
      fields = {
        completed_iterations = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        total_iterations = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        completed_sims = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        total_sims = {
          id = 4,
          type = "int32",
          label = "optional"
        },
        presim_running = {
          id = 8,
          type = "bool",
          label = "optional"
        },
        dps = {
          id = 5,
          type = "double",
          label = "optional"
        },
        hps = {
          id = 9,
          type = "double",
          label = "optional"
        },
        final_raid_result = {
          id = 6,
          type = "message",
          label = "optional",
          message_type = "RaidSimResult"
        },
        final_weight_result = {
          id = 7,
          type = "message",
          label = "optional",
          message_type = "StatWeightsResult"
        },
        final_bulk_result = {
          id = 10,
          type = "message",
          label = "optional",
          message_type = "BulkSimResult"
        }
      },
      oneofs = {

      },
      field_order = {
        "completed_iterations",
        "total_iterations",
        "completed_sims",
        "total_sims",
        "presim_running",
        "dps",
        "hps",
        "final_raid_result",
        "final_weight_result",
        "final_bulk_result"
      }
    },
    BulkSimRequest = {
      fields = {
        base_settings = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "RaidSimRequest"
        },
        bulk_settings = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "BulkSettings"
        }
      },
      oneofs = {

      },
      field_order = {
        "base_settings",
        "bulk_settings"
      }
    },
    TalentLoadout = {
      fields = {
        talents_string = {
          id = 1,
          type = "string",
          label = "optional"
        },
        name = {
          id = 2,
          type = "string",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "talents_string",
        "name"
      }
    },
    BulkSettings = {
      fields = {
        items = {
          id = 1,
          type = "message",
          label = "repeated",
          message_type = "ItemSpec"
        },
        combinations = {
          id = 2,
          type = "bool",
          label = "optional"
        },
        fast_mode = {
          id = 3,
          type = "bool",
          label = "optional"
        },
        auto_enchant = {
          id = 4,
          type = "bool",
          label = "optional"
        },
        iterations_per_combo = {
          id = 11,
          type = "int32",
          label = "optional"
        },
        sim_talents = {
          id = 12,
          type = "bool",
          label = "optional"
        },
        talents_to_sim = {
          id = 13,
          type = "message",
          label = "repeated",
          message_type = "TalentLoadout"
        }
      },
      oneofs = {

      },
      field_order = {
        "items",
        "combinations",
        "fast_mode",
        "auto_enchant",
        "iterations_per_combo",
        "sim_talents",
        "talents_to_sim"
      }
    },
    BulkSimResult = {
      fields = {
        results = {
          id = 1,
          type = "message",
          label = "repeated",
          message_type = "BulkComboResult"
        },
        equipped_gear_result = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "BulkComboResult"
        },
        error = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "ErrorOutcome"
        }
      },
      oneofs = {

      },
      field_order = {
        "results",
        "equipped_gear_result",
        "error"
      }
    },
    BulkComboResult = {
      fields = {
        items_added = {
          id = 1,
          type = "message",
          label = "repeated",
          message_type = "ItemSpecWithSlot"
        },
        unit_metrics = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "UnitMetrics"
        },
        talent_loadout = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "TalentLoadout"
        }
      },
      oneofs = {

      },
      field_order = {
        "items_added",
        "unit_metrics",
        "talent_loadout"
      }
    },
    ItemSpecWithSlot = {
      fields = {
        item = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "ItemSpec"
        },
        slot = {
          id = 2,
          type = "enum",
          label = "optional",
          enum_type = "ItemSlot"
        }
      },
      oneofs = {

      },
      field_order = {
        "item",
        "slot"
      }
    },
    RogueSpells = {
      fields = {
        sinister_strike = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              label = "Sinister Strike",
              flags = "rogue.builderFlags()",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "[]float64{1, 1.02, 1.04, 1.06}[rogue.Talents.Aggression]",
              threat_multiplier = "1",
              class_token = "rogue"
            }
          }
        },
        slice_and_dice = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              label = "Slice And Dice",
              flags = "SpellFlagAPL",
              class_token = "rogue"
            },
            aura = {
              class = "rogue",
              label = "Slice and Dice",
              duration = {
                raw = "rogue.sliceAndDiceDurations[5]"
              },
              class_token = "rogue"
            }
          }
        },
        backstab = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              label = "Backstab",
              flags = "rogue.builderFlags()",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1.5 * []float64{1, 1.04, 1.08, 1.12, 1.16, 1.2}[rogue.Talents.Opportunity]",
              threat_multiplier = "1",
              class_token = "rogue"
            }
          }
        },
        vanish = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 1856,
              label = "Vanish",
              cooldown = {
                raw = "time.Second * 300-45*rogue.Talents.Elusiveness"
              },
              flags = "SpellFlagAPL",
              spell_school = "2",
              class_token = "rogue"
            },
            aura = {
              class = "rogue",
              spell_id = 457437,
              label = "Vanish",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "rogue"
            }
          }
        },
        feint = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 1966,
              label = "Feint",
              cooldown = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHAuto | ProcMaskMeleeMHSpecial",
              threat_multiplier = "1",
              class_token = "rogue"
            }
          }
        },
        stealth = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "rogue",
              spell_id = 1787,
              label = "Stealth",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "rogue"
            }
          }
        },
        garrote = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              label = "Garrote",
              flags = "SpellFlagBuilder | core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1 + 0.04*float64(rogue.Talents.Opportunity)",
              threat_multiplier = "1",
              class_token = "rogue"
            }
          }
        },
        make_wound_poison = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 13219,
              label = "Make Wound Poison",
              flags = "core.SpellFlagPoison | core.SpellFlagPassiveSpell | SpellFlagRoguePoison",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellDamageProc",
              damage_multiplier = "rogue.getPoisonDamageMultiplier()",
              threat_multiplier = "1",
              class_token = "rogue"
            }
          }
        },
        make_deadly_poison = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              label = "Make Deadly Poison",
              flags = "core.SpellFlagPoison | core.SpellFlagPassiveSpell | SpellFlagRoguePoison",
              class_token = "rogue"
            }
          }
        },
        make_instant_poison = {
          id = 10,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              label = "Make Instant Poison",
              flags = "core.SpellFlagPoison | core.SpellFlagPassiveSpell | SpellFlagRoguePoison",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellDamageProc",
              damage_multiplier = "rogue.getPoisonDamageMultiplier()",
              threat_multiplier = "1",
              class_token = "rogue"
            }
          }
        },
        wound_poison = {
          id = 11,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "rogue",
                spell_id = 13219,
                label = "Wound Poison",
                label_raw = [["WoundPoison-" + strconv.Itoa(int(rogue.Index))]],
                duration = {
                  raw = "time.Second * 15",
                  seconds = 15.0
                },
                class_token = "rogue"
              },
              {
                class = "rogue",
                label = "Wound Poison",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "rogue"
              }
            }
          }
        },
        deadly_poison = {
          id = 12,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              label = "DeadlyPoison",
              flags = "core.SpellFlagPoison | core.SpellFlagPassiveSpell | SpellFlagRoguePoison",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellDamageProc",
              damage_multiplier = "rogue.getPoisonDamageMultiplier()",
              threat_multiplier = "1",
              class_token = "rogue"
            },
            aura = {
              class = "rogue",
              label = "Deadly Poison",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "rogue"
            }
          }
        },
        instant_poison = {
          id = 13,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "rogue",
              label = "Instant Poison",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "rogue"
            }
          }
        },
        init = {
          id = 14,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "rogue",
                label = "Init",
                cooldown = {
                  raw = "time.Minute * 5",
                  seconds = 300.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagOffensiveEquipment",
                proc_mask = "2",
                class_token = "rogue"
              },
              {
                class = "rogue",
                spell_id = 24532,
                label = "Init",
                cooldown = {
                  raw = "time.Second * 180",
                  seconds = 180.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagOffensiveEquipment",
                proc_mask = "2",
                class_token = "rogue"
              }
            }
          }
        },
        venomous_totem = {
          id = 15,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "rogue",
              spell_id = 23726,
              label = "Venomous Totem",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "rogue"
            }
          }
        },
        rupture = {
          id = 16,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              label = "Rupture",
              flags = "rogue.finisherFlags()",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "[]float64{1, 1.1, 1.2, 1.3}[rogue.Talents.SerratedBlades]",
              threat_multiplier = "1",
              class_token = "rogue"
            }
          }
        },
        eviscerate = {
          id = 17,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              label = "Eviscerate",
              flags = "rogue.finisherFlags() | SpellFlagColdBlooded",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1 + []float64{0, 0.05, 0.10, 0.15}[rogue.Talents.ImprovedEviscerate] + []float64{0, 0.02, 0.04, 0.06}[rogue.Talents.Aggression]",
              threat_multiplier = "1",
              class_token = "rogue"
            }
          }
        },
        ambush = {
          id = 18,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              label = "Ambush",
              flags = "rogue.builderFlags()",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "2.5 * []float64{1, 1.04, 1.08, 1.12, 1.16, 1.2}[rogue.Talents.Opportunity]",
              threat_multiplier = "1",
              class_token = "rogue"
            }
          }
        },
        revealed_flaw = {
          id = 19,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "rogue",
              spell_id = 28815,
              label = "Revealed Flaw",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "rogue"
            }
          }
        },
        reduced_threat = {
          id = 20,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "rogue",
              label = "Reduced Threat",
              class_token = "rogue"
            }
          }
        },
        head_rush = {
          id = 21,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "rogue",
              label = "Head Rush",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "rogue"
            }
          }
        },
        deathdealer_eviscerate_bonus = {
          id = 22,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "rogue",
              label = "Deathdealer Eviscerate Bonus",
              class_token = "rogue"
            }
          }
        },
        deathdealer_evasion_bonus = {
          id = 23,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "rogue",
              label = "Deathdealer Evasion Bonus",
              class_token = "rogue"
            }
          }
        },
        emblemsof_veiled_shadows3pc = {
          id = 24,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "rogue",
              label = "Emblems of Veiled Shadows 3pc",
              class_token = "rogue"
            }
          }
        },
        improved_eviscerateand_rupture = {
          id = 25,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "rogue",
              label = "Improved Eviscerate and Rupture",
              class_token = "rogue"
            }
          }
        },
        proc = {
          id = 26,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 23581,
              label = "Proc",
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
              spell_school = "2",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "rogue"
            }
          }
        },
        bloodfang = {
          id = 27,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 23580,
              label = "Bloodfang",
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
              spell_school = "2",
              proc_mask = "2",
              class_token = "rogue"
            }
          }
        },
        clean_escape = {
          id = 28,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "rogue",
              label = "Clean Escape",
              class_token = "rogue"
            }
          }
        },
        improved_vanish = {
          id = 29,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "rogue",
              label = "Improved Vanish",
              class_token = "rogue"
            }
          }
        },
        evasion = {
          id = 30,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 5277,
              label = "Evasion",
              cooldown = {
                raw = "[]time.Duration{time.Minute * 5, time.Minute*5 - time.Second*45, time.Second*5 - time.Second*90}[rogue.Talents.Elusiveness]"
              },
              major_cooldown = {
                type = "core.CooldownTypeSurvival"
              },
              flags = "SpellFlagAPL",
              spell_school = "2",
              class_token = "rogue"
            },
            aura = {
              class = "rogue",
              spell_id = 5277,
              label = "Evasion",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "rogue"
            }
          }
        },
        thistle_tea = {
          id = 31,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              label = "Thistle Tea",
              cooldown = {
                raw = "time.Minute * 5",
                seconds = 300.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              class_token = "rogue"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "sinister_strike",
        "slice_and_dice",
        "backstab",
        "vanish",
        "feint",
        "stealth",
        "garrote",
        "make_wound_poison",
        "make_deadly_poison",
        "make_instant_poison",
        "wound_poison",
        "deadly_poison",
        "instant_poison",
        "init",
        "venomous_totem",
        "rupture",
        "eviscerate",
        "ambush",
        "revealed_flaw",
        "reduced_threat",
        "head_rush",
        "deathdealer_eviscerate_bonus",
        "deathdealer_evasion_bonus",
        "emblemsof_veiled_shadows3pc",
        "improved_eviscerateand_rupture",
        "proc",
        "bloodfang",
        "clean_escape",
        "improved_vanish",
        "evasion",
        "thistle_tea"
      },
      synthetic = true
    },
    DruidSpells = {
      fields = {
        barkskin = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 22812,
              label = "Barkskin",
              cooldown = {
                raw = "time.Second * 60",
                seconds = 60.0
              },
              flags = "SpellFlagAPL",
              class_token = "druid"
            },
            aura = {
              class = "druid",
              spell_id = 22812,
              label = "Barkskin",
              duration = {
                raw = "time.Second * 12",
                seconds = 12.0
              },
              class_token = "druid"
            }
          }
        },
        starfire = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 20303,
              label = "Starfire",
              flags = "SpellFlagOmen | core.SpellFlagAPL | core.SpellFlagResetAttackSwing",
              spell_school = "SpellSchoolArcane",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "druid"
            }
          }
        },
        cat_form = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 768,
              label = "Cat Form",
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
              class_token = "druid"
            },
            aura = {
              class = "druid",
              spell_id = 768,
              label = "Cat Form",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "druid"
            }
          }
        },
        moonfire = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 20303,
              label = "Moonfire",
              flags = "SpellFlagOmen | core.SpellFlagAPL | core.SpellFlagResetAttackSwing",
              spell_school = "SpellSchoolArcane",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "druid"
            }
          }
        },
        hurricane = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              label = "Hurricane",
              label_raw = [["Hurricane" + druid.Label + strconv.Itoa(i+1)]],
              cooldown = {
                raw = "time.Second * 60",
                seconds = 60.0
              },
              flags = "SpellFlagOmen | core.SpellFlagChanneled | core.SpellFlagBinary | core.SpellFlagAPL",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "druid"
            }
          }
        },
        innervate = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 29166,
              label = "Innervate",
              cooldown = {
                raw = "core.InnervateCD"
              },
              class_token = "druid"
            }
          }
        },
        maul = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "druid",
                label = "Maul",
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
                spell_school = "2",
                proc_mask = "ProcMaskMeleeMHSpecial",
                class_token = "druid"
              },
              {
                class = "druid",
                spell_id = 48480,
                label = "Maul",
                flags = "SpellFlagOmen | core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagNoOnCastComplete",
                spell_school = "2",
                proc_mask = "core.ProcMaskMeleeMHSpecial | core.ProcMaskMeleeMHAuto",
                damage_multiplier = "1 + 0.1*float64(druid.Talents.SavageFury)",
                threat_multiplier = "1",
                class_token = "druid"
              }
            },
            aura = {
              class = "druid",
              label = "Maul Queue Aura",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "druid"
            }
          }
        },
        claw = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 9850,
              label = "Claw",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | SpellFlagOmen | SpellFlagBuilder",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              damage_multiplier_additive = "1 + 0.1*float64(druid.Talents.SavageFury)",
              threat_multiplier = "1",
              class_token = "druid"
            }
          }
        },
        rake = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              label = "Rake",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIgnoreResists | core.SpellFlagBinary | core.SpellFlagAPL | SpellFlagOmen | SpellFlagBuilder",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              damage_multiplier_additive = "1 + 0.1*float64(druid.Talents.SavageFury)",
              threat_multiplier = "1",
              class_token = "druid"
            }
          }
        },
        shred = {
          id = 10,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              label = "Shred",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | SpellFlagOmen | SpellFlagBuilder",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "2.25",
              threat_multiplier = "1",
              class_token = "druid"
            }
          }
        },
        frenzied_regeneration = {
          id = 11,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 22842,
              label = "Frenzied Regeneration",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              class_token = "druid"
            },
            aura = {
              class = "druid",
              spell_id = 22842,
              label = "Frenzied Regeneration",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "druid"
            }
          }
        },
        rip = {
          id = 12,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              label = "Rip",
              flags = "SpellFlagOmen | core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagPureDot",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "druid"
            }
          }
        },
        wrath = {
          id = 13,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 20303,
              label = "Wrath",
              flags = "SpellFlagOmen | core.SpellFlagAPL | core.SpellFlagResetAttackSwing",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "druid"
            }
          }
        },
        init = {
          id = 14,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 23724,
              label = "Init",
              cooldown = {
                raw = "time.Minute * 5",
                seconds = 300.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagOffensiveEquipment",
              class_token = "druid"
            }
          }
        },
        metamorphosis_rune = {
          id = 15,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "druid",
              spell_id = 23724,
              label = "Metamorphosis Rune",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "druid"
            }
          }
        },
        tigers_fury = {
          id = 16,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              label = "Tigers Fury",
              cooldown = {
                raw = "time.Second",
                seconds = 1.0
              },
              flags = "SpellFlagAPL",
              class_token = "druid"
            },
            aura = {
              class = "druid",
              label = "Tiger's Fury Aura",
              duration = {
                raw = "6 * time.Second",
                seconds = 6.0
              },
              class_token = "druid"
            }
          }
        },
        swipe_bear = {
          id = 17,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 779,
              label = "Swipe Bear",
              flags = "SpellFlagOmen | core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1 + 0.1*float64(druid.Talents.SavageFury)",
              threat_multiplier = "2.0",
              variants = {
                {
                  rank = 1,
                  required_level = 16,
                  spell_id = 779,
                  base_damage = 18
                },
                {
                  rank = 2,
                  required_level = 24,
                  spell_id = 780,
                  base_damage = 25
                },
                {
                  rank = 3,
                  required_level = 34,
                  spell_id = 769,
                  base_damage = 36
                },
                {
                  rank = 4,
                  required_level = 44,
                  spell_id = 9754,
                  base_damage = 60
                },
                {
                  rank = 5,
                  required_level = 54,
                  spell_id = 9908,
                  base_damage = 83
                }
              },
              class_token = "druid"
            }
          }
        },
        ferocious_bite = {
          id = 18,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              label = "Ferocious Bite",
              flags = "SpellFlagOmen | core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              damage_multiplier_additive = "1 + 0.03*float64(druid.Talents.FeralAggression)",
              threat_multiplier = "1",
              class_token = "druid"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "barkskin",
        "starfire",
        "cat_form",
        "moonfire",
        "hurricane",
        "innervate",
        "maul",
        "claw",
        "rake",
        "shred",
        "frenzied_regeneration",
        "rip",
        "wrath",
        "init",
        "metamorphosis_rune",
        "tigers_fury",
        "swipe_bear",
        "ferocious_bite"
      },
      synthetic = true
    },
    CommonSpells = {
      fields = {
        thorns_arcane_damage = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "common",
                label = "Thorns (Razor Gauntlets)",
                class_token = "common"
              },
              {
                class = "common",
                label = "Thorns (Naglering)",
                class_token = "common"
              },
              {
                class = "common",
                label = "Thorns (Drillborer Disk)",
                class_token = "common"
              }
            },
            spell = {
              {
                class = "common",
                label = "Thorns Arcane Damage",
                flags = "core.SpellFlagBinary | core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
                spell_school = "SpellSchoolArcane",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common"
              },
              {
                class = "common",
                label = "Thorns Arcane Damage",
                flags = "core.SpellFlagBinary | core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
                spell_school = "SpellSchoolArcane",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common"
              },
              {
                class = "common",
                label = "Thorns Arcane Damage",
                flags = "core.SpellFlagBinary | core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
                spell_school = "SpellSchoolArcane",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common"
              }
            }
          }
        },
        armor_shatter_auras = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 16928,
              label = "Armor Shatter",
              duration = {
                raw = "time.Second * 45",
                seconds = 45.0
              },
              class_token = "common"
            }
          }
        },
        puncture_armor = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 17315,
              label = "Puncture Armor",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "common"
            }
          }
        },
        init = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "common",
                label = "Init",
                cooldown = {
                  raw = "time.Minute * 3",
                  seconds = 180.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagOffensiveEquipment",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 18818,
                label = "Init",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
                spell_school = "SpellSchoolFire",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 18817,
                label = "Init",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
                spell_school = "SpellSchoolShadow",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common"
              },
              {
                class = "common",
                label = "Init",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
                spell_school = "SpellSchoolNature",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 7712,
                label = "Init",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
                spell_school = "SpellSchoolFire",
                proc_mask = "ProcMaskMeleeDamageProc",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common"
              },
              {
                class = "common",
                label = "Init",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagOffensiveEquipment",
                class_token = "common"
              },
              {
                class = "common",
                label = "Init",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagOffensiveEquipment",
                class_token = "common"
              },
              {
                class = "common",
                label = "Init",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagOffensiveEquipment",
                class_token = "common"
              },
              {
                class = "common",
                label = "Init",
                cooldown = {
                  raw = "time.Minute",
                  seconds = 60.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagOffensiveEquipment",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 15604,
                label = "Init",
                cooldown = {
                  raw = "time.Minute * 15",
                  seconds = 900.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                proc_mask = "2",
                class_token = "common"
              },
              {
                class = "common",
                label = "Init",
                cooldown = {
                  raw = "time.Minute * 3",
                  seconds = 180.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagOffensiveEquipment",
                spell_school = "2",
                proc_mask = "2",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 26470,
                label = "Init",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell | core.SpellFlagHelpful",
                spell_school = "SpellSchoolNature",
                proc_mask = "ProcMaskSpellHealing",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 29602,
                label = "Init",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagOffensiveEquipment",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 27656,
                label = "Init",
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                spell_school = "SpellSchoolFire",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 23266,
                label = "Init",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
                spell_school = "SpellSchoolFire",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 23686,
                label = "Init",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
                spell_school = "SpellSchoolNature",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 23689,
                label = "Init",
                flags = "SpellFlagNoOnCastComplete",
                spell_school = "SpellSchoolHoly",
                proc_mask = "2",
                class_token = "common"
              },
              {
                class = "common",
                label = "Init",
                cooldown = {
                  raw = "time.Minute * 15",
                  seconds = 900.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagOffensiveEquipment",
                proc_mask = "2",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 16414,
                label = "Init",
                spell_school = "SpellSchoolShadow",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 461686,
                label = "Init",
                spell_school = "SpellSchoolNature",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 21992,
                label = "Init",
                spell_school = "SpellSchoolNature",
                proc_mask = "2",
                threat_multiplier = "1",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 21992,
                label = "Init",
                flags = "SpellFlagIgnoreAttackerModifiers",
                spell_school = "SpellSchoolNature",
                proc_mask = "core.ProcMaskSpellProc | core.ProcMaskSpellDamageProc",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 21919,
                label = "Init",
                spell_school = "2",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 13532,
                label = "Init",
                spell_school = "SpellSchoolNature",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 21142,
                label = "Init",
                spell_school = "SpellSchoolFire",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 461683,
                label = "Init",
                spell_school = "SpellSchoolShadow",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 17315,
                label = "Init",
                spell_school = "2",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 9633,
                label = "Init",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
                spell_school = "2",
                proc_mask = "ProcMaskMeleeMHSpecial",
                damage_multiplier = "1",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 29150,
                label = "Init",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
                spell_school = "SpellSchoolNature",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 463946,
                label = "Init",
                spell_school = "SpellSchoolNature",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 13494,
                label = "Init",
                cooldown = {
                  raw = "time.Second * 30",
                  seconds = 30.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagOffensiveEquipment",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 24388,
                label = "Init",
                spell_school = "2",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 15494,
                label = "Init",
                spell_school = "2",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 461682,
                label = "Init",
                spell_school = "SpellSchoolShadow",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 18797,
                label = "Init",
                spell_school = "2",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 461151,
                label = "Init",
                spell_school = "SpellSchoolFire",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 461152,
                label = "Init",
                spell_school = "SpellSchoolFire",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 29638,
                label = "Init",
                spell_school = "SpellSchoolFire",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 21153,
                label = "Init",
                spell_school = "SpellSchoolShadow",
                proc_mask = "2",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 27860,
                label = "Init",
                spell_school = "SpellSchoolShadow",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 16596,
                label = "Init",
                flags = "core.SpellFlagIgnoreAttackerModifiers | core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
                spell_school = "SpellSchoolFire",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 16598,
                label = "Init",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
                spell_school = "SpellSchoolArcane",
                proc_mask = "2",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 16601,
                label = "Init",
                spell_school = "SpellSchoolArcane",
                proc_mask = "2",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 16600,
                label = "Init",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
                spell_school = "SpellSchoolArcane",
                proc_mask = "2",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 16597,
                label = "Init",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
                spell_school = "SpellSchoolArcane",
                proc_mask = "2",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 17315,
                label = "Init",
                spell_school = "2",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 16928,
                label = "Init",
                spell_school = "2",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 20004,
                label = "Init",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
                spell_school = "SpellSchoolShadow",
                proc_mask = "core.ProcMaskDamageProc",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 13897,
                label = "Init",
                spell_school = "SpellSchoolFire",
                proc_mask = "core.ProcMaskDamageProc",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 6296,
                label = "Init",
                spell_school = "SpellSchoolFire",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common"
              }
            }
          }
        },
        insightofthe_qiraji = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 26481,
              label = "Insight of the Qiraji",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common"
            }
          }
        },
        spell_blasting = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 25906,
              label = "Spell Blasting",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "common"
            }
          }
        },
        restless_strength = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              label = "Restless Strength",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "common"
            }
          }
        },
        unstable_power = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              label = "Unstable Power",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "common"
            }
          }
        },
        fragile_armor = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              label = "Fragile Armor",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "common"
            }
          }
        },
        ascendance = {
          id = 10,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              label = "Ascendance",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "common"
            }
          }
        },
        poison_smolderwebs_eye = {
          id = 11,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "common",
              spell_id = 17330,
              label = "Poison (Smolderweb's Eye)",
              cooldown = {
                raw = "time.Minute * 2",
                seconds = 120.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              flags = "core.SpellFlagPoison | core.SpellFlagPureDot | core.SpellFlagNoOnCastComplete",
              spell_school = "SpellSchoolNature",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "common"
            }
          }
        },
        markofthe_chosen = {
          id = 12,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "common",
                label = "Mark of the Chosen",
                class_token = "common"
              },
              {
                class = "common",
                spell_id = 21970,
                label = "Mark of the Chosen Effect",
                duration_raw = "time.Minute",
                class_token = "common"
              }
            }
          }
        },
        jom_gabbar = {
          id = 13,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 29602,
              label = "Jom Gabbar",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "common"
            }
          }
        },
        handof_justice = {
          id = 14,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              label = "Hand of Justice",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common"
            }
          }
        },
        auraofthe_blue_dragon = {
          id = 15,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 23688,
              label = "Aura of the Blue Dragon",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "common"
            }
          }
        },
        burstof_knowledge = {
          id = 16,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              label = "Burst of Knowledge",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "common"
            }
          }
        },
        fireball_volcanic_hammer = {
          id = 17,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "common",
              spell_id = 18082,
              label = "Fireball (Volcanic Hammer)",
              spell_school = "SpellSchoolFire",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "common"
            }
          }
        },
        poison_venomspitter = {
          id = 18,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "common",
              spell_id = 18203,
              label = "Poison (Venomspitter)",
              flags = "core.SpellFlagPoison | core.SpellFlagPureDot",
              spell_school = "SpellSchoolNature",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "common"
            }
          }
        },
        thunderfury_trigger = {
          id = 19,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              label = "Thunderfury Trigger",
              class_token = "common"
            }
          }
        },
        untamed_fury = {
          id = 20,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 23719,
              label = "Untamed Fury",
              duration = {
                raw = "time.Second * 8",
                seconds = 8.0
              },
              class_token = "common"
            }
          }
        },
        the_jackhammer_haste = {
          id = 21,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 13533,
              label = "The Jackhammer Haste Aura",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "common"
            }
          }
        },
        thunder_clap_antusul = {
          id = 22,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 13532,
              label = "ThunderClap-Antu'sul",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "common"
            }
          }
        },
        curseof_timmy = {
          id = 23,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 17505,
              label = "Curse of Timmy",
              duration = {
                raw = "time.Minute * 1",
                seconds = 60.0
              },
              class_token = "common"
            }
          }
        },
        zeal = {
          id = 24,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 8191,
              label = "Zeal",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "common"
            }
          }
        },
        fireball_sulfuron_hammer = {
          id = 25,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "common",
              spell_id = 21159,
              label = "Fireball (Sulfuron Hammer)",
              spell_school = "SpellSchoolFire",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "common"
            }
          }
        },
        fireball_handof_ragnaros = {
          id = 26,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "common",
              spell_id = 21162,
              label = "Fireball (Hand of Ragnaros)",
              spell_school = "SpellSchoolFire",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "common"
            }
          }
        },
        immolation_handof_ragnaros = {
          id = 27,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 21142,
              label = "Immolation (Hand of Ragnaros)",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common"
            }
          }
        },
        skullforge_brand = {
          id = 28,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "common",
              spell_id = 17484,
              label = "Skullforge Brand",
              flags = "SpellFlagPureDot",
              spell_school = "SpellSchoolShadow",
              proc_mask = "character.GetProcMaskForItem(SkullforgeReaver)",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "common"
            }
          }
        },
        poison_serpent_slicer = {
          id = 29,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "common",
              spell_id = 17511,
              label = "Poison (Serpent Slicer)",
              flags = "core.SpellFlagPoison | core.SpellFlagPureDot",
              spell_school = "SpellSchoolNature",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "common"
            }
          }
        },
        seeping_willow_poison = {
          id = 30,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "common",
              spell_id = 17196,
              label = "Seeping Willow Poison",
              flags = "core.SpellFlagPoison | core.SpellFlagPureDot",
              spell_school = "SpellSchoolNature",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "common"
            }
          }
        },
        seeping_willow = {
          id = 31,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 17196,
              label = "Seeping Willow",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "common"
            }
          }
        },
        unholy = {
          id = 32,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 17625,
              label = "Unholy Aura",
              class_token = "common"
            }
          }
        },
        ravager_bladestorm = {
          id = 33,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 433801,
              label = "Ravager Bladestorm",
              duration = {
                raw = "time.Second * 9",
                seconds = 9.0
              },
              class_token = "common"
            }
          }
        },
        ravager_whirlwind = {
          id = 34,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "common",
              spell_id = 9632,
              label = "Ravager Whirlwind",
              flags = "SpellFlagChanneled",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              class_token = "common"
            }
          }
        },
        enrage12686 = {
          id = 35,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 12686,
              label = "Enrage (12686)",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "common"
            }
          }
        },
        sanctuary = {
          id = 36,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 463105,
              label = "Sanctuary",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "common"
            }
          }
        },
        spell_vulner = {
          id = 37,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 23605,
              label = "Spell Vulnerability",
              duration = {
                raw = "time.Second * 5",
                seconds = 5.0
              },
              class_token = "common"
            }
          }
        },
        haste = {
          id = 38,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 13494,
              label = "Haste",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "common"
            }
          }
        },
        lord_generals_sword = {
          id = 39,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 15602,
              label = "Lord General's Sword",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "common"
            }
          }
        },
        brain_damage = {
          id = 40,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 24388,
              label = "Brain Damage",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "common"
            }
          }
        },
        numbing_pain = {
          id = 41,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "common",
              spell_id = 16528,
              label = "Numbing Pain",
              flags = "core.SpellFlagPoison | core.SpellFlagPureDot",
              spell_school = "SpellSchoolNature",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "common"
            }
          }
        },
        corrosive_poison = {
          id = 42,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "common",
              spell_id = 13526,
              label = "Corrosive Poison",
              flags = "core.SpellFlagPoison | core.SpellFlagPureDot",
              spell_school = "SpellSchoolNature",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "common"
            }
          }
        },
        focus_handof_edwardthe_odd = {
          id = 43,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 18803,
              label = "Focus (Hand of Edward the Odd)",
              duration = {
                raw = "time.Second * 4",
                seconds = 4.0
              },
              class_token = "common"
            }
          }
        },
        rend_hameyas_slayer = {
          id = 44,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "common",
              spell_id = 16406,
              label = "Rend (Hameya's Slayer)",
              flags = "SpellFlagPureDot",
              spell_school = "2",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "common"
            }
          }
        },
        rend_gutwrencher = {
          id = 45,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "common",
              spell_id = 16406,
              label = "Rend (Gutwrencher)",
              flags = "SpellFlagPureDot",
              spell_school = "2",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "common"
            }
          }
        },
        gutgore_ripper = {
          id = 46,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 461682,
              label = "Gutgore Ripper",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "common"
            }
          }
        },
        creeping_mold = {
          id = 47,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "common",
              spell_id = 18289,
              label = "Creeping Mold",
              flags = "core.SpellFlagDisease | core.SpellFlagPureDot",
              spell_school = "SpellSchoolNature",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "common"
            }
          }
        },
        chilled_frostguard = {
          id = 48,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 16927,
              label = "Chilled (Frostguard)",
              duration = {
                raw = "time.Second * 5",
                seconds = 5.0
              },
              class_token = "common"
            }
          }
        },
        weakening_disease = {
          id = 49,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "common",
              spell_id = 18633,
              label = "Weakening Disease",
              flags = "core.SpellFlagPureDot | core.SpellFlagDisease",
              spell_school = "SpellSchoolShadow",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "common"
            }
          }
        },
        frightalon = {
          id = 50,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 19755,
              label = "Frightalon",
              duration = {
                raw = "time.Minute * 1",
                seconds = 60.0
              },
              class_token = "common"
            }
          }
        },
        flame_wrath = {
          id = 51,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 461152,
              label = "Flame Wrath",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "common"
            }
          }
        },
        fireball = {
          id = 52,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "common",
              spell_id = 16413,
              label = "Fireball",
              spell_school = "SpellSchoolFire",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "common"
            }
          }
        },
        fiery_war_axe_fireball = {
          id = 53,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "common",
              spell_id = 18796,
              label = "Fiery War Axe Fireball",
              spell_school = "SpellSchoolFire",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "common"
            }
          }
        },
        fangofthe_crystal_spider = {
          id = 54,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 17331,
              label = "Fang of the Crystal Spider",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "common"
            }
          }
        },
        eskhandars_rage = {
          id = 55,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 22640,
              label = "Eskhandar's Rage",
              duration = {
                raw = "time.Second * 5",
                seconds = 5.0
              },
              class_token = "common"
            }
          }
        },
        eskhandars_rake = {
          id = 56,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "common",
              spell_id = 22639,
              label = "Eskhandar's Rake",
              flags = "SpellFlagPureDot",
              spell_school = "2",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "common"
            }
          }
        },
        empyrean_demolisher_haste = {
          id = 57,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 21165,
              label = "Empyrean Demolisher Haste Aura",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "common"
            }
          }
        },
        corruption_ebon_hiltof_marduk = {
          id = 58,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "common",
              spell_id = 18656,
              label = "Corruption (Ebon Hilt of Marduk)",
              flags = "SpellFlagPureDot",
              spell_school = "SpellSchoolShadow",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "common"
            }
          }
        },
        destiny = {
          id = 59,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 17152,
              label = "Destiny",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "common"
            }
          }
        },
        bonereavers_edge = {
          id = 60,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 21153,
              label = "Bonereaver's Edge",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "common"
            }
          }
        },
        rend_blood_talon = {
          id = 61,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "common",
              spell_id = 13318,
              label = "Rend (Blood Talon)",
              flags = "SpellFlagPureDot",
              spell_school = "2",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "common"
            }
          }
        },
        rend_bloodrazor = {
          id = 62,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "common",
              spell_id = 17504,
              label = "Rend (Bloodrazor)",
              flags = "SpellFlagPureDot",
              spell_school = "2",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "common"
            }
          }
        },
        blaze = {
          id = 63,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "common",
              spell_id = 16898,
              label = "Blaze",
              flags = "SpellFlagPureDot",
              spell_school = "SpellSchoolFire",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "common"
            }
          }
        },
        willof_shahram0 = {
          id = 64,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 16598,
              label = "Will of Shahram (0)",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "common"
            }
          }
        },
        blessingof_shahram = {
          id = 65,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "common",
              spell_id = 16599,
              label = "Blessing of Shahram",
              flags = "core.SpellFlagIgnoreAttackerModifiers | core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
              spell_school = "SpellSchoolArcane",
              proc_mask = "2",
              class_token = "common"
            }
          }
        },
        fistof_shahram = {
          id = 66,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 16601,
              label = "Fist of Shahram",
              duration = {
                raw = "time.Second * 8",
                seconds = 8.0
              },
              class_token = "common"
            }
          }
        },
        mightof_shahram = {
          id = 67,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 16600,
              label = "Might of Shahram",
              duration = {
                raw = "time.Second * 5",
                seconds = 5.0
              },
              class_token = "common"
            }
          }
        },
        curseof_shahram = {
          id = 68,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 16597,
              label = "Curse of Shahram",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "common"
            }
          }
        },
        siphon_health_barovian_family_sword = {
          id = 69,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "common",
              spell_id = 18652,
              label = "Siphon Health (Barovian Family Sword)",
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              flags = "SpellFlagPureDot",
              spell_school = "SpellSchoolShadow",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "common"
            }
          }
        },
        rend_barman_shanker = {
          id = 70,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "common",
              spell_id = 13318,
              label = "Rend (Barman Shanker)",
              flags = "SpellFlagPureDot",
              spell_school = "2",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "common"
            }
          }
        },
        argent_avenger = {
          id = 71,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 17352,
              label = "Argent Avenger",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "common"
            }
          }
        },
        strengthofthe_champion = {
          id = 72,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 16916,
              label = "Strength of the Champion",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "common"
            }
          }
        },
        threat2 = {
          id = 73,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              label = "Threat +2%",
              class_token = "common"
            }
          }
        },
        crusader_enchant = {
          id = 74,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spell_id = 20007,
              label = "Crusader Enchant",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common"
            }
          }
        },
        lifestealing_weapon = {
          id = 75,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              label = "Lifestealing Weapon",
              class_token = "common"
            }
          }
        },
        minor_speed = {
          id = 76,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              label = "Minor Speed",
              class_token = "common"
            }
          }
        },
        fiery_weapon = {
          id = 77,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              label = "Fiery Weapon",
              class_token = "common"
            }
          }
        },
        fiery_blaze = {
          id = 78,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              label = "Fiery Blaze",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "thorns_arcane_damage",
        "armor_shatter_auras",
        "puncture_armor",
        "init",
        "insightofthe_qiraji",
        "spell_blasting",
        "restless_strength",
        "unstable_power",
        "fragile_armor",
        "ascendance",
        "poison_smolderwebs_eye",
        "markofthe_chosen",
        "jom_gabbar",
        "handof_justice",
        "auraofthe_blue_dragon",
        "burstof_knowledge",
        "fireball_volcanic_hammer",
        "poison_venomspitter",
        "thunderfury_trigger",
        "untamed_fury",
        "the_jackhammer_haste",
        "thunder_clap_antusul",
        "curseof_timmy",
        "zeal",
        "fireball_sulfuron_hammer",
        "fireball_handof_ragnaros",
        "immolation_handof_ragnaros",
        "skullforge_brand",
        "poison_serpent_slicer",
        "seeping_willow_poison",
        "seeping_willow",
        "unholy",
        "ravager_bladestorm",
        "ravager_whirlwind",
        "enrage12686",
        "sanctuary",
        "spell_vulner",
        "haste",
        "lord_generals_sword",
        "brain_damage",
        "numbing_pain",
        "corrosive_poison",
        "focus_handof_edwardthe_odd",
        "rend_hameyas_slayer",
        "rend_gutwrencher",
        "gutgore_ripper",
        "creeping_mold",
        "chilled_frostguard",
        "weakening_disease",
        "frightalon",
        "flame_wrath",
        "fireball",
        "fiery_war_axe_fireball",
        "fangofthe_crystal_spider",
        "eskhandars_rage",
        "eskhandars_rake",
        "empyrean_demolisher_haste",
        "corruption_ebon_hiltof_marduk",
        "destiny",
        "bonereavers_edge",
        "rend_blood_talon",
        "rend_bloodrazor",
        "blaze",
        "willof_shahram0",
        "blessingof_shahram",
        "fistof_shahram",
        "mightof_shahram",
        "curseof_shahram",
        "siphon_health_barovian_family_sword",
        "rend_barman_shanker",
        "argent_avenger",
        "strengthofthe_champion",
        "threat2",
        "crusader_enchant",
        "lifestealing_weapon",
        "minor_speed",
        "fiery_weapon",
        "fiery_blaze"
      },
      synthetic = true
    },
    ShamanSpells = {
      fields = {
        new_healing_stream_totem_spell_config = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 5394,
              label = "New Healing Stream Totem Spell Config",
              flags = "core.SpellFlagHelpful | core.SpellFlagNoOnCastComplete | core.SpellFlagNoLogs | core.SpellFlagNoMetrics",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellHealing",
              damage_multiplier = "1",
              threat_multiplier = "1",
              variants = {
                {
                  rank = 1,
                  spell_id = 5394,
                  heal_id = 5672,
                  spell_coefficient = 0.022,
                  mana_cost = 40,
                  required_level = 20
                },
                {
                  rank = 2,
                  spell_id = 6375,
                  heal_id = 6371,
                  spell_coefficient = 0.022,
                  mana_cost = 50,
                  required_level = 30
                },
                {
                  rank = 3,
                  spell_id = 6377,
                  heal_id = 6372,
                  spell_coefficient = 0.022,
                  mana_cost = 60,
                  required_level = 40
                },
                {
                  rank = 4,
                  spell_id = 10462,
                  heal_id = 10460,
                  spell_coefficient = 0.022,
                  mana_cost = 70,
                  required_level = 50
                },
                {
                  rank = 5,
                  spell_id = 10463,
                  heal_id = 10461,
                  spell_coefficient = 0.022,
                  mana_cost = 80,
                  required_level = 60
                }
              },
              class_token = "shaman"
            }
          }
        },
        healing_stream_totem = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              label = "Healing Stream HoT",
              class_token = "shaman"
            }
          }
        },
        new_fire_nova_totem_spell_config = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 1535,
              label = "New Fire Nova Totem Spell Config",
              spell_school = "SpellSchoolFire",
              proc_mask = "2",
              damage_multiplier = "shaman.callOfFlameMultiplier()",
              variants = {
                {
                  rank = 1,
                  spell_id = 1535,
                  base_damage_low = 53,
                  base_damage_high = 62,
                  spell_coefficient = 0.1,
                  mana_cost = 95,
                  required_level = 12
                },
                {
                  rank = 2,
                  spell_id = 8498,
                  base_damage_low = 110,
                  base_damage_high = 124,
                  spell_coefficient = 0.143,
                  mana_cost = 170,
                  required_level = 22
                },
                {
                  rank = 3,
                  spell_id = 8499,
                  base_damage_low = 195,
                  base_damage_high = 219,
                  spell_coefficient = 0.143,
                  mana_cost = 280,
                  required_level = 32
                },
                {
                  rank = 4,
                  spell_id = 11314,
                  base_damage_low = 295,
                  base_damage_high = 331,
                  spell_coefficient = 0.143,
                  mana_cost = 395,
                  required_level = 42
                },
                {
                  rank = 5,
                  spell_id = 11315,
                  base_damage_low = 413,
                  base_damage_high = 459,
                  spell_coefficient = 0.143,
                  mana_cost = 520,
                  required_level = 52
                }
              },
              class_token = "shaman"
            }
          }
        },
        new_magma_totem_spell_config = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 8190,
              label = "New Magma Totem Spell Config",
              spell_school = "SpellSchoolFire",
              proc_mask = "2",
              damage_multiplier = "shaman.callOfFlameMultiplier()",
              variants = {
                {
                  rank = 1,
                  spell_id = 8190,
                  base_damage = 22,
                  spell_coefficient = 0.033,
                  mana_cost = 230,
                  required_level = 26
                },
                {
                  rank = 2,
                  spell_id = 10585,
                  base_damage = 37,
                  spell_coefficient = 0.033,
                  mana_cost = 360,
                  required_level = 36
                },
                {
                  rank = 3,
                  spell_id = 10586,
                  base_damage = 54,
                  spell_coefficient = 0.033,
                  mana_cost = 500,
                  required_level = 46
                },
                {
                  rank = 4,
                  spell_id = 10587,
                  base_damage = 75,
                  spell_coefficient = 0.033,
                  mana_cost = 650,
                  required_level = 56
                }
              },
              class_token = "shaman"
            }
          }
        },
        new_searing_totem_spell_config = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              label = "New Searing Totem Spell Config",
              spell_school = "SpellSchoolFire",
              proc_mask = "2",
              damage_multiplier = "shaman.callOfFlameMultiplier()",
              class_token = "shaman"
            }
          }
        },
        fire_nova_totem = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 20303,
              label = "Fire Nova Totem",
              cooldown = {
                raw = "cooldown"
              },
              flags = "SpellFlagTotem | core.SpellFlagAPL",
              spell_school = "SpellSchoolFire",
              proc_mask = "2",
              class_token = "shaman"
            }
          }
        },
        magma_totem = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 20303,
              label = "Magma Totem",
              flags = "SpellFlagTotem | core.SpellFlagAPL",
              spell_school = "SpellSchoolFire",
              proc_mask = "2",
              class_token = "shaman"
            }
          }
        },
        searing_totem = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              label = "Searing Totem",
              flags = "SpellFlagTotem | core.SpellFlagAPL",
              spell_school = "SpellSchoolFire",
              proc_mask = "2",
              class_token = "shaman"
            }
          }
        },
        shaman_shock_crit_bonus = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "shaman",
                spell_id = 22804,
                label = "Shaman Shock Crit Bonus",
                class_token = "shaman"
              },
              {
                class = "shaman",
                spell_id = 22804,
                label = "Shaman Shock Crit Bonus",
                class_token = "shaman"
              },
              {
                class = "shaman",
                spell_id = 22804,
                label = "Shaman Shock Crit Bonus",
                class_token = "shaman"
              }
            }
          }
        },
        frostbrand_imbue = {
          id = 10,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "shaman",
              label = "Frostbrand Imbue",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "shaman"
            }
          }
        },
        new_frostbrand_imbue = {
          id = 11,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 8033,
              label = "New Frostbrand Imbue",
              spell_school = "SpellSchoolFrost",
              proc_mask = "ProcMaskSpellDamageProc",
              damage_multiplier = "[]float64{1, 1.05, 1.1, 1.15}[shaman.Talents.ElementalWeapons]",
              threat_multiplier = "1",
              variants = {
                {
                  rank = 1,
                  spell_id = 8033,
                  base_damage = 46
                },
                {
                  rank = 2,
                  spell_id = 8038,
                  base_damage = 77
                },
                {
                  rank = 3,
                  spell_id = 10456,
                  base_damage = 94
                },
                {
                  rank = 4,
                  spell_id = 16355,
                  base_damage = 142
                },
                {
                  rank = 5,
                  spell_id = 16356,
                  base_damage = 187
                }
              },
              class_token = "shaman"
            }
          }
        },
        frostbrand_debuff = {
          id = 12,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "shaman",
              spell_id = 8033,
              label = "Frostbrand Attack",
              duration = {
                raw = "time.Second * 8",
                seconds = 8.0
              },
              variants = {
                {
                  rank = 1,
                  spell_id = 8033
                },
                {
                  rank = 2,
                  spell_id = 8038
                },
                {
                  rank = 3,
                  spell_id = 10456
                },
                {
                  rank = 4,
                  spell_id = 16355
                },
                {
                  rank = 5,
                  spell_id = 16356
                }
              },
              class_token = "shaman"
            }
          }
        },
        tremor_totem = {
          id = 13,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 8143,
              label = "Tremor Totem",
              flags = "SpellFlagShaman | SpellFlagTotem | core.SpellFlagAPL",
              class_token = "shaman"
            }
          }
        },
        lightning_shield = {
          id = 14,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "shaman",
              label = "Lightning Shield",
              class_token = "shaman"
            }
          }
        },
        giftofthe_gathering_storm_chain_lightning_bonus = {
          id = 15,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "shaman",
              label = "Gift of the Gathering Storm Chain Lightning Bonus",
              class_token = "shaman"
            }
          }
        },
        stormcallers_wrath = {
          id = 16,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "shaman",
              spell_id = 26121,
              label = "Stormcaller's Wrath",
              duration = {
                raw = "time.Second * 8",
                seconds = 8.0
              },
              class_token = "shaman"
            }
          }
        },
        new_windfury_imbue = {
          id = 17,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              label = "New Windfury Imbue",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
              spell_school = "2",
              proc_mask = "core.ProcMaskMeleeMHSpecial",
              damage_multiplier = "1.0",
              threat_multiplier = "1",
              class_token = "shaman"
            }
          }
        },
        new_flametongue_imbue = {
          id = 18,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "shaman",
                spell_id = 8024,
                label = "New Flametongue Imbue",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
                spell_school = "SpellSchoolFire",
                proc_mask = "ProcMaskSpellDamageProc",
                damage_multiplier = "[]float64{1, 1.05, 1.1, 1.15}[shaman.Talents.ElementalWeapons]",
                threat_multiplier = "1",
                variants = {
                  {
                    rank = 1,
                    spell_id = 8024,
                    max_damage = 18
                  },
                  {
                    rank = 2,
                    spell_id = 8027,
                    max_damage = 26
                  },
                  {
                    rank = 3,
                    spell_id = 8030,
                    max_damage = 42
                  },
                  {
                    rank = 4,
                    spell_id = 16339,
                    max_damage = 57
                  },
                  {
                    rank = 5,
                    spell_id = 16341,
                    max_damage = 85
                  },
                  {
                    rank = 6,
                    spell_id = 16342,
                    max_damage = 112
                  }
                },
                class_token = "shaman"
              },
              {
                class = "shaman",
                spell_id = 8024,
                label = "New Flametongue Imbue",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
                spell_school = "SpellSchoolFire",
                proc_mask = "ProcMaskSpellDamageProc",
                damage_multiplier = "[]float64{1, 1.05, 1.1, 1.15}[shaman.Talents.ElementalWeapons]",
                threat_multiplier = "1",
                variants = {
                  {
                    rank = 1,
                    spell_id = 8024,
                    max_damage = 18
                  },
                  {
                    rank = 2,
                    spell_id = 8027,
                    max_damage = 26
                  },
                  {
                    rank = 3,
                    spell_id = 8030,
                    max_damage = 42
                  },
                  {
                    rank = 4,
                    spell_id = 16339,
                    max_damage = 57
                  },
                  {
                    rank = 5,
                    spell_id = 16341,
                    max_damage = 85
                  },
                  {
                    rank = 6,
                    spell_id = 16342,
                    max_damage = 112
                  }
                },
                class_token = "shaman"
              }
            }
          }
        },
        new_windfury_totem_spell_config = {
          id = 19,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "shaman",
                spell_id = 8512,
                label = "Windfury Trigger Dummy",
                duration = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                variants = {
                  {
                    rank = 1,
                    spell_id = 8512,
                    mana_cost = 115,
                    required_level = 32
                  },
                  {
                    rank = 2,
                    spell_id = 10613,
                    mana_cost = 175,
                    required_level = 42
                  },
                  {
                    rank = 3,
                    spell_id = 10614,
                    mana_cost = 250,
                    required_level = 52
                  }
                },
                class_token = "shaman"
              },
              {
                class = "shaman",
                spell_id = 8512,
                label = "Windfury",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                variants = {
                  {
                    rank = 1,
                    spell_id = 8512,
                    mana_cost = 115,
                    required_level = 32
                  },
                  {
                    rank = 2,
                    spell_id = 10613,
                    mana_cost = 175,
                    required_level = 42
                  },
                  {
                    rank = 3,
                    spell_id = 10614,
                    mana_cost = 250,
                    required_level = 52
                  }
                },
                class_token = "shaman"
              }
            }
          }
        },
        windwall_totem = {
          id = 20,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              label = "Windwall Totem",
              flags = "SpellFlagShaman | SpellFlagTotem | core.SpellFlagAPL",
              class_token = "shaman"
            }
          }
        },
        windfury_totem = {
          id = 21,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              label = "Windfury Trigger Dummy",
              duration = {
                raw = "time.Minute * 2",
                seconds = 120.0
              },
              class_token = "shaman"
            }
          }
        },
        init = {
          id = 22,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "shaman",
                label = "Init",
                cooldown = {
                  raw = "time.Minute * 3",
                  seconds = 180.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS",
                  priority = "core.CooldownPriorityDefault"
                },
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagOffensiveEquipment",
                spell_school = "SpellSchoolNature",
                proc_mask = "2",
                class_token = "shaman"
              },
              {
                class = "shaman",
                label = "Init",
                cooldown = {
                  raw = "time.Minute * 5",
                  seconds = 300.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS",
                  priority = "core.CooldownPriorityDefault"
                },
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagOffensiveEquipment",
                proc_mask = "2",
                class_token = "shaman"
              }
            }
          }
        },
        wushoolays_charmof_spirits = {
          id = 23,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "shaman",
              label = "Wushoolay's Charm of Spirits",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "shaman"
            }
          }
        },
        nature_aligned = {
          id = 24,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "shaman",
              label = "Nature Aligned",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "shaman"
            }
          }
        },
        chain_lightning = {
          id = 25,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              label = "Chain Lightning",
              flags = "SpellFlagShaman | SpellFlagLightning | core.SpellFlagAPL",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "shaman"
            }
          }
        },
        new_lightning_shield = {
          id = 26,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "shaman",
                spell_id = 324,
                label = "New Lightning Shield",
                flags = "core.SpellFlagAPL | SpellFlagShaman | SpellFlagLightning",
                proc_mask = "2",
                variants = {
                  {
                    rank = 1,
                    spell_id = 324,
                    proc_spell_id = 26364,
                    spell_coefficient = 0.147,
                    mana_cost = 45,
                    required_level = 8
                  },
                  {
                    rank = 2,
                    spell_id = 325,
                    proc_spell_id = 26365,
                    spell_coefficient = 0.227,
                    mana_cost = 80,
                    required_level = 16
                  },
                  {
                    rank = 3,
                    spell_id = 905,
                    proc_spell_id = 26366,
                    spell_coefficient = 0.267,
                    mana_cost = 125,
                    required_level = 24
                  },
                  {
                    rank = 4,
                    spell_id = 945,
                    proc_spell_id = 26367,
                    spell_coefficient = 0.267,
                    mana_cost = 180,
                    required_level = 32
                  },
                  {
                    rank = 5,
                    spell_id = 8134,
                    proc_spell_id = 26369,
                    spell_coefficient = 0.267,
                    mana_cost = 240,
                    required_level = 40
                  },
                  {
                    rank = 6,
                    spell_id = 10431,
                    proc_spell_id = 26370,
                    spell_coefficient = 0.267,
                    mana_cost = 305,
                    required_level = 48
                  },
                  {
                    rank = 7,
                    spell_id = 10432,
                    proc_spell_id = 26363,
                    spell_coefficient = 0.267,
                    required_level = 56
                  }
                },
                class_token = "shaman"
              },
              {
                class = "shaman",
                spell_id = 324,
                label = "New Lightning Shield",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell | SpellFlagShaman | SpellFlagLightning",
                spell_school = "SpellSchoolNature",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                variants = {
                  {
                    rank = 1,
                    spell_id = 324,
                    proc_spell_id = 26364,
                    spell_coefficient = 0.147,
                    mana_cost = 45,
                    required_level = 8
                  },
                  {
                    rank = 2,
                    spell_id = 325,
                    proc_spell_id = 26365,
                    spell_coefficient = 0.227,
                    mana_cost = 80,
                    required_level = 16
                  },
                  {
                    rank = 3,
                    spell_id = 905,
                    proc_spell_id = 26366,
                    spell_coefficient = 0.267,
                    mana_cost = 125,
                    required_level = 24
                  },
                  {
                    rank = 4,
                    spell_id = 945,
                    proc_spell_id = 26367,
                    spell_coefficient = 0.267,
                    mana_cost = 180,
                    required_level = 32
                  },
                  {
                    rank = 5,
                    spell_id = 8134,
                    proc_spell_id = 26369,
                    spell_coefficient = 0.267,
                    mana_cost = 240,
                    required_level = 40
                  },
                  {
                    rank = 6,
                    spell_id = 10431,
                    proc_spell_id = 26370,
                    spell_coefficient = 0.267,
                    mana_cost = 305,
                    required_level = 48
                  },
                  {
                    rank = 7,
                    spell_id = 10432,
                    proc_spell_id = 26363,
                    spell_coefficient = 0.267,
                    required_level = 56
                  }
                },
                class_token = "shaman"
              }
            },
            aura = {
              class = "shaman",
              spell_id = 324,
              label = "Lightning Shield",
              duration = {
                raw = "time.Minute * 10",
                seconds = 600.0
              },
              variants = {
                {
                  rank = 1,
                  spell_id = 324,
                  proc_spell_id = 26364,
                  spell_coefficient = 0.147,
                  mana_cost = 45,
                  required_level = 8
                },
                {
                  rank = 2,
                  spell_id = 325,
                  proc_spell_id = 26365,
                  spell_coefficient = 0.227,
                  mana_cost = 80,
                  required_level = 16
                },
                {
                  rank = 3,
                  spell_id = 905,
                  proc_spell_id = 26366,
                  spell_coefficient = 0.267,
                  mana_cost = 125,
                  required_level = 24
                },
                {
                  rank = 4,
                  spell_id = 945,
                  proc_spell_id = 26367,
                  spell_coefficient = 0.267,
                  mana_cost = 180,
                  required_level = 32
                },
                {
                  rank = 5,
                  spell_id = 8134,
                  proc_spell_id = 26369,
                  spell_coefficient = 0.267,
                  mana_cost = 240,
                  required_level = 40
                },
                {
                  rank = 6,
                  spell_id = 10431,
                  proc_spell_id = 26370,
                  spell_coefficient = 0.267,
                  mana_cost = 305,
                  required_level = 48
                },
                {
                  rank = 7,
                  spell_id = 10432,
                  proc_spell_id = 26363,
                  spell_coefficient = 0.267,
                  required_level = 56
                }
              },
              class_token = "shaman"
            }
          }
        },
        earth_shock = {
          id = 27,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              label = "Earth Shock",
              cooldown = {
                raw = "cdDuration"
              },
              flags = "SpellFlagShaman | core.SpellFlagAPL",
              spell_school = "shockTimer",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "shaman"
            }
          }
        },
        frost_shock = {
          id = 28,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              label = "Frost Shock",
              cooldown = {
                raw = "cdDuration"
              },
              flags = "SpellFlagShaman | core.SpellFlagAPL",
              spell_school = "shockTimer",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "shaman"
            }
          }
        },
        rockbiter_imbue = {
          id = 29,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "shaman",
              label = "Rockbiter Imbue",
              duration = {
                raw = "time.Minute * 5",
                seconds = 300.0
              },
              class_token = "shaman"
            }
          }
        },
        lightning_bolt = {
          id = 30,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              label = "Lightning Bolt",
              flags = "SpellFlagShaman | SpellFlagLightning | core.SpellFlagAPL",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "shaman"
            }
          }
        },
        make_flurry_consumption_trigger = {
          id = 31,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "shaman",
              label = "Flurry Consume Trigger",
              class_token = "shaman"
            }
          }
        },
        make_flurry = {
          id = 32,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "shaman",
              label = "Flurry Proc",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "shaman"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "new_healing_stream_totem_spell_config",
        "healing_stream_totem",
        "new_fire_nova_totem_spell_config",
        "new_magma_totem_spell_config",
        "new_searing_totem_spell_config",
        "fire_nova_totem",
        "magma_totem",
        "searing_totem",
        "shaman_shock_crit_bonus",
        "frostbrand_imbue",
        "new_frostbrand_imbue",
        "frostbrand_debuff",
        "tremor_totem",
        "lightning_shield",
        "giftofthe_gathering_storm_chain_lightning_bonus",
        "stormcallers_wrath",
        "new_windfury_imbue",
        "new_flametongue_imbue",
        "new_windfury_totem_spell_config",
        "windwall_totem",
        "windfury_totem",
        "init",
        "wushoolays_charmof_spirits",
        "nature_aligned",
        "chain_lightning",
        "new_lightning_shield",
        "earth_shock",
        "frost_shock",
        "rockbiter_imbue",
        "lightning_bolt",
        "make_flurry_consumption_trigger",
        "make_flurry"
      },
      synthetic = true
    },
    CoreSpells = {
      fields = {
        make_berserking_cooldown = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "core",
                spell_id = 26297,
                label = "Berserking",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 26297,
                label = "Berserking",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 26297,
                label = "Berserking",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 26297,
                label = "Berserking",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 26297,
                label = "Berserking",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 26297,
                label = "Berserking",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 26297,
                label = "Berserking",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 26297,
                label = "Berserking",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 26297,
                label = "Berserking",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 26297,
                label = "Berserking",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 26297,
                label = "Berserking",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 26297,
                label = "Berserking",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "core"
              }
            },
            spell = {
              class = "core",
              spell_id = 26297,
              label = "Make Berserking Cooldown",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              major_cooldown = {
                type = "CooldownTypeDPS"
              },
              class_token = "core"
            }
          }
        },
        race_effects = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "core",
                spell_id = 20594,
                label = "Race Effects",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                major_cooldown = {
                  type = "CooldownTypeDPS"
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 20594,
                label = "Race Effects",
                cooldown = {
                  raw = "time.Minute * 3",
                  seconds = 180.0
                },
                major_cooldown = {
                  type = "CooldownTypeDPS"
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "core"
              }
            },
            aura = {
              class = "core",
              spell_id = 20594,
              label = "Blood Fury",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "core"
            }
          }
        },
        faerie_fire_aura_internal = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "core",
                spell_id = 17392,
                label = "Faerie Fire (Feral)",
                duration = {
                  raw = "time.Second * 40",
                  seconds = 40.0
                },
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 9907,
                label = "Faerie Fire",
                duration = {
                  raw = "time.Second * 40",
                  seconds = 40.0
                },
                class_token = "core"
              }
            }
          }
        },
        bleed_damage = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              spell_id = 409828,
              label = "Mangle",
              duration_raw = "time.Minute",
              class_token = "core"
            }
          }
        },
        thunderfury_as = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              spell_id = 21992,
              label = "Thunderfury",
              duration = {
                raw = "time.Second * 12",
                seconds = 12.0
              },
              class_token = "core"
            }
          }
        },
        external_isb_caster = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              label = "Isb External Proc Aura",
              class_token = "core"
            }
          }
        },
        external_stormstrike_caster = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              label = "Stormstrike External Proc Aura",
              class_token = "core"
            }
          }
        },
        temporary_stats_on_use = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "core",
              label = "Temporary Stats On Use",
              major_cooldown = {
                type = "cdType"
              },
              class_token = "core"
            }
          }
        },
        init_movement = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "core",
              label = "Init Movement",
              flags = "SpellFlagMeleeMetrics",
              class_token = "core"
            },
            aura = {
              class = "core",
              label = "Movement",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "core"
            }
          }
        },
        enable_mana_bar_with_modifier = {
          id = 10,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "core",
              label = "Enable Mana Bar With Modifier",
              class_token = "core"
            }
          }
        },
        store_extra_mh_attack = {
          id = 11,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              spell_id = 21919,
              label = "Extra Attacks (Main Hand)",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "core"
            }
          }
        },
        finalize = {
          id = 12,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "core",
                label = "Finalize",
                class_token = "core"
              },
              {
                class = "core",
                label = "Finalize",
                class_token = "core"
              },
              {
                class = "core",
                label = "Finalize",
                class_token = "core"
              }
            }
          }
        },
        track_chance_of_death = {
          id = 13,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              label = "Chance of Death",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "core"
            }
          }
        },
        enable_rage_bar = {
          id = 14,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "core",
              label = "Enable Rage Bar",
              class_token = "core"
            },
            aura = {
              class = "core",
              label = "RageBar",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "core"
            }
          }
        },
        make_mana_consumable_m = {
          id = 15,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "core",
                label = "Make Mana Consumable M",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Mana Consumable M",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Mana Consumable M",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Mana Consumable M",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Mana Consumable M",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Mana Consumable M",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Mana Consumable M",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "core"
              }
            }
          }
        },
        make_health_consumable_m = {
          id = 16,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "core",
                label = "Make Health Consumable M",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Health Consumable M",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Health Consumable M",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Health Consumable M",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Health Consumable M",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Health Consumable M",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Health Consumable M",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Health Consumable M",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "core"
              }
            }
          }
        },
        make_magic_resistance_potion_m = {
          id = 17,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "core",
              label = "Make Magic Resistance Potion M",
              cooldown = {
                raw = "time.Minute * 2",
                seconds = 120.0
              },
              flags = "SpellFlagNoOnCastComplete",
              class_token = "core"
            }
          }
        },
        make_armor_consumable_m = {
          id = 18,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "core",
                label = "Make Armor Consumable M",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Armor Consumable M",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "core"
              }
            }
          }
        },
        make_rage_consumable_m = {
          id = 19,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "core",
                label = "Make Rage Consumable M",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Rage Consumable M",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Rage Consumable M",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "core"
              }
            }
          }
        },
        new_goblin_land_mine = {
          id = 20,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "core",
              label = "New Goblin Land Mine",
              flags = "SpellFlagCastTimeNoGCD",
              spell_school = "SpellSchoolFire",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "core"
            }
          }
        },
        new_thorium_grenade = {
          id = 21,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "core",
              label = "New Thorium Grenade",
              flags = "SpellFlagCastTimeNoGCD",
              spell_school = "SpellSchoolFire",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "core"
            }
          }
        },
        new_dense_dynamite = {
          id = 22,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "core",
              label = "New Dense Dynamite",
              flags = "SpellFlagCastTimeNoGCD",
              spell_school = "SpellSchoolFire",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "core"
            }
          }
        },
        new_solid_dynamite = {
          id = 23,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "core",
              label = "New Solid Dynamite",
              flags = "SpellFlagCastTimeNoGCD",
              spell_school = "SpellSchoolFire",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "core"
            }
          }
        },
        new_sapper = {
          id = 24,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "core",
              label = "New Sapper",
              cooldown = {
                raw = "time.Minute * 5",
                seconds = 300.0
              },
              flags = "SpellFlagCastTimeNoGCD",
              spell_school = "SpellSchoolFire",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "core"
            }
          }
        },
        shadow_oil = {
          id = 25,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              label = "Shadow Oil",
              class_token = "core"
            },
            spell = {
              class = "core",
              spell_id = 1382,
              label = "Shadow Oil",
              flags = "SpellFlagNoOnCastComplete | SpellFlagPassiveSpell",
              spell_school = "SpellSchoolShadow",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "core"
            }
          }
        },
        frost_oil = {
          id = 26,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              label = "Frost Oil",
              class_token = "core"
            },
            spell = {
              class = "core",
              spell_id = 1191,
              label = "Frost Oil",
              flags = "SpellFlagNoOnCastComplete | SpellFlagPassiveSpell",
              spell_school = "SpellSchoolFrost",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "core"
            }
          }
        },
        new_temporary_stats_aura_wrapped = {
          id = 27,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              label = "New Temporary Stats Aura Wrapped",
              label_raw = "auraLabel",
              duration_raw = "duration",
              class_token = "core"
            }
          }
        },
        make_proc_trigger = {
          id = 28,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              label = "Make Proc Trigger",
              label_raw = "config.Name",
              duration_raw = "config.Duration",
              class_token = "core"
            }
          }
        },
        feral_combat_specialization = {
          id = 29,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              label = "Feral Combat Skill Specialization",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "core"
            }
          }
        },
        thrown_specialization = {
          id = 30,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              label = "Thrown Skill Specialization",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "core"
            }
          }
        },
        crossbow_specialization = {
          id = 31,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              label = "Crossbow Skill Specialization",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "core"
            }
          }
        },
        bow_specialization = {
          id = 32,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              label = "Bow Skill Specialization",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "core"
            }
          }
        },
        gun_specialization = {
          id = 33,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              label = "Gun Skill Specialization",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "core"
            }
          }
        },
        pole_weapon_specialization = {
          id = 34,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              label = "Pole Weapon Skill Specialization",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "core"
            }
          }
        },
        spell_pushback = {
          id = 35,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              label = "Spell Pushback",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "core"
            }
          }
        },
        extra_attack_aura_common = {
          id = 36,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "core",
                label = "Windfury",
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 21919,
                label = "Extra Attacks  (Main Hand)",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "core"
              },
              {
                class = "core",
                label = " Buff",
                duration = {
                  raw = "time.Millisecond * 1500",
                  seconds = 1.5
                },
                class_token = "core"
              }
            }
          }
        },
        external_consecutive_cd_approximation = {
          id = 37,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "core",
                label = "External Consecutive Cd Approximation",
                cooldown = {
                  raw = "time.Second * 12",
                  seconds = 12.0
                },
                major_cooldown = {
                  type = "config.Type",
                  priority = "config.CooldownPriority"
                },
                flags = "SpellFlagNoOnCastComplete | SpellFlagNoMetrics | SpellFlagNoLogs",
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 29166,
                label = "External Consecutive Cd Approximation",
                cooldown = {
                  raw = "time.Second * 20",
                  seconds = 20.0
                },
                major_cooldown = {
                  type = "config.Type",
                  priority = "config.CooldownPriority"
                },
                flags = "SpellFlagNoOnCastComplete | SpellFlagNoMetrics | SpellFlagNoLogs",
                class_token = "core"
              },
              {
                class = "core",
                label = "External Consecutive Cd Approximation",
                cooldown = {
                  raw = "time.Second * 15",
                  seconds = 15.0
                },
                major_cooldown = {
                  type = "config.Type",
                  priority = "config.CooldownPriority"
                },
                flags = "SpellFlagNoOnCastComplete | SpellFlagNoMetrics | SpellFlagNoLogs",
                class_token = "core"
              }
            }
          }
        },
        innervate = {
          id = 38,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              spell_id = 29166,
              label = "Innervate",
              tag = "Innervate",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "core"
            }
          }
        },
        atiesh_mp5 = {
          id = 39,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              spell_id = 28145,
              label = "Atiesh Greatstaff of the Guardian",
              class_token = "core"
            }
          }
        },
        atiesh_healing = {
          id = 40,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              spell_id = 28144,
              label = "Atiesh Greatstaff of the Guardian",
              class_token = "core"
            }
          }
        },
        atiesh_spell_power = {
          id = 41,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              spell_id = 28143,
              label = "Atiesh Greatstaff of the Guardian",
              class_token = "core"
            }
          }
        },
        atiesh_spell_crit = {
          id = 42,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              spell_id = 28142,
              label = "Atiesh Greatstaff of the Guardian",
              class_token = "core"
            }
          }
        },
        sayges_fortunes = {
          id = 43,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              spell_id = 23768,
              label = "Sayge's Dark Fortune of Damage",
              class_token = "core"
            }
          }
        },
        trueshot = {
          id = 44,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              spell_id = 20906,
              label = "Trueshot Aura",
              class_token = "core"
            }
          }
        },
        retribution = {
          id = 45,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              spell_id = 10301,
              label = "Retribution Aura",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "core"
            },
            spell = {
              class = "core",
              spell_id = 10301,
              label = "Retribution",
              flags = "SpellFlagBinary | SpellFlagNoOnCastComplete | SpellFlagPassiveSpell",
              spell_school = "SpellSchoolHoly",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "core"
            }
          }
        },
        new_fake_elemental_shaman = {
          id = 46,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "core",
              spell_id = 42,
              label = "fakedot",
              flags = "2",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1.5",
              threat_multiplier = "1",
              class_token = "core"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "make_berserking_cooldown",
        "race_effects",
        "faerie_fire_aura_internal",
        "bleed_damage",
        "thunderfury_as",
        "external_isb_caster",
        "external_stormstrike_caster",
        "temporary_stats_on_use",
        "init_movement",
        "enable_mana_bar_with_modifier",
        "store_extra_mh_attack",
        "finalize",
        "track_chance_of_death",
        "enable_rage_bar",
        "make_mana_consumable_m",
        "make_health_consumable_m",
        "make_magic_resistance_potion_m",
        "make_armor_consumable_m",
        "make_rage_consumable_m",
        "new_goblin_land_mine",
        "new_thorium_grenade",
        "new_dense_dynamite",
        "new_solid_dynamite",
        "new_sapper",
        "shadow_oil",
        "frost_oil",
        "new_temporary_stats_aura_wrapped",
        "make_proc_trigger",
        "feral_combat_specialization",
        "thrown_specialization",
        "crossbow_specialization",
        "bow_specialization",
        "gun_specialization",
        "pole_weapon_specialization",
        "spell_pushback",
        "extra_attack_aura_common",
        "external_consecutive_cd_approximation",
        "innervate",
        "atiesh_mp5",
        "atiesh_healing",
        "atiesh_spell_power",
        "atiesh_spell_crit",
        "sayges_fortunes",
        "trueshot",
        "retribution",
        "new_fake_elemental_shaman"
      },
      synthetic = true
    },
    HunterSpells = {
      fields = {
        arcane_shot = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 20303,
              label = "Arcane Shot",
              cooldown = {
                raw = "time.Second*6 - time.Millisecond*200*hunter.Talents.ImprovedArcaneShot"
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | SpellFlagShot",
              spell_school = "SpellSchoolArcane",
              proc_mask = "ProcMaskRangedSpecial",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "hunter"
            }
          }
        },
        new_scorpid_poison = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              label = "ScorpidPoison",
              cooldown = {
                raw = "time.Second * 4",
                seconds = 4.0
              },
              flags = "core.SpellFlagPassiveSpell | core.SpellFlagPoison",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "hunter"
            }
          }
        },
        new_screech = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              label = "New Screech",
              flags = "SpellFlagMeleeMetrics",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial | ProcMaskMeleeOHSpecial",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "hunter"
            }
          }
        },
        new_lightning_breath = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              label = "New Lightning Breath",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "hunter"
            }
          }
        },
        new_bite = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              label = "New Bite",
              cooldown = {
                raw = "10 * time.Second",
                seconds = 10.0
              },
              flags = "SpellFlagMeleeMetrics",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "hunter"
            }
          }
        },
        new_claw = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              label = "New Claw",
              flags = "SpellFlagMeleeMetrics",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "hunter"
            }
          }
        },
        wing_clip = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 20303,
              label = "Wing Clip",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagBinary",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "hunter"
            }
          }
        },
        immolation_trap = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 20303,
              label = "Immolation Trap",
              label_raw = [["ImmolationTrap" + hunter.Label + strconv.Itoa(rank)]],
              tag = "ImmolationTrap",
              cooldown = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              flags = "core.SpellFlagAPL | core.SpellFlagPassiveSpell | SpellFlagTrap",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "hunter"
            }
          }
        },
        freezing_trap = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 409510,
              label = "Freezing Trap",
              cooldown = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              flags = "core.SpellFlagAPL | SpellFlagTrap",
              spell_school = "SpellSchoolFrost",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "hunter"
            }
          }
        },
        volley = {
          id = 10,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 20303,
              label = "Volley",
              cooldown = {
                raw = "time.Second * 60",
                seconds = 60.0
              },
              flags = "core.SpellFlagChanneled | core.SpellFlagAPL",
              spell_school = "SpellSchoolArcane",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "hunter"
            }
          }
        },
        cryptstalker_aimedand_multishot_bonus = {
          id = 11,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "hunter",
              label = "Cryptstalker Aimed and Multishot Bonus",
              class_token = "hunter"
            }
          }
        },
        stalkers_ally = {
          id = 12,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "hunter",
              label = "Stalker's Ally",
              class_token = "hunter"
            }
          }
        },
        rapid_fire_duration = {
          id = 13,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "hunter",
              label = "Rapid Fire Duration",
              class_token = "hunter"
            }
          }
        },
        strikers_rapid_bonus = {
          id = 14,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "hunter",
              label = "Striker's Rapid Bonus",
              class_token = "hunter"
            }
          }
        },
        strikers_arcane_shot_bonus = {
          id = 15,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "hunter",
              label = "Striker's Arcane Shot Bonus",
              class_token = "hunter"
            }
          }
        },
        natures_ally = {
          id = 16,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "hunter",
                label = "Nature's Ally",
                class_token = "hunter"
              },
              {
                class = "hunter",
                label = "Nature's Ally",
                class_token = "hunter"
              }
            }
          }
        },
        improved_aspectofthe_hawk = {
          id = 17,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "hunter",
              label = "Improved Aspect of the Hawk",
              class_token = "hunter"
            }
          }
        },
        improved_volleyand_multishot = {
          id = 18,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "hunter",
              label = "Improved Volley and Multishot",
              class_token = "hunter"
            }
          }
        },
        get_aspect_of_the_hawk_spell_config = {
          id = 19,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "hunter",
                spell_id = 6150,
                label = "Get Aspect Of The Hawk Spell Config",
                label_raw = [["Aspect of the Hawk"+strconv.Itoa(rank)]],
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 6150,
                label = "Get Aspect Of The Hawk Spell Config",
                label_raw = [["Aspect of the Hawk"+strconv.Itoa(rank)]],
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "hunter"
              }
            }
          }
        },
        improved_hawk = {
          id = 20,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "hunter",
              spell_id = 6150,
              label = "Quick Shots",
              duration = {
                raw = "time.Second * 12",
                seconds = 12.0
              },
              class_token = "hunter"
            }
          }
        },
        aspect_of_the_hawk = {
          id = 21,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 20303,
              label = "Aspect Of The Hawk",
              flags = "SpellFlagAPL",
              class_token = "hunter"
            }
          }
        },
        explosive_trap = {
          id = 22,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 20303,
              label = "Explosive Trap",
              label_raw = [["ExplosiveTrap" + hunter.Label + strconv.Itoa(rank)]],
              tag = "ExplosiveTrap",
              cooldown = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              flags = "core.SpellFlagAPL | SpellFlagTrap",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "hunter"
            }
          }
        },
        serpent_sting = {
          id = 23,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 20303,
              label = "Serpent Sting",
              label_raw = [["SerpentSting" + hunter.Label + strconv.Itoa(rank)]],
              tag = "SerpentSting",
              flags = "core.SpellFlagAPL | core.SpellFlagPureDot | core.SpellFlagPoison | SpellFlagSting",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskRangedSpecial",
              damage_multiplier = "1 + 0.02*float64(hunter.Talents.ImprovedSerpentSting)",
              threat_multiplier = "1",
              class_token = "hunter"
            }
          }
        },
        raptor_strike = {
          id = 24,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              label = "Raptor Strike",
              cooldown = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              flags = "core.SpellFlagMeleeMetrics | SpellFlagStrike",
              spell_school = "2",
              proc_mask = "core.ProcMaskMeleeMHSpecial | core.ProcMaskMeleeMHAuto",
              class_token = "hunter"
            }
          }
        },
        make_queue_spells_and = {
          id = 25,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              label = "Make Queue Spells And",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              class_token = "hunter"
            },
            aura = {
              class = "hunter",
              label = "Raptor Strike Queued",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "hunter"
            }
          }
        },
        new_raptor_strike_hit = {
          id = 26,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 2973,
              label = "New Raptor Strike Hit",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              variants = {
                {
                  rank = 1,
                  spell_id = 2973,
                  base_damage = 5
                },
                {
                  rank = 2,
                  spell_id = 14260,
                  base_damage = 11
                },
                {
                  rank = 3,
                  spell_id = 14261,
                  base_damage = 21
                },
                {
                  rank = 4,
                  spell_id = 14262,
                  base_damage = 34
                },
                {
                  rank = 5,
                  spell_id = 14263,
                  base_damage = 50
                },
                {
                  rank = 6,
                  spell_id = 14264,
                  base_damage = 80
                },
                {
                  rank = 7,
                  spell_id = 14265,
                  base_damage = 110
                },
                {
                  rank = 8,
                  spell_id = 14266,
                  base_damage = 140
                }
              },
              class_token = "hunter"
            }
          }
        },
        init = {
          id = 27,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "hunter",
                spell_id = 24353,
                label = "Init",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagOffensiveEquipment",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 24352,
                label = "Init",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagOffensiveEquipment",
                class_token = "hunter"
              },
              {
                class = "hunter",
                label = "Init",
                cooldown = {
                  raw = "time.Second * 180",
                  seconds = 180.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagOffensiveEquipment",
                proc_mask = "2",
                class_token = "hunter"
              }
            }
          }
        },
        primal_instinct = {
          id = 28,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "hunter",
              spell_id = 24353,
              label = "Primal Instinct",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "hunter"
            }
          }
        },
        primal_instinct_hunter = {
          id = 29,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "hunter",
              spell_id = 24353,
              label = "Primal Instinct Hunter",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "hunter"
            }
          }
        },
        devilsaur_fury = {
          id = 30,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "hunter",
              spell_id = 24352,
              label = "Devilsaur Fury",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "hunter"
            }
          }
        },
        multi_shot_damage_increase = {
          id = 31,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "hunter",
                label = "Multi-Shot Damage Increase",
                class_token = "hunter"
              },
              {
                class = "hunter",
                label = "Multi-Shot Damage Increase",
                class_token = "hunter"
              },
              {
                class = "hunter",
                label = "Multi-Shot Damage Increase",
                class_token = "hunter"
              },
              {
                class = "hunter",
                label = "Multi-Shot Damage Increase",
                class_token = "hunter"
              }
            }
          }
        },
        arcane_shot_mana_reduction = {
          id = 32,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "hunter",
                label = "Arcane Shot Mana Reduction",
                class_token = "hunter"
              },
              {
                class = "hunter",
                label = "Arcane Shot Mana Reduction",
                class_token = "hunter"
              }
            }
          }
        },
        rapid_fire = {
          id = 33,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 3045,
              label = "Rapid Fire",
              cooldown = {
                raw = "time.Minute * 5",
                seconds = 300.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              class_token = "hunter"
            },
            aura = {
              class = "hunter",
              spell_id = 3045,
              label = "Rapid Fire",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "hunter"
            }
          }
        },
        talents = {
          id = 34,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "hunter",
              label = "Bestial Discipline",
              class_token = "hunter"
            }
          }
        },
        multi_shot = {
          id = 35,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 20303,
              label = "Multi Shot",
              cooldown = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | SpellFlagShot",
              spell_school = "2",
              proc_mask = "ProcMaskRangedSpecial",
              damage_multiplier = "1 + .05*float64(hunter.Talents.Barrage)",
              threat_multiplier = "1",
              class_token = "hunter"
            }
          }
        },
        mongoose_bite = {
          id = 36,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 20303,
              label = "Mongoose Bite",
              cooldown = {
                raw = "time.Second * 5",
                seconds = 5.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial | ProcMaskMeleeOHSpecial",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "hunter"
            },
            aura = {
              class = "hunter",
              spell_id = 5302,
              label = "Defensive State",
              duration = {
                raw = "time.Second * 5",
                seconds = 5.0
              },
              class_token = "hunter"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "arcane_shot",
        "new_scorpid_poison",
        "new_screech",
        "new_lightning_breath",
        "new_bite",
        "new_claw",
        "wing_clip",
        "immolation_trap",
        "freezing_trap",
        "volley",
        "cryptstalker_aimedand_multishot_bonus",
        "stalkers_ally",
        "rapid_fire_duration",
        "strikers_rapid_bonus",
        "strikers_arcane_shot_bonus",
        "natures_ally",
        "improved_aspectofthe_hawk",
        "improved_volleyand_multishot",
        "get_aspect_of_the_hawk_spell_config",
        "improved_hawk",
        "aspect_of_the_hawk",
        "explosive_trap",
        "serpent_sting",
        "raptor_strike",
        "make_queue_spells_and",
        "new_raptor_strike_hit",
        "init",
        "primal_instinct",
        "primal_instinct_hunter",
        "devilsaur_fury",
        "multi_shot_damage_increase",
        "arcane_shot_mana_reduction",
        "rapid_fire",
        "talents",
        "multi_shot",
        "mongoose_bite"
      },
      synthetic = true
    },
    PriestSpells = {
      fields = {
        starshards = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              spell_id = 20303,
              label = "Starshards",
              flags = "flags",
              spell_school = "SpellSchoolArcane",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "priest"
            }
          }
        },
        devouring_plague = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              spell_id = 20303,
              label = "Devouring Plague",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              flags = "SpellFlagPriest | core.SpellFlagAPL | core.SpellFlagDisease | core.SpellFlagPureDot",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "priest"
            }
          }
        },
        init = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              label = "Init",
              cooldown = {
                raw = "time.Minute * 2",
                seconds = 120.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagOffensiveEquipment",
              class_token = "priest"
            }
          }
        },
        cassandras_tome = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "priest",
              label = "Cassandra's Tome",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "priest"
            }
          }
        },
        smite = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              spell_id = 20303,
              label = "Smite",
              flags = "SpellFlagPriest | core.SpellFlagAPL",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "priest"
            }
          }
        },
        mind_blast = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              spell_id = 20303,
              label = "Mind Blast",
              cooldown = {
                raw = "time.Second*8 - time.Millisecond*500*priest.Talents.ImprovedMindBlast"
              },
              flags = "SpellFlagPriest | core.SpellFlagAPL",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "priest"
            }
          }
        },
        holy_fire = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              spell_id = 20303,
              label = "Holy Fire",
              flags = "SpellFlagPriest | core.SpellFlagAPL",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "priest"
            }
          }
        },
        shadow_word_pain = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              spell_id = 20303,
              label = "Shadow Word: Pain",
              flags = "SpellFlagPriest | core.SpellFlagAPL | core.SpellFlagPureDot",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "priest"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "starshards",
        "devouring_plague",
        "init",
        "cassandras_tome",
        "smite",
        "mind_blast",
        "holy_fire",
        "shadow_word_pain"
      },
      synthetic = true
    },
    WarlockSpells = {
      fields = {
        corruption = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 20303,
              label = "Corruption",
              label_raw = [["Corruption-" + warlock.Label + strconv.Itoa(rank)]],
              flags = "core.SpellFlagAPL | core.SpellFlagResetAttackSwing | core.SpellFlagPureDot | WarlockFlagAffliction",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "warlock"
            }
          }
        },
        demon_armor = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warlock",
              label = "Demon Armor",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "warlock"
            }
          }
        },
        drain_soul = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 20303,
              label = "Drain Soul",
              label_raw = [["DrainSoul-" + warlock.Label + strconv.Itoa(rank)]],
              flags = "core.SpellFlagAPL | core.SpellFlagChanneled | core.SpellFlagResetAttackSwing | WarlockFlagAffliction",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "warlock"
            }
          }
        },
        soul_fire = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 20303,
              label = "Soul Fire",
              flags = "core.SpellFlagAPL | core.SpellFlagResetAttackSwing | WarlockFlagDestruction",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "warlock"
            }
          }
        },
        life_tap = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 20303,
              label = "Life Tap",
              flags = "core.SpellFlagAPL | core.SpellFlagResetAttackSwing | core.SpellFlagBinary | WarlockFlagAffliction",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1 + 0.1*float64(warlock.Talents.ImprovedLifeTap)",
              threat_multiplier = "1",
              class_token = "warlock"
            }
          }
        },
        drain_life = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 20303,
              label = "Drain Life",
              label_raw = [["DrainLife-" + warlock.Label + strconv.Itoa(rank)]],
              flags = "core.SpellFlagAPL | core.SpellFlagResetAttackSwing | WarlockFlagAffliction | core.SpellFlagChanneled",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              damage_multiplier_additive = "1",
              threat_multiplier = "1",
              class_token = "warlock"
            }
          }
        },
        get_drain_life_base_config = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              label = "Get Drain Life Base Config",
              flags = "core.SpellFlagPassiveSpell | core.SpellFlagHelpful",
              spell_school = "2",
              proc_mask = "ProcMaskSpellHealing",
              damage_multiplier = "1",
              threat_multiplier = "0",
              class_token = "warlock"
            }
          }
        },
        immolate_cast_time_reduction = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "warlock",
                label = "Immolate Cast Time Reduction",
                class_token = "warlock"
              },
              {
                class = "warlock",
                label = "Immolate Cast Time Reduction",
                class_token = "warlock"
              }
            }
          }
        },
        curse_of_doom = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 603,
              label = "CurseofDoom",
              cooldown = {
                raw = "time.Second * 60",
                seconds = 60.0
              },
              flags = "core.SpellFlagAPL | WarlockFlagAffliction",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1 - 0.1*float64(warlock.Talents.ImprovedDrainSoul)",
              class_token = "warlock"
            }
          }
        },
        curse_of_agony = {
          id = 10,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 20303,
              label = "Curse Of Agony",
              label_raw = [["CurseofAgony-" + warlock.Label + strconv.Itoa(rank)]],
              flags = "core.SpellFlagAPL | core.SpellFlagResetAttackSwing | core.SpellFlagPureDot | WarlockFlagAffliction",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              damage_multiplier_additive = "1",
              threat_multiplier = "1",
              class_token = "warlock"
            }
          }
        },
        immolate = {
          id = 11,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 20303,
              label = "Immolate",
              label_raw = [["Immolate-" + warlock.Label + strconv.Itoa(rank)]],
              flags = "core.SpellFlagAPL | core.SpellFlagResetAttackSwing | core.SpellFlagBinary | WarlockFlagDestruction",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "warlock"
            }
          }
        },
        plagueheart = {
          id = 12,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warlock",
              label = "Plagueheart",
              class_token = "warlock"
            }
          }
        },
        corruption_plagueheart_raiment = {
          id = 13,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warlock",
              label = "Corruption (Plagueheart Raiment)",
              class_token = "warlock"
            }
          }
        },
        doomcaller_reduced_shadow_bolt_cost = {
          id = 14,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warlock",
              label = "Doomcaller Reduced Shadow Bolt Cost",
              class_token = "warlock"
            }
          }
        },
        doomcaller_immolate_bonus = {
          id = 15,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warlock",
              label = "Doomcaller Immolate Bonus",
              class_token = "warlock"
            }
          }
        },
        improved_death_coil_demoniacs_threads = {
          id = 16,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warlock",
              label = "Improved Death Coil (Demoniac's Threads)",
              class_token = "warlock"
            }
          }
        },
        improved_corruption_demoniacs_threads = {
          id = 17,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warlock",
              label = "Improved Corruption (Demoniac's Threads)",
              class_token = "warlock"
            }
          }
        },
        decreased_destruction_threat_nemesis_raiment = {
          id = 18,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warlock",
              label = "Decreased Destruction Threat (Nemesis Raiment)",
              class_token = "warlock"
            }
          }
        },
        shadow_cost_reduction_felheart_raiment = {
          id = 19,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warlock",
              label = "Shadow Cost Reduction (Felheart Raiment)",
              class_token = "warlock"
            }
          }
        },
        shadow_burn = {
          id = 20,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 20303,
              label = "Shadow Burn",
              cooldown = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              flags = "core.SpellFlagAPL | core.SpellFlagResetAttackSwing | core.SpellFlagBinary | WarlockFlagDestruction",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "warlock"
            }
          }
        },
        death_coil = {
          id = 21,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 20303,
              label = "Death Coil",
              cooldown = {
                raw = "time.Minute * 2",
                seconds = 120.0
              },
              flags = "core.SpellFlagAPL | core.SpellFlagResetAttackSwing | core.SpellFlagBinary | WarlockFlagAffliction",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              damage_multiplier_additive = "1",
              threat_multiplier = "1",
              class_token = "warlock"
            }
          }
        },
        get_death_coil_base_config = {
          id = 22,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              label = "Get Death Coil Base Config",
              flags = "core.SpellFlagPassiveSpell | core.SpellFlagHelpful",
              spell_school = "2",
              proc_mask = "ProcMaskSpellHealing",
              damage_multiplier = "1",
              threat_multiplier = "0",
              class_token = "warlock"
            }
          }
        },
        rain_of_fire = {
          id = 23,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 20303,
              label = "Rain Of Fire",
              label_raw = [["RainOfFire-" + warlock.Label + strconv.Itoa(rank)]],
              flags = "flags",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "warlock"
            }
          }
        },
        shadow_bolt = {
          id = 24,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 20303,
              label = "Shadow Bolt",
              flags = "core.SpellFlagAPL | core.SpellFlagResetAttackSwing | WarlockFlagDestruction",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "warlock"
            }
          }
        },
        init = {
          id = 25,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "warlock",
                label = "Init",
                cooldown = {
                  raw = "time.Minute * 5",
                  seconds = 300.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS",
                  priority = "core.CooldownPriorityBloodlust"
                },
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagOffensiveEquipment",
                spell_school = "SpellSchoolShadow",
                class_token = "warlock"
              },
              {
                class = "warlock",
                label = "Init",
                cooldown = {
                  raw = "time.Minute * 3",
                  seconds = 180.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS",
                  priority = "core.CooldownPriorityBloodlust"
                },
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagOffensiveEquipment",
                spell_school = "SpellSchoolFire",
                class_token = "warlock"
              }
            }
          }
        },
        blessingofthe_black_book = {
          id = 26,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warlock",
              label = "Blessing of the Black Book",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "warlock"
            }
          }
        },
        massive_destruction = {
          id = 27,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warlock",
              label = "Massive Destruction",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "warlock"
            }
          }
        },
        summon_demon = {
          id = 28,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "warlock",
                spell_id = 697,
                label = "Summon Demon",
                flags = "SpellFlagAPL",
                spell_school = "SpellSchoolShadow",
                proc_mask = "2",
                class_token = "warlock"
              },
              {
                class = "warlock",
                spell_id = 712,
                label = "Summon Demon",
                flags = "SpellFlagAPL",
                spell_school = "SpellSchoolShadow",
                proc_mask = "2",
                class_token = "warlock"
              },
              {
                class = "warlock",
                spell_id = 688,
                label = "Summon Demon",
                flags = "SpellFlagAPL",
                spell_school = "SpellSchoolShadow",
                proc_mask = "2",
                class_token = "warlock"
              },
              {
                class = "warlock",
                spell_id = 691,
                label = "Summon Demon",
                flags = "SpellFlagAPL",
                spell_school = "SpellSchoolShadow",
                proc_mask = "2",
                class_token = "warlock"
              }
            }
          }
        },
        searing_pain = {
          id = 29,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 20303,
              label = "Searing Pain",
              flags = "core.SpellFlagAPL | core.SpellFlagResetAttackSwing | WarlockFlagDestruction",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "2",
              class_token = "warlock"
            }
          }
        },
        firestone = {
          id = 30,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warlock",
              label = "Firestone Proc",
              class_token = "warlock"
            },
            spell = {
              class = "warlock",
              spell_id = 0,
              label = "Firestone",
              spell_school = "SpellSchoolFire",
              proc_mask = "2",
              damage_multiplier = "1.0 + float64(warlock.Talents.ImprovedFirestone)*0.15",
              damage_multiplier_additive = "1",
              threat_multiplier = "1",
              class_token = "warlock"
            }
          }
        },
        imp_firebolt = {
          id = 31,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              label = "Imp Firebolt",
              cooldown = {
                raw = "time.Millisecond * 200",
                seconds = 0.2
              },
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "warlock"
            }
          }
        },
        succubus_lash_of_pain = {
          id = 32,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              label = "Succubus Lash Of Pain",
              cooldown = {
                raw = "time.Second * (12 - 3*wp.owner.Talents.ImprovedLashOfPain)"
              },
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "wp.AutoAttacks.MHConfig().DamageMultiplier",
              threat_multiplier = "1",
              class_token = "warlock"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "corruption",
        "demon_armor",
        "drain_soul",
        "soul_fire",
        "life_tap",
        "drain_life",
        "get_drain_life_base_config",
        "immolate_cast_time_reduction",
        "curse_of_doom",
        "curse_of_agony",
        "immolate",
        "plagueheart",
        "corruption_plagueheart_raiment",
        "doomcaller_reduced_shadow_bolt_cost",
        "doomcaller_immolate_bonus",
        "improved_death_coil_demoniacs_threads",
        "improved_corruption_demoniacs_threads",
        "decreased_destruction_threat_nemesis_raiment",
        "shadow_cost_reduction_felheart_raiment",
        "shadow_burn",
        "death_coil",
        "get_death_coil_base_config",
        "rain_of_fire",
        "shadow_bolt",
        "init",
        "blessingofthe_black_book",
        "massive_destruction",
        "summon_demon",
        "searing_pain",
        "firestone",
        "imp_firebolt",
        "succubus_lash_of_pain"
      },
      synthetic = true
    },
    PaladinSpells = {
      fields = {
        lay_on_hands = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "paladin",
              label = "Lay On Hands",
              cooldown = {
                raw = "time.Minute * 60-10*paladin.Talents.ImprovedLayOnHands"
              },
              major_cooldown = {
                type = "core.CooldownTypeSurvival",
                priority = "core.CooldownPriorityBloodlust"
              },
              flags = "core.SpellFlagAPL | core.SpellFlagMCD",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskSpellHealing",
              class_token = "paladin"
            }
          }
        },
        judgement_t2_paladin8_p_bonus = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "paladin",
              label = "Judgement - T2 - Paladin - 8P Bonus",
              class_token = "paladin"
            }
          }
        },
        hammer_of_wrath = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "paladin",
              label = "Hammer Of Wrath",
              cooldown = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskRangedSpecial",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "paladin"
            }
          }
        },
        seal_of_the_crusader = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "paladin",
                label = "Seal Of The Crusader",
                flags = "SpellFlagAPL",
                spell_school = "SpellSchoolHoly",
                class_token = "paladin"
              },
              {
                class = "paladin",
                label = "Seal Of The Crusader",
                flags = "SpellFlagMeleeMetrics",
                spell_school = "SpellSchoolHoly",
                proc_mask = "2",
                class_token = "paladin"
              }
            },
            aura = {
              class = "paladin",
              label = "Seal Of The Crusader",
              label_raw = [["Seal of the Crusader" + paladin.Label + strconv.Itoa(i+1)]],
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "paladin"
            }
          }
        },
        righteous_fury = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "paladin",
              label = "Righteous Fury",
              class_token = "paladin"
            }
          }
        },
        holy_wrath = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "paladin",
              label = "Holy Wrath",
              cooldown = {
                raw = "time.Second * 60",
                seconds = 60.0
              },
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1.0",
              threat_multiplier = "1",
              class_token = "paladin"
            }
          }
        },
        exorcism = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "paladin",
              label = "Exorcism",
              cooldown = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagBinary",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "paladin"
            }
          }
        },
        avenging_wrath = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "paladin",
              spell_id = 407788,
              label = "Avenging Wrath",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL | SpellFlag_Forbearance",
              class_token = "paladin"
            },
            aura = {
              class = "paladin",
              spell_id = 407788,
              label = "Avenging Wrath",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "paladin"
            }
          }
        },
        seal_of_righteousness = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "paladin",
                label = "Seal Of Righteousness",
                flags = "SpellFlagAPL",
                spell_school = "SpellSchoolHoly",
                class_token = "paladin"
              },
              {
                class = "paladin",
                label = "Seal Of Righteousness",
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagSuppressEquipProcs",
                spell_school = "SpellSchoolHoly",
                proc_mask = "ProcMaskMeleeMHSpecial",
                damage_multiplier = "paladin.getWeaponSpecializationModifier()",
                threat_multiplier = "1",
                class_token = "paladin"
              },
              {
                class = "paladin",
                label = "Seal Of Righteousness",
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagSuppressWeaponProcs | core.SpellFlagSuppressEquipProcs | core.SpellFlagBinary",
                spell_school = "SpellSchoolHoly",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "paladin"
              }
            },
            aura = {
              class = "paladin",
              label = "Seal Of Righteousness",
              label_raw = [["Seal of Righteousness" + paladin.Label + strconv.Itoa(i+1)]],
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "paladin"
            }
          }
        },
        judgement = {
          id = 10,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "paladin",
              spell_id = 20271,
              label = "Judgement",
              cooldown = {
                raw = "time.Second * (10 - paladin.Talents.ImprovedJudgement)"
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell | core.SpellFlagCastTimeNoGCD",
              spell_school = "SpellSchoolHoly",
              proc_mask = "2",
              class_token = "paladin"
            }
          }
        },
        forbearance = {
          id = 11,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "paladin",
              spell_id = 25771,
              label = "Forbearance",
              duration = {
                raw = "time.Minute * 1",
                seconds = 60.0
              },
              class_token = "paladin"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "lay_on_hands",
        "judgement_t2_paladin8_p_bonus",
        "hammer_of_wrath",
        "seal_of_the_crusader",
        "righteous_fury",
        "holy_wrath",
        "exorcism",
        "avenging_wrath",
        "seal_of_righteousness",
        "judgement",
        "forbearance"
      },
      synthetic = true
    },
    MageSpells = {
      fields = {
        mage_armor = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "mage",
              label = "Mage Armor",
              class_token = "mage"
            }
          }
        },
        frost_ice_armor = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "mage",
              label = "Ice Armor",
              class_token = "mage"
            }
          }
        },
        mana_gem = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              label = "Mana Gem",
              cooldown = {
                raw = "time.Minute * 2",
                seconds = 120.0
              },
              major_cooldown = {
                type = "core.CooldownTypeMana",
                priority = "int32(minMana)"
              },
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
              class_token = "mage"
            }
          }
        },
        not_there = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "mage",
                label = "NotThere",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "mage"
              },
              {
                class = "mage",
                spell_id = 28762,
                label = "Not There",
                duration = {
                  raw = "time.Second * 8",
                  seconds = 8.0
                },
                class_token = "mage"
              }
            }
          }
        },
        elemental_vulner = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "mage",
              spell_id = 28772,
              label = "Elemental Vulnerability",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "mage"
            }
          }
        },
        adaptive_warding = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "mage",
              label = "Adaptive Warding",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "mage"
            }
          }
        },
        arcane_resistance = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "mage",
              spell_id = 28770,
              label = "Arcane Resistance",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "mage"
            }
          }
        },
        shadow_resistance = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "mage",
              spell_id = 28769,
              label = "Shadow Resistance",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "mage"
            }
          }
        },
        nature_resistance = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "mage",
              spell_id = 28768,
              label = "Nature Resistance",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "mage"
            }
          }
        },
        frost_resistance = {
          id = 10,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "mage",
              spell_id = 28766,
              label = "Frost Resistance",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "mage"
            }
          }
        },
        fire_resistance = {
          id = 11,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "mage",
              spell_id = 28765,
              label = "Fire Resistance",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "mage"
            }
          }
        },
        evocation_frostfire_regalia = {
          id = 12,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "mage",
              label = "Evocation (Frostfire Regalia)",
              class_token = "mage"
            }
          }
        },
        enigma_resist_bonus = {
          id = 13,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "mage",
              label = "Enigma Resist Bonus",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "mage"
            }
          }
        },
        enigmas_answer = {
          id = 14,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "mage",
              spell_id = 26129,
              label = "Enigma's Answer",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "mage"
            }
          }
        },
        netherwind_focus_proc = {
          id = 15,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "mage",
              label = "Netherwind Focus - Proc Aura",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "mage"
            }
          }
        },
        netherwind_focus = {
          id = 16,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "mage",
              spell_id = 22008,
              label = "Netherwind Focus",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "mage"
            }
          }
        },
        friendly_nukes = {
          id = 17,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "mage",
              label = "Friendly Nukes",
              class_token = "mage"
            }
          }
        },
        counterspell = {
          id = 18,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 2139,
              label = "Counterspell",
              cooldown = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              flags = "core.SpellFlagAPL | SpellFlagMage | core.SpellFlagCastTimeNoGCD",
              spell_school = "SpellSchoolArcane",
              proc_mask = "ProcMaskSpellDamage",
              class_token = "mage"
            }
          }
        },
        scorch = {
          id = 19,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 20303,
              label = "Scorch",
              flags = "core.SpellFlagAPL | SpellFlagMage",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "mage"
            }
          }
        },
        get_arcane_missiles_tick = {
          id = 20,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 5143,
              label = "Get Arcane Missiles Tick",
              flags = "core.SpellFlagAgentReserved1",
              spell_school = "SpellSchoolArcane",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              variants = {
                {
                  rank = 1,
                  spell_id = 5143,
                  base_tick_damage = 26,
                  spell_coefficient = 0.132
                },
                {
                  rank = 2,
                  spell_id = 5144,
                  base_tick_damage = 38,
                  spell_coefficient = 0.204
                },
                {
                  rank = 3,
                  spell_id = 5145,
                  base_tick_damage = 57,
                  spell_coefficient = 0.24
                },
                {
                  rank = 4,
                  spell_id = 8416,
                  base_tick_damage = 86,
                  spell_coefficient = 0.24
                },
                {
                  rank = 5,
                  spell_id = 8417,
                  base_tick_damage = 115,
                  spell_coefficient = 0.24
                },
                {
                  rank = 6,
                  spell_id = 10211,
                  base_tick_damage = 153,
                  spell_coefficient = 0.24
                },
                {
                  rank = 7,
                  spell_id = 10212,
                  base_tick_damage = 196,
                  spell_coefficient = 0.24
                },
                {
                  rank = 8,
                  spell_id = 25345,
                  base_tick_damage = 230,
                  spell_coefficient = 0.24
                }
              },
              class_token = "mage"
            }
          }
        },
        arcane_missiles = {
          id = 21,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 20303,
              label = "ArcaneMissiles",
              flags = "SpellFlagMage | core.SpellFlagAPL | core.SpellFlagChanneled | core.SpellFlagNoMetrics",
              spell_school = "SpellSchoolArcane",
              proc_mask = "ProcMaskSpellDamage",
              class_token = "mage"
            }
          }
        },
        new_blizzard_spell_config = {
          id = 22,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 10,
              label = "New Blizzard Spell Config",
              flags = "SpellFlagMage | core.SpellFlagNoLogs | SpellFlagChillSpell",
              proc_mask = "ProcMaskSpellProc",
              variants = {
                {
                  rank = 1,
                  spell_id = 10,
                  mana_cost = 320,
                  required_level = 20
                },
                {
                  rank = 2,
                  spell_id = 6141,
                  mana_cost = 520,
                  required_level = 28
                },
                {
                  rank = 3,
                  spell_id = 8427,
                  mana_cost = 720,
                  required_level = 36
                },
                {
                  rank = 4,
                  spell_id = 10185,
                  mana_cost = 935,
                  required_level = 44
                },
                {
                  rank = 5,
                  spell_id = 10186,
                  mana_cost = 1160,
                  required_level = 52
                },
                {
                  rank = 6,
                  spell_id = 10187,
                  mana_cost = 1400,
                  required_level = 60
                }
              },
              class_token = "mage"
            },
            aura = {
              class = "mage",
              spell_id = 10,
              label = "Improved Blizzard",
              duration = {
                raw = "time.Millisecond * 1500",
                seconds = 1.5
              },
              variants = {
                {
                  rank = 1,
                  spell_id = 10,
                  mana_cost = 320,
                  required_level = 20
                },
                {
                  rank = 2,
                  spell_id = 6141,
                  mana_cost = 520,
                  required_level = 28
                },
                {
                  rank = 3,
                  spell_id = 8427,
                  mana_cost = 720,
                  required_level = 36
                },
                {
                  rank = 4,
                  spell_id = 10185,
                  mana_cost = 935,
                  required_level = 44
                },
                {
                  rank = 5,
                  spell_id = 10186,
                  mana_cost = 1160,
                  required_level = 52
                },
                {
                  rank = 6,
                  spell_id = 10187,
                  mana_cost = 1400,
                  required_level = 60
                }
              },
              class_token = "mage"
            }
          }
        },
        blizzard = {
          id = 23,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 20303,
              label = "Blizzard",
              flags = "SpellFlagMage | core.SpellFlagChanneled | core.SpellFlagAPL",
              spell_school = "SpellSchoolFrost",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "mage"
            }
          }
        },
        flamestrike = {
          id = 24,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 20303,
              label = "Flamestrike",
              flags = "SpellFlagMage | core.SpellFlagAPL",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "mage"
            }
          }
        },
        frostbolt = {
          id = 25,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 20303,
              label = "Frostbolt",
              flags = "SpellFlagMage | SpellFlagChillSpell | core.SpellFlagBinary | core.SpellFlagAPL",
              spell_school = "SpellSchoolFrost",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "mage"
            }
          }
        },
        init = {
          id = 26,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "mage",
                label = "Init",
                cooldown = {
                  raw = "time.Minute * 5",
                  seconds = 300.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS",
                  priority = "core.CooldownPriorityBloodlust"
                },
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagOffensiveEquipment",
                class_token = "mage"
              },
              {
                class = "mage",
                label = "Init",
                cooldown = {
                  raw = "time.Minute * 3",
                  seconds = 180.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS",
                  priority = "core.CooldownPriorityBloodlust"
                },
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagOffensiveEquipment",
                spell_school = "SpellSchoolArcane",
                class_token = "mage"
              },
              {
                class = "mage",
                label = "Init",
                cooldown = {
                  raw = "time.Minute * 3",
                  seconds = 180.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS",
                  priority = "core.CooldownPriorityBloodlust"
                },
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagOffensiveEquipment",
                spell_school = "2",
                class_token = "mage"
              }
            }
          }
        },
        mind_quickening = {
          id = 27,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "mage",
              label = "Mind Quickening",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "mage"
            }
          }
        },
        improved_counter = {
          id = 28,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "mage",
              label = "Improved Counterspell",
              class_token = "mage"
            }
          }
        },
        arcane_potency = {
          id = 29,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "mage",
              spell_id = 24544,
              label = "Arcane Potency",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "mage"
            }
          }
        },
        chaos_fire = {
          id = 30,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "mage",
              spell_id = 24389,
              label = "Chaos Fire",
              duration = {
                raw = "time.Minute * 1",
                seconds = 60.0
              },
              class_token = "mage"
            }
          }
        },
        fireball = {
          id = 31,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 20303,
              label = "Fireball",
              flags = "core.SpellFlagAPL | SpellFlagMage",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "mage"
            }
          }
        },
        evocation = {
          id = 32,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 12051,
              label = "Evocation",
              cooldown = {
                raw = "time.Minute * 8",
                seconds = 480.0
              },
              major_cooldown = {
                type = "core.CooldownTypeMana"
              },
              flags = "core.SpellFlagHelpful | core.SpellFlagChanneled | core.SpellFlagAPL",
              class_token = "mage"
            },
            aura = {
              class = "mage",
              spell_id = 12051,
              label = "Evocation Regen",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "mage"
            }
          }
        },
        new_ice_barrier_spell_config = {
          id = 33,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "mage",
              spell_id = 11426,
              label = "Ice Barrier",
              duration_raw = "time.Minute",
              variants = {
                {
                  rank = 1,
                  spell_id = 11426,
                  mana_cost = 305,
                  required_level = 40
                },
                {
                  rank = 2,
                  spell_id = 13031,
                  mana_cost = 360,
                  required_level = 46
                },
                {
                  rank = 3,
                  spell_id = 13032,
                  mana_cost = 420,
                  required_level = 52
                },
                {
                  rank = 4,
                  spell_id = 13033,
                  mana_cost = 480,
                  required_level = 58
                }
              },
              class_token = "mage"
            }
          }
        },
        arcane_explosion = {
          id = 34,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 20303,
              label = "Arcane Explosion",
              flags = "SpellFlagMage | core.SpellFlagAPL",
              spell_school = "SpellSchoolArcane",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "mage"
            }
          }
        },
        fire_blast = {
          id = 35,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 20303,
              label = "Fire Blast",
              cooldown = {
                raw = "cooldown - time.Millisecond*500*mage.Talents.ImprovedFireBlast"
              },
              flags = "flags",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "mage"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "mage_armor",
        "frost_ice_armor",
        "mana_gem",
        "not_there",
        "elemental_vulner",
        "adaptive_warding",
        "arcane_resistance",
        "shadow_resistance",
        "nature_resistance",
        "frost_resistance",
        "fire_resistance",
        "evocation_frostfire_regalia",
        "enigma_resist_bonus",
        "enigmas_answer",
        "netherwind_focus_proc",
        "netherwind_focus",
        "friendly_nukes",
        "counterspell",
        "scorch",
        "get_arcane_missiles_tick",
        "arcane_missiles",
        "new_blizzard_spell_config",
        "blizzard",
        "flamestrike",
        "frostbolt",
        "init",
        "mind_quickening",
        "improved_counter",
        "arcane_potency",
        "chaos_fire",
        "fireball",
        "evocation",
        "new_ice_barrier_spell_config",
        "arcane_explosion",
        "fire_blast"
      },
      synthetic = true
    },
    WarriorSpells = {
      fields = {
        berserker_rage = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 18499,
              label = "Berserker Rage",
              cooldown = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "warrior"
            },
            aura = {
              class = "warrior",
              spell_id = 18499,
              label = "Berserker Rage",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "warrior"
            }
          }
        },
        revenge = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "warrior",
                label = "Revenge Trigger",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "warrior"
              },
              {
                class = "warrior",
                label = "Revenge",
                duration = {
                  raw = "5 * time.Second",
                  seconds = 5.0
                },
                class_token = "warrior"
              }
            }
          }
        },
        hamstring = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 7373,
              label = "Hamstring",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagBinary | SpellFlagOffensive",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              threat_multiplier = "1.25",
              class_token = "warrior"
            }
          }
        },
        shield_wall = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 871,
              label = "Shield Wall",
              cooldown = {
                raw = "time.Minute * 30",
                seconds = 1800.0
              },
              class_token = "warrior"
            },
            aura = {
              class = "warrior",
              spell_id = 871,
              label = "Shield Wall",
              duration = {
                raw = "time.Duration(10+[]float64{0, 3, 5}[warrior.Talents.ImprovedShieldWall]) * time.Second"
              },
              class_token = "warrior"
            }
          }
        },
        bloodrage = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 2687,
              label = "Bloodrage",
              cooldown = {
                raw = "time.Minute",
                seconds = 60.0
              },
              class_token = "warrior"
            },
            aura = {
              class = "warrior",
              spell_id = 2687,
              label = "Bloodrage",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "warrior"
            }
          }
        },
        slam = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 11605,
              label = "Slam",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | SpellFlagOffensive",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "warrior"
            }
          }
        },
        increased_hit_chance = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warrior",
              label = "Increased Hit Chance",
              class_token = "warrior"
            }
          }
        },
        conqueror_shout_bonus = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warrior",
              label = "Conqueror Shout Bonus",
              class_token = "warrior"
            }
          }
        },
        improved_whirlwind = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warrior",
              label = "Improved Whirlwind",
              class_token = "warrior"
            }
          }
        },
        parry_trigger = {
          id = 10,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warrior",
              label = "Parry Trigger Aura",
              class_token = "warrior"
            }
          }
        },
        warriors_wrath_trigger = {
          id = 11,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warrior",
              label = "Warrior's Wrath Trigger",
              class_token = "warrior"
            }
          }
        },
        warriors_wrath = {
          id = 12,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warrior",
              spell_id = 21887,
              label = "Warrior's Wrath",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "warrior"
            }
          }
        },
        enhanced_sunder_armor = {
          id = 13,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warrior",
              label = "Enhanced Sunder Armor",
              class_token = "warrior"
            }
          }
        },
        shield_block = {
          id = 14,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 2565,
              label = "Shield Block",
              cooldown = {
                raw = "time.Second * 5",
                seconds = 5.0
              },
              spell_school = "2",
              class_token = "warrior"
            },
            aura = {
              class = "warrior",
              spell_id = 2565,
              label = "Shield Block",
              duration = {
                raw = "time.Second * time.Duration(5+[]float64{0, 0.5, 1, 2}[warrior.Talents.ImprovedShieldBlock])"
              },
              class_token = "warrior"
            }
          }
        },
        rend = {
          id = 15,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              label = "Rend",
              tag = "Rend",
              flags = "core.SpellFlagAPL | core.SpellFlagNoOnCastComplete | SpellFlagOffensive",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "[]float64{1, 1.15, 1.25, 1.35}[warrior.Talents.ImprovedRend]",
              threat_multiplier = "1",
              class_token = "warrior"
            }
          }
        },
        recklessness = {
          id = 16,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 1719,
              label = "Recklessness",
              cooldown = {
                raw = "time.Minute * 30",
                seconds = 1800.0
              },
              class_token = "warrior"
            },
            aura = {
              class = "warrior",
              spell_id = 1719,
              label = "Recklessness",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "warrior"
            }
          }
        },
        new_shout_spell_config = {
          id = 17,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              label = "New Shout Spell Config",
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL | core.SpellFlagHelpful",
              class_token = "warrior"
            }
          }
        },
        overpower = {
          id = 18,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "warrior",
                spell_id = 11585,
                label = "Overpower Aura",
                duration = {
                  raw = "time.Second * 5",
                  seconds = 5.0
                },
                class_token = "warrior"
              },
              {
                class = "warrior",
                label = "Overpower Trigger",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "warrior"
              }
            }
          }
        },
        hamstring_rage_reduction = {
          id = 19,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "warrior",
                label = "Hamstring Rage Reduction",
                class_token = "warrior"
              },
              {
                class = "warrior",
                label = "Hamstring Rage Reduction",
                class_token = "warrior"
              }
            }
          }
        },
        init = {
          id = 20,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "warrior",
                label = "Init",
                cooldown = {
                  raw = "time.Minute * 5",
                  seconds = 300.0
                },
                class_token = "warrior"
              },
              {
                class = "warrior",
                label = "Init",
                cooldown = {
                  raw = "time.Minute * 3",
                  seconds = 180.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagOffensiveEquipment",
                spell_school = "2",
                proc_mask = "2",
                class_token = "warrior"
              },
              {
                class = "warrior",
                spell_id = 24427,
                label = "Init",
                cooldown = {
                  raw = "time.Minute * 6",
                  seconds = 360.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS",
                  priority = "core.CooldownPriorityDefault"
                },
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagOffensiveEquipment",
                class_token = "warrior"
              }
            }
          }
        },
        giftof_life = {
          id = 21,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warrior",
              spell_id = 23725,
              label = "Gift of Life",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "warrior"
            }
          }
        },
        reducesthecostofyour_hamstringabilityby2ragepoints = {
          id = 22,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warrior",
              label = "Reduces the cost of your Hamstring ability by 2 rage points.",
              class_token = "warrior"
            }
          }
        },
        whirlwind = {
          id = 23,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 1680,
              label = "Whirlwind",
              cooldown = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              flags = "core.SpellFlagAPL | SpellFlagOffensive",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              threat_multiplier = "1.25",
              class_token = "warrior"
            }
          }
        },
        make_stance = {
          id = 24,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "warrior",
                label = "Make Stance",
                cooldown = {
                  raw = "time.Second",
                  seconds = 1.0
                },
                flags = "SpellFlagAPL",
                class_token = "warrior"
              },
              {
                class = "warrior",
                label = "Make Stance",
                cooldown = {
                  raw = "time.Second",
                  seconds = 1.0
                },
                flags = "SpellFlagAPL",
                class_token = "warrior"
              },
              {
                class = "warrior",
                label = "Make Stance",
                cooldown = {
                  raw = "time.Second",
                  seconds = 1.0
                },
                flags = "SpellFlagAPL",
                class_token = "warrior"
              }
            }
          }
        },
        berserker_stance = {
          id = 25,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warrior",
              spell_id = 2458,
              label = "Berserker Stance",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "warrior"
            }
          }
        },
        defensive_stance = {
          id = 26,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warrior",
              spell_id = 71,
              label = "Defensive Stance",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "warrior"
            }
          }
        },
        battle_stance = {
          id = 27,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warrior",
              spell_id = 2457,
              label = "Battle Stance",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "warrior"
            }
          }
        },
        make_queue_spells_and = {
          id = 28,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "warrior",
                label = "Make Queue Spells And",
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagCastTimeNoGCD",
                class_token = "warrior"
              },
              {
                class = "warrior",
                label = "Make Queue Spells And",
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagCastTimeNoGCD",
                class_token = "warrior"
              }
            },
            aura = {
              {
                class = "warrior",
                label = "HS/Cleave Queue Aura",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "warrior"
              },
              {
                class = "warrior",
                label = "HS/Cleave Queue Aura",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "warrior"
              }
            }
          }
        },
        cleave = {
          id = 29,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 20569,
              label = "Cleave",
              flags = "core.SpellFlagMeleeMetrics | SpellFlagOffensive",
              spell_school = "2",
              proc_mask = "core.ProcMaskMeleeMHSpecial | core.ProcMaskMeleeMHAuto",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "warrior"
            }
          }
        },
        heroic_strike = {
          id = 30,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              label = "Heroic Strike",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete | SpellFlagOffensive",
              spell_school = "2",
              proc_mask = "core.ProcMaskMeleeMHSpecial | core.ProcMaskMeleeMHAuto",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "warrior"
            }
          }
        },
        pummel = {
          id = 31,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 6554,
              label = "Pummel",
              cooldown = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagBinary | SpellFlagOffensive",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "warrior"
            }
          }
        },
        execute = {
          id = 32,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 20662,
              label = "Execute",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagPassiveSpell | SpellFlagOffensive",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              threat_multiplier = "1.25",
              class_token = "warrior"
            }
          }
        },
        make_flurry_consumption_trigger = {
          id = 33,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warrior",
              label = "Flurry Consume Trigger",
              class_token = "warrior"
            }
          }
        },
        make_flurry = {
          id = 34,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warrior",
              label = "Flurry Proc",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "warrior"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "berserker_rage",
        "revenge",
        "hamstring",
        "shield_wall",
        "bloodrage",
        "slam",
        "increased_hit_chance",
        "conqueror_shout_bonus",
        "improved_whirlwind",
        "parry_trigger",
        "warriors_wrath_trigger",
        "warriors_wrath",
        "enhanced_sunder_armor",
        "shield_block",
        "rend",
        "recklessness",
        "new_shout_spell_config",
        "overpower",
        "hamstring_rage_reduction",
        "init",
        "giftof_life",
        "reducesthecostofyour_hamstringabilityby2ragepoints",
        "whirlwind",
        "make_stance",
        "berserker_stance",
        "defensive_stance",
        "battle_stance",
        "make_queue_spells_and",
        "cleave",
        "heroic_strike",
        "pummel",
        "execute",
        "make_flurry_consumption_trigger",
        "make_flurry"
      },
      synthetic = true
    },
    CommonItemhelpersSpells = {
      fields = {
        weapon_proc_damage = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "common",
                spec = "itemhelpers",
                label = "Weapon Proc Damage",
                label_raw = [[fmt.Sprintf("%s Proc Aura", itemName)]],
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "common",
                spec_token = "itemhelpers"
              },
              {
                class = "common",
                spec = "itemhelpers",
                label = "Weapon Proc Damage",
                label_raw = [[fmt.Sprintf("%s Proc Aura", itemName)]],
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "common",
                spec_token = "itemhelpers"
              }
            },
            spell = {
              class = "common",
              spec = "itemhelpers",
              spell_id = 20303,
              label = "Weapon Proc Damage",
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
              spell_school = "school",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "common",
              spec_token = "itemhelpers"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "weapon_proc_damage"
      },
      synthetic = true
    },
    CommonItemSetsSpells = {
      fields = {
        primal_blessing = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "item_sets",
              spell_id = 467742,
              label = "Primal Blessing",
              duration = {
                raw = "time.Second * 12",
                seconds = 12.0
              },
              class_token = "common",
              spec_token = "item_sets"
            }
          }
        },
        proc = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "common",
                spec = "item_sets",
                spell_id = 9057,
                label = "Proc",
                spell_school = "SpellSchoolFire",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "item_sets"
              },
              {
                class = "common",
                spec = "item_sets",
                spell_id = 23864,
                label = "Proc",
                spell_school = "SpellSchoolNature",
                class_token = "common",
                spec_token = "item_sets"
              },
              {
                class = "common",
                spec = "item_sets",
                spell_id = 18980,
                label = "Proc",
                spell_school = "SpellSchoolNature",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "item_sets"
              }
            }
          }
        },
        revitalize = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "item_sets",
              spell_id = 18979,
              label = "Revitalize",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common",
              spec_token = "item_sets"
            }
          }
        },
        lightning = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "item_sets",
              spell_id = 18979,
              label = "Lightning",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common",
              spec_token = "item_sets"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "primal_blessing",
        "proc",
        "revitalize",
        "lightning"
      },
      synthetic = true
    },
    CommonItemEffectsSpells = {
      fields = {
        init = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "common",
                spec = "item_effects",
                label = "Init",
                cooldown = {
                  raw = "time.Minute * 3",
                  seconds = 180.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "SpellFlagNoOnCastComplete",
                spell_school = "2",
                proc_mask = "2",
                class_token = "common",
                spec_token = "item_effects"
              },
              {
                class = "common",
                spec = "item_effects",
                label = "Init",
                cooldown = {
                  raw = "time.Second * 120",
                  seconds = 120.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "SpellFlagNoOnCastComplete",
                spell_school = "2",
                proc_mask = "2",
                class_token = "common",
                spec_token = "item_effects"
              },
              {
                class = "common",
                spec = "item_effects",
                spell_id = 29155,
                label = "Init",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
                spell_school = "SpellSchoolShadow",
                proc_mask = "core.ProcMaskSpellProc | core.ProcMaskSpellDamageProc",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "item_effects"
              }
            }
          }
        },
        kissofthe_spider = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "item_effects",
              label = "Kiss of the Spider",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "common",
              spec_token = "item_effects"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "init",
        "kissofthe_spider"
      },
      synthetic = true
    },
    CommonGuardiansSpells = {
      fields = {
        acid_spit = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "common",
              spec = "guardians",
              spell_id = 9591,
              label = "Acid Spit",
              flags = "core.SpellFlagIgnoreModifiers | core.SpellFlagResetAttackSwing",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "common",
              spec_token = "guardians"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "acid_spit"
      },
      synthetic = true
    },
    EncounterSpells = {
      fields = {
        hateful_strike = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "encounters",
              spec = "naxxramas",
              spell_id = 59192,
              label = "Hateful Strike",
              cooldown = {
                raw = "time.Second * 2",
                seconds = 2.0
              },
              flags = "SpellFlagMeleeMetrics",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              class_token = "encounters",
              spec_token = "naxxramas"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "hateful_strike"
      },
      synthetic = true
    }
  },
  enums = {
    Armor = {
      NoArmor = 0,
      InnerFire = 1
    },
    TristateEffect = {
      TristateEffectMissing = 0,
      TristateEffectRegular = 1,
      TristateEffectImproved = 2
    },
    SaygesFortune = {
      SaygesUnknown = 0,
      SaygesDamage = 1,
      SaygesAgility = 2,
      SaygesIntellect = 3,
      SaygesStamina = 4,
      SaygesSpirit = 5
    },
    Flask = {
      FlaskUnknown = 0,
      FlaskOfTheTitans = 1,
      FlaskOfDistilledWisdom = 2,
      FlaskOfSupremePower = 3,
      FlaskOfChromaticResistance = 4
    },
    Food = {
      FoodUnknown = 0,
      FoodGrilledSquid = 1,
      FoodSmokedDesertDumpling = 2,
      FoodNightfinSoup = 3,
      FoodRunnTumTuberSurprise = 4,
      FoodDirgesKickChimaerokChops = 5,
      FoodBlessedSunfruitJuice = 6,
      FoodBlessSunfruit = 7,
      FoodHotWolfRibs = 8,
      FoodTenderWolfSteak = 9,
      FoodSmokedSagefish = 10,
      FoodSagefishDelight = 11
    },
    AgilityElixir = {
      AgilityElixirUnknown = 0,
      ElixirOfTheMongoose = 1,
      ElixirOfGreaterAgility = 2,
      ElixirOfLesserAgility = 3,
      ScrollOfAgility = 4,
      ElixirOfAgility = 5
    },
    ManaRegenElixir = {
      ManaRegenElixirUnknown = 0,
      MagebloodPotion = 1
    },
    StrengthBuff = {
      StrengthBuffUnknown = 0,
      JujuPower = 1,
      ElixirOfGiants = 2,
      ElixirOfOgresStrength = 3,
      ScrollOfStrength = 4
    },
    AttackPowerBuff = {
      AttackPowerBuffUnknown = 0,
      JujuMight = 1,
      WinterfallFirewater = 2
    },
    SpellPowerBuff = {
      SpellPowerBuffUnknown = 0,
      ArcaneElixir = 1,
      GreaterArcaneElixir = 2,
      LesserArcaneElixir = 3
    },
    ShadowPowerBuff = {
      ShadowPowerBuffUnknown = 0,
      ElixirOfShadowPower = 1
    },
    FirePowerBuff = {
      FirePowerBuffUnknown = 0,
      ElixirOfFirepower = 1,
      ElixirOfGreaterFirepower = 2
    },
    FrostPowerBuff = {
      FrostPowerBuffUnknown = 0,
      ElixirOfFrostPower = 1
    },
    Explosive = {
      ExplosiveUnknown = 0,
      ExplosiveSolidDynamite = 1,
      ExplosiveDenseDynamite = 2,
      ExplosiveThoriumGrenade = 3,
      ExplosiveGoblinLandMine = 4
    },
    WeaponImbue = {
      WeaponImbueUnknown = 0,
      MinorWizardOil = 13,
      LesserWizardOil = 14,
      WizardOil = 20,
      BrilliantWizardOil = 2,
      BlessedWizardOil = 24,
      MinorManaOil = 15,
      LesserManaOil = 16,
      BrilliantManaOil = 1,
      SolidSharpeningStone = 17,
      DenseSharpeningStone = 3,
      ElementalSharpeningStone = 4,
      ConsecratedSharpeningStone = 23,
      SolidWeightstone = 18,
      DenseWeightstone = 19,
      ShadowOil = 21,
      FrostOil = 22,
      Windfury = 8,
      RockbiterWeapon = 9,
      FlametongueWeapon = 10,
      FrostbrandWeapon = 11,
      WindfuryWeapon = 12,
      InstantPoison = 5,
      DeadlyPoison = 6,
      WoundPoison = 7
    },
    Potions = {
      UnknownPotion = 0,
      ManaPotion = 2,
      GreaterManaPotion = 3,
      SuperiorManaPotion = 4,
      MajorManaPotion = 5,
      RagePotion = 6,
      GreatRagePotion = 7,
      MightyRagePotion = 8,
      LesserStoneshieldPotion = 9,
      GreaterStoneshieldPotion = 10,
      LesserHealingPotion = 11,
      HealingPotion = 12,
      GreaterHealingPotion = 13,
      SuperiorHealingPotion = 14,
      MajorHealingPotion = 15,
      MagicResistancePotion = 16,
      GreaterArcaneProtectionPotion = 17,
      GreaterFireProtectionPotion = 18,
      GreaterFrostProtectionPotion = 19,
      GreaterHolyProtectionPotion = 20,
      GreaterNatureProtectionPotion = 21,
      GreaterShadowProtectionPotion = 22,
      LesserManaPotion = 1
    },
    Conjured = {
      ConjuredUnknown = 0,
      ConjuredMinorRecombobulator = 1,
      ConjuredDemonicRune = 2,
      ConjuredRogueThistleTea = 3,
      ConjuredHealthstone = 4,
      ConjuredGreaterHealthstone = 5,
      ConjuredMajorHealthstone = 6
    },
    ZanzaBuff = {
      ZanzaBuffUnknown = 0,
      SpiritOfZanza = 1,
      SheenOfZanza = 2,
      SwiftnessOfZanza = 3,
      ROIDS = 4,
      GroundScorpokAssay = 5,
      CerebralCortexCompound = 6,
      GizzardGum = 7,
      LungJuiceCocktail = 8,
      DarnassusGiftCollection = 9
    },
    ArmorElixir = {
      ArmorElixirUnknown = 0,
      ElixirOfSuperiorDefense = 1,
      ElixirOfGreaterDefense = 2,
      ElixirOfDefense = 3,
      ElixirOfMinorDefense = 4,
      ScrollOfProtection = 5
    },
    HealthElixir = {
      HealthElixirUnknown = 0,
      ElixirOfFortitude = 1,
      ElixirOfMinorFortitude = 2
    },
    Alcohol = {
      AlcoholUnknown = 0,
      AlcoholRumseyRumBlackLabel = 1,
      AlcoholGordokGreenGrog = 2,
      AlcoholRumseyRumDark = 3,
      AlcoholRumseyRumLight = 4,
      AlcoholKreegsStoutBeatdown = 5
    },
    SapperExplosive = {
      SapperUnknown = 0,
      SapperGoblinSapper = 1
    },
    HitConsumable = {
      HitConsumableUnknown = 0,
      FireToastedBun = 1,
      DarkDesire = 2
    },
    InputType = {
      Bool = 0,
      Number = 1,
      Enum = 2
    },
    MobType = {
      MobTypeUnknown = 0,
      MobTypeBeast = 1,
      MobTypeDemon = 2,
      MobTypeDragonkin = 3,
      MobTypeElemental = 4,
      MobTypeGiant = 5,
      MobTypeHumanoid = 6,
      MobTypeMechanical = 7,
      MobTypeUndead = 8
    },
    SpellSchool = {
      SpellSchoolPhysical = 0,
      SpellSchoolArcane = 1,
      SpellSchoolFire = 2,
      SpellSchoolFrost = 3,
      SpellSchoolHoly = 4,
      SpellSchoolNature = 5,
      SpellSchoolShadow = 6
    },
    Class = {
      ClassUnknown = 0,
      ClassDruid = 1,
      ClassHunter = 2,
      ClassMage = 3,
      ClassPaladin = 4,
      ClassPriest = 5,
      ClassRogue = 6,
      ClassShaman = 7,
      ClassWarlock = 8,
      ClassWarrior = 9
    },
    ItemType = {
      ItemTypeUnknown = 0,
      ItemTypeHead = 1,
      ItemTypeNeck = 2,
      ItemTypeShoulder = 3,
      ItemTypeBack = 4,
      ItemTypeChest = 5,
      ItemTypeWrist = 6,
      ItemTypeHands = 7,
      ItemTypeWaist = 8,
      ItemTypeLegs = 9,
      ItemTypeFeet = 10,
      ItemTypeFinger = 11,
      ItemTypeTrinket = 12,
      ItemTypeWeapon = 13,
      ItemTypeRanged = 14
    },
    ArmorType = {
      ArmorTypeUnknown = 0,
      ArmorTypeCloth = 1,
      ArmorTypeLeather = 2,
      ArmorTypeMail = 3,
      ArmorTypePlate = 4
    },
    WeaponType = {
      WeaponTypeUnknown = 0,
      WeaponTypeAxe = 1,
      WeaponTypeDagger = 2,
      WeaponTypeFist = 3,
      WeaponTypeMace = 4,
      WeaponTypeOffHand = 5,
      WeaponTypePolearm = 6,
      WeaponTypeShield = 7,
      WeaponTypeStaff = 8,
      WeaponTypeSword = 9
    },
    HandType = {
      HandTypeUnknown = 0,
      HandTypeMainHand = 1,
      HandTypeOneHand = 2,
      HandTypeOffHand = 3,
      HandTypeTwoHand = 4
    },
    RangedWeaponType = {
      RangedWeaponTypeUnknown = 0,
      RangedWeaponTypeBow = 1,
      RangedWeaponTypeCrossbow = 2,
      RangedWeaponTypeGun = 3,
      RangedWeaponTypeIdol = 4,
      RangedWeaponTypeLibram = 5,
      RangedWeaponTypeThrown = 6,
      RangedWeaponTypeTotem = 7,
      RangedWeaponTypeWand = 8,
      RangedWeaponTypeSigil = 9
    },
    UnitType = {
      Unknown = 0,
      Player = 1,
      Target = 2,
      Pet = 3,
      Self = 4,
      CurrentTarget = 5,
      AllPlayers = 6,
      AllTargets = 7
    },
    Type = {
      Unknown = 0,
      Player = 1,
      Target = 2,
      Pet = 3,
      Self = 4,
      CurrentTarget = 5,
      AllPlayers = 6,
      AllTargets = 7
    },
    OtherAction = {
      OtherActionNone = 0,
      OtherActionWait = 1,
      OtherActionManaRegen = 2,
      OtherActionEnergyRegen = 3,
      OtherActionFocusRegen = 4,
      OtherActionManaGain = 5,
      OtherActionRageGain = 6,
      OtherActionAttack = 7,
      OtherActionShoot = 8,
      OtherActionPet = 9,
      OtherActionRefund = 10,
      OtherActionDamageTaken = 11,
      OtherActionHealingModel = 12,
      OtherActionPotion = 13,
      OtherActionMove = 14,
      OtherActionComboPoints = 15,
      OtherActionExplosives = 16,
      OtherActionOffensiveEquip = 17,
      OtherActionDefensiveEquip = 18
    },
    Spec = {
      SpecBalanceDruid = 0,
      SpecFeralDruid = 12,
      SpecFeralTankDruid = 14,
      SpecRestorationDruid = 18,
      SpecElementalShaman = 1,
      SpecEnhancementShaman = 9,
      SpecRestorationShaman = 19,
      SpecWardenShaman = 21,
      SpecHunter = 8,
      SpecMage = 2,
      SpecHolyPaladin = 20,
      SpecProtectionPaladin = 13,
      SpecRetributionPaladin = 3,
      SpecRogue = 7,
      SpecHealingPriest = 17,
      SpecShadowPriest = 4,
      SpecWarlock = 5,
      SpecWarrior = 6,
      SpecTankWarrior = 11
    },
    Race = {
      RaceUnknown = 0,
      RaceDwarf = 1,
      RaceGnome = 2,
      RaceHuman = 3,
      RaceNightElf = 4,
      RaceOrc = 5,
      RaceTauren = 6,
      RaceTroll = 7,
      RaceUndead = 8
    },
    Faction = {
      Unknown = 0,
      Alliance = 1,
      Horde = 2
    },
    Profession = {
      ProfessionUnknown = 0,
      Alchemy = 1,
      Blacksmithing = 2,
      Enchanting = 3,
      Engineering = 4,
      Herbalism = 5,
      Leatherworking = 8,
      Mining = 9,
      Skinning = 10,
      Tailoring = 11
    },
    Stat = {
      StatStrength = 0,
      StatAgility = 1,
      StatStamina = 2,
      StatIntellect = 3,
      StatSpirit = 4,
      StatSpellPower = 5,
      StatArcanePower = 6,
      StatFirePower = 7,
      StatFrostPower = 8,
      StatHolyPower = 9,
      StatNaturePower = 10,
      StatShadowPower = 11,
      StatMP5 = 12,
      StatSpellHit = 13,
      StatSpellCrit = 14,
      StatSpellHaste = 15,
      StatSpellPenetration = 16,
      StatAttackPower = 17,
      StatMeleeHit = 18,
      StatMeleeCrit = 19,
      StatMeleeHaste = 20,
      StatArmorPenetration = 21,
      StatExpertise = 22,
      StatMana = 23,
      StatEnergy = 24,
      StatRage = 25,
      StatArmor = 26,
      StatRangedAttackPower = 27,
      StatDefense = 28,
      StatBlock = 29,
      StatBlockValue = 30,
      StatDodge = 31,
      StatParry = 32,
      StatResilience = 33,
      StatHealth = 34,
      StatArcaneResistance = 35,
      StatFireResistance = 36,
      StatFrostResistance = 37,
      StatNatureResistance = 38,
      StatShadowResistance = 39,
      StatBonusArmor = 40,
      StatHealingPower = 41,
      StatSpellDamage = 42,
      StatFeralAttackPower = 43
    },
    PseudoStat = {
      PseudoStatMainHandDps = 0,
      PseudoStatOffHandDps = 1,
      PseudoStatRangedDps = 2,
      PseudoStatBlockValueMultiplier = 3,
      PseudoStatDodge = 4,
      PseudoStatParry = 5,
      BonusPhysicalDamage = 30,
      PseudoStatUnarmedSkill = 6,
      PseudoStatDaggersSkill = 7,
      PseudoStatSwordsSkill = 8,
      PseudoStatMacesSkill = 9,
      PseudoStatAxesSkill = 10,
      PseudoStatTwoHandedSwordsSkill = 11,
      PseudoStatTwoHandedMacesSkill = 12,
      PseudoStatTwoHandedAxesSkill = 13,
      PseudoStatPolearmsSkill = 14,
      PseudoStatStavesSkill = 15,
      PseudoStatBowsSkill = 16,
      PseudoStatCrossbowsSkill = 17,
      PseudoStatGunsSkill = 18,
      PseudoStatThrownSkill = 19,
      PseudoStatFeralCombatSkill = 20,
      PseudoStatSchoolHitArcane = 21,
      PseudoStatSchoolHitFire = 22,
      PseudoStatSchoolHitFrost = 23,
      PseudoStatSchoolHitHoly = 24,
      PseudoStatSchoolHitNature = 25,
      PseudoStatSchoolHitShadow = 26,
      PseudoStatMeleeSpeedMultiplier = 27,
      PseudoStatRangedSpeedMultiplier = 28,
      PseudoStatCastSpeedMultiplier = 34,
      PseudoStatBlockValuePerStrength = 29
    },
    WeaponSkill = {
      WeaponSkillUnknown = 0,
      WeaponSkillAxes = 1,
      WeaponSkillSwords = 2,
      WeaponSkillMaces = 3,
      WeaponSkillDaggers = 4,
      WeaponSkillUnarmed = 5,
      WeaponSkillTwoHandedAxes = 6,
      WeaponSkillTwoHandedSwords = 7,
      WeaponSkillTwoHandedMaces = 8,
      WeaponSkillPolearms = 9,
      WeaponSkillStaves = 10,
      WeaponSkillThrown = 11,
      WeaponSkillBows = 12,
      WeaponSkillCrossbows = 13,
      WeaponSkillGuns = 14,
      WeaponSkillFeralCombat = 15
    },
    CastType = {
      CastTypeUnknown = 0,
      CastTypeMainHand = 1,
      CastTypeOffHand = 2,
      CastTypeRanged = 3
    },
    ItemSlot = {
      ItemSlotHead = 0,
      ItemSlotNeck = 1,
      ItemSlotShoulder = 2,
      ItemSlotBack = 3,
      ItemSlotChest = 4,
      ItemSlotWrist = 5,
      ItemSlotHands = 6,
      ItemSlotWaist = 7,
      ItemSlotLegs = 8,
      ItemSlotFeet = 9,
      ItemSlotFinger1 = 10,
      ItemSlotFinger2 = 11,
      ItemSlotTrinket1 = 12,
      ItemSlotTrinket2 = 13,
      ItemSlotMainHand = 14,
      ItemSlotOffHand = 15,
      ItemSlotRanged = 16
    },
    ItemQuality = {
      ItemQualityJunk = 0,
      ItemQualityCommon = 1,
      ItemQualityUncommon = 2,
      ItemQualityRare = 3,
      ItemQualityEpic = 4,
      ItemQualityLegendary = 5,
      ItemQualityArtifact = 6,
      ItemQualityHeirloom = 7
    },
    EnchantType = {
      EnchantTypeNormal = 0,
      EnchantTypeTwoHand = 1,
      EnchantTypeShield = 2,
      EnchantTypeKit = 3,
      EnchantTypeStaff = 4
    },
    APLRotationType = {
      TypeUnknown = 0,
      TypeAuto = 1,
      TypeSimple = 2,
      TypeAPL = 3,
      TypeLegacy = 4
    },
    SwapSet = {
      Unknown = 0,
      Main = 1,
      Swap1 = 2
    },
    ComparisonOperator = {
      OpUnknown = 0,
      OpEq = 1,
      OpNe = 2,
      OpLt = 3,
      OpLe = 4,
      OpGt = 5,
      OpGe = 6
    },
    MathOperator = {
      OpUnknown = 0,
      OpAdd = 1,
      OpSub = 2,
      OpMul = 3,
      OpDiv = 4
    },
    ExecutePhaseThreshold = {
      Unknown = 0,
      E20 = 1,
      E25 = 2,
      E35 = 3
    },
    AttackType = {
      Unknown = 0,
      Any = 1,
      Melee = 2,
      MainHand = 3,
      OffHand = 4,
      Ranged = 5
    },
    SwingType = {
      Unknown = 0,
      MainHand = 3,
      OffHand = 4,
      Ranged = 5
    },
    TotemType = {
      TypeUnknown = 0,
      Earth = 1,
      Air = 2,
      Fire = 3,
      Water = 4
    },
    APLValueType = {
      ValueTypeUnknown = 0,
      ValueTypeBool = 1,
      ValueTypeInt = 2,
      ValueTypeFloat = 3,
      ValueTypeDuration = 4,
      ValueTypeString = 5
    },
    EarthTotem = {
      NoEarthTotem = 0,
      StrengthOfEarthTotem = 1,
      TremorTotem = 2,
      StoneskinTotem = 3
    },
    AirTotem = {
      NoAirTotem = 0,
      WindfuryTotem = 1,
      GraceOfAirTotem = 2
    },
    FireTotem = {
      NoFireTotem = 0,
      MagmaTotem = 1,
      SearingTotem = 2,
      FireNovaTotem = 3
    },
    WaterTotem = {
      NoWaterTotem = 0,
      ManaSpringTotem = 1,
      HealingStreamTotem = 2
    },
    ShamanSyncType = {
      NoSync = 0,
      SyncMainhandOffhandSwings = 1,
      DelayOffhandSwings = 2,
      Auto = 3
    },
    ShamanHealSpell = {
      AutoHeal = 0,
      HealingWave = 1,
      LesserHealingWave = 2,
      ChainHeal = 3
    },
    WarriorShout = {
      WarriorShoutNone = 0,
      WarriorShoutBattle = 1,
      WarriorShoutCommanding = 2
    },
    WarriorStance = {
      WarriorStanceNone = 0,
      WarriorStanceBattle = 1,
      WarriorStanceDefensive = 2,
      WarriorStanceBerserker = 3,
      WarriorStanceGladiator = 4
    },
    Summon = {
      NoSummon = 0,
      Imp = 1,
      Voidwalker = 2,
      Succubus = 3,
      Felhunter = 4
    },
    MaxFireboltRank = {
      NoMaximum = 0,
      Rank1 = 1,
      Rank2 = 2,
      Rank3 = 3,
      Rank4 = 4,
      Rank5 = 5,
      Rank6 = 6,
      Rank7 = 7,
      Rank8 = 8
    },
    PaladinSeal = {
      NoSeal = 0,
      Righteousness = 1,
      Command = 2,
      Martyrdom = 3
    },
    PaladinAura = {
      NoPaladinAura = 0,
      SanctityAura = 1,
      DevotionAura = 2,
      RetributionAura = 3,
      ConcentrationAura = 4,
      FrostResistanceAura = 5,
      ShadowResistanceAura = 6,
      FireResistanceAura = 7
    },
    Blessings = {
      BlessingUnknown = 0,
      BlessingOfKings = 1,
      BlessingOfMight = 2,
      BlessingOfSalvation = 3,
      BlessingOfWisdom = 4,
      BlessingOfSanctuary = 5,
      BlessingOfLight = 6
    },
    Expansion = {
      ExpansionUnknown = 0,
      ExpansionVanilla = 1,
      ExpansionTbc = 2,
      ExpansionWotlk = 3
    },
    FactionRestriction = {
      FACTION_RESTRICTION_UNSPECIFIED = 0,
      FACTION_RESTRICTION_ALLIANCE_ONLY = 1,
      FACTION_RESTRICTION_HORDE_ONLY = 2
    },
    DungeonDifficulty = {
      DifficultyUnknown = 0,
      DifficultyNormal = 1
    },
    RepLevel = {
      RepLevelUnknown = 0,
      RepLevelHated = 1,
      RepLevelHostile = 2,
      RepLevelUnfriendly = 3,
      RepLevelNeutral = 4,
      RepLevelFriendly = 5,
      RepLevelHonored = 6,
      RepLevelRevered = 7,
      RepLevelExalted = 8
    },
    SourceFilterOption = {
      SourceUnknown = 0,
      SourceCrafting = 1,
      SourceQuest = 2,
      SourceDungeon = 3,
      SourceRaid = 4,
      SourceWorldBOE = 6,
      SourceReputation = 7
    },
    RaidFilterOption = {
      RaidUnknown = 0,
      RaidMoltenCore = 2717,
      RaidOnyxiasLair = 2159,
      RaidBlackwingLair = 2677,
      RaidZulGurub = 1977,
      RaidRuinsOfAQ = 3428,
      RaidTempleOfAQ = 3429,
      RaidNaxxramas = 3456
    },
    DungeonFilterOption = {
      DungeonUnknown = 0,
      DungeonRagefireChasm = 2437,
      DungeonDeadmines = 1581,
      DungeonWailingCaverns = 718,
      DungeonShadowfangKeep = 209,
      DungeonStockades = 717,
      DungeonRazorfenKraul = 491,
      DungeonScarletMonestary = 796,
      DungeonRazorfenDowns = 722,
      DungeonUldaman = 1337,
      DungeonZulFarrak = 1176,
      DungeonMaraudon = 2100,
      DungeonBlackrockDepths = 1584,
      DungeonScholomance = 2057,
      DungeonStratholme = 2017,
      DungeonBlackrockSpire = 1583,
      DungeonDireMaul = 2557
    },
    ExcludedZones = {
      ZoneUnknown = 0
    },
    ResourceType = {
      ResourceTypeNone = 0,
      ResourceTypeMana = 1,
      ResourceTypeEnergy = 2,
      ResourceTypeRage = 3,
      ResourceTypeComboPoints = 4,
      ResourceTypeFocus = 5,
      ResourceTypeHealth = 6
    },
    ErrorOutcomeType = {
      ErrorOutcomeError = 0,
      ErrorOutcomeAborted = 1
    }
  },
  consumables = {

  },
  buffs_debuffs = {

  },
  enum_name_collisions = {
    Type = {
      "proto.APLRotation.Type",
      "proto.UnitReference.Type"
    },
    Armor = {
      "proto.ShadowPriest.Options.Armor",
      "proto.WarlockOptions.Armor"
    },
    WeaponImbue = {
      "proto.WarlockOptions.WeaponImbue",
      "proto.WeaponImbue"
    }
  }
}
