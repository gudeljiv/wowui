-- AST prototype schema for tbc
local _, ns = ...
ns.protoSchema = ns.protoSchema or {}
ns.protoSchema['tbc'] = {
  version = "tbc",
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
        absolution = {
          id = 7,
          type = "int32",
          label = "optional"
        },
        inner_focus = {
          id = 8,
          type = "bool",
          label = "optional"
        },
        meditation = {
          id = 9,
          type = "int32",
          label = "optional"
        },
        improved_inner_fire = {
          id = 10,
          type = "int32",
          label = "optional"
        },
        mental_agility = {
          id = 11,
          type = "int32",
          label = "optional"
        },
        improved_mana_burn = {
          id = 12,
          type = "int32",
          label = "optional"
        },
        mental_strength = {
          id = 13,
          type = "int32",
          label = "optional"
        },
        divine_spirit = {
          id = 14,
          type = "bool",
          label = "optional"
        },
        improved_divine_spirit = {
          id = 15,
          type = "int32",
          label = "optional"
        },
        focused_power = {
          id = 16,
          type = "int32",
          label = "optional"
        },
        force_of_will = {
          id = 17,
          type = "int32",
          label = "optional"
        },
        focused_will = {
          id = 18,
          type = "int32",
          label = "optional"
        },
        power_infusion = {
          id = 19,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "priest",
              spell_id = 10060,
              label = "Power Infusion",
              cooldown = {
                raw = "time.Minute * 2",
                seconds = 120.0
              },
              major_cooldown = {
                type = "core.CooldownTypeMana",
                priority = "core.CooldownPriorityBloodlust"
              },
              flags = "SpellFlagHelpful",
              class_token = "priest"
            },
            aura = {
              class = "priest",
              spell_id = 10060,
              label = "PowerInfusion-Aura",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "priest"
            }
          }
        },
        reflective_shield = {
          id = 20,
          type = "int32",
          label = "optional"
        },
        enlightenment = {
          id = 21,
          type = "int32",
          label = "optional"
        },
        pain_suppression = {
          id = 22,
          type = "bool",
          label = "optional",
          _metadata = {
            aura = {
              class = "core",
              spell_id = 33206,
              label = "PainSuppression",
              tag = "PainSuppression",
              duration = {
                raw = "time.Second * 8",
                seconds = 8.0
              },
              class_token = "core"
            }
          }
        },
        healing_focus = {
          id = 23,
          type = "int32",
          label = "optional"
        },
        improved_renew = {
          id = 24,
          type = "int32",
          label = "optional"
        },
        holy_specialization = {
          id = 25,
          type = "int32",
          label = "optional"
        },
        spell_warding = {
          id = 26,
          type = "int32",
          label = "optional"
        },
        divine_fury = {
          id = 27,
          type = "int32",
          label = "optional"
        },
        holy_nova = {
          id = 28,
          type = "bool",
          label = "optional"
        },
        blessed_recovery = {
          id = 29,
          type = "int32",
          label = "optional"
        },
        inspiration = {
          id = 30,
          type = "int32",
          label = "optional"
        },
        holy_reach = {
          id = 31,
          type = "int32",
          label = "optional"
        },
        improved_healing = {
          id = 32,
          type = "int32",
          label = "optional"
        },
        searing_light = {
          id = 33,
          type = "int32",
          label = "optional"
        },
        healing_prayers = {
          id = 34,
          type = "int32",
          label = "optional"
        },
        spirit_of_redemption = {
          id = 35,
          type = "bool",
          label = "optional"
        },
        spiritual_guidance = {
          id = 36,
          type = "int32",
          label = "optional"
        },
        surge_of_light = {
          id = 37,
          type = "int32",
          label = "optional"
        },
        spiritual_healing = {
          id = 38,
          type = "int32",
          label = "optional"
        },
        holy_concentration = {
          id = 39,
          type = "int32",
          label = "optional"
        },
        lightwell = {
          id = 40,
          type = "bool",
          label = "optional"
        },
        blessed_resilience = {
          id = 41,
          type = "int32",
          label = "optional"
        },
        empowered_healing = {
          id = 42,
          type = "int32",
          label = "optional"
        },
        circle_of_healing = {
          id = 43,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "priest",
              spell_id = 48089,
              label = "Circle Of Healing",
              cooldown = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskSpellHealing",
              damage_multiplier = "1 * (1 + .02*float64(priest.Talents.SpiritualHealing)) * (1 + .01*float64(priest.Talents.BlessedResilience)) * (1 + .02*float64(priest.Talents.FocusedPower)) * (1 + .02*float64(priest.Talents.DivineProvidence)) * core.TernaryFloat64(priest.CouldHaveSetBonus(ItemSetCrimsonAcolytesRaiment, 4), 1.1, 1)",
              crit_multiplier = "priest.DefaultCritMultiplier()",
              threat_multiplier = "1 - []float64{0, .07, .14, .20}[priest.Talents.SilentResolve]",
              class_token = "priest"
            }
          }
        },
        spirit_tap = {
          id = 44,
          type = "int32",
          label = "optional"
        },
        blackout = {
          id = 45,
          type = "int32",
          label = "optional"
        },
        shadow_affinity = {
          id = 46,
          type = "int32",
          label = "optional"
        },
        improved_shadow_word_pain = {
          id = 47,
          type = "int32",
          label = "optional"
        },
        shadow_focus = {
          id = 48,
          type = "int32",
          label = "optional"
        },
        improved_psychic_scream = {
          id = 49,
          type = "int32",
          label = "optional"
        },
        improved_mind_blast = {
          id = 50,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "priest",
              label = "Improved Mind Blast",
              class_token = "priest"
            },
            spell = {
              class = "priest",
              spell_id = 48301,
              label = "Improved Mind Blast",
              flags = "SpellFlagNoMetrics",
              class_spell_mask = "PriestSpellMindTrauma",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellProc",
              damage_multiplier = "1",
              damage_multiplier_additive = "1",
              crit_multiplier = "priest.DefaultCritMultiplier()",
              class_token = "priest"
            }
          }
        },
        mind_flay = {
          id = 51,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "priest",
              spec = "shadow",
              spell_id = 15407,
              label = "MindFlay",
              flags = "core.SpellFlagChanneled | core.SpellFlagAPL",
              class_spell_mask = "PriestSpellMindFlay",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              damage_multiplier_additive = "1",
              crit_multiplier = "shadow.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "priest",
              spec_token = "shadow"
            }
          }
        },
        improved_fade = {
          id = 52,
          type = "int32",
          label = "optional"
        },
        shadow_reach = {
          id = 53,
          type = "int32",
          label = "optional"
        },
        shadow_weaving = {
          id = 54,
          type = "int32",
          label = "optional"
        },
        silence = {
          id = 55,
          type = "bool",
          label = "optional"
        },
        vampiric_embrace = {
          id = 56,
          type = "bool",
          label = "optional"
        },
        improved_vampiric_embrace = {
          id = 57,
          type = "int32",
          label = "optional"
        },
        focused_mind = {
          id = 58,
          type = "int32",
          label = "optional"
        },
        shadow_resilience = {
          id = 59,
          type = "int32",
          label = "optional"
        },
        darkness = {
          id = 60,
          type = "int32",
          label = "optional"
        },
        shadowform = {
          id = 61,
          type = "bool",
          label = "optional"
        },
        shadow_power = {
          id = 62,
          type = "int32",
          label = "optional"
        },
        misery = {
          id = 63,
          type = "int32",
          label = "optional"
        },
        vampiric_touch = {
          id = 64,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "priest",
              spell_id = 34914,
              label = "VampiricTouch",
              flags = "SpellFlagAPL",
              class_spell_mask = "PriestSpellVampiricTouch",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              damage_multiplier_additive = "1",
              crit_multiplier = "priest.DefaultCritMultiplier()",
              threat_multiplier = "1",
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
        "absolution",
        "inner_focus",
        "meditation",
        "improved_inner_fire",
        "mental_agility",
        "improved_mana_burn",
        "mental_strength",
        "divine_spirit",
        "improved_divine_spirit",
        "focused_power",
        "force_of_will",
        "focused_will",
        "power_infusion",
        "reflective_shield",
        "enlightenment",
        "pain_suppression",
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
        "healing_prayers",
        "spirit_of_redemption",
        "spiritual_guidance",
        "surge_of_light",
        "spiritual_healing",
        "holy_concentration",
        "lightwell",
        "blessed_resilience",
        "empowered_healing",
        "circle_of_healing",
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
        "focused_mind",
        "shadow_resilience",
        "darkness",
        "shadowform",
        "shadow_power",
        "misery",
        "vampiric_touch"
      }
    },
    PriestOptions = {
      fields = {
        armor = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "Armor"
        },
        use_shadowfiend = {
          id = 2,
          type = "bool",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "armor",
        "use_shadowfiend"
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
        class_options = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "PriestOptions"
        },
        power_infusion_target = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "UnitReference"
        }
      },
      oneofs = {

      },
      field_order = {
        "class_options",
        "power_infusion_target"
      }
    },
    DisciplinePriest = {
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
    HolyPriest = {
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
    ProtoVersion = {
      fields = {
        saved_version_number = {
          id = 1,
          type = "int32",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "saved_version_number"
      }
    },
    StatsEntry = {
      fields = {
        key = {
          id = 1,
          type = "int32",
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
    ScalingItemProperties = {
      fields = {
        rand_prop_points = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        weapon_damage_min = {
          id = 2,
          type = "double",
          label = "optional"
        },
        weapon_damage_max = {
          id = 3,
          type = "double",
          label = "optional"
        },
        stats = {
          id = 4,
          type = "message",
          label = "repeated",
          message_type = "StatsEntry"
        },
        ilvl = {
          id = 6,
          type = "int32",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "rand_prop_points",
        "weapon_damage_min",
        "weapon_damage_max",
        "stats",
        "ilvl"
      }
    },
    UnitStats = {
      fields = {
        api_version = {
          id = 3,
          type = "int32",
          label = "optional"
        },
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
        "api_version",
        "stats",
        "pseudo_stats"
      }
    },
    RaidBuffs = {
      fields = {
        arcane_brilliance = {
          id = 1,
          type = "bool",
          label = "optional"
        },
        power_word_fortitude = {
          id = 2,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect"
        },
        shadow_protection = {
          id = 3,
          type = "bool",
          label = "optional"
        },
        divine_spirit = {
          id = 4,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect"
        },
        gift_of_the_wild = {
          id = 5,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect"
        },
        thorns = {
          id = 6,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect"
        },
        bloodlust = {
          id = 7,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "MajorHasteBuff",
            field_alias = "bloodlust",
            ids = {
              spell = {
                2825
              }
            },
            label = "Bloodlust",
            label_source = "i18n.t('settings_tab.external_damage_cooldowns.bloodlust')",
            spell = {
              {
                class = "shaman",
                label = "Bloodlust",
                cooldown = {
                  raw = "time.Minute * 10",
                  seconds = 600.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS",
                  priority = "core.CooldownPriorityBloodlust"
                },
                flags = "SpellFlagAPL",
                class_spell_mask = "SpellMaskBloodlust",
                class_token = "shaman"
              },
              {
                class = "core",
                label = "Bloodlust",
                cooldown = {
                  raw = "time.Minute * 10",
                  seconds = 600.0
                },
                major_cooldown = {
                  type = "CooldownTypeDPS",
                  priority = "CooldownPriorityBloodlust"
                },
                flags = "SpellFlagNoOnCastComplete | SpellFlagNoMetrics | SpellFlagNoLogs",
                class_token = "core"
              }
            },
            aura = {
              {
                class = "core",
                label = "Bloodlust",
                tag = "Bloodlust",
                duration = {
                  raw = "time.Second * 40",
                  seconds = 40.0
                },
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 57724,
                label = "Sated",
                duration = {
                  raw = "time.Minute * 10",
                  seconds = 600.0
                },
                class_token = "core"
              }
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "arcane_brilliance",
        "power_word_fortitude",
        "shadow_protection",
        "divine_spirit",
        "gift_of_the_wild",
        "thorns",
        "bloodlust"
      }
    },
    PartyBuffs = {
      fields = {
        ferocious_inspiration = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        blood_pact = {
          id = 2,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect"
        },
        moonkin_aura = {
          id = 3,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect"
        },
        leader_of_the_pack = {
          id = 4,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect"
        },
        sanctity_aura = {
          id = 5,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect"
        },
        devotion_aura = {
          id = 6,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            aura = {
              class = "core",
              label = "DevotionAura",
              tag = "DevotionAura",
              duration = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              class_token = "core"
            }
          }
        },
        retribution_aura = {
          id = 7,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect"
        },
        trueshot_aura = {
          id = 8,
          type = "bool",
          label = "optional"
        },
        draenei_racial_melee = {
          id = 9,
          type = "bool",
          label = "optional"
        },
        draenei_racial_caster = {
          id = 10,
          type = "bool",
          label = "optional"
        },
        drums = {
          id = 11,
          type = "enum",
          label = "optional",
          enum_type = "Drums"
        },
        atiesh_mage = {
          id = 12,
          type = "int32",
          label = "optional"
        },
        atiesh_warlock = {
          id = 13,
          type = "int32",
          label = "optional"
        },
        braided_eternium_chain = {
          id = 14,
          type = "bool",
          label = "optional"
        },
        eye_of_the_night = {
          id = 15,
          type = "bool",
          label = "optional"
        },
        chain_of_the_twilight_owl = {
          id = 16,
          type = "bool",
          label = "optional"
        },
        jade_pendant_of_blasting = {
          id = 17,
          type = "bool",
          label = "optional"
        },
        mana_spring_totem = {
          id = 18,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect"
        },
        mana_tide_totems = {
          id = 19,
          type = "int32",
          label = "optional"
        },
        totem_of_wrath = {
          id = 20,
          type = "int32",
          label = "optional"
        },
        wrath_of_air_totem = {
          id = 21,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect"
        },
        snapshot_improved_wrath_of_air_totem = {
          id = 22,
          type = "bool",
          label = "optional"
        },
        grace_of_air_totem = {
          id = 23,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect"
        },
        strength_of_earth_totem = {
          id = 24,
          type = "enum",
          label = "optional",
          enum_type = "StrengthOfEarthType"
        },
        snapshot_improved_strength_of_earth_totem = {
          id = 25,
          type = "bool",
          label = "optional"
        },
        tranquil_air_totem = {
          id = 26,
          type = "bool",
          label = "optional"
        },
        windfury_totem_rank = {
          id = 27,
          type = "int32",
          label = "optional"
        },
        windfury_totem_iwt = {
          id = 28,
          type = "int32",
          label = "optional"
        },
        battle_shout = {
          id = 29,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect"
        },
        bs_solarian_sapphire = {
          id = 30,
          type = "bool",
          label = "optional"
        },
        snapshot_bs_solarian_sapphire = {
          id = 31,
          type = "bool",
          label = "optional"
        },
        snapshot_bs_t2 = {
          id = 32,
          type = "bool",
          label = "optional"
        },
        snapshot_bs_booming_voice_rank = {
          id = 33,
          type = "int32",
          label = "optional"
        },
        commanding_shout = {
          id = 34,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect"
        }
      },
      oneofs = {

      },
      field_order = {
        "ferocious_inspiration",
        "blood_pact",
        "moonkin_aura",
        "leader_of_the_pack",
        "sanctity_aura",
        "devotion_aura",
        "retribution_aura",
        "trueshot_aura",
        "draenei_racial_melee",
        "draenei_racial_caster",
        "drums",
        "atiesh_mage",
        "atiesh_warlock",
        "braided_eternium_chain",
        "eye_of_the_night",
        "chain_of_the_twilight_owl",
        "jade_pendant_of_blasting",
        "mana_spring_totem",
        "mana_tide_totems",
        "totem_of_wrath",
        "wrath_of_air_totem",
        "snapshot_improved_wrath_of_air_totem",
        "grace_of_air_totem",
        "strength_of_earth_totem",
        "snapshot_improved_strength_of_earth_totem",
        "tranquil_air_totem",
        "windfury_totem_rank",
        "windfury_totem_iwt",
        "battle_shout",
        "bs_solarian_sapphire",
        "snapshot_bs_solarian_sapphire",
        "snapshot_bs_t2",
        "snapshot_bs_booming_voice_rank",
        "commanding_shout"
      }
    },
    IndividualBuffs = {
      fields = {
        blessing_of_kings = {
          id = 1,
          type = "bool",
          label = "optional"
        },
        blessing_of_salvation = {
          id = 2,
          type = "bool",
          label = "optional"
        },
        blessing_of_sanctuary = {
          id = 3,
          type = "bool",
          label = "optional"
        },
        blessing_of_wisdom = {
          id = 4,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect"
        },
        blessing_of_might = {
          id = 5,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect"
        },
        shadow_priest_dps = {
          id = 6,
          type = "int32",
          label = "optional"
        },
        unleashed_rage = {
          id = 7,
          type = "bool",
          label = "optional"
        },
        innervates = {
          id = 8,
          type = "int32",
          label = "optional"
        },
        power_infusions = {
          id = 9,
          type = "int32",
          label = "optional"
        },
        inspiration_uptime = {
          id = 10,
          type = "double",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "blessing_of_kings",
        "blessing_of_salvation",
        "blessing_of_sanctuary",
        "blessing_of_wisdom",
        "blessing_of_might",
        "shadow_priest_dps",
        "unleashed_rage",
        "innervates",
        "power_infusions",
        "inspiration_uptime"
      }
    },
    Debuffs = {
      fields = {
        judgement_of_wisdom = {
          id = 1,
          type = "bool",
          label = "optional"
        },
        judgement_of_light = {
          id = 2,
          type = "bool",
          label = "optional"
        },
        improved_seal_of_the_crusader = {
          id = 3,
          type = "bool",
          label = "optional"
        },
        misery = {
          id = 4,
          type = "bool",
          label = "optional"
        },
        curse_of_elements = {
          id = 5,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 1490,
              label = "Curse Of Elements",
              flags = "SpellFlagAPL",
              class_spell_mask = "WarlockSpellCurseOfElements",
              spell_school = "SpellSchoolShadow",
              proc_mask = "2",
              threat_multiplier = "1",
              class_token = "warlock"
            }
          }
        },
        isb_uptime = {
          id = 6,
          type = "double",
          label = "optional"
        },
        shadow_weaving = {
          id = 7,
          type = "bool",
          label = "optional"
        },
        improved_scorch = {
          id = 8,
          type = "bool",
          label = "optional"
        },
        winters_chill = {
          id = 9,
          type = "bool",
          label = "optional"
        },
        blood_frenzy = {
          id = 10,
          type = "bool",
          label = "optional"
        },
        gift_of_arthas = {
          id = 11,
          type = "bool",
          label = "optional"
        },
        mangle = {
          id = 12,
          type = "bool",
          label = "optional"
        },
        expose_armor = {
          id = 13,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 8647,
              label = "Expose Armor",
              flags = "core.SpellFlagMeleeMetrics | SpellFlagBuilder | core.SpellFlagAPL",
              class_spell_mask = "RogueSpellExposeArmor",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              threat_multiplier = "1",
              class_token = "rogue"
            }
          }
        },
        faerie_fire = {
          id = 14,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 770,
              label = "Faerie Fire",
              flags = "core.SpellFlagAPL",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "druid.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "druid"
            }
          }
        },
        sunder_armor = {
          id = 15,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 7386,
              label = "Sunder Armor",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              class_spell_mask = "SpellMaskSunderArmor",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              threat_multiplier = "1",
              max_range = "5",
              class_token = "warrior"
            }
          }
        },
        curse_of_recklessness = {
          id = 16,
          type = "bool",
          label = "optional"
        },
        hunters_mark = {
          id = 17,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            spell = {
              {
                class = "hunter",
                spell_id = 1130,
                label = "Hunters Mark",
                proc_mask = "2",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 1130,
                label = "Hunters Mark",
                proc_mask = "2",
                class_token = "hunter"
              }
            },
            aura = {
              class = "hunter",
              spell_id = 1130,
              label = "HuntersMark",
              duration = {
                raw = "5 * time.Minute",
                seconds = 300.0
              },
              class_token = "hunter"
            }
          }
        },
        expose_weakness_uptime = {
          id = 18,
          type = "double",
          label = "optional"
        },
        expose_weakness_hunter_agility = {
          id = 19,
          type = "double",
          label = "optional"
        },
        demoralizing_roar = {
          id = 20,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect"
        },
        demoralizing_shout = {
          id = 21,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            spell = {
              class = "warrior",
              spec = "protection",
              spell_id = 1160,
              label = "Demoralizing Shout",
              cooldown = {
                raw = "time.Minute * 1",
                seconds = 60.0
              },
              major_cooldown = {
                type = "core.CooldownTypeSurvival"
              },
              flags = "core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
              class_spell_mask = "SpellMaskDemoralizingShout",
              spell_school = "2",
              proc_mask = "2",
              class_token = "warrior",
              spec_token = "protection"
            },
            aura = {
              class = "warrior",
              spec = "protection",
              spell_id = 1160,
              label = "Demoralizing Shout",
              duration = {
                raw = "10 * time.Second",
                seconds = 10.0
              },
              class_token = "warrior",
              spec_token = "protection"
            }
          }
        },
        thunder_clap = {
          id = 22,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 6343,
              label = "Thunder Clap",
              cooldown = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              flags = "core.SpellFlagAoE | core.SpellFlagAPL",
              class_spell_mask = "SpellMaskThunderClap",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              crit_multiplier = "war.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "warrior"
            }
          }
        },
        insect_swarm = {
          id = 23,
          type = "bool",
          label = "optional"
        },
        scorpid_sting = {
          id = 24,
          type = "bool",
          label = "optional"
        },
        shadow_embrace = {
          id = 25,
          type = "bool",
          label = "optional"
        },
        screech = {
          id = 26,
          type = "bool",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "judgement_of_wisdom",
        "judgement_of_light",
        "improved_seal_of_the_crusader",
        "misery",
        "curse_of_elements",
        "isb_uptime",
        "shadow_weaving",
        "improved_scorch",
        "winters_chill",
        "blood_frenzy",
        "gift_of_arthas",
        "mangle",
        "expose_armor",
        "faerie_fire",
        "sunder_armor",
        "curse_of_recklessness",
        "hunters_mark",
        "expose_weakness_uptime",
        "expose_weakness_hunter_agility",
        "demoralizing_roar",
        "demoralizing_shout",
        "thunder_clap",
        "insect_swarm",
        "scorpid_sting",
        "shadow_embrace",
        "screech"
      }
    },
    ConsumesSpec = {
      fields = {
        prepot_id = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        pot_id = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        flask_id = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        battle_elixir_id = {
          id = 4,
          type = "int32",
          label = "optional"
        },
        guardian_elixir_id = {
          id = 5,
          type = "int32",
          label = "optional"
        },
        food_id = {
          id = 6,
          type = "int32",
          label = "optional"
        },
        explosive_id = {
          id = 7,
          type = "int32",
          label = "optional",
          _metadata = {
            export = "ExplosiveBigDaddy",
            field_alias = "explosiveId",
            ids = {
              item = {
                63396
              }
            },
            value = "89637",
            show_when = "(player: Player<any>) => player.hasProfession(Profession.Engineering)"
          }
        },
        conjured_id = {
          id = 9,
          type = "int32",
          label = "optional",
          _metadata = {
            export = "ConjuredDarkRune",
            field_alias = "conjuredId",
            ids = {
              item = {
                12662
              }
            },
            value = "12662",
            show_when = "<SpecType extends Spec>(player: Player<SpecType>) => player.getClass() == Class.ClassRogue"
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "prepot_id",
        "pot_id",
        "flask_id",
        "battle_elixir_id",
        "guardian_elixir_id",
        "food_id",
        "explosive_id",
        "conjured_id"
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
          id = 14,
          type = "int32",
          label = "optional"
        },
        name = {
          id = 15,
          type = "string",
          label = "optional"
        },
        level = {
          id = 4,
          type = "int32",
          label = "optional"
        },
        mob_type = {
          id = 3,
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
          id = 7,
          type = "double",
          label = "optional"
        },
        damage_spread = {
          id = 19,
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
          id = 12,
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
        suppress_dodge = {
          id = 16,
          type = "bool",
          label = "optional"
        },
        spell_school = {
          id = 13,
          type = "enum",
          label = "optional",
          enum_type = "SpellSchool"
        },
        tank_index = {
          id = 6,
          type = "int32",
          label = "optional"
        },
        second_tank_index = {
          id = 100,
          type = "int32",
          label = "optional"
        },
        disabled_at_start = {
          id = 101,
          type = "bool",
          label = "optional"
        },
        target_inputs = {
          id = 18,
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
        "suppress_dodge",
        "spell_school",
        "tank_index",
        "second_tank_index",
        "disabled_at_start",
        "target_inputs"
      }
    },
    Encounter = {
      fields = {
        api_version = {
          id = 9,
          type = "int32",
          label = "optional"
        },
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
        execute_proportion_45 = {
          id = 10,
          type = "double",
          label = "optional"
        },
        execute_proportion_90 = {
          id = 8,
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
        "api_version",
        "duration",
        "duration_variation",
        "execute_proportion_20",
        "execute_proportion_25",
        "execute_proportion_35",
        "execute_proportion_45",
        "execute_proportion_90",
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
          id = 1,
          type = "int32",
          label = "optional"
        },
        random_suffix = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        enchant = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        gems = {
          id = 4,
          type = "int32",
          label = "repeated"
        }
      },
      oneofs = {

      },
      field_order = {
        "id",
        "random_suffix",
        "enchant",
        "gems"
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
        "tag"
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
          id = 4,
          type = "double",
          label = "optional"
        },
        absorb_frac = {
          id = 5,
          type = "double",
          label = "optional"
        },
        burst_window = {
          id = 3,
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
        "absorb_frac",
        "burst_window"
      }
    },
    CustomRotation = {
      fields = {
        spells = {
          id = 1,
          type = "message",
          label = "repeated",
          message_type = "CustomSpell"
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
        items = {
          id = 1,
          type = "message",
          label = "repeated",
          message_type = "ItemSpec"
        },
        prepull_bonus_stats = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "UnitStats"
        }
      },
      oneofs = {

      },
      field_order = {
        "items",
        "prepull_bonus_stats"
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
    UUID = {
      fields = {
        value = {
          id = 1,
          type = "string",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "value"
      }
    },
    FileDescriptorSet = {
      fields = {
        file = {
          id = 1,
          type = "message",
          label = "repeated",
          message_type = "FileDescriptorProto"
        }
      },
      oneofs = {

      },
      field_order = {
        "file"
      }
    },
    FileDescriptorProto = {
      fields = {
        name = {
          id = 1,
          type = "string",
          label = "optional"
        },
        package = {
          id = 2,
          type = "string",
          label = "optional"
        },
        dependency = {
          id = 3,
          type = "string",
          label = "repeated"
        },
        public_dependency = {
          id = 10,
          type = "int32",
          label = "repeated"
        },
        weak_dependency = {
          id = 11,
          type = "int32",
          label = "repeated"
        },
        option_dependency = {
          id = 15,
          type = "string",
          label = "repeated"
        },
        message_type = {
          id = 4,
          type = "message",
          label = "repeated",
          message_type = "DescriptorProto"
        },
        enum_type = {
          id = 5,
          type = "message",
          label = "repeated",
          message_type = "EnumDescriptorProto"
        },
        service = {
          id = 6,
          type = "message",
          label = "repeated",
          message_type = "ServiceDescriptorProto"
        },
        extension = {
          id = 7,
          type = "message",
          label = "repeated",
          message_type = "FieldDescriptorProto"
        },
        options = {
          id = 8,
          type = "message",
          label = "optional",
          message_type = "FileOptions"
        },
        source_code_info = {
          id = 9,
          type = "message",
          label = "optional",
          message_type = "SourceCodeInfo"
        },
        syntax = {
          id = 12,
          type = "string",
          label = "optional"
        },
        edition = {
          id = 14,
          type = "enum",
          label = "optional",
          enum_type = "Edition"
        }
      },
      oneofs = {

      },
      field_order = {
        "name",
        "package",
        "dependency",
        "public_dependency",
        "weak_dependency",
        "option_dependency",
        "message_type",
        "enum_type",
        "service",
        "extension",
        "options",
        "source_code_info",
        "syntax",
        "edition"
      }
    },
    ExtensionRange = {
      fields = {
        start = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        ["end"] = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        options = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "ExtensionRangeOptions"
        }
      },
      oneofs = {

      },
      field_order = {
        "start",
        "end",
        "options"
      }
    },
    ReservedRange = {
      fields = {
        start = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        ["end"] = {
          id = 2,
          type = "int32",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "start",
        "end"
      }
    },
    DescriptorProto = {
      fields = {
        name = {
          id = 1,
          type = "string",
          label = "optional"
        },
        field = {
          id = 2,
          type = "message",
          label = "repeated",
          message_type = "FieldDescriptorProto"
        },
        extension = {
          id = 6,
          type = "message",
          label = "repeated",
          message_type = "FieldDescriptorProto"
        },
        nested_type = {
          id = 3,
          type = "message",
          label = "repeated",
          message_type = "DescriptorProto"
        },
        enum_type = {
          id = 4,
          type = "message",
          label = "repeated",
          message_type = "EnumDescriptorProto"
        },
        extension_range = {
          id = 5,
          type = "message",
          label = "repeated",
          message_type = "ExtensionRange"
        },
        oneof_decl = {
          id = 8,
          type = "message",
          label = "repeated",
          message_type = "OneofDescriptorProto"
        },
        options = {
          id = 7,
          type = "message",
          label = "optional",
          message_type = "MessageOptions"
        },
        reserved_range = {
          id = 9,
          type = "message",
          label = "repeated",
          message_type = "ReservedRange"
        },
        reserved_name = {
          id = 10,
          type = "string",
          label = "repeated"
        },
        visibility = {
          id = 11,
          type = "enum",
          label = "optional",
          enum_type = "SymbolVisibility"
        }
      },
      oneofs = {

      },
      field_order = {
        "name",
        "field",
        "extension",
        "nested_type",
        "enum_type",
        "extension_range",
        "oneof_decl",
        "options",
        "reserved_range",
        "reserved_name",
        "visibility"
      }
    },
    Declaration = {
      fields = {
        number = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        full_name = {
          id = 2,
          type = "string",
          label = "optional"
        },
        type = {
          id = 3,
          type = "string",
          label = "optional"
        },
        reserved = {
          id = 5,
          type = "bool",
          label = "optional"
        },
        repeated = {
          id = 6,
          type = "bool",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "number",
        "full_name",
        "type",
        "reserved",
        "repeated"
      }
    },
    ExtensionRangeOptions = {
      fields = {
        uninterpreted_option = {
          id = 999,
          type = "message",
          label = "repeated",
          message_type = "UninterpretedOption"
        },
        declaration = {
          id = 2,
          type = "message",
          label = "repeated",
          message_type = "Declaration"
        },
        features = {
          id = 50,
          type = "message",
          label = "optional",
          message_type = "FeatureSet"
        },
        verification = {
          id = 3,
          type = "enum",
          label = "optional",
          enum_type = "VerificationState"
        }
      },
      oneofs = {

      },
      field_order = {
        "uninterpreted_option",
        "declaration",
        "features",
        "verification"
      }
    },
    FieldDescriptorProto = {
      fields = {
        name = {
          id = 1,
          type = "string",
          label = "optional"
        },
        number = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        label = {
          id = 4,
          type = "enum",
          label = "optional",
          enum_type = "Label"
        },
        type = {
          id = 5,
          type = "enum",
          label = "optional",
          enum_type = "Type"
        },
        type_name = {
          id = 6,
          type = "string",
          label = "optional"
        },
        extendee = {
          id = 2,
          type = "string",
          label = "optional"
        },
        default_value = {
          id = 7,
          type = "string",
          label = "optional"
        },
        oneof_index = {
          id = 9,
          type = "int32",
          label = "optional"
        },
        json_name = {
          id = 10,
          type = "string",
          label = "optional"
        },
        options = {
          id = 8,
          type = "message",
          label = "optional",
          message_type = "FieldOptions"
        },
        proto3_optional = {
          id = 17,
          type = "bool",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "name",
        "number",
        "label",
        "type",
        "type_name",
        "extendee",
        "default_value",
        "oneof_index",
        "json_name",
        "options",
        "proto3_optional"
      }
    },
    OneofDescriptorProto = {
      fields = {
        name = {
          id = 1,
          type = "string",
          label = "optional"
        },
        options = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "OneofOptions"
        }
      },
      oneofs = {

      },
      field_order = {
        "name",
        "options"
      }
    },
    EnumReservedRange = {
      fields = {
        start = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        ["end"] = {
          id = 2,
          type = "int32",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "start",
        "end"
      }
    },
    EnumDescriptorProto = {
      fields = {
        name = {
          id = 1,
          type = "string",
          label = "optional"
        },
        value = {
          id = 2,
          type = "message",
          label = "repeated",
          message_type = "EnumValueDescriptorProto"
        },
        options = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "EnumOptions"
        },
        reserved_range = {
          id = 4,
          type = "message",
          label = "repeated",
          message_type = "EnumReservedRange"
        },
        reserved_name = {
          id = 5,
          type = "string",
          label = "repeated"
        },
        visibility = {
          id = 6,
          type = "enum",
          label = "optional",
          enum_type = "SymbolVisibility"
        }
      },
      oneofs = {

      },
      field_order = {
        "name",
        "value",
        "options",
        "reserved_range",
        "reserved_name",
        "visibility"
      }
    },
    EnumValueDescriptorProto = {
      fields = {
        name = {
          id = 1,
          type = "string",
          label = "optional"
        },
        number = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        options = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "EnumValueOptions"
        }
      },
      oneofs = {

      },
      field_order = {
        "name",
        "number",
        "options"
      }
    },
    ServiceDescriptorProto = {
      fields = {
        name = {
          id = 1,
          type = "string",
          label = "optional"
        },
        method = {
          id = 2,
          type = "message",
          label = "repeated",
          message_type = "MethodDescriptorProto"
        },
        options = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "ServiceOptions"
        }
      },
      oneofs = {

      },
      field_order = {
        "name",
        "method",
        "options"
      }
    },
    MethodDescriptorProto = {
      fields = {
        name = {
          id = 1,
          type = "string",
          label = "optional"
        },
        input_type = {
          id = 2,
          type = "string",
          label = "optional"
        },
        output_type = {
          id = 3,
          type = "string",
          label = "optional"
        },
        options = {
          id = 4,
          type = "message",
          label = "optional",
          message_type = "MethodOptions"
        },
        client_streaming = {
          id = 5,
          type = "bool",
          label = "optional"
        },
        server_streaming = {
          id = 6,
          type = "bool",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "name",
        "input_type",
        "output_type",
        "options",
        "client_streaming",
        "server_streaming"
      }
    },
    FileOptions = {
      fields = {
        java_package = {
          id = 1,
          type = "string",
          label = "optional"
        },
        java_outer_classname = {
          id = 8,
          type = "string",
          label = "optional"
        },
        java_multiple_files = {
          id = 10,
          type = "bool",
          label = "optional"
        },
        java_generate_equals_and_hash = {
          id = 20,
          type = "bool",
          label = "optional"
        },
        java_string_check_utf8 = {
          id = 27,
          type = "bool",
          label = "optional"
        },
        optimize_for = {
          id = 9,
          type = "enum",
          label = "optional",
          enum_type = "OptimizeMode"
        },
        go_package = {
          id = 11,
          type = "string",
          label = "optional"
        },
        cc_generic_services = {
          id = 16,
          type = "bool",
          label = "optional"
        },
        java_generic_services = {
          id = 17,
          type = "bool",
          label = "optional"
        },
        py_generic_services = {
          id = 18,
          type = "bool",
          label = "optional"
        },
        deprecated = {
          id = 23,
          type = "bool",
          label = "optional"
        },
        cc_enable_arenas = {
          id = 31,
          type = "bool",
          label = "optional"
        },
        objc_class_prefix = {
          id = 36,
          type = "string",
          label = "optional"
        },
        csharp_namespace = {
          id = 37,
          type = "string",
          label = "optional"
        },
        swift_prefix = {
          id = 39,
          type = "string",
          label = "optional"
        },
        php_class_prefix = {
          id = 40,
          type = "string",
          label = "optional"
        },
        php_namespace = {
          id = 41,
          type = "string",
          label = "optional"
        },
        php_metadata_namespace = {
          id = 44,
          type = "string",
          label = "optional"
        },
        ruby_package = {
          id = 45,
          type = "string",
          label = "optional"
        },
        features = {
          id = 50,
          type = "message",
          label = "optional",
          message_type = "FeatureSet"
        },
        uninterpreted_option = {
          id = 999,
          type = "message",
          label = "repeated",
          message_type = "UninterpretedOption"
        }
      },
      oneofs = {

      },
      field_order = {
        "java_package",
        "java_outer_classname",
        "java_multiple_files",
        "java_generate_equals_and_hash",
        "java_string_check_utf8",
        "optimize_for",
        "go_package",
        "cc_generic_services",
        "java_generic_services",
        "py_generic_services",
        "deprecated",
        "cc_enable_arenas",
        "objc_class_prefix",
        "csharp_namespace",
        "swift_prefix",
        "php_class_prefix",
        "php_namespace",
        "php_metadata_namespace",
        "ruby_package",
        "features",
        "uninterpreted_option"
      }
    },
    MessageOptions = {
      fields = {
        message_set_wire_format = {
          id = 1,
          type = "bool",
          label = "optional"
        },
        no_standard_descriptor_accessor = {
          id = 2,
          type = "bool",
          label = "optional"
        },
        deprecated = {
          id = 3,
          type = "bool",
          label = "optional"
        },
        map_entry = {
          id = 7,
          type = "bool",
          label = "optional"
        },
        deprecated_legacy_json_field_conflicts = {
          id = 11,
          type = "bool",
          label = "optional"
        },
        features = {
          id = 12,
          type = "message",
          label = "optional",
          message_type = "FeatureSet"
        },
        uninterpreted_option = {
          id = 999,
          type = "message",
          label = "repeated",
          message_type = "UninterpretedOption"
        }
      },
      oneofs = {

      },
      field_order = {
        "message_set_wire_format",
        "no_standard_descriptor_accessor",
        "deprecated",
        "map_entry",
        "deprecated_legacy_json_field_conflicts",
        "features",
        "uninterpreted_option"
      }
    },
    EditionDefault = {
      fields = {
        edition = {
          id = 3,
          type = "enum",
          label = "optional",
          enum_type = "Edition"
        },
        value = {
          id = 2,
          type = "string",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "edition",
        "value"
      }
    },
    FeatureSupport = {
      fields = {
        edition_introduced = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "Edition"
        },
        edition_deprecated = {
          id = 2,
          type = "enum",
          label = "optional",
          enum_type = "Edition"
        },
        deprecation_warning = {
          id = 3,
          type = "string",
          label = "optional"
        },
        edition_removed = {
          id = 4,
          type = "enum",
          label = "optional",
          enum_type = "Edition"
        }
      },
      oneofs = {

      },
      field_order = {
        "edition_introduced",
        "edition_deprecated",
        "deprecation_warning",
        "edition_removed"
      }
    },
    FieldOptions = {
      fields = {
        ctype = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "CType"
        },
        packed = {
          id = 2,
          type = "bool",
          label = "optional"
        },
        jstype = {
          id = 6,
          type = "enum",
          label = "optional",
          enum_type = "JSType"
        },
        lazy = {
          id = 5,
          type = "bool",
          label = "optional"
        },
        unverified_lazy = {
          id = 15,
          type = "bool",
          label = "optional"
        },
        deprecated = {
          id = 3,
          type = "bool",
          label = "optional"
        },
        weak = {
          id = 10,
          type = "bool",
          label = "optional"
        },
        debug_redact = {
          id = 16,
          type = "bool",
          label = "optional"
        },
        retention = {
          id = 17,
          type = "enum",
          label = "optional",
          enum_type = "OptionRetention"
        },
        targets = {
          id = 19,
          type = "enum",
          label = "repeated",
          enum_type = "OptionTargetType"
        },
        edition_defaults = {
          id = 20,
          type = "message",
          label = "repeated",
          message_type = "EditionDefault"
        },
        features = {
          id = 21,
          type = "message",
          label = "optional",
          message_type = "FeatureSet"
        },
        feature_support = {
          id = 22,
          type = "message",
          label = "optional",
          message_type = "FeatureSupport"
        },
        uninterpreted_option = {
          id = 999,
          type = "message",
          label = "repeated",
          message_type = "UninterpretedOption"
        }
      },
      oneofs = {

      },
      field_order = {
        "ctype",
        "packed",
        "jstype",
        "lazy",
        "unverified_lazy",
        "deprecated",
        "weak",
        "debug_redact",
        "retention",
        "targets",
        "edition_defaults",
        "features",
        "feature_support",
        "uninterpreted_option"
      }
    },
    OneofOptions = {
      fields = {
        features = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "FeatureSet"
        },
        uninterpreted_option = {
          id = 999,
          type = "message",
          label = "repeated",
          message_type = "UninterpretedOption"
        }
      },
      oneofs = {

      },
      field_order = {
        "features",
        "uninterpreted_option"
      }
    },
    EnumOptions = {
      fields = {
        allow_alias = {
          id = 2,
          type = "bool",
          label = "optional"
        },
        deprecated = {
          id = 3,
          type = "bool",
          label = "optional"
        },
        deprecated_legacy_json_field_conflicts = {
          id = 6,
          type = "bool",
          label = "optional"
        },
        features = {
          id = 7,
          type = "message",
          label = "optional",
          message_type = "FeatureSet"
        },
        uninterpreted_option = {
          id = 999,
          type = "message",
          label = "repeated",
          message_type = "UninterpretedOption"
        }
      },
      oneofs = {

      },
      field_order = {
        "allow_alias",
        "deprecated",
        "deprecated_legacy_json_field_conflicts",
        "features",
        "uninterpreted_option"
      }
    },
    EnumValueOptions = {
      fields = {
        deprecated = {
          id = 1,
          type = "bool",
          label = "optional"
        },
        features = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "FeatureSet"
        },
        debug_redact = {
          id = 3,
          type = "bool",
          label = "optional"
        },
        feature_support = {
          id = 4,
          type = "message",
          label = "optional",
          message_type = "FeatureSupport"
        },
        uninterpreted_option = {
          id = 999,
          type = "message",
          label = "repeated",
          message_type = "UninterpretedOption"
        }
      },
      oneofs = {

      },
      field_order = {
        "deprecated",
        "features",
        "debug_redact",
        "feature_support",
        "uninterpreted_option"
      }
    },
    ServiceOptions = {
      fields = {
        features = {
          id = 34,
          type = "message",
          label = "optional",
          message_type = "FeatureSet"
        },
        deprecated = {
          id = 33,
          type = "bool",
          label = "optional"
        },
        uninterpreted_option = {
          id = 999,
          type = "message",
          label = "repeated",
          message_type = "UninterpretedOption"
        }
      },
      oneofs = {

      },
      field_order = {
        "features",
        "deprecated",
        "uninterpreted_option"
      }
    },
    MethodOptions = {
      fields = {
        deprecated = {
          id = 33,
          type = "bool",
          label = "optional"
        },
        idempotency_level = {
          id = 34,
          type = "enum",
          label = "optional",
          enum_type = "IdempotencyLevel"
        },
        features = {
          id = 35,
          type = "message",
          label = "optional",
          message_type = "FeatureSet"
        },
        uninterpreted_option = {
          id = 999,
          type = "message",
          label = "repeated",
          message_type = "UninterpretedOption"
        }
      },
      oneofs = {

      },
      field_order = {
        "deprecated",
        "idempotency_level",
        "features",
        "uninterpreted_option"
      }
    },
    NamePart = {
      fields = {
        name_part = {
          id = 1,
          type = "string",
          label = "required"
        },
        is_extension = {
          id = 2,
          type = "bool",
          label = "required"
        }
      },
      oneofs = {

      },
      field_order = {
        "name_part",
        "is_extension"
      }
    },
    UninterpretedOption = {
      fields = {
        name = {
          id = 2,
          type = "message",
          label = "repeated",
          message_type = "NamePart"
        },
        identifier_value = {
          id = 3,
          type = "string",
          label = "optional"
        },
        positive_int_value = {
          id = 4,
          type = "uint64",
          label = "optional"
        },
        negative_int_value = {
          id = 5,
          type = "int64",
          label = "optional"
        },
        double_value = {
          id = 6,
          type = "double",
          label = "optional"
        },
        string_value = {
          id = 7,
          type = "bytes",
          label = "optional"
        },
        aggregate_value = {
          id = 8,
          type = "string",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "name",
        "identifier_value",
        "positive_int_value",
        "negative_int_value",
        "double_value",
        "string_value",
        "aggregate_value"
      }
    },
    VisibilityFeature = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      }
    },
    FeatureSet = {
      fields = {
        field_presence = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "FieldPresence"
        },
        enum_type = {
          id = 2,
          type = "enum",
          label = "optional",
          enum_type = "EnumType"
        },
        repeated_field_encoding = {
          id = 3,
          type = "enum",
          label = "optional",
          enum_type = "RepeatedFieldEncoding"
        },
        utf8_validation = {
          id = 4,
          type = "enum",
          label = "optional",
          enum_type = "Utf8Validation"
        },
        message_encoding = {
          id = 5,
          type = "enum",
          label = "optional",
          enum_type = "MessageEncoding"
        },
        json_format = {
          id = 6,
          type = "enum",
          label = "optional",
          enum_type = "JsonFormat"
        },
        enforce_naming_style = {
          id = 7,
          type = "enum",
          label = "optional",
          enum_type = "EnforceNamingStyle"
        },
        default_symbol_visibility = {
          id = 8,
          type = "enum",
          label = "optional",
          enum_type = "DefaultSymbolVisibility"
        }
      },
      oneofs = {

      },
      field_order = {
        "field_presence",
        "enum_type",
        "repeated_field_encoding",
        "utf8_validation",
        "message_encoding",
        "json_format",
        "enforce_naming_style",
        "default_symbol_visibility"
      }
    },
    FeatureSetEditionDefault = {
      fields = {
        edition = {
          id = 3,
          type = "enum",
          label = "optional",
          enum_type = "Edition"
        },
        overridable_features = {
          id = 4,
          type = "message",
          label = "optional",
          message_type = "FeatureSet"
        },
        fixed_features = {
          id = 5,
          type = "message",
          label = "optional",
          message_type = "FeatureSet"
        }
      },
      oneofs = {

      },
      field_order = {
        "edition",
        "overridable_features",
        "fixed_features"
      }
    },
    FeatureSetDefaults = {
      fields = {
        defaults = {
          id = 1,
          type = "message",
          label = "repeated",
          message_type = "FeatureSetEditionDefault"
        },
        minimum_edition = {
          id = 4,
          type = "enum",
          label = "optional",
          enum_type = "Edition"
        },
        maximum_edition = {
          id = 5,
          type = "enum",
          label = "optional",
          enum_type = "Edition"
        }
      },
      oneofs = {

      },
      field_order = {
        "defaults",
        "minimum_edition",
        "maximum_edition"
      }
    },
    Location = {
      fields = {
        path = {
          id = 1,
          type = "int32",
          label = "repeated"
        },
        span = {
          id = 2,
          type = "int32",
          label = "repeated"
        },
        leading_comments = {
          id = 3,
          type = "string",
          label = "optional"
        },
        trailing_comments = {
          id = 4,
          type = "string",
          label = "optional"
        },
        leading_detached_comments = {
          id = 6,
          type = "string",
          label = "repeated"
        }
      },
      oneofs = {

      },
      field_order = {
        "path",
        "span",
        "leading_comments",
        "trailing_comments",
        "leading_detached_comments"
      }
    },
    SourceCodeInfo = {
      fields = {
        location = {
          id = 1,
          type = "message",
          label = "repeated",
          message_type = "Location"
        }
      },
      oneofs = {

      },
      field_order = {
        "location"
      }
    },
    Annotation = {
      fields = {
        path = {
          id = 1,
          type = "int32",
          label = "repeated"
        },
        source_file = {
          id = 2,
          type = "string",
          label = "optional"
        },
        begin = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        ["end"] = {
          id = 4,
          type = "int32",
          label = "optional"
        },
        semantic = {
          id = 5,
          type = "enum",
          label = "optional",
          enum_type = "Semantic"
        }
      },
      oneofs = {

      },
      field_order = {
        "path",
        "source_file",
        "begin",
        "end",
        "semantic"
      }
    },
    GeneratedCodeInfo = {
      fields = {
        annotation = {
          id = 1,
          type = "message",
          label = "repeated",
          message_type = "Annotation"
        }
      },
      oneofs = {

      },
      field_order = {
        "annotation"
      }
    },
    ScalingItemEffectProperties = {
      fields = {
        stats = {
          id = 1,
          type = "message",
          label = "repeated",
          message_type = "StatsEntry"
        }
      },
      oneofs = {

      },
      field_order = {
        "stats"
      }
    },
    ScalingOptionsEntry = {
      fields = {
        key = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        value = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "ScalingItemEffectProperties"
        }
      },
      oneofs = {

      },
      field_order = {
        "key",
        "value"
      }
    },
    ItemEffect = {
      fields = {
        buff_id = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        buff_name = {
          id = 6,
          type = "string",
          label = "optional"
        },
        effect_duration_ms = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        scaling_options = {
          id = 3,
          type = "message",
          label = "repeated",
          message_type = "ScalingOptionsEntry"
        },
        proc = {
          id = 4,
          type = "message",
          label = "optional",
          message_type = "ProcEffect"
        },
        on_use = {
          id = 5,
          type = "message",
          label = "optional",
          message_type = "OnUseEffect"
        }
      },
      oneofs = {
        effect = {
          "proc",
          "on_use"
        }
      },
      field_order = {
        "buff_id",
        "buff_name",
        "effect_duration_ms",
        "scaling_options",
        "proc",
        "on_use"
      }
    },
    ProcEffect = {
      fields = {
        icd_ms = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        proc_chance = {
          id = 2,
          type = "double",
          label = "optional"
        },
        ppm = {
          id = 3,
          type = "double",
          label = "optional"
        }
      },
      oneofs = {
        procRate = {
          "proc_chance",
          "ppm"
        }
      },
      field_order = {
        "icd_ms",
        "proc_chance",
        "ppm"
      }
    },
    OnUseEffect = {
      fields = {
        cooldown_ms = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        category_id = {
          id = 11,
          type = "int32",
          label = "optional"
        },
        category_cooldown_ms = {
          id = 8,
          type = "int32",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "cooldown_ms",
        "category_id",
        "category_cooldown_ms"
      }
    },
    SpellEffect = {
      fields = {
        id = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        spell_id = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        index = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        type = {
          id = 4,
          type = "enum",
          label = "optional",
          enum_type = "EffectType"
        },
        min_effect_size = {
          id = 5,
          type = "double",
          label = "optional"
        },
        effect_spread = {
          id = 6,
          type = "double",
          label = "optional"
        },
        resource_type = {
          id = 7,
          type = "enum",
          label = "optional",
          enum_type = "ResourceType"
        },
        school = {
          id = 8,
          type = "enum",
          label = "optional",
          enum_type = "SpellSchool"
        },
        stat = {
          id = 9,
          type = "enum",
          label = "optional",
          enum_type = "Stat"
        }
      },
      oneofs = {
        misc_value0 = {
          "resource_type",
          "school",
          "stat"
        }
      },
      field_order = {
        "id",
        "spell_id",
        "index",
        "type",
        "min_effect_size",
        "effect_spread",
        "resource_type",
        "school",
        "stat"
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
        },
        groups = {
          id = 5,
          type = "message",
          label = "repeated",
          message_type = "APLGroup"
        },
        value_variables = {
          id = 6,
          type = "message",
          label = "repeated",
          message_type = "APLValueVariable"
        }
      },
      oneofs = {

      },
      field_order = {
        "type",
        "simple",
        "prepull_actions",
        "priority_list",
        "groups",
        "value_variables"
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
    APLGroup = {
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
          message_type = "APLListItem"
        },
        variables = {
          id = 3,
          type = "message",
          label = "repeated",
          message_type = "APLValueVariable"
        }
      },
      oneofs = {

      },
      field_order = {
        "name",
        "actions",
        "variables"
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
        cast_friendly_spell = {
          id = 20,
          type = "message",
          label = "optional",
          message_type = "APLActionCastFriendlySpell",
          _metadata = {
            export = "cast_friendly_spell"
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
        strict_multidot = {
          id = 26,
          type = "message",
          label = "optional",
          message_type = "APLActionStrictMultidot",
          _metadata = {
            export = "strict_multidot"
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
        cast_all_stat_buff_cooldowns = {
          id = 23,
          type = "message",
          label = "optional",
          message_type = "APLActionCastAllStatBuffCooldowns",
          _metadata = {
            export = "cast_all_stat_buff_cooldowns"
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
          id = 24,
          type = "message",
          label = "optional",
          message_type = "APLActionActivateAuraWithStacks",
          _metadata = {
            export = "activate_aura_with_stacks"
          }
        },
        activate_all_stat_buff_proc_auras = {
          id = 25,
          type = "message",
          label = "optional",
          message_type = "APLActionActivateAllStatBuffProcAuras",
          _metadata = {
            export = "activate_all_stat_buff_proc_auras"
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
          id = 21,
          type = "message",
          label = "optional",
          message_type = "APLActionMove",
          _metadata = {
            export = "move"
          }
        },
        move_duration = {
          id = 22,
          type = "message",
          label = "optional",
          message_type = "APLActionMoveDuration",
          _metadata = {
            export = "move_duration"
          }
        },
        cat_optimal_rotation_action = {
          id = 18,
          type = "message",
          label = "optional",
          message_type = "APLActionCatOptimalRotationAction"
        },
        guardian_hotw_dps_rotation = {
          id = 27,
          type = "message",
          label = "optional",
          message_type = "APLActionGuardianHotwDpsRotation"
        },
        warlock_next_exhale_target = {
          id = 29,
          type = "message",
          label = "optional",
          message_type = "APLActionWarlockNextExhaleTarget"
        },
        custom_rotation = {
          id = 19,
          type = "message",
          label = "optional",
          message_type = "APLActionCustomRotation",
          _metadata = {
            export = "custom_rotation"
          }
        },
        group_reference = {
          id = 28,
          type = "message",
          label = "optional",
          message_type = "APLActionGroupReference",
          _metadata = {
            export = "group_reference"
          }
        }
      },
      oneofs = {
        action = {
          "cast_spell",
          "cast_friendly_spell",
          "channel_spell",
          "multidot",
          "strict_multidot",
          "multishield",
          "cast_all_stat_buff_cooldowns",
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
          "activate_all_stat_buff_proc_auras",
          "cancel_aura",
          "trigger_icd",
          "item_swap",
          "move",
          "move_duration",
          "cat_optimal_rotation_action",
          "guardian_hotw_dps_rotation",
          "warlock_next_exhale_target",
          "custom_rotation",
          "group_reference"
        }
      },
      field_order = {
        "condition",
        "cast_spell",
        "cast_friendly_spell",
        "channel_spell",
        "multidot",
        "strict_multidot",
        "multishield",
        "cast_all_stat_buff_cooldowns",
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
        "activate_all_stat_buff_proc_auras",
        "cancel_aura",
        "trigger_icd",
        "item_swap",
        "move",
        "move_duration",
        "cat_optimal_rotation_action",
        "guardian_hotw_dps_rotation",
        "warlock_next_exhale_target",
        "custom_rotation",
        "group_reference"
      }
    },
    APLValue = {
      fields = {
        uuid = {
          id = 85,
          type = "message",
          label = "optional",
          message_type = "UUID"
        },
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
        boss_spell_time_to_ready = {
          id = 64,
          type = "message",
          label = "optional",
          message_type = "APLValueBossSpellTimeToReady",
          _metadata = {
            export = "boss_spell_time_to_ready"
          }
        },
        boss_spell_is_casting = {
          id = 65,
          type = "message",
          label = "optional",
          message_type = "APLValueBossSpellIsCasting",
          _metadata = {
            export = "boss_spell_is_casting"
          }
        },
        boss_current_target = {
          id = 120,
          type = "message",
          label = "optional",
          message_type = "APLValueBossCurrentTarget",
          _metadata = {
            export = "boss_current_target"
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
        current_focus = {
          id = 66,
          type = "message",
          label = "optional",
          message_type = "APLValueCurrentFocus",
          _metadata = {
            export = "current_focus"
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
        current_solar_energy = {
          id = 68,
          type = "message",
          label = "optional",
          message_type = "APLValueCurrentSolarEnergy",
          _metadata = {
            export = "current_solar_energy"
          }
        },
        current_lunar_energy = {
          id = 69,
          type = "message",
          label = "optional",
          message_type = "APLValueCurrentLunarEnergy",
          _metadata = {
            export = "current_lunar_energy"
          }
        },
        current_generic_resource = {
          id = 75,
          type = "message",
          label = "optional",
          message_type = "APLValueCurrentGenericResource",
          _metadata = {
            export = "current_generic_resource",
            extras = {
              dynamic_string_resolver = "(value: string, player: Player<any>) => ''"
            }
          }
        },
        max_health = {
          id = 98,
          type = "message",
          label = "optional",
          message_type = "APLValueMaxHealth",
          _metadata = {
            export = "max_health"
          }
        },
        max_combo_points = {
          id = 93,
          type = "message",
          label = "optional",
          message_type = "APLValueMaxComboPoints",
          _metadata = {
            export = "max_combo_points"
          }
        },
        max_energy = {
          id = 87,
          type = "message",
          label = "optional",
          message_type = "APLValueMaxEnergy",
          _metadata = {
            export = "max_energy"
          }
        },
        max_focus = {
          id = 88,
          type = "message",
          label = "optional",
          message_type = "APLValueMaxFocus",
          _metadata = {
            export = "max_focus"
          }
        },
        max_rage = {
          id = 102,
          type = "message",
          label = "optional",
          message_type = "APLValueMaxRage",
          _metadata = {
            export = "max_rage"
          }
        },
        energy_regen_per_second = {
          id = 89,
          type = "message",
          label = "optional",
          message_type = "APLValueEnergyRegenPerSecond",
          _metadata = {
            export = "energy_regen_per_second"
          }
        },
        focus_regen_per_second = {
          id = 90,
          type = "message",
          label = "optional",
          message_type = "APLValueFocusRegenPerSecond",
          _metadata = {
            export = "focus_regen_per_second"
          }
        },
        energy_time_to_target = {
          id = 91,
          type = "message",
          label = "optional",
          message_type = "APLValueEnergyTimeToTarget",
          _metadata = {
            export = "energy_time_to_target"
          }
        },
        focus_time_to_target = {
          id = 92,
          type = "message",
          label = "optional",
          message_type = "APLValueFocusTimeToTarget",
          _metadata = {
            export = "focus_time_to_target"
          }
        },
        unit_is_moving = {
          id = 72,
          type = "message",
          label = "optional",
          message_type = "APLValueUnitIsMoving",
          _metadata = {
            export = "unit_is_moving"
          }
        },
        unit_distance = {
          id = 105,
          type = "message",
          label = "optional",
          message_type = "APLValueUnitDistance",
          _metadata = {
            export = "unit_distance"
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
        spell_is_known = {
          id = 74,
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
        spell_num_charges = {
          id = 96,
          type = "message",
          label = "optional",
          message_type = "APLValueSpellNumCharges",
          _metadata = {
            export = "spell_num_charges"
          }
        },
        spell_time_to_charge = {
          id = 97,
          type = "message",
          label = "optional",
          message_type = "APLValueSpellTimeToCharge",
          _metadata = {
            export = "spell_time_to_charge"
          }
        },
        spell_gcd_hasted_duration = {
          id = 115,
          type = "message",
          label = "optional",
          message_type = "APLValueSpellGCDHastedDuration",
          _metadata = {
            export = "spell_gcd_hasted_duration"
          }
        },
        spell_full_cooldown = {
          id = 116,
          type = "message",
          label = "optional",
          message_type = "APLValueSpellFullCooldown",
          _metadata = {
            export = "spell_full_cooldown"
          }
        },
        spell_in_flight = {
          id = 118,
          type = "message",
          label = "optional",
          message_type = "APLValueSpellInFlight",
          _metadata = {
            export = "spell_in_flight"
          }
        },
        aura_is_known = {
          id = 73,
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
          message_type = "APLValueAuraIsActive",
          _metadata = {
            export = "aura_is_active_with_reaction_time"
          }
        },
        aura_is_inactive = {
          id = 107,
          type = "message",
          label = "optional",
          message_type = "APLValueAuraIsInactive",
          _metadata = {
            export = "aura_is_inactive"
          }
        },
        aura_is_inactive_with_reaction_time = {
          id = 76,
          type = "message",
          label = "optional",
          message_type = "APLValueAuraIsInactive",
          _metadata = {
            export = "aura_is_inactive_with_reaction_time"
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
        aura_icd_is_ready = {
          id = 108,
          type = "message",
          label = "optional",
          message_type = "APLValueAuraICDIsReady",
          _metadata = {
            export = "aura_icd_is_ready"
          }
        },
        aura_icd_is_ready_with_reaction_time = {
          id = 51,
          type = "message",
          label = "optional",
          message_type = "APLValueAuraICDIsReady",
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
        all_trinket_stat_procs_active = {
          id = 78,
          type = "message",
          label = "optional",
          message_type = "APLValueAllTrinketStatProcsActive",
          _metadata = {
            export = "all_trinket_stat_procs_active"
          }
        },
        any_trinket_stat_procs_active = {
          id = 79,
          type = "message",
          label = "optional",
          message_type = "APLValueAnyTrinketStatProcsActive",
          _metadata = {
            export = "any_trinket_stat_procs_active"
          }
        },
        any_trinket_stat_procs_available = {
          id = 121,
          type = "message",
          label = "optional",
          message_type = "APLValueAnyTrinketStatProcsAvailable",
          _metadata = {
            export = "any_trinket_stat_procs_available"
          }
        },
        trinket_procs_min_remaining_time = {
          id = 80,
          type = "message",
          label = "optional",
          message_type = "APLValueTrinketProcsMinRemainingTime",
          _metadata = {
            export = "trinket_procs_min_remaining_time"
          }
        },
        trinket_procs_max_remaining_icd = {
          id = 82,
          type = "message",
          label = "optional",
          message_type = "APLValueTrinketProcsMaxRemainingICD",
          _metadata = {
            export = "trinket_procs_max_remaining_icd"
          }
        },
        num_equipped_stat_proc_trinkets = {
          id = 81,
          type = "message",
          label = "optional",
          message_type = "APLValueNumEquippedStatProcTrinkets",
          _metadata = {
            export = "num_equipped_stat_proc_trinkets"
          }
        },
        num_stat_buff_cooldowns = {
          id = 84,
          type = "message",
          label = "optional",
          message_type = "APLValueNumStatBuffCooldowns",
          _metadata = {
            export = "num_stat_buff_cooldowns"
          }
        },
        any_stat_buff_cooldowns_active = {
          id = 106,
          type = "message",
          label = "optional",
          message_type = "APLValueAnyStatBuffCooldownsActive",
          _metadata = {
            export = "any_stat_buff_cooldowns_active"
          }
        },
        any_stat_buff_cooldowns_min_duration = {
          id = 122,
          type = "message",
          label = "optional",
          message_type = "APLValueAnyStatBuffCooldownsMinDuration",
          _metadata = {
            export = "any_stat_buff_cooldowns_min_duration"
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
        dot_is_active_on_all_targets = {
          id = 103,
          type = "message",
          label = "optional",
          message_type = "APLValueDotIsActiveOnAllTargets",
          _metadata = {
            export = "dot_is_active_on_all_targets"
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
        dot_lowest_remaining_time = {
          id = 104,
          type = "message",
          label = "optional",
          message_type = "APLValueDotLowestRemainingTime",
          _metadata = {
            export = "dot_lowest_remaining_time"
          }
        },
        dot_tick_frequency = {
          id = 67,
          type = "message",
          label = "optional",
          message_type = "APLValueDotTickFrequency",
          _metadata = {
            export = "dot_tick_frequency"
          }
        },
        dot_time_to_next_tick = {
          id = 117,
          type = "message",
          label = "optional",
          message_type = "APLValueDotTimeToNextTick",
          _metadata = {
            export = "dot_time_to_next_tick"
          }
        },
        dot_base_duration = {
          id = 114,
          type = "message",
          label = "optional",
          message_type = "APLValueDotBaseDuration",
          _metadata = {
            export = "dot_base_duration"
          }
        },
        dot_percent_increase = {
          id = 101,
          type = "message",
          label = "optional",
          message_type = "APLValueDotPercentIncrease",
          _metadata = {
            export = "dot_percent_increase"
          }
        },
        dot_crit_percent_increase = {
          id = 109,
          type = "message",
          label = "optional",
          message_type = "APLValueDotPercentIncrease",
          _metadata = {
            export = "dot_crit_percent_increase"
          }
        },
        dot_tick_rate_percent_increase = {
          id = 110,
          type = "message",
          label = "optional",
          message_type = "APLValueDotPercentIncrease",
          _metadata = {
            export = "dot_tick_rate_percent_increase"
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
        input_delay = {
          id = 71,
          type = "message",
          label = "optional",
          message_type = "APLValueInputDelay",
          _metadata = {
            export = "input_delay"
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
        cat_new_savage_roar_duration = {
          id = 61,
          type = "message",
          label = "optional",
          message_type = "APLValueCatNewSavageRoarDuration",
          _metadata = {
            export = "cat_new_savage_roar_duration"
          }
        },
        warlock_hand_of_guldan_in_flight = {
          id = 59,
          type = "message",
          label = "optional",
          message_type = "APLValueWarlockHandOfGuldanInFlight",
          _metadata = {
            export = "warlock_hand_of_guldan_in_flight"
          }
        },
        warlock_haunt_in_flight = {
          id = 60,
          type = "message",
          label = "optional",
          message_type = "APLValueWarlockHauntInFlight",
          _metadata = {
            export = "warlock_haunt_in_flight"
          }
        },
        druid_current_eclipse_phase = {
          id = 70,
          type = "message",
          label = "optional",
          message_type = "APLValueCurrentEclipsePhase",
          _metadata = {
            export = "druid_current_eclipse_phase"
          }
        },
        mage_current_combustion_dot_estimate = {
          id = 77,
          type = "message",
          label = "optional",
          message_type = "APLValueMageCurrentCombustionDotEstimate",
          _metadata = {
            export = "mage_current_combustion_dot_estimate"
          }
        },
        shaman_fire_elemental_duration = {
          id = 83,
          type = "message",
          label = "optional",
          message_type = "APLValueShamanFireElementalDuration",
          _metadata = {
            export = "shaman_fire_elemental_duration"
          }
        },
        protection_paladin_damage_taken_last_global = {
          id = 100,
          type = "message",
          label = "optional",
          message_type = "APLValueProtectionPaladinDamageTakenLastGlobal",
          _metadata = {
            export = "protection_paladin_damage_taken_last_global"
          }
        },
        affliction_current_snapshot = {
          id = 123,
          type = "message",
          label = "optional",
          message_type = "APLValueAfflictionCurrentSnapshot",
          _metadata = {
            export = "affliction_current_snapshot"
          }
        },
        affliction_exhale_window = {
          id = 124,
          type = "message",
          label = "optional",
          message_type = "APLValueAfflictionExhaleWindow",
          _metadata = {
            export = "affliction_exhale_window"
          }
        },
        variable_ref = {
          id = 111,
          type = "message",
          label = "optional",
          message_type = "APLValueVariableRef",
          _metadata = {
            export = "variable_ref"
          }
        },
        variable_placeholder = {
          id = 112,
          type = "message",
          label = "optional",
          message_type = "APLValueVariablePlaceholder",
          _metadata = {
            export = "variable_placeholder"
          }
        },
        active_item_swap_set = {
          id = 113,
          type = "message",
          label = "optional",
          message_type = "APLValueActiveItemSwapSet",
          _metadata = {
            export = "active_item_swap_set"
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
          "boss_spell_time_to_ready",
          "boss_spell_is_casting",
          "boss_current_target",
          "current_health",
          "current_health_percent",
          "current_mana",
          "current_mana_percent",
          "current_rage",
          "current_energy",
          "current_focus",
          "current_combo_points",
          "current_solar_energy",
          "current_lunar_energy",
          "current_generic_resource",
          "max_health",
          "max_combo_points",
          "max_energy",
          "max_focus",
          "max_rage",
          "energy_regen_per_second",
          "focus_regen_per_second",
          "energy_time_to_target",
          "focus_time_to_target",
          "unit_is_moving",
          "unit_distance",
          "gcd_is_ready",
          "gcd_time_to_ready",
          "auto_time_to_next",
          "spell_is_known",
          "spell_can_cast",
          "spell_is_ready",
          "spell_time_to_ready",
          "spell_cast_time",
          "spell_travel_time",
          "spell_cpm",
          "spell_is_channeling",
          "spell_channeled_ticks",
          "spell_current_cost",
          "spell_num_charges",
          "spell_time_to_charge",
          "spell_gcd_hasted_duration",
          "spell_full_cooldown",
          "spell_in_flight",
          "aura_is_known",
          "aura_is_active",
          "aura_is_active_with_reaction_time",
          "aura_is_inactive",
          "aura_is_inactive_with_reaction_time",
          "aura_remaining_time",
          "aura_num_stacks",
          "aura_internal_cooldown",
          "aura_icd_is_ready",
          "aura_icd_is_ready_with_reaction_time",
          "aura_should_refresh",
          "all_trinket_stat_procs_active",
          "any_trinket_stat_procs_active",
          "any_trinket_stat_procs_available",
          "trinket_procs_min_remaining_time",
          "trinket_procs_max_remaining_icd",
          "num_equipped_stat_proc_trinkets",
          "num_stat_buff_cooldowns",
          "any_stat_buff_cooldowns_active",
          "any_stat_buff_cooldowns_min_duration",
          "dot_is_active",
          "dot_is_active_on_all_targets",
          "dot_remaining_time",
          "dot_lowest_remaining_time",
          "dot_tick_frequency",
          "dot_time_to_next_tick",
          "dot_base_duration",
          "dot_percent_increase",
          "dot_crit_percent_increase",
          "dot_tick_rate_percent_increase",
          "sequence_is_complete",
          "sequence_is_ready",
          "sequence_time_to_ready",
          "channel_clip_delay",
          "input_delay",
          "front_of_target",
          "totem_remaining_time",
          "cat_excess_energy",
          "cat_new_savage_roar_duration",
          "warlock_hand_of_guldan_in_flight",
          "warlock_haunt_in_flight",
          "druid_current_eclipse_phase",
          "mage_current_combustion_dot_estimate",
          "shaman_fire_elemental_duration",
          "protection_paladin_damage_taken_last_global",
          "affliction_current_snapshot",
          "affliction_exhale_window",
          "variable_ref",
          "variable_placeholder",
          "active_item_swap_set"
        }
      },
      field_order = {
        "uuid",
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
        "boss_spell_time_to_ready",
        "boss_spell_is_casting",
        "boss_current_target",
        "current_health",
        "current_health_percent",
        "current_mana",
        "current_mana_percent",
        "current_rage",
        "current_energy",
        "current_focus",
        "current_combo_points",
        "current_solar_energy",
        "current_lunar_energy",
        "current_generic_resource",
        "max_health",
        "max_combo_points",
        "max_energy",
        "max_focus",
        "max_rage",
        "energy_regen_per_second",
        "focus_regen_per_second",
        "energy_time_to_target",
        "focus_time_to_target",
        "unit_is_moving",
        "unit_distance",
        "gcd_is_ready",
        "gcd_time_to_ready",
        "auto_time_to_next",
        "spell_is_known",
        "spell_can_cast",
        "spell_is_ready",
        "spell_time_to_ready",
        "spell_cast_time",
        "spell_travel_time",
        "spell_cpm",
        "spell_is_channeling",
        "spell_channeled_ticks",
        "spell_current_cost",
        "spell_num_charges",
        "spell_time_to_charge",
        "spell_gcd_hasted_duration",
        "spell_full_cooldown",
        "spell_in_flight",
        "aura_is_known",
        "aura_is_active",
        "aura_is_active_with_reaction_time",
        "aura_is_inactive",
        "aura_is_inactive_with_reaction_time",
        "aura_remaining_time",
        "aura_num_stacks",
        "aura_internal_cooldown",
        "aura_icd_is_ready",
        "aura_icd_is_ready_with_reaction_time",
        "aura_should_refresh",
        "all_trinket_stat_procs_active",
        "any_trinket_stat_procs_active",
        "any_trinket_stat_procs_available",
        "trinket_procs_min_remaining_time",
        "trinket_procs_max_remaining_icd",
        "num_equipped_stat_proc_trinkets",
        "num_stat_buff_cooldowns",
        "any_stat_buff_cooldowns_active",
        "any_stat_buff_cooldowns_min_duration",
        "dot_is_active",
        "dot_is_active_on_all_targets",
        "dot_remaining_time",
        "dot_lowest_remaining_time",
        "dot_tick_frequency",
        "dot_time_to_next_tick",
        "dot_base_duration",
        "dot_percent_increase",
        "dot_crit_percent_increase",
        "dot_tick_rate_percent_increase",
        "sequence_is_complete",
        "sequence_is_ready",
        "sequence_time_to_ready",
        "channel_clip_delay",
        "input_delay",
        "front_of_target",
        "totem_remaining_time",
        "cat_excess_energy",
        "cat_new_savage_roar_duration",
        "warlock_hand_of_guldan_in_flight",
        "warlock_haunt_in_flight",
        "druid_current_eclipse_phase",
        "mage_current_combustion_dot_estimate",
        "shaman_fire_elemental_duration",
        "protection_paladin_damage_taken_last_global",
        "affliction_current_snapshot",
        "affliction_exhale_window",
        "variable_ref",
        "variable_placeholder",
        "active_item_swap_set"
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
            ui_label = "Spell",
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
    APLActionCastFriendlySpell = {
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
        ui_label = "Cast at Player",
        short_description = "Casts a friendly spell if possible, i.e. resource/cooldown/GCD/etc requirements are all met.",
        defaults = "APLActionCastFriendlySpell.create",
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
          requires_group = true,
          requires_target_dummies = true,
          requires_item_swap = false,
          requires_secondary_resource = false,
          requires_healer_spec = false,
          requires_tank_spec = false,
          unparsed = false
        },
        fields = {
          spell_id = {
            ui_label = "Friendly Spell",
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
        "allow_recast"
      },
      _metadata = {
        ui_label = "Channel",
        short_description = "Channels the spell if possible.",
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
          "casting"
        },
        fields = {
          spell_id = {
            ui_label = "Channeled Spell",
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
            full_description = "Interrupt the channel if the condition is true.",
            default = {
              value = {
                oneof_kind = "gcdIsReady",
                gcd_is_ready = {

                }
              }
            }
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
          "casting"
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
            ui_label = "DoT Spell",
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
    APLActionStrictMultidot = {
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
        ui_label = "Strict Multi Dot",
        short_description = "Keeps a DoT active on multiple targets by casting the specified spell. Will not refresh DoTs that are not about to expire.",
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
          "casting"
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
            ui_label = "DoT Spell",
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
        short_description = "Keeps a shield active on multiple targets by casting the specified spell.",
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
          "casting"
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
          requires_healer_spec = true,
          requires_tank_spec = false,
          unparsed = false
        },
        fields = {
          spell_id = {
            ui_label = "Shield Spell",
            default = {

            }
          },
          max_shields = {
            ui_label = "Max Shields",
            full_description = "Maximum number of shields to simultaneously apply.",
            default = 3
          },
          max_overlap = {
            ui_label = "Overlap",
            full_description = "Maximum amount of time before a shield expires when it may be refreshed.",
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
    APLActionCastAllStatBuffCooldowns = {
      fields = {
        stat_type1 = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        stat_type2 = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        stat_type3 = {
          id = 3,
          type = "int32",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "stat_type1",
        "stat_type2",
        "stat_type3"
      },
      _metadata = {
        ui_label = "Cast All Stat Buff Cooldowns",
        short_description = "Casts all available stat buff cooldowns.",
        defaults = {
          stat_type1 = -1,
          stat_type2 = -1,
          stat_type3 = -1
        },
        submenu = {
          "casting"
        },
        fields = {
          stat_type1 = {
            ui_label = "Buff Type",
            default = -1
          },
          stat_type2 = {
            ui_label = "Buff Type",
            default = -1
          },
          stat_type3 = {
            ui_label = "Buff Type",
            default = -1
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
        short_description = "Automatically casts other cooldowns when available.",
        defaults = "APLActionAutocastOtherCooldowns.create",
        submenu = {
          "casting"
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
        short_description = "Waits for the specified amount of time.",
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
          "timing"
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
        short_description = "Waits until the specified condition is true.",
        defaults = "() => APLActionWaitUntil.create()",
        submenu = {
          "timing"
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
        short_description = "Performs an action at a scheduled time.",
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
          "timing"
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
            ui_label = "Action",
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
        defaults = "APLActionSequence.create",
        submenu = {
          "sequences"
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
        defaults = "APLActionResetSequence.create",
        submenu = {
          "sequences"
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
        short_description = "Like a regular Sequence, except all sub-actions are executed immediately after each other and the sequence resets automatically upon completion.",
        defaults = "APLActionStrictSequence.create",
        submenu = {
          "sequences"
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
          "misc"
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
          "misc"
        },
        fields = {
          aura_id = {
            ui_label = "Aura",
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
          "misc"
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
            ui_label = "Aura",
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
          type = "int32",
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
        short_description = "Activates the specified aura with the given number of stacks.",
        defaults = {
          num_stacks = 1
        },
        submenu = {
          "misc"
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
            ui_label = "Aura",
            default = {

            }
          },
          num_stacks = {
            ui_label = "stacks",
            full_description = "Desired number of initial aura stacks.",
            default = 1
          }
        }
      }
    },
    APLActionActivateAllStatBuffProcAuras = {
      fields = {
        swap_set = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "SwapSet"
        },
        stat_type1 = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        stat_type2 = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        stat_type3 = {
          id = 4,
          type = "int32",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "swap_set",
        "stat_type1",
        "stat_type2",
        "stat_type3"
      },
      _metadata = {
        ui_label = "Activate All Stat Buff Proc Auras",
        short_description = "Activates all item/enchant proc auras that buff the specified stat type(s) using the specified item set.",
        defaults = {
          swap_set = "ItemSwapSet.Main",
          stat_type1 = -1,
          stat_type2 = -1,
          stat_type3 = -1
        },
        submenu = {
          "misc"
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
          swap_set = {
            ui_label = "None",
            default = "ItemSwapSet.Main"
          },
          stat_type1 = {
            ui_label = "Buff Type",
            default = -1
          },
          stat_type2 = {
            ui_label = "Buff Type",
            default = -1
          },
          stat_type3 = {
            ui_label = "Buff Type",
            default = -1
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
        short_description = "Triggers the specified internal cooldown.",
        defaults = "() => APLActionTriggerICD.create()",
        submenu = {
          "misc"
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
            ui_label = "Aura",
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
          "misc"
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
            ui_label = "None",
            default = 0
          }
        }
      }
    },
    APLActionCatOptimalRotationAction = {
      fields = {
        rotation_type = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "AplType"
        },
        bear_weave = {
          id = 2,
          type = "bool",
          label = "optional"
        },
        snek_weave = {
          id = 3,
          type = "bool",
          label = "optional"
        },
        allow_aoe_berserk = {
          id = 4,
          type = "bool",
          label = "optional"
        },
        manual_params = {
          id = 5,
          type = "bool",
          label = "optional"
        },
        min_roar_offset = {
          id = 6,
          type = "double",
          label = "optional"
        },
        rip_leeway = {
          id = 7,
          type = "double",
          label = "optional"
        },
        use_bite = {
          id = 8,
          type = "bool",
          label = "optional"
        },
        bite_time = {
          id = 9,
          type = "double",
          label = "optional"
        },
        berserk_bite_time = {
          id = 10,
          type = "double",
          label = "optional"
        },
        use_ns = {
          id = 11,
          type = "bool",
          label = "optional"
        },
        wrath_weave = {
          id = 12,
          type = "bool",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "rotation_type",
        "bear_weave",
        "snek_weave",
        "allow_aoe_berserk",
        "manual_params",
        "min_roar_offset",
        "rip_leeway",
        "use_bite",
        "bite_time",
        "berserk_bite_time",
        "use_ns",
        "wrath_weave"
      }
    },
    APLActionGuardianHotwDpsRotation = {
      fields = {
        strategy = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "Strategy"
        }
      },
      oneofs = {

      },
      field_order = {
        "strategy"
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
          "misc"
        },
        fields = {
          range_from_target = {
            ui_label = "to Range",
            full_description = "Desired range from target."
          }
        }
      }
    },
    APLActionMoveDuration = {
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
        ui_label = "Move duration",
        short_description = "The characters moves for the given duration.",
        defaults = "() => APLActionMoveDuration.create()",
        submenu = {
          "misc"
        },
        fields = {
          duration = {
            ui_label = "Duration",
            full_description = "Amount of time the character should move."
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
    APLActionWarlockNextExhaleTarget = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

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
        ui_label = "Constant",
        short_description = "A constant value",
        full_description = "<p>Examples:<ul><li><b>Number:</b> '123', '0.5', '-10'</li><li><b>Time:</b> '100ms', '5s', '3m'</li><li><b>Percentage:</b> '30%'</li></ul></p>",
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
        ui_label = "All Of",
        short_description = "True if ALL of the values are true",
        defaults = "APLValueAnd.create",
        submenu = {
          "logic"
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
        ui_label = "Any Of",
        short_description = "True if ANY of the values are true",
        defaults = "APLValueOr.create",
        submenu = {
          "logic"
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
        short_description = "True if the value is false",
        defaults = "APLValueNot.create",
        submenu = {
          "logic"
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
        short_description = "Compare two values using the specified operator",
        defaults = "APLValueCompare.create",
        submenu = {
          "logic"
        },
        fields = {
          lhs = {
            ui_label = "Lhs"
          },
          op = {
            ui_label = "None",
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
        short_description = "Perform mathematical operations on two values",
        defaults = "APLValueMath.create",
        submenu = {
          "logic"
        },
        fields = {
          lhs = {
            ui_label = "Lhs"
          },
          op = {
            ui_label = "None",
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
        short_description = "Get the maximum value from a list of values",
        defaults = "APLValueMax.create",
        submenu = {
          "logic"
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
        short_description = "Get the minimum value from a list of values",
        defaults = "APLValueMin.create",
        submenu = {
          "logic"
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
        short_description = "Current time in seconds",
        defaults = "APLValueCurrentTime.create",
        submenu = {
          "encounter"
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
        ui_label = "Current Time %",
        short_description = "Current time as a percentage of the encounter duration",
        defaults = "APLValueCurrentTimePercent.create",
        submenu = {
          "encounter"
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
        short_description = "Remaining time in seconds",
        defaults = "APLValueRemainingTime.create",
        submenu = {
          "encounter"
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
        ui_label = "Remaining Time %",
        short_description = "Remaining time as a percentage of the encounter duration",
        defaults = "APLValueRemainingTimePercent.create",
        submenu = {
          "encounter"
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
        short_description = "Number of targets in the encounter",
        defaults = "APLValueNumberTargets.create",
        submenu = {
          "encounter"
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
        short_description = "True if we are in the execute phase (target health below threshold)",
        defaults = "APLValueIsExecutePhase.create",
        submenu = {
          "encounter"
        },
        fields = {
          threshold = {
            ui_label = "None",
            default = 0
          }
        }
      }
    },
    APLValueBossSpellTimeToReady = {
      fields = {
        target_unit = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "UnitReference"
        },
        spell_id = {
          id = 2,
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
        ui_label = "Spell Time to Ready",
        short_description = "Time until the spell will be ready",
        defaults = "APLValueBossSpellTimeToReady.create",
        submenu = {
          "boss"
        },
        fields = {
          target_unit = {
            ui_label = "Unit",
            default = {
              type = 0
            }
          },
          spell_id = {
            ui_label = "Spell",
            default = {

            }
          }
        }
      }
    },
    APLValueBossSpellIsCasting = {
      fields = {
        target_unit = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "UnitReference"
        },
        spell_id = {
          id = 2,
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
        ui_label = "Spell Is Casting",
        short_description = "True if the spell is currently being cast",
        defaults = "APLValueBossSpellIsCasting.create",
        submenu = {
          "boss"
        },
        fields = {
          target_unit = {
            ui_label = "Unit",
            default = {
              type = 0
            }
          },
          spell_id = {
            ui_label = "Non-instant Spell",
            default = {

            }
          }
        }
      }
    },
    APLValueBossCurrentTarget = {
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
        ui_label = "Is Tanking",
        short_description = "True if the player is currently tanking",
        defaults = "APLValueBossCurrentTarget.create",
        submenu = {
          "boss"
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
    APLValueUnitIsMoving = {
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
        ui_label = "Unit Is Moving",
        short_description = "True if the unit is moving",
        defaults = "APLValueUnitIsMoving.create",
        submenu = {
          "unit"
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
    APLValueUnitDistance = {
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
        ui_label = "Distance to Unit",
        short_description = "Distance to the unit",
        defaults = "APLValueUnitDistance.create",
        submenu = {
          "unit"
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
        ui_label = "Current Health",
        short_description = "Current health of the unit",
        defaults = "APLValueCurrentHealth.create",
        submenu = {
          "resources",
          "health"
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
        ui_label = "Current Health %",
        short_description = "Current health as a percentage of max health",
        defaults = "APLValueCurrentHealthPercent.create",
        submenu = {
          "resources",
          "health"
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
        ui_label = "Current Mana",
        short_description = "Amount of currently available Mana.",
        defaults = "APLValueCurrentMana.create",
        submenu = {
          "resources",
          "mana"
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
            "Hunter",
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
        ui_label = "Current Mana (%)",
        short_description = "Amount of currently available Mana, as a percentage.",
        defaults = "APLValueCurrentManaPercent.create",
        submenu = {
          "resources",
          "mana"
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
            "Hunter",
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
        ui_label = "Current Rage",
        short_description = "Amount of currently available Rage.",
        defaults = "APLValueCurrentRage.create",
        submenu = {
          "resources",
          "rage"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = true,
          class_specific = true,
          classes = {
            "Druid",
            "Warrior"
          },
          specs = {
            "FeralBearDruid",
            "FeralCatDruid"
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
        ui_label = "Current Energy",
        short_description = "Amount of currently available Energy.",
        defaults = "APLValueCurrentEnergy.create",
        submenu = {
          "resources",
          "energy"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = true,
          class_specific = true,
          classes = {
            "Druid",
            "Rogue"
          },
          specs = {
            "FeralBearDruid",
            "FeralCatDruid"
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
    APLValueCurrentFocus = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Current Focus",
        short_description = "Amount of currently available Focus.",
        defaults = "APLValueCurrentFocus.create",
        submenu = {
          "resources",
          "focus"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = false,
          class_specific = true,
          classes = {
            "Hunter"
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
        ui_label = "Current Combo Points",
        short_description = "Amount of currently available Combo Points.",
        defaults = "APLValueCurrentComboPoints.create",
        submenu = {
          "resources",
          "combo_points"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = true,
          class_specific = true,
          classes = {
            "Druid",
            "Rogue"
          },
          specs = {
            "FeralBearDruid",
            "FeralCatDruid"
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
    APLValueCurrentSolarEnergy = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Solar Energy",
        short_description = "Amount of currently available Solar Energy.",
        defaults = "APLValueCurrentSolarEnergy.create",
        submenu = {
          "resources",
          "eclipse"
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
            "BalanceDruid"
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
    APLValueCurrentLunarEnergy = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Lunar Energy",
        short_description = "Amount of currently available Lunar Energy",
        defaults = "APLValueCurrentLunarEnergy.create",
        submenu = {
          "resources",
          "eclipse"
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
            "BalanceDruid"
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
    APLValueCurrentGenericResource = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "{GENERIC_RESOURCE}",
        short_description = "Amount of currently available {GENERIC_RESOURCE}.",
        defaults = "APLValueCurrentGenericResource.create",
        submenu = {
          "resources"
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
        short_description = "Maximum health of the unit",
        defaults = "APLValueMaxHealth.create",
        submenu = {
          "resources",
          "health"
        }
      }
    },
    APLValueMaxComboPoints = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Max Combo Points",
        short_description = "Amount of maximum available Combo Points.",
        defaults = "APLValueMaxComboPoints.create",
        submenu = {
          "resources",
          "combo_points"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = true,
          class_specific = true,
          classes = {
            "Druid",
            "Rogue"
          },
          specs = {
            "FeralBearDruid",
            "FeralCatDruid"
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
    APLValueMaxEnergy = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Max Energy",
        short_description = "Amount of maximum available Energy.",
        defaults = "APLValueMaxEnergy.create",
        submenu = {
          "resources",
          "energy"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = true,
          class_specific = true,
          classes = {
            "Druid",
            "Rogue"
          },
          specs = {
            "FeralBearDruid",
            "FeralCatDruid"
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
    APLValueMaxFocus = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Max Focus",
        short_description = "Amount of maximum available Focus.",
        defaults = "APLValueMaxFocus.create",
        submenu = {
          "resources",
          "focus"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = false,
          class_specific = true,
          classes = {
            "Hunter"
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
    APLValueMaxRage = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Max Rage",
        short_description = "Amount of maximum available Rage.",
        defaults = "APLValueMaxRage.create",
        submenu = {
          "resources",
          "rage"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = true,
          class_specific = true,
          classes = {
            "Druid",
            "Warrior"
          },
          specs = {
            "FeralBearDruid",
            "FeralCatDruid"
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
    APLValueEnergyRegenPerSecond = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Energy Regen Per Second",
        short_description = "Energy regen per second.",
        defaults = "APLValueEnergyRegenPerSecond.create",
        submenu = {
          "resources",
          "energy"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = true,
          class_specific = true,
          classes = {
            "Druid",
            "Rogue"
          },
          specs = {
            "FeralBearDruid",
            "FeralCatDruid"
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
    APLValueFocusRegenPerSecond = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Focus Regen Per Second",
        short_description = "Focus regen per second.",
        defaults = "APLValueFocusRegenPerSecond.create",
        submenu = {
          "resources",
          "focus"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = false,
          class_specific = true,
          classes = {
            "Hunter"
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
    APLValueEnergyTimeToTarget = {
      fields = {
        target_energy = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "APLValue"
        }
      },
      oneofs = {

      },
      field_order = {
        "target_energy"
      },
      _metadata = {
        ui_label = "Estimated Time To Target Energy",
        short_description = "Estimated time until target Energy is reached, will return 0 if at or above target.",
        defaults = "APLValueEnergyTimeToTarget.create",
        submenu = {
          "resources",
          "energy"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = true,
          class_specific = true,
          classes = {
            "Druid",
            "Rogue"
          },
          specs = {
            "FeralBearDruid",
            "FeralCatDruid"
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
          target_energy = {
            ui_label = "Target Energy"
          }
        }
      }
    },
    APLValueFocusTimeToTarget = {
      fields = {
        target_focus = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "APLValue"
        }
      },
      oneofs = {

      },
      field_order = {
        "target_focus"
      },
      _metadata = {
        ui_label = "Estimated Time To Target Focus",
        short_description = "Estimated time until target Focus is reached, will return 0 if at or above target.",
        defaults = "APLValueFocusTimeToTarget.create",
        submenu = {
          "resources",
          "focus"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = false,
          class_specific = true,
          classes = {
            "Hunter"
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
          target_focus = {
            ui_label = "Target Focus"
          }
        }
      }
    },
    APLValueCurrentEclipsePhase = {
      fields = {
        eclipse_phase = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "APLValueEclipsePhase"
        }
      },
      oneofs = {

      },
      field_order = {
        "eclipse_phase"
      },
      _metadata = {
        ui_label = "Current Eclipse Phase",
        short_description = "The eclipse phase the druid currently is in.",
        defaults = "APLValueCurrentEclipsePhase.create",
        submenu = {
          "resources",
          "eclipse"
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
            "BalanceDruid"
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
          eclipse_phase = {
            ui_label = "Lunar",
            default = 0
          }
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
          "gcd"
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
          "gcd"
        }
      }
    },
    APLValueAutoTimeToNext = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Time To Next Auto",
        short_description = "Amount of time remaining before the next Main-hand or Off-hand melee attack, or <b>0</b> if autoattacks are not engaged.",
        defaults = "APLValueAutoTimeToNext.create",
        submenu = {
          "auto"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = true,
          class_specific = true,
          classes = {

          },
          specs = {

          },
          excluded_classes = {
            "Druid",
            "Hunter",
            "Mage",
            "Priest",
            "Shaman",
            "Warlock"
          },
          excluded_specs = {
            "BalanceDruid",
            "ElementalShaman"
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
          "spell"
        },
        fields = {
          spell_id = {
            ui_label = "Spell",
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
        full_description = "<p>The <b>Cast Spell</b> action does not need to be conditioned on this, because it applies this check automatically.</p>",
        defaults = "APLValueSpellCanCast.create",
        submenu = {
          "spell"
        },
        fields = {
          spell_id = {
            ui_label = "Spell",
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
          "spell"
        },
        fields = {
          spell_id = {
            ui_label = "Spell",
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
          "spell"
        },
        fields = {
          spell_id = {
            ui_label = "Spell",
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
          "spell"
        },
        fields = {
          spell_id = {
            ui_label = "Spell",
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
          "spell"
        }
      }
    },
    APLValueInputDelay = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Input Delay",
        short_description = "The amount of time specified by the <b>Input Dleay</b> setting.",
        defaults = "APLValueInputDelay.create",
        submenu = {
          "spell"
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
        ui_label = "In Front of Target",
        short_description = "True if we are in front of the target",
        defaults = "APLValueFrontOfTarget.create",
        submenu = {
          "encounter"
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
          "spell"
        },
        fields = {
          spell_id = {
            ui_label = "Spell",
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
          "spell"
        },
        fields = {
          spell_id = {
            ui_label = "Spell",
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
          "spell"
        },
        fields = {
          spell_id = {
            ui_label = "Channeled Spell",
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
          "spell"
        },
        fields = {
          spell_id = {
            ui_label = "Channeled Spell",
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
          "spell"
        },
        fields = {
          spell_id = {
            ui_label = "Spell",
            default = {

            }
          }
        }
      }
    },
    APLValueSpellNumCharges = {
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
        ui_label = "Number of Charges",
        short_description = "The number of charges that are currently available for the spell.",
        defaults = "APLValueSpellNumCharges.create",
        submenu = {
          "spell"
        },
        fields = {
          spell_id = {
            ui_label = "Spell",
            default = {

            }
          }
        }
      }
    },
    APLValueSpellTimeToCharge = {
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
        ui_label = "Time to next Charge",
        short_description = "The time until the next charge is available. 0 if spell has all charges avaialable.",
        defaults = "APLValueSpellTimeToCharge.create",
        submenu = {
          "spell"
        },
        fields = {
          spell_id = {
            ui_label = "Spell",
            default = {

            }
          }
        }
      }
    },
    APLValueSpellGCDHastedDuration = {
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
        ui_label = "GCD Hasted Duration",
        short_description = "The duration of the GCD induced by a cast with the current haste",
        defaults = "APLValueSpellGCDHastedDuration.create",
        submenu = {
          "spell"
        },
        fields = {
          spell_id = {
            ui_label = "Spell",
            default = {

            }
          }
        }
      }
    },
    APLValueSpellFullCooldown = {
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
        ui_label = "Full Cooldown",
        short_description = "The full cooldown duration of the spell",
        defaults = "APLValueSpellFullCooldown.create",
        submenu = {
          "spell"
        },
        fields = {
          spell_id = {
            ui_label = "Spell",
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
        ui_label = "Spell in Flight",
        short_description = "<b>True</b> if this spell is currently in flight, otherwise <b>False</b>.",
        defaults = "APLValueSpellInFlight.create",
        submenu = {
          "spell"
        },
        fields = {
          spell_id = {
            ui_label = "Spell",
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
          "aura"
        },
        fields = {
          source_unit = {
            ui_label = "Unit",
            default = {
              type = 4
            }
          },
          aura_id = {
            ui_label = "Aura",
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
        },
        include_reaction_time = {
          id = 3,
          type = "bool",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "source_unit",
        "aura_id",
        "include_reaction_time"
      },
      _metadata = {
        ui_label = "Aura Active",
        short_description = "<b>True</b> if the aura is currently active AND it has been active for at least as long as the player reaction time (configured in Settings), otherwise <b>False</b>.",
        defaults = {
          include_reaction_time = true
        },
        submenu = {
          "aura"
        },
        fields = {
          source_unit = {
            ui_label = "Unit",
            default = {
              type = 4
            }
          },
          aura_id = {
            ui_label = "Aura",
            default = {

            }
          }
        }
      }
    },
    APLValueAuraIsInactive = {
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
        include_reaction_time = {
          id = 3,
          type = "bool",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "source_unit",
        "aura_id",
        "include_reaction_time"
      },
      _metadata = {
        ui_label = "Aura Inactive",
        short_description = "<b>True</b> if the aura is not currently active AND it has been inactive for at least as long as the player reaction time (configured in Settings), otherwise <b>False</b>.",
        defaults = {
          include_reaction_time = true
        },
        submenu = {
          "aura"
        },
        fields = {
          source_unit = {
            ui_label = "Unit",
            default = {
              type = 4
            }
          },
          aura_id = {
            ui_label = "Aura",
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
          "aura"
        },
        fields = {
          source_unit = {
            ui_label = "Unit",
            default = {
              type = 4
            }
          },
          aura_id = {
            ui_label = "Aura",
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
        },
        include_reaction_time = {
          id = 3,
          type = "bool",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "source_unit",
        "aura_id",
        "include_reaction_time"
      },
      _metadata = {
        ui_label = "Aura Num Stacks",
        short_description = "Number of stacks of the aura.",
        defaults = {
          include_reaction_time = true
        },
        submenu = {
          "aura"
        },
        fields = {
          source_unit = {
            ui_label = "Unit",
            default = {
              type = 4
            }
          },
          aura_id = {
            ui_label = "Aura",
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
        short_description = "Time remaining before this aura's internal cooldown will be ready, or 0 if the ICD is ready now.",
        defaults = "APLValueAuraInternalCooldown.create",
        submenu = {
          "aura"
        },
        fields = {
          source_unit = {
            ui_label = "Unit",
            default = {
              type = 4
            }
          },
          aura_id = {
            ui_label = "Aura",
            default = {

            }
          }
        }
      }
    },
    APLValueAuraICDIsReady = {
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
        include_reaction_time = {
          id = 3,
          type = "bool",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "source_unit",
        "aura_id",
        "include_reaction_time"
      },
      _metadata = {
        ui_label = "Aura ICD Is Ready",
        short_description = "<b>True</b> if the aura's ICD is currently ready OR it was put on CD recently, within the player's reaction time (configured in Settings), otherwise <b>False</b>.",
        defaults = {
          include_reaction_time = true
        },
        submenu = {
          "aura"
        },
        fields = {
          source_unit = {
            ui_label = "Unit",
            default = {
              type = 4
            }
          },
          aura_id = {
            ui_label = "Aura",
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
        ui_label = "Aura Should Refresh",
        short_description = "Whether this aura should be refreshed, e.g. for the purpose of maintaining a debuff.",
        full_description = "<p>This condition checks not only the specified aura but also any other auras on the same unit, including auras applied by other raid members, which apply the same debuff category.</p><p>For example, 'Should Refresh Debuff(Sunder Armor)' will return <b>False</b> if the unit has an active Expose Armor aura.</p>",
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
          "aura"
        },
        fields = {
          source_unit = {
            ui_label = "Unit",
            default = {
              type = 4
            }
          },
          aura_id = {
            ui_label = "Aura",
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
    APLValueAllTrinketStatProcsActive = {
      fields = {
        stat_type1 = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        stat_type2 = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        stat_type3 = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        min_icd_seconds = {
          id = 4,
          type = "double",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "stat_type1",
        "stat_type2",
        "stat_type3",
        "min_icd_seconds"
      },
      _metadata = {
        ui_label = "All Item Proc Buffs Active",
        short_description = "<b>True</b> if all item/enchant procs that buff the specified stat type(s) are currently active, otherwise <b>False</b>.",
        full_description = "<p>For stacking proc buffs, this condition also checks that the buff has been stacked to its maximum possible strength.</p>",
        defaults = {
          stat_type1 = -1,
          stat_type2 = -1,
          stat_type3 = -1
        },
        submenu = {
          "aura_sets"
        },
        fields = {
          stat_type1 = {
            ui_label = "Buff Type",
            default = -1
          },
          stat_type2 = {
            ui_label = "Buff Type",
            default = -1
          },
          stat_type3 = {
            ui_label = "Buff Type",
            default = -1
          },
          min_icd_seconds = {
            ui_label = "Min ICD",
            full_description = "If non-zero, filter out any procs that either lack an ICD or for which the ICD is smaller than the specified value (in seconds). This can be useful for certain snapshotting checks, since procs with low ICDs are often too weak to snapshot.",
            default = 0.0
          }
        }
      }
    },
    APLValueAnyTrinketStatProcsActive = {
      fields = {
        stat_type1 = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        stat_type2 = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        stat_type3 = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        min_icd_seconds = {
          id = 4,
          type = "double",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "stat_type1",
        "stat_type2",
        "stat_type3",
        "min_icd_seconds"
      },
      _metadata = {
        ui_label = "Any Item Proc Buff Active",
        short_description = "<b>True</b> if any item/enchant procs that buff the specified stat type(s) are currently active, otherwise <b>False</b>.",
        full_description = "<p>For stacking proc buffs, this condition also checks that the buff has been stacked to its maximum possible strength.</p>",
        defaults = {
          stat_type1 = -1,
          stat_type2 = -1,
          stat_type3 = -1
        },
        submenu = {
          "aura_sets"
        },
        fields = {
          stat_type1 = {
            ui_label = "Buff Type",
            default = -1
          },
          stat_type2 = {
            ui_label = "Buff Type",
            default = -1
          },
          stat_type3 = {
            ui_label = "Buff Type",
            default = -1
          },
          min_icd_seconds = {
            ui_label = "Min ICD",
            full_description = "If non-zero, filter out any procs that either lack an ICD or for which the ICD is smaller than the specified value (in seconds). This can be useful for certain snapshotting checks, since procs with low ICDs are often too weak to snapshot.",
            default = 0.0
          }
        }
      }
    },
    APLValueAnyTrinketStatProcsAvailable = {
      fields = {
        stat_type1 = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        stat_type2 = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        stat_type3 = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        min_icd_seconds = {
          id = 4,
          type = "double",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "stat_type1",
        "stat_type2",
        "stat_type3",
        "min_icd_seconds"
      },
      _metadata = {
        ui_label = "Any Item Proc Buff Available",
        short_description = "<b>True</b> if any item/enchant procs that buff the specified stat type(s) are currently not on ICD and aren't active, otherwise <b>False</b>.",
        defaults = {
          stat_type1 = -1,
          stat_type2 = -1,
          stat_type3 = -1
        },
        submenu = {
          "aura_sets"
        },
        fields = {
          stat_type1 = {
            ui_label = "Buff Type",
            default = -1
          },
          stat_type2 = {
            ui_label = "Buff Type",
            default = -1
          },
          stat_type3 = {
            ui_label = "Buff Type",
            default = -1
          },
          min_icd_seconds = {
            ui_label = "Min ICD",
            full_description = "If non-zero, filter out any procs that either lack an ICD or for which the ICD is smaller than the specified value (in seconds). This can be useful for certain snapshotting checks, since procs with low ICDs are often too weak to snapshot.",
            default = 0.0
          }
        }
      }
    },
    APLValueTrinketProcsMinRemainingTime = {
      fields = {
        stat_type1 = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        stat_type2 = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        stat_type3 = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        min_icd_seconds = {
          id = 4,
          type = "double",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "stat_type1",
        "stat_type2",
        "stat_type3",
        "min_icd_seconds"
      },
      _metadata = {
        ui_label = "Item Procs Min Remaining Time",
        short_description = "Shortest remaining duration on any active item/enchant procs that buff the specified stat type(s), or infinity if none are currently active.",
        defaults = {
          stat_type1 = -1,
          stat_type2 = -1,
          stat_type3 = -1
        },
        submenu = {
          "aura_sets"
        },
        fields = {
          stat_type1 = {
            ui_label = "Buff Type",
            default = -1
          },
          stat_type2 = {
            ui_label = "Buff Type",
            default = -1
          },
          stat_type3 = {
            ui_label = "Buff Type",
            default = -1
          },
          min_icd_seconds = {
            ui_label = "Min ICD",
            full_description = "If non-zero, filter out any procs that either lack an ICD or for which the ICD is smaller than the specified value (in seconds). This can be useful for certain snapshotting checks, since procs with low ICDs are often too weak to snapshot.",
            default = 0.0
          }
        }
      }
    },
    APLValueTrinketProcsMaxRemainingICD = {
      fields = {
        stat_type1 = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        stat_type2 = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        stat_type3 = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        min_icd_seconds = {
          id = 4,
          type = "double",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "stat_type1",
        "stat_type2",
        "stat_type3",
        "min_icd_seconds"
      },
      _metadata = {
        ui_label = "Item Procs Max Remaining ICD",
        short_description = "Longest remaining ICD on any inactive item/enchant procs that buff the specified stat type(s), or 0 if all are currently active.",
        defaults = {
          stat_type1 = -1,
          stat_type2 = -1,
          stat_type3 = -1
        },
        submenu = {
          "aura_sets"
        },
        fields = {
          stat_type1 = {
            ui_label = "Buff Type",
            default = -1
          },
          stat_type2 = {
            ui_label = "Buff Type",
            default = -1
          },
          stat_type3 = {
            ui_label = "Buff Type",
            default = -1
          },
          min_icd_seconds = {
            ui_label = "Min ICD",
            full_description = "If non-zero, filter out any procs that either lack an ICD or for which the ICD is smaller than the specified value (in seconds). This can be useful for certain snapshotting checks, since procs with low ICDs are often too weak to snapshot.",
            default = 0.0
          }
        }
      }
    },
    APLValueNumEquippedStatProcTrinkets = {
      fields = {
        stat_type1 = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        stat_type2 = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        stat_type3 = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        min_icd_seconds = {
          id = 4,
          type = "double",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "stat_type1",
        "stat_type2",
        "stat_type3",
        "min_icd_seconds"
      },
      _metadata = {
        ui_label = "Num Equipped Stat Proc Effects",
        short_description = "Number of equipped passive item/enchant effects that buff the specified stat type(s) when they proc.",
        defaults = {
          stat_type1 = -1,
          stat_type2 = -1,
          stat_type3 = -1
        },
        submenu = {
          "aura_sets"
        },
        fields = {
          stat_type1 = {
            ui_label = "Buff Type",
            default = -1
          },
          stat_type2 = {
            ui_label = "Buff Type",
            default = -1
          },
          stat_type3 = {
            ui_label = "Buff Type",
            default = -1
          },
          min_icd_seconds = {
            ui_label = "Min ICD",
            full_description = "If non-zero, filter out any procs that either lack an ICD or for which the ICD is smaller than the specified value (in seconds). This can be useful for certain snapshotting checks, since procs with low ICDs are often too weak to snapshot.",
            default = 0.0
          }
        }
      }
    },
    APLValueNumStatBuffCooldowns = {
      fields = {
        stat_type1 = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        stat_type2 = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        stat_type3 = {
          id = 3,
          type = "int32",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "stat_type1",
        "stat_type2",
        "stat_type3"
      },
      _metadata = {
        ui_label = "Num Stat Buff Cooldowns",
        short_description = "Number of registered Major Cooldowns that buff the specified stat type(s) when they are cast.",
        full_description = [[<p>Both manually casted cooldowns as well as cooldowns controlled by "Cast All Stat Buff Cooldowns" and "Autocast Other Cooldowns" actions are included in the total count returned by this value.</p>]],
        defaults = {
          stat_type1 = -1,
          stat_type2 = -1,
          stat_type3 = -1
        },
        submenu = {
          "aura_sets"
        },
        fields = {
          stat_type1 = {
            ui_label = "Buff Type",
            default = -1
          },
          stat_type2 = {
            ui_label = "Buff Type",
            default = -1
          },
          stat_type3 = {
            ui_label = "Buff Type",
            default = -1
          }
        }
      }
    },
    APLValueAnyStatBuffCooldownsActive = {
      fields = {
        stat_type1 = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        stat_type2 = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        stat_type3 = {
          id = 3,
          type = "int32",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "stat_type1",
        "stat_type2",
        "stat_type3"
      },
      _metadata = {
        ui_label = "Any Stat Buff Cooldowns Active",
        short_description = "<b>True</b> if any registered Major Cooldowns that buff the specified stat type(s) are currently active, otherwise <b>False</b>.",
        full_description = [[<p>For stacking buffs, this condition also checks that the buff has been stacked to its maximum possible strength after the cooldown is activated.</p><p>Both manually casted cooldowns as well as cooldowns controlled by "Cast All Stat Buff Cooldowns" and "Autocast Other Cooldowns" actions are checked.</p>]],
        defaults = {
          stat_type1 = -1,
          stat_type2 = -1,
          stat_type3 = -1
        },
        submenu = {
          "aura_sets"
        },
        fields = {
          stat_type1 = {
            ui_label = "Buff Type",
            default = -1
          },
          stat_type2 = {
            ui_label = "Buff Type",
            default = -1
          },
          stat_type3 = {
            ui_label = "Buff Type",
            default = -1
          }
        }
      }
    },
    APLValueAnyStatBuffCooldownsMinDuration = {
      fields = {
        stat_type1 = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        stat_type2 = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        stat_type3 = {
          id = 3,
          type = "int32",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "stat_type1",
        "stat_type2",
        "stat_type3"
      },
      _metadata = {
        ui_label = "Any Stat Buff Cooldowns Min Remaining Time",
        short_description = "Shortest remaining duration on any registered Major Cooldown that buff the specified stat type(s), or infinity if none are currently active.",
        defaults = {
          stat_type1 = -1,
          stat_type2 = -1,
          stat_type3 = -1
        },
        submenu = {
          "aura_sets"
        },
        fields = {
          stat_type1 = {
            ui_label = "Buff Type",
            default = -1
          },
          stat_type2 = {
            ui_label = "Buff Type",
            default = -1
          },
          stat_type3 = {
            ui_label = "Buff Type",
            default = -1
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
          "dot"
        },
        fields = {
          target_unit = {
            ui_label = "Unit",
            default = {
              type = 5
            }
          },
          spell_id = {
            ui_label = "DoT Spell",
            default = {

            }
          }
        }
      }
    },
    APLValueDotIsActiveOnAllTargets = {
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
        ui_label = "Dot Is Active On All Targets",
        short_description = "<b>True</b> if the specified dot is currently ticking on all targets, otherwise <b>False</b>.",
        defaults = "APLValueDotIsActiveOnAllTargets.create",
        submenu = {
          "dot"
        },
        fields = {
          spell_id = {
            ui_label = "DoT Spell",
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
          "dot"
        },
        fields = {
          target_unit = {
            ui_label = "Unit",
            default = {
              type = 5
            }
          },
          spell_id = {
            ui_label = "DoT Spell",
            default = {

            }
          }
        }
      }
    },
    APLValueDotLowestRemainingTime = {
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
        ui_label = "Dot Lowest Remaining Time",
        short_description = "Time remaining before the last tick of this DoT on any target will occur, or 0 if the DoT is not currently ticking.",
        defaults = "APLValueDotLowestRemainingTime.create",
        submenu = {
          "dot"
        },
        fields = {
          spell_id = {
            ui_label = "DoT Spell",
            default = {

            }
          }
        }
      }
    },
    APLValueDotTickFrequency = {
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
        ui_label = "Dot Tick Frequency",
        short_description = "The time between each tick.",
        defaults = "APLValueDotTickFrequency.create",
        submenu = {
          "dot"
        },
        fields = {
          target_unit = {
            ui_label = "Unit",
            default = {
              type = 5
            }
          },
          spell_id = {
            ui_label = "DoT Spell",
            default = {

            }
          }
        }
      }
    },
    APLValueDotTimeToNextTick = {
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
        ui_label = "Dot Time To Next Tick",
        short_description = "The time remaining until the next tick of this DoT will occur.",
        defaults = "APLValueDotTimeToNextTick.create",
        submenu = {
          "dot"
        },
        fields = {
          target_unit = {
            ui_label = "Unit",
            default = {
              type = 5
            }
          },
          spell_id = {
            ui_label = "DoT Spell",
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
          "sequence"
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
          "sequence"
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
          "sequence"
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
          "shaman"
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
            ui_label = "None",
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
          "feral_druid"
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
            "FeralCatDruid"
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
    APLValueCatNewSavageRoarDuration = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "New Savage Roar Duration",
        short_description = "Returns duration of savage roar based on current combo points",
        defaults = "APLValueCatNewSavageRoarDuration.create",
        submenu = {
          "feral_druid"
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
            "FeralCatDruid"
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
    APLValueWarlockHandOfGuldanInFlight = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Hand of Guldan in Flight",
        short_description = "Returns <b>True</b> if the impact of Hand of Guldan currenty is in flight.",
        defaults = "APLValueWarlockHandOfGuldanInFlight.create",
        submenu = {
          "warlock"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = true,
          class_specific = true,
          classes = {
            "Warlock"
          },
          specs = {
            "Warlock"
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
    APLValueWarlockHauntInFlight = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "[DEPRECATED] Haunt In Flight",
        short_description = "Returns <b>True</b> if Haunt currently is in flight.",
        defaults = "APLValueWarlockHauntInFlight.create",
        submenu = {
          "warlock"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = true,
          class_specific = true,
          classes = {
            "Warlock"
          },
          specs = {
            "Warlock"
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
    APLValueAfflictionExhaleWindow = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Exhale Window",
        short_description = "Configured leeway for exhaling inhaled DoTs.",
        defaults = "APLValueAfflictionExhaleWindow.create",
        submenu = {
          "warlock"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = true,
          class_specific = true,
          classes = {
            "Warlock"
          },
          specs = {
            "Warlock"
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
    APLValueAfflictionCurrentSnapshot = {
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
        }
      },
      oneofs = {

      },
      field_order = {
        "spell_id",
        "target_unit"
      },
      _metadata = {
        ui_label = "Existing Raw Snapshot %",
        short_description = "How much stronger your existing snapshot is relative to baseline. Ignores Haste and Crit. Not recommended to use unless you know what you're doing.",
        defaults = "APLValueAfflictionCurrentSnapshot.create",
        submenu = {
          "warlock"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = true,
          class_specific = true,
          classes = {
            "Warlock"
          },
          specs = {
            "Warlock"
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
          },
          spell_id = {
            ui_label = "DoT Spell",
            default = {

            }
          }
        }
      }
    },
    APLValueMageCurrentCombustionDotEstimate = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Combustion Dot Value",
        short_description = "Returns the current estimated size of your Combustion Dot.",
        defaults = "APLValueMageCurrentCombustionDotEstimate.create",
        submenu = {
          "mage"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = true,
          class_specific = true,
          classes = {
            "Mage"
          },
          specs = {
            "Mage"
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
    APLValueShamanFireElementalDuration = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Fire Elemental Total Duration",
        short_description = "Returns the total duration of Fire Elemental Totem",
        defaults = "APLValueShamanFireElementalDuration.create",
        submenu = {
          "shaman"
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
        }
      }
    },
    APLValueProtectionPaladinDamageTakenLastGlobal = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Damage Taken Last Global",
        short_description = "Amount of damage taken in the last 1.5s.",
        defaults = "APLValueProtectionPaladinDamageTakenLastGlobal.create",
        submenu = {
          "tank"
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
            "ProtectionPaladin"
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
    APLValueDotBaseDuration = {
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
        ui_label = "Dot Base Duration",
        short_description = "The base duration of the DoT.",
        defaults = "APLValueDotBaseDuration.create",
        submenu = {
          "dot"
        },
        fields = {
          spell_id = {
            ui_label = "DoT Spell",
            default = {

            }
          }
        }
      }
    },
    APLValueDotPercentIncrease = {
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
      oneofs = {

      },
      field_order = {
        "spell_id",
        "target_unit",
        "use_base_value"
      },
      _metadata = {
        ui_label = "Dot Damage Increase %",
        short_description = "How much stronger a new DoT would be compared to the old.",
        defaults = "APLValueDotPercentIncrease.create",
        submenu = {
          "dot"
        },
        fields = {
          target_unit = {
            ui_label = "Unit",
            default = {
              type = 5
            }
          },
          spell_id = {
            ui_label = "DoT Spell",
            default = {

            }
          }
        }
      }
    },
    APLActionGroupReference = {
      fields = {
        group_name = {
          id = 1,
          type = "string",
          label = "optional"
        },
        variables = {
          id = 2,
          type = "message",
          label = "repeated",
          message_type = "APLValueVariable"
        }
      },
      oneofs = {

      },
      field_order = {
        "group_name",
        "variables"
      },
      _metadata = {
        ui_label = "Group Reference",
        short_description = "References an action group defined in the Groups section.",
        full_description = [[
			<p>Executes all actions in the referenced group in order. Groups allow you to create reusable action sequences.</p>
			<p>Example: If you have a group named "careful_aim" with actions [serpent_sting, chimera_shot, steady_shot],
			referencing this group will execute those three actions in sequence.</p>
		]],
        defaults = {
          group_name = "",
          variables = {

          }
        },
        submenu = {
          "Groups"
        },
        fields = {
          group_name = {
            ui_label = "Select Group",
            full_description = "Name of the group to reference (must match a group defined in the Groups section)",
            default = ""
          },
          variables = {
            ui_label = "Group Variables",
            full_description = "Variables to pass to the group. These will override the group's internal variables.",
            default = {

            }
          }
        }
      }
    },
    APLValueVariable = {
      fields = {
        name = {
          id = 1,
          type = "string",
          label = "optional"
        },
        value = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "APLValue"
        }
      },
      oneofs = {

      },
      field_order = {
        "name",
        "value"
      },
      _metadata = {
        ui_label = "Variable",
        short_description = "Variables can be used to store complex conditions that can be referenced in the Action Priority L..."
      }
    },
    APLValueVariableRef = {
      fields = {
        name = {
          id = 1,
          type = "string",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "name"
      },
      _metadata = {
        ui_label = "Variable Reference",
        short_description = "Reference a named condition variable",
        defaults = {
          name = ""
        },
        submenu = {
          "Variables"
        },
        fields = {
          name = {
            ui_label = "Select Variable",
            default = ""
          }
        }
      }
    },
    APLValueVariablePlaceholder = {
      fields = {
        name = {
          id = 1,
          type = "string",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "name"
      },
      _metadata = {
        ui_label = "Variable Placeholder",
        short_description = "Placeholder value that gets replaced when group is referenced",
        full_description = [[
			<p>Defines a placeholder value that must be set when this group is referenced. This allows groups to be parameterized.</p>
			<p>Example: If you add a Variable Placeholder named "replace", then when referencing this group, you must provide a value for "replace".</p>
		]],
        defaults = {
          name = ""
        },
        submenu = {
          "Variables"
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
          requires_group = true,
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
            full_description = "Name of the variable placeholder to expose. This name will be used when referencing the group.",
            default = ""
          }
        }
      }
    },
    APLValueActiveItemSwapSet = {
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
        short_description = "Returns <b>True</b> if the specified item swap set is currently active.",
        defaults = "APLValueActiveItemSwapSet.create",
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
            ui_label = "None",
            default = 0
          }
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
          label = "optional"
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
          label = "optional"
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
        unrelenting_storm = {
          id = 14,
          type = "int32",
          label = "optional"
        },
        elemental_precision = {
          id = 15,
          type = "int32",
          label = "optional"
        },
        lightning_mastery = {
          id = 16,
          type = "int32",
          label = "optional"
        },
        elemental_mastery = {
          id = 17,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 16166,
              label = "Elemental Mastery",
              cooldown = {
                raw = "time.Second * 90",
                seconds = 90.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              class_spell_mask = "SpellMaskElementalMastery",
              class_token = "shaman"
            },
            aura = {
              class = "shaman",
              spell_id = 16166,
              label = "Elemental Mastery",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "shaman"
            }
          }
        },
        elemental_shields = {
          id = 18,
          type = "int32",
          label = "optional"
        },
        lightning_overload = {
          id = 19,
          type = "int32",
          label = "optional"
        },
        totem_of_wrath = {
          id = 20,
          type = "bool",
          label = "optional"
        },
        ancestral_knowledge = {
          id = 21,
          type = "int32",
          label = "optional"
        },
        shield_specialization = {
          id = 22,
          type = "int32",
          label = "optional"
        },
        guardian_totems = {
          id = 23,
          type = "int32",
          label = "optional"
        },
        thundering_strikes = {
          id = 24,
          type = "int32",
          label = "optional"
        },
        improved_ghost_wolf = {
          id = 25,
          type = "int32",
          label = "optional"
        },
        improved_lightning_shield = {
          id = 26,
          type = "int32",
          label = "optional"
        },
        enhancing_totems = {
          id = 27,
          type = "int32",
          label = "optional"
        },
        shamanistic_focus = {
          id = 28,
          type = "bool",
          label = "optional"
        },
        anticipation = {
          id = 29,
          type = "int32",
          label = "optional"
        },
        flurry = {
          id = 30,
          type = "int32",
          label = "optional"
        },
        toughness = {
          id = 31,
          type = "int32",
          label = "optional"
        },
        improved_weapon_totems = {
          id = 32,
          type = "int32",
          label = "optional"
        },
        spirit_weapons = {
          id = 33,
          type = "bool",
          label = "optional"
        },
        elemental_weapons = {
          id = 34,
          type = "int32",
          label = "optional"
        },
        mental_quickness = {
          id = 35,
          type = "int32",
          label = "optional"
        },
        weapon_mastery = {
          id = 36,
          type = "int32",
          label = "optional"
        },
        dual_wield_specialization = {
          id = 37,
          type = "int32",
          label = "optional"
        },
        dual_wield = {
          id = 38,
          type = "bool",
          label = "optional"
        },
        stormstrike = {
          id = 39,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "shaman",
              spec = "enhancement",
              spell_id = 17364,
              label = "Stormstrike",
              cooldown = {
                raw = "time.Second * 8",
                seconds = 8.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              class_spell_mask = "SpellMaskStormstrikeCast",
              spell_school = "2",
              proc_mask = "2",
              class_token = "shaman",
              spec_token = "enhancement"
            }
          }
        },
        unleashed_rage = {
          id = 40,
          type = "int32",
          label = "optional"
        },
        shamanistic_rage = {
          id = 41,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 30823,
              label = "Shamanistic Rage",
              cooldown = {
                raw = "time.Minute * 1",
                seconds = 60.0
              },
              major_cooldown = {
                type = "core.CooldownTypeMana"
              },
              flags = "core.SpellFlagReadinessTrinket",
              class_spell_mask = "SpellMaskShamanisticRage",
              related_self_buff = "shaman.ShamanisticRageSpellAura",
              class_token = "shaman"
            },
            aura = {
              class = "shaman",
              spell_id = 30823,
              label = "Shamanistic Rage",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "shaman"
            }
          }
        },
        improved_healing_wave = {
          id = 42,
          type = "int32",
          label = "optional"
        },
        tidal_focus = {
          id = 43,
          type = "int32",
          label = "optional"
        },
        improved_reincarnation = {
          id = 44,
          type = "int32",
          label = "optional"
        },
        ancestral_healing = {
          id = 45,
          type = "int32",
          label = "optional",
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 52752,
              label = "Ancestral Healing",
              flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellHealing",
              damage_multiplier = "1",
              crit_multiplier = "1",
              threat_multiplier = "1",
              class_token = "shaman"
            }
          }
        },
        totemic_focus = {
          id = 46,
          type = "int32",
          label = "optional"
        },
        natures_guidance = {
          id = 47,
          type = "int32",
          label = "optional"
        },
        healing_focus = {
          id = 48,
          type = "int32",
          label = "optional"
        },
        totemic_mastery = {
          id = 49,
          type = "bool",
          label = "optional"
        },
        healing_grace = {
          id = 50,
          type = "int32",
          label = "optional"
        },
        restorative_totems = {
          id = 51,
          type = "int32",
          label = "optional"
        },
        tidal_mastery = {
          id = 52,
          type = "int32",
          label = "optional"
        },
        healing_way = {
          id = 53,
          type = "int32",
          label = "optional"
        },
        natures_swiftness = {
          id = 54,
          type = "bool",
          label = "optional"
        },
        focused_mind = {
          id = 55,
          type = "int32",
          label = "optional"
        },
        purification = {
          id = 56,
          type = "int32",
          label = "optional"
        },
        mana_tide_totem = {
          id = 57,
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
        },
        natures_guardian = {
          id = 58,
          type = "int32",
          label = "optional"
        },
        natures_blessing = {
          id = 59,
          type = "int32",
          label = "optional"
        },
        improved_chain_heal = {
          id = 60,
          type = "int32",
          label = "optional"
        },
        earth_shield = {
          id = 61,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 49284,
              label = "Earth Shield",
              flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
              class_spell_mask = "SpellMaskEarthShield Cast: core.CastConfig{ DefaultCast: core.Cast{ GCD: core.GCDDefault, }, }",
              spell_school = "SpellSchoolNature",
              proc_mask = "2",
              damage_multiplier = "1 + 0.05*float64(shaman.Talents.ImprovedEarthShield)",
              threat_multiplier = "1",
              class_token = "shaman"
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
        "unrelenting_storm",
        "elemental_precision",
        "lightning_mastery",
        "elemental_mastery",
        "elemental_shields",
        "lightning_overload",
        "totem_of_wrath",
        "ancestral_knowledge",
        "shield_specialization",
        "guardian_totems",
        "thundering_strikes",
        "improved_ghost_wolf",
        "improved_lightning_shield",
        "enhancing_totems",
        "shamanistic_focus",
        "anticipation",
        "flurry",
        "toughness",
        "improved_weapon_totems",
        "spirit_weapons",
        "elemental_weapons",
        "mental_quickness",
        "weapon_mastery",
        "dual_wield_specialization",
        "dual_wield",
        "stormstrike",
        "unleashed_rage",
        "shamanistic_rage",
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
        "focused_mind",
        "purification",
        "mana_tide_totem",
        "natures_guardian",
        "natures_blessing",
        "improved_chain_heal",
        "earth_shield"
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
        }
      },
      oneofs = {

      },
      field_order = {
        "earth",
        "air",
        "fire",
        "water"
      }
    },
    FeleAutocastSettings = {
      fields = {
        autocast_fireblast = {
          id = 1,
          type = "bool",
          label = "optional"
        },
        autocast_firenova = {
          id = 2,
          type = "bool",
          label = "optional"
        },
        autocast_immolate = {
          id = 3,
          type = "bool",
          label = "optional"
        },
        autocast_empower = {
          id = 4,
          type = "bool",
          label = "optional"
        },
        no_immolate_wfunleash = {
          id = 5,
          type = "bool",
          label = "optional"
        },
        no_immolate_duration = {
          id = 6,
          type = "double",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "autocast_fireblast",
        "autocast_firenova",
        "autocast_immolate",
        "autocast_empower",
        "no_immolate_wfunleash",
        "no_immolate_duration"
      }
    },
    ShamanOptions = {
      fields = {
        shield = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "ShamanShield"
        },
        imbue_mh = {
          id = 2,
          type = "enum",
          label = "optional",
          enum_type = "ShamanImbue"
        },
        imbue_mh_swap = {
          id = 4,
          type = "enum",
          label = "optional",
          enum_type = "ShamanImbue"
        },
        fele_autocast = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "FeleAutocastSettings"
        }
      },
      oneofs = {

      },
      field_order = {
        "shield",
        "imbue_mh",
        "imbue_mh_swap",
        "fele_autocast"
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
    DruidTalents = {
      fields = {
        starlight_wrath = {
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
        control_of_nature = {
          id = 4,
          type = "int32",
          label = "optional"
        },
        focused_starlight = {
          id = 5,
          type = "int32",
          label = "optional"
        },
        improved_moonfire = {
          id = 6,
          type = "int32",
          label = "optional"
        },
        brambles = {
          id = 7,
          type = "int32",
          label = "optional"
        },
        insect_swarm = {
          id = 8,
          type = "bool",
          label = "optional"
        },
        natures_reach = {
          id = 9,
          type = "int32",
          label = "optional"
        },
        vengeance = {
          id = 10,
          type = "int32",
          label = "optional"
        },
        celestial_focus = {
          id = 11,
          type = "int32",
          label = "optional"
        },
        lunar_guidance = {
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
              class = "druid",
              spec = "balance",
              spell_id = 16886,
              label = "Nature's Grace",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "druid",
              spec_token = "balance"
            }
          }
        },
        moonglow = {
          id = 14,
          type = "int32",
          label = "optional"
        },
        moonfury = {
          id = 15,
          type = "int32",
          label = "optional"
        },
        balance_of_power = {
          id = 16,
          type = "int32",
          label = "optional"
        },
        dreamstate = {
          id = 17,
          type = "int32",
          label = "optional"
        },
        moonkin_form = {
          id = 18,
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
        improved_faerie_fire = {
          id = 19,
          type = "int32",
          label = "optional"
        },
        wrath_of_cenarius = {
          id = 20,
          type = "int32",
          label = "optional"
        },
        force_of_nature = {
          id = 21,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 106737,
              label = "Force Of Nature",
              flags = "SpellFlagAPL",
              class_token = "druid"
            }
          }
        },
        ferocity = {
          id = 22,
          type = "int32",
          label = "optional"
        },
        feral_aggression = {
          id = 23,
          type = "int32",
          label = "optional"
        },
        feral_instinct = {
          id = 24,
          type = "int32",
          label = "optional"
        },
        brutal_impact = {
          id = 25,
          type = "int32",
          label = "optional"
        },
        thick_hide = {
          id = 26,
          type = "int32",
          label = "optional"
        },
        feral_swiftness = {
          id = 27,
          type = "int32",
          label = "optional"
        },
        feral_charge = {
          id = 28,
          type = "bool",
          label = "optional"
        },
        sharpened_claws = {
          id = 29,
          type = "int32",
          label = "optional"
        },
        shredding_attacks = {
          id = 30,
          type = "int32",
          label = "optional"
        },
        predatory_strikes = {
          id = 31,
          type = "int32",
          label = "optional"
        },
        primal_fury = {
          id = 32,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "druid",
              spell_id = 16961,
              label = "Primal Fury",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "druid"
            }
          }
        },
        savage_fury = {
          id = 33,
          type = "int32",
          label = "optional"
        },
        faerie_fire_feral = {
          id = 34,
          type = "bool",
          label = "optional"
        },
        nurturing_instinct = {
          id = 35,
          type = "int32",
          label = "optional"
        },
        heart_of_the_wild = {
          id = 36,
          type = "int32",
          label = "optional",
          _metadata = {
            spell = {
              {
                class = "druid",
                spec = "feralbear",
                spell_id = 108293,
                label = "Heart Of The Wild",
                cooldown = {
                  raw = "time.Minute * 3",
                  seconds = 180.0
                },
                flags = "SpellFlagAPL",
                class_token = "druid",
                spec_token = "feralbear"
              },
              {
                class = "druid",
                spec = "feralcat",
                spell_id = 108292,
                label = "Heart Of The Wild",
                cooldown = {
                  raw = "time.Minute * 6",
                  seconds = 360.0
                },
                flags = "SpellFlagAPL",
                related_self_buff = "cat.HeartOfTheWildAura",
                class_token = "druid",
                spec_token = "feralcat"
              }
            },
            aura = {
              {
                class = "druid",
                spec = "feralbear",
                spell_id = 108293,
                label = "Heart of the Wild",
                duration = {
                  raw = "time.Second * 45",
                  seconds = 45.0
                },
                class_token = "druid",
                spec_token = "feralbear"
              },
              {
                class = "druid",
                spec = "feralcat",
                spell_id = 108292,
                label = "Heart of the Wild",
                duration = {
                  raw = "time.Second * 45",
                  seconds = 45.0
                },
                class_token = "druid",
                spec_token = "feralcat"
              }
            }
          }
        },
        survival_of_the_fittest = {
          id = 37,
          type = "int32",
          label = "optional"
        },
        primal_tenacity = {
          id = 38,
          type = "int32",
          label = "optional"
        },
        leader_of_the_pack = {
          id = 39,
          type = "bool",
          label = "optional",
          _metadata = {
            aura = {
              class = "druid",
              spell_id = 68285,
              label = "Improved Leader of the Pack",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "druid"
            },
            spell = {
              class = "druid",
              spell_id = 34299,
              label = "Leader Of The Pack",
              flags = "core.SpellFlagHelpful | core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell | core.SpellFlagIgnoreModifiers",
              spell_school = "2",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "0",
              class_token = "druid"
            }
          }
        },
        improved_leader_of_the_pack = {
          id = 40,
          type = "int32",
          label = "optional"
        },
        predatory_instincts = {
          id = 41,
          type = "int32",
          label = "optional"
        },
        mangle = {
          id = 42,
          type = "bool",
          label = "optional"
        },
        improved_mark_of_the_wild = {
          id = 43,
          type = "int32",
          label = "optional"
        },
        furor = {
          id = 44,
          type = "int32",
          label = "optional"
        },
        naturalist = {
          id = 45,
          type = "int32",
          label = "optional"
        },
        natures_focus = {
          id = 46,
          type = "int32",
          label = "optional"
        },
        natural_shapeshifter = {
          id = 47,
          type = "int32",
          label = "optional"
        },
        intensity = {
          id = 48,
          type = "int32",
          label = "optional"
        },
        subtlety = {
          id = 49,
          type = "int32",
          label = "optional"
        },
        omen_of_clarity = {
          id = 50,
          type = "bool",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "druid",
                spec = "feralcat",
                label = "Omen of Clarity",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "druid",
                spec_token = "feralcat"
              },
              {
                class = "druid",
                spec = "feralcat",
                spell_id = 135700,
                label = "Clearcasting",
                duration = {
                  raw = "time.Second * 15",
                  seconds = 15.0
                },
                class_token = "druid",
                spec_token = "feralcat"
              }
              ,
              {
                class = "druid",
                spec = "feralcat",
                spell_id = 12536,
                label = "Clearcasting",
                duration = {
                  raw = "time.Second * 15",
                  seconds = 15.0
                },
                class_token = "druid",
                spec_token = "feralcat"
              }
            }
          }
        },
        tranquil_spirit = {
          id = 51,
          type = "int32",
          label = "optional"
        },
        improved_rejuvenation = {
          id = 52,
          type = "int32",
          label = "optional"
        },
        natures_swiftness = {
          id = 53,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 132158,
              label = "Natures Swiftness",
              cooldown = {
                raw = "time.Minute * 1",
                seconds = 60.0
              },
              flags = "SpellFlagNoOnCastComplete",
              related_self_buff = "druid.NaturesSwiftnessAura",
              class_token = "druid"
            },
            aura = {
              class = "druid",
              spell_id = 132158,
              label = "Nature's Swiftness",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "druid"
            }
          }
        },
        gift_of_nature = {
          id = 54,
          type = "int32",
          label = "optional"
        },
        improved_tranquility = {
          id = 55,
          type = "int32",
          label = "optional"
        },
        empowered_touch = {
          id = 56,
          type = "int32",
          label = "optional"
        },
        improved_regrowth = {
          id = 57,
          type = "int32",
          label = "optional"
        },
        living_spirit = {
          id = 58,
          type = "int32",
          label = "optional"
        },
        swiftmend = {
          id = 59,
          type = "bool",
          label = "optional"
        },
        natural_perfection = {
          id = 60,
          type = "int32",
          label = "optional"
        },
        empowered_rejuvenation = {
          id = 61,
          type = "int32",
          label = "optional"
        },
        tree_of_life = {
          id = 62,
          type = "bool",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "starlight_wrath",
        "natures_grasp",
        "improved_natures_grasp",
        "control_of_nature",
        "focused_starlight",
        "improved_moonfire",
        "brambles",
        "insect_swarm",
        "natures_reach",
        "vengeance",
        "celestial_focus",
        "lunar_guidance",
        "natures_grace",
        "moonglow",
        "moonfury",
        "balance_of_power",
        "dreamstate",
        "moonkin_form",
        "improved_faerie_fire",
        "wrath_of_cenarius",
        "force_of_nature",
        "ferocity",
        "feral_aggression",
        "feral_instinct",
        "brutal_impact",
        "thick_hide",
        "feral_swiftness",
        "feral_charge",
        "sharpened_claws",
        "shredding_attacks",
        "predatory_strikes",
        "primal_fury",
        "savage_fury",
        "faerie_fire_feral",
        "nurturing_instinct",
        "heart_of_the_wild",
        "survival_of_the_fittest",
        "primal_tenacity",
        "leader_of_the_pack",
        "improved_leader_of_the_pack",
        "predatory_instincts",
        "mangle",
        "improved_mark_of_the_wild",
        "furor",
        "naturalist",
        "natures_focus",
        "natural_shapeshifter",
        "intensity",
        "subtlety",
        "omen_of_clarity",
        "tranquil_spirit",
        "improved_rejuvenation",
        "natures_swiftness",
        "gift_of_nature",
        "improved_tranquility",
        "empowered_touch",
        "improved_regrowth",
        "living_spirit",
        "swiftmend",
        "natural_perfection",
        "empowered_rejuvenation",
        "tree_of_life"
      }
    },
    DruidOptions = {
      fields = {
        innervate_target = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "UnitReference"
        }
      },
      oneofs = {

      },
      field_order = {
        "innervate_target"
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
    FeralCatDruid = {
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
    FeralBearDruid = {
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
        iron_will = {
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
            spell = {
              class = "warrior",
              spell_id = 115768,
              label = "Deep Wounds",
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreArmor | core.SpellFlagIgnoreAttackerModifiers | SpellFlagBleed | core.SpellFlagPassiveSpell",
              spell_school = "2",
              proc_mask = "2",
              damage_multiplier = "1.0",
              crit_multiplier = "warrior.DefaultCritMultiplier()",
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
        poleaxe_specialization = {
          id = 12,
          type = "int32",
          label = "optional"
        },
        death_wish = {
          id = 13,
          type = "bool",
          label = "optional"
        },
        mace_specialization = {
          id = 14,
          type = "int32",
          label = "optional"
        },
        sword_specialization = {
          id = 15,
          type = "int32",
          label = "optional"
        },
        improved_intercept = {
          id = 16,
          type = "int32",
          label = "optional"
        },
        improved_hamstring = {
          id = 17,
          type = "int32",
          label = "optional"
        },
        improved_disciplines = {
          id = 18,
          type = "int32",
          label = "optional"
        },
        blood_frenzy = {
          id = 19,
          type = "int32",
          label = "optional"
        },
        mortal_strike = {
          id = 20,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "warrior",
              spec = "_arms",
              spell_id = 12294,
              label = "Mortal Strike",
              cooldown = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              flags = "core.SpellFlagAPL | core.SpellFlagMeleeMetrics",
              class_spell_mask = "SpellMaskMortalStrike",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "2.15",
              crit_multiplier = "war.DefaultCritMultiplier()",
              max_range = "5",
              class_token = "warrior",
              spec_token = "_arms"
            }
          }
        },
        second_wind = {
          id = 21,
          type = "int32",
          label = "optional"
        },
        improved_mortal_strike = {
          id = 22,
          type = "int32",
          label = "optional"
        },
        endless_rage = {
          id = 23,
          type = "bool",
          label = "optional"
        },
        booming_voice = {
          id = 24,
          type = "int32",
          label = "optional"
        },
        cruelty = {
          id = 25,
          type = "int32",
          label = "optional"
        },
        improved_demoralizing_shout = {
          id = 26,
          type = "int32",
          label = "optional"
        },
        unbridled_wrath = {
          id = 27,
          type = "int32",
          label = "optional"
        },
        improved_cleave = {
          id = 28,
          type = "int32",
          label = "optional"
        },
        piercing_howl = {
          id = 29,
          type = "bool",
          label = "optional"
        },
        blood_craze = {
          id = 30,
          type = "int32",
          label = "optional"
        },
        commanding_presence = {
          id = 31,
          type = "int32",
          label = "optional"
        },
        dual_wield_specialization = {
          id = 32,
          type = "int32",
          label = "optional"
        },
        improved_execute = {
          id = 33,
          type = "int32",
          label = "optional"
        },
        enrage = {
          id = 34,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "warrior",
                spell_id = 12880,
                label = "Enrage",
                tag = "EnrageEffect",
                duration = {
                  cases = {
                    {
                      raw = "time.Second * 6",
                      seconds = 6.0
                    },
                    {
                      condition = "war.Spec == proto.Spec_SpecFuryWarrior",
                      raw = "time.Second * 8",
                      seconds = 8.0
                    }
                  },
                  raw = "time.Second * 6"
                },
                duration_raw = "duration",
                class_token = "warrior"
              },
              {
                class = "druid",
                spec = "feralbear",
                spell_id = 5229,
                label = "Enrage",
                duration = {
                  raw = "10*time.Second + 1",
                  seconds = 11.0
                },
                class_token = "druid",
                spec_token = "feralbear"
              }
            },
            spell = {
              class = "druid",
              spec = "feralbear",
              spell_id = 5229,
              label = "Enrage",
              cooldown = {
                raw = "time.Minute",
                seconds = 60.0
              },
              flags = "SpellFlagAPL",
              class_token = "druid",
              spec_token = "feralbear"
            }
          }
        },
        improved_slam = {
          id = 35,
          type = "int32",
          label = "optional"
        },
        sweeping_strikes = {
          id = 36,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              {
                class = "warrior",
                spec = "_arms",
                spell_id = 1250616,
                label = "Sweeping Strikes",
                cooldown = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                class_spell_mask = "SpellMaskSweepingStrikes",
                spell_school = "2",
                class_token = "warrior",
                spec_token = "_arms"
              },
              {
                class = "warrior",
                spec = "_arms",
                spell_id = 26654,
                label = "Sweeping Strikes",
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagPassiveSpell | core.SpellFlagNoOnCastComplete",
                class_spell_mask = "SpellMaskSweepingStrikesNormalizedHit",
                spell_school = "2",
                proc_mask = "ProcMaskMeleeMHSpecial | ProcMaskMeleeOHSpecial",
                damage_multiplier = "0.5 + 0.1",
                threat_multiplier = "1",
                class_token = "warrior",
                spec_token = "_arms"
              },
              {
                class = "warrior",
                spec = "_arms",
                spell_id = 12723,
                label = "Sweeping Strikes",
                flags = "core.SpellFlagIgnoreArmor | core.SpellFlagIgnoreModifiers | core.SpellFlagMeleeMetrics | core.SpellFlagPassiveSpell | core.SpellFlagNoOnCastComplete",
                class_spell_mask = "SpellMaskSweepingStrikesHit",
                spell_school = "2",
                proc_mask = "ProcMaskMeleeMHSpecial | ProcMaskMeleeOHSpecial",
                damage_multiplier = "0.5",
                threat_multiplier = "1",
                class_token = "warrior",
                spec_token = "_arms"
              }
            }
          }
        },
        weapon_mastery = {
          id = 37,
          type = "int32",
          label = "optional"
        },
        improved_berserker_rage = {
          id = 38,
          type = "int32",
          label = "optional"
        },
        flurry = {
          id = 39,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "warrior",
              spec = "dps",
              spell_id = 12968,
              label = "Flurry",
              duration = {
                raw = "15 * time.Second",
                seconds = 15.0
              },
              class_token = "warrior",
              spec_token = "dps"
            }
          }
        },
        precision = {
          id = 40,
          type = "int32",
          label = "optional"
        },
        bloodthirst = {
          id = 41,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "warrior",
              spec = "dps",
              spell_id = 23881,
              label = "Bloodthirst",
              cooldown = {
                raw = "time.Millisecond * 4500",
                seconds = 4.5
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              class_spell_mask = "SpellMaskBloodthirst",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "0.9 * 1.2",
              crit_multiplier = "war.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "5",
              class_token = "warrior",
              spec_token = "dps"
            }
          }
        },
        improved_whirlwind = {
          id = 42,
          type = "int32",
          label = "optional"
        },
        improved_berserker_stance = {
          id = 43,
          type = "int32",
          label = "optional"
        },
        rampage = {
          id = 44,
          type = "bool",
          label = "optional"
        },
        improved_bloodrage = {
          id = 45,
          type = "int32",
          label = "optional"
        },
        tactical_mastery = {
          id = 46,
          type = "int32",
          label = "optional"
        },
        anticipation = {
          id = 47,
          type = "int32",
          label = "optional"
        },
        shield_specialization = {
          id = 48,
          type = "int32",
          label = "optional"
        },
        toughness = {
          id = 49,
          type = "int32",
          label = "optional"
        },
        last_stand = {
          id = 50,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "warrior",
              spec = "protection",
              spell_id = 12975,
              label = "Last Stand",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              major_cooldown = {
                type = "core.CooldownTypeSurvival",
                priority = "core.CooldownPriorityLow"
              },
              flags = "core.SpellFlagReadinessTrinket",
              class_spell_mask = "SpellMaskLastStand",
              related_self_buff = "war.LastStandAura",
              class_token = "warrior",
              spec_token = "protection"
            },
            aura = {
              class = "warrior",
              spec = "protection",
              spell_id = 12975,
              label = "Last Stand",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "warrior",
              spec_token = "protection"
            }
          }
        },
        improved_shield_block = {
          id = 51,
          type = "bool",
          label = "optional"
        },
        improved_revenge = {
          id = 52,
          type = "int32",
          label = "optional"
        },
        defiance = {
          id = 53,
          type = "int32",
          label = "optional"
        },
        improved_sunder_armor = {
          id = 54,
          type = "int32",
          label = "optional"
        },
        improved_disarm = {
          id = 55,
          type = "int32",
          label = "optional"
        },
        improved_taunt = {
          id = 56,
          type = "int32",
          label = "optional"
        },
        improved_shield_wall = {
          id = 57,
          type = "int32",
          label = "optional"
        },
        concussion_blow = {
          id = 58,
          type = "bool",
          label = "optional"
        },
        improved_shield_bash = {
          id = 59,
          type = "int32",
          label = "optional"
        },
        shield_mastery = {
          id = 60,
          type = "int32",
          label = "optional"
        },
        one_handed_weapon_specialization = {
          id = 61,
          type = "int32",
          label = "optional"
        },
        improved_defensive_stance = {
          id = 62,
          type = "int32",
          label = "optional"
        },
        shield_slam = {
          id = 63,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "warrior",
              spec = "protection",
              spell_id = 23922,
              label = "Shield Slam",
              cooldown = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              class_spell_mask = "SpellMaskShieldSlam",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              crit_multiplier = "war.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "5",
              class_token = "warrior",
              spec_token = "protection"
            }
          }
        },
        focused_rage = {
          id = 64,
          type = "int32",
          label = "optional"
        },
        vitality = {
          id = 65,
          type = "int32",
          label = "optional"
        },
        devastate = {
          id = 66,
          type = "bool",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "improved_heroic_strike",
        "deflection",
        "improved_rend",
        "improved_charge",
        "iron_will",
        "improved_thunder_clap",
        "improved_overpower",
        "anger_management",
        "deep_wounds",
        "two_handed_weapon_specialization",
        "impale",
        "poleaxe_specialization",
        "death_wish",
        "mace_specialization",
        "sword_specialization",
        "improved_intercept",
        "improved_hamstring",
        "improved_disciplines",
        "blood_frenzy",
        "mortal_strike",
        "second_wind",
        "improved_mortal_strike",
        "endless_rage",
        "booming_voice",
        "cruelty",
        "improved_demoralizing_shout",
        "unbridled_wrath",
        "improved_cleave",
        "piercing_howl",
        "blood_craze",
        "commanding_presence",
        "dual_wield_specialization",
        "improved_execute",
        "enrage",
        "improved_slam",
        "sweeping_strikes",
        "weapon_mastery",
        "improved_berserker_rage",
        "flurry",
        "precision",
        "bloodthirst",
        "improved_whirlwind",
        "improved_berserker_stance",
        "rampage",
        "improved_bloodrage",
        "tactical_mastery",
        "anticipation",
        "shield_specialization",
        "toughness",
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
        "shield_mastery",
        "one_handed_weapon_specialization",
        "improved_defensive_stance",
        "shield_slam",
        "focused_rage",
        "vitality",
        "devastate"
      }
    },
    WarriorOptions = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      }
    },
    DPSWarrior = {
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
    ProtectionWarrior = {
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
          label = "optional"
        },
        magic_attunement = {
          id = 7,
          type = "int32",
          label = "optional"
        },
        arcane_impact = {
          id = 8,
          type = "int32",
          label = "optional"
        },
        arcane_fortitude = {
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
        improved_blink = {
          id = 13,
          type = "int32",
          label = "optional"
        },
        presence_of_mind = {
          id = 14,
          type = "bool",
          label = "optional"
        },
        arcane_mind = {
          id = 15,
          type = "int32",
          label = "optional"
        },
        prismatic_cloak = {
          id = 16,
          type = "int32",
          label = "optional"
        },
        arcane_instability = {
          id = 17,
          type = "int32",
          label = "optional"
        },
        arcane_potency = {
          id = 18,
          type = "int32",
          label = "optional"
        },
        empowered_arcane_missiles = {
          id = 19,
          type = "int32",
          label = "optional"
        },
        arcane_power = {
          id = 20,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "mage",
              spec = "_arcane",
              spell_id = 12042,
              label = "Arcane Power",
              cooldown = {
                raw = "time.Second * 90",
                seconds = 90.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              flags = "SpellFlagNoOnCastComplete",
              class_spell_mask = "MageSpellArcanePower",
              related_self_buff = "arcane.ArcanePowerCDAura",
              class_token = "mage",
              spec_token = "_arcane"
            },
            aura = {
              class = "mage",
              spec = "_arcane",
              spell_id = 12042,
              label = "Arcane Power",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "mage",
              spec_token = "_arcane"
            }
          }
        },
        spell_power = {
          id = 21,
          type = "int32",
          label = "optional"
        },
        mind_mastery = {
          id = 22,
          type = "int32",
          label = "optional"
        },
        slow = {
          id = 23,
          type = "bool",
          label = "optional"
        },
        improved_fireball = {
          id = 24,
          type = "int32",
          label = "optional"
        },
        impact = {
          id = 25,
          type = "int32",
          label = "optional"
        },
        ignite = {
          id = 26,
          type = "int32",
          label = "optional"
        },
        flame_throwing = {
          id = 27,
          type = "int32",
          label = "optional"
        },
        improved_fire_blast = {
          id = 28,
          type = "int32",
          label = "optional"
        },
        incineration = {
          id = 29,
          type = "int32",
          label = "optional"
        },
        improved_flamestrike = {
          id = 30,
          type = "int32",
          label = "optional"
        },
        pyroblast = {
          id = 31,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              {
                class = "mage",
                spec = "_fire",
                spell_id = 11366,
                label = "PyroblastDoT",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
                class_spell_mask = "MageSpellPyroblastDot",
                spell_school = "SpellSchoolFire",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "fire.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "mage",
                spec_token = "_fire"
              },
              {
                class = "mage",
                spec = "_fire",
                spell_id = 11366,
                label = "Pyroblast",
                flags = "SpellFlagAPL",
                class_spell_mask = "MageSpellPyroblast",
                spell_school = "SpellSchoolFire",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "fire.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "mage",
                spec_token = "_fire"
              }
            }
          }
        },
        burning_soul = {
          id = 32,
          type = "int32",
          label = "optional"
        },
        improved_scorch = {
          id = 33,
          type = "int32",
          label = "optional"
        },
        molten_shields = {
          id = 34,
          type = "int32",
          label = "optional"
        },
        master_of_elements = {
          id = 35,
          type = "int32",
          label = "optional"
        },
        playing_with_fire = {
          id = 36,
          type = "int32",
          label = "optional"
        },
        critical_mass = {
          id = 37,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "mage",
              spec = "_fire",
              label = "Critical Mass",
              class_token = "mage",
              spec_token = "_fire"
            }
          }
        },
        blast_wave = {
          id = 38,
          type = "bool",
          label = "optional"
        },
        blazing_speed = {
          id = 39,
          type = "int32",
          label = "optional"
        },
        fire_power = {
          id = 40,
          type = "int32",
          label = "optional"
        },
        pyromaniac = {
          id = 41,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "mage",
              spec = "_fire",
              spell_id = 132209,
              label = "Pyromaniac",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "mage",
              spec_token = "_fire"
            }
          }
        },
        combustion = {
          id = 42,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              {
                class = "mage",
                spec = "_fire",
                spell_id = 11129,
                label = "Combustion Dot",
                flags = "core.SpellFlagIgnoreModifiers | core.SpellFlagNoSpellMods | core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
                class_spell_mask = "MageSpellCombustionDot",
                spell_school = "SpellSchoolFire",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "fire.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "mage",
                spec_token = "_fire"
              },
              {
                class = "mage",
                spec = "_fire",
                spell_id = 11129,
                label = "Combustion",
                cooldown = {
                  raw = "time.Second * 45",
                  seconds = 45.0
                },
                flags = "SpellFlagAPL",
                class_spell_mask = "MageSpellCombustion",
                spell_school = "SpellSchoolFire",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1.0",
                crit_multiplier = "fire.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "mage",
                spec_token = "_fire"
              }
            }
          }
        },
        molten_fury = {
          id = 43,
          type = "int32",
          label = "optional"
        },
        empowered_fireball = {
          id = 44,
          type = "int32",
          label = "optional"
        },
        dragons_breath = {
          id = 45,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "mage",
              spec = "_fire",
              spell_id = 31661,
              label = "Dragons Breath",
              cooldown = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              flags = "core.SpellFlagAoE | core.SpellFlagAPL",
              class_spell_mask = "MageSpellDragonsBreath",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "fire.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "mage",
              spec_token = "_fire"
            }
          }
        },
        frost_warding = {
          id = 46,
          type = "int32",
          label = "optional"
        },
        improved_frostbolt = {
          id = 47,
          type = "int32",
          label = "optional"
        },
        elemental_precision = {
          id = 48,
          type = "int32",
          label = "optional"
        },
        ice_shards = {
          id = 49,
          type = "int32",
          label = "optional"
        },
        frostbite = {
          id = 50,
          type = "int32",
          label = "optional"
        },
        improved_frost_nova = {
          id = 51,
          type = "int32",
          label = "optional"
        },
        permafrost = {
          id = 52,
          type = "int32",
          label = "optional"
        },
        piercing_ice = {
          id = 53,
          type = "int32",
          label = "optional"
        },
        icy_veins = {
          id = 54,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 12472,
              label = "Icy Veins",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              flags = "SpellFlagNoOnCastComplete",
              class_spell_mask = "MageSpellIcyVeins",
              class_token = "mage"
            },
            aura = {
              class = "mage",
              spell_id = 12472,
              label = "Icy Veins",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "mage"
            }
          }
        },
        improved_blizzard = {
          id = 55,
          type = "int32",
          label = "optional"
        },
        arctic_reach = {
          id = 56,
          type = "int32",
          label = "optional"
        },
        frost_channeling = {
          id = 57,
          type = "int32",
          label = "optional"
        },
        shatter = {
          id = 58,
          type = "int32",
          label = "optional"
        },
        frozen_core = {
          id = 59,
          type = "int32",
          label = "optional"
        },
        cold_snap = {
          id = 60,
          type = "bool",
          label = "optional"
        },
        improved_cone_of_cold = {
          id = 61,
          type = "int32",
          label = "optional"
        },
        ice_floes = {
          id = 62,
          type = "int32",
          label = "optional"
        },
        winters_chill = {
          id = 63,
          type = "int32",
          label = "optional"
        },
        ice_barrier = {
          id = 64,
          type = "bool",
          label = "optional"
        },
        arctic_winds = {
          id = 65,
          type = "int32",
          label = "optional"
        },
        empowered_frostbolt = {
          id = 66,
          type = "int32",
          label = "optional"
        },
        summon_water_elemental = {
          id = 67,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "mage",
              spec = "_frost",
              spell_id = 31687,
              label = "Summon Water Elemental",
              cooldown = {
                raw = "time.Minute * 1",
                seconds = 60.0
              },
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
              class_token = "mage",
              spec_token = "_frost"
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
        "arcane_impact",
        "arcane_fortitude",
        "improved_mana_shield",
        "improved_counterspell",
        "arcane_meditation",
        "improved_blink",
        "presence_of_mind",
        "arcane_mind",
        "prismatic_cloak",
        "arcane_instability",
        "arcane_potency",
        "empowered_arcane_missiles",
        "arcane_power",
        "spell_power",
        "mind_mastery",
        "slow",
        "improved_fireball",
        "impact",
        "ignite",
        "flame_throwing",
        "improved_fire_blast",
        "incineration",
        "improved_flamestrike",
        "pyroblast",
        "burning_soul",
        "improved_scorch",
        "molten_shields",
        "master_of_elements",
        "playing_with_fire",
        "critical_mass",
        "blast_wave",
        "blazing_speed",
        "fire_power",
        "pyromaniac",
        "combustion",
        "molten_fury",
        "empowered_fireball",
        "dragons_breath",
        "frost_warding",
        "improved_frostbolt",
        "elemental_precision",
        "ice_shards",
        "frostbite",
        "improved_frost_nova",
        "permafrost",
        "piercing_ice",
        "icy_veins",
        "improved_blizzard",
        "arctic_reach",
        "frost_channeling",
        "shatter",
        "frozen_core",
        "cold_snap",
        "improved_cone_of_cold",
        "ice_floes",
        "winters_chill",
        "ice_barrier",
        "arctic_winds",
        "empowered_frostbolt",
        "summon_water_elemental"
      }
    },
    MageOptions = {
      fields = {
        default_mage_armor = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "MageArmor"
        }
      },
      oneofs = {

      },
      field_order = {
        "default_mage_armor"
      }
    },
    Mage = {
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
        focused_fire = {
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
        animal_handler = {
          id = 15,
          type = "int32",
          label = "optional"
        },
        frenzy = {
          id = 16,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "hunter",
              spec = "_beast_mastery",
              spell_id = 19623,
              label = "Frenzy",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "hunter",
              spec_token = "_beast_mastery"
            }
          }
        },
        ferocious_inspiration = {
          id = 17,
          type = "int32",
          label = "optional"
        },
        bestial_wrath = {
          id = 18,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "hunter",
              spec = "_beast_mastery",
              spell_id = 19574,
              label = "Bestial Wrath",
              cooldown = {
                raw = "time.Minute * 1",
                seconds = 60.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              flags = "core.SpellFlagReadinessTrinket",
              class_spell_mask = "HunterSpellBestialWrath",
              class_token = "hunter",
              spec_token = "_beast_mastery"
            },
            aura = {
              {
                class = "hunter",
                spec = "_beast_mastery",
                spell_id = 19574,
                label = "Bestial Wrath",
                duration = {
                  cases = {
                    {
                      condition = "bmHunter.CouldHaveSetBonus(hunter.YaungolSlayersBattlegear, 4)",
                      raw = "(16) * time.Second",
                      seconds = 16.0
                    },
                    {
                      condition = "!(bmHunter.CouldHaveSetBonus(hunter.YaungolSlayersBattlegear, 4))",
                      raw = "(10) * time.Second",
                      seconds = 10.0
                    }
                  },
                  raw = "core.TernaryDuration(bmHunter.CouldHaveSetBonus(hunter.YaungolSlayersBattlegear, 4), 16, 10) * time.Second"
                },
                duration_raw = "duration",
                class_token = "hunter",
                spec_token = "_beast_mastery"
              },
              {
                class = "hunter",
                spec = "_beast_mastery",
                spell_id = 19574,
                label = "Bestial Wrath Pet",
                duration = {
                  cases = {
                    {
                      condition = "bmHunter.CouldHaveSetBonus(hunter.YaungolSlayersBattlegear, 4)",
                      raw = "(16) * time.Second",
                      seconds = 16.0
                    },
                    {
                      condition = "!(bmHunter.CouldHaveSetBonus(hunter.YaungolSlayersBattlegear, 4))",
                      raw = "(10) * time.Second",
                      seconds = 10.0
                    }
                  },
                  raw = "core.TernaryDuration(bmHunter.CouldHaveSetBonus(hunter.YaungolSlayersBattlegear, 4), 16, 10) * time.Second"
                },
                duration_raw = "duration",
                class_token = "hunter",
                spec_token = "_beast_mastery"
              }
            }
          }
        },
        catlike_reflexes = {
          id = 19,
          type = "int32",
          label = "optional"
        },
        serpents_swiftness = {
          id = 20,
          type = "int32",
          label = "optional"
        },
        the_beast_within = {
          id = 21,
          type = "bool",
          label = "optional"
        },
        improved_concussive_shot = {
          id = 22,
          type = "int32",
          label = "optional"
        },
        lethal_shots = {
          id = 23,
          type = "int32",
          label = "optional"
        },
        improved_hunters_mark = {
          id = 24,
          type = "int32",
          label = "optional"
        },
        efficiency = {
          id = 25,
          type = "int32",
          label = "optional"
        },
        go_for_the_throat = {
          id = 26,
          type = "int32",
          label = "optional"
        },
        improved_arcane_shot = {
          id = 27,
          type = "int32",
          label = "optional"
        },
        aimed_shot = {
          id = 28,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              {
                class = "hunter",
                spec = "_marksmanship",
                spell_id = 19434,
                label = "Aimed Shot",
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagRanged | core.SpellFlagAPL",
                class_spell_mask = "HunterSpellAimedShot",
                spell_school = "2",
                proc_mask = "ProcMaskRangedSpecial",
                damage_multiplier = "4.5",
                crit_multiplier = "mmHunter.DefaultCritMultiplier()",
                threat_multiplier = "1",
                max_range = "40",
                class_token = "hunter",
                spec_token = "_marksmanship"
              },
              {
                class = "hunter",
                spec = "_marksmanship",
                spell_id = 82928,
                label = "Aimed Shot",
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagRanged | core.SpellFlagAPL",
                class_spell_mask = "HunterSpellAimedShot",
                spell_school = "2",
                proc_mask = "ProcMaskRangedSpecial",
                damage_multiplier = "4.5",
                crit_multiplier = "mmHunter.DefaultCritMultiplier()",
                threat_multiplier = "1",
                max_range = "40",
                class_token = "hunter",
                spec_token = "_marksmanship"
              }
            }
          }
        },
        rapid_killing = {
          id = 29,
          type = "int32",
          label = "optional"
        },
        improved_stings = {
          id = 30,
          type = "int32",
          label = "optional"
        },
        mortal_shots = {
          id = 31,
          type = "int32",
          label = "optional"
        },
        concussive_barrage = {
          id = 32,
          type = "int32",
          label = "optional"
        },
        scatter_shot = {
          id = 33,
          type = "bool",
          label = "optional"
        },
        barrage = {
          id = 34,
          type = "int32",
          label = "optional",
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 120360,
              label = "Barrage",
              cooldown = {
                raw = "30 * time.Second",
                seconds = 30.0
              },
              flags = "core.SpellFlagRanged | core.SpellFlagChanneled | core.SpellFlagAPL",
              class_spell_mask = "HunterSpellBarrage",
              spell_school = "2",
              proc_mask = "ProcMaskRangedSpecial",
              damage_multiplier = "1",
              damage_multiplier_additive = "1",
              crit_multiplier = "hunter.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "40",
              class_token = "hunter"
            }
          }
        },
        combat_experience = {
          id = 35,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "hunter",
              spell_id = 20782,
              label = "Combat Experience",
              class_token = "hunter"
            }
          }
        },
        ranged_weapon_specialization = {
          id = 36,
          type = "int32",
          label = "optional"
        },
        careful_aim = {
          id = 37,
          type = "int32",
          label = "optional"
        },
        trueshot_aura = {
          id = 38,
          type = "bool",
          label = "optional"
        },
        improved_barrage = {
          id = 39,
          type = "int32",
          label = "optional"
        },
        master_marksman = {
          id = 40,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "hunter",
                spec = "_marksmanship",
                label = "Master Marksman Internal",
                class_token = "hunter",
                spec_token = "_marksmanship"
              },
              {
                class = "hunter",
                spec = "_marksmanship",
                spell_id = 34487,
                label = "Master Marksman",
                duration = {
                  raw = "time.Second * 30",
                  seconds = 30.0
                },
                class_token = "hunter",
                spec_token = "_marksmanship"
              },
              {
                class = "hunter",
                spec = "_marksmanship",
                spell_id = 82925,
                label = "Ready, Set, Aim...",
                duration = {
                  raw = "time.Second * 8",
                  seconds = 8.0
                },
                class_token = "hunter",
                spec_token = "_marksmanship"
              }
            }
          }
        },
        silencing_shot = {
          id = 41,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 34490,
              label = "Silencing Shot",
              cooldown = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
              spell_school = "2",
              proc_mask = "ProcMaskRangedSpecial",
              threat_multiplier = "1",
              max_range = "40",
              class_token = "hunter"
            }
          }
        },
        monster_slaying = {
          id = 42,
          type = "int32",
          label = "optional"
        },
        humanoid_slaying = {
          id = 43,
          type = "int32",
          label = "optional"
        },
        hawk_eye = {
          id = 44,
          type = "int32",
          label = "optional"
        },
        savage_strikes = {
          id = 45,
          type = "int32",
          label = "optional"
        },
        entrapment = {
          id = 46,
          type = "int32",
          label = "optional"
        },
        deflection = {
          id = 47,
          type = "int32",
          label = "optional"
        },
        improved_wing_clip = {
          id = 48,
          type = "int32",
          label = "optional"
        },
        clever_traps = {
          id = 49,
          type = "int32",
          label = "optional"
        },
        survivalist = {
          id = 50,
          type = "int32",
          label = "optional"
        },
        deterrence = {
          id = 51,
          type = "bool",
          label = "optional"
        },
        trap_mastery = {
          id = 52,
          type = "int32",
          label = "optional"
        },
        surefooted = {
          id = 53,
          type = "int32",
          label = "optional"
        },
        improved_feign_death = {
          id = 54,
          type = "int32",
          label = "optional"
        },
        survival_instincts = {
          id = 55,
          type = "int32",
          label = "optional",
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 61336,
              label = "Survival Instincts",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              related_self_buff = "druid.SurvivalInstinctsCDAura",
              class_token = "druid"
            },
            aura = {
              class = "druid",
              spell_id = 61336,
              label = "Survival Instincts",
              duration = {
                raw = "time.Second * 12",
                seconds = 12.0
              },
              class_token = "druid"
            }
          }
        },
        killer_instinct = {
          id = 56,
          type = "int32",
          label = "optional"
        },
        counterattack = {
          id = 57,
          type = "bool",
          label = "optional"
        },
        resourcefulness = {
          id = 58,
          type = "int32",
          label = "optional"
        },
        lightning_reflexes = {
          id = 59,
          type = "int32",
          label = "optional"
        },
        thrill_of_the_hunt = {
          id = 60,
          type = "int32",
          label = "optional"
        },
        wyvern_sting = {
          id = 61,
          type = "bool",
          label = "optional"
        },
        expose_weakness = {
          id = 62,
          type = "int32",
          label = "optional"
        },
        master_tactician = {
          id = 63,
          type = "int32",
          label = "optional"
        },
        readiness = {
          id = 64,
          type = "bool",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "improved_aspect_of_the_hawk",
        "endurance_training",
        "focused_fire",
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
        "animal_handler",
        "frenzy",
        "ferocious_inspiration",
        "bestial_wrath",
        "catlike_reflexes",
        "serpents_swiftness",
        "the_beast_within",
        "improved_concussive_shot",
        "lethal_shots",
        "improved_hunters_mark",
        "efficiency",
        "go_for_the_throat",
        "improved_arcane_shot",
        "aimed_shot",
        "rapid_killing",
        "improved_stings",
        "mortal_shots",
        "concussive_barrage",
        "scatter_shot",
        "barrage",
        "combat_experience",
        "ranged_weapon_specialization",
        "careful_aim",
        "trueshot_aura",
        "improved_barrage",
        "master_marksman",
        "silencing_shot",
        "monster_slaying",
        "humanoid_slaying",
        "hawk_eye",
        "savage_strikes",
        "entrapment",
        "deflection",
        "improved_wing_clip",
        "clever_traps",
        "survivalist",
        "deterrence",
        "trap_mastery",
        "surefooted",
        "improved_feign_death",
        "survival_instincts",
        "killer_instinct",
        "counterattack",
        "resourcefulness",
        "lightning_reflexes",
        "thrill_of_the_hunt",
        "wyvern_sting",
        "expose_weakness",
        "master_tactician",
        "readiness"
      }
    },
    HunterOptions = {
      fields = {
        pet_type = {
          id = 2,
          type = "enum",
          label = "optional",
          enum_type = "PetType"
        },
        pet_spec = {
          id = 3,
          type = "enum",
          label = "optional",
          enum_type = "PetSpec"
        },
        pet_uptime = {
          id = 4,
          type = "double",
          label = "optional"
        },
        time_to_trap_weave_ms = {
          id = 5,
          type = "double",
          label = "optional"
        },
        use_hunters_mark = {
          id = 6,
          type = "bool",
          label = "optional"
        },
        use_aq_tier = {
          id = 7,
          type = "bool",
          label = "optional"
        },
        use_naxx_tier = {
          id = 8,
          type = "bool",
          label = "optional"
        },
        glaive_toss_success = {
          id = 9,
          type = "double",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "pet_type",
        "pet_spec",
        "pet_uptime",
        "time_to_trap_weave_ms",
        "use_hunters_mark",
        "use_aq_tier",
        "use_naxx_tier",
        "glaive_toss_success"
      }
    },
    Hunter = {
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
        puncturing_wounds = {
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
          label = "optional"
        },
        fleet_footed = {
          id = 12,
          type = "int32",
          label = "optional"
        },
        cold_blood = {
          id = 13,
          type = "bool",
          label = "optional"
        },
        improved_kidney_shot = {
          id = 14,
          type = "int32",
          label = "optional"
        },
        quick_recovery = {
          id = 15,
          type = "int32",
          label = "optional"
        },
        seal_fate = {
          id = 16,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "rogue",
              spell_id = 14190,
              label = "Seal Fate",
              class_token = "rogue"
            }
          }
        },
        master_poisoner = {
          id = 17,
          type = "int32",
          label = "optional"
        },
        vigor = {
          id = 18,
          type = "bool",
          label = "optional"
        },
        deadened_nerves = {
          id = 19,
          type = "int32",
          label = "optional"
        },
        find_weakness = {
          id = 20,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "rogue",
                label = "Find Weakness",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "rogue"
              },
              {
                class = "rogue",
                spell_id = 91023,
                label = "Find Weakness",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "rogue"
              }
            }
          }
        },
        mutilate = {
          id = 21,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 1329,
              label = "Mutilate",
              flags = "core.SpellFlagMeleeMetrics | rogue.SpellFlagBuilder | core.SpellFlagAPL",
              class_spell_mask = "RogueSpellMutilate",
              spell_school = "2",
              proc_mask = "2",
              threat_multiplier = "1",
              class_token = "rogue"
            }
          }
        },
        improved_gouge = {
          id = 22,
          type = "int32",
          label = "optional"
        },
        improved_sinister_strike = {
          id = 23,
          type = "int32",
          label = "optional"
        },
        lightning_reflexes = {
          id = 24,
          type = "int32",
          label = "optional"
        },
        improved_slice_and_dice = {
          id = 25,
          type = "int32",
          label = "optional"
        },
        deflection = {
          id = 26,
          type = "int32",
          label = "optional"
        },
        precision = {
          id = 27,
          type = "int32",
          label = "optional"
        },
        endurance = {
          id = 28,
          type = "int32",
          label = "optional"
        },
        riposte = {
          id = 29,
          type = "bool",
          label = "optional"
        },
        improved_sprint = {
          id = 30,
          type = "int32",
          label = "optional"
        },
        improved_kick = {
          id = 31,
          type = "int32",
          label = "optional"
        },
        dagger_specialization = {
          id = 32,
          type = "int32",
          label = "optional"
        },
        dual_wield_specialization = {
          id = 33,
          type = "int32",
          label = "optional"
        },
        mace_specialization = {
          id = 34,
          type = "int32",
          label = "optional"
        },
        blade_flurry = {
          id = 35,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              {
                class = "rogue",
                spell_id = 13877,
                label = "Blade Flurry",
                cooldown = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                flags = "SpellFlagAPL",
                class_spell_mask = "RogueSpellBladeFlurry",
                class_token = "rogue"
              },
              {
                class = "rogue",
                spell_id = 22482,
                label = "Blade Flurry",
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreModifiers | core.SpellFlagIgnoreArmor",
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
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "rogue"
            }
          }
        },
        sword_specialization = {
          id = 36,
          type = "int32",
          label = "optional"
        },
        fist_weapon_specialization = {
          id = 37,
          type = "int32",
          label = "optional"
        },
        blade_twisting = {
          id = 38,
          type = "int32",
          label = "optional"
        },
        weapon_expertise = {
          id = 39,
          type = "int32",
          label = "optional"
        },
        aggression = {
          id = 40,
          type = "int32",
          label = "optional"
        },
        vitality = {
          id = 41,
          type = "int32",
          label = "optional"
        },
        adrenaline_rush = {
          id = 42,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 13750,
              label = "Adrenaline Rush",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS",
                priority = "core.CooldownPriorityDefault"
              },
              flags = "core.SpellFlagReadinessTrinket",
              class_spell_mask = "RogueSpellAdrenalineRush",
              related_self_buff = "comRogue.AdrenalineRushCDAura",
              class_token = "rogue"
            },
            aura = {
              class = "rogue",
              spell_id = 13750,
              label = "Adrenaline Rush",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "rogue"
            }
          }
        },
        nerves_of_steel = {
          id = 43,
          type = "int32",
          label = "optional"
        },
        combat_potency = {
          id = 44,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "rogue",
              spell_id = 35546,
              label = "Combat Potency",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "rogue"
            }
          }
        },
        surprise_attacks = {
          id = 45,
          type = "bool",
          label = "optional"
        },
        master_of_deception = {
          id = 46,
          type = "int32",
          label = "optional"
        },
        opportunity = {
          id = 47,
          type = "int32",
          label = "optional"
        },
        sleight_of_hand = {
          id = 48,
          type = "int32",
          label = "optional"
        },
        dirty_tricks = {
          id = 49,
          type = "int32",
          label = "optional"
        },
        camouflage = {
          id = 50,
          type = "int32",
          label = "optional"
        },
        initiative = {
          id = 51,
          type = "int32",
          label = "optional"
        },
        ghostly_strike = {
          id = 52,
          type = "bool",
          label = "optional"
        },
        improved_ambush = {
          id = 53,
          type = "int32",
          label = "optional"
        },
        setup = {
          id = 54,
          type = "int32",
          label = "optional"
        },
        elusiveness = {
          id = 55,
          type = "int32",
          label = "optional"
        },
        serrated_blades = {
          id = 56,
          type = "int32",
          label = "optional"
        },
        heightened_senses = {
          id = 57,
          type = "int32",
          label = "optional"
        },
        preparation = {
          id = 58,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 14185,
              label = "Preparation",
              cooldown = {
                raw = "time.Minute * 5",
                seconds = 300.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS",
                priority = "core.CooldownPriorityDefault"
              },
              flags = "SpellFlagAPL",
              class_spell_mask = "RogueSpellPreparation",
              class_token = "rogue"
            }
          }
        },
        dirty_deeds = {
          id = 59,
          type = "int32",
          label = "optional"
        },
        hemorrhage = {
          id = 60,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              {
                class = "rogue",
                spell_id = 16511,
                label = "Hemorrhage",
                flags = "core.SpellFlagMeleeMetrics | rogue.SpellFlagBuilder | core.SpellFlagAPL",
                class_spell_mask = "RogueSpellHemorrhage",
                spell_school = "2",
                proc_mask = "ProcMaskMeleeMHSpecial",
                damage_multiplier = "core.TernaryFloat64(subRogue.HasDagger(core.MainHand), weaponDamage*1.45, weaponDamage)",
                crit_multiplier = "subRogue.CritMultiplier(true)",
                threat_multiplier = "1",
                class_token = "rogue"
              },
              {
                class = "rogue",
                spell_id = 16511,
                label = "Hemorrhage DoT",
                tag = "RogueBleed",
                flags = "core.SpellFlagIgnoreAttackerModifiers | core.SpellFlagPassiveSpell",
                spell_school = "2",
                proc_mask = "2",
                damage_multiplier = "1",
                crit_multiplier = "subRogue.CritMultiplier(false)",
                threat_multiplier = "1",
                class_token = "rogue"
              }
            }
          }
        },
        master_of_subtlety = {
          id = 61,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "rogue",
              spell_id = 31223,
              label = "Master of Subtlety",
              duration = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              class_token = "rogue"
            }
          }
        },
        deadliness = {
          id = 62,
          type = "int32",
          label = "optional"
        },
        enveloping_shadows = {
          id = 63,
          type = "int32",
          label = "optional"
        },
        premeditation = {
          id = 64,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 14183,
              label = "Premeditation",
              cooldown = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS",
                priority = "core.CooldownPriorityLow"
              },
              flags = "core.SpellFlagAPL | core.SpellFlagNoOnCastComplete",
              class_spell_mask = "RogueSpellPremeditation",
              class_token = "rogue"
            },
            aura = {
              class = "rogue",
              spell_id = 14183,
              label = "Premed Timeout Aura",
              duration = {
                raw = "time.Second * 18",
                seconds = 18.0
              },
              class_token = "rogue"
            }
          }
        },
        cheat_death = {
          id = 65,
          type = "int32",
          label = "optional"
        },
        sinister_calling = {
          id = 66,
          type = "int32",
          label = "optional"
        },
        shadowstep = {
          id = 67,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 36554,
              label = "Shadowstep",
              cooldown = {
                raw = "time.Second * 24",
                seconds = 24.0
              },
              flags = "SpellFlagAPL",
              class_spell_mask = "RogueSpellShadowstep",
              related_self_buff = "rogue.ShadowstepCDAura",
              class_token = "rogue"
            },
            aura = {
              class = "rogue",
              spell_id = 36554,
              label = "Shadowstep",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
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
        "puncturing_wounds",
        "relentless_strikes",
        "improved_expose_armor",
        "lethality",
        "vile_poisons",
        "improved_poisons",
        "fleet_footed",
        "cold_blood",
        "improved_kidney_shot",
        "quick_recovery",
        "seal_fate",
        "master_poisoner",
        "vigor",
        "deadened_nerves",
        "find_weakness",
        "mutilate",
        "improved_gouge",
        "improved_sinister_strike",
        "lightning_reflexes",
        "improved_slice_and_dice",
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
        "blade_twisting",
        "weapon_expertise",
        "aggression",
        "vitality",
        "adrenaline_rush",
        "nerves_of_steel",
        "combat_potency",
        "surprise_attacks",
        "master_of_deception",
        "opportunity",
        "sleight_of_hand",
        "dirty_tricks",
        "camouflage",
        "initiative",
        "ghostly_strike",
        "improved_ambush",
        "setup",
        "elusiveness",
        "serrated_blades",
        "heightened_senses",
        "preparation",
        "dirty_deeds",
        "hemorrhage",
        "master_of_subtlety",
        "deadliness",
        "enveloping_shadows",
        "premeditation",
        "cheat_death",
        "sinister_calling",
        "shadowstep"
      }
    },
    RogueOptions = {
      fields = {
        tricks_of_the_trade_target = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "UnitReference"
        },
        lethal_poison = {
          id = 2,
          type = "enum",
          label = "optional",
          enum_type = "PoisonOptions"
        },
        starting_overkill_duration = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        apply_poisons_manually = {
          id = 4,
          type = "bool",
          label = "optional"
        },
        vanish_break_time = {
          id = 5,
          type = "float",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "tricks_of_the_trade_target",
        "lethal_poison",
        "starting_overkill_duration",
        "apply_poisons_manually",
        "vanish_break_time"
      }
    },
    Rogue = {
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
        },
        gems = {
          id = 3,
          type = "message",
          label = "repeated",
          message_type = "SimGem"
        },
        item_effect_rand_prop_points = {
          id = 9,
          type = "message",
          label = "repeated",
          message_type = "ItemEffectRandPropPoints"
        },
        consumables = {
          id = 7,
          type = "message",
          label = "repeated",
          message_type = "Consumable"
        },
        spell_effects = {
          id = 8,
          type = "message",
          label = "repeated",
          message_type = "SpellEffect"
        }
      },
      oneofs = {

      },
      field_order = {
        "items",
        "random_suffixes",
        "enchants",
        "gems",
        "item_effect_rand_prop_points",
        "consumables",
        "spell_effects"
      }
    },
    SimEnchant = {
      fields = {
        effect_id = {
          id = 1,
          type = "int32",
          label = "optional"
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
        stats = {
          id = 4,
          type = "double",
          label = "repeated"
        },
        enchant_effect = {
          id = 5,
          type = "message",
          label = "optional",
          message_type = "ItemEffect"
        }
      },
      oneofs = {

      },
      field_order = {
        "effect_id",
        "name",
        "type",
        "stats",
        "enchant_effect"
      }
    },
    SimItem = {
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
        gem_sockets = {
          id = 8,
          type = "enum",
          label = "repeated",
          enum_type = "GemColor"
        },
        socketBonus = {
          id = 9,
          type = "double",
          label = "repeated"
        },
        weapon_speed = {
          id = 10,
          type = "double",
          label = "optional"
        },
        set_name = {
          id = 11,
          type = "string",
          label = "optional"
        },
        set_id = {
          id = 12,
          type = "int32",
          label = "optional"
        },
        scaling_options = {
          id = 13,
          type = "message",
          label = "repeated",
          message_type = "ScalingOptionsEntry"
        },
        item_effect = {
          id = 14,
          type = "message",
          label = "optional",
          message_type = "ItemEffect"
        }
      },
      oneofs = {

      },
      field_order = {
        "id",
        "name",
        "type",
        "armor_type",
        "weapon_type",
        "hand_type",
        "ranged_weapon_type",
        "gem_sockets",
        "socketBonus",
        "weapon_speed",
        "set_name",
        "set_id",
        "scaling_options",
        "item_effect"
      }
    },
    Consumable = {
      fields = {
        id = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        type = {
          id = 2,
          type = "enum",
          label = "optional",
          enum_type = "ConsumableType"
        },
        stats = {
          id = 3,
          type = "double",
          label = "repeated"
        },
        buffs_main_stat = {
          id = 4,
          type = "bool",
          label = "optional"
        },
        name = {
          id = 5,
          type = "string",
          label = "optional"
        },
        icon = {
          id = 6,
          type = "string",
          label = "optional"
        },
        buff_duration = {
          id = 7,
          type = "int32",
          label = "optional"
        },
        cooldown_duration = {
          id = 9,
          type = "int32",
          label = "optional"
        },
        category_cooldown_duration = {
          id = 10,
          type = "int32",
          label = "optional"
        },
        effect_ids = {
          id = 8,
          type = "int32",
          label = "repeated"
        }
      },
      oneofs = {

      },
      field_order = {
        "id",
        "type",
        "stats",
        "buffs_main_stat",
        "name",
        "icon",
        "buff_duration",
        "cooldown_duration",
        "category_cooldown_duration",
        "effect_ids"
      }
    },
    ItemEffectRandPropPoints = {
      fields = {
        ilvl = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        rand_prop_points = {
          id = 2,
          type = "int32",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "ilvl",
        "rand_prop_points"
      }
    },
    SimGem = {
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
        color = {
          id = 3,
          type = "enum",
          label = "optional",
          enum_type = "GemColor"
        },
        stats = {
          id = 4,
          type = "double",
          label = "repeated"
        },
        disabled_in_challenge_mode = {
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
        "color",
        "stats",
        "disabled_in_challenge_mode"
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
        soul_siphon = {
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
          label = "optional"
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
              class = "warlock",
              spec = "_affliction",
              spell_id = 17941,
              label = "Shadow Trance",
              duration = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              class_token = "warlock",
              spec_token = "_affliction"
            }
          }
        },
        empowered_corruption = {
          id = 12,
          type = "int32",
          label = "optional"
        },
        shadow_embrace = {
          id = 13,
          type = "int32",
          label = "optional"
        },
        siphon_life = {
          id = 14,
          type = "bool",
          label = "optional"
        },
        curse_of_exhaustion = {
          id = 15,
          type = "bool",
          label = "optional"
        },
        shadow_mastery = {
          id = 16,
          type = "int32",
          label = "optional"
        },
        contagion = {
          id = 17,
          type = "int32",
          label = "optional"
        },
        dark_pact = {
          id = 18,
          type = "bool",
          label = "optional"
        },
        improved_howl_of_terror = {
          id = 19,
          type = "int32",
          label = "optional"
        },
        malediction = {
          id = 20,
          type = "int32",
          label = "optional"
        },
        unstable_affliction = {
          id = 21,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "warlock",
              spec = "_affliction",
              spell_id = 30108,
              label = "UnstableAffliction",
              flags = "SpellFlagAPL",
              class_spell_mask = "WarlockSpellUnstableAffliction",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier_additive = "1",
              crit_multiplier = "affliction.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "warlock",
              spec_token = "_affliction"
            }
          }
        },
        improved_healthstone = {
          id = 22,
          type = "int32",
          label = "optional"
        },
        improved_imp = {
          id = 23,
          type = "int32",
          label = "optional"
        },
        demonic_embrace = {
          id = 24,
          type = "int32",
          label = "optional"
        },
        improved_health_funnel = {
          id = 25,
          type = "int32",
          label = "optional"
        },
        improved_voidwalker = {
          id = 26,
          type = "int32",
          label = "optional"
        },
        fel_intellect = {
          id = 27,
          type = "int32",
          label = "optional"
        },
        improved_sayaad = {
          id = 28,
          type = "int32",
          label = "optional"
        },
        fel_domination = {
          id = 29,
          type = "bool",
          label = "optional"
        },
        fel_stamina = {
          id = 30,
          type = "int32",
          label = "optional"
        },
        demonic_aegis = {
          id = 31,
          type = "int32",
          label = "optional"
        },
        master_summoner = {
          id = 32,
          type = "int32",
          label = "optional"
        },
        unholy_power = {
          id = 33,
          type = "int32",
          label = "optional"
        },
        improved_subjugate_demon = {
          id = 34,
          type = "int32",
          label = "optional"
        },
        demonic_sacrifice = {
          id = 35,
          type = "bool",
          label = "optional"
        },
        master_conjuror = {
          id = 36,
          type = "int32",
          label = "optional"
        },
        mana_feed = {
          id = 37,
          type = "int32",
          label = "optional"
        },
        master_demonologist = {
          id = 38,
          type = "int32",
          label = "optional"
        },
        demonic_resilience = {
          id = 39,
          type = "int32",
          label = "optional"
        },
        soul_link = {
          id = 40,
          type = "bool",
          label = "optional"
        },
        demonic_knowledge = {
          id = 41,
          type = "int32",
          label = "optional"
        },
        demonic_tactics = {
          id = 42,
          type = "int32",
          label = "optional"
        },
        summon_felguard = {
          id = 43,
          type = "bool",
          label = "optional"
        },
        improved_shadow_bolt = {
          id = 44,
          type = "int32",
          label = "optional"
        },
        cataclysm = {
          id = 45,
          type = "int32",
          label = "optional"
        },
        bane = {
          id = 46,
          type = "int32",
          label = "optional"
        },
        aftermath = {
          id = 47,
          type = "int32",
          label = "optional"
        },
        improved_firebolt = {
          id = 48,
          type = "int32",
          label = "optional"
        },
        improved_lash_of_pain = {
          id = 49,
          type = "int32",
          label = "optional"
        },
        devastation = {
          id = 50,
          type = "int32",
          label = "optional"
        },
        shadowburn = {
          id = 51,
          type = "bool",
          label = "optional"
        },
        intensity = {
          id = 52,
          type = "int32",
          label = "optional"
        },
        destructive_reach = {
          id = 53,
          type = "int32",
          label = "optional"
        },
        improved_searing_pain = {
          id = 54,
          type = "int32",
          label = "optional"
        },
        pyroclasm = {
          id = 55,
          type = "int32",
          label = "optional"
        },
        improved_immolate = {
          id = 56,
          type = "int32",
          label = "optional"
        },
        ruin = {
          id = 57,
          type = "bool",
          label = "optional"
        },
        nether_protection = {
          id = 58,
          type = "int32",
          label = "optional"
        },
        emberstorm = {
          id = 59,
          type = "int32",
          label = "optional"
        },
        backlash = {
          id = 60,
          type = "int32",
          label = "optional"
        },
        conflagrate = {
          id = 61,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "warlock",
              spec = "_destruction",
              spell_id = 17962,
              label = "Conflagrate",
              flags = "SpellFlagAPL",
              class_spell_mask = "2",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1.0",
              crit_multiplier = "destruction.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "warlock",
              spec_token = "_destruction"
            }
          }
        },
        soul_leech = {
          id = 62,
          type = "int32",
          label = "optional"
        },
        shadow_and_flame = {
          id = 63,
          type = "int32",
          label = "optional"
        },
        shadowfury = {
          id = 64,
          type = "bool",
          label = "optional"
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
        "soul_siphon",
        "improved_curse_of_agony",
        "fel_concentration",
        "amplify_curse",
        "grim_reach",
        "nightfall",
        "empowered_corruption",
        "shadow_embrace",
        "siphon_life",
        "curse_of_exhaustion",
        "shadow_mastery",
        "contagion",
        "dark_pact",
        "improved_howl_of_terror",
        "malediction",
        "unstable_affliction",
        "improved_healthstone",
        "improved_imp",
        "demonic_embrace",
        "improved_health_funnel",
        "improved_voidwalker",
        "fel_intellect",
        "improved_sayaad",
        "fel_domination",
        "fel_stamina",
        "demonic_aegis",
        "master_summoner",
        "unholy_power",
        "improved_subjugate_demon",
        "demonic_sacrifice",
        "master_conjuror",
        "mana_feed",
        "master_demonologist",
        "demonic_resilience",
        "soul_link",
        "demonic_knowledge",
        "demonic_tactics",
        "summon_felguard",
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
        "nether_protection",
        "emberstorm",
        "backlash",
        "conflagrate",
        "soul_leech",
        "shadow_and_flame",
        "shadowfury"
      }
    },
    WarlockOptions = {
      fields = {
        summon = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "Summon"
        },
        detonate_seed = {
          id = 2,
          type = "bool",
          label = "optional"
        },
        use_item_swap_bonus_stats = {
          id = 3,
          type = "bool",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "summon",
        "detonate_seed",
        "use_item_swap_bonus_stats"
      }
    },
    Warlock = {
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
        aura_mastery = {
          id = 6,
          type = "bool",
          label = "optional"
        },
        improved_lay_on_hands = {
          id = 7,
          type = "int32",
          label = "optional"
        },
        unyielding_faith = {
          id = 8,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "paladin",
              spell_id = 144624,
              label = "Unyielding Faith",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "paladin"
            }
          }
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
        pure_of_heart = {
          id = 11,
          type = "int32",
          label = "optional"
        },
        divine_favor = {
          id = 12,
          type = "bool",
          label = "optional"
        },
        sanctified_light = {
          id = 13,
          type = "int32",
          label = "optional"
        },
        purifying_power = {
          id = 14,
          type = "int32",
          label = "optional"
        },
        holy_power = {
          id = 15,
          type = "int32",
          label = "optional"
        },
        lights_grace = {
          id = 16,
          type = "int32",
          label = "optional"
        },
        holy_shock = {
          id = 17,
          type = "bool",
          label = "optional"
        },
        blessed_life = {
          id = 18,
          type = "int32",
          label = "optional"
        },
        holy_guidance = {
          id = 19,
          type = "int32",
          label = "optional"
        },
        divine_illumination = {
          id = 20,
          type = "bool",
          label = "optional"
        },
        improved_devotion_aura = {
          id = 21,
          type = "int32",
          label = "optional"
        },
        redoubt = {
          id = 22,
          type = "int32",
          label = "optional"
        },
        precision = {
          id = 23,
          type = "int32",
          label = "optional"
        },
        guardians_favor = {
          id = 24,
          type = "int32",
          label = "optional"
        },
        toughness = {
          id = 25,
          type = "int32",
          label = "optional"
        },
        blessing_of_kings = {
          id = 26,
          type = "bool",
          label = "optional"
        },
        improved_righteous_fury = {
          id = 27,
          type = "int32",
          label = "optional"
        },
        shield_specialization = {
          id = 28,
          type = "int32",
          label = "optional"
        },
        anticipation = {
          id = 29,
          type = "int32",
          label = "optional"
        },
        stoicism = {
          id = 30,
          type = "int32",
          label = "optional"
        },
        improved_hammer_of_justice = {
          id = 31,
          type = "int32",
          label = "optional"
        },
        improved_concentration_aura = {
          id = 32,
          type = "int32",
          label = "optional"
        },
        spell_warding = {
          id = 33,
          type = "int32",
          label = "optional"
        },
        blessing_of_sanctuary = {
          id = 34,
          type = "bool",
          label = "optional"
        },
        reckoning = {
          id = 35,
          type = "int32",
          label = "optional"
        },
        sacred_duty = {
          id = 36,
          type = "int32",
          label = "optional"
        },
        one_handed_weapon_specialization = {
          id = 37,
          type = "int32",
          label = "optional"
        },
        improved_holy_shield = {
          id = 38,
          type = "int32",
          label = "optional"
        },
        holy_shield = {
          id = 39,
          type = "bool",
          label = "optional"
        },
        ardent_defender = {
          id = 40,
          type = "int32",
          label = "optional",
          _metadata = {
            spell = {
              {
                class = "paladin",
                spec = "protection",
                spell_id = 66235,
                label = "Ardent Defender",
                flags = "core.SpellFlagHelpful | core.SpellFlagPassiveSpell",
                spell_school = "SpellSchoolHoly",
                proc_mask = "ProcMaskSpellHealing",
                damage_multiplier = "1",
                crit_multiplier = "1",
                threat_multiplier = "0",
                class_token = "paladin",
                spec_token = "protection"
              },
              {
                class = "paladin",
                spec = "protection",
                spell_id = 31850,
                label = "Ardent Defender",
                cooldown = {
                  raw = "time.Minute * 3",
                  seconds = 180.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeSurvival",
                  priority = "core.CooldownPriorityLow + 10"
                },
                flags = "core.SpellFlagAPL | core.SpellFlagHelpful | core.SpellFlagReadinessTrinket",
                class_spell_mask = "SpellMaskArdentDefender",
                spell_school = "SpellSchoolHoly",
                related_self_buff = "prot.ArdentDefenderAura",
                class_token = "paladin",
                spec_token = "protection"
              }
            },
            aura = {
              class = "paladin",
              spec = "protection",
              spell_id = 31850,
              label = "Ardent Defender",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "paladin",
              spec_token = "protection"
            }
          }
        },
        combat_expertise = {
          id = 41,
          type = "int32",
          label = "optional"
        },
        avengers_shield = {
          id = 42,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "paladin",
              spec = "protection",
              spell_id = 31935,
              label = "Avengers Shield",
              cooldown = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              class_spell_mask = "SpellMaskAvengersShield",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "prot.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "30",
              class_token = "paladin",
              spec_token = "protection"
            }
          }
        },
        improved_blessing_of_might = {
          id = 43,
          type = "int32",
          label = "optional"
        },
        benediction = {
          id = 44,
          type = "int32",
          label = "optional"
        },
        improved_judgement = {
          id = 45,
          type = "int32",
          label = "optional"
        },
        improved_seal_of_the_crusader = {
          id = 46,
          type = "int32",
          label = "optional"
        },
        deflection = {
          id = 47,
          type = "int32",
          label = "optional"
        },
        vindication = {
          id = 48,
          type = "int32",
          label = "optional"
        },
        conviction = {
          id = 49,
          type = "int32",
          label = "optional"
        },
        seal_of_command = {
          id = 50,
          type = "bool",
          label = "optional"
        },
        pursuit_of_justice = {
          id = 51,
          type = "int32",
          label = "optional"
        },
        eye_for_an_eye = {
          id = 52,
          type = "int32",
          label = "optional"
        },
        improved_retribution_aura = {
          id = 53,
          type = "int32",
          label = "optional"
        },
        crusade = {
          id = 54,
          type = "int32",
          label = "optional"
        },
        two_handed_weapon_specialization = {
          id = 55,
          type = "int32",
          label = "optional"
        },
        sanctity_aura = {
          id = 56,
          type = "bool",
          label = "optional"
        },
        improved_sanctity_aura = {
          id = 57,
          type = "int32",
          label = "optional"
        },
        vengeance = {
          id = 58,
          type = "int32",
          label = "optional"
        },
        sanctified_judgement = {
          id = 59,
          type = "int32",
          label = "optional"
        },
        sanctified_seals = {
          id = 60,
          type = "int32",
          label = "optional"
        },
        repentance = {
          id = 61,
          type = "bool",
          label = "optional"
        },
        divine_purpose = {
          id = 62,
          type = "int32",
          label = "optional"
        },
        fanaticism = {
          id = 63,
          type = "int32",
          label = "optional"
        },
        crusader_strike = {
          id = 64,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "paladin",
              spell_id = 35395,
              label = "Crusader Strike",
              cooldown = {
                raw = "time.Millisecond * 4500",
                seconds = 4.5
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              class_spell_mask = "SpellMaskCrusaderStrike",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1.25",
              crit_multiplier = "paladin.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "5",
              class_token = "paladin"
            }
          }
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
        "aura_mastery",
        "improved_lay_on_hands",
        "unyielding_faith",
        "illumination",
        "improved_blessing_of_wisdom",
        "pure_of_heart",
        "divine_favor",
        "sanctified_light",
        "purifying_power",
        "holy_power",
        "lights_grace",
        "holy_shock",
        "blessed_life",
        "holy_guidance",
        "divine_illumination",
        "improved_devotion_aura",
        "redoubt",
        "precision",
        "guardians_favor",
        "toughness",
        "blessing_of_kings",
        "improved_righteous_fury",
        "shield_specialization",
        "anticipation",
        "stoicism",
        "improved_hammer_of_justice",
        "improved_concentration_aura",
        "spell_warding",
        "blessing_of_sanctuary",
        "reckoning",
        "sacred_duty",
        "one_handed_weapon_specialization",
        "improved_holy_shield",
        "holy_shield",
        "ardent_defender",
        "combat_expertise",
        "avengers_shield",
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
        "crusade",
        "two_handed_weapon_specialization",
        "sanctity_aura",
        "improved_sanctity_aura",
        "vengeance",
        "sanctified_judgement",
        "sanctified_seals",
        "repentance",
        "divine_purpose",
        "fanaticism",
        "crusader_strike"
      }
    },
    PaladinOptions = {
      fields = {
        seal = {
          id = 2,
          type = "enum",
          label = "optional",
          enum_type = "PaladinSeal"
        }
      },
      oneofs = {

      },
      field_order = {
        "seal"
      }
    },
    RetributionPaladin = {
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
    ProtectionPaladin = {
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
    HolyPaladin = {
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
    UIDatabase = {
      fields = {
        items = {
          id = 1,
          type = "message",
          label = "repeated",
          message_type = "UIItem"
        },
        random_suffixes = {
          id = 11,
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
        gems = {
          id = 3,
          type = "message",
          label = "repeated",
          message_type = "UIGem"
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
        },
        item_effect_rand_prop_points = {
          id = 15,
          type = "message",
          label = "repeated",
          message_type = "ItemEffectRandPropPoints"
        },
        consumables = {
          id = 13,
          type = "message",
          label = "repeated",
          message_type = "Consumable"
        },
        spell_effects = {
          id = 14,
          type = "message",
          label = "repeated",
          message_type = "SpellEffect"
        }
      },
      oneofs = {

      },
      field_order = {
        "items",
        "random_suffixes",
        "enchants",
        "gems",
        "encounters",
        "zones",
        "npcs",
        "item_icons",
        "spell_icons",
        "item_effect_rand_prop_points",
        "consumables",
        "spell_effects"
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
          id = 9,
          type = "double",
          label = "repeated"
        },
        gem_sockets = {
          id = 10,
          type = "enum",
          label = "repeated",
          enum_type = "GemColor"
        },
        socketBonus = {
          id = 11,
          type = "double",
          label = "repeated"
        },
        random_suffix_options = {
          id = 26,
          type = "int32",
          label = "repeated"
        },
        rand_prop_points = {
          id = 27,
          type = "int32",
          label = "optional"
        },
        weapon_damage_min = {
          id = 12,
          type = "double",
          label = "optional"
        },
        weapon_damage_max = {
          id = 13,
          type = "double",
          label = "optional"
        },
        weapon_speed = {
          id = 14,
          type = "double",
          label = "optional"
        },
        ilvl = {
          id = 15,
          type = "int32",
          label = "optional"
        },
        phase = {
          id = 16,
          type = "int32",
          label = "optional"
        },
        quality = {
          id = 17,
          type = "enum",
          label = "optional",
          enum_type = "ItemQuality"
        },
        unique = {
          id = 18,
          type = "bool",
          label = "optional"
        },
        limit_category = {
          id = 32,
          type = "int32",
          label = "optional"
        },
        name_description = {
          id = 19,
          type = "string",
          label = "optional"
        },
        class_allowlist = {
          id = 20,
          type = "enum",
          label = "repeated",
          enum_type = "Class"
        },
        required_profession = {
          id = 21,
          type = "enum",
          label = "optional",
          enum_type = "Profession"
        },
        set_name = {
          id = 22,
          type = "string",
          label = "optional"
        },
        set_id = {
          id = 28,
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
          id = 23,
          type = "message",
          label = "repeated",
          message_type = "UIItemSource"
        },
        faction_restriction = {
          id = 25,
          type = "enum",
          label = "optional",
          enum_type = "FactionRestriction"
        },
        scaling_options = {
          id = 29,
          type = "message",
          label = "repeated",
          message_type = "ScalingOptionsEntry"
        },
        item_effect = {
          id = 30,
          type = "message",
          label = "optional",
          message_type = "ItemEffect"
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
        "gem_sockets",
        "socketBonus",
        "random_suffix_options",
        "rand_prop_points",
        "weapon_damage_min",
        "weapon_damage_max",
        "weapon_speed",
        "ilvl",
        "phase",
        "quality",
        "unique",
        "limit_category",
        "name_description",
        "class_allowlist",
        "required_profession",
        "set_name",
        "set_id",
        "expansion",
        "sources",
        "faction_restriction",
        "scaling_options",
        "item_effect"
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
          type = "enum",
          label = "optional",
          enum_type = "RepFaction"
        },
        rep_level = {
          id = 2,
          type = "enum",
          label = "optional",
          enum_type = "RepLevel"
        },
        faction_id = {
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
        "faction_id"
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
        },
        enchant_effect = {
          id = 14,
          type = "message",
          label = "optional",
          message_type = "ItemEffect"
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
        "required_profession",
        "enchant_effect"
      }
    },
    UIGem = {
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
        color = {
          id = 4,
          type = "enum",
          label = "optional",
          enum_type = "GemColor"
        },
        stats = {
          id = 5,
          type = "double",
          label = "repeated"
        },
        phase = {
          id = 6,
          type = "int32",
          label = "optional"
        },
        quality = {
          id = 7,
          type = "enum",
          label = "optional",
          enum_type = "ItemQuality"
        },
        unique = {
          id = 8,
          type = "bool",
          label = "optional"
        },
        required_profession = {
          id = 9,
          type = "enum",
          label = "optional",
          enum_type = "Profession"
        },
        disabled_in_challenge_mode = {
          id = 10,
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
        "color",
        "stats",
        "phase",
        "quality",
        "unique",
        "required_profession",
        "disabled_in_challenge_mode"
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
        has_buff = {
          id = 4,
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
          id = 20,
          type = "int32",
          label = "optional"
        },
        max_ilvl = {
          id = 21,
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
        matching_gems_only = {
          id = 8,
          type = "bool",
          label = "optional"
        },
        favorite_items = {
          id = 11,
          type = "int32",
          label = "repeated"
        },
        favorite_gems = {
          id = 12,
          type = "int32",
          label = "repeated"
        },
        favorite_random_suffixes = {
          id = 22,
          type = "int32",
          label = "repeated"
        },
        favorite_reforges = {
          id = 23,
          type = "int32",
          label = "repeated"
        },
        favorite_enchants = {
          id = 13,
          type = "string",
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
        "matching_gems_only",
        "favorite_items",
        "favorite_gems",
        "favorite_random_suffixes",
        "favorite_reforges",
        "favorite_enchants"
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
        show_quick_swap = {
          id = 12,
          type = "bool",
          label = "optional"
        },
        show_ep_values = {
          id = 11,
          type = "bool",
          label = "optional"
        },
        use_custom_ep_values = {
          id = 13,
          type = "bool",
          label = "optional"
        },
        use_soft_cap_breakpoints = {
          id = 14,
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
        "show_quick_swap",
        "show_ep_values",
        "use_custom_ep_values",
        "use_soft_cap_breakpoints",
        "language",
        "faction",
        "filters"
      }
    },
    IndividualSimSettings = {
      fields = {
        api_version = {
          id = 15,
          type = "int32",
          label = "optional"
        },
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
        },
        stat_caps = {
          id = 16,
          type = "message",
          label = "optional",
          message_type = "UnitStats"
        },
        breakpoint_limits = {
          id = 17,
          type = "message",
          label = "optional",
          message_type = "UnitStats"
        },
        reforge_settings = {
          id = 18,
          type = "message",
          label = "optional",
          message_type = "ReforgeSettings"
        }
      },
      oneofs = {

      },
      field_order = {
        "api_version",
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
        "tank_ref_stat",
        "stat_caps",
        "breakpoint_limits",
        "reforge_settings"
      }
    },
    ReforgeSettings = {
      fields = {
        use_custom_ep_values = {
          id = 1,
          type = "bool",
          label = "optional"
        },
        use_soft_cap_breakpoints = {
          id = 2,
          type = "bool",
          label = "optional"
        },
        include_timeout = {
          id = 3,
          type = "bool",
          label = "optional"
        },
        include_gems = {
          id = 4,
          type = "bool",
          label = "optional"
        },
        include_eotb_gem_socket = {
          id = 5,
          type = "bool",
          label = "optional"
        },
        freeze_item_slots = {
          id = 6,
          type = "bool",
          label = "optional"
        },
        frozen_item_slots = {
          id = 7,
          type = "enum",
          label = "repeated",
          enum_type = "ItemSlot"
        },
        relative_stat_cap_stat = {
          id = 8,
          type = "message",
          label = "optional",
          message_type = "UIStat"
        },
        stat_caps = {
          id = 9,
          type = "message",
          label = "optional",
          message_type = "UnitStats"
        },
        breakpoint_limits = {
          id = 10,
          type = "message",
          label = "optional",
          message_type = "UnitStats"
        }
      },
      oneofs = {

      },
      field_order = {
        "use_custom_ep_values",
        "use_soft_cap_breakpoints",
        "include_timeout",
        "include_gems",
        "include_eotb_gem_socket",
        "freeze_item_slots",
        "frozen_item_slots",
        "relative_stat_cap_stat",
        "stat_caps",
        "breakpoint_limits"
      }
    },
    StatCapConfig = {
      fields = {
        unit_stat = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "UIStat"
        },
        breakpoints = {
          id = 2,
          type = "double",
          label = "repeated"
        },
        cap_type = {
          id = 3,
          type = "enum",
          label = "optional",
          enum_type = "StatCapType"
        },
        post_cap_EPs = {
          id = 4,
          type = "double",
          label = "repeated"
        }
      },
      oneofs = {

      },
      field_order = {
        "unit_stat",
        "breakpoints",
        "cap_type",
        "post_cap_EPs"
      }
    },
    UIStat = {
      fields = {
        api_version = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        stat = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "Stat"
        },
        pseudo_stat = {
          id = 2,
          type = "enum",
          label = "optional",
          enum_type = "PseudoStat"
        }
      },
      oneofs = {
        unit_stat = {
          "stat",
          "pseudo_stat"
        }
      },
      field_order = {
        "api_version",
        "stat",
        "pseudo_stat"
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
    SavedStatWeightSettings = {
      fields = {
        excluded_stats = {
          id = 1,
          type = "enum",
          label = "repeated",
          enum_type = "Stat"
        },
        excluded_pseudo_stats = {
          id = 2,
          type = "enum",
          label = "repeated",
          enum_type = "PseudoStat"
        },
        api_version = {
          id = 3,
          type = "int32",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "excluded_stats",
        "excluded_pseudo_stats",
        "api_version"
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
          id = 7,
          type = "message",
          label = "optional",
          message_type = "Debuffs"
        },
        player_buffs = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "IndividualBuffs"
        },
        consumables = {
          id = 4,
          type = "message",
          label = "optional",
          message_type = "ConsumesSpec"
        },
        race = {
          id = 5,
          type = "enum",
          label = "optional",
          enum_type = "Race"
        },
        professions = {
          id = 9,
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
          id = 10,
          type = "int32",
          label = "optional"
        },
        channel_clip_delay_ms = {
          id = 14,
          type = "int32",
          label = "optional"
        },
        in_front_of_target = {
          id = 11,
          type = "bool",
          label = "optional"
        },
        distance_from_target = {
          id = 12,
          type = "double",
          label = "optional"
        },
        healing_model = {
          id = 13,
          type = "message",
          label = "optional",
          message_type = "HealingModel"
        },
        dark_intent_uptime = {
          id = 19,
          type = "double",
          label = "optional"
        },
        challenge_mode = {
          id = 20,
          type = "bool",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "raid_buffs",
        "party_buffs",
        "debuffs",
        "player_buffs",
        "consumables",
        "race",
        "professions",
        "enable_item_swap",
        "item_swap",
        "reaction_time_ms",
        "channel_clip_delay_ms",
        "in_front_of_target",
        "distance_from_target",
        "healing_model",
        "dark_intent_uptime",
        "challenge_mode"
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
    SavedEPWeights = {
      fields = {
        ep_weights = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "UnitStats"
        }
      },
      oneofs = {

      },
      field_order = {
        "ep_weights"
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
        api_version = {
          id = 54,
          type = "int32",
          label = "optional"
        },
        name = {
          id = 51,
          type = "string",
          label = "optional"
        },
        race = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "Race"
        },
        class = {
          id = 2,
          type = "enum",
          label = "optional",
          enum_type = "Class"
        },
        equipment = {
          id = 3,
          type = "message",
          label = "optional",
          message_type = "EquipmentSpec"
        },
        consumables = {
          id = 4,
          type = "message",
          label = "optional",
          message_type = "ConsumesSpec"
        },
        bonus_stats = {
          id = 5,
          type = "message",
          label = "optional",
          message_type = "UnitStats"
        },
        enable_item_swap = {
          id = 6,
          type = "bool",
          label = "optional"
        },
        item_swap = {
          id = 7,
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
        balance_druid = {
          id = 12,
          type = "message",
          label = "optional",
          message_type = "BalanceDruid"
        },
        feral_druid = {
          id = 13,
          type = "message",
          label = "optional",
          message_type = "FeralCatDruid"
        },
        guardian_druid = {
          id = 53,
          type = "message",
          label = "optional",
          message_type = "FeralBearDruid"
        },
        restoration_druid = {
          id = 14,
          type = "message",
          label = "optional",
          message_type = "RestorationDruid"
        },
        hunter = {
          id = 17,
          type = "message",
          label = "optional",
          message_type = "Hunter"
        },
        mage = {
          id = 20,
          type = "message",
          label = "optional",
          message_type = "Mage"
        },
        holy_paladin = {
          id = 21,
          type = "message",
          label = "optional",
          message_type = "HolyPaladin"
        },
        protection_paladin = {
          id = 22,
          type = "message",
          label = "optional",
          message_type = "ProtectionPaladin"
        },
        retribution_paladin = {
          id = 23,
          type = "message",
          label = "optional",
          message_type = "RetributionPaladin"
        },
        discipline_priest = {
          id = 24,
          type = "message",
          label = "optional",
          message_type = "DisciplinePriest"
        },
        holy_priest = {
          id = 25,
          type = "message",
          label = "optional",
          message_type = "HolyPriest"
        },
        shadow_priest = {
          id = 26,
          type = "message",
          label = "optional",
          message_type = "ShadowPriest"
        },
        rogue = {
          id = 29,
          type = "message",
          label = "optional",
          message_type = "Rogue"
        },
        elemental_shaman = {
          id = 30,
          type = "message",
          label = "optional",
          message_type = "ElementalShaman"
        },
        enhancement_shaman = {
          id = 31,
          type = "message",
          label = "optional",
          message_type = "EnhancementShaman"
        },
        restoration_shaman = {
          id = 32,
          type = "message",
          label = "optional",
          message_type = "RestorationShaman"
        },
        warlock = {
          id = 35,
          type = "message",
          label = "optional",
          message_type = "Warlock"
        },
        dps_warrior = {
          id = 37,
          type = "message",
          label = "optional",
          message_type = "DPSWarrior"
        },
        protection_warrior = {
          id = 38,
          type = "message",
          label = "optional",
          message_type = "ProtectionWarrior"
        },
        talents_string = {
          id = 39,
          type = "string",
          label = "optional"
        },
        profession1 = {
          id = 41,
          type = "enum",
          label = "optional",
          enum_type = "Profession"
        },
        profession2 = {
          id = 42,
          type = "enum",
          label = "optional",
          enum_type = "Profession"
        },
        cooldowns = {
          id = 43,
          type = "message",
          label = "optional",
          message_type = "Cooldowns"
        },
        rotation = {
          id = 44,
          type = "message",
          label = "optional",
          message_type = "APLRotation"
        },
        reaction_time_ms = {
          id = 45,
          type = "int32",
          label = "optional"
        },
        channel_clip_delay_ms = {
          id = 46,
          type = "int32",
          label = "optional"
        },
        in_front_of_target = {
          id = 47,
          type = "bool",
          label = "optional"
        },
        distance_from_target = {
          id = 48,
          type = "double",
          label = "optional"
        },
        dark_intent_uptime = {
          id = 52,
          type = "double",
          label = "optional"
        },
        challenge_mode = {
          id = 58,
          type = "bool",
          label = "optional"
        },
        healing_model = {
          id = 49,
          type = "message",
          label = "optional",
          message_type = "HealingModel"
        },
        database = {
          id = 50,
          type = "message",
          label = "optional",
          message_type = "SimDatabase"
        }
      },
      oneofs = {
        spec = {
          "balance_druid",
          "feral_druid",
          "guardian_druid",
          "restoration_druid",
          "hunter",
          "mage",
          "holy_paladin",
          "protection_paladin",
          "retribution_paladin",
          "discipline_priest",
          "holy_priest",
          "shadow_priest",
          "rogue",
          "elemental_shaman",
          "enhancement_shaman",
          "restoration_shaman",
          "warlock",
          "dps_warrior",
          "protection_warrior"
        }
      },
      field_order = {
        "api_version",
        "name",
        "race",
        "class",
        "equipment",
        "consumables",
        "bonus_stats",
        "enable_item_swap",
        "item_swap",
        "buffs",
        "balance_druid",
        "feral_druid",
        "guardian_druid",
        "restoration_druid",
        "hunter",
        "mage",
        "holy_paladin",
        "protection_paladin",
        "retribution_paladin",
        "discipline_priest",
        "holy_priest",
        "shadow_priest",
        "rogue",
        "elemental_shaman",
        "enhancement_shaman",
        "restoration_shaman",
        "warlock",
        "dps_warrior",
        "protection_warrior",
        "talents_string",
        "profession1",
        "profession2",
        "cooldowns",
        "rotation",
        "reaction_time_ms",
        "channel_clip_delay_ms",
        "in_front_of_target",
        "distance_from_target",
        "dark_intent_uptime",
        "challenge_mode",
        "healing_model",
        "database"
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
          id = 1,
          type = "int32",
          label = "optional"
        },
        casts = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        hits = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        crits = {
          id = 4,
          type = "int32",
          label = "optional"
        },
        ticks = {
          id = 5,
          type = "int32",
          label = "optional"
        },
        crit_ticks = {
          id = 6,
          type = "int32",
          label = "optional"
        },
        misses = {
          id = 7,
          type = "int32",
          label = "optional"
        },
        dodges = {
          id = 8,
          type = "int32",
          label = "optional"
        },
        parries = {
          id = 9,
          type = "int32",
          label = "optional"
        },
        blocks = {
          id = 10,
          type = "int32",
          label = "optional"
        },
        crit_blocks = {
          id = 11,
          type = "int32",
          label = "optional"
        },
        glances = {
          id = 12,
          type = "int32",
          label = "optional"
        },
        glance_blocks = {
          id = 13,
          type = "int32",
          label = "optional"
        },
        damage = {
          id = 14,
          type = "double",
          label = "optional"
        },
        crit_damage = {
          id = 15,
          type = "double",
          label = "optional"
        },
        tick_damage = {
          id = 16,
          type = "double",
          label = "optional"
        },
        crit_tick_damage = {
          id = 17,
          type = "double",
          label = "optional"
        },
        glance_damage = {
          id = 18,
          type = "double",
          label = "optional"
        },
        glance_block_damage = {
          id = 19,
          type = "double",
          label = "optional"
        },
        block_damage = {
          id = 20,
          type = "double",
          label = "optional"
        },
        crit_block_damage = {
          id = 21,
          type = "double",
          label = "optional"
        },
        threat = {
          id = 22,
          type = "double",
          label = "optional"
        },
        healing = {
          id = 23,
          type = "double",
          label = "optional"
        },
        crit_healing = {
          id = 24,
          type = "double",
          label = "optional"
        },
        shielding = {
          id = 25,
          type = "double",
          label = "optional"
        },
        cast_time_ms = {
          id = 26,
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
        "crits",
        "ticks",
        "crit_ticks",
        "misses",
        "dodges",
        "parries",
        "blocks",
        "crit_blocks",
        "glances",
        "glance_blocks",
        "damage",
        "crit_damage",
        "tick_damage",
        "crit_tick_damage",
        "glance_damage",
        "glance_block_damage",
        "block_damage",
        "crit_block_damage",
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
          id = 16,
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
        death_seeds = {
          id = 2,
          type = "int64",
          label = "repeated"
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
        "threat",
        "dtps",
        "tmi",
        "hps",
        "tto",
        "seconds_oom_avg",
        "chance_of_death",
        "death_seeds",
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
        request_id = {
          id = 5,
          type = "string",
          label = "optional"
        },
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
        },
        type = {
          id = 4,
          type = "enum",
          label = "optional",
          enum_type = "SimType"
        }
      },
      oneofs = {

      },
      field_order = {
        "request_id",
        "raid",
        "encounter",
        "sim_options",
        "type"
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
        },
        has_cast_time = {
          id = 9,
          type = "bool",
          label = "optional"
        },
        is_friendly = {
          id = 10,
          type = "bool",
          label = "optional"
        },
        has_expected_tick = {
          id = 11,
          type = "bool",
          label = "optional"
        },
        has_missile_speed = {
          id = 12,
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
        "encounter_only",
        "has_cast_time",
        "is_friendly",
        "has_expected_tick",
        "has_missile_speed"
      }
    },
    APLValidation = {
      fields = {
        log_level = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "LogLevel"
        },
        validation = {
          id = 2,
          type = "string",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "log_level",
        "validation"
      }
    },
    APLActionStats = {
      fields = {
        validations = {
          id = 1,
          type = "message",
          label = "repeated",
          message_type = "APLValidation"
        }
      },
      oneofs = {

      },
      field_order = {
        "validations"
      },
      _metadata = {
        ui_label = "Action Stats",
        short_description = "Contains validation information for an action in the rotation."
      }
    },
    UUIDValidations = {
      fields = {
        uuid = {
          id = 1,
          type = "message",
          label = "optional",
          message_type = "UUID"
        },
        validations = {
          id = 2,
          type = "message",
          label = "repeated",
          message_type = "APLValidation"
        }
      },
      oneofs = {

      },
      field_order = {
        "uuid",
        "validations"
      }
    },
    APLGroupStats = {
      fields = {
        actions = {
          id = 1,
          type = "message",
          label = "repeated",
          message_type = "APLActionStats"
        }
      },
      oneofs = {

      },
      field_order = {
        "actions"
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
        },
        uuid_validations = {
          id = 3,
          type = "message",
          label = "repeated",
          message_type = "UUIDValidations"
        },
        groups = {
          id = 4,
          type = "message",
          label = "repeated",
          message_type = "APLGroupStats"
        }
      },
      oneofs = {

      },
      field_order = {
        "prepull_actions",
        "priority_list",
        "uuid_validations",
        "groups"
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
        "final_weight_result"
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
        iterations_per_combo = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        default_red_gem = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        default_blue_gem = {
          id = 4,
          type = "int32",
          label = "optional"
        },
        default_yellow_gem = {
          id = 5,
          type = "int32",
          label = "optional"
        },
        default_meta_gem = {
          id = 6,
          type = "int32",
          label = "optional"
        },
        default_prismatic_gem = {
          id = 7,
          type = "int32",
          label = "optional"
        },
        inherit_upgrades = {
          id = 8,
          type = "bool",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "items",
        "iterations_per_combo",
        "default_red_gem",
        "default_blue_gem",
        "default_yellow_gem",
        "default_meta_gem",
        "default_prismatic_gem",
        "inherit_upgrades"
      }
    },
    RogueSpells = {
      fields = {
        envenom = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 32645,
              label = "Envenom",
              flags = "core.SpellFlagMeleeMetrics | rogue.SpellFlagFinisher | core.SpellFlagAPL",
              class_spell_mask = "RogueSpellEnvenom",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              damage_multiplier_additive = "1",
              crit_multiplier = "asnRogue.CritMultiplier(false)",
              threat_multiplier = "1",
              class_token = "rogue"
            },
            aura = {
              class = "rogue",
              spell_id = 32645,
              label = "Envenom",
              class_token = "rogue"
            }
          }
        },
        ambush = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 8676,
              label = "Ambush",
              flags = "core.SpellFlagMeleeMetrics | SpellFlagBuilder | core.SpellFlagAPL",
              class_spell_mask = "2",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "core.TernaryFloat64(rogue.HasDagger(core.MainHand), weaponDamage*daggerModifier, weaponDamage)",
              damage_multiplier_additive = "1",
              crit_multiplier = "rogue.CritMultiplier(false)",
              threat_multiplier = "1",
              class_token = "rogue"
            }
          }
        },
        eviscerate = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 2098,
              label = "Eviscerate",
              flags = "core.SpellFlagMeleeMetrics | SpellFlagFinisher | core.SpellFlagAPL",
              class_spell_mask = "RogueSpellEviscerate",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              damage_multiplier_additive = "1",
              crit_multiplier = "rogue.CritMultiplier(false)",
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
                raw = "time.Minute * 2",
                seconds = 120.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS",
                priority = "core.CooldownPriorityDrums"
              },
              flags = "core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
              class_spell_mask = "RogueSpellVanish",
              spell_school = "2",
              class_token = "rogue"
            }
          }
        },
        furyofthe_destroyer = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "rogue",
              spell_id = 109949,
              label = "Fury of the Destroyer",
              duration = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              class_token = "rogue"
            }
          }
        },
        toxicologist = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "rogue",
              spell_id = 145249,
              label = "Toxicologist",
              duration = {
                raw = "time.Second * 5",
                seconds = 5.0
              },
              class_token = "rogue"
            }
          }
        },
        sleightof_hand = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "rogue",
              spell_id = 145211,
              label = "Sleight of Hand",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "rogue"
            }
          }
        },
        silent_blades = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "rogue",
              spell_id = 145193,
              label = "Silent Blades",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "rogue"
            }
          }
        },
        shadow_blades_energy_cost_reduction = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "rogue",
              spell_id = 138151,
              label = "Shadow Blades Energy Cost Reduction",
              duration = {
                raw = "time.Second * 12",
                seconds = 12.0
              },
              class_token = "rogue"
            }
          }
        },
        new_mutilate_hit = {
          id = 10,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "rogue",
                spell_id = 1329,
                label = "New Mutilate Hit",
                flags = "core.SpellFlagMeleeMetrics | rogue.SpellFlagSealFate",
                class_spell_mask = "RogueSpellMutilateHit",
                spell_school = "2",
                proc_mask = "core.ProcMaskMeleeMHSpecial",
                damage_multiplier = "2.8",
                damage_multiplier_additive = "1",
                crit_multiplier = "sinRogue.CritMultiplier(true)",
                threat_multiplier = "1",
                class_token = "rogue"
              },
              {
                class = "rogue",
                spell_id = 1329,
                label = "New Mutilate Hit",
                flags = "core.SpellFlagMeleeMetrics | rogue.SpellFlagSealFate",
                class_spell_mask = "RogueSpellMutilateHit",
                spell_school = "2",
                proc_mask = "core.ProcMaskMeleeMHSpecial",
                damage_multiplier = "2.8",
                damage_multiplier_additive = "1",
                crit_multiplier = "sinRogue.CritMultiplier(true)",
                threat_multiplier = "1",
                class_token = "rogue"
              }
            }
          }
        },
        slice_and_dice = {
          id = 11,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 5171,
              label = "Slice and Dice",
              flags = "SpellFlagFinisher | core.SpellFlagAPL",
              class_spell_mask = "RogueSpellSliceAndDice",
              related_self_buff = "rogue.SliceAndDiceAura",
              class_token = "rogue"
            },
            aura = {
              class = "rogue",
              spell_id = 5171,
              label = "Slice and Dice",
              duration = {
                raw = "rogue.sliceAndDiceDurations[5]"
              },
              class_token = "rogue"
            }
          }
        },
        vendetta = {
          id = 12,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 79140,
              label = "Vendetta",
              cooldown = {
                raw = "time.Minute * 2",
                seconds = 120.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS",
                priority = "core.CooldownPriorityDefault"
              },
              flags = "core.SpellFlagAPL | core.SpellFlagMCD | core.SpellFlagReadinessTrinket",
              class_spell_mask = "RogueSpellVendetta",
              spell_school = "2",
              class_token = "rogue"
            },
            aura = {
              class = "rogue",
              spell_id = 79140,
              label = "Vendetta",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "rogue"
            }
          }
        },
        rupture = {
          id = 13,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 1943,
              label = "Rupture",
              tag = "RogueBleed",
              flags = "core.SpellFlagMeleeMetrics | SpellFlagFinisher | core.SpellFlagAPL",
              class_spell_mask = "RogueSpellRupture",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              crit_multiplier = "rogue.CritMultiplier(false)",
              threat_multiplier = "1",
              class_token = "rogue"
            }
          }
        },
        backstab = {
          id = 14,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 53,
              label = "Backstab",
              flags = "core.SpellFlagMeleeMetrics | rogue.SpellFlagBuilder | core.SpellFlagAPL",
              class_spell_mask = "RogueSpellBackstab",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              damage_multiplier_additive = "3.8",
              crit_multiplier = "subRogue.CritMultiplier(true)",
              threat_multiplier = "1",
              class_token = "rogue"
            }
          }
        },
        dispatch = {
          id = 15,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 111240,
              label = "Dispatch",
              flags = "core.SpellFlagMeleeMetrics | rogue.SpellFlagBuilder | core.SpellFlagAPL",
              class_spell_mask = "RogueSpellDispatch",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "6.45",
              damage_multiplier_additive = "1",
              crit_multiplier = "sinRogue.CritMultiplier(true)",
              threat_multiplier = "1",
              class_token = "rogue"
            }
          }
        },
        venomous_wounds = {
          id = 16,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 79134,
              label = "Venomous Wounds",
              flags = "SpellFlagPassiveSpell",
              class_spell_mask = "RogueSpellVenomousWounds",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "sinRogue.CritMultiplier(false)",
              threat_multiplier = "1",
              class_token = "rogue"
            },
            aura = {
              class = "rogue",
              label = "Venomous Wounds Aura",
              class_token = "rogue"
            }
          }
        },
        sanguinary_vein = {
          id = 17,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "rogue",
                label = "Sanguinary Vein Talent",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "rogue"
              },
              {
                class = "rogue",
                label = "Sanguinary Vein Debuff",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "rogue"
              }
            }
          }
        },
        crimson_tempest = {
          id = 18,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "rogue",
                spell_id = 121411,
                label = "Crimson Tempest",
                flags = "core.SpellFlagMeleeMetrics | SpellFlagFinisher | core.SpellFlagAPL",
                class_spell_mask = "RogueSpellCrimsonTempest",
                spell_school = "2",
                proc_mask = "ProcMaskMeleeMHSpecial",
                damage_multiplier = "1",
                crit_multiplier = "rogue.CritMultiplier(false)",
                threat_multiplier = "1",
                class_token = "rogue"
              },
              {
                class = "rogue",
                spell_id = 121411,
                label = "Crimson Tempest",
                tag = "RogueBleed",
                flags = "core.SpellFlagIgnoreTargetModifiers | core.SpellFlagIgnoreAttackerModifiers | core.SpellFlagPassiveSpell",
                class_spell_mask = "RogueSpellCrimsonTempestDoT",
                spell_school = "2",
                proc_mask = "2",
                damage_multiplier = "1",
                crit_multiplier = "rogue.CritMultiplier(false)",
                threat_multiplier = "1",
                class_token = "rogue"
              }
            }
          }
        },
        wound_poison = {
          id = 19,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 8680,
              label = "Wound Poison",
              class_spell_mask = "RogueSpellWoundPoison",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellDamageProc",
              damage_multiplier = "1",
              damage_multiplier_additive = "1",
              crit_multiplier = "rogue.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "rogue"
            },
            aura = {
              class = "rogue",
              spell_id = 8680,
              label = "Wound Poison",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "rogue"
            }
          }
        },
        deadly_poison = {
          id = 20,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "rogue",
                spell_id = 2818,
                label = "Deadly Poison",
                flags = "SpellFlagPassiveSpell",
                class_spell_mask = "RogueSpellDeadlyPoison",
                spell_school = "SpellSchoolNature",
                proc_mask = "ProcMaskSpellDamageProc",
                damage_multiplier = "1",
                damage_multiplier_additive = "1",
                crit_multiplier = "rogue.CritMultiplier(false)",
                threat_multiplier = "1",
                class_token = "rogue"
              },
              {
                class = "rogue",
                spell_id = 2818,
                label = "Deadly Poison",
                flags = "SpellFlagPassiveSpell",
                class_spell_mask = "RogueSpellDeadlyPoison",
                spell_school = "SpellSchoolNature",
                proc_mask = "ProcMaskSpellDamageProc",
                damage_multiplier = "1",
                damage_multiplier_additive = "1",
                crit_multiplier = "rogue.CritMultiplier(false)",
                threat_multiplier = "1",
                class_token = "rogue"
              }
            }
          }
        },
        fan_of_knives = {
          id = 21,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "rogue",
                spell_id = 51723,
                label = "Fan Of Knives",
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagAoE",
                spell_school = "2",
                class_token = "rogue"
              },
              {
                class = "rogue",
                spell_id = 51723,
                label = "Fan Of Knives",
                flags = "SpellFlagMeleeMetrics",
                class_spell_mask = "RogueSpellFanOfKnives",
                spell_school = "2",
                proc_mask = "ProcMaskMeleeMHSpecial | ProcMaskMeleeOHSpecial",
                damage_multiplier = "1",
                crit_multiplier = "rogue.CritMultiplier(false)",
                threat_multiplier = "1",
                class_token = "rogue"
              }
            }
          }
        },
        stealth = {
          id = 22,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "rogue",
              spell_id = 1784,
              label = "Stealth",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "rogue"
            }
          }
        },
        make_shadow_blade_hit = {
          id = 23,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "rogue",
                spell_id = 121471,
                label = "Make Shadow Blade Hit",
                flags = "SpellFlagMeleeMetrics",
                class_spell_mask = "RogueSpellShadowBladesHit",
                spell_school = "SpellSchoolShadow",
                proc_mask = "core.Ternary(isMH, core.ProcMaskMeleeMH, core.ProcMaskMeleeOH)",
                damage_multiplier = "1",
                damage_multiplier_additive = "1",
                crit_multiplier = "rogue.CritMultiplier(true)",
                threat_multiplier = "1",
                class_token = "rogue"
              },
              {
                class = "rogue",
                spell_id = 121471,
                label = "Make Shadow Blade Hit",
                flags = "SpellFlagMeleeMetrics",
                class_spell_mask = "RogueSpellShadowBladesHit",
                spell_school = "SpellSchoolShadow",
                proc_mask = "core.Ternary(isMH, core.ProcMaskMeleeMH, core.ProcMaskMeleeOH)",
                damage_multiplier = "1",
                damage_multiplier_additive = "1",
                crit_multiplier = "rogue.CritMultiplier(true)",
                threat_multiplier = "1",
                class_token = "rogue"
              }
            }
          }
        },
        shadow_blades = {
          id = 24,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 121471,
              label = "Shadow Blades",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS",
                priority = "core.CooldownPriorityDefault"
              },
              flags = "core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
              class_spell_mask = "RogueSpellShadowBlades",
              related_self_buff = "rogue.ShadowBladesCDAura",
              class_token = "rogue"
            },
            aura = {
              class = "rogue",
              spell_id = 121471,
              label = "Shadow Blades",
              duration = {
                raw = "time.Second * 12",
                seconds = 12.0
              },
              class_token = "rogue"
            }
          }
        },
        tricks_of_the_trade = {
          id = 25,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "rogue",
                spell_id = 57934,
                label = "Tricks Of The Trade",
                cooldown = {
                  raw = "time.Second * 30",
                  seconds = 30.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "core.SpellFlagAPL | core.SpellFlagHelpful",
                class_spell_mask = "RogueSpellTricksOfTheTrade",
                class_token = "rogue"
              },
              {
                class = "rogue",
                spell_id = 59628,
                label = "Tricks Of The Trade",
                class_spell_mask = "RogueSpellTricksOfTheTradeThreat",
                class_token = "rogue"
              }
            },
            aura = {
              {
                class = "rogue",
                spell_id = 57934,
                label = "TricksOfTheTradeApplication",
                duration = {
                  raw = "30 * time.Second",
                  seconds = 30.0
                },
                class_token = "rogue"
              },
              {
                class = "rogue",
                spell_id = 59628,
                label = "TricksOfTheTradeThreatTransfer",
                duration = {
                  raw = "time.Second * 6",
                  seconds = 6.0
                },
                class_token = "rogue"
              }
            }
          }
        },
        talents = {
          id = 26,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "rogue",
                spell_id = 114015,
                label = "Anticipation",
                duration = {
                  raw = "time.Second * 15",
                  seconds = 15.0
                },
                class_token = "rogue"
              },
              {
                class = "rogue",
                spell_id = 108208,
                label = "Subterfuge",
                duration = {
                  raw = "time.Second * 3",
                  seconds = 3.0
                },
                class_token = "rogue"
              }
            },
            spell = {
              class = "rogue",
              spell_id = 137619,
              label = "Talents",
              cooldown = {
                raw = "time.Minute * 1",
                seconds = 60.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS",
                priority = "core.CooldownPriorityDefault"
              },
              flags = "SpellFlagAPL",
              class_spell_mask = "RogueSpellMarkedForDeath",
              class_token = "rogue"
            }
          }
        },
        sinister_strike = {
          id = 27,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 1752,
              label = "Sinister Strike",
              flags = "core.SpellFlagMeleeMetrics | rogue.SpellFlagBuilder | core.SpellFlagAPL",
              class_spell_mask = "RogueSpellSinisterStrike",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1.92",
              damage_multiplier_additive = "1",
              crit_multiplier = "comRogue.CritMultiplier(true)",
              threat_multiplier = "1",
              class_token = "rogue"
            }
          }
        },
        shadow_dance = {
          id = 28,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 51713,
              label = "Shadow Dance",
              cooldown = {
                raw = "time.Minute",
                seconds = 60.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS",
                priority = "core.CooldownPriorityDefault"
              },
              flags = "core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
              class_spell_mask = "RogueSpellShadowDance",
              related_self_buff = "subRogue.ShadowDanceCDAura",
              class_token = "rogue"
            },
            aura = {
              class = "rogue",
              spell_id = 51713,
              label = "Shadow Dance",
              duration = {
                raw = "time.Second * 8",
                seconds = 8.0
              },
              class_token = "rogue"
            }
          }
        },
        revealing_strike = {
          id = 29,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 84617,
              label = "Revealing Strike",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | rogue.SpellFlagBuilder",
              class_spell_mask = "RogueSpellRevealingStrike",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1.6",
              crit_multiplier = "comRogue.CritMultiplier(false)",
              threat_multiplier = "1",
              class_token = "rogue"
            },
            aura = {
              class = "rogue",
              spell_id = 84617,
              label = "Revealing Strike",
              duration = {
                raw = "time.Second * 24",
                seconds = 24.0
              },
              class_token = "rogue"
            }
          }
        },
        bandits_guile = {
          id = 30,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "rogue",
                spell_id = 84654,
                label = "Bandit's Guile Tracker",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "rogue"
              },
              {
                class = "rogue",
                spell_id = 84745,
                label = "Shallow Insight",
                duration = {
                  raw = "time.Second * 15",
                  seconds = 15.0
                },
                class_token = "rogue"
              }
            }
          }
        },
        garrote = {
          id = 31,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 703,
              label = "Garrote",
              tag = "RogueBleed",
              flags = "core.SpellFlagMeleeMetrics | SpellFlagBuilder | core.SpellFlagAPL",
              class_spell_mask = "RogueSpellGarrote",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              damage_multiplier_additive = "1",
              crit_multiplier = "rogue.CritMultiplier(false)",
              threat_multiplier = "1",
              class_token = "rogue"
            }
          }
        },
        killing_spree = {
          id = 32,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "rogue",
                spell_id = 51690,
                label = "Killing Spree",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS",
                  priority = "core.CooldownPriorityDefault"
                },
                flags = "core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
                class_spell_mask = "RogueSpellKillingSpree",
                class_token = "rogue"
              },
              {
                class = "rogue",
                spell_id = 51690,
                label = "Killing Spree",
                flags = "SpellFlagMeleeMetrics",
                class_spell_mask = "RogueSpellKillingSpreeHit",
                spell_school = "2",
                proc_mask = "ProcMaskMeleeOHSpecial",
                damage_multiplier = "1.75",
                crit_multiplier = "comRogue.CritMultiplier(false)",
                threat_multiplier = "1",
                class_token = "rogue"
              },
              {
                class = "rogue",
                spell_id = 51690,
                label = "Killing Spree",
                flags = "SpellFlagMeleeMetrics",
                class_spell_mask = "RogueSpellKillingSpreeHit",
                spell_school = "2",
                proc_mask = "ProcMaskMeleeMHSpecial",
                damage_multiplier = "1",
                crit_multiplier = "comRogue.CritMultiplier(false)",
                threat_multiplier = "1",
                class_token = "rogue"
              }
            },
            aura = {
              class = "rogue",
              spell_id = 51690,
              label = "Killing Spree",
              duration = {
                raw = "time.Second*3 + 1",
                seconds = 4.0
              },
              class_token = "rogue"
            }
          }
        },
        passives = {
          id = 33,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "rogue",
              spell_id = 76808,
              label = "Executioner",
              class_token = "rogue"
            }
          }
        },
        honor_among_thieves = {
          id = 34,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "rogue",
              spell_id = 51701,
              label = "Honor Among Thieves Combo Point Aura",
              class_token = "rogue"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "envenom",
        "ambush",
        "eviscerate",
        "vanish",
        "furyofthe_destroyer",
        "toxicologist",
        "sleightof_hand",
        "silent_blades",
        "shadow_blades_energy_cost_reduction",
        "new_mutilate_hit",
        "slice_and_dice",
        "vendetta",
        "rupture",
        "backstab",
        "dispatch",
        "venomous_wounds",
        "sanguinary_vein",
        "crimson_tempest",
        "wound_poison",
        "deadly_poison",
        "fan_of_knives",
        "stealth",
        "make_shadow_blade_hit",
        "shadow_blades",
        "tricks_of_the_trade",
        "talents",
        "sinister_strike",
        "shadow_dance",
        "revealing_strike",
        "bandits_guile",
        "garrote",
        "killing_spree",
        "passives",
        "honor_among_thieves"
      },
      synthetic = true
    },
    DruidSpells = {
      fields = {
        rip = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 1079,
              label = "Rip",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              class_spell_mask = "DruidSpellRip",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1.2",
              crit_multiplier = "druid.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "5",
              class_token = "druid"
            }
          }
        },
        bear_form = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 5487,
              label = "Bear Form",
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
              class_token = "druid"
            },
            aura = {
              class = "druid",
              spell_id = 5487,
              label = "Bear Form",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
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
        swipe_cat = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 62078,
              label = "Swipe Cat",
              flags = "core.SpellFlagAoE | core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              class_spell_mask = "DruidSpellSwipeCat",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "4.0",
              crit_multiplier = "druid.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "druid"
            }
          }
        },
        swipe_bear = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 779,
              label = "Swipe Bear",
              cooldown = {
                raw = "time.Second * 3",
                seconds = 3.0
              },
              flags = "core.SpellFlagAoE | core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              class_spell_mask = "DruidSpellSwipeBear",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              crit_multiplier = "druid.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "8",
              class_token = "druid"
            }
          }
        },
        lacerate = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 33745,
              label = "Lacerate",
              cooldown = {
                raw = "time.Second * 3",
                seconds = 3.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              class_spell_mask = "DruidSpellLacerate",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              crit_multiplier = "druid.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "5",
              class_token = "druid"
            }
          }
        },
        moonfire_impact = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 8921,
              label = "Moonfire Impact",
              flags = "SpellFlagAPL",
              class_spell_mask = "DruidSpellMoonfire",
              spell_school = "SpellSchoolArcane",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "druid.DefaultSpellCritMultiplier()",
              threat_multiplier = "1",
              class_token = "druid"
            }
          }
        },
        moonfire = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 8921,
              label = "Moonfire",
              flags = "SpellFlagPassiveSpell",
              class_spell_mask = "DruidSpellMoonfireDoT",
              spell_school = "SpellSchoolArcane",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "druid.DefaultSpellCritMultiplier()",
              threat_multiplier = "1",
              class_token = "druid"
            }
          }
        },
        pulverize = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 80313,
              label = "Pulverize",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "0.6",
              crit_multiplier = "druid.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "5",
              class_token = "druid"
            },
            aura = {
              class = "druid",
              spell_id = 80951,
              label = "Pulverize",
              duration = {
                raw = "core.DurationFromSeconds(10.0 + 4.0*float64(druid.Talents.EndlessCarnage))"
              },
              class_token = "druid"
            }
          }
        },
        hurricane = {
          id = 10,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "druid",
                spell_id = 16914,
                label = "Hurricane (Aura)",
                flags = "core.SpellFlagChanneled | core.SpellFlagAPL",
                class_spell_mask = "DruidSpellHurricane",
                spell_school = "SpellSchoolNature",
                proc_mask = "ProcMaskSpellDamage",
                class_token = "druid"
              },
              {
                class = "druid",
                spell_id = 42231,
                label = "Hurricane",
                flags = "core.SpellFlagAoE",
                class_spell_mask = "DruidSpellHurricane",
                spell_school = "SpellSchoolNature",
                proc_mask = "ProcMaskSpellProc",
                damage_multiplier = "1",
                crit_multiplier = "druid.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "druid"
              }
            }
          }
        },
        thrash_cat = {
          id = 11,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 106830,
              label = "Thrash (Cat)",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIgnoreArmor | core.SpellFlagAPL | core.SpellFlagAoE",
              class_spell_mask = "DruidSpellThrashCat",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              crit_multiplier = "druid.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "druid"
            }
          }
        },
        thrash_bear = {
          id = 12,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 77758,
              label = "Thrash (Bear)",
              cooldown = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIgnoreArmor | core.SpellFlagAPL | core.SpellFlagAoE",
              class_spell_mask = "DruidSpellThrashBear",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              crit_multiplier = "druid.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "druid"
            }
          }
        },
        ferocious_bite = {
          id = 13,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 22568,
              label = "Ferocious Bite",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              class_spell_mask = "DruidSpellFerociousBite",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              crit_multiplier = "druid.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "5",
              class_token = "druid"
            }
          }
        },
        dash = {
          id = 14,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 1850,
              label = "Dash",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              related_self_buff = "druid.DashCDAura",
              class_token = "druid"
            },
            aura = {
              class = "druid",
              spell_id = 1850,
              label = "Dash",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "druid"
            }
          }
        },
        maul = {
          id = 15,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 6807,
              label = "Maul",
              cooldown = {
                raw = "time.Second * 3",
                seconds = 3.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              class_spell_mask = "DruidSpellMaul",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1.1",
              crit_multiplier = "druid.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "5",
              class_token = "druid"
            }
          }
        },
        ravage = {
          id = 16,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 6785,
              label = "Ravage",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              class_spell_mask = "DruidSpellRavage",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "9.5",
              crit_multiplier = "druid.DefaultMeleeCritMultiplier()",
              threat_multiplier = "1",
              max_range = "5",
              class_token = "druid"
            }
          }
        },
        rejuvenation = {
          id = 17,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 774,
              label = "Rejuvenation",
              flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
              class_spell_mask = "DruidSpellRejuvenation",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellHealing",
              damage_multiplier = "1",
              crit_multiplier = "druid.DefaultSpellCritMultiplier()",
              threat_multiplier = "1",
              class_token = "druid"
            }
          }
        },
        frenzied_regeneration = {
          id = 18,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 22842,
              label = "Frenzied Regeneration",
              cooldown = {
                raw = "time.Millisecond * 1500",
                seconds = 1.5
              },
              flags = "SpellFlagAPL",
              class_spell_mask = "DruidSpellFrenziedRegeneration",
              spell_school = "2",
              proc_mask = "ProcMaskSpellHealing",
              damage_multiplier = "1",
              crit_multiplier = "druid.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "druid"
            }
          }
        },
        tigers_fury4_pt15 = {
          id = 19,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "druid",
              spell_id = 138358,
              label = "Tiger's Fury 4PT15",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "druid"
            }
          }
        },
        stampede_pending = {
          id = 20,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "druid",
              spell_id = 131538,
              label = "Stampede Pending",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "druid"
            }
          }
        },
        stampede = {
          id = 21,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "druid",
              spell_id = 81022,
              label = "Stampede",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "druid"
            }
          }
        },
        wrath = {
          id = 22,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 5176,
              label = "Wrath",
              flags = "SpellFlagAPL",
              class_spell_mask = "DruidSpellWrath",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "druid.DefaultSpellCritMultiplier()",
              threat_multiplier = "1",
              class_token = "druid"
            }
          }
        },
        rebirth = {
          id = 23,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 48477,
              label = "Rebirth",
              cooldown = {
                raw = "time.Minute * 10",
                seconds = 600.0
              },
              flags = "SpellFlagOmenTrigger | core.SpellFlagAPL",
              class_token = "druid"
            }
          }
        },
        healing_touch = {
          id = 24,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 5185,
              label = "Healing Touch",
              flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
              class_spell_mask = "DruidSpellHealingTouch",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellHealing",
              damage_multiplier = "1",
              crit_multiplier = "druid.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "druid"
            }
          }
        },
        prowl = {
          id = 25,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 5215,
              label = "Prowl",
              cooldown = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              flags = "SpellFlagAPL",
              spell_school = "2",
              proc_mask = "2",
              class_token = "druid"
            },
            aura = {
              class = "druid",
              spell_id = 5215,
              label = "Prowl",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "druid"
            }
          }
        },
        innervate = {
          id = 26,
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
              flags = "core.SpellFlagReadinessTrinket",
              class_token = "druid"
            }
          }
        },
        tranquility = {
          id = 27,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "druid",
                spell_id = 740,
                label = "Tranquility",
                cooldown = {
                  raw = "time.Minute * 8",
                  seconds = 480.0
                },
                flags = "core.SpellFlagHelpful | core.SpellFlagAPL | core.SpellFlagChanneled",
                class_spell_mask = "DruidSpellTranquility",
                spell_school = "SpellSchoolNature",
                proc_mask = "ProcMaskSpellHealing",
                damage_multiplier = "1",
                crit_multiplier = "druid.DefaultSpellCritMultiplier()",
                threat_multiplier = "1",
                class_token = "druid"
              },
              {
                class = "druid",
                spell_id = 44203,
                label = "Tranquility (HoT)",
                flags = "core.SpellFlagHelpful | core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
                class_spell_mask = "DruidSpellTranquility",
                spell_school = "SpellSchoolNature",
                proc_mask = "ProcMaskSpellHealing",
                damage_multiplier = "1",
                crit_multiplier = "druid.DefaultSpellCritMultiplier()",
                threat_multiplier = "1",
                class_token = "druid"
              }
            }
          }
        },
        mangle_cat = {
          id = 28,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 33876,
              label = "Mangle Cat",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              class_spell_mask = "DruidSpellMangleCat",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "5",
              crit_multiplier = "druid.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "5",
              class_token = "druid"
            }
          }
        },
        mangle_bear = {
          id = 29,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 33878,
              label = "Mangle Bear",
              cooldown = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              class_spell_mask = "DruidSpellMangleBear",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "2.8 * core.TernaryFloat64(applySotF, 1.15, 1)",
              crit_multiplier = "druid.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "5",
              class_token = "druid"
            }
          }
        },
        berserk = {
          id = 30,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 106952,
              label = "Berserk",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              flags = "core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
              class_token = "druid"
            },
            aura = {
              {
                class = "druid",
                spell_id = 50334,
                label = "Berserk (Bear)",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "druid"
              },
              {
                class = "druid",
                spell_id = 106951,
                label = "Berserk (Cat)",
                duration = {
                  raw = "time.Second * 15",
                  seconds = 15.0
                },
                class_token = "druid"
              }
            }
          }
        },
        barkskin = {
          id = 31,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 22812,
              label = "Barkskin",
              cooldown = {
                raw = "core.TernaryDuration(druid.Spec == proto.Spec_SpecGuardianDruid, time.Second*30, time.Second*60)",
                cases = {
                  {
                    condition = "druid.Spec == proto.Spec_SpecGuardianDruid",
                    raw = "(time.Second*30)",
                    seconds = 30.0
                  },
                  {
                    condition = "!(druid.Spec == proto.Spec_SpecGuardianDruid)",
                    raw = "(time.Second*60)",
                    seconds = 60.0
                  }
                }
              },
              flags = "core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
              related_self_buff = "druid.BarkskinCDAura",
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
        typhoon = {
          id = 32,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 61391,
              label = "Typhoon",
              cooldown = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              flags = "core.SpellFlagAoE | core.SpellFlagAPL | SpellFlagOmenTrigger",
              class_spell_mask = "DruidSpellTyphoon",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "1",
              threat_multiplier = "1",
              class_token = "druid"
            }
          }
        },
        might_of_ursoc = {
          id = 33,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 106922,
              label = "Might Of Ursoc",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              class_spell_mask = "DruidSpellMightOfUrsoc",
              related_self_buff = "druid.MightOfUrsocCDAura",
              class_token = "druid"
            },
            aura = {
              class = "druid",
              spell_id = 106922,
              label = "Might of Ursoc",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "druid"
            }
          }
        },
        rake = {
          id = 34,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 1822,
              label = "Rake",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIgnoreArmor | core.SpellFlagAPL",
              class_spell_mask = "DruidSpellRake",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              crit_multiplier = "druid.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "5",
              class_token = "druid"
            }
          }
        },
        cat_charge = {
          id = 35,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 49376,
              label = "Cat Charge",
              flags = "SpellFlagAPL",
              max_range = "25",
              class_token = "druid"
            }
          }
        },
        cenarion_ward = {
          id = 36,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "druid",
                spell_id = 102351,
                label = "Cenarion Ward",
                cooldown = {
                  raw = "time.Second * 30",
                  seconds = 30.0
                },
                flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
                proc_mask = "2",
                class_token = "druid"
              },
              {
                class = "druid",
                spell_id = 102352,
                label = "Cenarion Ward (HoT)",
                flags = "core.SpellFlagHelpful | core.SpellFlagNoOnCastComplete",
                class_spell_mask = "DruidSpellCenarionWard",
                spell_school = "SpellSchoolNature",
                proc_mask = "ProcMaskSpellHealing",
                damage_multiplier = "1",
                crit_multiplier = "druid.DefaultSpellCritMultiplier()",
                threat_multiplier = "1",
                class_token = "druid"
              }
            },
            aura = {
              class = "druid",
              spell_id = 102351,
              label = "Cenarion Ward",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "druid"
            }
          }
        },
        renewal = {
          id = 37,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 108238,
              label = "Renewal",
              cooldown = {
                raw = "time.Minute * 2",
                seconds = 120.0
              },
              flags = "core.SpellFlagHelpful | core.SpellFlagAPL | core.SpellFlagIgnoreModifiers",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellHealing",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "druid"
            }
          }
        },
        yseras_gift = {
          id = 38,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 145108,
              label = "Yseras Gift",
              flags = "core.SpellFlagHelpful | core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellHealing",
              damage_multiplier = "1",
              crit_multiplier = "druid.DefaultSpellCritMultiplier()",
              threat_multiplier = "1",
              class_token = "druid"
            }
          }
        },
        natures_vigil = {
          id = 39,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "druid",
                spell_id = 124974,
                label = "Natures Vigil",
                cooldown = {
                  raw = "time.Second * 90",
                  seconds = 90.0
                },
                flags = "SpellFlagAPL",
                related_self_buff = "druid.NaturesVigilAura",
                class_token = "druid"
              },
              {
                class = "druid",
                spell_id = 124988,
                label = "Natures Vigil",
                flags = "core.SpellFlagHelpful | core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell | core.SpellFlagIgnoreAttackerModifiers",
                spell_school = "SpellSchoolNature",
                proc_mask = "ProcMaskSpellHealing",
                damage_multiplier = "1",
                threat_multiplier = "0",
                class_token = "druid"
              }
            },
            aura = {
              class = "druid",
              spell_id = 124974,
              label = "Nature's Vigil",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "druid"
            }
          }
        },
        displacer_beast = {
          id = 40,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 102280,
              label = "Displacer Beast",
              cooldown = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              related_self_buff = "druid.DisplacerBeastAura",
              class_token = "druid"
            },
            aura = {
              class = "druid",
              spell_id = 137452,
              label = "Displacer Beast",
              duration = {
                raw = "time.Second * 4",
                seconds = 4.0
              },
              class_token = "druid"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "rip",
        "bear_form",
        "cat_form",
        "swipe_cat",
        "swipe_bear",
        "lacerate",
        "moonfire_impact",
        "moonfire",
        "pulverize",
        "hurricane",
        "thrash_cat",
        "thrash_bear",
        "ferocious_bite",
        "dash",
        "maul",
        "ravage",
        "rejuvenation",
        "frenzied_regeneration",
        "tigers_fury4_pt15",
        "stampede_pending",
        "stampede",
        "wrath",
        "rebirth",
        "healing_touch",
        "prowl",
        "innervate",
        "tranquility",
        "mangle_cat",
        "mangle_bear",
        "berserk",
        "barkskin",
        "typhoon",
        "might_of_ursoc",
        "rake",
        "cat_charge",
        "cenarion_ward",
        "renewal",
        "yseras_gift",
        "natures_vigil",
        "displacer_beast"
      },
      synthetic = true
    },
    ShamanSpells = {
      fields = {
        chain_heal = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 55459,
              label = "Chain Heal",
              flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellHealing",
              damage_multiplier = "1 + 0.1*float64(shaman.Talents.ImprovedChainHeal)",
              crit_multiplier = "shaman.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "shaman"
            }
          }
        },
        healing_wave = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 49273,
              label = "Healing Wave",
              flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellHealing",
              damage_multiplier = "1",
              crit_multiplier = "shaman.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "shaman"
            }
          }
        },
        riptide = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 61301,
              label = "Riptide",
              cooldown = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellHealing",
              damage_multiplier = "1",
              crit_multiplier = "shaman.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "shaman"
            }
          }
        },
        healing_surge = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 49276,
              label = "Healing Surge",
              flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellHealing",
              damage_multiplier = "1",
              crit_multiplier = "shaman.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "shaman"
            }
          }
        },
        lightning_shield = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "shaman",
                spell_id = 324,
                label = "Lightning Shield",
                flags = "SpellFlagAPL",
                class_token = "shaman"
              },
              {
                class = "shaman",
                spell_id = 26364,
                label = "Lightning Shield",
                flags = "core.SpellFlagAgentReserved1",
                class_spell_mask = "SpellMaskLightningShield",
                spell_school = "SpellSchoolNature",
                proc_mask = "2",
                damage_multiplier = "1",
                crit_multiplier = "shaman.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "shaman"
              }
            },
            aura = {
              class = "shaman",
              spell_id = 324,
              label = "Lightning Shield",
              duration = {
                raw = "time.Minute * 60",
                seconds = 3600.0
              },
              class_token = "shaman"
            }
          }
        },
        earth_elemental_totem = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 2062,
              label = "Earth Elemental Totem",
              cooldown = {
                raw = "time.Minute * 5",
                seconds = 300.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              flags = "core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
              class_spell_mask = "SpellMaskEarthElementalTotem",
              class_token = "shaman"
            },
            aura = {
              class = "shaman",
              spell_id = 2062,
              label = "Earth Elemental Totem",
              duration = {
                raw = "time.Second * 60",
                seconds = 60.0
              },
              class_token = "shaman"
            }
          }
        },
        healing_stream_totem = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "shaman",
                spell_id = 5394,
                label = "Healing Stream Totem",
                flags = "SpellFlagAPL",
                class_token = "shaman"
              },
              {
                class = "shaman",
                spell_id = 5394,
                label = "Healing Stream Totem",
                flags = "core.SpellFlagHelpful | core.SpellFlagNoOnCastComplete",
                spell_school = "SpellSchoolNature",
                proc_mask = "2",
                damage_multiplier = "1",
                crit_multiplier = "1",
                threat_multiplier = "1",
                class_token = "shaman"
              }
            }
          }
        },
        elemental_talents = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "shaman",
                label = "Lava Surge Proc Aura",
                class_token = "shaman"
              },
              {
                class = "shaman",
                spell_id = 77762,
                label = "Lava Surge",
                duration = {
                  raw = "time.Second * 6",
                  seconds = 6.0
                },
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
            },
            spell = {
              class = "shaman",
              spell_id = 88767,
              label = "Elemental Talents",
              flags = "core.SpellFlagPassiveSpell | SpellFlagShamanSpell",
              class_spell_mask = "SpellMaskFulmination",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellProc",
              damage_multiplier = "1",
              crit_multiplier = "shaman.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "shaman"
            }
          }
        },
        new_flametongue_imbue = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 8024,
              label = "New Flametongue Imbue",
              flags = "core.SpellFlagPassiveSpell | SpellFlagShamanSpell",
              class_spell_mask = "SpellMaskFlametongueWeapon",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamageProc",
              damage_multiplier = "weapon.SwingSpeed / 2.6",
              crit_multiplier = "shaman.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "shaman"
            }
          }
        },
        make_wf_proc_trigger = {
          id = 10,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "shaman",
              label = "Windfury Imbue",
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
              flags = "core.SpellFlagPassiveSpell | SpellFlagShamanSpell",
              class_spell_mask = "SpellMaskFrostbrandWeapon",
              spell_school = "SpellSchoolFrost",
              proc_mask = "2",
              damage_multiplier = "1",
              crit_multiplier = "shaman.DefaultCritMultiplier()",
              threat_multiplier = "1",
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
              spell_id = 8034,
              label = "Frostbrand Attack",
              duration = {
                raw = "time.Second * 8",
                seconds = 8.0
              },
              class_token = "shaman"
            }
          }
        },
        flametongue_imbue = {
          id = 13,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "shaman",
              label = "Flametongue Weapon",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "shaman"
            }
          }
        },
        new_windfury_imbue = {
          id = 14,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 8232,
              label = "New Windfury Imbue",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagPassiveSpell",
              class_spell_mask = "SpellMaskWindfuryWeapon",
              spell_school = "2",
              proc_mask = "core.ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              crit_multiplier = "shaman.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "shaman"
            }
          }
        },
        enhancement_talents = {
          id = 15,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "shaman",
                spell_id = 51530,
                label = "MaelstromWeapon Proc",
                duration = {
                  raw = "time.Second * 30",
                  seconds = 30.0
                },
                class_token = "shaman"
              },
              {
                class = "shaman",
                spell_id = 77661,
                label = "Searing Flames",
                duration = {
                  raw = "time.Second * 15",
                  seconds = 15.0
                },
                class_token = "shaman"
              },
              {
                class = "shaman",
                spell_id = 16278,
                label = "Flurry Proc",
                duration = {
                  raw = "time.Second * 15",
                  seconds = 15.0
                },
                class_token = "shaman"
              }
            }
          }
        },
        magma_totem = {
          id = 16,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 8190,
              label = "MagmaTotem",
              flags = "core.SpellFlagAoE | core.SpellFlagAPL | SpellFlagShamanSpell",
              class_spell_mask = "SpellMaskMagmaTotem",
              spell_school = "SpellSchoolFire",
              proc_mask = "2",
              damage_multiplier = "1",
              crit_multiplier = "shaman.DefaultCritMultiplier()",
              class_token = "shaman"
            }
          }
        },
        searing_totem = {
          id = 17,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 3599,
              label = "SearingTotem",
              flags = "core.SpellFlagAPL | SpellFlagShamanSpell",
              class_spell_mask = "SpellMaskSearingTotem",
              spell_school = "SpellSchoolFire",
              proc_mask = "2",
              damage_multiplier = "1",
              crit_multiplier = "shaman.DefaultCritMultiplier()",
              class_token = "shaman"
            }
          }
        },
        empower = {
          id = 18,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 118350,
              label = "Empower",
              cooldown = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              flags = "SpellFlagChanneled",
              spell_school = "SpellSchoolFire",
              class_token = "shaman"
            },
            aura = {
              class = "shaman",
              spell_id = 118350,
              label = "Empower",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "shaman"
            }
          }
        },
        immolate = {
          id = 19,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 118297,
              label = "Immolate",
              cooldown = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              flags = "core.SpellFlagAgentReserved1",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "fireElemental.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "shaman"
            }
          }
        },
        fire_nova = {
          id = 20,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 117588,
              label = "Fire Nova",
              cooldown = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              flags = "core.SpellFlagAoE | SpellFlagShamanSpell",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "fireElemental.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "shaman"
            }
          }
        },
        fire_blast = {
          id = 21,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 57984,
              label = "Fire Blast",
              cooldown = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              flags = "core.SpellFlagAgentReserved1",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "fireElemental.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "shaman"
            }
          }
        },
        fire_elemental_totem = {
          id = 22,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 2894,
              label = "Fire Elemental Totem",
              cooldown = {
                raw = "time.Minute * 5",
                seconds = 300.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              flags = "core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
              class_spell_mask = "2",
              related_self_buff = "shaman.FireElementalTotemAura",
              class_token = "shaman"
            },
            aura = {
              class = "shaman",
              spell_id = 2894,
              label = "Fire Elemental Totem",
              duration = {
                raw = "time.Second * 60",
                seconds = 60.0
              },
              class_token = "shaman"
            }
          }
        },
        lightning_bolt = {
          id = 23,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "shaman",
                spell_id = 403,
                label = "Lightning Bolt",
                class_token = "shaman"
              },
              {
                class = "shaman",
                spell_id = 403,
                label = "Lightning Bolt",
                class_token = "shaman"
              },
              {
                class = "shaman",
                spell_id = 403,
                label = "Lightning Bolt",
                class_token = "shaman"
              }
            }
          }
        },
        pulverize = {
          id = 24,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 118345,
              label = "Pulverize",
              cooldown = {
                raw = "time.Second * 40",
                seconds = 40.0
              },
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1.5",
              crit_multiplier = "earthElemental.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "shaman"
            }
          }
        },
        frost_shock = {
          id = 25,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 8056,
              label = "Frost Shock",
              cooldown = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              flags = "SpellFlagShamanSpell | SpellFlagShock | core.SpellFlagAPL",
              spell_school = "core.SpellSchoolFrost",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "shaman.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "shaman"
            }
          }
        },
        flame_shock = {
          id = 26,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "shaman",
                spell_id = 8050,
                label = "FlameShock",
                flags = "config.Flags & ^core.SpellFlagAPL | core.SpellFlagPassiveSpell",
                class_spell_mask = "SpellMaskFlameShockDot",
                spell_school = "SpellSchoolFire",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "shaman.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "shaman"
              },
              {
                class = "shaman",
                spell_id = 8050,
                label = "Flame Shock",
                cooldown = {
                  raw = "time.Second * 6",
                  seconds = 6.0
                },
                flags = "SpellFlagShamanSpell | SpellFlagShock | core.SpellFlagAPL",
                spell_school = "core.SpellSchoolFire",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "shaman.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "shaman"
              }
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
              spell_id = 8042,
              label = "Earth Shock",
              cooldown = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              flags = "SpellFlagShamanSpell | SpellFlagShock | core.SpellFlagAPL",
              spell_school = "core.SpellSchoolNature",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "shaman.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "shaman"
            }
          }
        },
        ancestral_swiftness = {
          id = 28,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 16188,
              label = "Ancestral Swiftness",
              cooldown = {
                raw = "time.Second * 90",
                seconds = 90.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              flags = "SpellFlagNoOnCastComplete",
              class_token = "shaman"
            },
            aura = {
              {
                class = "shaman",
                spell_id = 16188,
                label = "Ancestral swiftness",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "shaman"
              },
              {
                class = "shaman",
                label = "Ancestral Swiftness Passive",
                class_token = "shaman"
              }
            }
          }
        },
        new_chain_lightning = {
          id = 29,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              label = "New Chain Lightning",
              flags = "flags",
              class_spell_mask = "config.ClassSpellMask",
              spell_school = "SpellSchoolNature",
              proc_mask = "mask",
              damage_multiplier = "1",
              crit_multiplier = "shaman.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "shaman"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "chain_heal",
        "healing_wave",
        "riptide",
        "healing_surge",
        "lightning_shield",
        "earth_elemental_totem",
        "healing_stream_totem",
        "elemental_talents",
        "new_flametongue_imbue",
        "make_wf_proc_trigger",
        "new_frostbrand_imbue",
        "frostbrand_debuff",
        "flametongue_imbue",
        "new_windfury_imbue",
        "enhancement_talents",
        "magma_totem",
        "searing_totem",
        "empower",
        "immolate",
        "fire_nova",
        "fire_blast",
        "fire_elemental_totem",
        "lightning_bolt",
        "pulverize",
        "frost_shock",
        "flame_shock",
        "earth_shock",
        "ancestral_swiftness",
        "new_chain_lightning"
      },
      synthetic = true
    },
    CoreSpells = {
      fields = {
        weapon_specialization = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "core",
                spell_id = 20574,
                label = "Axe Specialization",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 20597,
                label = "Sword Specialization ",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 92680,
                label = "Shortblade Specialization",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 59224,
                label = "Mace Specialization",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "core"
              }
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
                spell_id = 25046,
                label = "Race Effects",
                spell_school = "SpellSchoolShadow",
                proc_mask = "ProcMaskSpellProc",
                damage_multiplier = "1",
                crit_multiplier = "character.DefaultSpellCritMultiplier()",
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 25046,
                label = "Race Effects",
                cooldown = {
                  raw = "time.Minute * 3",
                  seconds = 180.0
                },
                major_cooldown = {
                  type = "CooldownTypeDPS"
                },
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 25046,
                label = "Race Effects",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                major_cooldown = {
                  type = "CooldownTypeUnknown"
                },
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 25046,
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
                spell_id = 25046,
                label = "Gift of the Naaru",
                cooldown = {
                  raw = "time.Second * 15",
                  seconds = 15.0
                },
                flags = "SpellFlagAPL | SpellFlagHelpful | SpellFlagIgnoreModifiers",
                spell_school = "SpellSchoolHoly",
                proc_mask = "ProcMaskSpellHealing",
                damage_multiplier = "1.0",
                crit_multiplier = "character.DefaultSpellCritMultiplier()",
                threat_multiplier = "1.0",
                max_range = "40",
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 25046,
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
              }
            },
            aura = {
              {
                class = "core",
                spell_id = 25046,
                label = "Berserking (Troll)",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 25046,
                label = "Shadowmeld",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "core"
              }
            }
          }
        },
        cast_speed_reduction = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "core",
                label = "Cast Speed Reduction",
                label_raw = "label",
                duration = {
                  raw = "astSpeedReduct"
                },
                class_token = "core"
              },
              {
                class = "core",
                label = "Cast Speed Reduction",
                label_raw = "label",
                duration = {
                  raw = "lowAura(target"
                },
                class_token = "core"
              },
              {
                class = "core",
                label = "Cast Speed Reduction",
                label_raw = "label",
                duration = {
                  raw = "urseOfEnfeeble"
                },
                class_token = "core"
              },
              {
                class = "core",
                label = "Cast Speed Reduction",
                label_raw = "label",
                duration = {
                  raw = "indNumbingPois"
                },
                class_token = "core"
              },
              {
                class = "core",
                label = "Cast Speed Reduction",
                label_raw = "label",
                duration = {
                  raw = "poreCloud(targ"
                },
                class_token = "core"
              },
              {
                class = "core",
                label = "Cast Speed Reduction",
                label_raw = "label",
                duration = {
                  raw = "avaBreathAura("
                },
                class_token = "core"
              }
            }
          }
        },
        spell_damage_effect = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "core",
                spell_id = 1490,
                label = "Spell Damage Effect",
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 58410,
                label = "Spell Damage Effect",
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 24844,
                label = "Spell Damage Effect",
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 34889,
                label = "Spell Damage Effect",
                class_token = "core"
              }
            }
          }
        },
        major_healing_reduction = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              label = "Major Healing Reduction",
              label_raw = "label",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "core"
            }
          }
        },
        phys_vulnerability = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "core",
                label = "Phys Vulnerability",
                label_raw = "label",
                duration = {
                  raw = ") } func phys"
                },
                class_token = "core"
              },
              {
                class = "core",
                label = "Phys Vulnerability",
                label_raw = "label",
                duration = {
                  raw = ") } func GoreA"
                },
                class_token = "core"
              },
              {
                class = "core",
                label = "Phys Vulnerability",
                label_raw = "label",
                duration = {
                  raw = ") } func Ravag"
                },
                class_token = "core"
              },
              {
                class = "core",
                label = "Phys Vulnerability",
                label_raw = "label",
                duration = {
                  raw = ") } func Stamp"
                },
                class_token = "core"
              },
              {
                class = "core",
                label = "Phys Vulnerability",
                label_raw = "label",
                duration = {
                  raw = ") } func AcidS"
                },
                class_token = "core"
              }
            }
          }
        },
        phys_damage_dealt = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "core",
                label = "Phys Damage Dealt",
                label_raw = "label",
                duration = {
                  raw = ") } func phys"
                },
                class_token = "core"
              },
              {
                class = "core",
                label = "Phys Damage Dealt",
                label_raw = "label",
                duration = {
                  raw = ") } func Demor"
                },
                class_token = "core"
              },
              {
                class = "core",
                label = "Phys Damage Dealt",
                label_raw = "label",
                duration = {
                  raw = "uration) } func Demor"
                },
                class_token = "core"
              }
            }
          }
        },
        weakened_armor = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              spell_id = 113746,
              label = "Weakened Armor",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "core"
            }
          }
        },
        make_set_bonus_status = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "core",
                label = "Make Set Bonus Status",
                label_raw = [[fmt.Sprintf("%s %dP", setName, numPieces)]],
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Set Bonus Status",
                label_raw = [[fmt.Sprintf("%s %dP", setName, numPieces)]],
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "core"
              }
            }
          }
        },
        init_movement = {
          id = 10,
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
        new_dot_increase_value = {
          id = 11,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              label = "Dummy Aura - APL Dot Increase Base Value",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "core"
            }
          }
        },
        enable_mana_bar_with_modifier = {
          id = 12,
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
        finalize = {
          id = 13,
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
          id = 14,
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
          id = 15,
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
        conjured = {
          id = 16,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "core",
                label = "Conjured",
                cooldown = {
                  raw = "time.Minute * 60",
                  seconds = 3600.0
                },
                major_cooldown = {
                  type = "CooldownTypeSurvival"
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "core"
              },
              {
                class = "core",
                label = "Conjured",
                cooldown = {
                  raw = "time.Minute * 15",
                  seconds = 900.0
                },
                major_cooldown = {
                  type = "CooldownTypeSurvival"
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "core"
              }
            }
          }
        },
        make_potion_activation_spell_internal = {
          id = 17,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "core",
              label = "Make Potion Activation Spell Internal",
              flags = "SpellFlagNoOnCastComplete",
              class_token = "core"
            }
          }
        },
        make_stacking = {
          id = 18,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              label = "Make Stacking",
              class_token = "core"
            }
          }
        },
        new_temporary_stats_aura_wrapped = {
          id = 19,
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
          id = 20,
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
        armor_specialization_tracker = {
          id = 21,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              label = "Armor Specialization",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "core"
            }
          }
        },
        storm_lash = {
          id = 22,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "core",
                spell_id = 120668,
                label = "Stormlash Totem",
                tag = "StormLash",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 120668,
                label = "Stormlash Totem",
                tag = "StormLash",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "core"
              }
            },
            spell = {
              {
                class = "core",
                spell_id = 120687,
                label = "Storm Lash",
                flags = "SpellFlagNoOnCastComplete | SpellFlagPassiveSpell",
                spell_school = "SpellSchoolNature",
                proc_mask = "2",
                damage_multiplier = "1",
                crit_multiplier = "character.DefaultMeleeCritMultiplier()",
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 120687,
                label = "Storm Lash",
                flags = "SpellFlagNoOnCastComplete | SpellFlagPassiveSpell",
                spell_school = "SpellSchoolNature",
                proc_mask = "2",
                damage_multiplier = "1",
                crit_multiplier = "character.DefaultMeleeCritMultiplier()",
                class_token = "core"
              }
            }
          }
        },
        external_consecutive_cd_approximation = {
          id = 23,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "core",
                spell_id = 120668,
                label = "External Consecutive Cd Approximation",
                cooldown = {
                  raw = "me.Second * 10",
                  seconds = 10.0
                },
                major_cooldown = {
                  type = "config.Type",
                  priority = "config.CooldownPriority"
                },
                flags = "SpellFlagNoOnCastComplete | SpellFlagNoMetrics | SpellFlagNoLogs",
                related_self_buff = "sbAura",
                class_token = "core"
              },
              {
                class = "core",
                label = "External Consecutive Cd Approximation",
                cooldown = {
                  raw = "me.Second * 12",
                  seconds = 12.0
                },
                major_cooldown = {
                  type = "config.Type",
                  priority = "config.CooldownPriority"
                },
                flags = "SpellFlagNoOnCastComplete | SpellFlagNoMetrics | SpellFlagNoLogs",
                related_self_buff = "mttAura",
                class_token = "core"
              },
              {
                class = "core",
                label = "External Consecutive Cd Approximation",
                cooldown = {
                  raw = "me.Second * 10",
                  seconds = 10.0
                },
                major_cooldown = {
                  type = "config.Type",
                  priority = "config.CooldownPriority"
                },
                flags = "SpellFlagNoOnCastComplete | SpellFlagNoMetrics | SpellFlagNoLogs",
                related_self_buff = "sbAura",
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 1249459,
                label = "External Consecutive Cd Approximation",
                cooldown = {
                  raw = "hatteringThrowAu"
                },
                major_cooldown = {
                  type = "config.Type",
                  priority = "config.CooldownPriority"
                },
                flags = "SpellFlagNoOnCastComplete | SpellFlagNoMetrics | SpellFlagNoLogs",
                related_self_buff = "stAura",
                class_token = "core"
              },
              {
                class = "core",
                label = "External Consecutive Cd Approximation",
                cooldown = {
                  raw = "me.Second * 10",
                  seconds = 10.0
                },
                major_cooldown = {
                  type = "config.Type",
                  priority = "config.CooldownPriority"
                },
                flags = "SpellFlagNoOnCastComplete | SpellFlagNoMetrics | SpellFlagNoLogs",
                related_self_buff = "config.RelatedSelfBuff",
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 47788,
                label = "External Consecutive Cd Approximation",
                cooldown = {
                  raw = "me.Second * 10",
                  seconds = 10.0
                },
                major_cooldown = {
                  type = "config.Type",
                  priority = "config.CooldownPriority"
                },
                flags = "SpellFlagNoOnCastComplete | SpellFlagNoMetrics | SpellFlagNoLogs",
                related_self_buff = "gsAura",
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 33206,
                label = "External Consecutive Cd Approximation",
                cooldown = {
                  raw = "me.Second * 8",
                  seconds = 8.0
                },
                major_cooldown = {
                  type = "config.Type",
                  priority = "config.CooldownPriority"
                },
                flags = "SpellFlagNoOnCastComplete | SpellFlagNoMetrics | SpellFlagNoLogs",
                related_self_buff = "psAura",
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 4030,
                label = "External Consecutive Cd Approximation",
                cooldown = {
                  raw = "me.Second * 12",
                  seconds = 12.0
                },
                major_cooldown = {
                  type = "config.Type",
                  priority = "config.CooldownPriority"
                },
                flags = "SpellFlagNoOnCastComplete | SpellFlagNoMetrics | SpellFlagNoLogs",
                related_self_buff = "buffAura",
                class_token = "core"
              },
              {
                class = "core",
                label = "External Consecutive Cd Approximation",
                cooldown = {
                  raw = "time.Second * 6",
                  seconds = 6.0
                },
                major_cooldown = {
                  type = "config.Type",
                  priority = "config.CooldownPriority"
                },
                flags = "SpellFlagNoOnCastComplete | SpellFlagNoMetrics | SpellFlagNoLogs",
                related_self_buff = "devAura",
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 49016,
                label = "External Consecutive Cd Approximation",
                cooldown = {
                  raw = "time.Second * 30",
                  seconds = 30.0
                },
                major_cooldown = {
                  type = "config.Type",
                  priority = "config.CooldownPriority"
                },
                flags = "SpellFlagNoOnCastComplete | SpellFlagNoMetrics | SpellFlagNoLogs",
                related_self_buff = "ufAura",
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 57933,
                label = "External Consecutive Cd Approximation",
                cooldown = {
                  raw = "tricksAura.Duration"
                },
                major_cooldown = {
                  type = "config.Type",
                  priority = "config.CooldownPriority"
                },
                flags = "SpellFlagNoOnCastComplete | SpellFlagNoMetrics | SpellFlagNoLogs",
                related_self_buff = "tricksAura",
                class_token = "core"
              }
            }
          }
        },
        skull_banner = {
          id = 24,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "core",
                spell_id = 114206,
                label = "Skull Banner",
                tag = "SkullBanner",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 114206,
                label = "Skull Banner",
                tag = "SkullBanner",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "core"
              }
            }
          }
        },
        unholy_frenzy = {
          id = 25,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              spell_id = 49016,
              label = "UnholyFrenzy",
              tag = "UnholyFrenzy",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "core"
            }
          }
        },
        make_exclusive = {
          id = 26,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "core",
                label = "Make Exclusive",
                label_raw = "config.Label",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Exclusive",
                label_raw = "config.Label",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Exclusive",
                label_raw = "config.Label",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Exclusive",
                label_raw = "config.Label",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Exclusive",
                label_raw = "config.Label",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Exclusive",
                label_raw = "config.Label",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Exclusive",
                label_raw = "config.Label",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Exclusive",
                label_raw = "config.Label",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Exclusive",
                label_raw = "config.Label",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Exclusive",
                label_raw = "config.Label",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Exclusive",
                label_raw = "config.Label",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Exclusive",
                label_raw = "config.Label",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Exclusive",
                label_raw = "config.Label",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Exclusive",
                label_raw = "config.Label",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Exclusive",
                label_raw = "config.Label",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Exclusive",
                label_raw = "config.Label",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Exclusive",
                label_raw = "config.Label",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Exclusive",
                label_raw = "config.Label",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Exclusive",
                label_raw = "config.Label",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Exclusive",
                label_raw = "config.Label",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Exclusive",
                label_raw = "config.Label",
                class_token = "core"
              }
            }
          }
        },
        rallying_cry_aura_array = {
          id = 27,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              label = "RallyingCry",
              tag = "RallyingCry",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "core"
            }
          }
        },
        guardian_spirit = {
          id = 28,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              spell_id = 47788,
              label = "GuardianSpirit",
              tag = "GuardianSpirit",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "core"
            }
          }
        },
        vigilance = {
          id = 29,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              spell_id = 114030,
              label = "Vigilance",
              tag = "Vigilance",
              duration = {
                raw = "time.Second * 12",
                seconds = 12.0
              },
              class_token = "core"
            }
          }
        },
        tricks_of_the_trade = {
          id = 30,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              spell_id = 57933,
              label = "TricksOfTheTrade",
              tag = "TricksOfTheTrade",
              duration = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              class_token = "core"
            }
          }
        },
        new_fake_elemental_shaman = {
          id = 31,
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
        "weapon_specialization",
        "race_effects",
        "cast_speed_reduction",
        "spell_damage_effect",
        "major_healing_reduction",
        "phys_vulnerability",
        "phys_damage_dealt",
        "weakened_armor",
        "make_set_bonus_status",
        "init_movement",
        "new_dot_increase_value",
        "enable_mana_bar_with_modifier",
        "finalize",
        "track_chance_of_death",
        "enable_rage_bar",
        "conjured",
        "make_potion_activation_spell_internal",
        "make_stacking",
        "new_temporary_stats_aura_wrapped",
        "make_proc_trigger",
        "armor_specialization_tracker",
        "storm_lash",
        "external_consecutive_cd_approximation",
        "skull_banner",
        "unholy_frenzy",
        "make_exclusive",
        "rallying_cry_aura_array",
        "guardian_spirit",
        "vigilance",
        "tricks_of_the_trade",
        "new_fake_elemental_shaman"
      },
      synthetic = true
    },
    HunterSpells = {
      fields = {
        beast_mastery_t16 = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "hunter",
                spell_id = 144670,
                label = "Brutal Kinship",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 145737,
                label = "Brutal Kinship",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "hunter"
              }
            }
          }
        },
        marksman_t16 = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "hunter",
              spell_id = 144659,
              label = "Keen Eye",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "hunter"
            }
          }
        },
        lightning_arrow = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 138366,
              label = "Lightning Arrow",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagRanged | core.SpellFlagPassiveSpell",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskRangedProc",
              damage_multiplier = "1.0",
              crit_multiplier = "hunter.DefaultCritMultiplier()",
              threat_multiplier = "1.0",
              class_token = "hunter"
            }
          }
        },
        summon_thunderhawk = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 138363,
              label = "Summon Thunderhawk",
              flags = "SpellFlagPassiveSpell",
              spell_school = "2",
              class_token = "hunter"
            }
          }
        },
        cobra_shot = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 77767,
              label = "Cobra Shot",
              flags = "core.SpellFlagAPL | core.SpellFlagRanged",
              class_spell_mask = "HunterSpellCobraShot",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskRangedSpecial",
              damage_multiplier = "0.77",
              crit_multiplier = "hunter.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "40",
              class_token = "hunter"
            }
          }
        },
        lynx_rush = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "hunter",
                spell_id = 120697,
                label = "Lynx Rush",
                cooldown = {
                  raw = "time.Second * 90",
                  seconds = 90.0
                },
                flags = "SpellFlagAPL",
                spell_school = "0",
                proc_mask = "2",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 120697,
                label = "Lynx Rush",
                flags = "SpellFlagMeleeMetrics",
                class_spell_mask = "HunterSpellLynxRush",
                spell_school = "2",
                proc_mask = "ProcMaskSpellProc | ProcMaskRangedProc | ProcMaskMeleeProc",
                damage_multiplier = "1",
                crit_multiplier = "1",
                class_token = "hunter"
              }
            }
          }
        },
        glaive_toss = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "hunter",
                spell_id = 117050,
                label = "Glaive Toss",
                cooldown = {
                  raw = "15 * time.Second",
                  seconds = 15.0
                },
                flags = "SpellFlagAPL",
                class_spell_mask = "HunterSpellGlaiveToss",
                spell_school = "2",
                proc_mask = "ProcMaskSpellProc | ProcMaskRangedProc | ProcMaskMeleeProc",
                damage_multiplier_additive = "1",
                crit_multiplier = "hunter.DefaultCritMultiplier()",
                threat_multiplier = "1",
                max_range = "40",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 117050,
                label = "Glaive Toss",
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagRanged | core.SpellFlagPassiveSpell",
                class_spell_mask = "HunterSpellGlaiveToss",
                spell_school = "2",
                proc_mask = "ProcMaskRangedSpecial",
                damage_multiplier = "1",
                damage_multiplier_additive = "1",
                crit_multiplier = "hunter.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "hunter"
              }
            }
          }
        },
        boars_speed = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "hunter",
              spell_id = 19596,
              label = "Boar's Speed",
              class_token = "hunter"
            }
          }
        },
        spiked_collar = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "hunter",
              spell_id = 53184,
              label = "Spiked Collar",
              class_token = "hunter"
            }
          }
        },
        aspect = {
          id = 10,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "hunter",
              spell_id = 13165,
              label = "Aspect of the Hawk",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "hunter"
            },
            spell = {
              class = "hunter",
              label = "Aspect",
              flags = "SpellFlagAPL",
              class_token = "hunter"
            }
          }
        },
        amoc = {
          id = 11,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 131894,
              label = "Peck",
              tag = "Peck",
              cooldown = {
                raw = "time.Minute * 2",
                seconds = 120.0
              },
              flags = "core.SpellFlagAPL | core.SpellFlagApplyArmorReduction | core.SpellFlagRanged",
              class_spell_mask = "HunterSpellAMurderOfCrows",
              spell_school = "2",
              proc_mask = "ProcMaskSpellProc | ProcMaskRangedProc | ProcMaskMeleeProc",
              damage_multiplier_additive = "1",
              crit_multiplier = "hunter.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "40",
              class_token = "hunter"
            }
          }
        },
        rapid_fire = {
          id = 12,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 3045,
              label = "Rapid Fire",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              flags = "core.SpellFlagReadinessTrinket",
              class_spell_mask = "HunterSpellRapidFire",
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
        multi_shot = {
          id = 13,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 2643,
              label = "Multi Shot",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagRanged",
              class_spell_mask = "HunterSpellMultiShot",
              spell_school = "2",
              proc_mask = "ProcMaskRangedSpecial",
              damage_multiplier = "0.6",
              damage_multiplier_additive = "1",
              crit_multiplier = "hunter.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "40",
              class_token = "hunter"
            }
          }
        },
        new_focus_dump = {
          id = 14,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "hunter",
                label = "New Focus Dump",
                cooldown = {
                  raw = "time.Millisecond * 3200",
                  seconds = 3.2
                },
                flags = "SpellFlagMeleeMetrics",
                class_spell_mask = "HunterPetFocusDump",
                spell_school = "2",
                proc_mask = "ProcMaskMeleeMHSpecial",
                damage_multiplier = "1",
                damage_multiplier_additive = "1",
                crit_multiplier = "hp.CritMultiplier(1.0, 0.0)",
                threat_multiplier = "1",
                class_token = "hunter"
              },
              {
                class = "hunter",
                label = "New Focus Dump",
                cooldown = {
                  raw = "time.Millisecond * 3200",
                  seconds = 3.2
                },
                flags = "SpellFlagMeleeMetrics",
                class_spell_mask = "HunterPetFocusDump",
                spell_school = "2",
                proc_mask = "ProcMaskMeleeMHSpecial",
                damage_multiplier = "1",
                damage_multiplier_additive = "1",
                crit_multiplier = "hp.CritMultiplier(1.0, 0.0)",
                threat_multiplier = "1",
                class_token = "hunter"
              },
              {
                class = "hunter",
                label = "New Focus Dump",
                cooldown = {
                  raw = "time.Millisecond * 3200",
                  seconds = 3.2
                },
                flags = "SpellFlagMeleeMetrics",
                class_spell_mask = "HunterPetFocusDump",
                spell_school = "2",
                proc_mask = "ProcMaskMeleeMHSpecial",
                damage_multiplier = "1",
                damage_multiplier_additive = "1",
                crit_multiplier = "hp.CritMultiplier(1.0, 0.0)",
                threat_multiplier = "1",
                class_token = "hunter"
              }
            }
          }
        },
        new_pet_de = {
          id = 15,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "hunter",
                spell_id = 54680,
                label = "New Pet De",
                cooldown = {
                  raw = "time.Second * 8",
                  seconds = 8.0
                },
                flags = "SpellFlagAPL",
                spell_school = "core.SpellSchoolNature",
                proc_mask = "2",
                threat_multiplier = "1",
                max_range = "core.MaxMeleeRange",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 50498,
                label = "New Pet De",
                cooldown = {
                  raw = "time.Second * 6",
                  seconds = 6.0
                },
                flags = "SpellFlagAPL",
                spell_school = "core.SpellSchoolNature",
                proc_mask = "2",
                threat_multiplier = "1",
                max_range = "core.MaxMeleeRange",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 50285,
                label = "New Pet De",
                cooldown = {
                  raw = "time.Second * 25",
                  seconds = 25.0
                },
                flags = "SpellFlagAPL",
                spell_school = "core.SpellSchoolNature",
                proc_mask = "2",
                threat_multiplier = "1",
                max_range = "core.MaxMeleeRange",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 58604,
                label = "New Pet De",
                cooldown = {
                  raw = "time.Second * 8",
                  seconds = 8.0
                },
                flags = "SpellFlagAPL",
                spell_school = "core.SpellSchoolFire",
                proc_mask = "2",
                threat_multiplier = "1",
                max_range = "30",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 50274,
                label = "New Pet De",
                cooldown = {
                  raw = "time.Second * 8",
                  seconds = 8.0
                },
                flags = "SpellFlagAPL",
                spell_school = "core.SpellSchoolFire",
                proc_mask = "2",
                threat_multiplier = "1",
                max_range = "6",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 24844,
                label = "New Pet De",
                cooldown = {
                  raw = "time.Second * 30",
                  seconds = 30.0
                },
                flags = "SpellFlagAPL",
                spell_school = "core.SpellSchoolFire",
                proc_mask = "2",
                threat_multiplier = "1",
                max_range = "40",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 34889,
                label = "New Pet De",
                cooldown = {
                  raw = "time.Second * 30",
                  seconds = 30.0
                },
                flags = "SpellFlagAPL",
                spell_school = "core.SpellSchoolFire",
                proc_mask = "2",
                threat_multiplier = "1",
                max_range = "40",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 24423,
                label = "New Pet De",
                cooldown = {
                  raw = "time.Second * 8",
                  seconds = 8.0
                },
                flags = "SpellFlagAPL",
                spell_school = "core.SpellSchoolNature",
                proc_mask = "2",
                threat_multiplier = "1",
                max_range = "core.MaxMeleeRange",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 50256,
                label = "New Pet De",
                cooldown = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                flags = "SpellFlagAPL",
                spell_school = "core.SpellSchoolNature",
                proc_mask = "2",
                threat_multiplier = "1",
                max_range = "core.MaxMeleeRange",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 55749,
                label = "New Pet De",
                cooldown = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                flags = "SpellFlagAPL",
                spell_school = "core.SpellSchoolNature",
                proc_mask = "2",
                threat_multiplier = "1",
                max_range = "30",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 57386,
                label = "New Pet De",
                cooldown = {
                  raw = "time.Second * 15",
                  seconds = 15.0
                },
                flags = "SpellFlagAPL",
                spell_school = "core.SpellSchoolPhysical",
                proc_mask = "2",
                threat_multiplier = "1",
                max_range = "core.MaxMeleeRange",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 50518,
                label = "New Pet De",
                cooldown = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                flags = "SpellFlagAPL",
                spell_school = "core.SpellSchoolPhysical",
                proc_mask = "2",
                threat_multiplier = "1",
                max_range = "core.MaxMeleeRange",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 35290,
                label = "New Pet De",
                cooldown = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                flags = "SpellFlagAPL",
                spell_school = "core.SpellSchoolPhysical",
                proc_mask = "2",
                threat_multiplier = "1",
                max_range = "core.MaxMeleeRange",
                class_token = "hunter"
              }
            }
          }
        },
        lightning_blast = {
          id = 16,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 138374,
              label = "Lightning Blast",
              spell_school = "SpellSchoolNature",
              proc_mask = "2",
              damage_multiplier = "1",
              crit_multiplier = "tp.CritMultiplier(1.0, 0.0)",
              threat_multiplier = "1",
              max_range = "40",
              class_token = "hunter"
            }
          }
        },
        blink_strikes = {
          id = 17,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 130393,
              label = "Blink Strikes",
              cooldown = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              max_range = "30",
              class_token = "hunter"
            },
            aura = {
              class = "hunter",
              spell_id = 130392,
              label = "Blink Strikes",
              class_token = "hunter"
            }
          }
        },
        dash = {
          id = 18,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 61684,
              label = "Dash",
              cooldown = {
                raw = "time.Second * 32",
                seconds = 32.0
              },
              class_token = "hunter"
            },
            aura = {
              class = "hunter",
              spell_id = 61684,
              label = "Dash",
              duration = {
                raw = "time.Second * 16",
                seconds = 16.0
              },
              class_token = "hunter"
            }
          }
        },
        rabid = {
          id = 19,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 53401,
              label = "Rabid",
              cooldown = {
                raw = "time.Second * 90",
                seconds = 90.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              class_token = "hunter"
            },
            aura = {
              class = "hunter",
              spell_id = 53401,
              label = "Rabid",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "hunter"
            }
          }
        },
        new_frost_storm_breath = {
          id = 20,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 92380,
              label = "FrostStormBreath",
              flags = "core.SpellFlagChanneled | core.SpellFlagNoMetrics",
              spell_school = "core.SpellSchoolNature | core.SpellSchoolFrost",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              damage_multiplier_additive = "1",
              crit_multiplier = "hp.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "hunter"
            }
          }
        },
        get_frost_storm_tick = {
          id = 21,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 92380,
              label = "Get Frost Storm Tick (Spell 92380)",
              spell_school = "core.SpellSchoolNature | core.SpellSchoolFrost",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              damage_multiplier_additive = "1",
              crit_multiplier = "hp.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "hunter"
            }
          }
        },
        kill_command = {
          id = 22,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 83381,
              label = "Kill Command",
              flags = "SpellFlagAPL",
              class_spell_mask = "HunterSpellKillCommand",
              spell_school = "2",
              proc_mask = "2",
              damage_multiplier = "1",
              crit_multiplier = "hp.CritMultiplier(1.0, 0.0)",
              threat_multiplier = "1",
              max_range = "25",
              class_token = "hunter"
            },
            aura = {
              class = "hunter",
              label = "Charge",
              duration = {
                raw = "5 * time.Second",
                seconds = 5.0
              },
              class_token = "hunter"
            }
          }
        },
        stampede = {
          id = 23,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 121818,
              label = "Stampede",
              cooldown = {
                raw = "time.Minute * 5",
                seconds = 300.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              flags = "core.SpellFlagReadinessTrinket",
              class_token = "hunter"
            }
          }
        },
        dire_beast = {
          id = 24,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 120679,
              label = "Dire Beast",
              cooldown = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              class_spell_mask = "HunterSpellDireBeast",
              class_token = "hunter"
            }
          }
        },
        fervor = {
          id = 25,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 82726,
              label = "Fervor",
              cooldown = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              flags = "core.SpellFlagAPL | core.SpellFlagReactive",
              class_spell_mask = "HunterSpellFervor",
              class_token = "hunter"
            }
          }
        },
        serpent_sting = {
          id = 26,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "hunter",
                spell_id = 1978,
                label = "SerpentStingDot",
                tag = "Serpent Sting",
                flags = "core.SpellFlagAPL | core.SpellFlagRanged",
                class_spell_mask = "HunterSpellSerpentSting",
                spell_school = "SpellSchoolNature",
                proc_mask = "ProcMaskSpellProc | ProcMaskRangedProc | ProcMaskMeleeProc",
                damage_multiplier_additive = "1",
                crit_multiplier = "hunter.CritMultiplier(1, 0)",
                threat_multiplier = "1",
                max_range = "40",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 118976,
                label = "Serpent Sting",
                cooldown = {
                  raw = "time.Second * 3",
                  seconds = 3.0
                },
                flags = "0",
                proc_mask = "2",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 1978,
                label = "Serpent Sting",
                flags = "core.SpellFlagPassiveSpell | core.SpellFlagRanged",
                class_spell_mask = "HunterSpellSerpentSting",
                spell_school = "SpellSchoolNature",
                proc_mask = "ProcMaskMelee | ProcMaskRanged | ProcMaskSpellDamage",
                damage_multiplier = "1",
                damage_multiplier_additive = "1",
                crit_multiplier = "hunter.CritMultiplier(1, 0)",
                class_token = "hunter"
              }
            }
          }
        },
        power_shot = {
          id = 27,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 109259,
              label = "Power Shot",
              cooldown = {
                raw = "45 * time.Second",
                seconds = 45.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagRanged",
              class_spell_mask = "HunterSpellPowershot",
              spell_school = "2",
              proc_mask = "ProcMaskRangedSpecial",
              damage_multiplier = "6",
              crit_multiplier = "hunter.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "40",
              class_token = "hunter"
            }
          }
        },
        explosive_trap = {
          id = 28,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 13812,
              label = "Explosive Trap",
              cooldown = {
                raw = "core.Ternary(hunter.Spec == proto.Spec_SpecSurvivalHunter, 24*time.Second, 30*time.Second)",
                cases = {
                  {
                    condition = "hunter.Spec == proto.Spec_SpecSurvivalHunter",
                    raw = "(24*time.Second)",
                    seconds = 24.0
                  },
                  {
                    condition = "!(hunter.Spec == proto.Spec_SpecSurvivalHunter)",
                    raw = "(30*time.Second)",
                    seconds = 30.0
                  }
                }
              },
              flags = "core.SpellFlagAoE | core.SpellFlagAPL",
              class_spell_mask = "HunterSpellExplosiveTrap",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier_additive = "1",
              crit_multiplier = "hunter.CritMultiplier(1, 0)",
              threat_multiplier = "1",
              class_token = "hunter"
            }
          }
        },
        arcane_shot = {
          id = 29,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 3044,
              label = "Arcane Shot",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagRanged",
              class_spell_mask = "HunterSpellArcaneShot",
              spell_school = "SpellSchoolArcane",
              proc_mask = "ProcMaskRangedSpecial",
              damage_multiplier = "1.25",
              damage_multiplier_additive = "1",
              crit_multiplier = "hunter.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "40",
              class_token = "hunter"
            }
          }
        },
        kill_shot = {
          id = 30,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 53351,
              label = "Kill Shot",
              cooldown = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagRanged",
              class_spell_mask = "HunterSpellKillShot",
              spell_school = "2",
              proc_mask = "ProcMaskRangedSpecial",
              damage_multiplier = "4.2",
              crit_multiplier = "hunter.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "45",
              class_token = "hunter"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "beast_mastery_t16",
        "marksman_t16",
        "lightning_arrow",
        "summon_thunderhawk",
        "cobra_shot",
        "lynx_rush",
        "glaive_toss",
        "boars_speed",
        "spiked_collar",
        "aspect",
        "amoc",
        "rapid_fire",
        "multi_shot",
        "new_focus_dump",
        "new_pet_de",
        "lightning_blast",
        "blink_strikes",
        "dash",
        "rabid",
        "new_frost_storm_breath",
        "get_frost_storm_tick",
        "kill_command",
        "stampede",
        "dire_beast",
        "fervor",
        "serpent_sting",
        "power_shot",
        "explosive_trap",
        "arcane_shot",
        "kill_shot"
      },
      synthetic = true
    },
    PriestSpells = {
      fields = {
        binding_heal = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              spell_id = 48120,
              label = "Binding Heal",
              flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskSpellHealing",
              damage_multiplier = "1 * (1 + .02*float64(priest.Talents.SpiritualHealing)) * (1 + .01*float64(priest.Talents.BlessedResilience)) * (1 + .02*float64(priest.Talents.FocusedPower)) * (1 + .02*float64(priest.Talents.DivineProvidence))",
              crit_multiplier = "priest.DefaultCritMultiplier()",
              threat_multiplier = "0.5 * (1 - []float64{0, .07, .14, .20}[priest.Talents.SilentResolve])",
              class_token = "priest"
            }
          }
        },
        new_mind_sear = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              label = "New Mind Sear",
              class_spell_mask = "PriestSpellMindSear",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellProc",
              damage_multiplier = "1",
              damage_multiplier_additive = "1",
              crit_multiplier = "priest.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "priest"
            }
          }
        },
        get_mind_sear_tick = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              label = "Get Mind Sear Tick",
              class_spell_mask = "PriestSpellMindSear",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellProc",
              damage_multiplier = "1",
              damage_multiplier_additive = "1",
              crit_multiplier = "priest.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "priest"
            }
          }
        },
        power_word_shield = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "priest",
              spell_id = 6788,
              label = "Weakened Soul",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "priest"
            },
            spell = {
              class = "priest",
              spell_id = 48066,
              label = "Power Word Shield",
              flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskSpellHealing",
              damage_multiplier = "1 * (1 + .05*float64(priest.Talents.ImprovedPowerWordShield)) * (1 + .01*float64(priest.Talents.TwinDisciplines) + .02*float64(priest.Talents.FocusedPower) + .02*float64(priest.Talents.SpiritualHealing)) * core.TernaryFloat64(priest.CouldHaveSetBonus(ItemSetCrimsonAcolytesRaiment, 4), 1.05, 1)",
              threat_multiplier = "1 - []float64{0, .07, .14, .20}[priest.Talents.SilentResolve]",
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
              spell_id = 48123,
              label = "Smite",
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1 + 0.05*float64(priest.Talents.SearingLight)",
              crit_multiplier = "priest.DefaultCritMultiplier()",
              threat_multiplier = "1 - []float64{0, .07, .14, .20}[priest.Talents.SilentResolve]",
              class_token = "priest"
            }
          }
        },
        initialize = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "priest",
              spell_id = 588,
              label = "Inner Fire",
              class_token = "priest"
            }
          }
        },
        greater_heal = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              spell_id = 48063,
              label = "Greater Heal",
              flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskSpellHealing",
              damage_multiplier = "1 * (1 + .02*float64(priest.Talents.SpiritualHealing)) * (1 + .01*float64(priest.Talents.BlessedResilience)) * (1 + .02*float64(priest.Talents.FocusedPower)) * core.TernaryFloat64(priest.CouldHaveSetBonus(ItemSetVestmentsOfAbsolution, 4), 1.05, 1)",
              crit_multiplier = "priest.DefaultCritMultiplier()",
              threat_multiplier = "1 - []float64{0, .07, .14, .20}[priest.Talents.SilentResolve]",
              class_token = "priest"
            }
          }
        },
        holy_fire = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              spell_id = 48135,
              label = "HolyFire",
              cooldown = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1 + 0.05*float64(priest.Talents.SearingLight)",
              crit_multiplier = "priest.DefaultCritMultiplier()",
              threat_multiplier = "1 - []float64{0, .07, .14, .20}[priest.Talents.SilentResolve]",
              class_token = "priest"
            }
          }
        },
        new_mind_bender = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              spell_id = 63619,
              label = "New Mind Bender",
              flags = "SpellFlagNoLogs",
              spell_school = "SpellSchoolShadow",
              proc_mask = "2",
              class_token = "priest"
            },
            aura = {
              {
                class = "priest",
                spell_id = 63619,
                label = "Shadowcrawl",
                duration = {
                  raw = "time.Second * 5",
                  seconds = 5.0
                },
                class_token = "priest"
              },
              {
                class = "priest",
                spell_id = 34433,
                label = "Autoattack mana regen",
                class_token = "priest"
              }
            }
          }
        },
        new_shadowfiend = {
          id = 10,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              spell_id = 63619,
              label = "New Shadowfiend",
              flags = "SpellFlagNoLogs",
              spell_school = "SpellSchoolShadow",
              proc_mask = "2",
              class_token = "priest"
            },
            aura = {
              {
                class = "priest",
                spell_id = 63619,
                label = "Shadowcrawl",
                duration = {
                  raw = "time.Second * 5",
                  seconds = 5.0
                },
                class_token = "priest"
              },
              {
                class = "priest",
                spell_id = 34433,
                label = "Autoattack mana regen",
                class_token = "priest"
              }
            }
          }
        },
        flash_heal = {
          id = 11,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              spell_id = 48071,
              label = "Flash Heal",
              flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskSpellHealing",
              damage_multiplier = "1 * (1 + .02*float64(priest.Talents.SpiritualHealing)) * (1 + .01*float64(priest.Talents.BlessedResilience)) * (1 + .02*float64(priest.Talents.FocusedPower))",
              crit_multiplier = "priest.DefaultCritMultiplier()",
              threat_multiplier = "1 - []float64{0, .07, .14, .20}[priest.Talents.SilentResolve]",
              class_token = "priest"
            }
          }
        },
        hymn_of_hope = {
          id = 12,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              spell_id = 64901,
              label = "Hymn Of Hope",
              cooldown = {
                raw = "time.Minute * 6",
                seconds = 360.0
              },
              major_cooldown = {
                type = "core.CooldownTypeMana"
              },
              flags = "SpellFlagHelpful",
              class_token = "priest"
            }
          }
        },
        regaliaofthe_ternion_glory4_p = {
          id = 13,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "priest",
              spell_id = 145180,
              label = "Regalia of the Ternion Glory - 4P (Proc)",
              duration = {
                raw = "time.Second * 12",
                seconds = 12.0
              },
              class_token = "priest"
            }
          }
        },
        renew = {
          id = 14,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "priest",
                spell_id = 48068,
                label = "Renew",
                flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
                spell_school = "SpellSchoolHoly",
                proc_mask = "ProcMaskSpellHealing",
                damage_multiplier = "priest.renewHealingMultiplier()",
                threat_multiplier = "1 - []float64{0, .07, .14, .20}[priest.Talents.SilentResolve]",
                class_token = "priest"
              },
              {
                class = "priest",
                spell_id = 63543,
                label = "Renew",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagHelpful",
                spell_school = "SpellSchoolHoly",
                proc_mask = "ProcMaskSpellHealing",
                damage_multiplier = "1 * float64(priest.renewTicks()) * priest.renewHealingMultiplier() * .05 * float64(priest.Talents.EmpoweredRenew) * core.TernaryFloat64(priest.CouldHaveSetBonus(ItemSetZabrasRaiment, 4), 1.1, 1)",
                crit_multiplier = "priest.DefaultCritMultiplier()",
                threat_multiplier = "1 - []float64{0, .07, .14, .20}[priest.Talents.SilentResolve]",
                class_token = "priest"
              }
            }
          }
        },
        dispersion = {
          id = 15,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              spell_id = 47585,
              label = "Dispersion",
              cooldown = {
                raw = "time.Second * 120",
                seconds = 120.0
              },
              major_cooldown = {
                type = "core.CooldownTypeMana",
                priority = "1"
              },
              class_spell_mask = "PriestSpellDispersion",
              spell_school = "SpellSchoolShadow",
              proc_mask = "2",
              class_token = "priest"
            },
            aura = {
              class = "priest",
              spell_id = 47585,
              label = "Dispersion",
              duration = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              class_token = "priest"
            }
          }
        },
        make_prayer_of_mending = {
          id = 16,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "priest",
              label = "Make Prayer Of Mending",
              label_raw = [["PrayerOfMending" + strconv.Itoa(int(priest.Index))]],
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "priest"
            }
          }
        },
        prayer_of_mending = {
          id = 17,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              spell_id = 48113,
              label = "Prayer Of Mending",
              cooldown = {
                raw = "time.Second*10 * (1 - .06*priest.Talents.DivineProvidence)"
              },
              flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskSpellHealing",
              damage_multiplier = "1 * (1 + .02*float64(priest.Talents.SpiritualHealing)) * (1 + .01*float64(priest.Talents.BlessedResilience)) * (1 + .02*float64(priest.Talents.FocusedPower)) * (1 + .02*float64(priest.Talents.DivineProvidence)) * (1 + .01*float64(priest.Talents.TwinDisciplines)) * core.TernaryFloat64(priest.CouldHaveSetBonus(ItemSetZabrasRaiment, 2), 1.2, 1)",
              crit_multiplier = "priest.DefaultCritMultiplier()",
              threat_multiplier = "1 - []float64{0, .07, .14, .20}[priest.Talents.SilentResolve]",
              class_token = "priest"
            }
          }
        },
        mind_melt = {
          id = 18,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "priest",
              spell_id = 87160,
              label = "Mind Melt Proc",
              duration = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              class_token = "priest"
            }
          }
        },
        masochism = {
          id = 19,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "priest",
              label = "Masochism",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "priest"
            }
          }
        },
        improved_devouring_plague = {
          id = 20,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "priest",
              label = "Improved Devouring Plague Talent",
              class_token = "priest"
            },
            spell = {
              class = "priest",
              spell_id = 2944,
              label = "Improved Devouring Plague",
              flags = "SpellFlagPassiveSpell",
              class_spell_mask = "PriestSpellImprovedDevouringPlague",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellProc | ProcMaskRangedProc | ProcMaskMeleeProc",
              damage_multiplier = "1",
              damage_multiplier_additive = "1",
              crit_multiplier = "priest.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "priest"
            }
          }
        },
        mind_trauma = {
          id = 21,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "priest",
              spell_id = 48301,
              label = "Mind Trauma",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "priest"
            }
          }
        },
        archangel = {
          id = 22,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "priest",
                spell_id = 87153,
                label = "Archangel",
                cooldown = {
                  raw = "time.Second * 90",
                  seconds = 90.0
                },
                flags = "SpellFlagAPL",
                class_spell_mask = "PriestSpellDarkArchangel",
                spell_school = "SpellSchoolHoly",
                proc_mask = "2",
                damage_multiplier = "1",
                damage_multiplier_additive = "1",
                crit_multiplier = "priest.DefaultCritMultiplier()",
                class_token = "priest"
              },
              {
                class = "priest",
                spell_id = 87151,
                label = "Archangel",
                cooldown = {
                  raw = "time.Second * 30",
                  seconds = 30.0
                },
                flags = "SpellFlagAPL",
                class_spell_mask = "2",
                spell_school = "SpellSchoolHoly",
                proc_mask = "2",
                damage_multiplier = "1",
                damage_multiplier_additive = "1",
                crit_multiplier = "priest.DefaultCritMultiplier()",
                class_token = "priest"
              }
            },
            aura = {
              {
                class = "priest",
                spell_id = 87153,
                label = "Dark Archangel Aura",
                duration = {
                  raw = "time.Second * 18",
                  seconds = 18.0
                },
                class_token = "priest"
              },
              {
                class = "priest",
                spell_id = 81700,
                label = "Archangel Aura",
                duration = {
                  raw = "time.Second * 18",
                  seconds = 18.0
                },
                class_token = "priest"
              }
            }
          }
        },
        evangelism = {
          id = 23,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "priest",
                spell_id = 81661,
                label = "EvangelismProc",
                duration = {
                  raw = "time.Second * 20",
                  seconds = 20.0
                },
                class_token = "priest"
              },
              {
                class = "priest",
                spell_id = 87118,
                label = "Dark EvangelismProc",
                duration = {
                  raw = "time.Second * 20",
                  seconds = 20.0
                },
                class_token = "priest"
              }
            }
          }
        },
        shadowfiend = {
          id = 24,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              spell_id = 34433,
              label = "Shadowfiend",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              flags = "core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
              class_spell_mask = "PriestSpellShadowFiend",
              spell_school = "SpellSchoolShadow",
              proc_mask = "2",
              class_token = "priest"
            },
            aura = {
              class = "priest",
              spell_id = 34433,
              label = "Shadowfiend",
              duration = {
                raw = "time.Second * 12.0",
                seconds = 12.0
              },
              class_token = "priest"
            }
          }
        },
        mindbender = {
          id = 25,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              spell_id = 123040,
              label = "Mindbender",
              cooldown = {
                raw = "time.Minute",
                seconds = 60.0
              },
              flags = "core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
              class_spell_mask = "PriestSpellMindBender",
              spell_school = "SpellSchoolShadow",
              proc_mask = "2",
              class_token = "priest"
            },
            aura = {
              class = "priest",
              spell_id = 123040,
              label = "Mindbender",
              duration = {
                raw = "time.Second * 15.0",
                seconds = 15.0
              },
              class_token = "priest"
            }
          }
        },
        shadow_word_pain = {
          id = 26,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              spell_id = 589,
              label = "ShadowWordPain",
              flags = "SpellFlagAPL",
              class_spell_mask = "PriestSpellShadowWordPain",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              damage_multiplier_additive = "1",
              crit_multiplier = "priest.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "priest"
            }
          }
        },
        make_penance = {
          id = 27,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "priest",
                spell_id = 53007,
                label = "Penance",
                cooldown = {
                  raw = "time.Second*12 * (1 - .1*priest.Talents.Aspiration)"
                },
                flags = "core.SpellFlagChanneled | core.SpellFlagAPL",
                spell_school = "SpellSchoolHoly",
                proc_mask = "core.ProcMaskSpellHealing",
                damage_multiplier = "1 + core.TernaryFloat64(isHeal, 1* (1+.02*float64(priest.Talents.SpiritualHealing))* (1+.01*float64(priest.Talents.BlessedResilience))* (1+.02*float64(priest.Talents.FocusedPower)), .05*float64(priest.Talents.SearingLight)) + .01*float64(priest.Talents.TwinDisciplines)",
                crit_multiplier = "core.TernaryFloat64(isHeal, priest.DefaultCritMultiplier(), priest.DefaultCritMultiplier())",
                threat_multiplier = "0",
                class_token = "priest"
              },
              {
                class = "priest",
                spell_id = 53007,
                label = "Penance",
                cooldown = {
                  raw = "time.Second*12 * (1 - .1*priest.Talents.Aspiration)"
                },
                flags = "core.SpellFlagChanneled | core.SpellFlagAPL",
                spell_school = "SpellSchoolHoly",
                proc_mask = "core.ProcMaskSpellHealing",
                damage_multiplier = "1 + core.TernaryFloat64(isHeal, 1* (1+.02*float64(priest.Talents.SpiritualHealing))* (1+.01*float64(priest.Talents.BlessedResilience))* (1+.02*float64(priest.Talents.FocusedPower)), .05*float64(priest.Talents.SearingLight)) + .01*float64(priest.Talents.TwinDisciplines)",
                crit_multiplier = "core.TernaryFloat64(isHeal, priest.DefaultCritMultiplier(), priest.DefaultCritMultiplier())",
                threat_multiplier = "0",
                class_token = "priest"
              }
            }
          }
        },
        prayer_of_healing = {
          id = 28,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              spell_id = 48072,
              label = "Prayer Of Healing",
              flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskSpellHealing",
              damage_multiplier = "1 * (1 + .02*float64(priest.Talents.SpiritualHealing)) * (1 + .01*float64(priest.Talents.BlessedResilience)) * (1 + .02*float64(priest.Talents.FocusedPower)) * (1 + .02*float64(priest.Talents.DivineProvidence))",
              crit_multiplier = "priest.DefaultCritMultiplier()",
              threat_multiplier = "1 - []float64{0, .07, .14, .20}[priest.Talents.SilentResolve]",
              class_token = "priest"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "binding_heal",
        "new_mind_sear",
        "get_mind_sear_tick",
        "power_word_shield",
        "smite",
        "initialize",
        "greater_heal",
        "holy_fire",
        "new_mind_bender",
        "new_shadowfiend",
        "flash_heal",
        "hymn_of_hope",
        "regaliaofthe_ternion_glory4_p",
        "renew",
        "dispersion",
        "make_prayer_of_mending",
        "prayer_of_mending",
        "mind_melt",
        "masochism",
        "improved_devouring_plague",
        "mind_trauma",
        "archangel",
        "evangelism",
        "shadowfiend",
        "mindbender",
        "shadow_word_pain",
        "make_penance",
        "prayer_of_healing"
      },
      synthetic = true
    },
    WarlockSpells = {
      fields = {
        life_tap = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 1454,
              label = "Life Tap",
              flags = "SpellFlagAPL",
              class_spell_mask = "WarlockSpellLifeTap",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              threat_multiplier = "1",
              class_token = "warlock"
            }
          }
        },
        torment = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 3716,
              label = "Torment",
              class_spell_mask = "WarlockSpellVoidwalkerTorment",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "2",
              threat_multiplier = "1",
              class_token = "warlock"
            }
          }
        },
        lash_of_pain = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 7814,
              label = "Lash Of Pain",
              class_spell_mask = "WarlockSpellSuccubusLashOfPain",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "2",
              threat_multiplier = "1",
              class_token = "warlock"
            }
          }
        },
        firebolt = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 3110,
              label = "Firebolt",
              class_spell_mask = "WarlockSpellImpFireBolt",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "2",
              threat_multiplier = "1",
              class_token = "warlock"
            }
          }
        },
        shadow_bite = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 54049,
              label = "Shadow Bite",
              class_spell_mask = "WarlockSpellFelHunterShadowBite",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "2",
              threat_multiplier = "1",
              class_token = "warlock"
            }
          }
        },
        initialize = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 20153,
              label = "Immolation",
              flags = "core.SpellFlagAoE",
              spell_school = "SpellSchoolFire",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "warlock"
            },
            aura = {
              class = "warlock",
              spell_id = 104938,
              label = "Fel Armor",
              class_token = "warlock"
            }
          }
        },
        summon_infernal = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warlock",
              spell_id = 1122,
              label = "Summon Infernal",
              duration = {
                raw = "time.Second * 60",
                seconds = 60.0
              },
              class_token = "warlock"
            }
          }
        },
        build_and_register_summon = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "warlock",
                spell_id = 111897,
                label = "Build And Register Summon (Spell 111897)",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                flags = "SpellFlagAPL",
                spell_school = "SpellSchoolShadow",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "warlock"
              },
              {
                class = "warlock",
                spell_id = 111896,
                label = "Build And Register Summon (Spell 111896)",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                flags = "SpellFlagAPL",
                spell_school = "SpellSchoolShadow",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "warlock"
              },
              {
                class = "warlock",
                spell_id = 111895,
                label = "Build And Register Summon (Spell 111895)",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                flags = "SpellFlagAPL",
                spell_school = "SpellSchoolShadow",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "warlock"
              },
              {
                class = "warlock",
                spell_id = 111859,
                label = "Build And Register Summon (Spell 111859)",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                flags = "SpellFlagAPL",
                spell_school = "SpellSchoolShadow",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "warlock"
              }
            }
          }
        },
        grimoire_of_sacrifice = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 108503,
              label = "Grimoire Of Sacrifice",
              cooldown = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolFire",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "warlock"
            },
            aura = {
              class = "warlock",
              spell_id = 108503,
              label = "Grimioire of Sacrifice",
              duration_raw = "time.Hour",
              class_token = "warlock"
            }
          }
        },
        mannaroths_fury = {
          id = 10,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 108508,
              label = "Mannaroths Fury",
              cooldown = {
                raw = "time.Minute",
                seconds = 60.0
              },
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolShadow",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "warlock"
            },
            aura = {
              class = "warlock",
              spell_id = 108508,
              label = "Mannaroth's Fury",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "warlock"
            }
          }
        },
        doom_bolt = {
          id = 11,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 85692,
              label = "Doom Bolt",
              class_spell_mask = "WarlockSpellDoomguardDoomBolt",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier_additive = "1",
              crit_multiplier = "2",
              threat_multiplier = "1",
              class_token = "warlock"
            }
          }
        },
        summon_doomguard = {
          id = 12,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warlock",
              spell_id = 18540,
              label = "Summon Doomguard",
              duration = {
                raw = "62 * time.Second",
                seconds = 62.0
              },
              class_token = "warlock"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "life_tap",
        "torment",
        "lash_of_pain",
        "firebolt",
        "shadow_bite",
        "initialize",
        "summon_infernal",
        "build_and_register_summon",
        "grimoire_of_sacrifice",
        "mannaroths_fury",
        "doom_bolt",
        "summon_doomguard"
      },
      synthetic = true
    },
    PaladinSpells = {
      fields = {
        seal_of_insight = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "paladin",
                spell_id = 20165,
                label = "Seal Of Insight",
                flags = "SpellFlagAPL",
                spell_school = "SpellSchoolHoly",
                proc_mask = "2",
                threat_multiplier = "0",
                class_token = "paladin"
              },
              {
                class = "paladin",
                spell_id = 20167,
                label = "Seal Of Insight",
                flags = "core.SpellFlagHelpful | core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
                class_spell_mask = "SpellMaskSealOfInsight",
                spell_school = "SpellSchoolHoly",
                proc_mask = "2",
                damage_multiplier = "1",
                crit_multiplier = "0",
                threat_multiplier = "1",
                class_token = "paladin"
              }
            },
            aura = {
              class = "paladin",
              spell_id = 20165,
              label = "Seal of Insight",
              tag = "Seal",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "paladin"
            }
          }
        },
        hammer_of_wrath = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "paladin",
              spell_id = 24275,
              label = "Hammer Of Wrath",
              cooldown = {
                raw = "6 * time.Second",
                seconds = 6.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              class_spell_mask = "SpellMaskHammerOfWrath",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskRangedSpecial",
              damage_multiplier = "1",
              crit_multiplier = "paladin.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "30",
              class_token = "paladin"
            }
          }
        },
        flash_of_light = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "paladin",
              spell_id = 19750,
              label = "Flash Of Light",
              flags = "core.SpellFlagAPL | core.SpellFlagHelpful",
              class_spell_mask = "SpellMaskFlashOfLight",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskSpellHealing",
              damage_multiplier = "1",
              crit_multiplier = "paladin.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "40",
              class_token = "paladin"
            }
          }
        },
        devotion = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "paladin",
              spell_id = 31821,
              label = "Devotion",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              flags = "core.SpellFlagAPL | core.SpellFlagHelpful | core.SpellFlagReadinessTrinket",
              class_spell_mask = "SpellMaskDevotionAura",
              class_token = "paladin"
            }
          }
        },
        divine_protection = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "paladin",
              spell_id = 498,
              label = "Divine Protection",
              cooldown = {
                raw = "time.Minute * 1",
                seconds = 60.0
              },
              flags = "core.SpellFlagAPL | core.SpellFlagHelpful | core.SpellFlagReadinessTrinket",
              class_spell_mask = "SpellMaskDivineProtection",
              related_self_buff = "paladin.DivineProtectionAura",
              class_token = "paladin"
            },
            aura = {
              class = "paladin",
              spell_id = 498,
              label = "Divine Protection",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "paladin"
            }
          }
        },
        word_of_glory = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "paladin",
              label = "Word Of Glory",
              cooldown = {
                raw = "time.Millisecond * 1500",
                seconds = 1.5
              },
              flags = "core.SpellFlagAPL | core.SpellFlagHelpful",
              class_spell_mask = "SpellMaskWordOfGlory",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskSpellHealing",
              damage_multiplier = "1",
              crit_multiplier = "paladin.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "40",
              class_token = "paladin"
            }
          }
        },
        lay_on_hands = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "paladin",
              spell_id = 633,
              label = "Lay On Hands",
              cooldown = {
                raw = "time.Minute * 10",
                seconds = 600.0
              },
              flags = "core.SpellFlagAPL | core.SpellFlagHelpful | core.SpellFlagIgnoreModifiers",
              class_spell_mask = "SpellMaskLayOnHands",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskSpellHealing",
              damage_multiplier = "1",
              crit_multiplier = "0",
              threat_multiplier = "1",
              max_range = "40",
              class_token = "paladin"
            }
          }
        },
        seal_of_truth = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "paladin",
                spell_id = 31801,
                label = "Seal Of Truth",
                flags = "core.SpellFlagAPL | core.SpellFlagHelpful",
                spell_school = "SpellSchoolHoly",
                proc_mask = "2",
                threat_multiplier = "0",
                class_token = "paladin"
              },
              {
                class = "paladin",
                spell_id = 42463,
                label = "Seal Of Truth",
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagPassiveSpell",
                class_spell_mask = "SpellMaskSealOfTruth",
                spell_school = "SpellSchoolHoly",
                proc_mask = "2",
                damage_multiplier = "0.12",
                crit_multiplier = "paladin.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "paladin"
              },
              {
                class = "paladin",
                spell_id = 31803,
                label = "Censure (DoT)",
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagPassiveSpell",
                class_spell_mask = "SpellMaskCensure",
                spell_school = "SpellSchoolHoly",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "paladin.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "paladin"
              },
              {
                class = "paladin",
                spell_id = 31803,
                label = "Seal Of Truth",
                flags = "core.SpellFlagNoMetrics | core.SpellFlagNoLogs | core.SpellFlagPassiveSpell",
                spell_school = "SpellSchoolHoly",
                proc_mask = "ProcMaskSpellProc | ProcMaskRangedProc | ProcMaskMeleeProc",
                class_token = "paladin"
              }
            },
            aura = {
              class = "paladin",
              spell_id = 31801,
              label = "Seal of Truth",
              tag = "Seal",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "paladin"
            }
          }
        },
        favorofthe_kings = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "paladin",
              spell_id = 144622,
              label = "Favor of the Kings",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "paladin"
            }
          }
        },
        bastionof_power = {
          id = 10,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "paladin",
              spell_id = 144569,
              label = "Bastion of Power",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "paladin"
            }
          }
        },
        blessingofthe_guardians = {
          id = 11,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "paladin",
              spell_id = 144581,
              label = "Blessing of the Guardians",
              flags = "core.SpellFlagPassiveSpell | core.SpellFlagHelpful",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskSpellHealing",
              damage_multiplier = "0.75 * core.TernaryFloat64(paladin.Talents.UnbreakableSpirit, 0.5, 1.0)",
              crit_multiplier = "paladin.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "paladin"
            }
          }
        },
        warriorofthe_light = {
          id = 12,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "paladin",
              spell_id = 144587,
              label = "Warrior of the Light",
              duration = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              class_token = "paladin"
            }
          }
        },
        shieldof_glory = {
          id = 13,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "paladin",
              spell_id = 138242,
              label = "Shield of Glory",
              duration = {
                raw = "time.Second * 5",
                seconds = 5.0
              },
              class_token = "paladin"
            }
          }
        },
        templars_verdict = {
          id = 14,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "paladin",
              spell_id = 138169,
              label = "Templar's Verdict",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "paladin"
            }
          }
        },
        exorcism = {
          id = 15,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "paladin",
              spell_id = 138162,
              label = "Exorcism",
              duration = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              class_token = "paladin"
            }
          }
        },
        holy_damage_templars_verdict = {
          id = 16,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "paladin",
              spell_id = 85256,
              label = "Holy Damage Templars Verdict",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete",
              class_spell_mask = "SpellMaskTemplarsVerdict",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "2.75",
              crit_multiplier = "paladin.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "paladin"
            }
          }
        },
        avenging_wrath = {
          id = 17,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "paladin",
              spell_id = 31884,
              label = "Avenging Wrath",
              cooldown = {
                raw = "3 * time.Minute",
                seconds = 180.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL | core.SpellFlagHelpful | core.SpellFlagReadinessTrinket",
              class_spell_mask = "1",
              related_self_buff = "paladin.AvengingWrathAura",
              class_token = "paladin"
            },
            aura = {
              class = "paladin",
              spell_id = 31884,
              label = "Avenging Wrath",
              duration = {
                cases = {
                  {
                    condition = "paladin.Talents.SanctifiedWrath",
                    raw = "core.DurationFromSeconds((30))"
                  },
                  {
                    condition = "!(paladin.Talents.SanctifiedWrath)",
                    raw = "core.DurationFromSeconds((20))"
                  }
                },
                raw = "core.DurationFromSeconds(core.TernaryFloat64(paladin.Talents.SanctifiedWrath, 30, 20))"
              },
              duration_raw = "core.DurationFromSeconds(core.TernaryFloat64(paladin.Talents.SanctifiedWrath, 30, 20))",
              class_token = "paladin"
            }
          }
        },
        forbearance = {
          id = 18,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "paladin",
              spell_id = 25771,
              label = "Forbearance",
              duration = {
                raw = "time.Second * 60",
                seconds = 60.0
              },
              class_token = "paladin"
            }
          }
        },
        sanctity_of_battle = {
          id = 19,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "paladin",
              spell_id = 25956,
              label = "Sanctity of Battle",
              class_token = "paladin"
            }
          }
        },
        judgment = {
          id = 20,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "paladin",
              spell_id = 20271,
              label = "Judgment",
              cooldown = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              flags = "core.SpellFlagAPL | core.SpellFlagMeleeMetrics",
              class_spell_mask = "SpellMaskJudgment",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              crit_multiplier = "paladin.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "30",
              class_token = "paladin"
            }
          }
        },
        retribution_guardian = {
          id = 21,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "paladin",
                spell_id = 86698,
                label = "Guardian of Ancient Kings",
                duration = {
                  raw = "duration"
                },
                class_token = "paladin"
              },
              {
                class = "paladin",
                spell_id = 86700,
                label = "Ancient Power",
                duration = {
                  raw = "duration + time.Second*1"
                },
                class_token = "paladin"
              }
            },
            spell = {
              {
                class = "paladin",
                spell_id = 86698,
                label = "Retribution Guardian",
                cooldown = {
                  raw = "time.Minute * 3",
                  seconds = 180.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "SpellFlagAPL",
                class_spell_mask = "SpellMaskGuardianOfAncientKings",
                proc_mask = "2",
                related_self_buff = "paladin.RetributionGuardianAura",
                class_token = "paladin"
              },
              {
                class = "paladin",
                spell_id = 86704,
                label = "Retribution Guardian",
                flags = "core.SpellFlagPassiveSpell | core.SpellFlagReadinessTrinket",
                spell_school = "SpellSchoolHoly",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "paladin.DefaultCritMultiplier()",
                threat_multiplier = "1",
                max_range = "10",
                class_token = "paladin"
              }
            }
          }
        },
        protection_guardian = {
          id = 22,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "paladin",
              spell_id = 86659,
              label = "Guardian of Ancient Kings",
              duration = {
                raw = "duration"
              },
              class_token = "paladin"
            },
            spell = {
              class = "paladin",
              spell_id = 86659,
              label = "Protection Guardian",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              major_cooldown = {
                type = "core.CooldownTypeSurvival",
                priority = "core.CooldownPriorityLow + 20"
              },
              flags = "core.SpellFlagAPL | core.SpellFlagHelpful | core.SpellFlagReadinessTrinket",
              class_spell_mask = "SpellMaskGuardianOfAncientKings",
              related_self_buff = "paladin.ProtectionGuardianAura",
              class_token = "paladin"
            }
          }
        },
        holy_guardian = {
          id = 23,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "paladin",
              spell_id = 86669,
              label = "Guardian of Ancient Kings",
              duration = {
                raw = "duration"
              },
              class_token = "paladin"
            },
            spell = {
              class = "paladin",
              spell_id = 86669,
              label = "Holy Guardian",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              major_cooldown = {
                type = "core.CooldownTypeSurvival"
              },
              flags = "core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
              class_spell_mask = "SpellMaskGuardianOfAncientKings",
              related_self_buff = "paladin.HolyGuardianAura",
              class_token = "paladin"
            }
          }
        },
        hammer_of_the_righteous = {
          id = 24,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "paladin",
                spell_id = 53595,
                label = "Hammer Of The Righteous",
                cooldown = {
                  raw = "time.Millisecond * 4500",
                  seconds = 4.5
                },
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
                class_spell_mask = "SpellMaskHammerOfTheRighteousMelee",
                spell_school = "2",
                proc_mask = "ProcMaskMeleeMHSpecial",
                damage_multiplier = "0.2",
                crit_multiplier = "paladin.DefaultCritMultiplier()",
                threat_multiplier = "1",
                max_range = "5",
                class_token = "paladin"
              },
              {
                class = "paladin",
                spell_id = 88263,
                label = "Hammer Of The Righteous",
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagPassiveSpell | core.SpellFlagAoE",
                class_spell_mask = "SpellMaskHammerOfTheRighteousAoe",
                spell_school = "SpellSchoolHoly",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "0.35",
                crit_multiplier = "paladin.DefaultCritMultiplier()",
                threat_multiplier = "1",
                max_range = "8",
                class_token = "paladin"
              }
            }
          }
        },
        seal_of_righteousness = {
          id = 25,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "paladin",
                spell_id = 20154,
                label = "Seal Of Righteousness",
                flags = "core.SpellFlagAPL | core.SpellFlagHelpful",
                spell_school = "SpellSchoolHoly",
                proc_mask = "2",
                threat_multiplier = "0",
                class_token = "paladin"
              },
              {
                class = "paladin",
                spell_id = 101423,
                label = "Seal Of Righteousness",
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagPassiveSpell | core.SpellFlagAoE",
                class_spell_mask = "SpellMaskSealOfRighteousness",
                spell_school = "SpellSchoolHoly",
                proc_mask = "ProcMaskMeleeProc",
                damage_multiplier = "0.09",
                crit_multiplier = "paladin.DefaultCritMultiplier()",
                threat_multiplier = "1",
                max_range = "8",
                class_token = "paladin"
              }
            },
            aura = {
              class = "paladin",
              spell_id = 20154,
              label = "Seal of Righteousness",
              tag = "Seal",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "paladin"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "seal_of_insight",
        "hammer_of_wrath",
        "flash_of_light",
        "devotion",
        "divine_protection",
        "word_of_glory",
        "lay_on_hands",
        "seal_of_truth",
        "favorofthe_kings",
        "bastionof_power",
        "blessingofthe_guardians",
        "warriorofthe_light",
        "shieldof_glory",
        "templars_verdict",
        "exorcism",
        "holy_damage_templars_verdict",
        "avenging_wrath",
        "forbearance",
        "sanctity_of_battle",
        "judgment",
        "retribution_guardian",
        "protection_guardian",
        "holy_guardian",
        "hammer_of_the_righteous",
        "seal_of_righteousness"
      },
      synthetic = true
    },
    MageSpells = {
      fields = {
        cone_of_cold = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 120,
              label = "Cone Of Cold",
              cooldown = {
                raw = "10 * time.Second",
                seconds = 10.0
              },
              flags = "core.SpellFlagAPL | core.SpellFlagAoE",
              class_spell_mask = "MageSpellConeOfCold",
              spell_school = "SpellSchoolFrost",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "mage.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "mage"
            }
          }
        },
        living_bomb = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "mage",
                spell_id = 44457,
                label = "LivingBomb",
                class_spell_mask = "MageSpellLivingBombDot",
                spell_school = "SpellSchoolFire",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "mage.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "mage"
              },
              {
                class = "mage",
                spell_id = 44457,
                label = "Living Bomb",
                flags = "SpellFlagAPL",
                class_spell_mask = "MageSpellLivingBombApply",
                spell_school = "SpellSchoolFire",
                proc_mask = "ProcMaskSpellDamage",
                crit_multiplier = "mage.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "mage"
              },
              {
                class = "mage",
                spell_id = 44457,
                label = "Living Bomb",
                flags = "core.SpellFlagAoE | core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
                class_spell_mask = "MageSpellLivingBombExplosion",
                spell_school = "SpellSchoolFire",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "mage.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "mage"
              }
            }
          }
        },
        arcane_blast = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "mage",
              spell_id = 36032,
              label = "Mirror Images: Arcane Charges Aura",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "mage"
            },
            spell = {
              class = "mage",
              spell_id = 88084,
              label = "Arcane Blast",
              class_spell_mask = "MageMirrorImageSpellArcaneBlast",
              spell_school = "SpellSchoolArcane",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "mi.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "mage"
            }
          }
        },
        fireball = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 88082,
              label = "Fireball",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "mi.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "mage"
            }
          }
        },
        frostbolt = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 59638,
              label = "Frostbolt",
              spell_school = "SpellSchoolFrost",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "mi.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "mage"
            }
          }
        },
        mirror_image = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 55342,
              label = "Mirror Image",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              flags = "SpellFlagAPL",
              class_spell_mask = "MageSpellMirrorImage",
              class_token = "mage"
            }
          }
        },
        frost_nova = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 122,
              label = "Frost Nova",
              cooldown = {
                raw = "25 * time.Second",
                seconds = 25.0
              },
              flags = "core.SpellFlagAPL | core.SpellFlagAoE",
              class_spell_mask = "MageSpellFrostNova",
              spell_school = "SpellSchoolFrost",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "mage.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "mage"
            }
          }
        },
        arcane_explosion = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 1449,
              label = "Arcane Explosion",
              flags = "core.SpellFlagAoE | core.SpellFlagAPL",
              class_spell_mask = "MageSpellArcaneExplosion",
              spell_school = "SpellSchoolArcane",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "mage.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "mage"
            }
          }
        },
        frostfire_bolt = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              label = "Frostfire Bolt",
              flags = "core.SpellFlagAPL",
              class_spell_mask = "MageSpellFrostfireBolt",
              spell_school = "SpellSchoolFire | SpellSchoolFrost",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "mage.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "mage"
            }
          }
        },
        evocation = {
          id = 10,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 12051,
              label = "Evocation",
              cooldown = {
                raw = "time.Minute * 2",
                seconds = 120.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              flags = "core.SpellFlagHelpful | core.SpellFlagChanneled | core.SpellFlagAPL",
              class_spell_mask = "MageSpellEvocation",
              class_token = "mage"
            }
          }
        },
        flamestrike = {
          id = 11,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "mage",
                spell_id = 2120,
                label = "FlameStrike DOT",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
                class_spell_mask = "MageSpellFlamestrikeDot",
                spell_school = "SpellSchoolFire",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "mage.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "mage"
              },
              {
                class = "mage",
                spell_id = 2120,
                label = "Flamestrike",
                cooldown = {
                  raw = "time.Second * 12",
                  seconds = 12.0
                },
                flags = "core.SpellFlagAoE | core.SpellFlagAPL",
                class_spell_mask = "MageSpellFlamestrike",
                spell_school = "SpellSchoolFire",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "mage.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "mage"
              }
            }
          }
        },
        armor_spells = {
          id = 12,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "mage",
                spell_id = 7302,
                label = "Armor Spells",
                flags = "core.SpellFlagAPL | core.SpellFlagHelpful",
                class_spell_mask = "MageSpellFrostArmor",
                spell_school = "SpellSchoolFrost",
                class_token = "mage"
              },
              {
                class = "mage",
                spell_id = 6117,
                label = "Armor Spells",
                flags = "core.SpellFlagAPL | core.SpellFlagHelpful",
                class_spell_mask = "MageSpellMageArmor",
                spell_school = "SpellSchoolArcane",
                class_token = "mage"
              },
              {
                class = "mage",
                spell_id = 30482,
                label = "Armor Spells",
                flags = "core.SpellFlagAPL | core.SpellFlagHelpful",
                class_spell_mask = "MageSpellMoltenArmor",
                spell_school = "SpellSchoolFire",
                class_token = "mage"
              }
            },
            aura = {
              {
                class = "mage",
                spell_id = 7302,
                label = "Frost Armor",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "mage"
              },
              {
                class = "mage",
                spell_id = 6117,
                label = "Mage Armor",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "mage"
              },
              {
                class = "mage",
                spell_id = 30482,
                label = "Molten Armor",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "mage"
              }
            }
          }
        },
        mana_gems = {
          id = 13,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              label = "Mana Gems",
              cooldown = {
                raw = "time.Minute * 2",
                seconds = 120.0
              },
              major_cooldown = {
                type = "core.CooldownTypeMana",
                priority = "core.CooldownPriorityDefault"
              },
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL | core.SpellFlagHelpful",
              class_token = "mage"
            }
          }
        },
        frost_mastery = {
          id = 14,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "mage",
              spell_id = 148022,
              label = "Mastery: Icicles",
              duration = {
                raw = "time.Hour * 1",
                seconds = 3600.0
              },
              class_token = "mage"
            },
            spell = {
              class = "mage",
              spell_id = 148022,
              label = "Frost Mastery",
              flags = "core.SpellFlagPassiveSpell | core.SpellFlagNoOnCastComplete | core.SpellFlagNoSpellMods | core.SpellFlagIgnoreModifiers",
              class_spell_mask = "MageSpellIcicle",
              spell_school = "SpellSchoolFrost",
              proc_mask = "ProcMaskSpellDamageProc",
              damage_multiplier = "1",
              class_token = "mage"
            }
          }
        },
        deep_freeze = {
          id = 15,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 44572,
              label = "Deep Freeze",
              cooldown = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              flags = "SpellFlagAPL",
              class_spell_mask = "MageSpellDeepFreeze",
              spell_school = "SpellSchoolFrost",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "mage.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "mage"
            }
          }
        },
        alter_time = {
          id = 16,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "mage",
                spell_id = 108978,
                label = "Alter Time",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
                class_token = "mage"
              },
              {
                class = "mage",
                spell_id = 108978,
                label = "Alter Time",
                cooldown = {
                  raw = "time.Minute * 3",
                  seconds = 180.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "SpellFlagNoOnCastComplete",
                class_spell_mask = "8",
                related_self_buff = "mage.AlterTimeCDAura",
                class_token = "mage"
              }
            },
            aura = {
              class = "mage",
              spell_id = 108978,
              label = "Alter Time",
              duration = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              class_token = "mage"
            }
          }
        },
        fiery_adept = {
          id = 17,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "mage",
              spell_id = 145261,
              label = "Fiery Adept",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "mage"
            }
          }
        },
        frigid_blast = {
          id = 18,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 145264,
              label = "Frigid Blast",
              flags = "SpellFlagPassiveSpell",
              spell_school = "SpellSchoolFrost",
              proc_mask = "ProcMaskSpellProc",
              damage_multiplier = "1",
              crit_multiplier = "mage.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "mage"
            }
          }
        },
        frozen_thoughts = {
          id = 19,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "mage",
              spell_id = 146557,
              label = "Frozen Thoughts",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "mage"
            }
          }
        },
        profound_magic = {
          id = 20,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "mage",
              spell_id = 145252,
              label = "Profound Magic",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "mage"
            }
          }
        },
        fire_blast = {
          id = 21,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 2136,
              label = "Fire Blast",
              cooldown = {
                raw = "time.Second * 8",
                seconds = 8.0
              },
              flags = "core.SpellFlagAPL | core.SpellFlagAoE",
              class_spell_mask = "MageSpellFireBlast",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "mage.DefaultCritMultiplier()",
              class_token = "mage"
            }
          }
        },
        nether_tempest = {
          id = 22,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "mage",
                spell_id = 114923,
                label = "Nether Tempest",
                class_spell_mask = "MageSpellNetherTempestDot",
                spell_school = "SpellSchoolArcane",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "mage.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "mage"
              },
              {
                class = "mage",
                spell_id = 114923,
                label = "Nether Tempest",
                flags = "SpellFlagAPL",
                class_spell_mask = "MageSpellNetherTempest",
                spell_school = "SpellSchoolArcane",
                proc_mask = "ProcMaskSpellDamage",
                crit_multiplier = "mage.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "mage"
              },
              {
                class = "mage",
                spell_id = 114923,
                label = "Nether Tempest",
                class_spell_mask = "MageSpellNetherTempestDot",
                spell_school = "SpellSchoolArcane",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "mage.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "mage"
              }
            }
          }
        },
        ice_lance = {
          id = 23,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 30455,
              label = "Ice Lance",
              flags = "SpellFlagAPL",
              damage_multiplier = "1",
              class_token = "mage"
            }
          }
        },
        blizzard = {
          id = 24,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "mage",
                spell_id = 10,
                label = "Blizzard",
                flags = "core.SpellFlagChanneled | core.SpellFlagAPL",
                class_spell_mask = "MageSpellBlizzard",
                spell_school = "SpellSchoolFrost",
                proc_mask = "ProcMaskSpellDamage",
                class_token = "mage"
              },
              {
                class = "mage",
                spell_id = 42208,
                label = "Blizzard",
                flags = "core.SpellFlagAoE",
                class_spell_mask = "MageSpellBlizzard",
                spell_school = "SpellSchoolFrost",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "mage.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "mage"
              }
            }
          }
        },
        heating_up = {
          id = 25,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "mage",
                spell_id = 48108,
                label = "Pyroblast!",
                duration = {
                  raw = "time.Second * 15",
                  seconds = 15.0
                },
                class_token = "mage"
              },
              {
                class = "mage",
                spell_id = 48107,
                label = "Heating Up",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "mage"
              }
            }
          }
        },
        frost_bomb = {
          id = 26,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "mage",
                spell_id = 112948,
                label = "FrostBomb",
                cooldown = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                flags = "SpellFlagAPL",
                class_spell_mask = "MageSpellFrostBomb",
                spell_school = "SpellSchoolFrost",
                proc_mask = "2",
                class_token = "mage"
              },
              {
                class = "mage",
                spell_id = 112948,
                label = "Frost Bomb",
                flags = "core.SpellFlagAoE",
                class_spell_mask = "MageSpellFrostBombExplosion",
                spell_school = "SpellSchoolFrost",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "mage.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "mage"
              }
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "cone_of_cold",
        "living_bomb",
        "arcane_blast",
        "fireball",
        "frostbolt",
        "mirror_image",
        "frost_nova",
        "arcane_explosion",
        "frostfire_bolt",
        "evocation",
        "flamestrike",
        "armor_spells",
        "mana_gems",
        "frost_mastery",
        "deep_freeze",
        "alter_time",
        "fiery_adept",
        "frigid_blast",
        "frozen_thoughts",
        "profound_magic",
        "fire_blast",
        "nether_tempest",
        "ice_lance",
        "blizzard",
        "heating_up",
        "frost_bomb"
      },
      synthetic = true
    },
    WarriorSpells = {
      fields = {
        victory_rush = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 34428,
              label = "Victory Rush",
              flags = "core.SpellFlagAPL | core.SpellFlagMeleeMetrics",
              class_spell_mask = "SpellMaskImpendingVictory",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              crit_multiplier = "war.DefaultCritMultiplier()",
              class_token = "warrior"
            }
          }
        },
        pummel = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 6552,
              label = "Pummel",
              cooldown = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              class_spell_mask = "SpellMaskPummel",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              crit_multiplier = "war.DefaultCritMultiplier()",
              max_range = "5",
              class_token = "warrior"
            }
          }
        },
        shield_wall = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 871,
              label = "Shield Wall",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              major_cooldown = {
                type = "core.CooldownTypeSurvival"
              },
              flags = "core.SpellFlagReadinessTrinket",
              class_spell_mask = "SpellMaskShieldWall",
              related_self_buff = "war.ShieldWallAura",
              class_token = "warrior"
            },
            aura = {
              class = "warrior",
              spell_id = 871,
              label = "Shield Wall",
              duration = {
                raw = "time.Second * 12",
                seconds = 12.0
              },
              class_token = "warrior"
            }
          }
        },
        recklessness = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 1719,
              label = "Recklessness",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              flags = "core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
              class_spell_mask = "SpellMaskRecklessness",
              related_self_buff = "war.RecklessnessAura",
              class_token = "warrior"
            },
            aura = {
              class = "warrior",
              spell_id = 1719,
              label = "Recklessness",
              duration = {
                raw = "time.Second * 12",
                seconds = 12.0
              },
              class_token = "warrior"
            }
          }
        },
        hamstring = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 1715,
              label = "Hamstring",
              cooldown = {
                raw = "time.Second * 1",
                seconds = 1.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              class_spell_mask = "SpellMaskHamstring",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              threat_multiplier = "1",
              max_range = "5",
              class_token = "warrior"
            }
          }
        },
        execute = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 5308,
              label = "Execute",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              class_spell_mask = "SpellMaskExecute",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1.0",
              crit_multiplier = "war.DefaultCritMultiplier()",
              max_range = "5",
              class_token = "warrior"
            }
          }
        },
        charge = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              label = "Charge",
              cooldown = {
                raw = "20 * time.Second",
                seconds = 20.0
              },
              flags = "SpellFlagAPL",
              class_spell_mask = "SpellMaskCharge",
              spell_school = "2",
              max_range = "25.0",
              class_token = "warrior"
            },
            aura = {
              class = "warrior",
              label = "Charge",
              duration = {
                raw = "5 * time.Second",
                seconds = 5.0
              },
              class_token = "warrior"
            }
          }
        },
        cleave = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 845,
              label = "Cleave",
              cooldown = {
                raw = "time.Millisecond * 1500",
                seconds = 1.5
              },
              flags = "core.SpellFlagAPL | core.SpellFlagMeleeMetrics",
              class_spell_mask = "SpellMaskCleave",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "0.82",
              crit_multiplier = "war.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "5",
              class_token = "warrior"
            }
          }
        },
        heroic_strike = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 78,
              label = "Heroic Strike",
              cooldown = {
                raw = "time.Millisecond * 1500",
                seconds = 1.5
              },
              flags = "core.SpellFlagAPL | core.SpellFlagMeleeMetrics",
              class_spell_mask = "SpellMaskHeroicStrike",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1.1",
              crit_multiplier = "war.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "5",
              class_token = "warrior"
            }
          }
        },
        make_shout_spell_helper = {
          id = 10,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "warrior",
                spell_id = 469,
                label = "Make Shout Spell Helper",
                cooldown = {
                  raw = "time.Minute * 1",
                  seconds = 60.0
                },
                flags = "core.SpellFlagAPL | core.SpellFlagHelpful",
                class_spell_mask = "SpellMaskCommandingShout",
                class_token = "warrior"
              },
              {
                class = "warrior",
                spell_id = 6673,
                label = "Make Shout Spell Helper",
                cooldown = {
                  raw = "time.Minute * 1",
                  seconds = 60.0
                },
                flags = "core.SpellFlagAPL | core.SpellFlagHelpful",
                class_spell_mask = "SpellMaskBattleShout",
                class_token = "warrior"
              }
            }
          }
        },
        rallying_cry = {
          id = 11,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 97462,
              label = "Rallying Cry",
              cooldown = {
                raw = "me.Minute * 3",
                seconds = 180.0
              },
              major_cooldown = {
                type = "core.CooldownTypeSurvival",
                priority = "core.CooldownPriorityLow"
              },
              flags = "SpellFlagAPL",
              class_spell_mask = "SpellMaskRallyingCry",
              class_token = "warrior"
            }
          }
        },
        berserker_rage = {
          id = 12,
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
              flags = "SpellFlagAPL",
              class_spell_mask = "SpellMaskBerserkerRage",
              class_token = "warrior"
            },
            aura = {
              class = "warrior",
              spell_id = 18499,
              label = "Berserker Rage",
              duration = {
                cases = {
                  {
                    raw = "time.Second * 6",
                    seconds = 6.0
                  },
                  {
                    condition = "war.Spec == proto.Spec_SpecFuryWarrior",
                    raw = "time.Second * 8",
                    seconds = 8.0
                  }
                },
                raw = "time.Second * 6"
              },
              duration_raw = "duration",
              class_token = "warrior"
            }
          }
        },
        whirlwind = {
          id = 13,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "warrior",
                spell_id = 1680,
                label = "Whirlwind",
                flags = "core.SpellFlagAoE | core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
                class_spell_mask = "SpellMaskWhirlwind",
                spell_school = "2",
                proc_mask = "ProcMaskMeleeMHSpecial",
                damage_multiplier = "0.85",
                crit_multiplier = "war.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "warrior"
              },
              {
                class = "warrior",
                spell_id = 1680,
                label = "Whirlwind",
                flags = "core.SpellFlagAoE | core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete",
                class_spell_mask = "SpellMaskWhirlwindOh",
                spell_school = "2",
                proc_mask = "ProcMaskMeleeOHSpecial",
                damage_multiplier = "0.85",
                crit_multiplier = "war.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "warrior"
              }
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "victory_rush",
        "pummel",
        "shield_wall",
        "recklessness",
        "hamstring",
        "execute",
        "charge",
        "cleave",
        "heroic_strike",
        "make_shout_spell_helper",
        "rallying_cry",
        "berserker_rage",
        "whirlwind"
      },
      synthetic = true
    },
    DruidFeralbearSpells = {
      fields = {
        bone_shield = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spec = "feralbear",
              spell_id = 122285,
              label = "Bone Shield",
              cooldown = {
                raw = "time.Minute",
                seconds = 60.0
              },
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolShadow",
              proc_mask = "2",
              related_self_buff = "bear.BoneShieldSpellAura",
              class_token = "druid",
              spec_token = "feralbear"
            },
            aura = {
              class = "druid",
              spec = "feralbear",
              spell_id = 122285,
              label = "Bone Shield",
              duration = {
                raw = "time.Minute * 5",
                seconds = 300.0
              },
              class_token = "druid",
              spec_token = "feralbear"
            }
          }
        },
        elusive_brew = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spec = "feralbear",
              spell_id = 126453,
              label = "Elusive Brew",
              cooldown = {
                raw = "time.Minute",
                seconds = 60.0
              },
              flags = "SpellFlagAPL",
              spell_school = "2",
              proc_mask = "2",
              related_self_buff = "bear.ElusiveBrewSpellAura",
              class_token = "druid",
              spec_token = "feralbear"
            },
            aura = {
              class = "druid",
              spec = "feralbear",
              spell_id = 126453,
              label = "Elusive Brew",
              duration = {
                raw = "time.Second * 8",
                seconds = 8.0
              },
              class_token = "druid",
              spec_token = "feralbear"
            }
          }
        },
        improved_regeneration = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "druid",
              spec = "feralbear",
              spell_id = 138217,
              label = "Improved Regeneration 2PT15",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "druid",
              spec_token = "feralbear"
            }
          }
        },
        savage_defense = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spec = "feralbear",
              spell_id = 62606,
              label = "Savage Defense",
              cooldown = {
                raw = "time.Millisecond * 1500",
                seconds = 1.5
              },
              flags = "SpellFlagAPL",
              class_spell_mask = "DruidSpellSavageDefense",
              spell_school = "SpellSchoolNature",
              proc_mask = "2",
              related_self_buff = "bear.SavageDefenseSpellAura",
              class_token = "druid",
              spec_token = "feralbear"
            },
            aura = {
              class = "druid",
              spec = "feralbear",
              spell_id = 132402,
              label = "Savage Defense",
              duration = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              class_token = "druid",
              spec_token = "feralbear"
            }
          }
        },
        tooth_and_claw_passive = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "druid",
                spec = "feralbear",
                spell_id = 135286,
                label = "Tooth and Claw",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "druid",
                spec_token = "feralbear"
              },
              {
                class = "druid",
                spec = "feralbear",
                spell_id = 135597,
                label = "Tooth and Claw",
                duration = {
                  raw = "time.Second * 15",
                  seconds = 15.0
                },
                class_token = "druid",
                spec_token = "feralbear"
              }
            }
          }
        },
        dream_of_cenarius = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "druid",
              spec = "feralbear",
              spell_id = 145162,
              label = "Dream of Cenarius",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "druid",
              spec_token = "feralbear"
            }
          }
        },
        incarnation = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spec = "feralbear",
              spell_id = 102558,
              label = "Incarnation",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              flags = "SpellFlagAPL",
              class_token = "druid",
              spec_token = "feralbear"
            },
            aura = {
              class = "druid",
              spec = "feralbear",
              spell_id = 102558,
              label = "Incarnation: Son of Ursoc",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "druid",
              spec_token = "feralbear"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "bone_shield",
        "elusive_brew",
        "improved_regeneration",
        "savage_defense",
        "tooth_and_claw_passive",
        "dream_of_cenarius",
        "incarnation"
      },
      synthetic = true
    },
    DruidFeralcatSpells = {
      fields = {
        tigers_fury = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spec = "feralcat",
              spell_id = 5217,
              label = "Tigers Fury",
              cooldown = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              flags = "core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
              class_spell_mask = "DruidSpellTigersFury",
              class_token = "druid",
              spec_token = "feralcat"
            },
            aura = {
              class = "druid",
              spec = "feralcat",
              spell_id = 5217,
              label = "Tiger's Fury",
              duration = {
                raw = "6 * time.Second",
                seconds = 6.0
              },
              class_token = "druid",
              spec_token = "feralcat"
            }
          }
        },
        predatory_swiftness = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "druid",
                spec = "feralcat",
                label = "Predatory Swiftness Trigger",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "druid",
                spec_token = "feralcat"
              },
              {
                class = "druid",
                spec = "feralcat",
                spell_id = 69369,
                label = "Predatory Swiftness",
                duration = {
                  raw = "time.Second * 12",
                  seconds = 12.0
                },
                class_token = "druid",
                spec_token = "feralcat"
              }
            }
          }
        },
        savage_roar = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spec = "feralcat",
              spell_id = 52610,
              label = "Savage Roar",
              flags = "SpellFlagAPL",
              class_spell_mask = "DruidSpellSavageRoar",
              class_token = "druid",
              spec_token = "feralcat"
            }
          }
        },
        feral_rage = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "druid",
              spec = "feralcat",
              spell_id = 146874,
              label = "Feral Rage 4PT16",
              duration = {
                raw = "time.Second * 12",
                seconds = 12.0
              },
              class_token = "druid",
              spec_token = "feralcat"
            }
          }
        },
        feral_fury = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "druid",
              spec = "feralcat",
              spell_id = 144865,
              label = "Feral Fury 2PT16",
              duration = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              class_token = "druid",
              spec_token = "feralcat"
            }
          }
        },
        shred = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spec = "feralcat",
              spell_id = 5221,
              label = "Shred",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              class_spell_mask = "DruidSpellShred",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "5",
              crit_multiplier = "cat.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "5",
              class_token = "druid",
              spec_token = "feralcat"
            }
          }
        },
        initialize = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spec = "feralcat",
              spell_id = 150017,
              label = "Rake",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIgnoreArmor",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              crit_multiplier = "treant.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "5",
              class_token = "druid",
              spec_token = "feralcat"
            }
          }
        },
        dream_of_cenarius = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "druid",
              spec = "feralcat",
              spell_id = 145152,
              label = "Dream of Cenarius",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "druid",
              spec_token = "feralcat"
            }
          }
        },
        incarnation = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spec = "feralcat",
              spell_id = 102543,
              label = "Incarnation",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              flags = "SpellFlagAPL",
              related_self_buff = "cat.IncarnationAura",
              class_token = "druid",
              spec_token = "feralcat"
            },
            aura = {
              class = "druid",
              spec = "feralcat",
              spell_id = 102543,
              label = "Incarnation: King of the Jungle",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "druid",
              spec_token = "feralcat"
            }
          }
        },
        soul_of_the_forest = {
          id = 10,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "druid",
              spec = "feralcat",
              label = "Soul of the Forest Trigger",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "druid",
              spec_token = "feralcat"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "tigers_fury",
        "predatory_swiftness",
        "savage_roar",
        "feral_rage",
        "feral_fury",
        "shred",
        "initialize",
        "dream_of_cenarius",
        "incarnation",
        "soul_of_the_forest"
      },
      synthetic = true
    },
    DruidBalanceSpells = {
      fields = {
        sunfire_impact = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spec = "balance",
              spell_id = 93402,
              label = "Sunfire Impact",
              flags = "SpellFlagAPL",
              class_spell_mask = "DruidSpellSunfire",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "moonkin.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "druid",
              spec_token = "balance"
            }
          }
        },
        sunfire = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spec = "balance",
              spell_id = 93402,
              label = "Sunfire",
              flags = "SpellFlagPassiveSpell",
              class_spell_mask = "DruidSpellSunfireDoT",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "moonkin.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "druid",
              spec_token = "balance"
            }
          }
        },
        starsurge = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spec = "balance",
              spell_id = 78674,
              label = "Starsurge",
              cooldown = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              flags = "SpellFlagAPL",
              class_spell_mask = "DruidSpellStarsurge",
              spell_school = "core.SpellSchoolArcane | core.SpellSchoolNature",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              damage_multiplier_additive = "1",
              crit_multiplier = "moonkin.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "druid",
              spec_token = "balance"
            }
          }
        },
        starfall = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "druid",
                spec = "balance",
                spell_id = 48505,
                label = "Starfall",
                cooldown = {
                  raw = "time.Second * 90",
                  seconds = 90.0
                },
                flags = "SpellFlagAPL",
                spell_school = "SpellSchoolArcane",
                proc_mask = "2",
                related_self_buff = [[moonkin.GetOrRegisterAura(core.Aura{ Label: "Starfall", ActionID: core.ActionID{SpellID: 48505}, Duration: time.Second * 10, })]],
                class_token = "druid",
                spec_token = "balance"
              },
              {
                class = "druid",
                spec = "balance",
                spell_id = 50286,
                label = "Starfall",
                flags = "SpellFlagPassiveSpell",
                class_spell_mask = "DruidSpellStarfall",
                spell_school = "SpellSchoolArcane",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "moonkin.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "druid",
                spec_token = "balance"
              }
            },
            aura = {
              class = "druid",
              spec = "balance",
              spell_id = 48505,
              label = "Starfall",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "druid",
              spec_token = "balance"
            }
          }
        },
        astral_communion = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spec = "balance",
              spell_id = 127663,
              label = "Astral Communion",
              flags = "core.SpellFlagHelpful | core.SpellFlagChanneled | core.SpellFlagAPL",
              class_spell_mask = "DruidSpellAstralCommunion",
              spell_school = "SpellSchoolArcane",
              class_token = "druid",
              spec_token = "balance"
            }
          }
        },
        wild_mushrooms = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "druid",
                spec = "balance",
                spell_id = 88751,
                label = "Wild Mushrooms",
                cooldown = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                flags = "core.SpellFlagAPL | core.SpellFlagPassiveSpell",
                class_spell_mask = "DruidSpellWildMushroomDetonate",
                spell_school = "SpellSchoolNature",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "moonkin.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "druid",
                spec_token = "balance"
              },
              {
                class = "druid",
                spec = "balance",
                spell_id = 78777,
                label = "Wild Mushrooms",
                flags = "core.SpellFlagAoE | core.SpellFlagPassiveSpell",
                class_spell_mask = "DruidSpellWildMushroomDetonate",
                spell_school = "SpellSchoolNature",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "moonkin.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "druid",
                spec_token = "balance"
              },
              {
                class = "druid",
                spec = "balance",
                spell_id = 88747,
                label = "Wild Mushrooms",
                flags = "SpellFlagAPL",
                class_token = "druid",
                spec_token = "balance"
              }
            },
            aura = {
              class = "druid",
              spec = "balance",
              spell_id = 88747,
              label = "Wild Mushrooms (Tracker)",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "druid",
              spec_token = "balance"
            }
          }
        },
        astral_storm = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "druid",
                spec = "balance",
                spell_id = 106996,
                label = "Astral Storm (Aura)",
                flags = "core.SpellFlagChanneled | core.SpellFlagAPL",
                class_spell_mask = "DruidSpellAstralStorm",
                spell_school = "SpellSchoolArcane",
                proc_mask = "ProcMaskSpellDamage",
                class_token = "druid",
                spec_token = "balance"
              },
              {
                class = "druid",
                spec = "balance",
                spell_id = 106998,
                label = "Astral Storm",
                flags = "core.SpellFlagAoE",
                class_spell_mask = "DruidSpellAstralStorm",
                spell_school = "SpellSchoolArcane",
                proc_mask = "ProcMaskSpellProc",
                damage_multiplier = "1",
                crit_multiplier = "moonkin.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "druid",
                spec_token = "balance"
              }
            }
          }
        },
        eclipse_energy_gain = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "druid",
              spec = "balance",
              spell_id = 89265,
              label = "Eclipse Energy",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "druid",
              spec_token = "balance"
            }
          }
        },
        eclipse_auras = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "druid",
                spec = "balance",
                spell_id = 48517,
                label = "Eclipse (Solar)",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "druid",
                spec_token = "balance"
              },
              {
                class = "druid",
                spec = "balance",
                spell_id = 48518,
                label = "Eclipse (Lunar)",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "druid",
                spec_token = "balance"
              }
            }
          }
        },
        wrath = {
          id = 10,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spec = "balance",
              spell_id = 113769,
              label = "Wrath",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "treant.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "druid",
              spec_token = "balance"
            }
          }
        },
        starfire = {
          id = 11,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spec = "balance",
              spell_id = 2912,
              label = "Starfire",
              flags = "SpellFlagAPL",
              class_spell_mask = "DruidSpellStarfire",
              spell_school = "SpellSchoolArcane",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "moonkin.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "druid",
              spec_token = "balance"
            }
          }
        },
        lunar_shower = {
          id = 12,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "druid",
                spec = "balance",
                label = "Lunar Shower Handler",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "druid",
                spec_token = "balance"
              },
              {
                class = "druid",
                spec = "balance",
                spell_id = 81192,
                label = "Lunar Shower",
                duration = {
                  raw = "time.Second * 3",
                  seconds = 3.0
                },
                class_token = "druid",
                spec_token = "balance"
              }
            }
          }
        },
        owlkin_frenzy = {
          id = 13,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "druid",
              spec = "balance",
              spell_id = 48393,
              label = "Owlkin Frenzy",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "druid",
              spec_token = "balance"
            }
          }
        },
        shooting_stars = {
          id = 14,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "druid",
              spec = "balance",
              spell_id = 93400,
              label = "Shooting Stars",
              duration = {
                raw = "time.Second * 12",
                seconds = 12.0
              },
              class_token = "druid",
              spec_token = "balance"
            }
          }
        },
        celestial_alignment = {
          id = 15,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spec = "balance",
              spell_id = 112071,
              label = "Celestial Alignment",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolArcane",
              related_self_buff = "moonkin.CelestialAlignmentSpellAura",
              class_token = "druid",
              spec_token = "balance"
            },
            aura = {
              class = "druid",
              spec = "balance",
              spell_id = 112071,
              label = "Celestial Alignment",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "druid",
              spec_token = "balance"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "sunfire_impact",
        "sunfire",
        "starsurge",
        "starfall",
        "astral_communion",
        "wild_mushrooms",
        "astral_storm",
        "eclipse_energy_gain",
        "eclipse_auras",
        "wrath",
        "starfire",
        "lunar_shower",
        "owlkin_frenzy",
        "shooting_stars",
        "celestial_alignment"
      },
      synthetic = true
    },
    CommonSharedSpells = {
      fields = {
        new_proc_damage = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            proc = {
              class = "common",
              spec = "shared",
              label = "New Proc Damage",
              label_raw = "config.Name",
              duration_raw = "config.Duration",
              class_token = "common",
              spec_token = "shared"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "new_proc_damage"
      },
      synthetic = true
    },
    CommonTbcSpells = {
      fields = {
        init = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "common",
              spec = "tbc",
              spell_id = 46579,
              label = "Init",
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
              spell_school = "SpellSchoolFrost",
              proc_mask = "ProcMaskSpellProc",
              damage_multiplier = "1",
              crit_multiplier = "character.DefaultSpellCritMultiplier()",
              threat_multiplier = "1",
              class_token = "common",
              spec_token = "tbc"
            }
          }
        },
        deathfrost = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "tbc",
              spell_id = 46629,
              label = "Deathfrost",
              duration = {
                raw = "time.Second * 8",
                seconds = 8.0
              },
              class_token = "common",
              spec_token = "tbc"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "init",
        "deathfrost"
      },
      synthetic = true
    },
    ShamanElementalSpells = {
      fields = {
        thunderstorm = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spec = "elemental",
              spell_id = 51490,
              label = "Thunderstorm",
              cooldown = {
                raw = "time.Second * 45",
                seconds = 45.0
              },
              flags = "shaman.SpellFlagShamanSpell | core.SpellFlagAoE | core.SpellFlagAPL | shaman.SpellFlagFocusable",
              class_spell_mask = "SpellMaskThunderstorm",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "elemental.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "shaman",
              spec_token = "elemental"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "thunderstorm"
      },
      synthetic = true
    },
    ShamanEnhancementSpells = {
      fields = {
        new_stormstrike_hit = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "shaman",
                spec = "enhancement",
                spell_id = 17364,
                label = "New Stormstrike Hit",
                flags = "SpellFlagMeleeMetrics",
                class_spell_mask = "SpellMaskStormstrikeDamage",
                spell_school = "2",
                proc_mask = "procMask",
                damage_multiplier = "4.5",
                crit_multiplier = "enh.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "shaman",
                spec_token = "enhancement"
              },
              {
                class = "shaman",
                spec = "enhancement",
                spell_id = 17364,
                label = "New Stormstrike Hit",
                flags = "SpellFlagMeleeMetrics",
                class_spell_mask = "SpellMaskStormstrikeDamage",
                spell_school = "2",
                proc_mask = "procMask",
                damage_multiplier = "4.5",
                crit_multiplier = "enh.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "shaman",
                spec_token = "enhancement"
              }
            }
          }
        },
        stormstrike_debuff = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "shaman",
              spec = "enhancement",
              spell_id = 17364,
              label = "Stormstrike",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "shaman",
              spec_token = "enhancement"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "new_stormstrike_hit",
        "stormstrike_debuff"
      },
      synthetic = true
    },
    HunterSurvivalSpells = {
      fields = {
        black_arrow = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spec = "_survival",
              spell_id = 3674,
              label = "Black Arrow Dot",
              cooldown = {
                raw = "time.Second * 24",
                seconds = 24.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagReadinessTrinket | core.SpellFlagRanged",
              class_spell_mask = "HunterSpellBlackArrow",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskRangedSpecial",
              damage_multiplier = "1.3",
              crit_multiplier = "svHunter.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "40",
              class_token = "hunter",
              spec_token = "_survival"
            }
          }
        },
        lnl = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "hunter",
                spec = "_survival",
                label = "Lock and Load",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "hunter",
                spec_token = "_survival"
              },
              {
                class = "hunter",
                spec = "_survival",
                spell_id = 56343,
                label = "Lock and Load Proc",
                duration = {
                  raw = "time.Second * 12",
                  seconds = 12.0
                },
                class_token = "hunter",
                spec_token = "_survival"
              }
            }
          }
        },
        explosive_shot = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spec = "_survival",
              spell_id = 53301,
              label = "Explosive Shot",
              cooldown = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagRanged",
              class_spell_mask = "HunterSpellExplosiveShot",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskRangedSpecial",
              damage_multiplier = "1",
              damage_multiplier_additive = "1",
              crit_multiplier = "svHunter.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "40",
              class_token = "hunter",
              spec_token = "_survival"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "black_arrow",
        "lnl",
        "explosive_shot"
      },
      synthetic = true
    },
    HunterMarksmanshipSpells = {
      fields = {
        steady_shot = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spec = "_marksmanship",
              spell_id = 56641,
              label = "Steady Shot",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagRanged",
              class_spell_mask = "HunterSpellSteadyShot",
              spell_school = "2",
              proc_mask = "ProcMaskRangedSpecial",
              damage_multiplier = "0.66",
              damage_multiplier_additive = "1",
              crit_multiplier = "mm.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "40",
              class_token = "hunter",
              spec_token = "_marksmanship"
            }
          }
        },
        chimera_shot = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spec = "_marksmanship",
              spell_id = 53209,
              label = "Chimera Shot",
              cooldown = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagRanged",
              class_spell_mask = "HunterSpellChimeraShot",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskRangedSpecial",
              damage_multiplier = "2.65",
              crit_multiplier = "mmHunter.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "40",
              class_token = "hunter",
              spec_token = "_marksmanship"
            }
          }
        },
        piercing_shots = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "hunter",
              spec = "_marksmanship",
              label = "Piercing Shots Talent",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "hunter",
              spec_token = "_marksmanship"
            },
            spell = {
              class = "hunter",
              spec = "_marksmanship",
              spell_id = 53238,
              label = "PiercingShots",
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreModifiers | core.SpellFlagPassiveSpell",
              spell_school = "2",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "hunter",
              spec_token = "_marksmanship"
            }
          }
        },
        steady_focus = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "hunter",
                spec = "_marksmanship",
                spell_id = 53224,
                label = "Steady Focus Counter",
                class_token = "hunter",
                spec_token = "_marksmanship"
              },
              {
                class = "hunter",
                spec = "_marksmanship",
                spell_id = 53224,
                label = "Steady Focus",
                duration = {
                  raw = "time.Second * 20",
                  seconds = 20.0
                },
                class_token = "hunter",
                spec_token = "_marksmanship"
              }
            }
          }
        },
        specialization = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "hunter",
              spec = "_marksmanship",
              spell_id = 35110,
              label = "Bombardment",
              duration = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              class_token = "hunter",
              spec_token = "_marksmanship"
            }
          }
        },
        mastery = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "hunter",
              spec = "_marksmanship",
              label = "Wild Quiver Mastery",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "hunter",
              spec_token = "_marksmanship"
            },
            spell = {
              class = "hunter",
              spec = "_marksmanship",
              spell_id = 76659,
              label = "Mastery",
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell | core.SpellFlagRanged",
              spell_school = "2",
              proc_mask = "2",
              damage_multiplier = "0.8",
              crit_multiplier = "mm.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "hunter",
              spec_token = "_marksmanship"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "steady_shot",
        "chimera_shot",
        "piercing_shots",
        "steady_focus",
        "specialization",
        "mastery"
      },
      synthetic = true
    },
    HunterBeastMasterySpells = {
      fields = {
        kill_command = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spec = "_beast_mastery",
              spell_id = 34026,
              label = "Kill Command",
              cooldown = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              flags = "SpellFlagAPL",
              class_spell_mask = "HunterSpellKillCommand",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeWhiteHit | ProcMaskMeleeSpecial",
              damage_multiplier_additive = "1",
              crit_multiplier = "bmHunter.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "100",
              class_token = "hunter",
              spec_token = "_beast_mastery"
            }
          }
        },
        beast_cleave = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spec = "_beast_mastery",
              spell_id = 118459,
              label = "Beast Cleave",
              flags = "core.SpellFlagIgnoreModifiers | core.SpellFlagNoSpellMods | core.SpellFlagPassiveSpell | core.SpellFlagNoOnCastComplete",
              class_spell_mask = "HunterPetBeastCleaveHit",
              spell_school = "2",
              proc_mask = "2",
              damage_multiplier = "0.75",
              threat_multiplier = "1",
              class_token = "hunter",
              spec_token = "_beast_mastery"
            }
          }
        },
        cobra_strikes = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "hunter",
              spec = "_beast_mastery",
              spell_id = 53260,
              label = "Cobra Strikes",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "hunter",
              spec_token = "_beast_mastery"
            }
          }
        },
        focus_fire = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spec = "_beast_mastery",
              spell_id = 82692,
              label = "Focus Fire",
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              class_token = "hunter",
              spec_token = "_beast_mastery"
            },
            aura = {
              class = "hunter",
              spec = "_beast_mastery",
              spell_id = 82692,
              label = "Focus Fire",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "hunter",
              spec_token = "_beast_mastery"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "kill_command",
        "beast_cleave",
        "cobra_strikes",
        "focus_fire"
      },
      synthetic = true
    },
    PriestShadowSpells = {
      fields = {
        talents = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "priest",
              spec = "shadow",
              spell_id = 15473,
              label = "Shadowform",
              class_token = "priest",
              spec_token = "shadow"
            }
          }
        },
        divine_star = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              spec = "shadow",
              spell_id = 122128,
              label = "Divine Star",
              cooldown = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "shadow.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "30",
              class_token = "priest",
              spec_token = "shadow"
            }
          }
        },
        mind_spike = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              spec = "shadow",
              spell_id = 73510,
              label = "Mind Spike",
              flags = "SpellFlagAPL",
              class_spell_mask = "PriestSpellMindSpike",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              damage_multiplier_additive = "1",
              crit_multiplier = "shadow.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "priest",
              spec_token = "shadow"
            }
          }
        },
        mind_blast = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              spec = "shadow",
              spell_id = 8092,
              label = "Mind Blast",
              cooldown = {
                raw = "time.Second * 8",
                seconds = 8.0
              },
              flags = "SpellFlagAPL",
              class_spell_mask = "PriestSpellMindBlast",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              damage_multiplier_additive = "1",
              crit_multiplier = "shadow.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "priest",
              spec_token = "shadow"
            }
          }
        },
        shadowy_apparition = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              spec = "shadow",
              spell_id = 148859,
              label = "Shadowy Apparition",
              flags = "SpellFlagPassiveSpell",
              class_spell_mask = "PriestSpellShadowyApparation",
              spell_school = "SpellSchoolShadow",
              proc_mask = "2",
              damage_multiplier = "1",
              damage_multiplier_additive = "1",
              crit_multiplier = "shadow.DefaultCritMultiplier()",
              class_token = "priest",
              spec_token = "shadow"
            }
          }
        },
        divine_insight = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "priest",
                spec = "shadow",
                label = "Divine Insight (Talent)",
                class_token = "priest",
                spec_token = "shadow"
              },
              {
                class = "priest",
                spec = "shadow",
                spell_id = 124430,
                label = "Divine Insight",
                duration = {
                  raw = "time.Second * 12",
                  seconds = 12.0
                },
                class_token = "priest",
                spec_token = "shadow"
              }
            }
          }
        },
        twist_of_fate = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "priest",
                spec = "shadow",
                label = "Twist of Fate (Talent)",
                class_token = "priest",
                spec_token = "shadow"
              },
              {
                class = "priest",
                spec = "shadow",
                spell_id = 123254,
                label = "Twist of Fate",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "priest",
                spec_token = "shadow"
              }
            }
          }
        },
        solace_and_instanity = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              spec = "shadow",
              spell_id = 129197,
              label = "MindFlay-Insanity",
              flags = "core.SpellFlagChanneled | core.SpellFlagAPL",
              class_spell_mask = "PriestSpellMindFlay",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              damage_multiplier_additive = "1",
              crit_multiplier = "shadow.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "priest",
              spec_token = "shadow"
            }
          }
        },
        surge_of_darkness = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "priest",
                spec = "shadow",
                label = "Surge of Darkness (Talent)",
                class_token = "priest",
                spec_token = "shadow"
              },
              {
                class = "priest",
                spec = "shadow",
                spell_id = 87160,
                label = "Surge of Darkness",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "priest",
                spec_token = "shadow"
              }
            }
          }
        },
        cascade = {
          id = 10,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "priest",
                spec = "shadow",
                spell_id = 127632,
                label = "Cascade",
                cooldown = {
                  raw = "time.Second * 25",
                  seconds = 25.0
                },
                flags = "SpellFlagAPL",
                spell_school = "SpellSchoolShadow",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "shadow.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "priest",
                spec_token = "shadow"
              },
              {
                class = "priest",
                spec = "shadow",
                spell_id = 127632,
                label = "Cascade",
                flags = "SpellFlagPassiveSpell",
                spell_school = "SpellSchoolShadow",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "shadow.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "priest",
                spec_token = "shadow"
              }
            }
          }
        },
        halo = {
          id = 11,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              spec = "shadow",
              spell_id = 120696,
              label = "Halo",
              cooldown = {
                raw = "time.Second * 40",
                seconds = 40.0
              },
              flags = "SpellFlagAPL",
              class_spell_mask = "PriestSpellHalo",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "shadow.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "30",
              class_token = "priest",
              spec_token = "shadow"
            }
          }
        },
        build_single_tick = {
          id = 12,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "priest",
                spec = "shadow",
                spell_id = 2944,
                label = "Shadowy Recall (Spell 2944)",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
                class_spell_mask = "classMask | priest.PriestSpellShadowyRecall",
                spell_school = "SpellSchoolShadow",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "shadow.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "priest",
                spec_token = "shadow"
              },
              {
                class = "priest",
                spec = "shadow",
                spell_id = 48045,
                label = "Shadowy Recall (Spell 48045)",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
                class_spell_mask = "classMask | priest.PriestSpellShadowyRecall",
                spell_school = "SpellSchoolShadow",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "shadow.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "priest",
                spec_token = "shadow"
              },
              {
                class = "priest",
                spec = "shadow",
                spell_id = 34914,
                label = "Shadowy Recall (Spell 34914)",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
                class_spell_mask = "classMask | priest.PriestSpellShadowyRecall",
                spell_school = "SpellSchoolShadow",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "shadow.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "priest",
                spec_token = "shadow"
              },
              {
                class = "priest",
                spec = "shadow",
                spell_id = 15407,
                label = "Shadowy Recall (Spell 15407)",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
                class_spell_mask = "classMask | priest.PriestSpellShadowyRecall",
                spell_school = "SpellSchoolShadow",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "shadow.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "priest",
                spec_token = "shadow"
              },
              {
                class = "priest",
                spec = "shadow",
                spell_id = 589,
                label = "Shadowy Recall (Spell 589)",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
                class_spell_mask = "classMask | priest.PriestSpellShadowyRecall",
                spell_school = "SpellSchoolShadow",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "shadow.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "priest",
                spec_token = "shadow"
              }
            }
          }
        },
        shadowy_recall = {
          id = 13,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "priest",
              spec = "shadow",
              label = "Shadowy Recall (Mastery)",
              class_token = "priest",
              spec_token = "shadow"
            }
          }
        },
        shadow_word_death = {
          id = 14,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              spec = "shadow",
              spell_id = 32379,
              label = "Shadow Word Death",
              cooldown = {
                raw = "time.Second * 8",
                seconds = 8.0
              },
              flags = "SpellFlagAPL",
              class_spell_mask = "PriestSpellShadowWordDeath",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              damage_multiplier_additive = "1",
              crit_multiplier = "shadow.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "priest",
              spec_token = "shadow"
            },
            aura = {
              class = "priest",
              spec = "shadow",
              spell_id = 32379,
              label = "Shadow Word: Death",
              duration = {
                raw = "9 * time.Second",
                seconds = 9.0
              },
              class_token = "priest",
              spec_token = "shadow"
            }
          }
        },
        devouring_plague = {
          id = 15,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "priest",
                spec = "shadow",
                spell_id = 2944,
                label = "Devouring Plague",
                flags = "core.SpellFlagDisease | core.SpellFlagPassiveSpell",
                class_spell_mask = "PriestSpellDevouringPlagueDoT",
                spell_school = "SpellSchoolShadow",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                damage_multiplier_additive = "1",
                crit_multiplier = "shadow.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "priest",
                spec_token = "shadow"
              },
              {
                class = "priest",
                spec = "shadow",
                spell_id = 2944,
                label = "Devouring Plague",
                flags = "core.SpellFlagHelpful | core.SpellFlagPassiveSpell",
                class_spell_mask = "PriestSpellDevouringPlagueHeal",
                spell_school = "SpellSchoolShadow",
                proc_mask = "ProcMaskSpellHealing",
                damage_multiplier = "1",
                crit_multiplier = "shadow.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "priest",
                spec_token = "shadow"
              },
              {
                class = "priest",
                spec = "shadow",
                spell_id = 2944,
                label = "Devouring Plague",
                flags = "core.SpellFlagDisease | core.SpellFlagAPL",
                class_spell_mask = "PriestSpellDevouringPlague",
                spell_school = "SpellSchoolShadow",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                damage_multiplier_additive = "1",
                crit_multiplier = "shadow.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "priest",
                spec_token = "shadow"
              }
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "talents",
        "divine_star",
        "mind_spike",
        "mind_blast",
        "shadowy_apparition",
        "divine_insight",
        "twist_of_fate",
        "solace_and_instanity",
        "surge_of_darkness",
        "cascade",
        "halo",
        "build_single_tick",
        "shadowy_recall",
        "shadow_word_death",
        "devouring_plague"
      },
      synthetic = true
    },
    WarlockAfflictionSpells = {
      fields = {
        haunt = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spec = "_affliction",
              spell_id = 48181,
              label = "Haunt",
              flags = "SpellFlagAPL",
              class_spell_mask = "WarlockSpellHaunt",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "affliction.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "warlock",
              spec_token = "_affliction"
            }
          }
        },
        new_affliction_current_snapshot = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warlock",
              spec = "_affliction",
              label = "Dummy Aura - APL Current Snapshot Base Value",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "warlock",
              spec_token = "_affliction"
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
              spec = "_affliction",
              spell_id = 1120,
              label = "DrainSoul",
              flags = "core.SpellFlagAPL | core.SpellFlagChanneled",
              class_spell_mask = "WarlockSpellDrainSoul",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier_additive = "1",
              crit_multiplier = "affliction.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "warlock",
              spec_token = "_affliction"
            }
          }
        },
        agony = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spec = "_affliction",
              spell_id = 980,
              label = "Agony",
              flags = "SpellFlagAPL",
              class_spell_mask = "WarlockSpellAgony",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "affliction.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "warlock",
              spec_token = "_affliction"
            }
          }
        },
        soulburn = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spec = "_affliction",
              spell_id = 74434,
              label = "Soulburn",
              cooldown = {
                raw = "time.Second",
                seconds = 1.0
              },
              flags = "SpellFlagAPL",
              class_spell_mask = "WarlockSpellSoulBurn",
              spell_school = "SpellSchoolShadow",
              proc_mask = "2",
              class_token = "warlock",
              spec_token = "_affliction"
            },
            aura = {
              class = "warlock",
              spec = "_affliction",
              spell_id = 74434,
              label = "Soulburn",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "warlock",
              spec_token = "_affliction"
            }
          }
        },
        seed = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "warlock",
                spec = "_affliction",
                spell_id = 27243,
                label = "Seed",
                flags = "SpellFlagAPL",
                class_spell_mask = "WarlockSpellSeedOfCorruption",
                spell_school = "SpellSchoolShadow",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier_additive = "1",
                crit_multiplier = "affliction.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "warlock",
                spec_token = "_affliction"
              },
              {
                class = "warlock",
                spec = "_affliction",
                spell_id = 27243,
                label = "Seed",
                flags = "core.SpellFlagAoE | core.SpellFlagPassiveSpell",
                class_spell_mask = "WarlockSpellSeedOfCorruptionExposion",
                spell_school = "SpellSchoolShadow",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier_additive = "1",
                crit_multiplier = "affliction.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "warlock",
                spec_token = "_affliction"
              }
            }
          }
        },
        malefic = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spec = "_affliction",
              label = "Malefic",
              flags = "core.SpellFlagPassiveSpell | core.SpellFlagNoOnCastComplete | core.SpellFlagNoSpellMods | core.SpellFlagIgnoreAttackerModifiers",
              class_spell_mask = "WarlockSpellMaleficGrasp",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "affliction.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "warlock",
              spec_token = "_affliction"
            }
          }
        },
        dark_soul_misery = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spec = "_affliction",
              spell_id = 113860,
              label = "Dark Soul Misery",
              cooldown = {
                raw = "time.Minute * 2",
                seconds = 120.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS",
                priority = "core.CooldownPriorityDefault"
              },
              class_spell_mask = "WarlockSpellDarkSoulMisery",
              spell_school = "SpellSchoolShadow",
              proc_mask = "2",
              damage_multiplier = "1",
              related_self_buff = "affliction.DarkSoulMiseryAura",
              class_token = "warlock",
              spec_token = "_affliction"
            },
            aura = {
              class = "warlock",
              spec = "_affliction",
              spell_id = 113860,
              label = "Dark Soul: Misery",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "warlock",
              spec_token = "_affliction"
            }
          }
        },
        soul_swap = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "warlock",
                spec = "_affliction",
                spell_id = 86121,
                label = "Soul Swap",
                flags = "SpellFlagAPL",
                spell_school = "SpellSchoolShadow",
                proc_mask = "2",
                damage_multiplier = "1",
                crit_multiplier = "affliction.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "warlock",
                spec_token = "_affliction"
              },
              {
                class = "warlock",
                spec = "_affliction",
                spell_id = 86121,
                label = "Soul Swap",
                flags = "SpellFlagAPL",
                spell_school = "SpellSchoolShadow",
                proc_mask = "2",
                damage_multiplier = "1",
                crit_multiplier = "affliction.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "warlock",
                spec_token = "_affliction"
              },
              {
                class = "warlock",
                spec = "_affliction",
                spell_id = 86213,
                label = "Soul Swap",
                flags = "SpellFlagAPL",
                spell_school = "SpellSchoolShadow",
                proc_mask = "2",
                damage_multiplier = "1",
                crit_multiplier = "affliction.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "warlock",
                spec_token = "_affliction"
              }
            },
            aura = {
              class = "warlock",
              spec = "_affliction",
              spell_id = 86211,
              label = "Soul Swap",
              duration = {
                raw = "time.Second * 3",
                seconds = 3.0
              },
              class_token = "warlock",
              spec_token = "_affliction"
            }
          }
        },
        malefic_grasp = {
          id = 10,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spec = "_affliction",
              spell_id = 103103,
              label = "MaleficGrasp",
              flags = "core.SpellFlagAPL | core.SpellFlagChanneled",
              class_spell_mask = "WarlockSpellMaleficGrasp",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier_additive = "1",
              crit_multiplier = "affliction.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "warlock",
              spec_token = "_affliction"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "haunt",
        "new_affliction_current_snapshot",
        "drain_soul",
        "agony",
        "soulburn",
        "seed",
        "malefic",
        "dark_soul_misery",
        "soul_swap",
        "malefic_grasp"
      },
      synthetic = true
    },
    WarlockDemonologySpells = {
      fields = {
        hand_of_guldan = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "warlock",
                spec = "_demonology",
                spell_id = 105174,
                label = "Hand Of Guldan",
                flags = "core.SpellFlagAoE | core.SpellFlagAPL",
                class_spell_mask = "WarlockSpellHandOfGuldan",
                spell_school = "core.SpellSchoolFire | core.SpellSchoolShadow",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "demonology.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "warlock",
                spec_token = "_demonology"
              },
              {
                class = "warlock",
                spec = "_demonology",
                spell_id = 47960,
                label = "Shadowflame",
                flags = "SpellFlagNoOnCastComplete",
                class_spell_mask = "WarlockSpellShadowflameDot",
                spell_school = "core.SpellSchoolFire | core.SpellSchoolShadow",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "demonology.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "warlock",
                spec_token = "_demonology"
              }
            }
          }
        },
        immolation = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spec = "_demonology",
              spell_id = 104025,
              label = "Immolation Aura (DoT)",
              flags = "core.SpellFlagAoE | core.SpellFlagAPL | core.SpellFlagNoMetrics",
              class_spell_mask = "WarlockSpellImmolationAura",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier_additive = "1",
              crit_multiplier = "demonology.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "warlock",
              spec_token = "_demonology"
            }
          }
        },
        doom = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spec = "_demonology",
              spell_id = 603,
              label = "Doom",
              flags = "SpellFlagAPL",
              class_spell_mask = "WarlockSpellDoom",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier_additive = "1",
              crit_multiplier = "demonology.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "warlock",
              spec_token = "_demonology"
            }
          }
        },
        void_ray = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spec = "_demonology",
              spell_id = 115422,
              label = "Void Ray",
              flags = "core.SpellFlagAoE | core.SpellFlagAPL",
              class_spell_mask = "WarlockSpellVoidray",
              spell_school = "SpellSchoolFire | SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1.0",
              crit_multiplier = "demonology.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "warlock",
              spec_token = "_demonology"
            }
          }
        },
        wild_imp_passive = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warlock",
              spec = "_demonology",
              label = "Wild Imp - Controller",
              class_token = "warlock",
              spec_token = "_demonology"
            }
          }
        },
        firebolt = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spec = "_demonology",
              spell_id = 104318,
              label = "Firebolt",
              class_spell_mask = "WarlockSpellImpFireBolt",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "2",
              threat_multiplier = "1",
              class_token = "warlock",
              spec_token = "_demonology"
            }
          }
        },
        chaos_wave = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spec = "_demonology",
              spell_id = 124916,
              label = "Chaos Wave",
              flags = "core.SpellFlagAoE | core.SpellFlagAPL",
              class_spell_mask = "WarlockSpellChaosWave",
              spell_school = "SpellSchoolArcane | SpellSchoolFire | SpellSchoolFrost | SpellSchoolHoly | SpellSchoolNature | SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "demonology.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "warlock",
              spec_token = "_demonology"
            }
          }
        },
        carrion_swarm = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spec = "_demonology",
              spell_id = 103967,
              label = "Carrion Swarm",
              cooldown = {
                raw = "time.Second * 12",
                seconds = 12.0
              },
              flags = "core.SpellFlagAoE | core.SpellFlagAPL",
              class_spell_mask = "WarlockSpellCarrionSwarm",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "demonology.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "warlock",
              spec_token = "_demonology"
            }
          }
        },
        shadow_bolt = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spec = "_demonology",
              spell_id = 686,
              label = "Shadow Bolt",
              flags = "SpellFlagAPL",
              class_spell_mask = "WarlockSpellShadowBolt",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier_additive = "1",
              crit_multiplier = "demonology.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "warlock",
              spec_token = "_demonology"
            }
          }
        },
        metamorphosis = {
          id = 10,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spec = "_demonology",
              spell_id = 103958,
              label = "Metamorphosis",
              cooldown = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              flags = "core.SpellFlagAPL | core.SpellFlagNoOnCastComplete",
              spell_school = "SpellSchoolShadow",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              related_self_buff = "demo.MetamorphosisAura",
              class_token = "warlock",
              spec_token = "_demonology"
            },
            aura = {
              class = "warlock",
              spec = "_demonology",
              spell_id = 103958,
              label = "Metamorphosis",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "warlock",
              spec_token = "_demonology"
            }
          }
        },
        legion_strike = {
          id = 11,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spec = "_demonology",
              spell_id = 30213,
              label = "Legion Strike",
              cooldown = {
                raw = "time.Millisecond * 1300",
                seconds = 1.3
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              class_spell_mask = "WarlockSpellFelGuardLegionStrike",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              crit_multiplier = "2",
              threat_multiplier = "1",
              class_token = "warlock",
              spec_token = "_demonology"
            }
          }
        },
        felstorm = {
          id = 12,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spec = "_demonology",
              spell_id = 89751,
              label = "Felstorm",
              cooldown = {
                raw = "time.Second * 45",
                seconds = 45.0
              },
              flags = "core.SpellFlagAoE | core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagChanneled",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              crit_multiplier = "2",
              threat_multiplier = "1",
              class_token = "warlock",
              spec_token = "_demonology"
            }
          }
        },
        felguard_with_name = {
          id = 13,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spec = "_demonology",
              spell_id = 89751,
              label = "Felguard With Name",
              cooldown = {
                raw = "time.Second * 45",
                seconds = 45.0
              },
              flags = "core.SpellFlagAPL | core.SpellFlagNoMetrics",
              spell_school = "2",
              proc_mask = "2",
              class_token = "warlock",
              spec_token = "_demonology"
            }
          }
        },
        touch_of_chaos = {
          id = 14,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spec = "_demonology",
              spell_id = 103964,
              label = "Touch Of Chaos",
              flags = "SpellFlagAPL",
              class_spell_mask = "WarlockSpellTouchOfChaos",
              spell_school = "SpellSchoolArcane | SpellSchoolFire | SpellSchoolFrost | SpellSchoolHoly | SpellSchoolNature | SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier_additive = "1",
              crit_multiplier = "demonology.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "warlock",
              spec_token = "_demonology"
            }
          }
        },
        soulfire = {
          id = 15,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "warlock",
                spec = "_demonology",
                spell_id = 104027,
                label = "Soulfire",
                class_token = "warlock",
                spec_token = "_demonology"
              },
              {
                class = "warlock",
                spec = "_demonology",
                spell_id = 6353,
                label = "Soulfire",
                class_token = "warlock",
                spec_token = "_demonology"
              }
            }
          }
        },
        darksoul_knowledge = {
          id = 16,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spec = "_demonology",
              spell_id = 113861,
              label = "Darksoul Knowledge",
              cooldown = {
                raw = "time.Minute * 2",
                seconds = 120.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS",
                priority = "core.CooldownPriorityDefault"
              },
              class_spell_mask = "WarlockSpellDarkSoulKnowledge",
              spell_school = "SpellSchoolShadow",
              proc_mask = "2",
              damage_multiplier = "1",
              related_self_buff = "demonology.DarksoulKnowledgeAura",
              class_token = "warlock",
              spec_token = "_demonology"
            }
          }
        },
        grimoire_of_supremacy = {
          id = 17,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spec = "_demonology",
              spell_id = 115625,
              label = "Grimoire Of Supremacy",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              class_spell_mask = "WarlockSpellFelGuardLegionStrike",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              crit_multiplier = "2",
              threat_multiplier = "1",
              class_token = "warlock",
              spec_token = "_demonology"
            }
          }
        },
        molten_core = {
          id = 18,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warlock",
              spec = "_demonology",
              spell_id = 122355,
              label = "Demonic Core",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "warlock",
              spec_token = "_demonology"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "hand_of_guldan",
        "immolation",
        "doom",
        "void_ray",
        "wild_imp_passive",
        "firebolt",
        "chaos_wave",
        "carrion_swarm",
        "shadow_bolt",
        "metamorphosis",
        "legion_strike",
        "felstorm",
        "felguard_with_name",
        "touch_of_chaos",
        "soulfire",
        "darksoul_knowledge",
        "grimoire_of_supremacy",
        "molten_core"
      },
      synthetic = true
    },
    WarlockDestructionSpells = {
      fields = {
        fire_and_brimstone_incinerate = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spec = "_destruction",
              spell_id = 114654,
              label = "Fire And Brimstone Incinerate",
              flags = "core.SpellFlagAoE | core.SpellFlagAPL",
              class_spell_mask = "WarlockSpellFaBIncinerate",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier_additive = "1",
              crit_multiplier = "destruction.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "warlock",
              spec_token = "_destruction"
            }
          }
        },
        chaotic_energy = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warlock",
              spec = "_destruction",
              label = "Chaotic Energy",
              class_token = "warlock",
              spec_token = "_destruction"
            }
          }
        },
        immolate = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "warlock",
                spec = "_destruction",
                spell_id = 348,
                label = "Immolate (DoT)",
                flags = "SpellFlagPassiveSpell",
                class_spell_mask = "WarlockSpellImmolateDot",
                spell_school = "SpellSchoolFire",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "destruction.DefaultCritMultiplier()",
                class_token = "warlock",
                spec_token = "_destruction"
              },
              {
                class = "warlock",
                spec = "_destruction",
                spell_id = 348,
                label = "Immolate",
                flags = "SpellFlagAPL",
                class_spell_mask = "WarlockSpellImmolate",
                spell_school = "SpellSchoolFire",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "destruction.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "warlock",
                spec_token = "_destruction"
              }
            }
          }
        },
        shadow_burn = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spec = "_destruction",
              spell_id = 17877,
              label = "Shadow Burn",
              flags = "SpellFlagAPL",
              class_spell_mask = "WarlockSpellShadowBurn",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier_additive = "1",
              crit_multiplier = "destruction.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "warlock",
              spec_token = "_destruction"
            }
          }
        },
        havoc = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spec = "_destruction",
              spell_id = 80240,
              label = "Havoc",
              cooldown = {
                raw = "cooldown * time.Second"
              },
              flags = "SpellFlagAPL",
              class_spell_mask = "WarlockSpellHavoc",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              class_token = "warlock",
              spec_token = "_destruction"
            },
            aura = {
              {
                class = "warlock",
                spec = "_destruction",
                spell_id = 80240,
                label = "Havoc Charges Aura",
                duration = {
                  raw = "time.Second * 15",
                  seconds = 15.0
                },
                class_token = "warlock",
                spec_token = "_destruction"
              },
              {
                class = "warlock",
                spec = "_destruction",
                spell_id = 80240,
                label = "Havoc",
                duration = {
                  raw = "time.Second * 15",
                  seconds = 15.0
                },
                class_token = "warlock",
                spec_token = "_destruction"
              }
            }
          }
        },
        incinerate = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spec = "_destruction",
              spell_id = 29722,
              label = "Incinerate",
              flags = "SpellFlagAPL",
              class_spell_mask = "WarlockSpellIncinerate",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier_additive = "1",
              crit_multiplier = "destro.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "warlock",
              spec_token = "_destruction"
            }
          }
        },
        chaos_bolt = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spec = "_destruction",
              spell_id = 116858,
              label = "Chaosbolt (DoT)",
              flags = "SpellFlagAPL",
              class_spell_mask = "WarlockSpellChaosBolt",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier_additive = "1",
              crit_multiplier = "destro.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "warlock",
              spec_token = "_destruction"
            }
          }
        },
        rain_of_fire = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spec = "_destruction",
              spell_id = 104232,
              label = "Rain of Fire (DoT)",
              flags = "core.SpellFlagAoE | core.SpellFlagAPL",
              class_spell_mask = "WarlockSpellRainOfFire",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier_additive = "1",
              crit_multiplier = "destruction.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "warlock",
              spec_token = "_destruction"
            }
          }
        },
        fire_and_brimstone_immolate = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "warlock",
                spec = "_destruction",
                spell_id = 108686,
                label = "FAB - Immolate (DoT)",
                flags = "SpellFlagPassiveSpell",
                class_spell_mask = "WarlockSpellImmolateDot",
                spell_school = "SpellSchoolFire",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "destruction.DefaultCritMultiplier()",
                class_token = "warlock",
                spec_token = "_destruction"
              },
              {
                class = "warlock",
                spec = "_destruction",
                spell_id = 108686,
                label = "Fire And Brimstone Immolate",
                flags = "SpellFlagAPL",
                class_spell_mask = "WarlockSpellImmolate",
                spell_school = "SpellSchoolFire",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "destruction.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "warlock",
                spec_token = "_destruction"
              }
            }
          }
        },
        fire_and_brimstone_conflagrate = {
          id = 10,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spec = "_destruction",
              spell_id = 108685,
              label = "Fire And Brimstone Conflagrate",
              flags = "core.SpellFlagAoE | core.SpellFlagAPL",
              class_spell_mask = "WarlockSpellFaBConflagrate",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "destruction.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "warlock",
              spec_token = "_destruction"
            }
          }
        },
        mastery = {
          id = 11,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warlock",
              spec = "_destruction",
              label = "Mastery: Emberstorm",
              class_token = "warlock",
              spec_token = "_destruction"
            }
          }
        },
        backdraft = {
          id = 12,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warlock",
              spec = "_destruction",
              spell_id = 117828,
              label = "Backdraft",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "warlock",
              spec_token = "_destruction"
            }
          }
        },
        fire_and_brimstone = {
          id = 13,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spec = "_destruction",
              spell_id = 108683,
              label = "Fire And Brimstone",
              flags = "SpellFlagAPL",
              class_spell_mask = "WarlockSpellFireAndBrimstone",
              spell_school = "SpellSchoolFire",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "warlock",
              spec_token = "_destruction"
            },
            aura = {
              class = "warlock",
              spec = "_destruction",
              spell_id = 108683,
              label = "Fire and Brimstone",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "warlock",
              spec_token = "_destruction"
            }
          }
        },
        dark_soul_inst = {
          id = 14,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spec = "_destruction",
              spell_id = 113858,
              label = "Dark Soul Inst",
              cooldown = {
                raw = "time.Minute * 2",
                seconds = 120.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS",
                priority = "core.CooldownPriorityDefault"
              },
              class_spell_mask = "WarlockSpellDarkSoulInsanity",
              spell_school = "SpellSchoolShadow",
              proc_mask = "2",
              damage_multiplier = "1",
              related_self_buff = "destruction.DarkSoulInstabilityAura",
              class_token = "warlock",
              spec_token = "_destruction"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "fire_and_brimstone_incinerate",
        "chaotic_energy",
        "immolate",
        "shadow_burn",
        "havoc",
        "incinerate",
        "chaos_bolt",
        "rain_of_fire",
        "fire_and_brimstone_immolate",
        "fire_and_brimstone_conflagrate",
        "mastery",
        "backdraft",
        "fire_and_brimstone",
        "dark_soul_inst"
      },
      synthetic = true
    },
    PaladinRetributionSpells = {
      fields = {
        exorcism = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "paladin",
              spec = "retribution",
              spell_id = 879,
              label = "Exorcism",
              cooldown = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              flags = "SpellFlagAPL",
              class_spell_mask = "SpellMaskExorcism",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "ret.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "30",
              class_token = "paladin",
              spec_token = "retribution"
            }
          }
        },
        hotfix_passive = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "paladin",
              spec = "retribution",
              label = "Hotfix Passive",
              class_token = "paladin",
              spec_token = "retribution"
            }
          }
        },
        templars_verdict = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "paladin",
              spec = "retribution",
              spell_id = 85256,
              label = "Templars Verdict",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              class_spell_mask = "SpellMaskTemplarsVerdict",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "2.75",
              crit_multiplier = "ret.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "5",
              class_token = "paladin",
              spec_token = "retribution"
            }
          }
        },
        inquisition = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "paladin",
              spec = "retribution",
              spell_id = 84963,
              label = "Inquisition",
              flags = "core.SpellFlagAPL | core.SpellFlagHelpful | core.SpellFlagMeleeMetrics",
              class_spell_mask = "SpellMaskInquisition",
              spell_school = "SpellSchoolHoly",
              proc_mask = "2",
              threat_multiplier = "1",
              related_self_buff = "ret.InquisitionAura",
              class_token = "paladin",
              spec_token = "retribution"
            },
            aura = {
              class = "paladin",
              spec = "retribution",
              spell_id = 84963,
              label = "Inquisition",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "paladin",
              spec_token = "retribution"
            }
          }
        },
        seal_of_justice = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "paladin",
                spec = "retribution",
                spell_id = 20164,
                label = "Seal Of Justice",
                flags = "core.SpellFlagAPL | core.SpellFlagPassiveSpell",
                spell_school = "SpellSchoolHoly",
                proc_mask = "2",
                threat_multiplier = "0",
                class_token = "paladin",
                spec_token = "retribution"
              },
              {
                class = "paladin",
                spec = "retribution",
                spell_id = 20170,
                label = "Seal Of Justice",
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagPassiveSpell",
                class_spell_mask = "SpellMaskSealOfJustice",
                spell_school = "SpellSchoolHoly",
                proc_mask = "ProcMaskMeleeProc",
                damage_multiplier = "0.2",
                crit_multiplier = "ret.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "paladin",
                spec_token = "retribution"
              }
            },
            aura = {
              {
                class = "paladin",
                spec = "retribution",
                spell_id = 20164,
                label = "Seal of Justice",
                tag = "Seal",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "paladin",
                spec_token = "retribution"
              },
              {
                class = "paladin",
                spec = "retribution",
                spell_id = 20170,
                label = "Seal of Justice",
                duration = {
                  raw = "time.Second * 8",
                  seconds = 8.0
                },
                class_token = "paladin",
                spec_token = "retribution"
              }
            }
          }
        },
        sword_of_light = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "paladin",
                spec = "retribution",
                spell_id = 53503,
                label = "Sword of Light Mana Regen",
                class_token = "paladin",
                spec_token = "retribution"
              },
              {
                class = "paladin",
                spec = "retribution",
                spell_id = 53503,
                label = "Sword of Light",
                class_token = "paladin",
                spec_token = "retribution"
              }
            }
          }
        },
        mastery = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "paladin",
              spec = "retribution",
              spell_id = 96172,
              label = "Mastery",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIgnoreModifiers | core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
              spell_school = "SpellSchoolHoly",
              proc_mask = "2",
              damage_multiplier = "1.0",
              crit_multiplier = "0.0",
              threat_multiplier = "1.0",
              class_token = "paladin",
              spec_token = "retribution"
            }
          }
        },
        art_of_war = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "paladin",
              spec = "retribution",
              spell_id = 59578,
              label = "The Art Of War",
              duration = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              class_token = "paladin",
              spec_token = "retribution"
            }
          }
        },
        divine_storm = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "paladin",
              spec = "retribution",
              spell_id = 53385,
              label = "Divine Storm",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagAoE",
              class_spell_mask = "SpellMaskDivineStorm",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              crit_multiplier = "ret.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "8",
              class_token = "paladin",
              spec_token = "retribution"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "exorcism",
        "hotfix_passive",
        "templars_verdict",
        "inquisition",
        "seal_of_justice",
        "sword_of_light",
        "mastery",
        "art_of_war",
        "divine_storm"
      },
      synthetic = true
    },
    PaladinProtectionSpells = {
      fields = {
        shield_of_the_righteous = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "paladin",
              spec = "protection",
              spell_id = 53600,
              label = "Shield Of The Righteous",
              cooldown = {
                raw = "time.Millisecond * 1500",
                seconds = 1.5
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              class_spell_mask = "SpellMaskShieldOfTheRighteous",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              crit_multiplier = "prot.DefaultCritMultiplier()",
              threat_multiplier = "1",
              related_self_buff = "prot.ShieldOfTheRighteousAura",
              max_range = "5",
              class_token = "paladin",
              spec_token = "protection"
            },
            aura = {
              {
                class = "paladin",
                spec = "protection",
                spell_id = 132403,
                label = "Shield of the Righteous",
                duration = {
                  raw = "time.Second * 3",
                  seconds = 3.0
                },
                class_token = "paladin",
                spec_token = "protection"
              },
              {
                class = "paladin",
                spec = "protection",
                spell_id = 114637,
                label = "Bastion of Glory",
                duration = {
                  raw = "time.Second * 20",
                  seconds = 20.0
                },
                class_token = "paladin",
                spec_token = "protection"
              }
            }
          }
        },
        grand_crusader = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "paladin",
              spec = "protection",
              spell_id = 85416,
              label = "Grand Crusader",
              duration = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              class_token = "paladin",
              spec_token = "protection"
            }
          }
        },
        righteous_fury = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "paladin",
              spec = "protection",
              spell_id = 25780,
              label = "Righteous Fury",
              class_token = "paladin",
              spec_token = "protection"
            }
          }
        },
        holy_wrath = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "paladin",
              spec = "protection",
              spell_id = 119072,
              label = "Holy Wrath",
              cooldown = {
                raw = "9 * time.Second",
                seconds = 9.0
              },
              flags = "SpellFlagAPL",
              class_spell_mask = "SpellMaskHolyWrath",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "prot.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "10",
              class_token = "paladin",
              spec_token = "protection"
            }
          }
        },
        track_damage_taken_last_global = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "paladin",
              spec = "protection",
              label = "Damage Taken Last Global",
              class_token = "paladin",
              spec_token = "protection"
            }
          }
        },
        mastery = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "paladin",
              spec = "protection",
              spell_id = 76671,
              label = "Mastery: Divine Bulwark",
              class_token = "paladin",
              spec_token = "protection"
            }
          }
        },
        guarded_by_the_light = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "paladin",
                spec = "protection",
                spell_id = 53592,
                label = "Guarded by the Light Mana Regen",
                class_token = "paladin",
                spec_token = "protection"
              },
              {
                class = "paladin",
                spec = "protection",
                spell_id = 53592,
                label = "Guarded by the Light",
                class_token = "paladin",
                spec_token = "protection"
              }
            }
          }
        },
        sanctuary = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "paladin",
              spec = "protection",
              spell_id = 105805,
              label = "Sanctuary",
              class_token = "paladin",
              spec_token = "protection"
            }
          }
        },
        consecration = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "paladin",
              spec = "protection",
              spell_id = 26573,
              label = "Consecration",
              cooldown = {
                raw = "9 * time.Second",
                seconds = 9.0
              },
              flags = "core.SpellFlagAPL | core.SpellFlagAoE",
              class_spell_mask = "SpellMaskConsecration",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "prot.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "8",
              class_token = "paladin",
              spec_token = "protection"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "shield_of_the_righteous",
        "grand_crusader",
        "righteous_fury",
        "holy_wrath",
        "track_damage_taken_last_global",
        "mastery",
        "guarded_by_the_light",
        "sanctuary",
        "consecration"
      },
      synthetic = true
    },
    MageFireSpells = {
      fields = {
        inferno_blast = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spec = "_fire",
              spell_id = 108853,
              label = "Inferno Blast",
              cooldown = {
                raw = "time.Second * 8",
                seconds = 8.0
              },
              flags = "SpellFlagAPL",
              class_spell_mask = "MageSpellInfernoBlast",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "fire.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "mage",
              spec_token = "_fire"
            }
          }
        },
        scorch = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spec = "_fire",
              spell_id = 2948,
              label = "Scorch",
              flags = "SpellFlagAPL",
              class_spell_mask = "MageSpellScorch",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier_additive = "1",
              crit_multiplier = "fire.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "mage",
              spec_token = "_fire"
            }
          }
        },
        fireball = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spec = "_fire",
              spell_id = 133,
              label = "Fireball",
              flags = "SpellFlagAPL",
              class_spell_mask = "MageSpellFireball",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "fire.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "mage",
              spec_token = "_fire"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "inferno_blast",
        "scorch",
        "fireball"
      },
      synthetic = true
    },
    MageFrostSpells = {
      fields = {
        mastery = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "mage",
              spec = "_frost",
              label = "Mastery: Icicles - Water Elemental",
              class_token = "mage",
              spec_token = "_frost"
            }
          }
        },
        fingers_of_frost = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "mage",
              spec = "_frost",
              spell_id = 112965,
              label = "Fingers of Frost",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "mage",
              spec_token = "_frost"
            }
          }
        },
        frozen_orb = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "mage",
                spec = "_frost",
                spell_id = 84714,
                label = "Frozen Orb",
                cooldown = {
                  raw = "time.Minute",
                  seconds = 60.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "SpellFlagAPL",
                class_spell_mask = "MageSpellFrozenOrb",
                spell_school = "SpellSchoolFrost",
                proc_mask = "2",
                class_token = "mage",
                spec_token = "_frost"
              },
              {
                class = "mage",
                spec = "_frost",
                spell_id = 84721,
                label = "Frozen Orb",
                flags = "core.SpellFlagAoE",
                class_spell_mask = "MageSpellFrozenOrbTick",
                spell_school = "SpellSchoolFrost",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "frost.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "mage",
                spec_token = "_frost"
              }
            }
          }
        },
        frostbolt = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spec = "_frost",
              label = "Frostbolt",
              flags = "core.SpellFlagAPL",
              class_spell_mask = "MageSpellFrostbolt",
              spell_school = "SpellSchoolFrost",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "frost.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "mage",
              spec_token = "_frost"
            }
          }
        },
        brain_freeze = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "mage",
              spec = "_frost",
              spell_id = 44549,
              label = "Brain Freeze",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "mage",
              spec_token = "_frost"
            }
          }
        },
        waterbolt = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spec = "_frost",
              spell_id = 31707,
              label = "Waterbolt",
              class_spell_mask = "MageWaterElementalSpellWaterBolt",
              spell_school = "SpellSchoolFrost",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1 * 1.2",
              crit_multiplier = "we.mageOwner.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "mage",
              spec_token = "_frost"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "mastery",
        "fingers_of_frost",
        "frozen_orb",
        "frostbolt",
        "brain_freeze",
        "waterbolt"
      },
      synthetic = true
    },
    MageArcaneSpells = {
      fields = {
        mastery = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "mage",
              spec = "_arcane",
              spell_id = 76547,
              label = "Mana Adept",
              class_token = "mage",
              spec_token = "_arcane"
            }
          }
        },
        arcane_blast = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spec = "_arcane",
              spell_id = 30451,
              label = "Arcane Blast",
              flags = "SpellFlagAPL",
              class_spell_mask = "MageSpellArcaneBlast",
              spell_school = "SpellSchoolArcane",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "arcane.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "mage",
              spec_token = "_arcane"
            }
          }
        },
        arcane_charges = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "mage",
              spec = "_arcane",
              spell_id = 36032,
              label = "Arcane Charges Aura",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "mage",
              spec_token = "_arcane"
            }
          }
        },
        arcane_missiles = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "mage",
                spec = "_arcane",
                spell_id = 7268,
                label = "ArcaneMissiles",
                flags = "core.SpellFlagChanneled | core.SpellFlagAPL",
                class_spell_mask = "MageSpellArcaneMissilesCast",
                spell_school = "SpellSchoolArcane",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "0",
                class_token = "mage",
                spec_token = "_arcane"
              },
              {
                class = "mage",
                spec = "_arcane",
                spell_id = 7268,
                label = "Arcane Missiles",
                class_spell_mask = "MageSpellArcaneMissilesTick",
                spell_school = "SpellSchoolArcane",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "arcane.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "mage",
                spec_token = "_arcane"
              }
            },
            aura = {
              class = "mage",
              spec = "_arcane",
              spell_id = 79683,
              label = "Arcane Missiles Proc",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "mage",
              spec_token = "_arcane"
            }
          }
        },
        arcane_barrage = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spec = "_arcane",
              spell_id = 44425,
              label = "Arcane Barrage",
              cooldown = {
                raw = "time.Second * 3",
                seconds = 3.0
              },
              flags = "SpellFlagAPL",
              class_spell_mask = "MageSpellArcaneBarrage",
              spell_school = "SpellSchoolArcane",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "arcane.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "mage",
              spec_token = "_arcane"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "mastery",
        "arcane_blast",
        "arcane_charges",
        "arcane_missiles",
        "arcane_barrage"
      },
      synthetic = true
    },
    WarriorProtectionSpells = {
      fields = {
        shield_block = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              spec = "protection",
              spell_id = 2565,
              label = "Shield Block",
              cooldown = {
                raw = "time.Millisecond * 1500",
                seconds = 1.5
              },
              flags = "core.SpellFlagAPL | core.SpellFlagHelpful",
              class_spell_mask = "SpellMaskShieldBlock",
              spell_school = "2",
              class_token = "warrior",
              spec_token = "protection"
            },
            aura = {
              class = "warrior",
              spec = "protection",
              spell_id = 2565,
              label = "Shield Block",
              duration = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              class_token = "warrior",
              spec_token = "protection"
            }
          }
        },
        ultimatum = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warrior",
              spec = "protection",
              spell_id = 122510,
              label = "Ultimatum",
              duration = {
                raw = "10 * time.Second",
                seconds = 10.0
              },
              class_token = "warrior",
              spec_token = "protection"
            }
          }
        },
        sword_and_board = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warrior",
              spec = "protection",
              spell_id = 50227,
              label = "Sword and Board",
              duration = {
                raw = "5 * time.Second",
                seconds = 5.0
              },
              class_token = "warrior",
              spec_token = "protection"
            }
          }
        },
        bastion_of_defense = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warrior",
              spec = "protection",
              spell_id = 84608,
              label = "Bastion of Defense",
              class_token = "warrior",
              spec_token = "protection"
            }
          }
        },
        unwavering_sentinel = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warrior",
              spec = "protection",
              spell_id = 29144,
              label = "Unwavering Sentinel",
              class_token = "warrior",
              spec_token = "protection"
            }
          }
        },
        revenge = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              spec = "protection",
              spell_id = 6572,
              label = "Revenge",
              cooldown = {
                raw = "time.Second * 9",
                seconds = 9.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              class_spell_mask = "SpellMaskRevenge",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              crit_multiplier = "war.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "5",
              class_token = "warrior",
              spec_token = "protection"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "shield_block",
        "ultimatum",
        "sword_and_board",
        "bastion_of_defense",
        "unwavering_sentinel",
        "revenge"
      },
      synthetic = true
    },
    WarriorDpsSpells = {
      fields = {
        single_minded_fury_or_titans_grip = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "warrior",
                spec = "dps",
                spell_id = 46917,
                label = "Titan's Grip",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "warrior",
                spec_token = "dps"
              },
              {
                class = "warrior",
                spec = "dps",
                spell_id = 81099,
                label = "Single-Minded Fury",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "warrior",
                spec_token = "dps"
              }
            }
          }
        },
        meat_cleaver = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warrior",
              spec = "dps",
              spell_id = 85739,
              label = "Meat Cleaver",
              duration = {
                raw = "10 * time.Second",
                seconds = 10.0
              },
              class_token = "warrior",
              spec_token = "dps"
            }
          }
        },
        bloodsurge = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warrior",
              spec = "dps",
              spell_id = 46916,
              label = "Bloodsurge",
              duration = {
                raw = "15 * time.Second",
                seconds = 15.0
              },
              class_token = "warrior",
              spec_token = "dps"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "single_minded_fury_or_titans_grip",
        "meat_cleaver",
        "bloodsurge"
      },
      synthetic = true
    },
    WarriorArmsSpells = {
      fields = {
        slam = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "warrior",
                spec = "_arms",
                spell_id = 1464,
                label = "Slam",
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
                class_spell_mask = "SpellMaskSlam",
                spell_school = "2",
                proc_mask = "ProcMaskMeleeMHSpecial",
                damage_multiplier = "2.75",
                crit_multiplier = "war.DefaultCritMultiplier()",
                threat_multiplier = "1",
                max_range = "5",
                class_token = "warrior",
                spec_token = "_arms"
              },
              {
                class = "warrior",
                spec = "_arms",
                spell_id = 1464,
                label = "Slam",
                flags = "core.SpellFlagIgnoreArmor | core.SpellFlagIgnoreModifiers | core.SpellFlagMeleeMetrics | core.SpellFlagPassiveSpell | core.SpellFlagNoOnCastComplete",
                class_spell_mask = "SpellMaskSweepingSlam",
                spell_school = "2",
                proc_mask = "2",
                damage_multiplier = "0.35",
                crit_multiplier = "war.DefaultCritMultiplier()",
                threat_multiplier = "1",
                class_token = "warrior",
                spec_token = "_arms"
              }
            }
          }
        },
        overpower = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              spec = "_arms",
              spell_id = 7384,
              label = "Overpower",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              class_spell_mask = "SpellMaskOverpower",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1.05 + 0.2",
              crit_multiplier = "war.DefaultCritMultiplier()",
              threat_multiplier = "1",
              max_range = "5",
              class_token = "warrior",
              spec_token = "_arms"
            }
          }
        },
        taste_for_blood = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warrior",
              spec = "_arms",
              spell_id = 60503,
              label = "Taste For Blood",
              duration = {
                raw = "12 * time.Second",
                seconds = 12.0
              },
              class_token = "warrior",
              spec_token = "_arms"
            }
          }
        },
        sudden_death = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "warrior",
                spec = "_arms",
                spell_id = 139958,
                label = "Sudden Execute",
                duration = {
                  raw = "10 * time.Second",
                  seconds = 10.0
                },
                class_token = "warrior",
                spec_token = "_arms"
              },
              {
                class = "warrior",
                spec = "_arms",
                spell_id = 52437,
                label = "Sudden Death",
                duration = {
                  raw = "2 * time.Second",
                  seconds = 2.0
                },
                class_token = "warrior",
                spec_token = "_arms"
              }
            }
          }
        },
        seasoned_soldier = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warrior",
              spec = "_arms",
              spell_id = 12712,
              label = "Seasoned Soldier",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "warrior",
              spec_token = "_arms"
            }
          }
        },
        mastery = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              spec = "_arms",
              spell_id = 76858,
              label = "Mastery",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial | ProcMaskMeleeOHSpecial",
              damage_multiplier = "0.55",
              crit_multiplier = "war.DefaultCritMultiplier()",
              threat_multiplier = "1",
              class_token = "warrior",
              spec_token = "_arms"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "slam",
        "overpower",
        "taste_for_blood",
        "sudden_death",
        "seasoned_soldier",
        "mastery"
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
    Drums = {
      DrumsUnknown = 0,
      DrumsOfBattle = 1,
      DrumsOfRestoration = 2,
      DrumsOfWar = 3
    },
    StrengthOfEarthType = {
      None = 0,
      Basic = 1,
      CycloneBonus = 2,
      EnhancingTotems = 3,
      EnhancingAndCyclone = 4
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
    UnitType = {
      Unknown = 0,
      Player = 1,
      Target = 2,
      Pet = 3,
      Self = 4,
      CurrentTarget = 5,
      AllPlayers = 6,
      AllTargets = 7,
      PreviousTarget = 8,
      NextTarget = 9
    },
    Type = {
      Unknown = 0,
      Player = 1,
      Target = 2,
      Pet = 3,
      Self = 4,
      CurrentTarget = 5,
      AllPlayers = 6,
      AllTargets = 7,
      PreviousTarget = 8,
      NextTarget = 9
    },
    OtherAction = {
      OtherActionNone = 0,
      OtherActionWait = 1,
      OtherActionManaRegen = 2,
      OtherActionEnergyRegen = 5,
      OtherActionFocusRegen = 6,
      OtherActionManaGain = 10,
      OtherActionRageGain = 11,
      OtherActionAttack = 3,
      OtherActionShoot = 4,
      OtherActionPet = 7,
      OtherActionRefund = 8,
      OtherActionDamageTaken = 9,
      OtherActionHealingModel = 12,
      OtherActionPotion = 17,
      OtherActionMove = 20,
      OtherActionPrepull = 21,
      OtherActionEncounterStart = 22
    },
    Spec = {
      SpecUnknown = 0,
      SpecBalanceDruid = 1,
      SpecFeralCatDruid = 2,
      SpecFeralBearDruid = 3,
      SpecRestorationDruid = 4,
      SpecHunter = 5,
      SpecMage = 6,
      SpecHolyPaladin = 7,
      SpecProtectionPaladin = 8,
      SpecRetributionPaladin = 9,
      SpecDisciplinePriest = 10,
      SpecHolyPriest = 11,
      SpecShadowPriest = 12,
      SpecRogue = 13,
      SpecElementalShaman = 14,
      SpecEnhancementShaman = 15,
      SpecRestorationShaman = 16,
      SpecWarlock = 17,
      SpecDPSWarrior = 18,
      SpecProtectionWarrior = 19
    },
    Race = {
      RaceUnknown = 0,
      RaceBloodElf = 1,
      RaceDraenei = 2,
      RaceDwarf = 3,
      RaceGnome = 4,
      RaceHuman = 5,
      RaceNightElf = 6,
      RaceOrc = 7,
      RaceTauren = 8,
      RaceTroll = 9,
      RaceUndead = 10
    },
    Faction = {
      Unknown = 0,
      Alliance = 1,
      Horde = 2
    },
    Class = {
      ClassUnknown = 0,
      ClassWarrior = 1,
      ClassPaladin = 2,
      ClassHunter = 3,
      ClassRogue = 4,
      ClassPriest = 5,
      ClassShaman = 7,
      ClassMage = 8,
      ClassWarlock = 9,
      ClassDruid = 11,
      ClassExtra1 = 12,
      ClassExtra2 = 13,
      ClassExtra3 = 14,
      ClassExtra4 = 15,
      ClassExtra5 = 16,
      ClassExtra6 = 17
    },
    Profession = {
      ProfessionUnknown = 0,
      Alchemy = 1,
      Blacksmithing = 2,
      Enchanting = 3,
      Engineering = 4,
      Herbalism = 5,
      Inscription = 6,
      Jewelcrafting = 7,
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
      StatSpellPower = 4,
      StatHealingPower = 5,
      StatSpellDamage = 6,
      StatArcanePower = 7,
      StatFirePower = 8,
      StatFrostPower = 9,
      StatHolyPower = 10,
      StatNaturePower = 11,
      StatShadowPower = 12,
      StatSpellHitRating = 13,
      StatSpellCritRating = 14,
      StatSpellHasteRating = 15,
      StatSpellPenetration = 16,
      StatSpirit = 17,
      StatAttackPower = 18,
      StatRangedAttackPower = 19,
      StatFeralAttackPower = 20,
      StatMeleeHitRating = 21,
      StatMeleeCritRating = 22,
      StatMeleeHasteRating = 23,
      StatArmorPenetration = 24,
      StatExpertiseRating = 25,
      StatAllPhysHitRating = 26,
      StatAllPhysCritRating = 27,
      StatAllPhysHasteRating = 28,
      StatDefenseRating = 29,
      StatBlockRating = 30,
      StatBlockValue = 31,
      StatDodgeRating = 32,
      StatParryRating = 33,
      StatResilienceRating = 34,
      StatArmor = 35,
      StatBonusArmor = 36,
      StatHealth = 37,
      StatMana = 38,
      StatMP5 = 39,
      StatArcaneResistance = 40,
      StatFireResistance = 41,
      StatFrostResistance = 42,
      StatNatureResistance = 43,
      StatShadowResistance = 44
    },
    PseudoStat = {
      PseudoStatMainHandDps = 0,
      PseudoStatOffHandDps = 1,
      PseudoStatRangedDps = 2,
      PseudoStatBlockValueMultiplier = 3,
      PseudoStatDodgePercent = 4,
      PseudoStatParryPercent = 5,
      BonusPhysicalDamage = 6,
      PseudoStatSchoolHitArcane = 7,
      PseudoStatSchoolHitFire = 8,
      PseudoStatSchoolHitFrost = 9,
      PseudoStatSchoolHitHoly = 10,
      PseudoStatSchoolHitNature = 11,
      PseudoStatSchoolHitShadow = 12,
      PseudoStatMeleeHitPercent = 13,
      PseudoStatSpellHitPercent = 14,
      PseudoStatMeleeCritPercent = 15,
      PseudoStatSpellCritPercent = 16,
      PseudoStatBlockPercent = 17,
      PseudoStatMeleeSpeedMultiplier = 18,
      PseudoStatRangedSpeedMultiplier = 19,
      PseudoStatCastSpeedMultiplier = 20,
      PseudoStatMeleeHastePercent = 21,
      PseudoStatRangedHastePercent = 22,
      PseudoStatSpellHastePercent = 23,
      PseudoStatBlockValuePerStrength = 24,
      PseudoStatRangedHitPercent = 25,
      PseudoStatRangedCritPercent = 26
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
      RangedWeaponTypeThrown = 4,
      RangedWeaponTypeWand = 5,
      RangedWeaponTypeIdol = 6,
      RangedWeaponTypeLibram = 7,
      RangedWeaponTypeTotem = 8,
      RangedWeaponTypeSigil = 9
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
    GemColor = {
      GemColorUnknown = 0,
      GemColorMeta = 1,
      GemColorRed = 2,
      GemColorBlue = 3,
      GemColorYellow = 4,
      GemColorGreen = 5,
      GemColorOrange = 6,
      GemColorPurple = 7,
      GemColorPrismatic = 8
    },
    ConsumableType = {
      ConsumableTypeUnknown = 0,
      ConsumableTypePotion = 1,
      ConsumableTypeFlask = 2,
      ConsumableTypeFood = 3,
      ConsumableTypeScroll = 4,
      ConsumableTypeExplosive = 5,
      ConsumableTypeBattleElixir = 6,
      ConsumableTypeGuardianElixir = 7
    },
    EnchantType = {
      EnchantTypeNormal = 0,
      EnchantTypeTwoHand = 1,
      EnchantTypeShield = 2,
      EnchantTypeKit = 3,
      EnchantTypeStaff = 4,
      EnchantTypeOffHand = 5
    },
    RotationType = {
      UnknownType = 0,
      SingleTarget = 1,
      Aoe = 3,
      Custom = 2
    },
    LogLevel = {
      Information = 0,
      Warning = 1,
      Error = 2,
      Undefined = -1
    },
    Edition = {
      EDITION_UNKNOWN = 0,
      EDITION_LEGACY = 900,
      EDITION_PROTO2 = 998,
      EDITION_PROTO3 = 999,
      EDITION_2023 = 1000,
      EDITION_2024 = 1001,
      EDITION_1_TEST_ONLY = 1,
      EDITION_2_TEST_ONLY = 2,
      EDITION_99997_TEST_ONLY = 99997,
      EDITION_99998_TEST_ONLY = 99998,
      EDITION_99999_TEST_ONLY = 99999,
      EDITION_MAX = 2147483647
    },
    SymbolVisibility = {
      VISIBILITY_UNSET = 0,
      VISIBILITY_LOCAL = 1,
      VISIBILITY_EXPORT = 2
    },
    VerificationState = {
      DECLARATION = 0,
      UNVERIFIED = 1
    },
    Label = {
      LABEL_OPTIONAL = 1,
      LABEL_REPEATED = 3,
      LABEL_REQUIRED = 2
    },
    OptimizeMode = {
      SPEED = 1,
      CODE_SIZE = 2,
      LITE_RUNTIME = 3
    },
    CType = {
      STRING = 0,
      CORD = 1,
      STRING_PIECE = 2
    },
    JSType = {
      JS_NORMAL = 0,
      JS_STRING = 1,
      JS_NUMBER = 2
    },
    OptionRetention = {
      RETENTION_UNKNOWN = 0,
      RETENTION_RUNTIME = 1,
      RETENTION_SOURCE = 2
    },
    OptionTargetType = {
      TARGET_TYPE_UNKNOWN = 0,
      TARGET_TYPE_FILE = 1,
      TARGET_TYPE_EXTENSION_RANGE = 2,
      TARGET_TYPE_MESSAGE = 3,
      TARGET_TYPE_FIELD = 4,
      TARGET_TYPE_ONEOF = 5,
      TARGET_TYPE_ENUM = 6,
      TARGET_TYPE_ENUM_ENTRY = 7,
      TARGET_TYPE_SERVICE = 8,
      TARGET_TYPE_METHOD = 9
    },
    IdempotencyLevel = {
      IDEMPOTENCY_UNKNOWN = 0,
      NO_SIDE_EFFECTS = 1,
      IDEMPOTENT = 2
    },
    FieldPresence = {
      FIELD_PRESENCE_UNKNOWN = 0,
      EXPLICIT = 1,
      IMPLICIT = 2,
      LEGACY_REQUIRED = 3
    },
    EnumType = {
      ENUM_TYPE_UNKNOWN = 0,
      OPEN = 1,
      CLOSED = 2
    },
    RepeatedFieldEncoding = {
      REPEATED_FIELD_ENCODING_UNKNOWN = 0,
      PACKED = 1,
      EXPANDED = 2
    },
    Utf8Validation = {
      UTF8_VALIDATION_UNKNOWN = 0,
      VERIFY = 2,
      NONE = 3
    },
    MessageEncoding = {
      MESSAGE_ENCODING_UNKNOWN = 0,
      LENGTH_PREFIXED = 1,
      DELIMITED = 2
    },
    JsonFormat = {
      JSON_FORMAT_UNKNOWN = 0,
      ALLOW = 1,
      LEGACY_BEST_EFFORT = 2
    },
    EnforceNamingStyle = {
      ENFORCE_NAMING_STYLE_UNKNOWN = 0,
      STYLE2024 = 1,
      STYLE_LEGACY = 2
    },
    DefaultSymbolVisibility = {
      DEFAULT_SYMBOL_VISIBILITY_UNKNOWN = 0,
      EXPORT_ALL = 1,
      EXPORT_TOP_LEVEL = 2,
      LOCAL_ALL = 3,
      STRICT = 4
    },
    Semantic = {
      NONE = 0,
      SET = 1,
      ALIAS = 2
    },
    EffectType = {
      EffectTypeUnknown = 0,
      EffectTypeHeal = 10,
      EffectTypeResourceGain = 30
    },
    ResourceType = {
      ResourceTypeNone = 0,
      ResourceTypeMana = 1,
      ResourceTypeEnergy = 2,
      ResourceTypeRage = 3,
      ResourceTypeFocus = 4,
      ResourceTypeComboPoints = 5,
      ResourceTypeHealth = 6,
      ResourceTypeGenericResource = 7
    },
    APLRotationType = {
      TypeUnknown = 0,
      TypeAuto = 1,
      TypeSimple = 2,
      TypeAPL = 3
    },
    SwapSet = {
      Unknown = 0,
      Main = 1,
      Swap1 = 2
    },
    AplType = {
      SingleTarget = 0,
      Aoe = 1
    },
    Strategy = {
      Caster = 0,
      Cat = 1,
      Hybrid = 2
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
      E35 = 3,
      E45 = 4,
      E90 = 5
    },
    APLValueEclipsePhase = {
      UnknownPhase = 0,
      NeutralPhase = 1,
      SolarPhase = 2,
      LunarPhase = 3
    },
    TotemType = {
      TypeUnknownTotem = 0,
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
      EarthElementalTotem = 1,
      TremorTotem = 2,
      EarthbindTotem = 3
    },
    AirTotem = {
      NoAirTotem = 0,
      StormlashTotem = 1,
      GroundingTotem = 2,
      CapacitorTotem = 3,
      SpiritLinkTotem = 4
    },
    FireTotem = {
      NoFireTotem = 0,
      MagmaTotem = 1,
      SearingTotem = 2,
      FireElementalTotem = 3
    },
    WaterTotem = {
      NoWaterTotem = 0,
      HealingTideTotem = 1,
      HealingStreamTotem = 2,
      ManaTideTotem = 3
    },
    ShamanShield = {
      NoShield = 0,
      WaterShield = 1,
      LightningShield = 2
    },
    ShamanImbue = {
      NoImbue = 0,
      WindfuryWeapon = 1,
      FlametongueWeapon = 2,
      FrostbrandWeapon = 3,
      EarthlivingWeapon = 4,
      RockbiterWeapon = 5
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
      HealingSurge = 2,
      ChainHeal = 3
    },
    WarriorSyncType = {
      WarriorNoSync = 0,
      WarriorSyncMainhandOffhandSwings = 1
    },
    MageArmor = {
      MageArmorNone = 0,
      MageArmorMageArmor = 1,
      MageArmorFrostArmor = 2,
      MageArmorMoltenArmor = 3
    },
    PetType = {
      PetNone = 0,
      Bat = 1,
      Bear = 2,
      BirdOfPrey = 3,
      Boar = 4,
      CarrionBird = 5,
      Cat = 6,
      Chimaera = 7,
      CoreHound = 8,
      Crab = 9,
      Crocolisk = 10,
      Devilsaur = 11,
      Dragonhawk = 12,
      Gorilla = 13,
      Hyena = 14,
      Moth = 15,
      NetherRay = 16,
      Raptor = 17,
      Ravager = 18,
      Rhino = 19,
      Scorpid = 20,
      Serpent = 21,
      Silithid = 22,
      Spider = 23,
      SpiritBeast = 24,
      SporeBat = 25,
      Tallstrider = 26,
      Turtle = 27,
      WarpStalker = 28,
      Wasp = 29,
      WindSerpent = 30,
      Wolf = 31,
      Worm = 32,
      ShaleSpider = 33,
      Fox = 34,
      Goat = 35,
      Porcupine = 36,
      Monkey = 37,
      Basilisk = 38,
      Crane = 39,
      Dog = 40,
      Beetle = 41,
      Quilen = 42,
      WaterStrider = 43
    },
    PetSpec = {
      Ferocity = 0,
      Tenacity = 1,
      Cunning = 2
    },
    HunterStingType = {
      NoSting = 0,
      ScorpidSting = 1,
      SerpentSting = 2
    },
    PoisonOptions = {
      NoPoison = 0,
      DeadlyPoison = 1,
      WoundPoison = 2
    },
    Summon = {
      NoSummon = 0,
      Imp = 1,
      Voidwalker = 2,
      Succubus = 3,
      Felhunter = 4,
      Felguard = 5
    },
    PaladinSeal = {
      Truth = 0,
      Justice = 1,
      Insight = 2,
      Righteousness = 3
    },
    Blessings = {
      BlessingUnknown = 0,
      BlessingOfKings = 1,
      BlessingOfMight = 2
    },
    Expansion = {
      ExpansionUnknown = 0,
      ExpansionVanilla = 1,
      ExpansionTbc = 2,
      ExpansionWotlk = 3,
      ExpansionCata = 4,
      ExpansionMop = 5
    },
    FactionRestriction = {
      FACTION_RESTRICTION_UNSPECIFIED = 0,
      FACTION_RESTRICTION_ALLIANCE_ONLY = 1,
      FACTION_RESTRICTION_HORDE_ONLY = 2
    },
    DungeonDifficulty = {
      DifficultyUnknown = 0,
      DifficultyNormal = 1,
      DifficultyHeroic = 2,
      DifficultyTitanRuneAlpha = 7,
      DifficultyTitanRuneBeta = 8,
      DifficultyCelestial = 10,
      DifficultyRaid10 = 3,
      DifficultyRaid10H = 4,
      DifficultyRaid25 = 5,
      DifficultyRaid25H = 6,
      DifficultyRaid25RF = 9,
      DifficultyRaidFlex = 11,
      DifficultyVendor = 12
    },
    RepFaction = {
      RepFactionUnknown = 0,
      RepFactionTheEarthenRing = 1135,
      RepFactionGuardiansOfHyjal = 1158,
      RepFactionTherazane = 1171,
      RepFactionDragonmawClan = 1172,
      RepFactionRamkahen = 1173,
      RepFactionWildhammerClan = 1174,
      RepFactionBaradinsWardens = 1177,
      RepFactionHellscreamsReach = 1178,
      RepFactionAvengersOfHyjal = 1204,
      RepFactionGoldenLotus = 1269,
      RepFactionTheTillers = 1272,
      RepFactionShadoPan = 1270,
      RepFactionShadoPanAssault = 1435,
      RepFactionTheBrewmasters = 1351,
      RepFactionTheKlaxxi = 1337,
      RepFactionTheAugustCelestials = 1341,
      RepFactionTheAnglers = 1302,
      RepFactionEmperorShaohao = 1492,
      RepFactionSunreaverOnslaught = 1388,
      RepFactionKirinTorOffensive = 1387,
      RepFactionDominanceOffensive = 1375,
      RepFactionOrderOfTheCloudSerpent = 1271,
      RepFactionShangXisAcademy = 1216,
      RepFactionTheLorewalkers = 1345,
      RepFactionTheBlackPrince = 1359,
      RepFactionForestHozen = 1228,
      RepFactionPearlfinJinyu = 1242,
      RepFactionHozen = 1243,
      RepFactionOperationShieldwall = 1376
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
      SourceReputation = 3,
      SourceSoldBy = 11,
      SourcePvp = 4,
      SourceDungeon = 5,
      SourceDungeonH = 6,
      SourceRaid = 7,
      SourceRaidH = 8,
      SourceRaidRF = 9,
      SourceRaidFlex = 10
    },
    RaidFilterOption = {
      RaidUnknown = 0,
      RaidMogushanVaults = 1,
      RaidHeartOfFear = 2,
      RaidTerraceOfEndlessSpring = 3,
      RaidThroneOfThunder = 4,
      RaidSiegeOfOrgrimmar = 5
    },
    StatCapType = {
      TypeUnknown = 0,
      TypeHardCap = 1,
      TypeSoftCap = 2,
      TypeThreshold = 3
    },
    ErrorOutcomeType = {
      ErrorOutcomeError = 0,
      ErrorOutcomeAborted = 1
    },
    SimType = {
      SimTypeUnknown = 0,
      SimTypeIndividual = 1,
      SimTypeRaid = 2
    }
  },
  consumables = {

  },
  buffs_debuffs = {

  },
  enum_name_collisions = {
    Type = {
      "google.protobuf.FieldDescriptorProto.Type",
      "proto.APLRotation.Type",
      "proto.UnitReference.Type"
    }
  }
}
