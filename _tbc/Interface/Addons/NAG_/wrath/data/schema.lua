-- AST prototype schema for wrath
local _, ns = ...
ns.protoSchema = ns.protoSchema or {}
ns.protoSchema['wrath'] = {
  version = "wrath",
  messages = {
    PriestTalents = {
      fields = {
        unbreakable_will = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        twin_disciplines = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        silent_resolve = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        improved_inner_fire = {
          id = 4,
          type = "int32",
          label = "optional"
        },
        improved_power_word_fortitude = {
          id = 5,
          type = "int32",
          label = "optional"
        },
        martyrdom = {
          id = 6,
          type = "int32",
          label = "optional"
        },
        meditation = {
          id = 7,
          type = "int32",
          label = "optional"
        },
        inner_focus = {
          id = 8,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "priest",
              spell_id = 14751,
              label = "Inner Focus",
              cooldown = {
                raw = "time.Minute*3 * (1 - .1*priest.Talents.Aspiration)"
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
        improved_power_word_shield = {
          id = 9,
          type = "int32",
          label = "optional"
        },
        absolution = {
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
        reflective_shield = {
          id = 13,
          type = "int32",
          label = "optional"
        },
        mental_strength = {
          id = 14,
          type = "int32",
          label = "optional"
        },
        soul_warding = {
          id = 15,
          type = "bool",
          label = "optional"
        },
        focused_power = {
          id = 16,
          type = "int32",
          label = "optional"
        },
        enlightenment = {
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
            },
            spell = {
              class = "priest",
              spell_id = 10060,
              label = "Power Infusion",
              cooldown = {
                raw = "core.PowerInfusionCD * (1 - .1*priest.Talents.Aspiration)"
              },
              major_cooldown = {
                type = "core.CooldownTypeMana",
                priority = "core.CooldownPriorityBloodlust"
              },
              flags = "SpellFlagHelpful",
              class_token = "priest"
            }
          }
        },
        improved_flash_heal = {
          id = 20,
          type = "int32",
          label = "optional"
        },
        renewed_hope = {
          id = 21,
          type = "int32",
          label = "optional",
          _metadata = {
            export = "RenewedHope",
            field_alias = "renewedHope",
            ids = {
              spell = {
                57472
              }
            }
          }
        },
        rapture = {
          id = 22,
          type = "int32",
          label = "optional"
        },
        aspiration = {
          id = 23,
          type = "int32",
          label = "optional"
        },
        divine_aegis = {
          id = 24,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "priest",
              label = "Divine Aegis Talent",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "priest"
            },
            spell = {
              class = "priest",
              spell_id = 47515,
              label = "Divine Aegis",
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagHelpful",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskSpellHealing",
              damage_multiplier = "1 * (0.1 * float64(priest.Talents.DivineAegis)) * core.TernaryFloat64(priest.HasSetBonus(ItemSetZabrasRaiment, 4), 1.1, 1)",
              threat_multiplier = "1",
              class_token = "priest"
            }
          }
        },
        pain_suppression = {
          id = 25,
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
        grace = {
          id = 26,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "priest",
                label = "Grace Talent",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "priest"
              },
              {
                class = "priest",
                spell_id = 47517,
                label = "Grace",
                label_raw = [["Grace" + strconv.Itoa(int(priest.Index))]],
                duration = {
                  raw = "time.Second * 15",
                  seconds = 15.0
                },
                class_token = "priest"
              }
            }
          }
        },
        borrowed_time = {
          id = 27,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "priest",
                label = "Borrwed Time Talent",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "priest"
              },
              {
                class = "priest",
                spell_id = 52800,
                label = "Borrowed Time",
                duration = {
                  raw = "time.Second * 6",
                  seconds = 6.0
                },
                class_token = "priest"
              }
            }
          }
        },
        penance = {
          id = 28,
          type = "bool",
          label = "optional"
        },
        healing_focus = {
          id = 29,
          type = "int32",
          label = "optional"
        },
        improved_renew = {
          id = 30,
          type = "int32",
          label = "optional"
        },
        holy_specialization = {
          id = 31,
          type = "int32",
          label = "optional"
        },
        spell_warding = {
          id = 32,
          type = "int32",
          label = "optional"
        },
        divine_fury = {
          id = 33,
          type = "int32",
          label = "optional"
        },
        desperate_prayer = {
          id = 34,
          type = "bool",
          label = "optional"
        },
        blessed_recovery = {
          id = 35,
          type = "int32",
          label = "optional"
        },
        inspiration = {
          id = 36,
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
          id = 37,
          type = "int32",
          label = "optional"
        },
        improved_healing = {
          id = 38,
          type = "int32",
          label = "optional"
        },
        searing_light = {
          id = 39,
          type = "int32",
          label = "optional"
        },
        healing_prayers = {
          id = 40,
          type = "int32",
          label = "optional"
        },
        spirit_of_redemption = {
          id = 41,
          type = "bool",
          label = "optional"
        },
        spiritual_guidance = {
          id = 42,
          type = "int32",
          label = "optional"
        },
        surge_of_light = {
          id = 43,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "priest",
                label = "Surge of Light",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "priest"
              },
              {
                class = "priest",
                spell_id = 33154,
                label = "Surge of Light Proc",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "priest"
              }
            }
          }
        },
        spiritual_healing = {
          id = 44,
          type = "int32",
          label = "optional"
        },
        holy_concentration = {
          id = 45,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "priest",
                label = "Holy Concentration Talent",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "priest"
              },
              {
                class = "priest",
                spell_id = 34860,
                label = "Holy Concentration",
                duration = {
                  raw = "time.Second * 8",
                  seconds = 8.0
                },
                class_token = "priest"
              }
            }
          }
        },
        lightwell = {
          id = 46,
          type = "bool",
          label = "optional"
        },
        blessed_resilience = {
          id = 47,
          type = "int32",
          label = "optional"
        },
        body_and_soul = {
          id = 48,
          type = "int32",
          label = "optional"
        },
        empowered_healing = {
          id = 49,
          type = "int32",
          label = "optional"
        },
        serendipity = {
          id = 50,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "priest",
                label = "Serendipity Talent",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "priest"
              },
              {
                class = "priest",
                spell_id = 63737,
                label = "Serendipity",
                duration = {
                  raw = "time.Second * 20",
                  seconds = 20.0
                },
                class_token = "priest"
              }
            }
          }
        },
        empowered_renew = {
          id = 51,
          type = "int32",
          label = "optional"
        },
        circle_of_healing = {
          id = 52,
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
              damage_multiplier = "1 * (1 + .02*float64(priest.Talents.SpiritualHealing)) * (1 + .01*float64(priest.Talents.BlessedResilience)) * (1 + .02*float64(priest.Talents.FocusedPower)) * (1 + .02*float64(priest.Talents.DivineProvidence)) * core.TernaryFloat64(priest.HasSetBonus(ItemSetCrimsonAcolytesRaiment, 4), 1.1, 1)",
              crit_multiplier = "priest.DefaultHealingCritMultiplier()",
              threat_multiplier = "1 - []float64{0, .07, .14, .20}[priest.Talents.SilentResolve]",
              class_token = "priest"
            }
          }
        },
        test_of_faith = {
          id = 53,
          type = "int32",
          label = "optional"
        },
        divine_providence = {
          id = 54,
          type = "int32",
          label = "optional"
        },
        guardian_spirit = {
          id = 55,
          type = "bool",
          label = "optional",
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
        spirit_tap = {
          id = 56,
          type = "int32",
          label = "optional"
        },
        improved_spirit_tap = {
          id = 57,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "priest",
              spell_id = 59000,
              label = "Improved Spirit Tap",
              duration = {
                raw = "time.Second * 8",
                seconds = 8.0
              },
              class_token = "priest"
            }
          }
        },
        darkness = {
          id = 58,
          type = "int32",
          label = "optional"
        },
        shadow_affinity = {
          id = 59,
          type = "int32",
          label = "optional"
        },
        improved_shadow_word_pain = {
          id = 60,
          type = "int32",
          label = "optional"
        },
        shadow_focus = {
          id = 61,
          type = "int32",
          label = "optional"
        },
        improved_psychic_scream = {
          id = 62,
          type = "int32",
          label = "optional"
        },
        improved_mind_blast = {
          id = 63,
          type = "int32",
          label = "optional"
        },
        mind_flay = {
          id = 64,
          type = "bool",
          label = "optional"
        },
        veiled_shadows = {
          id = 65,
          type = "int32",
          label = "optional"
        },
        shadow_reach = {
          id = 66,
          type = "int32",
          label = "optional"
        },
        shadow_weaving = {
          id = 67,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "priest",
              spell_id = 15258,
              label = "Shadow Weaving",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "priest"
            }
          }
        },
        silence = {
          id = 68,
          type = "bool",
          label = "optional"
        },
        vampiric_embrace = {
          id = 69,
          type = "bool",
          label = "optional"
        },
        improved_vampiric_embrace = {
          id = 70,
          type = "int32",
          label = "optional"
        },
        focused_mind = {
          id = 71,
          type = "int32",
          label = "optional"
        },
        mind_melt = {
          id = 72,
          type = "int32",
          label = "optional"
        },
        improved_devouring_plague = {
          id = 73,
          type = "int32",
          label = "optional"
        },
        shadowform = {
          id = 74,
          type = "bool",
          label = "optional"
        },
        shadow_power = {
          id = 75,
          type = "int32",
          label = "optional"
        },
        improved_shadowform = {
          id = 76,
          type = "int32",
          label = "optional"
        },
        misery = {
          id = 77,
          type = "int32",
          label = "optional",
          _metadata = {
            export = "Misery",
            field_alias = "misery",
            ids = {
              spell = {
                33198
              }
            },
            aura = {
              {
                class = "core",
                spell_id = 33198,
                label = "Misery",
                duration = {
                  raw = "time.Second * 24",
                  seconds = 24.0
                },
                class_token = "core"
              },
              {
                class = "priest",
                label = "Priest Shadow Effects",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "priest"
              }
            }
          }
        },
        psychic_horror = {
          id = 78,
          type = "bool",
          label = "optional"
        },
        vampiric_touch = {
          id = 79,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "VampiricTouch",
            field_alias = "vampiricTouch",
            ids = {
              spell = {
                48160
              }
            },
            spell = {
              class = "priest",
              spell_id = 48160,
              label = "VampiricTouch",
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1 + float64(priest.Talents.Darkness)*0.02",
              crit_multiplier = "priest.SpellCritMultiplier(1, 1)",
              threat_multiplier = "1 - 0.08*float64(priest.Talents.ShadowAffinity)",
              class_token = "priest"
            }
          }
        },
        pain_and_suffering = {
          id = 80,
          type = "int32",
          label = "optional"
        },
        twisted_faith = {
          id = 81,
          type = "int32",
          label = "optional"
        },
        dispersion = {
          id = 82,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "priest",
              spell_id = 47585,
              label = "Dispersion",
              cooldown = {
                raw = "time.Second*120 - time.Second*glyphReduction"
              },
              major_cooldown = {
                type = "core.CooldownTypeMana",
                priority = "1"
              },
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
        }
      },
      oneofs = {

      },
      field_order = {
        "unbreakable_will",
        "twin_disciplines",
        "silent_resolve",
        "improved_inner_fire",
        "improved_power_word_fortitude",
        "martyrdom",
        "meditation",
        "inner_focus",
        "improved_power_word_shield",
        "absolution",
        "mental_agility",
        "improved_mana_burn",
        "reflective_shield",
        "mental_strength",
        "soul_warding",
        "focused_power",
        "enlightenment",
        "focused_will",
        "power_infusion",
        "improved_flash_heal",
        "renewed_hope",
        "rapture",
        "aspiration",
        "divine_aegis",
        "pain_suppression",
        "grace",
        "borrowed_time",
        "penance",
        "healing_focus",
        "improved_renew",
        "holy_specialization",
        "spell_warding",
        "divine_fury",
        "desperate_prayer",
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
        "body_and_soul",
        "empowered_healing",
        "serendipity",
        "empowered_renew",
        "circle_of_healing",
        "test_of_faith",
        "divine_providence",
        "guardian_spirit",
        "spirit_tap",
        "improved_spirit_tap",
        "darkness",
        "shadow_affinity",
        "improved_shadow_word_pain",
        "shadow_focus",
        "improved_psychic_scream",
        "improved_mind_blast",
        "mind_flay",
        "veiled_shadows",
        "shadow_reach",
        "shadow_weaving",
        "silence",
        "vampiric_embrace",
        "improved_vampiric_embrace",
        "focused_mind",
        "mind_melt",
        "improved_devouring_plague",
        "shadowform",
        "shadow_power",
        "improved_shadowform",
        "misery",
        "psychic_horror",
        "vampiric_touch",
        "pain_and_suffering",
        "twisted_faith",
        "dispersion"
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
        armor = {
          id = 2,
          type = "enum",
          label = "optional",
          enum_type = "Armor"
        },
        power_infusion_target = {
          id = 6,
          type = "message",
          label = "optional",
          message_type = "UnitReference"
        }
      },
      oneofs = {

      },
      field_order = {
        "armor",
        "power_infusion_target"
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
    SmitePriest = {
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
                48470
              }
            },
            extras = {
              imp_id = "ActionId.fromSpellId(17051)"
            }
          }
        },
        power_word_fortitude = {
          id = 2,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            export = "PowerWordFortitude",
            field_alias = "powerWordFortitude",
            ids = {
              spell = {
                48161
              }
            },
            extras = {
              imp_id = "ActionId.fromSpellId(14767)"
            }
          }
        },
        commanding_shout = {
          id = 3,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            export = "CommandingShout",
            field_alias = "commandingShout",
            ids = {
              spell = {
                47440
              }
            },
            extras = {
              imp_id = "ActionId.fromSpellId(12861)"
            },
            aura = {
              class = "core",
              spell_id = 47440,
              label = "Commanding Shout",
              duration = {
                raw = "time.Duration(float64(time.Minute*2)*(1+0.25*float64(boomingVoicePts))) + TernaryDuration(minorGlyph, 2*time.Minute, 0)"
              },
              class_token = "core"
            }
          }
        },
        blood_pact = {
          id = 4,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            export = "BloodPact",
            field_alias = "bloodPact",
            ids = {
              spell = {
                47982
              }
            },
            extras = {
              imp_id = "ActionId.fromSpellId(18696)"
            },
            aura = {
              class = "core",
              spell_id = 47982,
              label = "Blood Pact",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "core"
            }
          }
        },
        horn_of_winter = {
          id = 5,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "HornOfWinter",
            field_alias = "hornOfWinter",
            ids = {
              spell = {
                57623
              }
            },
            spell = {
              class = "deathknight",
              spell_id = 57623,
              label = "Horn Of Winter",
              cooldown = {
                raw = "20 * time.Second",
                seconds = 20.0
              },
              flags = "SpellFlagAPL",
              class_token = "deathknight"
            }
          }
        },
        strength_of_earth_totem = {
          id = 6,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            export = "StrengthOfEarthTotem",
            field_alias = "strengthOfEarthTotem",
            ids = {
              spell = {
                58643
              }
            },
            extras = {
              imp_id = "ActionId.fromSpellId(52456)"
            },
            spell = {
              class = "shaman",
              spell_id = 58643,
              label = "Strength Of Earth Totem",
              flags = "SpellFlagTotem | core.SpellFlagAPL",
              class_token = "shaman"
            }
          }
        },
        arcane_brilliance = {
          id = 7,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "ArcaneBrilliance",
            field_alias = "arcaneBrilliance",
            ids = {
              spell = {
                43002
              }
            }
          }
        },
        fel_intelligence = {
          id = 8,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            export = "FelIntelligence",
            field_alias = "felIntelligence",
            ids = {
              spell = {
                57567
              }
            },
            extras = {
              imp_id = "ActionId.fromSpellId(54038)"
            }
          }
        },
        divine_spirit = {
          id = 9,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "DivineSpirit",
            field_alias = "divineSpirit",
            ids = {
              spell = {
                48073
              }
            }
          }
        },
        battle_shout = {
          id = 10,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            export = "BattleShout",
            field_alias = "battleShout",
            ids = {
              spell = {
                47436
              }
            },
            extras = {
              imp_id = "ActionId.fromSpellId(12861)"
            },
            aura = {
              class = "core",
              spell_id = 47436,
              label = "Battle Shout",
              duration = {
                raw = "time.Duration(float64(time.Minute*2)*(1+0.25*float64(boomingVoicePts))) + TernaryDuration(minorGlyph, 2*time.Minute, 0)"
              },
              class_token = "core"
            }
          }
        },
        trueshot_aura = {
          id = 11,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "TrueshotAura",
            field_alias = "trueshotAura",
            ids = {
              spell = {
                19506
              }
            }
          }
        },
        unleashed_rage = {
          id = 12,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "UnleashedRage",
            field_alias = "unleashedRage",
            ids = {
              spell = {
                30809
              }
            }
          }
        },
        abominations_might = {
          id = 13,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "AbominationsMight",
            field_alias = "abominationsMight",
            ids = {
              spell = {
                53138
              }
            }
          }
        },
        leader_of_the_pack = {
          id = 14,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            export = "LeaderOfThePack",
            field_alias = "leaderOfThePack",
            ids = {
              spell = {
                17007
              }
            },
            extras = {
              imp_id = "ActionId.fromSpellId(34300)"
            }
          }
        },
        rampage = {
          id = 15,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "Rampage",
            field_alias = "rampage",
            ids = {
              spell = {
                29801
              }
            }
          }
        },
        icy_talons = {
          id = 16,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "IcyTalons",
            field_alias = "icyTalons",
            ids = {
              spell = {
                55610
              }
            }
          }
        },
        windfury_totem = {
          id = 17,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            export = "WindfuryTotem",
            field_alias = "windfuryTotem",
            ids = {
              spell = {
                65990
              }
            },
            extras = {
              imp_id = "ActionId.fromSpellId(29193)"
            },
            spell = {
              class = "shaman",
              spell_id = 8512,
              label = "Windfury Totem",
              flags = "SpellFlagTotem | core.SpellFlagAPL",
              class_token = "shaman"
            }
          }
        },
        totem_of_wrath = {
          id = 18,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "TotemOfWrath",
            field_alias = "totemOfWrath",
            ids = {
              spell = {
                30706
              }
            },
            aura = {
              class = "core",
              spell_id = 57722,
              label = "Totem of Wrath",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "core"
            },
            ["function"] = "TotemOfWrathDebuff",
            spell_id = 30708,
            tags = {
              "raid"
            },
            extras = {
              functions = {
                "TotemOfWrathDebuff"
              }
            }
          }
        },
        flametongue_totem = {
          id = 19,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "FlametongueTotem",
            field_alias = "flametongueTotem",
            ids = {
              spell = {
                58656
              }
            },
            spell = {
              class = "shaman",
              spell_id = 58656,
              label = "Flametongue Totem",
              flags = "SpellFlagTotem | core.SpellFlagAPL",
              class_token = "shaman"
            },
            aura = {
              class = "core",
              spell_id = 58656,
              label = "Flametongue Totem",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "core"
            },
            ["function"] = "FlametongueTotemAura",
            label = "Flametongue Totem",
            spell_id = 58656,
            tags = {
              "raid"
            },
            extras = {
              functions = {
                "FlametongueTotemAura"
              }
            }
          }
        },
        demonic_pact_sp = {
          id = 44,
          type = "int32",
          label = "optional",
          _metadata = {
            export = "DemonicPactSp",
            field_alias = "demonicPactSp",
            ids = {
              spell = {
                47240
              }
            },
            num_states = 2000,
            extras = {
              multiplier = "20"
            }
          }
        },
        swift_retribution = {
          id = 21,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "SwiftRetribution",
            field_alias = "swiftRetribution",
            ids = {
              spell = {
                53648
              }
            }
          }
        },
        moonkin_aura = {
          id = 22,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            export = "MoonkinAura",
            field_alias = "moonkinAura",
            ids = {
              spell = {
                24907
              }
            },
            extras = {
              imp_id = "ActionId.fromSpellId(48396)"
            }
          }
        },
        elemental_oath = {
          id = 23,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "ElementalOath",
            field_alias = "elementalOath",
            ids = {
              spell = {
                51470
              }
            }
          }
        },
        wrath_of_air_totem = {
          id = 24,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "WrathOfAirTotem",
            field_alias = "wrathOfAirTotem",
            ids = {
              spell = {
                3738
              }
            },
            spell = {
              class = "shaman",
              spell_id = 3738,
              label = "Wrath Of Air Totem",
              flags = "SpellFlagTotem | core.SpellFlagAPL",
              class_token = "shaman"
            }
          }
        },
        ferocious_inspiration = {
          id = 25,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "FerociousInspiration",
            field_alias = "ferociousInspiration",
            ids = {
              spell = {
                34460
              }
            }
          }
        },
        sanctified_retribution = {
          id = 26,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "SanctifiedRetribution",
            field_alias = "sanctifiedRetribution",
            ids = {
              spell = {
                31869
              }
            },
            ["function"] = "RetributionAura",
            label = "Retribution Aura",
            spell_id = 54043,
            tags = {
              "raid"
            },
            extras = {
              functions = {
                "RetributionAura"
              }
            }
          }
        },
        arcane_empowerment = {
          id = 27,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "ArcaneEmpowerment",
            field_alias = "arcaneEmpowerment",
            ids = {
              spell = {
                31583
              }
            }
          }
        },
        mana_spring_totem = {
          id = 28,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            export = "ManaSpringTotem",
            field_alias = "manaSpringTotem",
            ids = {
              spell = {
                58774
              }
            },
            extras = {
              imp_id = "ActionId.fromSpellId(16206)"
            },
            spell = {
              class = "shaman",
              spell_id = 58774,
              label = "Mana Spring Totem",
              flags = "SpellFlagTotem | core.SpellFlagAPL",
              class_token = "shaman"
            }
          }
        },
        shadow_protection = {
          id = 33,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "ShadowProtection",
            field_alias = "shadowProtection",
            ids = {
              spell = {
                48170
              }
            }
          }
        },
        nature_resistance_totem = {
          id = 45,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "NatureResistanceTotem",
            field_alias = "natureResistanceTotem",
            ids = {
              spell = {
                58749
              }
            }
          }
        },
        aspect_of_the_wild = {
          id = 46,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "AspectOfTheWild",
            field_alias = "aspectOfTheWild",
            ids = {
              spell = {
                49071
              }
            }
          }
        },
        frost_resistance_aura = {
          id = 47,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "FrostResistanceAura",
            field_alias = "frostResistanceAura",
            ids = {
              spell = {
                48945
              }
            }
          }
        },
        frost_resistance_totem = {
          id = 48,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "FrostResistanceTotem",
            field_alias = "frostResistanceTotem",
            ids = {
              spell = {
                58745
              }
            }
          }
        },
        bloodlust = {
          id = 29,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              {
                class = "shaman",
                label = "Bloodlust",
                cooldown = {
                  raw = "time.Minute * 10",
                  seconds = 600.0
                },
                flags = "SpellFlagAPL",
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
            },
            category = "HEROISM",
            ["function"] = "registerBloodlustCD",
            tags = {
              "raid"
            },
            extras = {
              functions = {
                "registerBloodlustCD"
              }
            }
          }
        },
        thorns = {
          id = 30,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            aura = {
              class = "core",
              spell_id = 53307,
              label = "Thorns",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "core"
            },
            spell = {
              class = "core",
              spell_id = 53307,
              label = "Thorns",
              flags = "SpellFlagBinary",
              spell_school = "SpellSchoolNature",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "core"
            }
          }
        },
        devotion_aura = {
          id = 31,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            export = "DevotionAura",
            field_alias = "devotionAura",
            ids = {
              spell = {
                48942
              }
            },
            extras = {
              imp_id = "ActionId.fromSpellId(20140)"
            }
          }
        },
        stoneskin_totem = {
          id = 42,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            export = "StoneskinTotem",
            field_alias = "stoneskinTotem",
            ids = {
              spell = {
                58753
              }
            },
            extras = {
              imp_id = "ActionId.fromSpellId(16293)"
            },
            spell = {
              class = "shaman",
              spell_id = 58753,
              label = "Stoneskin Totem",
              flags = "SpellFlagTotem | core.SpellFlagAPL",
              class_token = "shaman"
            }
          }
        },
        retribution_aura = {
          id = 32,
          type = "bool",
          label = "optional",
          _metadata = {
            ["function"] = "RetributionAura",
            label = "Retribution Aura",
            spell_id = 54043,
            tags = {
              "raid"
            },
            extras = {
              functions = {
                "RetributionAura"
              }
            }
          }
        },
        strength_of_wrynn = {
          id = 49,
          type = "bool",
          label = "optional"
        },
        drums_of_forgotten_kings = {
          id = 34,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "DrumsOfForgottenKings",
            field_alias = "drumsOfForgottenKings",
            ids = {
              item = {
                49633
              }
            }
          }
        },
        drums_of_the_wild = {
          id = 35,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "DrumsOfTheWild",
            field_alias = "drumsOfTheWild",
            ids = {
              item = {
                49634
              }
            }
          }
        },
        scroll_of_protection = {
          id = 36,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "ScrollOfProtection",
            field_alias = "scrollOfProtection",
            ids = {
              item = {
                43468
              }
            }
          }
        },
        scroll_of_stamina = {
          id = 37,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "ScrollOfStamina",
            field_alias = "scrollOfStamina",
            ids = {
              item = {
                37094
              }
            }
          }
        },
        scroll_of_strength = {
          id = 38,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "ScrollOfStrength",
            field_alias = "scrollOfStrength",
            ids = {
              item = {
                43466
              }
            }
          }
        },
        scroll_of_agility = {
          id = 39,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "ScrollOfAgility",
            field_alias = "scrollOfAgility",
            ids = {
              item = {
                43464
              }
            }
          }
        },
        scroll_of_intellect = {
          id = 40,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "ScrollOfIntellect",
            field_alias = "scrollOfIntellect",
            ids = {
              item = {
                37092
              }
            }
          }
        },
        scroll_of_spirit = {
          id = 41,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "ScrollOfSpirit",
            field_alias = "scrollOfSpirit",
            ids = {
              item = {
                37098
              }
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "gift_of_the_wild",
        "power_word_fortitude",
        "commanding_shout",
        "blood_pact",
        "horn_of_winter",
        "strength_of_earth_totem",
        "arcane_brilliance",
        "fel_intelligence",
        "divine_spirit",
        "battle_shout",
        "trueshot_aura",
        "unleashed_rage",
        "abominations_might",
        "leader_of_the_pack",
        "rampage",
        "icy_talons",
        "windfury_totem",
        "totem_of_wrath",
        "flametongue_totem",
        "demonic_pact_sp",
        "swift_retribution",
        "moonkin_aura",
        "elemental_oath",
        "wrath_of_air_totem",
        "ferocious_inspiration",
        "sanctified_retribution",
        "arcane_empowerment",
        "mana_spring_totem",
        "shadow_protection",
        "nature_resistance_totem",
        "aspect_of_the_wild",
        "frost_resistance_aura",
        "frost_resistance_totem",
        "bloodlust",
        "thorns",
        "devotion_aura",
        "stoneskin_totem",
        "retribution_aura",
        "strength_of_wrynn",
        "drums_of_forgotten_kings",
        "drums_of_the_wild",
        "scroll_of_protection",
        "scroll_of_stamina",
        "scroll_of_strength",
        "scroll_of_agility",
        "scroll_of_intellect",
        "scroll_of_spirit"
      },
      _metadata = {
        unholy_frenzy = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "UnholyFrenzy",
          ids = {
            spell = {
              49016
            }
          },
          stats = {
            "StatAttackPower",
            "StatRangedAttackPower"
          }
        },
        tricks_of_the_trade = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "TricksOfTheTrade",
          ids = {
            spell = {
              57933
            }
          },
          stats = {
            "StatAttackPower",
            "StatRangedAttackPower",
            "StatSpellPower"
          }
        },
        focus_magic = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "FocusMagic",
          ids = {
            spell = {
              54648
            }
          },
          stats = {
            "StatSpellCrit"
          }
        },
        power_infusion = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "PowerInfusion",
          ids = {
            spell = {
              10060
            }
          },
          stats = {
            "StatMP5",
            "StatSpellPower"
          }
        },
        innervate = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "Innervate",
          ids = {
            spell = {
              29166
            }
          },
          stats = {
            "StatMP5"
          }
        },
        thorns = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "Thorns",
          ids = {
            spell = {
              53307
            }
          },
          stats = {
            "StatArmor"
          }
        },
        eye_of_the_night = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "EyeOfTheNight",
          ids = {
            spell = {
              31033
            }
          },
          stats = {
            "StatSpellPower"
          }
        },
        heroic_presence = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "HeroicPresence",
          ids = {
            spell = {
              6562
            }
          },
          stats = {
            "StatMeleeHit",
            "StatSpellHit"
          }
        },
        chain_of_the_twilight_owl = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "ChainOfTheTwilightOwl",
          ids = {
            spell = {
              31035
            }
          },
          stats = {
            "StatMeleeCrit",
            "StatSpellCrit"
          }
        },
        braided_eternium_chain = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "BraidedEterniumChain",
          ids = {
            spell = {
              31025
            }
          },
          stats = {
            "StatMeleeCrit",
            "StatSpellCrit"
          }
        },
        retribution_aura = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "RetributionAura",
          ids = {
            spell = {
              54043
            }
          },
          stats = {
            "StatArmor"
          }
        },
        strength_of_wrynn = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "StrengthOfWrynn",
          ids = {
            spell = {
              73828
            }
          },
          stats = {
            "StatAttackPower",
            "StatRangedAttackPower",
            "StatSpellPower"
          }
        },
        strength_and_agility_buff = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "StrengthAndAgilityBuff",
          ids = {
            spell = {
              58643,
              57623
            },
            item = {
              43464,
              43466
            }
          },
          stats = {
            "StatAgility",
            "StatStrength"
          }
        },
        stamina_buff = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "StaminaBuff",
          ids = {
            spell = {
              48161
            },
            item = {
              37094
            }
          },
          stats = {
            "StatStamina"
          }
        },
        spirit_buff = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "SpiritBuff",
          ids = {
            spell = {
              48073,
              57567
            },
            item = {
              37098
            }
          },
          stats = {
            "StatSpirit"
          }
        },
        spell_power_buff = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "SpellPowerBuff",
          ids = {
            spell = {
              47240,
              57722,
              58656
            }
          },
          stats = {
            "StatSpellPower"
          }
        },
        spell_haste_buff = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "SpellHasteBuff",
          ids = {
            spell = {
              3738
            }
          },
          stats = {
            "StatSpellHaste"
          }
        },
        spell_crit_buff = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "SpellCritBuff",
          ids = {
            spell = {
              24907,
              51470
            }
          },
          stats = {
            "StatSpellCrit"
          }
        },
        resistance_buff = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "ResistanceBuff",
          ids = {
            spell = {
              48170,
              58749,
              49071,
              48945,
              58745
            }
          },
          stats = {
            "StatFrostResistance",
            "StatNatureResistance",
            "StatShadowResistance"
          }
        },
        melee_haste_buff = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "MeleeHasteBuff",
          ids = {
            spell = {
              55610,
              65990
            }
          },
          stats = {
            "StatMeleeHaste"
          }
        },
        melee_crit_buff = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "MeleeCritBuff",
          ids = {
            spell = {
              17007,
              29801
            }
          },
          stats = {
            "StatMeleeCrit"
          }
        },
        intellect_buff = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "IntellectBuff",
          ids = {
            spell = {
              43002,
              57567
            },
            item = {
              37092
            }
          },
          stats = {
            "StatIntellect"
          }
        },
        health_buff = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "HealthBuff",
          ids = {
            spell = {
              47440,
              47982
            }
          },
          stats = {
            "StatHealth"
          }
        },
        haste_percent_buff = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "HastePercentBuff",
          ids = {
            spell = {
              53648,
              48396
            }
          },
          stats = {
            "StatMeleeHaste",
            "StatSpellHaste"
          }
        },
        damage_percent_buff = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "DamagePercentBuff",
          ids = {
            spell = {
              31869,
              31583,
              34460
            }
          },
          stats = {
            "StatAttackPower",
            "StatRangedAttackPower",
            "StatSpellPower"
          }
        },
        bloodlust = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "Bloodlust",
          ids = {
            spell = {
              2825
            }
          },
          stats = {
            "StatMeleeHaste",
            "StatSpellHaste"
          }
        },
        attack_power_percent_buff = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "AttackPowerPercentBuff",
          ids = {
            spell = {
              53138,
              30809,
              19506
            }
          },
          stats = {
            "StatAttackPower",
            "StatRangedAttackPower"
          }
        },
        armor_buff = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "ArmorBuff",
          ids = {
            spell = {
              48942,
              58753
            },
            item = {
              43468
            }
          },
          stats = {
            "StatArmor"
          }
        },
        all_stats_buff = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "AllStatsBuff",
          ids = {
            spell = {
              48470
            },
            item = {
              49634
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
        braided_eternium_chain = {
          id = 3,
          type = "bool",
          label = "optional"
        },
        eye_of_the_night = {
          id = 4,
          type = "bool",
          label = "optional"
        },
        chain_of_the_twilight_owl = {
          id = 5,
          type = "bool",
          label = "optional"
        },
        mana_tide_totems = {
          id = 6,
          type = "int32",
          label = "optional",
          _metadata = {
            export = "ManaTideTotem",
            field_alias = "manaTideTotems",
            ids = {
              spell = {
                16190
              }
            },
            num_states = 5
          }
        },
        heroic_presence = {
          id = 7,
          type = "bool",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "atiesh_mage",
        "atiesh_warlock",
        "braided_eternium_chain",
        "eye_of_the_night",
        "chain_of_the_twilight_owl",
        "mana_tide_totems",
        "heroic_presence"
      }
    },
    IndividualBuffs = {
      fields = {
        blessing_of_kings = {
          id = 1,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "BlessingOfKings",
            field_alias = "blessingOfKings",
            ids = {
              spell = {
                25898
              }
            }
          }
        },
        blessing_of_wisdom = {
          id = 2,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            export = "BlessingOfWisdom",
            field_alias = "blessingOfWisdom",
            ids = {
              spell = {
                48938
              }
            },
            extras = {
              imp_id = "ActionId.fromSpellId(20245)"
            }
          }
        },
        blessing_of_might = {
          id = 3,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            export = "BlessingOfMight",
            field_alias = "blessingOfMight",
            ids = {
              spell = {
                48934
              }
            },
            extras = {
              imp_id = "ActionId.fromSpellId(20045)"
            },
            aura = {
              class = "core",
              spell_id = 48932,
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
          label = "optional",
          _metadata = {
            export = "BlessingOfSanctuary",
            field_alias = "blessingOfSanctuary",
            ids = {
              spell = {
                25899
              }
            },
            aura = {
              class = "core",
              spell_id = 25899,
              label = "Blessing of Sanctuary",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "core"
            }
          }
        },
        vigilance = {
          id = 5,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "Vigilance",
            field_alias = "vigilance",
            ids = {
              spell = {
                50720
              }
            }
          }
        },
        renewed_hope = {
          id = 6,
          type = "bool",
          label = "optional"
        },
        hymn_of_hope = {
          id = 7,
          type = "int32",
          label = "optional",
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
        hand_of_salvation = {
          id = 8,
          type = "int32",
          label = "optional"
        },
        rapture = {
          id = 9,
          type = "int32",
          label = "optional"
        },
        innervates = {
          id = 10,
          type = "int32",
          label = "optional",
          _metadata = {
            export = "Innervates",
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
          id = 11,
          type = "int32",
          label = "optional",
          _metadata = {
            export = "PowerInfusions",
            field_alias = "powerInfusions",
            ids = {
              spell = {
                10060
              }
            },
            num_states = 11
          }
        },
        unholy_frenzy = {
          id = 12,
          type = "int32",
          label = "optional",
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 49016,
              label = "Unholy Frenzy",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS",
                priority = "core.CooldownPriorityBloodlust"
              },
              flags = "SpellFlagAPL",
              class_token = "deathknight"
            },
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
        revitalize_rejuvination = {
          id = 13,
          type = "int32",
          label = "optional"
        },
        revitalize_wild_growth = {
          id = 21,
          type = "int32",
          label = "optional"
        },
        tricks_of_the_trades = {
          id = 19,
          type = "int32",
          label = "optional",
          _metadata = {
            export = "TricksOfTheTrades",
            field_alias = "tricksOfTheTrades",
            ids = {
              spell = {
                57933
              }
            },
            num_states = 20
          }
        },
        divine_guardians = {
          id = 23,
          type = "int32",
          label = "optional",
          _metadata = {
            export = "DivineGuardians",
            field_alias = "divineGuardians",
            ids = {
              spell = {
                53530
              }
            },
            num_states = 11
          }
        },
        pain_suppressions = {
          id = 24,
          type = "int32",
          label = "optional",
          _metadata = {
            export = "PainSuppressions",
            field_alias = "painSuppressions",
            ids = {
              spell = {
                33206
              }
            },
            num_states = 11
          }
        },
        hand_of_sacrifices = {
          id = 25,
          type = "int32",
          label = "optional",
          _metadata = {
            export = "HandOfSacrifices",
            field_alias = "handOfSacrifices",
            ids = {
              spell = {
                6940
              }
            },
            num_states = 11
          }
        },
        guardian_spirits = {
          id = 26,
          type = "int32",
          label = "optional",
          _metadata = {
            export = "GuardianSpirits",
            field_alias = "guardianSpirits",
            ids = {
              spell = {
                47788
              }
            },
            num_states = 11
          }
        },
        shattering_throws = {
          id = 20,
          type = "int32",
          label = "optional",
          _metadata = {
            export = "ShatteringThrows",
            field_alias = "shatteringThrows",
            ids = {
              spell = {
                64382
              }
            },
            num_states = 20
          }
        },
        vampiric_touch = {
          id = 14,
          type = "bool",
          label = "optional"
        },
        hunting_party = {
          id = 15,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "HuntingParty",
            field_alias = "huntingParty",
            ids = {
              spell = {
                53292
              }
            }
          }
        },
        judgements_of_the_wise = {
          id = 16,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "JudgementsOfTheWise",
            field_alias = "judgementsOfTheWise",
            ids = {
              spell = {
                31878
              }
            }
          }
        },
        improved_soul_leech = {
          id = 17,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "ImprovedSoulLeech",
            field_alias = "improvedSoulLeech",
            ids = {
              spell = {
                54118
              }
            }
          }
        },
        enduring_winter = {
          id = 18,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "EnduringWinter",
            field_alias = "enduringWinter",
            ids = {
              spell = {
                44561
              }
            }
          }
        },
        focus_magic = {
          id = 22,
          type = "bool",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "core",
                spell_id = 54648,
                label = "Focus Magic",
                label_raw = [["Focus Magic" + strconv.Itoa(casterIndex)]],
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 54648,
                label = "Focus Magic",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
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
        "blessing_of_kings",
        "blessing_of_wisdom",
        "blessing_of_might",
        "blessing_of_sanctuary",
        "vigilance",
        "renewed_hope",
        "hymn_of_hope",
        "hand_of_salvation",
        "rapture",
        "innervates",
        "power_infusions",
        "unholy_frenzy",
        "revitalize_rejuvination",
        "revitalize_wild_growth",
        "tricks_of_the_trades",
        "divine_guardians",
        "pain_suppressions",
        "hand_of_sacrifices",
        "guardian_spirits",
        "shattering_throws",
        "vampiric_touch",
        "hunting_party",
        "judgements_of_the_wise",
        "improved_soul_leech",
        "enduring_winter",
        "focus_magic"
      },
      _metadata = {
        revitalize_buff = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "RevitalizeBuff",
          ids = {
            spell = {
              26982,
              53251
            }
          },
          stats = {

          }
        },
        replenishment_buff = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "ReplenishmentBuff",
          ids = {
            spell = {
              48160,
              31878,
              53292,
              54118,
              44561
            }
          },
          stats = {
            "StatMP5"
          }
        },
        mp5_buff = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "MP5Buff",
          ids = {
            spell = {
              48938,
              58774
            }
          },
          stats = {
            "StatMP5"
          }
        },
        defensive_cooldown_buff = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "DefensiveCooldownBuff",
          ids = {
            spell = {
              6940,
              53530,
              33206,
              47788
            }
          },
          stats = {
            "StatArmor"
          }
        },
        damage_reduction_percent_buff = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "DamageReductionPercentBuff",
          ids = {
            spell = {
              57472,
              25899,
              50720
            }
          },
          stats = {
            "StatArmor"
          }
        },
        attack_power_buff = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "AttackPowerBuff",
          ids = {
            spell = {
              48934,
              47436
            }
          },
          stats = {
            "StatAttackPower",
            "StatRangedAttackPower"
          }
        },
        all_stats_percent_buff = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "AllStatsPercentBuff",
          ids = {
            spell = {
              25898,
              25899
            },
            item = {
              49633
            }
          },
          stats = {

          }
        }
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
            export = "FlaskOfTheFrostWyrm",
            field_alias = "flask",
            ids = {
              item = {
                46376
              }
            },
            value = "Flask.FlaskOfTheFrostWyrm"
          }
        },
        battle_elixir = {
          id = 2,
          type = "enum",
          label = "optional",
          enum_type = "BattleElixir"
        },
        guardian_elixir = {
          id = 3,
          type = "enum",
          label = "optional",
          enum_type = "GuardianElixir"
        },
        food = {
          id = 6,
          type = "enum",
          label = "optional",
          enum_type = "Food",
          _metadata = {
            export = "FoodFishFeast",
            field_alias = "food",
            ids = {
              item = {
                43015
              }
            },
            value = "Food.FoodFishFeast"
          }
        },
        pet_food = {
          id = 7,
          type = "enum",
          label = "optional",
          enum_type = "PetFood",
          _metadata = {
            export = "PetFood",
            field_alias = "petFood",
            ids = {
              item = {
                43005
              }
            },
            value = "PetFood.PetFoodSpicedMammothTreats"
          }
        },
        pet_scroll_of_agility = {
          id = 8,
          type = "int32",
          label = "optional",
          _metadata = {
            export = "PetScrollOfAgility",
            field_alias = "petScrollOfAgility",
            ids = {
              item = {
                27498
              }
            },
            value = "5"
          }
        },
        pet_scroll_of_strength = {
          id = 9,
          type = "int32",
          label = "optional",
          _metadata = {
            export = "PetScrollOfStrength",
            field_alias = "petScrollOfStrength",
            ids = {
              item = {
                27503
              }
            },
            value = "5"
          }
        },
        default_potion = {
          id = 10,
          type = "enum",
          label = "optional",
          enum_type = "Potions",
          _metadata = {
            export = "RunicHealingPotion",
            field_alias = "defaultPotion",
            ids = {
              item = {
                33447
              }
            },
            value = "Potions.RunicHealingPotion"
          }
        },
        prepop_potion = {
          id = 11,
          type = "enum",
          label = "optional",
          enum_type = "Potions"
        },
        default_conjured = {
          id = 12,
          type = "enum",
          label = "optional",
          enum_type = "Conjured",
          _metadata = {
            export = "ConjuredDarkRune",
            field_alias = "defaultConjured",
            ids = {
              item = {
                12662
              }
            },
            value = "Conjured.ConjuredDarkRune",
            show_when = "(player: Player<Spec>) => player.getClass() == Class.ClassRogue"
          }
        },
        thermal_sapper = {
          id = 15,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "ThermalSapper",
            field_alias = "thermalSapper",
            ids = {
              item = {
                42641
              }
            }
          }
        },
        explosive_decoy = {
          id = 16,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "ExplosiveDecoy",
            field_alias = "explosiveDecoy",
            ids = {
              item = {
                40536
              }
            }
          }
        },
        filler_explosive = {
          id = 17,
          type = "enum",
          label = "optional",
          enum_type = "Explosive",
          _metadata = {
            export = "ExplosiveSaroniteBomb",
            field_alias = "fillerExplosive",
            ids = {
              item = {
                41119
              }
            },
            value = "Explosive.ExplosiveSaroniteBomb"
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "flask",
        "battle_elixir",
        "guardian_elixir",
        "food",
        "pet_food",
        "pet_scroll_of_agility",
        "pet_scroll_of_strength",
        "default_potion",
        "prepop_potion",
        "default_conjured",
        "thermal_sapper",
        "explosive_decoy",
        "filler_explosive"
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
              spell_id = 53408,
              label = "Judgement of Wisdom",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "core"
            },
            spell = {
              class = "paladin",
              spell_id = 53408,
              label = "Judgement Of Wisdom",
              cooldown = {
                raw = [[(time.Second * 10) -
					(time.Second * paladin.Talents.ImprovedJudgements) -
					core.TernaryDuration(paladin.HasSetBonus(ItemSetRedemptionBattlegear, 4), 1*time.Second, 0) -
					core.TernaryDuration(paladin.HasSetBonus(ItemSetGladiatorsVindication, 4), 1*time.Second, 0)]],
                cases = {
                  {
                    condition = "paladin.HasSetBonus(ItemSetRedemptionBattlegear, 4) && paladin.HasSetBonus(ItemSetGladiatorsVindication, 4)",
                    raw = [[(time.Second * 10) -
					(time.Second * time.Duration(paladin.Talents.ImprovedJudgements)) -
					(1*time.Second) -
					(1*time.Second)]]
                  },
                  {
                    condition = "paladin.HasSetBonus(ItemSetRedemptionBattlegear, 4) && !(paladin.HasSetBonus(ItemSetGladiatorsVindication, 4))",
                    raw = [[(time.Second * 10) -
					(time.Second * time.Duration(paladin.Talents.ImprovedJudgements)) -
					(1*time.Second) -
					(0)]]
                  },
                  {
                    condition = "!(paladin.HasSetBonus(ItemSetRedemptionBattlegear, 4)) && paladin.HasSetBonus(ItemSetGladiatorsVindication, 4)",
                    raw = [[(time.Second * 10) -
					(time.Second * time.Duration(paladin.Talents.ImprovedJudgements)) -
					(0) -
					(1*time.Second)]]
                  },
                  {
                    condition = "!(paladin.HasSetBonus(ItemSetRedemptionBattlegear, 4)) && !(paladin.HasSetBonus(ItemSetGladiatorsVindication, 4))",
                    raw = [[(time.Second * 10) -
					(time.Second * time.Duration(paladin.Talents.ImprovedJudgements)) -
					(0) -
					(0)]]
                  }
                }
              },
              flags = "SpellFlagPrimaryJudgement | core.SpellFlagAPL",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskProc",
              class_token = "paladin"
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
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "core"
            },
            spell = {
              class = "paladin",
              spell_id = 20271,
              label = "Judgement Of Light",
              cooldown = {
                raw = [[(time.Second * 10) -
					(time.Second * paladin.Talents.ImprovedJudgements) -
					core.TernaryDuration(paladin.HasSetBonus(ItemSetRedemptionBattlegear, 4), 1*time.Second, 0) -
					core.TernaryDuration(paladin.HasSetBonus(ItemSetGladiatorsVindication, 4), 1*time.Second, 0)]],
                cases = {
                  {
                    condition = "paladin.HasSetBonus(ItemSetRedemptionBattlegear, 4) && paladin.HasSetBonus(ItemSetGladiatorsVindication, 4)",
                    raw = [[(time.Second * 10) -
					(time.Second * time.Duration(paladin.Talents.ImprovedJudgements)) -
					(1*time.Second) -
					(1*time.Second)]]
                  },
                  {
                    condition = "paladin.HasSetBonus(ItemSetRedemptionBattlegear, 4) && !(paladin.HasSetBonus(ItemSetGladiatorsVindication, 4))",
                    raw = [[(time.Second * 10) -
					(time.Second * time.Duration(paladin.Talents.ImprovedJudgements)) -
					(1*time.Second) -
					(0)]]
                  },
                  {
                    condition = "!(paladin.HasSetBonus(ItemSetRedemptionBattlegear, 4)) && paladin.HasSetBonus(ItemSetGladiatorsVindication, 4)",
                    raw = [[(time.Second * 10) -
					(time.Second * time.Duration(paladin.Talents.ImprovedJudgements)) -
					(0) -
					(1*time.Second)]]
                  },
                  {
                    condition = "!(paladin.HasSetBonus(ItemSetRedemptionBattlegear, 4)) && !(paladin.HasSetBonus(ItemSetGladiatorsVindication, 4))",
                    raw = [[(time.Second * 10) -
					(time.Second * time.Duration(paladin.Talents.ImprovedJudgements)) -
					(0) -
					(0)]]
                  }
                }
              },
              flags = "SpellFlagPrimaryJudgement | core.SpellFlagAPL",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskProc",
              class_token = "paladin"
            }
          }
        },
        misery = {
          id = 3,
          type = "bool",
          label = "optional"
        },
        faerie_fire = {
          id = 4,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            export = "FaerieFire",
            field_alias = "faerieFire",
            ids = {
              spell = {
                33602
              }
            },
            value = "TristateEffect.TristateEffectImproved",
            spell = {
              class = "druid",
              spell_id = 770,
              label = "Faerie Fire",
              flags = "SpellFlagOmenTrigger",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "druid.BalanceCritMultiplier()",
              threat_multiplier = "1",
              class_token = "druid"
            },
            aura = {
              class = "core",
              spell_id = 770,
              label = "Faerie Fire",
              label_raw = [["Faerie Fire" + strconv.Itoa(int(points))]],
              tag = "Faerie Fire",
              duration = {
                raw = "time.Minute * 5",
                seconds = 300.0
              },
              class_token = "core"
            }
          }
        },
        curse_of_elements = {
          id = 5,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "CurseOfElements",
            field_alias = "curseOfElements",
            ids = {
              spell = {
                47865
              }
            },
            aura = {
              class = "core",
              spell_id = 47865,
              label = "Curse of Elements",
              duration = {
                raw = "time.Minute * 5",
                seconds = 300.0
              },
              class_token = "core"
            },
            spell = {
              class = "warlock",
              spell_id = 47865,
              label = "Curse Of Elements",
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolShadow",
              proc_mask = "2",
              threat_multiplier = "1 - 0.1*float64(warlock.Talents.ImprovedDrainSoul)",
              class_token = "warlock"
            },
            ["function"] = "CurseOfElementsAura",
            label = "Curse of Elements",
            spell_id = 47865,
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
        ebon_plaguebringer = {
          id = 6,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "EbonPlaguebringer",
            field_alias = "ebonPlaguebringer",
            ids = {
              spell = {
                51161
              }
            },
            ["function"] = "EbonPlaguebringerOrCryptFeverAura",
            label = "EbonPlaguebringer",
            spell_id = 52789,
            tags = {
              "raid"
            },
            extras = {
              functions = {
                "EbonPlaguebringerOrCryptFeverAura"
              }
            }
          }
        },
        earth_and_moon = {
          id = 7,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "EarthAndMoon",
            field_alias = "earthAndMoon",
            ids = {
              spell = {
                48511
              }
            },
            aura = {
              class = "core",
              spell_id = 48511,
              label = "Earth And Moon",
              label_raw = [["Earth And Moon" + strconv.Itoa(int(points))]],
              duration = {
                raw = "time.Second * 12",
                seconds = 12.0
              },
              class_token = "core"
            }
          }
        },
        heart_of_the_crusader = {
          id = 8,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "HeartOfTheCrusader",
            field_alias = "heartOfTheCrusader",
            ids = {
              spell = {
                20337
              }
            }
          }
        },
        master_poisoner = {
          id = 9,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "MasterPoisoner",
            field_alias = "masterPoisoner",
            ids = {
              spell = {
                58410
              }
            },
            ["function"] = "MasterPoisonerDebuff",
            spell_id = 58410,
            tags = {
              "raid"
            },
            extras = {
              functions = {
                "MasterPoisonerDebuff"
              }
            }
          }
        },
        totem_of_wrath = {
          id = 10,
          type = "bool",
          label = "optional"
        },
        shadow_mastery = {
          id = 11,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "ShadowMastery",
            field_alias = "shadowMastery",
            ids = {
              spell = {
                17803
              }
            }
          }
        },
        improved_scorch = {
          id = 12,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "ImprovedScorch",
            field_alias = "improvedScorch",
            ids = {
              spell = {
                12873
              }
            }
          }
        },
        winters_chill = {
          id = 13,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "WintersChill",
            field_alias = "wintersChill",
            ids = {
              spell = {
                28593
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
        blood_frenzy = {
          id = 14,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "BloodFrenzy",
            field_alias = "bloodFrenzy",
            ids = {
              spell = {
                29859
              }
            }
          }
        },
        savage_combat = {
          id = 15,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "SavageCombat",
            field_alias = "savageCombat",
            ids = {
              spell = {
                58413
              }
            },
            ["function"] = "SavageCombatAura",
            spell_id = 58413,
            tags = {
              "raid"
            },
            extras = {
              functions = {
                "SavageCombatAura"
              }
            }
          }
        },
        gift_of_arthas = {
          id = 16,
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
        mangle = {
          id = 17,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "Mangle",
            field_alias = "mangle",
            ids = {
              spell = {
                48564
              }
            }
          }
        },
        trauma = {
          id = 18,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "Trauma",
            field_alias = "trauma",
            ids = {
              spell = {
                46855
              }
            }
          }
        },
        stampede = {
          id = 19,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "Stampede",
            field_alias = "stampede",
            ids = {
              spell = {
                57393
              }
            }
          }
        },
        expose_armor = {
          id = 20,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "ExposeArmor",
            field_alias = "exposeArmor",
            ids = {
              spell = {
                8647
              }
            },
            spell = {
              class = "rogue",
              spell_id = 8647,
              label = "Expose Armor",
              flags = "core.SpellFlagMeleeMetrics | rogue.finisherFlags() | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              threat_multiplier = "1",
              class_token = "rogue"
            },
            aura = {
              class = "core",
              spell_id = 8647,
              label = "ExposeArmor",
              duration = {
                raw = "time.Second * TernaryDuration(hasGlyph, 42, 30)"
              },
              class_token = "core"
            }
          }
        },
        sunder_armor = {
          id = 21,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "SunderArmor",
            field_alias = "sunderArmor",
            ids = {
              spell = {
                47467
              }
            },
            aura = {
              class = "core",
              spell_id = 47467,
              label = "Sunder Armor",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "core"
            }
          }
        },
        acid_spit = {
          id = 22,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "AcidSpit",
            field_alias = "acidSpit",
            ids = {
              spell = {
                55754
              }
            },
            aura = {
              class = "core",
              spell_id = 55754,
              label = "Acid Spit",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "core"
            }
          }
        },
        curse_of_weakness = {
          id = 23,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            export = "CurseOfWeakness",
            field_alias = "curseOfWeakness",
            ids = {
              spell = {
                50511
              }
            },
            extras = {
              imp_id = "ActionId.fromSpellId(18180)"
            },
            aura = {
              class = "core",
              spell_id = 50511,
              label = "Curse Of Weakness",
              label_raw = [["Curse of Weakness" + strconv.Itoa(int(points))]],
              duration = {
                raw = "time.Minute * 2",
                seconds = 120.0
              },
              class_token = "core"
            },
            spell = {
              class = "warlock",
              spell_id = 50511,
              label = "Curse Of Weakness",
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolShadow",
              proc_mask = "2",
              threat_multiplier = "1 - 0.1*float64(warlock.Talents.ImprovedDrainSoul)",
              class_token = "warlock"
            }
          }
        },
        sting = {
          id = 24,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "Sting",
            field_alias = "sting",
            ids = {
              spell = {
                56631
              }
            },
            aura = {
              class = "core",
              spell_id = 56631,
              label = "Sting",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "core"
            }
          }
        },
        spore_cloud = {
          id = 37,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "SporeCloud",
            field_alias = "sporeCloud",
            ids = {
              spell = {
                53598
              }
            },
            aura = {
              class = "core",
              spell_id = 53598,
              label = "Spore Cloud",
              duration = {
                raw = "time.Second * 9",
                seconds = 9.0
              },
              class_token = "core"
            },
            ["function"] = "SporeCloudAura",
            label = "Spore Cloud",
            spell_id = 53598,
            tags = {
              "raid"
            },
            extras = {
              functions = {
                "SporeCloudAura"
              }
            }
          }
        },
        demoralizing_roar = {
          id = 25,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            export = "DemoralizingRoar",
            field_alias = "demoralizingRoar",
            ids = {
              spell = {
                48560
              }
            },
            extras = {
              imp_id = "ActionId.fromSpellId(16862)"
            },
            spell = {
              class = "druid",
              spell_id = 48560,
              label = "Demoralizing Roar",
              flags = "SpellFlagAPL",
              spell_school = "2",
              proc_mask = "2",
              threat_multiplier = "1",
              class_token = "druid"
            },
            aura = {
              class = "core",
              spell_id = 48560,
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
          id = 26,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            export = "DemoralizingShout",
            field_alias = "demoralizingShout",
            ids = {
              spell = {
                47437
              }
            },
            extras = {
              imp_id = "ActionId.fromSpellId(12879)"
            },
            aura = {
              class = "core",
              spell_id = 47437,
              label = "Demoralizing Shout",
              label_raw = [["DemoralizingShout-" + strconv.Itoa(int(impDemoShoutPts))]],
              duration = {
                raw = "time.Duration(float64(time.Second*30) * (1 + 0.1*float64(boomingVoicePts)))"
              },
              class_token = "core"
            },
            spell = {
              class = "warrior",
              spell_id = 25203,
              label = "Demoralizing Shout",
              flags = "SpellFlagAPL",
              spell_school = "2",
              proc_mask = "2",
              threat_multiplier = "1",
              class_token = "warrior"
            }
          }
        },
        vindication = {
          id = 36,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "Vindication",
            field_alias = "vindication",
            ids = {
              spell = {
                26016
              }
            },
            aura = {
              class = "core",
              spell_id = 26016,
              label = "Vindication",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "core"
            }
          }
        },
        demoralizing_screech = {
          id = 34,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "DemoralizingScreech",
            field_alias = "demoralizingScreech",
            ids = {
              spell = {
                55487
              }
            },
            aura = {
              class = "core",
              spell_id = 55487,
              label = "DemoralizingScreech",
              duration = {
                raw = "time.Second * 4",
                seconds = 4.0
              },
              class_token = "core"
            },
            ["function"] = "DemoralizingScreechAura",
            label = "DemoralizingScreech",
            spell_id = 55487,
            tags = {
              "raid"
            },
            extras = {
              functions = {
                "DemoralizingScreechAura"
              }
            }
          }
        },
        thunder_clap = {
          id = 27,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            export = "ThunderClap",
            field_alias = "thunderClap",
            ids = {
              spell = {
                47502
              }
            },
            extras = {
              imp_id = "ActionId.fromSpellId(12666)"
            },
            aura = {
              class = "core",
              spell_id = 47502,
              label = "Thunder Clap",
              label_raw = [["ThunderClap-" + strconv.Itoa(int(points))]],
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "core"
            },
            spell = {
              class = "warrior",
              spell_id = 47502,
              label = "Thunder Clap",
              cooldown = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              flags = "core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskRangedSpecial",
              damage_multiplier = "[]float64{1.0, 1.1, 1.2, 1.3}[warrior.Talents.ImprovedThunderClap]",
              crit_multiplier = "warrior.critMultiplier(none)",
              threat_multiplier = "1.85",
              class_token = "warrior"
            }
          }
        },
        frost_fever = {
          id = 28,
          type = "enum",
          label = "optional",
          enum_type = "TristateEffect",
          _metadata = {
            export = "FrostFever",
            field_alias = "frostFever",
            ids = {
              spell = {
                55095
              }
            },
            extras = {
              imp_id = "ActionId.fromSpellId(51456)"
            },
            spell = {
              class = "deathknight",
              spell_id = 55095,
              label = "FrostFever",
              tag = "FrostFever",
              flags = "SpellFlagDisease",
              spell_school = "SpellSchoolFrost",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "core.TernaryFloat64(dk.HasMajorGlyph(proto.DeathknightMajorGlyph_GlyphOfIcyTouch), 1.2, 1.0)",
              threat_multiplier = "1",
              class_token = "deathknight"
            },
            aura = {
              class = "core",
              spell_id = 55095,
              label = "FrostFever",
              duration = {
                raw = "time.Second*15 + (time.Second * 3 * time.Duration(epidemic))"
              },
              class_token = "core"
            }
          }
        },
        infected_wounds = {
          id = 29,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "InfectedWounds",
            field_alias = "infectedWounds",
            ids = {
              spell = {
                48485
              }
            },
            aura = {
              class = "core",
              spell_id = 48485,
              label = "Infected Wounds",
              label_raw = [["InfectedWounds-" + strconv.Itoa(int(points))]],
              duration = {
                raw = "time.Second * 12",
                seconds = 12.0
              },
              class_token = "core"
            }
          }
        },
        judgements_of_the_just = {
          id = 30,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "JudgementsOfTheJust",
            field_alias = "judgementsOfTheJust",
            ids = {
              spell = {
                53696
              }
            },
            aura = {
              class = "core",
              spell_id = 53696,
              label = "Judgements Of The Just",
              label_raw = [["JudgementsOfTheJust-" + strconv.Itoa(int(points))]],
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "core"
            }
          }
        },
        insect_swarm = {
          id = 31,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "InsectSwarm",
            field_alias = "insectSwarm",
            ids = {
              spell = {
                65855
              }
            },
            aura = {
              class = "core",
              spell_id = 27013,
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
          id = 32,
          type = "bool",
          label = "optional",
          _metadata = {
            export = "ScorpidSting",
            field_alias = "scorpidSting",
            ids = {
              spell = {
                3043
              }
            },
            aura = {
              class = "core",
              spell_id = 3043,
              label = "Scorpid Sting",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "core"
            },
            spell = {
              class = "hunter",
              spell_id = 3043,
              label = "Scorpid Sting",
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskRangedSpecial",
              threat_multiplier = "1",
              class_token = "hunter"
            }
          }
        },
        shadow_embrace = {
          id = 33,
          type = "bool",
          label = "optional"
        },
        hunters_mark = {
          id = 35,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "core",
              spell_id = 53338,
              label = "Hunters Mark",
              label_raw = [["HuntersMark-" + strconv.Itoa(int(bonus))]],
              tag = "HuntersMark",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "core"
            }
          }
        },
        crystal_yield = {
          id = 38,
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
        "misery",
        "faerie_fire",
        "curse_of_elements",
        "ebon_plaguebringer",
        "earth_and_moon",
        "heart_of_the_crusader",
        "master_poisoner",
        "totem_of_wrath",
        "shadow_mastery",
        "improved_scorch",
        "winters_chill",
        "blood_frenzy",
        "savage_combat",
        "gift_of_arthas",
        "mangle",
        "trauma",
        "stampede",
        "expose_armor",
        "sunder_armor",
        "acid_spit",
        "curse_of_weakness",
        "sting",
        "spore_cloud",
        "demoralizing_roar",
        "demoralizing_shout",
        "vindication",
        "demoralizing_screech",
        "thunder_clap",
        "frost_fever",
        "infected_wounds",
        "judgements_of_the_just",
        "insect_swarm",
        "scorpid_sting",
        "shadow_embrace",
        "hunters_mark",
        "crystal_yield"
      },
      _metadata = {
        crystal_yield = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "CrystalYield",
          ids = {
            spell = {
              15235
            }
          },
          stats = {
            "StatArmorPenetration"
          }
        },
        gift_of_arthas = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
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
        shattering_throw = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "ShatteringThrow",
          ids = {
            spell = {
              64382
            }
          },
          stats = {
            "StatArmorPenetration"
          }
        },
        judgement_of_light = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "JudgementOfLight",
          ids = {
            spell = {
              20271
            }
          },
          stats = {
            "StatStamina"
          }
        },
        judgement_of_wisdom = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "JudgementOfWisdom",
          ids = {
            spell = {
              53408
            }
          },
          stats = {
            "StatIntellect",
            "StatMP5"
          }
        },
        hunters_mark = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "HuntersMark",
          ids = {
            spell = {
              53338
            }
          },
          stats = {
            "StatRangedAttackPower"
          }
        },
        spell_damage_debuff = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "SpellDamageDebuff",
          ids = {
            spell = {
              51161,
              48511,
              47865
            }
          },
          stats = {
            "StatSpellPower"
          }
        },
        spell_hit_debuff = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "SpellHitDebuff",
          ids = {
            spell = {
              33198,
              33602
            }
          },
          stats = {
            "StatSpellHit"
          }
        },
        spell_crit_debuff = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "SpellCritDebuff",
          ids = {
            spell = {
              17803,
              12873,
              28593
            }
          },
          stats = {
            "StatSpellCrit"
          }
        },
        physical_damage_debuff = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "PhysicalDamageDebuff",
          ids = {
            spell = {
              29859,
              58413
            }
          },
          stats = {
            "StatAttackPower",
            "StatRangedAttackPower"
          }
        },
        melee_hit_debuff = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "MeleeHitDebuff",
          ids = {
            spell = {
              65855,
              3043
            }
          },
          stats = {
            "StatDodge"
          }
        },
        melee_attack_speed_debuff = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "MeleeAttackSpeedDebuff",
          ids = {
            spell = {
              47502,
              55095,
              53696,
              48485
            }
          },
          stats = {
            "StatArmor"
          }
        },
        crit_debuff = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "CritDebuff",
          ids = {
            spell = {
              30706,
              20337,
              58410
            }
          },
          stats = {
            "StatMeleeCrit",
            "StatSpellCrit"
          }
        },
        bleed_debuff = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "BleedDebuff",
          ids = {
            spell = {
              48564,
              46855,
              57393
            }
          },
          stats = {
            "StatAttackPower",
            "StatRangedAttackPower"
          }
        },
        attack_power_debuff = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "AttackPowerDebuff",
          ids = {
            spell = {
              26016,
              47437,
              48560,
              50511,
              55487
            }
          },
          stats = {
            "StatArmor"
          }
        },
        minor_armor_debuff = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "MinorArmorDebuff",
          ids = {
            spell = {
              770,
              50511,
              56631,
              53598
            }
          },
          stats = {
            "StatArmorPenetration"
          }
        },
        major_armor_debuff = {
          source = "extern/wowsims-wotlk/ui/core/components/inputs/buffs_debuffs.ts",
          export = "MajorArmorDebuff",
          ids = {
            spell = {
              47467,
              8647,
              55754
            }
          },
          stats = {
            "StatArmorPenetration"
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
        }
      },
      oneofs = {

      },
      field_order = {
        "input_type",
        "label",
        "tooltip",
        "bool_value",
        "number_value"
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
    ItemSpec = {
      fields = {
        id = {
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
          message_type = "ItemSpec",
          _metadata = {
            aura = {
              {
                class = "deathknight",
                spell_id = 50401,
                label = "Sigil of the Bone Gryphon",
                class_token = "deathknight"
              },
              {
                class = "deathknight",
                spell_id = 50401,
                label = "Sigil of the Hanged Man",
                class_token = "deathknight"
              },
              {
                class = "deathknight",
                spell_id = 50401,
                label = "Sigil of Virulence",
                class_token = "deathknight"
              },
              {
                class = "deathknight",
                spell_id = 67380,
                label = "Sigil of Insolence",
                class_token = "deathknight"
              },
              {
                class = "deathknight",
                spell_id = 64963,
                label = "Sigil of Deflection",
                class_token = "deathknight"
              },
              {
                class = "deathknight",
                spell_id = 60828,
                label = "Sigil of Haunted Dreams",
                class_token = "deathknight"
              },
              {
                class = "deathknight",
                spell_id = 62146,
                label = "Sigil of the Unfaltering Knight",
                class_token = "deathknight"
              },
              {
                class = "deathknight",
                spell_id = 50401,
                label = "Rune of Cinderglacier",
                class_token = "deathknight"
              },
              {
                class = "deathknight",
                spell_id = 53386,
                label = "Cinderglacier",
                duration = {
                  raw = "time.Second * 30",
                  seconds = 30.0
                },
                class_token = "deathknight"
              },
              {
                class = "deathknight",
                spell_id = 53365,
                label = "Rune Of The Fallen Crusader",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "deathknight"
              },
              {
                class = "deathknight",
                spell_id = 50401,
                label = "Razor Frost",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "deathknight"
              }
            },
            spell = {
              class = "deathknight",
              spell_id = 50401,
              label = "Items",
              spell_school = "SpellSchoolFrost",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "deathknight"
            }
          }
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
        }
      },
      oneofs = {

      },
      field_order = {
        "items",
        "enchants",
        "gems"
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
        stats = {
          id = 8,
          type = "double",
          label = "repeated"
        },
        gem_sockets = {
          id = 9,
          type = "enum",
          label = "repeated",
          enum_type = "GemColor"
        },
        socketBonus = {
          id = 10,
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
        set_name = {
          id = 14,
          type = "string",
          label = "optional"
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
        "stats",
        "gem_sockets",
        "socketBonus",
        "weapon_damage_min",
        "weapon_damage_max",
        "weapon_speed",
        "set_name"
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
        }
      },
      oneofs = {

      },
      field_order = {
        "id",
        "name",
        "color",
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
    Glyphs = {
      fields = {
        major1 = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        major2 = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        major3 = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        minor1 = {
          id = 4,
          type = "int32",
          label = "optional"
        },
        minor2 = {
          id = 5,
          type = "int32",
          label = "optional"
        },
        minor3 = {
          id = 6,
          type = "int32",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "major1",
        "major2",
        "major3",
        "minor1",
        "minor2",
        "minor3"
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
        cat_optimal_rotation_action = {
          id = 18,
          type = "message",
          label = "optional",
          message_type = "APLActionCatOptimalRotationAction",
          _metadata = {
            export = "cat_optimal_rotation_action"
          }
        },
        custom_rotation = {
          id = 19,
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
          "cancel_aura",
          "trigger_icd",
          "item_swap",
          "cat_optimal_rotation_action",
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
        "cancel_aura",
        "trigger_icd",
        "item_swap",
        "cat_optimal_rotation_action",
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
        current_combo_points = {
          id = 16,
          type = "message",
          label = "optional",
          message_type = "APLValueCurrentComboPoints",
          _metadata = {
            export = "current_combo_points"
          }
        },
        current_runic_power = {
          id = 25,
          type = "message",
          label = "optional",
          message_type = "APLValueCurrentRunicPower",
          _metadata = {
            export = "current_runic_power"
          }
        },
        current_rune_count = {
          id = 29,
          type = "message",
          label = "optional",
          message_type = "APLValueCurrentRuneCount",
          _metadata = {
            export = "current_rune_count"
          }
        },
        current_non_death_rune_count = {
          id = 34,
          type = "message",
          label = "optional",
          message_type = "APLValueCurrentNonDeathRuneCount",
          _metadata = {
            export = "current_non_death_rune_count"
          }
        },
        current_rune_death = {
          id = 30,
          type = "message",
          label = "optional",
          message_type = "APLValueCurrentRuneDeath",
          _metadata = {
            export = "current_rune_death"
          }
        },
        current_rune_active = {
          id = 31,
          type = "message",
          label = "optional",
          message_type = "APLValueCurrentRuneActive",
          _metadata = {
            export = "current_rune_active"
          }
        },
        rune_cooldown = {
          id = 32,
          type = "message",
          label = "optional",
          message_type = "APLValueRuneCooldown",
          _metadata = {
            export = "rune_cooldown"
          }
        },
        next_rune_cooldown = {
          id = 33,
          type = "message",
          label = "optional",
          message_type = "APLValueNextRuneCooldown",
          _metadata = {
            export = "next_rune_cooldown"
          }
        },
        rune_slot_cooldown = {
          id = 53,
          type = "message",
          label = "optional",
          message_type = "APLValueRuneSlotCooldown",
          _metadata = {
            export = "rune_slot_cooldown"
          }
        },
        rune_grace = {
          id = 54,
          type = "message",
          label = "optional",
          message_type = "APLValueRuneGrace",
          _metadata = {
            export = "rune_grace"
          }
        },
        rune_slot_grace = {
          id = 55,
          type = "message",
          label = "optional",
          message_type = "APLValueRuneSlotGrace",
          _metadata = {
            export = "rune_slot_grace"
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
        cat_new_savage_roar_duration = {
          id = 61,
          type = "message",
          label = "optional",
          message_type = "APLValueCatNewSavageRoarDuration",
          _metadata = {
            export = "cat_new_savage_roar_duration"
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
          "current_health",
          "current_health_percent",
          "current_mana",
          "current_mana_percent",
          "current_rage",
          "current_energy",
          "current_combo_points",
          "current_runic_power",
          "current_rune_count",
          "current_non_death_rune_count",
          "current_rune_death",
          "current_rune_active",
          "rune_cooldown",
          "next_rune_cooldown",
          "rune_slot_cooldown",
          "rune_grace",
          "rune_slot_grace",
          "gcd_is_ready",
          "gcd_time_to_ready",
          "auto_time_to_next",
          "spell_can_cast",
          "spell_is_ready",
          "spell_time_to_ready",
          "spell_cast_time",
          "spell_travel_time",
          "spell_cpm",
          "spell_is_channeling",
          "spell_channeled_ticks",
          "spell_current_cost",
          "aura_is_active",
          "aura_is_active_with_reaction_time",
          "aura_remaining_time",
          "aura_num_stacks",
          "aura_internal_cooldown",
          "aura_icd_is_ready_with_reaction_time",
          "aura_should_refresh",
          "dot_is_active",
          "dot_remaining_time",
          "sequence_is_complete",
          "sequence_is_ready",
          "sequence_time_to_ready",
          "channel_clip_delay",
          "front_of_target",
          "totem_remaining_time",
          "cat_excess_energy",
          "cat_new_savage_roar_duration",
          "warlock_should_recast_drain_soul",
          "warlock_should_refresh_corruption"
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
        "boss_spell_time_to_ready",
        "boss_spell_is_casting",
        "current_health",
        "current_health_percent",
        "current_mana",
        "current_mana_percent",
        "current_rage",
        "current_energy",
        "current_combo_points",
        "current_runic_power",
        "current_rune_count",
        "current_non_death_rune_count",
        "current_rune_death",
        "current_rune_active",
        "rune_cooldown",
        "next_rune_cooldown",
        "rune_slot_cooldown",
        "rune_grace",
        "rune_slot_grace",
        "gcd_is_ready",
        "gcd_time_to_ready",
        "auto_time_to_next",
        "spell_can_cast",
        "spell_is_ready",
        "spell_time_to_ready",
        "spell_cast_time",
        "spell_travel_time",
        "spell_cpm",
        "spell_is_channeling",
        "spell_channeled_ticks",
        "spell_current_cost",
        "aura_is_active",
        "aura_is_active_with_reaction_time",
        "aura_remaining_time",
        "aura_num_stacks",
        "aura_internal_cooldown",
        "aura_icd_is_ready_with_reaction_time",
        "aura_should_refresh",
        "dot_is_active",
        "dot_remaining_time",
        "sequence_is_complete",
        "sequence_is_ready",
        "sequence_time_to_ready",
        "channel_clip_delay",
        "front_of_target",
        "totem_remaining_time",
        "cat_excess_energy",
        "cat_new_savage_roar_duration",
        "warlock_should_recast_drain_soul",
        "warlock_should_refresh_corruption"
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
        short_description = "Channels the spell if possible, i.e. resource/cooldown/GCD/etc requirements are all met.",
        full_description = [[
			<p>The difference between channeling a spell vs casting the spell is that channels can be interrupted. If the <b>Interrupt If</b> parameter is empty, this action is equivalent to <b>Cast</b>.</p>
			<p>The channel will be interrupted only if all of the following are true:</p>
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
        rotation_type = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "AplType"
        },
        manual_params = {
          id = 2,
          type = "bool",
          label = "optional"
        },
        max_ff_delay = {
          id = 3,
          type = "float",
          label = "optional"
        },
        min_roar_offset = {
          id = 4,
          type = "float",
          label = "optional"
        },
        rip_leeway = {
          id = 5,
          type = "int32",
          label = "optional"
        },
        use_rake = {
          id = 6,
          type = "bool",
          label = "optional"
        },
        use_bite = {
          id = 7,
          type = "bool",
          label = "optional"
        },
        bite_time = {
          id = 8,
          type = "float",
          label = "optional"
        },
        flower_weave = {
          id = 9,
          type = "bool",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "rotation_type",
        "manual_params",
        "max_ff_delay",
        "min_roar_offset",
        "rip_leeway",
        "use_rake",
        "use_bite",
        "bite_time",
        "flower_weave"
      },
      _metadata = {
        ui_label = "Optimal Rotation Action",
        short_description = "Executes optimized Feral DPS rotation using hardcoded legacy algorithm.",
        defaults = {
          rotation_type = "FeralDruid_Rotation_AplType.SingleTarget",
          manual_params = true,
          max_ff_delay = 0.1,
          min_roar_offset = 25.0,
          rip_leeway = 4,
          use_rake = true,
          use_bite = true,
          bite_time = 4.0,
          flower_weave = false
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
          rotation_type = {
            default = "FeralDruid_Rotation_AplType.SingleTarget"
          },
          manual_params = {
            ui_label = "Manual Advanced Parameters",
            default = true
          },
          max_ff_delay = {
            default = 0.1
          },
          min_roar_offset = {
            default = 25.0
          },
          rip_leeway = {
            default = 4
          },
          use_rake = {
            ui_label = "Use Rake",
            default = true
          },
          use_bite = {
            ui_label = "Bite during rotation",
            default = true
          },
          bite_time = {
            default = 4.0
          },
          flower_weave = {
            ui_label = "Flower Weave",
            default = false
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
        defaults = "APLValueBossSpellTimeToReady.create",
        submenu = {
          "Boss"
        },
        fields = {
          target_unit = {
            ui_label = "Unit",
            default = {
              type = 0
            }
          },
          spell_id = {
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
        ui_label = "Spell is Casting",
        defaults = "APLValueBossSpellIsCasting.create",
        submenu = {
          "Boss"
        },
        fields = {
          target_unit = {
            ui_label = "Unit",
            default = {
              type = 0
            }
          },
          spell_id = {
            default = {

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
        }
      }
    },
    APLValueCurrentRunicPower = {
      fields = {

      },
      oneofs = {

      },
      field_order = {

      },
      _metadata = {
        ui_label = "Runic Power",
        short_description = "Amount of currently available Runic Power.",
        defaults = "APLValueCurrentRunicPower.create",
        submenu = {
          "Resources"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = false,
          class_specific = true,
          classes = {
            "Deathknight"
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
    APLValueCurrentRuneCount = {
      fields = {
        rune_type = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "APLValueRuneType"
        }
      },
      oneofs = {

      },
      field_order = {
        "rune_type"
      },
      _metadata = {
        ui_label = "Num Runes",
        short_description = "Amount of currently available Runes of certain type including Death.",
        defaults = "APLValueCurrentRuneCount.create",
        submenu = {
          "Resources",
          "Runes"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = false,
          class_specific = true,
          classes = {
            "Deathknight"
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
          rune_type = {
            default = 0
          }
        }
      }
    },
    APLValueCurrentNonDeathRuneCount = {
      fields = {
        rune_type = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "APLValueRuneType"
        }
      },
      oneofs = {

      },
      field_order = {
        "rune_type"
      },
      _metadata = {
        ui_label = "Num Non Death Runes",
        short_description = "Amount of currently available Runes of certain type ignoring Death",
        defaults = "APLValueCurrentNonDeathRuneCount.create",
        submenu = {
          "Resources",
          "Runes"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = false,
          class_specific = true,
          classes = {
            "Deathknight"
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
          rune_type = {
            default = 0
          }
        }
      }
    },
    APLValueCurrentRuneDeath = {
      fields = {
        rune_slot = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "APLValueRuneSlot"
        }
      },
      oneofs = {

      },
      field_order = {
        "rune_slot"
      },
      _metadata = {
        ui_label = "Rune Is Death",
        short_description = "Is the rune of a certain slot currently converted to Death.",
        defaults = "APLValueCurrentRuneDeath.create",
        submenu = {
          "Resources",
          "Runes"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = false,
          class_specific = true,
          classes = {
            "Deathknight"
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
          rune_slot = {
            default = 0
          }
        }
      }
    },
    APLValueCurrentRuneActive = {
      fields = {
        rune_slot = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "APLValueRuneSlot"
        }
      },
      oneofs = {

      },
      field_order = {
        "rune_slot"
      },
      _metadata = {
        ui_label = "Rune Is Ready",
        short_description = "Is the rune of a certain slot currently available.",
        defaults = "APLValueCurrentRuneActive.create",
        submenu = {
          "Resources",
          "Runes"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = false,
          class_specific = true,
          classes = {
            "Deathknight"
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
          rune_slot = {
            default = 0
          }
        }
      }
    },
    APLValueRuneCooldown = {
      fields = {
        rune_type = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "APLValueRuneType"
        }
      },
      oneofs = {

      },
      field_order = {
        "rune_type"
      },
      _metadata = {
        ui_label = "Rune Cooldown",
        short_description = "Amount of time until a rune of certain type is ready to use.<br><b>NOTE:</b> Returns 0 if there is a rune available",
        defaults = "APLValueRuneCooldown.create",
        submenu = {
          "Resources",
          "Runes"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = false,
          class_specific = true,
          classes = {
            "Deathknight"
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
          rune_type = {
            default = 0
          }
        }
      }
    },
    APLValueNextRuneCooldown = {
      fields = {
        rune_type = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "APLValueRuneType"
        }
      },
      oneofs = {

      },
      field_order = {
        "rune_type"
      },
      _metadata = {
        ui_label = "Next Rune Cooldown",
        short_description = "Amount of time until a 2nd rune of certain type is ready to use.<br><b>NOTE:</b> Returns 0 if there are 2 runes available",
        defaults = "APLValueNextRuneCooldown.create",
        submenu = {
          "Resources",
          "Runes"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = false,
          class_specific = true,
          classes = {
            "Deathknight"
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
          rune_type = {
            default = 0
          }
        }
      }
    },
    APLValueRuneSlotCooldown = {
      fields = {
        rune_slot = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "APLValueRuneSlot"
        }
      },
      oneofs = {

      },
      field_order = {
        "rune_slot"
      },
      _metadata = {
        ui_label = "Rune Slot Cooldown",
        short_description = "Amount of time until a rune of certain slot is ready to use.<br><b>NOTE:</b> Returns 0 if rune is ready",
        defaults = "APLValueRuneSlotCooldown.create",
        submenu = {
          "Resources",
          "Runes"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = false,
          class_specific = true,
          classes = {
            "Deathknight"
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
          rune_slot = {
            default = 0
          }
        }
      }
    },
    APLValueRuneGrace = {
      fields = {
        rune_type = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "APLValueRuneType"
        }
      },
      oneofs = {

      },
      field_order = {
        "rune_type"
      },
      _metadata = {
        ui_label = "Rune Grace Period",
        short_description = "Amount of rune grace period available for certain rune type.",
        defaults = "APLValueRuneGrace.create",
        submenu = {
          "Resources",
          "Runes"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = false,
          class_specific = true,
          classes = {
            "Deathknight"
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
          rune_type = {
            default = 0
          }
        }
      }
    },
    APLValueRuneSlotGrace = {
      fields = {
        rune_slot = {
          id = 1,
          type = "enum",
          label = "optional",
          enum_type = "APLValueRuneType"
        }
      },
      oneofs = {

      },
      field_order = {
        "rune_slot"
      },
      _metadata = {
        ui_label = "Rune Slot Grace Period",
        short_description = "Amount of rune grace period available for certain rune slot.",
        defaults = "APLValueRuneSlotGrace.create",
        submenu = {
          "Resources",
          "Runes"
        },
        include_if = {
          prepull_only = false,
          combat_only = false,
          spec_specific = false,
          class_specific = true,
          classes = {
            "Deathknight"
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
          rune_slot = {
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
          "Auto"
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
        call_of_flame = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        elemental_warding = {
          id = 4,
          type = "int32",
          label = "optional"
        },
        elemental_devastation = {
          id = 5,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "shaman",
              spell_id = 30160,
              label = "Elemental Devastation",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "shaman"
            }
          }
        },
        reverberation = {
          id = 6,
          type = "int32",
          label = "optional"
        },
        elemental_focus = {
          id = 7,
          type = "bool",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "shaman",
                label = "Elemental Focus",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
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
            }
          }
        },
        elemental_fury = {
          id = 8,
          type = "int32",
          label = "optional"
        },
        improved_fire_nova = {
          id = 9,
          type = "int32",
          label = "optional"
        },
        eye_of_the_storm = {
          id = 10,
          type = "int32",
          label = "optional"
        },
        elemental_reach = {
          id = 11,
          type = "int32",
          label = "optional"
        },
        call_of_thunder = {
          id = 12,
          type = "bool",
          label = "optional"
        },
        unrelenting_storm = {
          id = 13,
          type = "int32",
          label = "optional"
        },
        elemental_precision = {
          id = 14,
          type = "int32",
          label = "optional"
        },
        lightning_mastery = {
          id = 15,
          type = "int32",
          label = "optional"
        },
        elemental_mastery = {
          id = 16,
          type = "bool",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "shaman",
                label = "Shaman T10 Elemental 2P Bonus",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "shaman"
              },
              {
                class = "shaman",
                spell_id = 16166,
                label = "Elemental Mastery",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "shaman"
              },
              {
                class = "shaman",
                spell_id = 64701,
                label = "Elemental Mastery Haste",
                duration = {
                  raw = "time.Second * 15",
                  seconds = 15.0
                },
                class_token = "shaman"
              }
            },
            spell = {
              class = "shaman",
              spell_id = 16166,
              label = "Elemental Mastery",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0,
                cases = {
                  {
                    raw = "time.Minute * 3",
                    seconds = 180.0
                  },
                  {
                    condition = "shaman.HasMajorGlyph(proto.ShamanMajorGlyph_GlyphOfElementalMastery)",
                    raw = "time.Second * 30",
                    seconds = 30.0
                  }
                }
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              flags = "SpellFlagNoOnCastComplete",
              class_token = "shaman"
            }
          }
        },
        storm_earth_and_fire = {
          id = 17,
          type = "int32",
          label = "optional"
        },
        booming_echoes = {
          id = 18,
          type = "int32",
          label = "optional"
        },
        elemental_oath = {
          id = 19,
          type = "int32",
          label = "optional"
        },
        lightning_overload = {
          id = 20,
          type = "int32",
          label = "optional"
        },
        astral_shift = {
          id = 21,
          type = "int32",
          label = "optional"
        },
        totem_of_wrath = {
          id = 22,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 57722,
              label = "Totem Of Wrath",
              flags = "SpellFlagTotem | core.SpellFlagAPL",
              class_token = "shaman"
            }
          }
        },
        lava_flows = {
          id = 23,
          type = "int32",
          label = "optional"
        },
        shamanism = {
          id = 24,
          type = "int32",
          label = "optional"
        },
        thunderstorm = {
          id = 25,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 59159,
              label = "Thunderstorm",
              cooldown = {
                raw = "time.Second * 45",
                seconds = 45.0
              },
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1 + 0.01*float64(shaman.Talents.Concussion)",
              crit_multiplier = "shaman.ElementalCritMultiplier(0)",
              threat_multiplier = "shaman.spellThreatMultiplier()",
              class_token = "shaman"
            }
          }
        },
        enhancing_totems = {
          id = 26,
          type = "int32",
          label = "optional"
        },
        earths_grasp = {
          id = 27,
          type = "int32",
          label = "optional"
        },
        ancestral_knowledge = {
          id = 28,
          type = "int32",
          label = "optional"
        },
        guardian_totems = {
          id = 29,
          type = "int32",
          label = "optional"
        },
        thundering_strikes = {
          id = 30,
          type = "int32",
          label = "optional"
        },
        improved_ghost_wolf = {
          id = 31,
          type = "int32",
          label = "optional"
        },
        improved_shields = {
          id = 32,
          type = "int32",
          label = "optional"
        },
        elemental_weapons = {
          id = 33,
          type = "int32",
          label = "optional"
        },
        shamanistic_focus = {
          id = 34,
          type = "bool",
          label = "optional"
        },
        anticipation = {
          id = 35,
          type = "int32",
          label = "optional"
        },
        flurry = {
          id = 36,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "shaman",
                label = "Flurry",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "shaman"
              },
              {
                class = "shaman",
                spell_id = 16280,
                label = "Flurry Proc",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "shaman"
              }
            }
          }
        },
        toughness = {
          id = 37,
          type = "int32",
          label = "optional"
        },
        improved_windfury_totem = {
          id = 38,
          type = "int32",
          label = "optional"
        },
        spirit_weapons = {
          id = 39,
          type = "bool",
          label = "optional"
        },
        mental_dexterity = {
          id = 40,
          type = "int32",
          label = "optional"
        },
        unleashed_rage = {
          id = 41,
          type = "int32",
          label = "optional"
        },
        weapon_mastery = {
          id = 42,
          type = "int32",
          label = "optional"
        },
        frozen_power = {
          id = 43,
          type = "int32",
          label = "optional"
        },
        dual_wield_specialization = {
          id = 44,
          type = "int32",
          label = "optional"
        },
        dual_wield = {
          id = 45,
          type = "bool",
          label = "optional"
        },
        stormstrike = {
          id = 46,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 17364,
              label = "Stormstrike",
              cooldown = {
                raw = "time.Second * cooldownTime"
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagIncludeTargetBonusDamage",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "core.TernaryFloat64(shaman.HasSetBonus(ItemSetWorldbreakerBattlegear, 2), 1.2, 1)",
              crit_multiplier = "shaman.DefaultMeleeCritMultiplier()",
              threat_multiplier = "1",
              class_token = "shaman"
            }
          }
        },
        static_shock = {
          id = 47,
          type = "int32",
          label = "optional"
        },
        lava_lash = {
          id = 48,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 60103,
              label = "Lava Lash",
              cooldown = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskMeleeOHSpecial",
              damage_multiplier = "imbueMultiplier * core.TernaryFloat64(shaman.HasSetBonus(ItemSetWorldbreakerBattlegear, 2), 1.2, 1)",
              crit_multiplier = "shaman.ElementalCritMultiplier(0)",
              threat_multiplier = "shaman.spellThreatMultiplier()",
              class_token = "shaman"
            }
          }
        },
        improved_stormstrike = {
          id = 49,
          type = "int32",
          label = "optional"
        },
        mental_quickness = {
          id = 50,
          type = "int32",
          label = "optional"
        },
        shamanistic_rage = {
          id = 51,
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
              flags = "SpellFlagNoOnCastComplete",
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
        earthen_power = {
          id = 52,
          type = "int32",
          label = "optional"
        },
        maelstrom_weapon = {
          id = 53,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "shaman",
                label = "MaelstromWeapon",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "shaman"
              },
              {
                class = "shaman",
                spell_id = 53817,
                label = "MaelstromWeapon Proc",
                duration = {
                  raw = "time.Second * 30",
                  seconds = 30.0
                },
                class_token = "shaman"
              },
              {
                class = "shaman",
                spell_id = 70831,
                label = "Maelstrom Power",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "shaman"
              }
            }
          }
        },
        feral_spirit = {
          id = 54,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 51533,
              label = "Feral Spirit",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS",
                priority = "core.CooldownPriorityDrums + 1000"
              },
              class_token = "shaman"
            },
            aura = {
              class = "shaman",
              spell_id = 51533,
              label = "Feral Spirit",
              duration = {
                raw = "time.Second * 45",
                seconds = 45.0
              },
              class_token = "shaman"
            }
          }
        },
        improved_healing_wave = {
          id = 55,
          type = "int32",
          label = "optional"
        },
        totemic_focus = {
          id = 56,
          type = "int32",
          label = "optional"
        },
        improved_reincarnation = {
          id = 57,
          type = "int32",
          label = "optional"
        },
        healing_grace = {
          id = 58,
          type = "int32",
          label = "optional"
        },
        tidal_focus = {
          id = 59,
          type = "int32",
          label = "optional"
        },
        improved_water_shield = {
          id = 60,
          type = "int32",
          label = "optional"
        },
        healing_focus = {
          id = 61,
          type = "int32",
          label = "optional"
        },
        tidal_force = {
          id = 62,
          type = "bool",
          label = "optional"
        },
        ancestral_healing = {
          id = 63,
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
              damage_multiplier = "1 * (1 + .02*float64(shaman.Talents.Purification))",
              crit_multiplier = "1",
              threat_multiplier = "1 - (float64(shaman.Talents.HealingGrace) * 0.05)",
              class_token = "shaman"
            }
          }
        },
        restorative_totems = {
          id = 64,
          type = "int32",
          label = "optional"
        },
        tidal_mastery = {
          id = 65,
          type = "int32",
          label = "optional"
        },
        healing_way = {
          id = 66,
          type = "int32",
          label = "optional"
        },
        natures_swiftness = {
          id = 67,
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
        focused_mind = {
          id = 68,
          type = "int32",
          label = "optional"
        },
        purification = {
          id = 69,
          type = "int32",
          label = "optional"
        },
        natures_guardian = {
          id = 70,
          type = "int32",
          label = "optional"
        },
        mana_tide_totem = {
          id = 71,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 16190,
              label = "Mana Tide Totem",
              cooldown = {
                raw = "time.Minute * 5",
                seconds = 300.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              flags = "SpellFlagNoOnCastComplete",
              class_token = "shaman"
            },
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
        cleanse_spirit = {
          id = 72,
          type = "bool",
          label = "optional"
        },
        blessing_of_the_eternals = {
          id = 73,
          type = "int32",
          label = "optional"
        },
        improved_chain_heal = {
          id = 74,
          type = "int32",
          label = "optional"
        },
        natures_blessing = {
          id = 75,
          type = "int32",
          label = "optional"
        },
        ancestral_awakening = {
          id = 76,
          type = "int32",
          label = "optional"
        },
        earth_shield = {
          id = 77,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 49284,
              label = "Earth Shield",
              flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
              spell_school = "SpellSchoolNature",
              proc_mask = "2",
              damage_multiplier = "1 + 0.05*float64(shaman.Talents.ImprovedShields) + 0.05*float64(shaman.Talents.ImprovedEarthShield) + bonusHeal",
              threat_multiplier = "1",
              class_token = "shaman"
            }
          }
        },
        improved_earth_shield = {
          id = 78,
          type = "int32",
          label = "optional"
        },
        tidal_waves = {
          id = 79,
          type = "int32",
          label = "optional"
        },
        riptide = {
          id = 80,
          type = "bool",
          label = "optional",
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
              damage_multiplier = "1 * (1 + .02*float64(shaman.Talents.Purification))",
              crit_multiplier = "shaman.DefaultHealingCritMultiplier()",
              threat_multiplier = "1 - (float64(shaman.Talents.HealingGrace) * 0.05)",
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
        "call_of_flame",
        "elemental_warding",
        "elemental_devastation",
        "reverberation",
        "elemental_focus",
        "elemental_fury",
        "improved_fire_nova",
        "eye_of_the_storm",
        "elemental_reach",
        "call_of_thunder",
        "unrelenting_storm",
        "elemental_precision",
        "lightning_mastery",
        "elemental_mastery",
        "storm_earth_and_fire",
        "booming_echoes",
        "elemental_oath",
        "lightning_overload",
        "astral_shift",
        "totem_of_wrath",
        "lava_flows",
        "shamanism",
        "thunderstorm",
        "enhancing_totems",
        "earths_grasp",
        "ancestral_knowledge",
        "guardian_totems",
        "thundering_strikes",
        "improved_ghost_wolf",
        "improved_shields",
        "elemental_weapons",
        "shamanistic_focus",
        "anticipation",
        "flurry",
        "toughness",
        "improved_windfury_totem",
        "spirit_weapons",
        "mental_dexterity",
        "unleashed_rage",
        "weapon_mastery",
        "frozen_power",
        "dual_wield_specialization",
        "dual_wield",
        "stormstrike",
        "static_shock",
        "lava_lash",
        "improved_stormstrike",
        "mental_quickness",
        "shamanistic_rage",
        "earthen_power",
        "maelstrom_weapon",
        "feral_spirit",
        "improved_healing_wave",
        "totemic_focus",
        "improved_reincarnation",
        "healing_grace",
        "tidal_focus",
        "improved_water_shield",
        "healing_focus",
        "tidal_force",
        "ancestral_healing",
        "restorative_totems",
        "tidal_mastery",
        "healing_way",
        "natures_swiftness",
        "focused_mind",
        "purification",
        "natures_guardian",
        "mana_tide_totem",
        "cleanse_spirit",
        "blessing_of_the_eternals",
        "improved_chain_heal",
        "natures_blessing",
        "ancestral_awakening",
        "earth_shield",
        "improved_earth_shield",
        "tidal_waves",
        "riptide"
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
        use_fire_elemental = {
          id = 6,
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
        "use_fire_elemental",
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
    DruidTalents = {
      fields = {
        starlight_wrath = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        genesis = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        moonglow = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        natures_majesty = {
          id = 4,
          type = "int32",
          label = "optional"
        },
        improved_moonfire = {
          id = 5,
          type = "int32",
          label = "optional"
        },
        brambles = {
          id = 6,
          type = "int32",
          label = "optional"
        },
        natures_grace = {
          id = 7,
          type = "int32",
          label = "optional"
        },
        natures_splendor = {
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
        insect_swarm = {
          id = 13,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 48468,
              label = "Insect Swarm",
              flags = "SpellFlagOmenTrigger | core.SpellFlagAPL",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1 + 0.01*float64(druid.Talents.Genesis) + core.TernaryFloat64(druid.HasSetBonus(ItemSetDreamwalkerGarb, 2), 0.1, 0) + core.TernaryFloat64(druid.HasMajorGlyph(proto.DruidMajorGlyph_GlyphOfInsectSwarm), 0.3, 0)",
              threat_multiplier = "1",
              class_token = "druid"
            },
            aura = {
              class = "druid",
              spell_id = 64823,
              label = "Elune's Wrath",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "druid"
            }
          }
        },
        improved_insect_swarm = {
          id = 14,
          type = "int32",
          label = "optional"
        },
        dreamstate = {
          id = 15,
          type = "int32",
          label = "optional"
        },
        moonfury = {
          id = 16,
          type = "int32",
          label = "optional"
        },
        balance_of_power = {
          id = 17,
          type = "int32",
          label = "optional"
        },
        moonkin_form = {
          id = 18,
          type = "bool",
          label = "optional",
          _metadata = {
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
        improved_moonkin_form = {
          id = 19,
          type = "int32",
          label = "optional"
        },
        improved_faerie_fire = {
          id = 20,
          type = "int32",
          label = "optional"
        },
        owlkin_frenzy = {
          id = 21,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "druid",
              spell_id = 48393,
              label = "Owlkin Frenzy proc",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "druid"
            }
          }
        },
        wrath_of_cenarius = {
          id = 22,
          type = "int32",
          label = "optional"
        },
        eclipse = {
          id = 23,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "druid",
                label = "Eclipse (Lunar)",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "druid"
              },
              {
                class = "druid",
                spell_id = 48518,
                label = "Lunar Eclipse proc",
                duration = {
                  raw = "time.Millisecond * 15000",
                  seconds = 15.0
                },
                class_token = "druid"
              },
              {
                class = "druid",
                label = "Eclipse (Solar)",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "druid"
              },
              {
                class = "druid",
                spell_id = 48517,
                label = "Solar Eclipse proc",
                duration = {
                  raw = "time.Millisecond * 15000",
                  seconds = 15.0
                },
                class_token = "druid"
              }
            }
          }
        },
        typhoon = {
          id = 24,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 61384,
              label = "Typhoon",
              cooldown = {
                raw = "time.Second * (20 - core.TernaryDuration(druid.HasMajorGlyph(proto.DruidMajorGlyph_GlyphOfMonsoon), 3, 0))",
                cases = {
                  {
                    condition = "druid.HasMajorGlyph(proto.DruidMajorGlyph_GlyphOfMonsoon)",
                    raw = "time.Second * (20 - (3))",
                    seconds = 17.0
                  },
                  {
                    condition = "!(druid.HasMajorGlyph(proto.DruidMajorGlyph_GlyphOfMonsoon))",
                    raw = "time.Second * (20 - (0))",
                    seconds = 20.0
                  }
                }
              },
              flags = "SpellFlagOmenTrigger | core.SpellFlagAPL",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1 + 0.15*float64(druid.Talents.GaleWinds)",
              crit_multiplier = "1",
              threat_multiplier = "1",
              class_token = "druid"
            }
          }
        },
        force_of_nature = {
          id = 25,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 65861,
              label = "Force Of Nature",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              flags = "SpellFlagAPL",
              class_token = "druid"
            },
            aura = {
              class = "druid",
              spell_id = 65861,
              label = "Force of Nature",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "druid"
            }
          }
        },
        gale_winds = {
          id = 26,
          type = "int32",
          label = "optional"
        },
        earth_and_moon = {
          id = 27,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "druid",
              label = "Earth And Moon Talent",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "druid"
            },
            spell = {
              class = "druid",
              spell_id = 60432,
              label = "Earth And Moon",
              flags = "SpellFlagNoLogs",
              proc_mask = "ProcMaskSuppressedProc",
              class_token = "druid"
            }
          }
        },
        starfall = {
          id = 28,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              {
                class = "druid",
                spell_id = 53190,
                label = "StarfallSplash",
                class_token = "druid"
              },
              {
                class = "druid",
                spell_id = 53190,
                label = "Starfall",
                spell_school = "SpellSchoolArcane",
                proc_mask = "ProcMaskSuppressedProc",
                damage_multiplier = "1 * (1 + core.TernaryFloat64(druid.HasMajorGlyph(proto.DruidMajorGlyph_GlyphOfFocus), 0.1, 0))",
                crit_multiplier = "druid.BalanceCritMultiplier()",
                threat_multiplier = "1",
                class_token = "druid"
              },
              {
                class = "druid",
                spell_id = 53201,
                label = "Starfall",
                cooldown = {
                  raw = "time.Second * (90 - core.TernaryDuration(druid.HasMajorGlyph(proto.DruidMajorGlyph_GlyphOfStarfall), 30, 0))",
                  cases = {
                    {
                      condition = "druid.HasMajorGlyph(proto.DruidMajorGlyph_GlyphOfStarfall)",
                      raw = "time.Second * (90 - (30))",
                      seconds = 60.0
                    },
                    {
                      condition = "!(druid.HasMajorGlyph(proto.DruidMajorGlyph_GlyphOfStarfall))",
                      raw = "time.Second * (90 - (0))",
                      seconds = 90.0
                    }
                  }
                },
                flags = "core.SpellFlagAPL | SpellFlagOmenTrigger",
                spell_school = "SpellSchoolArcane",
                proc_mask = "ProcMaskSpellDamage",
                class_token = "druid"
              },
              {
                class = "druid",
                spell_id = 53195,
                label = "Starfall",
                flags = "core.SpellFlagAgentReserved1",
                spell_school = "SpellSchoolArcane",
                proc_mask = "ProcMaskSuppressedProc",
                damage_multiplier = "1 * (1 + core.TernaryFloat64(druid.HasMajorGlyph(proto.DruidMajorGlyph_GlyphOfFocus), 0.1, 0))",
                crit_multiplier = "druid.BalanceCritMultiplier()",
                threat_multiplier = "1",
                class_token = "druid"
              }
            }
          }
        },
        ferocity = {
          id = 29,
          type = "int32",
          label = "optional"
        },
        feral_aggression = {
          id = 30,
          type = "int32",
          label = "optional"
        },
        feral_instinct = {
          id = 31,
          type = "int32",
          label = "optional"
        },
        savage_fury = {
          id = 32,
          type = "int32",
          label = "optional"
        },
        thick_hide = {
          id = 33,
          type = "int32",
          label = "optional"
        },
        feral_swiftness = {
          id = 34,
          type = "int32",
          label = "optional"
        },
        survival_instincts = {
          id = 35,
          type = "bool",
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
              flags = "core.SpellFlagAgentReserved2",
              class_token = "druid"
            },
            aura = {
              class = "druid",
              spell_id = 61336,
              label = "Survival Instincts",
              duration = {
                cases = {
                  {
                    condition = "druid.HasSetBonus(ItemSetNightsongBattlegear, 4)",
                    raw = "time.Second*20 + (8*time.Second)",
                    seconds = 28.0
                  },
                  {
                    condition = "!(druid.HasSetBonus(ItemSetNightsongBattlegear, 4))",
                    raw = "time.Second*20 + (0)",
                    seconds = 20.0
                  }
                },
                raw = "time.Second*20 + core.TernaryDuration(druid.HasSetBonus(ItemSetNightsongBattlegear, 4), 8*time.Second, 0)"
              },
              duration_raw = "time.Second*20 + core.TernaryDuration(druid.HasSetBonus(ItemSetNightsongBattlegear, 4), 8*time.Second, 0)",
              class_token = "druid"
            }
          }
        },
        sharpened_claws = {
          id = 36,
          type = "int32",
          label = "optional"
        },
        shredding_attacks = {
          id = 37,
          type = "int32",
          label = "optional"
        },
        predatory_strikes = {
          id = 38,
          type = "int32",
          label = "optional"
        },
        primal_fury = {
          id = 39,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "druid",
              spell_id = 37117,
              label = "Primal Fury",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "druid"
            }
          }
        },
        primal_precision = {
          id = 40,
          type = "int32",
          label = "optional"
        },
        brutal_impact = {
          id = 41,
          type = "int32",
          label = "optional"
        },
        feral_charge = {
          id = 42,
          type = "bool",
          label = "optional"
        },
        nurturing_instinct = {
          id = 43,
          type = "int32",
          label = "optional"
        },
        natural_reaction = {
          id = 44,
          type = "int32",
          label = "optional"
        },
        heart_of_the_wild = {
          id = 45,
          type = "int32",
          label = "optional"
        },
        survival_of_the_fittest = {
          id = 46,
          type = "int32",
          label = "optional"
        },
        leader_of_the_pack = {
          id = 47,
          type = "bool",
          label = "optional"
        },
        improved_leader_of_the_pack = {
          id = 48,
          type = "int32",
          label = "optional"
        },
        primal_tenacity = {
          id = 49,
          type = "int32",
          label = "optional"
        },
        protector_of_the_pack = {
          id = 50,
          type = "int32",
          label = "optional"
        },
        predatory_instincts = {
          id = 51,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "druid",
              label = "Predatory Instincts",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "druid"
            }
          }
        },
        infected_wounds = {
          id = 52,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "druid",
              label = "Infected Wounds Talent",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "druid"
            }
          }
        },
        king_of_the_jungle = {
          id = 53,
          type = "int32",
          label = "optional"
        },
        mangle = {
          id = 54,
          type = "bool",
          label = "optional"
        },
        improved_mangle = {
          id = 55,
          type = "int32",
          label = "optional"
        },
        rend_and_tear = {
          id = 56,
          type = "int32",
          label = "optional"
        },
        primal_gore = {
          id = 57,
          type = "bool",
          label = "optional"
        },
        berserk = {
          id = 58,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 50334,
              label = "Berserk",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              flags = "SpellFlagAPL",
              class_token = "druid"
            },
            aura = {
              class = "druid",
              spell_id = 50334,
              label = "Berserk",
              duration = {
                raw = "(time.Second * 15) + glyphBonus"
              },
              class_token = "druid"
            }
          }
        },
        improved_mark_of_the_wild = {
          id = 59,
          type = "int32",
          label = "optional"
        },
        natures_focus = {
          id = 60,
          type = "int32",
          label = "optional"
        },
        furor = {
          id = 61,
          type = "int32",
          label = "optional"
        },
        naturalist = {
          id = 62,
          type = "int32",
          label = "optional"
        },
        subtlety = {
          id = 63,
          type = "int32",
          label = "optional"
        },
        natural_shapeshifter = {
          id = 64,
          type = "int32",
          label = "optional"
        },
        intensity = {
          id = 65,
          type = "int32",
          label = "optional"
        },
        omen_of_clarity = {
          id = 66,
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
              },
              {
                class = "druid",
                spell_id = 70718,
                label = "T10-2P proc",
                duration = {
                  raw = "time.Second * 6",
                  seconds = 6.0
                },
                class_token = "druid"
              }
            }
          }
        },
        master_shapeshifter = {
          id = 67,
          type = "int32",
          label = "optional"
        },
        tranquil_spirit = {
          id = 68,
          type = "int32",
          label = "optional"
        },
        improved_rejuvenation = {
          id = 69,
          type = "int32",
          label = "optional"
        },
        natures_swiftness = {
          id = 70,
          type = "bool",
          label = "optional",
          _metadata = {
            aura = {
              class = "druid",
              spell_id = 17116,
              label = "Natures Swiftness",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "druid"
            },
            spell = {
              class = "druid",
              spell_id = 17116,
              label = "Natures Swiftness",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              flags = "SpellFlagNoOnCastComplete",
              class_token = "druid"
            }
          }
        },
        gift_of_nature = {
          id = 71,
          type = "int32",
          label = "optional"
        },
        improved_tranquility = {
          id = 72,
          type = "int32",
          label = "optional"
        },
        empowered_touch = {
          id = 73,
          type = "int32",
          label = "optional"
        },
        natures_bounty = {
          id = 74,
          type = "int32",
          label = "optional"
        },
        living_spirit = {
          id = 75,
          type = "int32",
          label = "optional"
        },
        swiftmend = {
          id = 76,
          type = "bool",
          label = "optional"
        },
        natural_perfection = {
          id = 77,
          type = "int32",
          label = "optional"
        },
        empowered_rejuvenation = {
          id = 78,
          type = "int32",
          label = "optional"
        },
        living_seed = {
          id = 79,
          type = "int32",
          label = "optional"
        },
        revitalize = {
          id = 80,
          type = "int32",
          label = "optional"
        },
        tree_of_life = {
          id = 81,
          type = "bool",
          label = "optional"
        },
        improved_tree_of_life = {
          id = 82,
          type = "int32",
          label = "optional"
        },
        improved_barkskin = {
          id = 83,
          type = "int32",
          label = "optional"
        },
        gift_of_the_earthmother = {
          id = 84,
          type = "int32",
          label = "optional"
        },
        wild_growth = {
          id = 85,
          type = "bool",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "starlight_wrath",
        "genesis",
        "moonglow",
        "natures_majesty",
        "improved_moonfire",
        "brambles",
        "natures_grace",
        "natures_splendor",
        "natures_reach",
        "vengeance",
        "celestial_focus",
        "lunar_guidance",
        "insect_swarm",
        "improved_insect_swarm",
        "dreamstate",
        "moonfury",
        "balance_of_power",
        "moonkin_form",
        "improved_moonkin_form",
        "improved_faerie_fire",
        "owlkin_frenzy",
        "wrath_of_cenarius",
        "eclipse",
        "typhoon",
        "force_of_nature",
        "gale_winds",
        "earth_and_moon",
        "starfall",
        "ferocity",
        "feral_aggression",
        "feral_instinct",
        "savage_fury",
        "thick_hide",
        "feral_swiftness",
        "survival_instincts",
        "sharpened_claws",
        "shredding_attacks",
        "predatory_strikes",
        "primal_fury",
        "primal_precision",
        "brutal_impact",
        "feral_charge",
        "nurturing_instinct",
        "natural_reaction",
        "heart_of_the_wild",
        "survival_of_the_fittest",
        "leader_of_the_pack",
        "improved_leader_of_the_pack",
        "primal_tenacity",
        "protector_of_the_pack",
        "predatory_instincts",
        "infected_wounds",
        "king_of_the_jungle",
        "mangle",
        "improved_mangle",
        "rend_and_tear",
        "primal_gore",
        "berserk",
        "improved_mark_of_the_wild",
        "natures_focus",
        "furor",
        "naturalist",
        "subtlety",
        "natural_shapeshifter",
        "intensity",
        "omen_of_clarity",
        "master_shapeshifter",
        "tranquil_spirit",
        "improved_rejuvenation",
        "natures_swiftness",
        "gift_of_nature",
        "improved_tranquility",
        "empowered_touch",
        "natures_bounty",
        "living_spirit",
        "swiftmend",
        "natural_perfection",
        "empowered_rejuvenation",
        "living_seed",
        "revitalize",
        "tree_of_life",
        "improved_tree_of_life",
        "improved_barkskin",
        "gift_of_the_earthmother",
        "wild_growth"
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
        tactical_mastery = {
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
        impale = {
          id = 9,
          type = "int32",
          label = "optional",
          _metadata = {
            spell = {
              class = "encounters",
              spec = "toc",
              spell_id = 66331,
              label = "Impale Bleed",
              cooldown = {
                raw = "time.Millisecond * 10000",
                seconds = 10.0
              },
              flags = "SpellFlagMeleeMetrics",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              crit_multiplier = "1",
              class_token = "encounters",
              spec_token = "toc"
            }
          }
        },
        deep_wounds = {
          id = 10,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "warrior",
              label = "Deep Wounds Talent",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "warrior"
            },
            spell = {
              class = "warrior",
              spell_id = 12867,
              label = "DeepWounds",
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreModifiers",
              spell_school = "2",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "warrior"
            }
          }
        },
        two_handed_weapon_specialization = {
          id = 11,
          type = "int32",
          label = "optional"
        },
        taste_for_blood = {
          id = 12,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "warrior",
              label = "Taste for Blood",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "warrior"
            }
          }
        },
        poleaxe_specialization = {
          id = 13,
          type = "int32",
          label = "optional"
        },
        sweeping_strikes = {
          id = 14,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              {
                class = "warrior",
                spell_id = 12723,
                label = "Sweeping Strikes",
                cooldown = {
                  raw = "time.Second * 30",
                  seconds = 30.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                spell_school = "2",
                class_token = "warrior"
              },
              {
                class = "warrior",
                spell_id = 12723,
                label = "Sweeping Strikes",
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreAttackerModifiers",
                spell_school = "2",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "warrior"
              }
            },
            aura = {
              class = "warrior",
              spell_id = 12723,
              label = "Sweeping Strikes",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "warrior"
            }
          }
        },
        mace_specialization = {
          id = 15,
          type = "int32",
          label = "optional"
        },
        sword_specialization = {
          id = 16,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "warrior",
              label = "Sword Specialization",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "warrior"
            }
          }
        },
        weapon_mastery = {
          id = 17,
          type = "int32",
          label = "optional"
        },
        improved_hamstring = {
          id = 18,
          type = "int32",
          label = "optional"
        },
        trauma = {
          id = 19,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "warrior",
              label = "Trauma",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "warrior"
            }
          }
        },
        second_wind = {
          id = 20,
          type = "int32",
          label = "optional"
        },
        mortal_strike = {
          id = 21,
          type = "bool",
          label = "optional"
        },
        strength_of_arms = {
          id = 22,
          type = "int32",
          label = "optional"
        },
        improved_slam = {
          id = 23,
          type = "int32",
          label = "optional"
        },
        juggernaut = {
          id = 24,
          type = "bool",
          label = "optional"
        },
        improved_mortal_strike = {
          id = 25,
          type = "int32",
          label = "optional"
        },
        unrelenting_assault = {
          id = 26,
          type = "int32",
          label = "optional"
        },
        sudden_death = {
          id = 27,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "warrior",
                label = "Sudden Death",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "warrior"
              },
              {
                class = "warrior",
                spell_id = 70847,
                label = "Ymirjar 4pc (Sudden Death) Proc",
                duration = {
                  raw = "time.Second * 20",
                  seconds = 20.0
                },
                class_token = "warrior"
              },
              {
                class = "warrior",
                spell_id = 29724,
                label = "Sudden Death Proc",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "warrior"
              }
            }
          }
        },
        endless_rage = {
          id = 28,
          type = "bool",
          label = "optional"
        },
        blood_frenzy = {
          id = 29,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "warrior",
              label = "Blood Frenzy Talent",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "warrior"
            }
          }
        },
        wrecking_crew = {
          id = 30,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "warrior",
                label = "Wrecking Crew",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "warrior"
              },
              {
                class = "warrior",
                spell_id = 57518,
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
        bladestorm = {
          id = 31,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              {
                class = "warrior",
                spell_id = 46924,
                label = "Bladestorm",
                cooldown = {
                  raw = "core.TernaryDuration(warrior.HasMajorGlyph(proto.WarriorMajorGlyph_GlyphOfBladestorm), time.Second*75, time.Second*90)",
                  cases = {
                    {
                      condition = "warrior.HasMajorGlyph(proto.WarriorMajorGlyph_GlyphOfBladestorm)",
                      raw = "(time.Second*75)",
                      seconds = 75.0
                    },
                    {
                      condition = "!(warrior.HasMajorGlyph(proto.WarriorMajorGlyph_GlyphOfBladestorm))",
                      raw = "(time.Second*90)",
                      seconds = 90.0
                    }
                  }
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "core.SpellFlagChanneled | core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
                spell_school = "2",
                proc_mask = "ProcMaskMeleeMHSpecial",
                damage_multiplier = "1",
                crit_multiplier = "warrior.critMultiplier(mh)",
                threat_multiplier = "1.25",
                class_token = "warrior"
              },
              {
                class = "warrior",
                spell_id = 46924,
                label = "Bladestorm",
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
                spell_school = "2",
                proc_mask = "ProcMaskMeleeOHSpecial",
                damage_multiplier = "1 + 0.05*float64(warrior.Talents.DualWieldSpecialization)",
                crit_multiplier = "warrior.critMultiplier(oh)",
                threat_multiplier = "1.25",
                class_token = "warrior"
              }
            }
          }
        },
        armored_to_the_teeth = {
          id = 32,
          type = "int32",
          label = "optional"
        },
        booming_voice = {
          id = 33,
          type = "int32",
          label = "optional"
        },
        cruelty = {
          id = 34,
          type = "int32",
          label = "optional"
        },
        improved_demoralizing_shout = {
          id = 35,
          type = "int32",
          label = "optional"
        },
        unbridled_wrath = {
          id = 36,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "warrior",
              spell_id = 13002,
              label = "Unbridled Wrath",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "warrior"
            }
          }
        },
        improved_cleave = {
          id = 37,
          type = "int32",
          label = "optional"
        },
        piercing_howl = {
          id = 38,
          type = "bool",
          label = "optional"
        },
        blood_craze = {
          id = 39,
          type = "int32",
          label = "optional"
        },
        commanding_presence = {
          id = 40,
          type = "int32",
          label = "optional"
        },
        dual_wield_specialization = {
          id = 41,
          type = "int32",
          label = "optional"
        },
        improved_execute = {
          id = 42,
          type = "int32",
          label = "optional"
        },
        enrage = {
          id = 43,
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
              class = "druid",
              spell_id = 5229,
              label = "Enrage Aura",
              duration = {
                raw = "10 * time.Second",
                seconds = 10.0
              },
              class_token = "druid"
            }
          }
        },
        precision = {
          id = 44,
          type = "int32",
          label = "optional"
        },
        death_wish = {
          id = 45,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 12292,
              label = "Death Wish",
              cooldown = {
                raw = "warrior.intensifyRageCooldown(time.Minute * 3)"
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              class_token = "warrior"
            },
            aura = {
              class = "warrior",
              spell_id = 12292,
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
          id = 46,
          type = "int32",
          label = "optional"
        },
        improved_berserker_rage = {
          id = 47,
          type = "int32",
          label = "optional"
        },
        flurry = {
          id = 48,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "warrior",
                label = "Flurry",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "warrior"
              },
              {
                class = "warrior",
                spell_id = 12974,
                label = "Flurry Proc",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "warrior"
              }
            }
          }
        },
        intensify_rage = {
          id = 49,
          type = "int32",
          label = "optional"
        },
        bloodthirst = {
          id = 50,
          type = "bool",
          label = "optional"
        },
        improved_whirlwind = {
          id = 51,
          type = "int32",
          label = "optional"
        },
        furious_attacks = {
          id = 52,
          type = "int32",
          label = "optional"
        },
        improved_berserker_stance = {
          id = 53,
          type = "int32",
          label = "optional"
        },
        heroic_fury = {
          id = 54,
          type = "bool",
          label = "optional"
        },
        rampage = {
          id = 55,
          type = "bool",
          label = "optional"
        },
        bloodsurge = {
          id = 56,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "warrior",
                label = "Bloodsurge",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "warrior"
              },
              {
                class = "warrior",
                spell_id = 70847,
                label = "Ymirjar 4pc (Bloodsurge) Proc",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "warrior"
              },
              {
                class = "warrior",
                spell_id = 46916,
                label = "Bloodsurge Proc",
                duration = {
                  raw = "time.Second * 5",
                  seconds = 5.0
                },
                class_token = "warrior"
              }
            }
          }
        },
        unending_fury = {
          id = 57,
          type = "int32",
          label = "optional"
        },
        titans_grip = {
          id = 58,
          type = "bool",
          label = "optional"
        },
        improved_bloodrage = {
          id = 59,
          type = "int32",
          label = "optional"
        },
        shield_specialization = {
          id = 60,
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
        improved_thunder_clap = {
          id = 61,
          type = "int32",
          label = "optional"
        },
        incite = {
          id = 62,
          type = "int32",
          label = "optional"
        },
        anticipation = {
          id = 63,
          type = "int32",
          label = "optional"
        },
        last_stand = {
          id = 64,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 12975,
              label = "Last Stand",
              cooldown = {
                raw = "core.TernaryDuration(warrior.HasMajorGlyph(proto.WarriorMajorGlyph_GlyphOfLastStand), time.Minute*3, time.Minute*2)",
                cases = {
                  {
                    condition = "warrior.HasMajorGlyph(proto.WarriorMajorGlyph_GlyphOfLastStand)",
                    raw = "(time.Minute*3)",
                    seconds = 180.0
                  },
                  {
                    condition = "!(warrior.HasMajorGlyph(proto.WarriorMajorGlyph_GlyphOfLastStand))",
                    raw = "(time.Minute*2)",
                    seconds = 120.0
                  }
                }
              },
              major_cooldown = {
                type = "core.CooldownTypeSurvival"
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
        improved_revenge = {
          id = 65,
          type = "int32",
          label = "optional"
        },
        shield_mastery = {
          id = 66,
          type = "int32",
          label = "optional"
        },
        toughness = {
          id = 67,
          type = "int32",
          label = "optional"
        },
        improved_spell_reflection = {
          id = 68,
          type = "int32",
          label = "optional"
        },
        improved_disarm = {
          id = 69,
          type = "int32",
          label = "optional"
        },
        puncture = {
          id = 70,
          type = "int32",
          label = "optional"
        },
        improved_disciplines = {
          id = 71,
          type = "int32",
          label = "optional"
        },
        concussion_blow = {
          id = 72,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 12809,
              label = "Concussion Blow",
              cooldown = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              crit_multiplier = "warrior.critMultiplier(mh)",
              threat_multiplier = "2",
              class_token = "warrior"
            }
          }
        },
        gag_order = {
          id = 73,
          type = "int32",
          label = "optional"
        },
        one_handed_weapon_specialization = {
          id = 74,
          type = "int32",
          label = "optional"
        },
        improved_defensive_stance = {
          id = 75,
          type = "int32",
          label = "optional"
        },
        vigilance = {
          id = 76,
          type = "bool",
          label = "optional"
        },
        focused_rage = {
          id = 77,
          type = "int32",
          label = "optional"
        },
        vitality = {
          id = 78,
          type = "int32",
          label = "optional"
        },
        safeguard = {
          id = 79,
          type = "int32",
          label = "optional"
        },
        warbringer = {
          id = 80,
          type = "bool",
          label = "optional"
        },
        devastate = {
          id = 81,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 47498,
              label = "Devastate",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "core.TernaryFloat64(warrior.HasSetBonus(ItemSetWrynnsPlate, 2), 1.05, 1.00)",
              crit_multiplier = "warrior.critMultiplier(mh)",
              threat_multiplier = "1",
              class_token = "warrior"
            }
          }
        },
        critical_block = {
          id = 82,
          type = "int32",
          label = "optional",
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 47296,
              label = "Critical Block",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete",
              class_token = "warrior"
            }
          }
        },
        sword_and_board = {
          id = 83,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "warrior",
                label = "Sword And Board Trigger",
                class_token = "warrior"
              },
              {
                class = "warrior",
                spell_id = 46953,
                label = "Sword And Board",
                duration = {
                  raw = "5 * time.Second",
                  seconds = 5.0
                },
                class_token = "warrior"
              }
            }
          }
        },
        damage_shield = {
          id = 84,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "warrior",
              label = "Damage Shield Trigger",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "warrior"
            },
            spell = {
              class = "warrior",
              spell_id = 58874,
              label = "Damage Shield",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete",
              spell_school = "2",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "warrior"
            }
          }
        },
        shockwave = {
          id = 85,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 46968,
              label = "Shockwave",
              cooldown = {
                raw = "20*time.Second - core.TernaryDuration(warrior.HasMajorGlyph(proto.WarriorMajorGlyph_GlyphOfShockwave), 3*time.Second, 0)",
                cases = {
                  {
                    condition = "warrior.HasMajorGlyph(proto.WarriorMajorGlyph_GlyphOfShockwave)",
                    raw = "20*time.Second - (3*time.Second)",
                    seconds = 17.0
                  },
                  {
                    condition = "!(warrior.HasMajorGlyph(proto.WarriorMajorGlyph_GlyphOfShockwave))",
                    raw = "20*time.Second - (0)",
                    seconds = 20.0
                  }
                }
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskRangedSpecial",
              damage_multiplier = "1 + core.TernaryFloat64(warrior.HasSetBonus(ItemSetYmirjarLordsPlate, 2), .20, 0)",
              crit_multiplier = "warrior.critMultiplier(none)",
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
        "iron_will",
        "tactical_mastery",
        "improved_overpower",
        "anger_management",
        "impale",
        "deep_wounds",
        "two_handed_weapon_specialization",
        "taste_for_blood",
        "poleaxe_specialization",
        "sweeping_strikes",
        "mace_specialization",
        "sword_specialization",
        "weapon_mastery",
        "improved_hamstring",
        "trauma",
        "second_wind",
        "mortal_strike",
        "strength_of_arms",
        "improved_slam",
        "juggernaut",
        "improved_mortal_strike",
        "unrelenting_assault",
        "sudden_death",
        "endless_rage",
        "blood_frenzy",
        "wrecking_crew",
        "bladestorm",
        "armored_to_the_teeth",
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
        "precision",
        "death_wish",
        "improved_intercept",
        "improved_berserker_rage",
        "flurry",
        "intensify_rage",
        "bloodthirst",
        "improved_whirlwind",
        "furious_attacks",
        "improved_berserker_stance",
        "heroic_fury",
        "rampage",
        "bloodsurge",
        "unending_fury",
        "titans_grip",
        "improved_bloodrage",
        "shield_specialization",
        "improved_thunder_clap",
        "incite",
        "anticipation",
        "last_stand",
        "improved_revenge",
        "shield_mastery",
        "toughness",
        "improved_spell_reflection",
        "improved_disarm",
        "puncture",
        "improved_disciplines",
        "concussion_blow",
        "gag_order",
        "one_handed_weapon_specialization",
        "improved_defensive_stance",
        "vigilance",
        "focused_rage",
        "vitality",
        "safeguard",
        "warbringer",
        "devastate",
        "critical_block",
        "sword_and_board",
        "damage_shield",
        "shockwave"
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
    ProtectionWarrior = {
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
        arcane_stability = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        arcane_fortitude = {
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
                spell_id = 12536,
                label = "Clearcasting",
                duration = {
                  raw = "time.Second * 15",
                  seconds = 15.0
                },
                class_token = "mage"
              },
              {
                class = "mage",
                spell_id = 31572,
                label = "Arcane Potency",
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
        spell_impact = {
          id = 8,
          type = "int32",
          label = "optional"
        },
        student_of_the_mind = {
          id = 9,
          type = "int32",
          label = "optional"
        },
        focus_magic = {
          id = 10,
          type = "bool",
          label = "optional"
        },
        arcane_shielding = {
          id = 11,
          type = "int32",
          label = "optional"
        },
        improved_counterspell = {
          id = 12,
          type = "int32",
          label = "optional"
        },
        arcane_meditation = {
          id = 13,
          type = "int32",
          label = "optional"
        },
        torment_the_weak = {
          id = 14,
          type = "int32",
          label = "optional"
        },
        improved_blink = {
          id = 15,
          type = "int32",
          label = "optional"
        },
        presence_of_mind = {
          id = 16,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 12043,
              label = "Presence Of Mind",
              cooldown = {
                raw = "cooldown * time.Second"
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              flags = "SpellFlagNoOnCastComplete",
              class_token = "mage"
            }
          }
        },
        arcane_mind = {
          id = 17,
          type = "int32",
          label = "optional"
        },
        prismatic_cloak = {
          id = 18,
          type = "int32",
          label = "optional"
        },
        arcane_instability = {
          id = 19,
          type = "int32",
          label = "optional"
        },
        arcane_potency = {
          id = 20,
          type = "int32",
          label = "optional"
        },
        arcane_empowerment = {
          id = 21,
          type = "int32",
          label = "optional"
        },
        arcane_power = {
          id = 22,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 12042,
              label = "Arcane Power",
              cooldown = {
                raw = "time.Second * 120*(1-(.15*mage.Talents.ArcaneFlows))"
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
                cases = {
                  {
                    condition = "mage.HasMajorGlyph(proto.MageMajorGlyph_GlyphOfArcanePower)",
                    raw = "(time.Second*18)",
                    seconds = 18.0
                  },
                  {
                    condition = "!(mage.HasMajorGlyph(proto.MageMajorGlyph_GlyphOfArcanePower))",
                    raw = "(time.Second*15)",
                    seconds = 15.0
                  }
                },
                raw = "core.TernaryDuration(mage.HasMajorGlyph(proto.MageMajorGlyph_GlyphOfArcanePower), time.Second*18, time.Second*15)"
              },
              duration_raw = "core.TernaryDuration(mage.HasMajorGlyph(proto.MageMajorGlyph_GlyphOfArcanePower), time.Second*18, time.Second*15)",
              class_token = "mage"
            }
          }
        },
        incanters_absorption = {
          id = 23,
          type = "int32",
          label = "optional"
        },
        arcane_flows = {
          id = 24,
          type = "int32",
          label = "optional"
        },
        mind_mastery = {
          id = 25,
          type = "int32",
          label = "optional"
        },
        slow = {
          id = 26,
          type = "bool",
          label = "optional"
        },
        missile_barrage = {
          id = 27,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "mage",
                label = "Missile Barrage Talent",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "mage"
              },
              {
                class = "mage",
                spell_id = 44401,
                label = "Missile Barrage Proc",
                duration = {
                  raw = "time.Second * 15",
                  seconds = 15.0
                },
                class_token = "mage"
              }
            }
          }
        },
        netherwind_presence = {
          id = 28,
          type = "int32",
          label = "optional"
        },
        spell_power = {
          id = 29,
          type = "int32",
          label = "optional"
        },
        arcane_barrage = {
          id = 30,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 44781,
              label = "Arcane Barrage",
              cooldown = {
                raw = "time.Second * 3",
                seconds = 3.0
              },
              flags = "SpellFlagMage | BarrageSpells | core.SpellFlagAPL",
              spell_school = "SpellSchoolFrost",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1 + .04*float64(mage.Talents.TormentTheWeak)",
              crit_multiplier = "mage.SpellCritMultiplier(1, mage.bonusCritDamage)",
              threat_multiplier = "1 - 0.2*float64(mage.Talents.ArcaneSubtlety)",
              class_token = "mage"
            }
          }
        },
        improved_fire_blast = {
          id = 31,
          type = "int32",
          label = "optional"
        },
        incineration = {
          id = 32,
          type = "int32",
          label = "optional"
        },
        improved_fireball = {
          id = 33,
          type = "int32",
          label = "optional"
        },
        ignite = {
          id = 34,
          type = "int32",
          label = "optional",
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 12654,
              label = "Ignite",
              flags = "SpellFlagMage | core.SpellFlagIgnoreModifiers",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskProc",
              damage_multiplier = "1",
              threat_multiplier = "1 - 0.1*float64(mage.Talents.BurningSoul)",
              class_token = "mage"
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
        burning_determination = {
          id = 35,
          type = "int32",
          label = "optional"
        },
        world_in_flames = {
          id = 36,
          type = "int32",
          label = "optional"
        },
        flame_throwing = {
          id = 37,
          type = "int32",
          label = "optional"
        },
        impact = {
          id = 38,
          type = "int32",
          label = "optional"
        },
        pyroblast = {
          id = 39,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              {
                class = "mage",
                spell_id = 42891,
                label = "Pyroblast",
                flags = "SpellFlagMage | core.SpellFlagAPL",
                spell_school = "SpellSchoolFire",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1 * (1 + .04*float64(mage.Talents.TormentTheWeak))",
                damage_multiplier_additive = "1 + .02*float64(mage.Talents.FirePower)",
                crit_multiplier = "mage.SpellCritMultiplier(1, mage.bonusCritDamage)",
                threat_multiplier = "1 - 0.1*float64(mage.Talents.BurningSoul)",
                class_token = "mage"
              },
              {
                class = "mage",
                spell_id = 42891,
                label = "Pyroblast",
                flags = "SpellFlagMage | core.SpellFlagAPL",
                spell_school = "SpellSchoolFire",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1 * (1 + .04*float64(mage.Talents.TormentTheWeak))",
                damage_multiplier_additive = "1 + .02*float64(mage.Talents.FirePower)",
                crit_multiplier = "mage.SpellCritMultiplier(1, mage.bonusCritDamage)",
                threat_multiplier = "1 - 0.1*float64(mage.Talents.BurningSoul)",
                class_token = "mage"
              }
            }
          }
        },
        burning_soul = {
          id = 40,
          type = "int32",
          label = "optional"
        },
        improved_scorch = {
          id = 41,
          type = "int32",
          label = "optional"
        },
        molten_shields = {
          id = 42,
          type = "int32",
          label = "optional"
        },
        master_of_elements = {
          id = 43,
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
        playing_with_fire = {
          id = 44,
          type = "int32",
          label = "optional"
        },
        critical_mass = {
          id = 45,
          type = "int32",
          label = "optional"
        },
        blast_wave = {
          id = 46,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 42945,
              label = "Blast Wave",
              cooldown = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              flags = "SpellFlagMage | core.SpellFlagAPL",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier_additive = "1 + .02*float64(mage.Talents.SpellImpact) + .02*float64(mage.Talents.FirePower)",
              crit_multiplier = "mage.SpellCritMultiplier(1, mage.bonusCritDamage)",
              threat_multiplier = "1 - 0.1*float64(mage.Talents.BurningSoul)",
              class_token = "mage"
            }
          }
        },
        blazing_speed = {
          id = 47,
          type = "int32",
          label = "optional"
        },
        fire_power = {
          id = 48,
          type = "int32",
          label = "optional"
        },
        pyromaniac = {
          id = 49,
          type = "int32",
          label = "optional"
        },
        combustion = {
          id = 50,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 11129,
              label = "Combustion",
              cooldown = {
                raw = "time.Minute * 2",
                seconds = 120.0
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
        molten_fury = {
          id = 51,
          type = "int32",
          label = "optional"
        },
        fiery_payback = {
          id = 52,
          type = "int32",
          label = "optional"
        },
        empowered_fire = {
          id = 53,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "mage",
              spell_id = 67545,
              label = "Empowered Fire",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "mage"
            }
          }
        },
        firestarter = {
          id = 54,
          type = "int32",
          label = "optional"
        },
        dragons_breath = {
          id = 55,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 42950,
              label = "Dragons Breath",
              cooldown = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              flags = "SpellFlagMage | core.SpellFlagAPL",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier_additive = "1 + .02*float64(mage.Talents.FirePower)",
              crit_multiplier = "mage.SpellCritMultiplier(1, mage.bonusCritDamage)",
              threat_multiplier = "1 - 0.1*float64(mage.Talents.BurningSoul)",
              class_token = "mage"
            }
          }
        },
        hot_streak = {
          id = 56,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "mage",
                label = "Hot Streak Trigger",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "mage"
              },
              {
                class = "mage",
                spell_id = 44448,
                label = "Hot Streak Proc Aura",
                duration_raw = "time.Hour",
                class_token = "mage"
              },
              {
                class = "mage",
                spell_id = 44448,
                label = "HotStreak",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "mage"
              }
            }
          }
        },
        burnout = {
          id = 57,
          type = "int32",
          label = "optional"
        },
        living_bomb = {
          id = 58,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              {
                class = "mage",
                spell_id = 55360,
                label = "LivingBomb",
                flags = "SpellFlagMage | core.SpellFlagAPL",
                spell_school = "SpellSchoolFire",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier_additive = "1 + .02*float64(mage.Talents.FirePower)",
                crit_multiplier = "mage.SpellCritMultiplier(1, mage.bonusCritDamage)",
                threat_multiplier = "1 - 0.1*float64(mage.Talents.BurningSoul)",
                class_token = "mage"
              },
              {
                class = "mage",
                spell_id = 55362,
                label = "Living Bomb",
                flags = "SpellFlagMage | HotStreakSpells",
                spell_school = "SpellSchoolFire",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier_additive = "1 + .02*float64(mage.Talents.FirePower)",
                crit_multiplier = "mage.SpellCritMultiplier(1, mage.bonusCritDamage)",
                threat_multiplier = "1 - 0.1*float64(mage.Talents.BurningSoul)",
                class_token = "mage"
              }
            }
          }
        },
        frostbite = {
          id = 59,
          type = "int32",
          label = "optional"
        },
        improved_frostbolt = {
          id = 60,
          type = "int32",
          label = "optional"
        },
        ice_floes = {
          id = 61,
          type = "int32",
          label = "optional"
        },
        ice_shards = {
          id = 62,
          type = "int32",
          label = "optional"
        },
        frost_warding = {
          id = 63,
          type = "int32",
          label = "optional"
        },
        precision = {
          id = 64,
          type = "int32",
          label = "optional"
        },
        permafrost = {
          id = 65,
          type = "int32",
          label = "optional"
        },
        piercing_ice = {
          id = 66,
          type = "int32",
          label = "optional"
        },
        icy_veins = {
          id = 67,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 12472,
              label = "Icy Veins",
              cooldown = {
                raw = "time.Second * 180*[]float64{1, .93, .86, .80}[mage.Talents.IceFloes]"
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              flags = "SpellFlagNoOnCastComplete",
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
          id = 68,
          type = "int32",
          label = "optional"
        },
        arctic_reach = {
          id = 69,
          type = "int32",
          label = "optional"
        },
        frost_channeling = {
          id = 70,
          type = "int32",
          label = "optional"
        },
        shatter = {
          id = 71,
          type = "int32",
          label = "optional"
        },
        cold_snap = {
          id = 72,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 11958,
              label = "Cold Snap",
              cooldown = {
                raw = "time.Minute*8 * (1.0 - mage.Talents.ColdAsIce*0.1)"
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              flags = "SpellFlagNoOnCastComplete",
              class_token = "mage"
            }
          }
        },
        improved_cone_of_cold = {
          id = 73,
          type = "int32",
          label = "optional"
        },
        frozen_core = {
          id = 74,
          type = "int32",
          label = "optional"
        },
        cold_as_ice = {
          id = 75,
          type = "int32",
          label = "optional"
        },
        winters_chill = {
          id = 76,
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
        shattered_barrier = {
          id = 77,
          type = "int32",
          label = "optional"
        },
        ice_barrier = {
          id = 78,
          type = "bool",
          label = "optional"
        },
        arctic_winds = {
          id = 79,
          type = "int32",
          label = "optional"
        },
        empowered_frostbolt = {
          id = 80,
          type = "int32",
          label = "optional"
        },
        fingers_of_frost = {
          id = 81,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "mage",
                label = "Fingers of Frost Talent",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "mage"
              },
              {
                class = "mage",
                spell_id = 44545,
                label = "Fingers of Frost Proc",
                duration = {
                  raw = "time.Second * 15",
                  seconds = 15.0
                },
                class_token = "mage"
              }
            }
          }
        },
        brain_freeze = {
          id = 82,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "mage",
                label = "Brain Freeze Talent",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "mage"
              },
              {
                class = "mage",
                spell_id = 44549,
                label = "Brain Freeze Proc",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "mage"
              }
            }
          }
        },
        summon_water_elemental = {
          id = 83,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 31687,
              label = "Summon Water Elemental",
              cooldown = {
                raw = [[time.Minute*3*(1-0.1*mage.Talents.ColdAsIce) -
					core.TernaryDuration(mage.HasMajorGlyph(proto.MageMajorGlyph_GlyphOfWaterElemental), time.Second*30, 0)]],
                cases = {
                  {
                    condition = "mage.HasMajorGlyph(proto.MageMajorGlyph_GlyphOfWaterElemental)",
                    raw = [[time.Duration(float64(time.Minute*3)*(1-0.1*float64(mage.Talents.ColdAsIce))) -
					(time.Second*30)]]
                  },
                  {
                    condition = "!(mage.HasMajorGlyph(proto.MageMajorGlyph_GlyphOfWaterElemental))",
                    raw = [[time.Duration(float64(time.Minute*3)*(1-0.1*float64(mage.Talents.ColdAsIce))) -
					(0)]]
                  }
                }
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS",
                priority = "core.CooldownPriorityDrums + 1000"
              },
              flags = "SpellFlagAPL",
              class_token = "mage"
            }
          }
        },
        enduring_winter = {
          id = 84,
          type = "int32",
          label = "optional"
        },
        chilled_to_the_bone = {
          id = 85,
          type = "int32",
          label = "optional"
        },
        deep_freeze = {
          id = 86,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 44572,
              label = "Deep Freeze",
              cooldown = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              flags = "SpellFlagMage | core.SpellFlagAPL",
              spell_school = "SpellSchoolFrost",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "mage.SpellCritMultiplier(1, mage.bonusCritDamage+float64(mage.Talents.IceShards)/3)",
              threat_multiplier = "1 - (0.1/3)*float64(mage.Talents.FrostChanneling)",
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
        "arcane_stability",
        "arcane_fortitude",
        "magic_absorption",
        "arcane_concentration",
        "magic_attunement",
        "spell_impact",
        "student_of_the_mind",
        "focus_magic",
        "arcane_shielding",
        "improved_counterspell",
        "arcane_meditation",
        "torment_the_weak",
        "improved_blink",
        "presence_of_mind",
        "arcane_mind",
        "prismatic_cloak",
        "arcane_instability",
        "arcane_potency",
        "arcane_empowerment",
        "arcane_power",
        "incanters_absorption",
        "arcane_flows",
        "mind_mastery",
        "slow",
        "missile_barrage",
        "netherwind_presence",
        "spell_power",
        "arcane_barrage",
        "improved_fire_blast",
        "incineration",
        "improved_fireball",
        "ignite",
        "burning_determination",
        "world_in_flames",
        "flame_throwing",
        "impact",
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
        "fiery_payback",
        "empowered_fire",
        "firestarter",
        "dragons_breath",
        "hot_streak",
        "burnout",
        "living_bomb",
        "frostbite",
        "improved_frostbolt",
        "ice_floes",
        "ice_shards",
        "frost_warding",
        "precision",
        "permafrost",
        "piercing_ice",
        "icy_veins",
        "improved_blizzard",
        "arctic_reach",
        "frost_channeling",
        "shatter",
        "cold_snap",
        "improved_cone_of_cold",
        "frozen_core",
        "cold_as_ice",
        "winters_chill",
        "shattered_barrier",
        "ice_barrier",
        "arctic_winds",
        "empowered_frostbolt",
        "fingers_of_frost",
        "brain_freeze",
        "summon_water_elemental",
        "enduring_winter",
        "chilled_to_the_bone",
        "deep_freeze"
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
        aspect_mastery = {
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
              spell_id = 19574,
              label = "Bestial Wrath",
              cooldown = {
                raw = "hunter.applyLongevity(time.Minute*2 - core.TernaryDuration(hunter.HasMajorGlyph(proto.HunterMajorGlyph_GlyphOfBestialWrath), time.Second*20, 0))",
                cases = {
                  {
                    condition = "hunter.HasMajorGlyph(proto.HunterMajorGlyph_GlyphOfBestialWrath)",
                    raw = "hunter.applyLongevity(time.Minute*2 - (time.Second*20))"
                  },
                  {
                    condition = "!(hunter.HasMajorGlyph(proto.HunterMajorGlyph_GlyphOfBestialWrath))",
                    raw = "hunter.applyLongevity(time.Minute*2 - (0))"
                  }
                }
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              class_token = "hunter"
            },
            aura = {
              {
                class = "hunter",
                spell_id = 19574,
                label = "Bestial Wrath",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 19574,
                label = "Bestial Wrath Pet",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "hunter"
              }
            }
          }
        },
        catlike_reflexes = {
          id = 19,
          type = "int32",
          label = "optional"
        },
        invigoration = {
          id = 20,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "hunter",
              spell_id = 53253,
              label = "Invigoration",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "hunter"
            }
          }
        },
        serpents_swiftness = {
          id = 21,
          type = "int32",
          label = "optional"
        },
        longevity = {
          id = 22,
          type = "int32",
          label = "optional"
        },
        the_beast_within = {
          id = 23,
          type = "bool",
          label = "optional"
        },
        cobra_strikes = {
          id = 24,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "hunter",
                label = "Cobra Strikes",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 53260,
                label = "Cobra Strikes",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "hunter"
              }
            }
          }
        },
        kindred_spirits = {
          id = 25,
          type = "int32",
          label = "optional"
        },
        beast_mastery = {
          id = 26,
          type = "bool",
          label = "optional"
        },
        improved_concussive_shot = {
          id = 27,
          type = "int32",
          label = "optional"
        },
        focused_aim = {
          id = 28,
          type = "int32",
          label = "optional"
        },
        lethal_shots = {
          id = 29,
          type = "int32",
          label = "optional"
        },
        careful_aim = {
          id = 30,
          type = "int32",
          label = "optional"
        },
        improved_hunters_mark = {
          id = 31,
          type = "int32",
          label = "optional"
        },
        mortal_shots = {
          id = 32,
          type = "int32",
          label = "optional"
        },
        go_for_the_throat = {
          id = 33,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "hunter",
              label = "Go for the Throat",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "hunter"
            }
          }
        },
        improved_arcane_shot = {
          id = 34,
          type = "int32",
          label = "optional"
        },
        aimed_shot = {
          id = 35,
          type = "bool",
          label = "optional"
        },
        rapid_killing = {
          id = 36,
          type = "int32",
          label = "optional"
        },
        improved_stings = {
          id = 37,
          type = "int32",
          label = "optional"
        },
        efficiency = {
          id = 38,
          type = "int32",
          label = "optional"
        },
        concussive_barrage = {
          id = 39,
          type = "int32",
          label = "optional"
        },
        readiness = {
          id = 40,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 23989,
              label = "Readiness",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              class_token = "hunter"
            }
          }
        },
        barrage = {
          id = 41,
          type = "int32",
          label = "optional"
        },
        combat_experience = {
          id = 42,
          type = "int32",
          label = "optional"
        },
        ranged_weapon_specialization = {
          id = 43,
          type = "int32",
          label = "optional"
        },
        piercing_shots = {
          id = 44,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "hunter",
              label = "Piercing Shots Talent",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "hunter"
            },
            spell = {
              class = "hunter",
              spell_id = 53238,
              label = "PiercingShots",
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreModifiers",
              spell_school = "2",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "hunter"
            }
          }
        },
        trueshot_aura = {
          id = 45,
          type = "bool",
          label = "optional"
        },
        improved_barrage = {
          id = 46,
          type = "int32",
          label = "optional"
        },
        master_marksman = {
          id = 47,
          type = "int32",
          label = "optional"
        },
        rapid_recuperation = {
          id = 48,
          type = "int32",
          label = "optional"
        },
        wild_quiver = {
          id = 49,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "hunter",
              label = "Wild Quiver Talent",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "hunter"
            },
            spell = {
              class = "hunter",
              spell_id = 53217,
              label = "Wild Quiver",
              flags = "SpellFlagNoOnCastComplete",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskRangedAuto",
              damage_multiplier = "0.8",
              crit_multiplier = "hunter.critMultiplier(false, false, false)",
              threat_multiplier = "1",
              class_token = "hunter"
            }
          }
        },
        silencing_shot = {
          id = 50,
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
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskRangedSpecial",
              damage_multiplier = "0.5 * hunter.markedForDeathMultiplier()",
              crit_multiplier = "hunter.critMultiplier(true, false, false)",
              threat_multiplier = "1",
              class_token = "hunter"
            }
          }
        },
        improved_steady_shot = {
          id = 51,
          type = "int32",
          label = "optional"
        },
        marked_for_death = {
          id = 52,
          type = "int32",
          label = "optional"
        },
        chimera_shot = {
          id = 53,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 53209,
              label = "Chimera Shot",
              cooldown = {
                raw = "time.Second*10 - core.TernaryDuration(hunter.HasMajorGlyph(proto.HunterMajorGlyph_GlyphOfChimeraShot), time.Second*1, 0)",
                cases = {
                  {
                    condition = "hunter.HasMajorGlyph(proto.HunterMajorGlyph_GlyphOfChimeraShot)",
                    raw = "time.Second*10 - (time.Second*1)",
                    seconds = 9.0
                  },
                  {
                    condition = "!(hunter.HasMajorGlyph(proto.HunterMajorGlyph_GlyphOfChimeraShot))",
                    raw = "time.Second*10 - (0)",
                    seconds = 10.0
                  }
                }
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskRangedSpecial",
              damage_multiplier = "1 * hunter.markedForDeathMultiplier()",
              crit_multiplier = "hunter.critMultiplier(true, true, false)",
              threat_multiplier = "1",
              class_token = "hunter"
            }
          }
        },
        improved_tracking = {
          id = 54,
          type = "int32",
          label = "optional"
        },
        hawk_eye = {
          id = 55,
          type = "int32",
          label = "optional"
        },
        savage_strikes = {
          id = 56,
          type = "int32",
          label = "optional"
        },
        surefooted = {
          id = 57,
          type = "int32",
          label = "optional"
        },
        entrapment = {
          id = 58,
          type = "int32",
          label = "optional"
        },
        trap_mastery = {
          id = 59,
          type = "int32",
          label = "optional"
        },
        survival_instincts = {
          id = 60,
          type = "int32",
          label = "optional"
        },
        survivalist = {
          id = 61,
          type = "int32",
          label = "optional"
        },
        scatter_shot = {
          id = 62,
          type = "bool",
          label = "optional"
        },
        deflection = {
          id = 63,
          type = "int32",
          label = "optional"
        },
        survival_tactics = {
          id = 64,
          type = "int32",
          label = "optional"
        },
        t_n_t = {
          id = 65,
          type = "int32",
          label = "optional"
        },
        lock_and_load = {
          id = 66,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "hunter",
                label = "Lock and Load Talent",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 56344,
                label = "Lock and Load Proc",
                duration = {
                  raw = "time.Second * 12",
                  seconds = 12.0
                },
                class_token = "hunter"
              }
            }
          }
        },
        hunter_vs_wild = {
          id = 67,
          type = "int32",
          label = "optional"
        },
        killer_instinct = {
          id = 68,
          type = "int32",
          label = "optional"
        },
        counterattack = {
          id = 69,
          type = "bool",
          label = "optional"
        },
        lightning_reflexes = {
          id = 70,
          type = "int32",
          label = "optional"
        },
        resourcefulness = {
          id = 71,
          type = "int32",
          label = "optional"
        },
        expose_weakness = {
          id = 72,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "hunter",
                label = "Expose Weakness Talent",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 34503,
                label = "Expose Weakness Proc",
                duration = {
                  raw = "time.Second * 7",
                  seconds = 7.0
                },
                class_token = "hunter"
              }
            }
          }
        },
        wyvern_sting = {
          id = 73,
          type = "bool",
          label = "optional"
        },
        thrill_of_the_hunt = {
          id = 74,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "hunter",
              spell_id = 34499,
              label = "Thrill of the Hunt",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "hunter"
            }
          }
        },
        master_tactician = {
          id = 75,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "hunter",
              spell_id = 34839,
              label = "Master Tactician",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "hunter"
            }
          }
        },
        noxious_stings = {
          id = 76,
          type = "int32",
          label = "optional"
        },
        point_of_no_escape = {
          id = 77,
          type = "int32",
          label = "optional"
        },
        black_arrow = {
          id = 78,
          type = "bool",
          label = "optional"
        },
        sniper_training = {
          id = 79,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "hunter",
              spell_id = 53304,
              label = "Sniper Training",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "hunter"
            }
          }
        },
        hunting_party = {
          id = 80,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "hunter",
              spell_id = 53292,
              label = "Hunting Party",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "hunter"
            }
          }
        },
        explosive_shot = {
          id = 81,
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
        "aspect_mastery",
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
        "invigoration",
        "serpents_swiftness",
        "longevity",
        "the_beast_within",
        "cobra_strikes",
        "kindred_spirits",
        "beast_mastery",
        "improved_concussive_shot",
        "focused_aim",
        "lethal_shots",
        "careful_aim",
        "improved_hunters_mark",
        "mortal_shots",
        "go_for_the_throat",
        "improved_arcane_shot",
        "aimed_shot",
        "rapid_killing",
        "improved_stings",
        "efficiency",
        "concussive_barrage",
        "readiness",
        "barrage",
        "combat_experience",
        "ranged_weapon_specialization",
        "piercing_shots",
        "trueshot_aura",
        "improved_barrage",
        "master_marksman",
        "rapid_recuperation",
        "wild_quiver",
        "silencing_shot",
        "improved_steady_shot",
        "marked_for_death",
        "chimera_shot",
        "improved_tracking",
        "hawk_eye",
        "savage_strikes",
        "surefooted",
        "entrapment",
        "trap_mastery",
        "survival_instincts",
        "survivalist",
        "scatter_shot",
        "deflection",
        "survival_tactics",
        "t_n_t",
        "lock_and_load",
        "hunter_vs_wild",
        "killer_instinct",
        "counterattack",
        "lightning_reflexes",
        "resourcefulness",
        "expose_weakness",
        "wyvern_sting",
        "thrill_of_the_hunt",
        "master_tactician",
        "noxious_stings",
        "point_of_no_escape",
        "black_arrow",
        "sniper_training",
        "hunting_party",
        "explosive_shot"
      }
    },
    HunterPetTalents = {
      fields = {
        cobra_reflexes = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        dive = {
          id = 2,
          type = "bool",
          label = "optional"
        },
        great_stamina = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        natural_armor = {
          id = 4,
          type = "int32",
          label = "optional"
        },
        boars_speed = {
          id = 5,
          type = "bool",
          label = "optional"
        },
        mobility = {
          id = 6,
          type = "int32",
          label = "optional"
        },
        owls_focus = {
          id = 7,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "hunter",
                label = "Owls Focus",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 53515,
                label = "Owl's Focus Proc",
                duration = {
                  raw = "time.Second * 8",
                  seconds = 8.0
                },
                class_token = "hunter"
              }
            }
          }
        },
        spiked_collar = {
          id = 8,
          type = "int32",
          label = "optional"
        },
        culling_the_herd = {
          id = 9,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "hunter",
                label = "Culling the Herd",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 52858,
                label = "Culling the Herd Proc",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "hunter"
              }
            }
          }
        },
        lionhearted = {
          id = 10,
          type = "int32",
          label = "optional"
        },
        carrion_feeder = {
          id = 11,
          type = "bool",
          label = "optional"
        },
        great_resistance = {
          id = 12,
          type = "int32",
          label = "optional"
        },
        cornered = {
          id = 13,
          type = "int32",
          label = "optional"
        },
        feeding_frenzy = {
          id = 14,
          type = "int32",
          label = "optional"
        },
        wolverine_bite = {
          id = 15,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 53508,
              label = "Wolverine Bite",
              cooldown = {
                raw = "hunter.applyLongevity(time.Second * 10)"
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1 * hp.hunterOwner.markedForDeathMultiplier()",
              crit_multiplier = "2",
              threat_multiplier = "1",
              class_token = "hunter"
            },
            aura = {
              class = "hunter",
              label = "Wolverine Bite Trigger",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "hunter"
            }
          }
        },
        roar_of_recovery = {
          id = 16,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 53517,
              label = "Roar Of Recovery",
              cooldown = {
                raw = "hunter.applyLongevity(time.Minute * 3)"
              },
              major_cooldown = {
                type = "core.CooldownTypeMana"
              },
              class_token = "hunter"
            }
          }
        },
        bullheaded = {
          id = 17,
          type = "bool",
          label = "optional"
        },
        grace_of_the_mantis = {
          id = 18,
          type = "int32",
          label = "optional"
        },
        wild_hunt = {
          id = 19,
          type = "int32",
          label = "optional"
        },
        roar_of_sacrifice = {
          id = 20,
          type = "bool",
          label = "optional"
        },
        improved_cower = {
          id = 21,
          type = "int32",
          label = "optional"
        },
        bloodthirsty = {
          id = 22,
          type = "int32",
          label = "optional"
        },
        heart_of_the_pheonix = {
          id = 23,
          type = "bool",
          label = "optional"
        },
        spiders_bite = {
          id = 24,
          type = "int32",
          label = "optional"
        },
        rabid = {
          id = 25,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 53401,
              label = "Rabid",
              cooldown = {
                raw = "hunter.applyLongevity(time.Second * 45)"
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              class_token = "hunter"
            },
            aura = {
              {
                class = "hunter",
                spell_id = 53401,
                label = "Rabid",
                duration = {
                  raw = "time.Second * 20",
                  seconds = 20.0
                },
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 53403,
                label = "Rabid Power",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "hunter"
              }
            }
          }
        },
        lick_your_wounds = {
          id = 26,
          type = "bool",
          label = "optional"
        },
        call_of_the_wild = {
          id = 27,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 53434,
              label = "Call Of The Wild",
              cooldown = {
                raw = "hunter.applyLongevity(time.Minute * 5)"
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              class_token = "hunter"
            },
            aura = {
              class = "hunter",
              spell_id = 53434,
              label = "Call of the Wild",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "hunter"
            }
          }
        },
        shark_attack = {
          id = 28,
          type = "int32",
          label = "optional"
        },
        charge = {
          id = 29,
          type = "bool",
          label = "optional"
        },
        blood_of_the_rhino = {
          id = 30,
          type = "int32",
          label = "optional"
        },
        pet_barding = {
          id = 31,
          type = "int32",
          label = "optional"
        },
        guard_dog = {
          id = 32,
          type = "int32",
          label = "optional"
        },
        thunderstomp = {
          id = 33,
          type = "bool",
          label = "optional"
        },
        last_stand = {
          id = 34,
          type = "bool",
          label = "optional"
        },
        taunt = {
          id = 35,
          type = "bool",
          label = "optional"
        },
        intervene = {
          id = 36,
          type = "bool",
          label = "optional"
        },
        silverback = {
          id = 37,
          type = "int32",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "cobra_reflexes",
        "dive",
        "great_stamina",
        "natural_armor",
        "boars_speed",
        "mobility",
        "owls_focus",
        "spiked_collar",
        "culling_the_herd",
        "lionhearted",
        "carrion_feeder",
        "great_resistance",
        "cornered",
        "feeding_frenzy",
        "wolverine_bite",
        "roar_of_recovery",
        "bullheaded",
        "grace_of_the_mantis",
        "wild_hunt",
        "roar_of_sacrifice",
        "improved_cower",
        "bloodthirsty",
        "heart_of_the_pheonix",
        "spiders_bite",
        "rabid",
        "lick_your_wounds",
        "call_of_the_wild",
        "shark_attack",
        "charge",
        "blood_of_the_rhino",
        "pet_barding",
        "guard_dog",
        "thunderstomp",
        "last_stand",
        "taunt",
        "intervene",
        "silverback"
      }
    },
    Hunter = {
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
    DeathknightTalents = {
      fields = {
        butchery = {
          id = 1,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "deathknight",
              spell_id = 49483,
              label = "Butchery",
              class_token = "deathknight"
            }
          }
        },
        subversion = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        blade_barrier = {
          id = 3,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "deathknight",
              spell_id = 55226,
              label = "Blade Barrier",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "deathknight"
            }
          }
        },
        bladed_armor = {
          id = 4,
          type = "int32",
          label = "optional"
        },
        scent_of_blood = {
          id = 5,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "deathknight",
                label = "Scent of Blood",
                class_token = "deathknight"
              },
              {
                class = "deathknight",
                spell_id = 49509,
                label = "Scent of Blood Proc",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "deathknight"
              }
            }
          }
        },
        two_handed_weapon_specialization = {
          id = 6,
          type = "int32",
          label = "optional"
        },
        rune_tap = {
          id = 7,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 48982,
              label = "Rune Tap",
              cooldown = {
                raw = "time.Minute - (time.Second * 10 * dk.Talents.ImprovedRuneTap)"
              },
              major_cooldown = {
                type = "core.CooldownTypeSurvival"
              },
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
              class_token = "deathknight"
            }
          }
        },
        dark_conviction = {
          id = 8,
          type = "int32",
          label = "optional"
        },
        death_rune_mastery = {
          id = 9,
          type = "int32",
          label = "optional"
        },
        improved_rune_tap = {
          id = 10,
          type = "int32",
          label = "optional"
        },
        spell_deflection = {
          id = 11,
          type = "int32",
          label = "optional"
        },
        vendetta = {
          id = 12,
          type = "int32",
          label = "optional"
        },
        bloody_strikes = {
          id = 13,
          type = "int32",
          label = "optional"
        },
        veteran_of_the_third_war = {
          id = 14,
          type = "int32",
          label = "optional"
        },
        mark_of_blood = {
          id = 15,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 49005,
              label = "Mark Of Blood",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              major_cooldown = {
                type = "core.CooldownTypeSurvival"
              },
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
              class_token = "deathknight"
            }
          }
        },
        bloody_vengeance = {
          id = 16,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "deathknight",
                spell_id = 50449,
                label = "Bloody Vengeance",
                class_token = "deathknight"
              },
              {
                class = "deathknight",
                spell_id = 50449,
                label = "Bloody Vengeance Proc",
                duration = {
                  raw = "30 * time.Second",
                  seconds = 30.0
                },
                class_token = "deathknight"
              }
            }
          }
        },
        abominations_might = {
          id = 17,
          type = "int32",
          label = "optional"
        },
        bloodworms = {
          id = 18,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "deathknight",
              label = "Bloodworms Proc",
              class_token = "deathknight"
            },
            spell = {
              class = "deathknight",
              spell_id = 49543,
              label = "Bloodworms",
              class_token = "deathknight"
            }
          }
        },
        hysteria = {
          id = 19,
          type = "bool",
          label = "optional"
        },
        improved_blood_presence = {
          id = 20,
          type = "int32",
          label = "optional"
        },
        improved_death_strike = {
          id = 21,
          type = "int32",
          label = "optional"
        },
        sudden_doom = {
          id = 22,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "deathknight",
                label = "Sudden Doom Drw",
                class_token = "deathknight"
              },
              {
                class = "deathknight",
                label = "Sudden Doom",
                class_token = "deathknight"
              },
              {
                class = "deathknight",
                spell_id = 49530,
                label = "Sudden Doom Proc",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "deathknight"
              }
            }
          }
        },
        vampiric_blood = {
          id = 23,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 55233,
              label = "Vampiric Blood",
              cooldown = {
                raw = "time.Minute*1 - dk.thassariansPlateCooldownReduction(dk.VampiricBlood)"
              },
              major_cooldown = {
                type = "core.CooldownTypeSurvival"
              },
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
              class_token = "deathknight"
            },
            aura = {
              class = "deathknight",
              spell_id = 55233,
              label = "Vampiric Blood",
              duration = {
                cases = {
                  {
                    condition = "dk.HasMajorGlyph(proto.DeathknightMajorGlyph_GlyphOfVampiricBlood)",
                    raw = "time.Second*10 + (5*time.Second)",
                    seconds = 15.0
                  },
                  {
                    condition = "!(dk.HasMajorGlyph(proto.DeathknightMajorGlyph_GlyphOfVampiricBlood))",
                    raw = "time.Second*10 + (0)",
                    seconds = 10.0
                  }
                },
                raw = "time.Second*10 + core.TernaryDuration(dk.HasMajorGlyph(proto.DeathknightMajorGlyph_GlyphOfVampiricBlood), 5*time.Second, 0)"
              },
              duration_raw = "time.Second*10 + core.TernaryDuration(dk.HasMajorGlyph(proto.DeathknightMajorGlyph_GlyphOfVampiricBlood), 5*time.Second, 0)",
              class_token = "deathknight"
            }
          }
        },
        will_of_the_necropolis = {
          id = 24,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "deathknight",
              spell_id = 50150,
              label = "Will of The Necropolis",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "deathknight"
            }
          }
        },
        heart_strike = {
          id = 25,
          type = "bool",
          label = "optional"
        },
        might_of_mograine = {
          id = 26,
          type = "int32",
          label = "optional"
        },
        blood_gorged = {
          id = 27,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "deathknight",
                label = "Blood Gorged",
                class_token = "deathknight"
              },
              {
                class = "deathknight",
                spell_id = 50111,
                label = "Blood Gorged Proc",
                class_token = "deathknight"
              }
            }
          }
        },
        dancing_rune_weapon = {
          id = 28,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 49028,
              label = "Dancing Rune Weapon",
              cooldown = {
                raw = "time.Second * 90",
                seconds = 90.0
              },
              flags = "SpellFlagAPL",
              class_token = "deathknight"
            },
            aura = {
              class = "deathknight",
              spell_id = 49028,
              label = "Dancing Rune Weapon",
              duration = {
                cases = {
                  {
                    raw = "time.Second * 12",
                    seconds = 12.0
                  },
                  {
                    condition = "dk.HasMajorGlyph(proto.DeathknightMajorGlyph_GlyphOfDancingRuneWeapon)",
                    raw = "time.Second * 5",
                    seconds = 5.0
                  }
                },
                raw = "time.Second * 12"
              },
              duration_raw = "duration",
              class_token = "deathknight"
            }
          }
        },
        improved_icy_touch = {
          id = 29,
          type = "int32",
          label = "optional"
        },
        runic_power_mastery = {
          id = 30,
          type = "int32",
          label = "optional"
        },
        toughness = {
          id = 31,
          type = "int32",
          label = "optional"
        },
        icy_reach = {
          id = 32,
          type = "int32",
          label = "optional"
        },
        black_ice = {
          id = 33,
          type = "int32",
          label = "optional"
        },
        nerves_of_cold_steel = {
          id = 34,
          type = "int32",
          label = "optional"
        },
        icy_talons = {
          id = 35,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "deathknight",
              spell_id = 50887,
              label = "Icy Talons",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "deathknight"
            }
          }
        },
        lichborne = {
          id = 36,
          type = "bool",
          label = "optional"
        },
        annihilation = {
          id = 37,
          type = "int32",
          label = "optional"
        },
        killing_machine = {
          id = 38,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "deathknight",
                label = "Killing Machine",
                class_token = "deathknight"
              },
              {
                class = "deathknight",
                spell_id = 51130,
                label = "Killing Machine Proc",
                duration = {
                  raw = "time.Second * 30",
                  seconds = 30.0
                },
                class_token = "deathknight"
              }
            }
          }
        },
        chill_of_the_grave = {
          id = 39,
          type = "int32",
          label = "optional"
        },
        endless_winter = {
          id = 40,
          type = "int32",
          label = "optional"
        },
        frigid_dreadplate = {
          id = 41,
          type = "int32",
          label = "optional"
        },
        glacier_rot = {
          id = 42,
          type = "int32",
          label = "optional"
        },
        deathchill = {
          id = 43,
          type = "bool",
          label = "optional",
          _metadata = {
            aura = {
              class = "deathknight",
              spell_id = 49796,
              label = "Deathchill",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "deathknight"
            },
            spell = {
              class = "deathknight",
              spell_id = 49796,
              label = "Deathchill",
              cooldown = {
                raw = "2 * time.Minute",
                seconds = 120.0
              },
              flags = "SpellFlagNoOnCastComplete",
              class_token = "deathknight"
            }
          }
        },
        improved_icy_talons = {
          id = 44,
          type = "bool",
          label = "optional"
        },
        merciless_combat = {
          id = 45,
          type = "int32",
          label = "optional"
        },
        rime = {
          id = 46,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "deathknight",
              spell_id = 59052,
              label = "Freezing Fog",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "deathknight"
            }
          }
        },
        chilblains = {
          id = 47,
          type = "int32",
          label = "optional"
        },
        hungering_cold = {
          id = 48,
          type = "bool",
          label = "optional"
        },
        improved_frost_presence = {
          id = 49,
          type = "int32",
          label = "optional"
        },
        threat_of_thassarian = {
          id = 50,
          type = "int32",
          label = "optional"
        },
        blood_of_the_north = {
          id = 51,
          type = "int32",
          label = "optional"
        },
        unbreakable_armor = {
          id = 52,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 51271,
              label = "Unbreakable Armor",
              cooldown = {
                raw = "time.Minute*1 - dk.thassariansPlateCooldownReduction(dk.UnbreakableArmor)"
              },
              major_cooldown = {
                type = "core.CooldownTypeSurvival"
              },
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
              class_token = "deathknight"
            },
            aura = {
              class = "deathknight",
              spell_id = 51271,
              label = "Unbreakable Armor",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "deathknight"
            }
          }
        },
        acclimation = {
          id = 53,
          type = "int32",
          label = "optional"
        },
        frost_strike = {
          id = 54,
          type = "bool",
          label = "optional"
        },
        guile_of_gorefiend = {
          id = 55,
          type = "int32",
          label = "optional"
        },
        tundra_stalker = {
          id = 56,
          type = "int32",
          label = "optional"
        },
        howling_blast = {
          id = 57,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 51411,
              label = "Howling Blast",
              cooldown = {
                raw = "8 * time.Second",
                seconds = 8.0
              },
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolFrost",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "dk.bonusCritMultiplier(dk.Talents.GuileOfGorefiend)",
              threat_multiplier = "1",
              class_token = "deathknight"
            }
          }
        },
        vicious_strikes = {
          id = 58,
          type = "int32",
          label = "optional"
        },
        virulence = {
          id = 59,
          type = "int32",
          label = "optional"
        },
        anticipation = {
          id = 60,
          type = "int32",
          label = "optional"
        },
        epidemic = {
          id = 61,
          type = "int32",
          label = "optional"
        },
        morbidity = {
          id = 62,
          type = "int32",
          label = "optional"
        },
        unholy_command = {
          id = 63,
          type = "int32",
          label = "optional"
        },
        ravenous_dead = {
          id = 64,
          type = "int32",
          label = "optional"
        },
        outbreak = {
          id = 65,
          type = "int32",
          label = "optional"
        },
        necrosis = {
          id = 66,
          type = "int32",
          label = "optional",
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 51460,
              label = "Necrosis",
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreModifiers | core.SpellFlagNoOnDamageDealt",
              spell_school = "SpellSchoolShadow",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "deathknight"
            }
          }
        },
        corpse_explosion = {
          id = 67,
          type = "bool",
          label = "optional"
        },
        on_a_pale_horse = {
          id = 68,
          type = "int32",
          label = "optional"
        },
        blood_caked_blade = {
          id = 69,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "deathknight",
              label = "Blood-Caked Blade",
              class_token = "deathknight"
            }
          }
        },
        night_of_the_dead = {
          id = 70,
          type = "int32",
          label = "optional"
        },
        unholy_blight = {
          id = 71,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 50536,
              label = "UnholyBlight",
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreModifiers | core.SpellFlagNoOnDamageDealt",
              spell_school = "SpellSchoolShadow",
              proc_mask = "2",
              damage_multiplier = "core.TernaryFloat64(dk.HasMajorGlyph(proto.DeathknightMajorGlyph_GlyphOfUnholyBlight), 1.4, 1)",
              threat_multiplier = "1",
              class_token = "deathknight"
            }
          }
        },
        impurity = {
          id = 72,
          type = "int32",
          label = "optional"
        },
        dirge = {
          id = 73,
          type = "int32",
          label = "optional"
        },
        desecration = {
          id = 74,
          type = "int32",
          label = "optional"
        },
        magic_suppression = {
          id = 75,
          type = "int32",
          label = "optional"
        },
        reaping = {
          id = 76,
          type = "int32",
          label = "optional"
        },
        master_of_ghouls = {
          id = 77,
          type = "bool",
          label = "optional"
        },
        desolation = {
          id = 78,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "deathknight",
              spell_id = 66803,
              label = "Desolation",
              duration = {
                raw = "time.Second * 20.0",
                seconds = 20.0
              },
              class_token = "deathknight"
            }
          }
        },
        anti_magic_zone = {
          id = 79,
          type = "bool",
          label = "optional"
        },
        improved_unholy_presence = {
          id = 80,
          type = "int32",
          label = "optional"
        },
        ghoul_frenzy = {
          id = 81,
          type = "bool",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "deathknight",
                spell_id = 63560,
                label = "Ghoul Frenzy",
                duration = {
                  raw = "time.Second * 30.0",
                  seconds = 30.0
                },
                class_token = "deathknight"
              },
              {
                class = "deathknight",
                spell_id = 63560,
                label = "Ghoul Frenzy",
                duration = {
                  raw = "time.Second * 30.0",
                  seconds = 30.0
                },
                class_token = "deathknight"
              }
            },
            spell = {
              class = "deathknight",
              spell_id = 63560,
              label = "Ghoul Frenzy Hot",
              cooldown = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellHealing",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "deathknight"
            }
          }
        },
        crypt_fever = {
          id = 82,
          type = "int32",
          label = "optional"
        },
        bone_shield = {
          id = 83,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 49222,
              label = "Bone Shield",
              cooldown = {
                raw = "time.Minute*1 - dk.thassariansPlateCooldownReduction(dk.BoneShield)"
              },
              major_cooldown = {
                type = "core.CooldownTypeSurvival"
              },
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
              class_token = "deathknight"
            },
            aura = {
              class = "deathknight",
              spell_id = 49222,
              label = "Bone Shield",
              duration = {
                raw = "time.Minute * 5",
                seconds = 300.0
              },
              class_token = "deathknight"
            }
          }
        },
        wandering_plague = {
          id = 84,
          type = "int32",
          label = "optional",
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 50526,
              label = "Wandering Plague",
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreAttackerModifiers | core.SpellFlagNoOnDamageDealt",
              spell_school = "SpellSchoolShadow",
              proc_mask = "2",
              damage_multiplier = "[]float64{0.0, 0.33, 0.66, 1.0}[dk.Talents.WanderingPlague]",
              threat_multiplier = "1",
              class_token = "deathknight"
            }
          }
        },
        ebon_plaguebringer = {
          id = 85,
          type = "int32",
          label = "optional"
        },
        scourge_strike = {
          id = 86,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 55271,
              label = "Scourge Strike",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = ".7 * []float64{1.0, 1.07, 1.13, 1.2}[dk.Talents.Outbreak] * dk.scourgelordsBattlegearDamageBonus(ScourgelordBonusSpellSS)",
              crit_multiplier = "dk.bonusCritMultiplier(dk.Talents.ViciousStrikes)",
              threat_multiplier = "1",
              class_token = "deathknight"
            }
          }
        },
        rage_of_rivendare = {
          id = 87,
          type = "int32",
          label = "optional"
        },
        summon_gargoyle = {
          id = 88,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 49206,
              label = "Summon Gargoyle",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              flags = "SpellFlagAPL",
              class_token = "deathknight"
            },
            aura = {
              class = "deathknight",
              spell_id = 49206,
              label = "Summon Gargoyle",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "deathknight"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "butchery",
        "subversion",
        "blade_barrier",
        "bladed_armor",
        "scent_of_blood",
        "two_handed_weapon_specialization",
        "rune_tap",
        "dark_conviction",
        "death_rune_mastery",
        "improved_rune_tap",
        "spell_deflection",
        "vendetta",
        "bloody_strikes",
        "veteran_of_the_third_war",
        "mark_of_blood",
        "bloody_vengeance",
        "abominations_might",
        "bloodworms",
        "hysteria",
        "improved_blood_presence",
        "improved_death_strike",
        "sudden_doom",
        "vampiric_blood",
        "will_of_the_necropolis",
        "heart_strike",
        "might_of_mograine",
        "blood_gorged",
        "dancing_rune_weapon",
        "improved_icy_touch",
        "runic_power_mastery",
        "toughness",
        "icy_reach",
        "black_ice",
        "nerves_of_cold_steel",
        "icy_talons",
        "lichborne",
        "annihilation",
        "killing_machine",
        "chill_of_the_grave",
        "endless_winter",
        "frigid_dreadplate",
        "glacier_rot",
        "deathchill",
        "improved_icy_talons",
        "merciless_combat",
        "rime",
        "chilblains",
        "hungering_cold",
        "improved_frost_presence",
        "threat_of_thassarian",
        "blood_of_the_north",
        "unbreakable_armor",
        "acclimation",
        "frost_strike",
        "guile_of_gorefiend",
        "tundra_stalker",
        "howling_blast",
        "vicious_strikes",
        "virulence",
        "anticipation",
        "epidemic",
        "morbidity",
        "unholy_command",
        "ravenous_dead",
        "outbreak",
        "necrosis",
        "corpse_explosion",
        "on_a_pale_horse",
        "blood_caked_blade",
        "night_of_the_dead",
        "unholy_blight",
        "impurity",
        "dirge",
        "desecration",
        "magic_suppression",
        "reaping",
        "master_of_ghouls",
        "desolation",
        "anti_magic_zone",
        "improved_unholy_presence",
        "ghoul_frenzy",
        "crypt_fever",
        "bone_shield",
        "wandering_plague",
        "ebon_plaguebringer",
        "scourge_strike",
        "rage_of_rivendare",
        "summon_gargoyle"
      }
    },
    Deathknight = {
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
    TankDeathknight = {
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
        blood_spatter = {
          id = 5,
          type = "int32",
          label = "optional"
        },
        puncturing_wounds = {
          id = 6,
          type = "int32",
          label = "optional"
        },
        vigor = {
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
              spell_id = 14195,
              label = "Seal Fate",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "rogue"
            }
          }
        },
        murder = {
          id = 17,
          type = "int32",
          label = "optional"
        },
        deadly_brew = {
          id = 18,
          type = "int32",
          label = "optional"
        },
        overkill = {
          id = 19,
          type = "bool",
          label = "optional",
          _metadata = {
            aura = {
              class = "rogue",
              spell_id = 58426,
              label = "Overkill",
              duration = {
                cases = {
                  {
                    raw = "time.Second * 20",
                    seconds = 20.0
                  },
                  {
                    condition = "rogue.StealthAura.IsActive()",
                    raw = "core.NeverExpires"
                  }
                },
                raw = "time.Second * 20"
              },
              duration_raw = "effectDuration",
              class_token = "rogue"
            }
          }
        },
        deadened_nerves = {
          id = 20,
          type = "int32",
          label = "optional"
        },
        focused_attacks = {
          id = 21,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "rogue",
              spell_id = 51637,
              label = "Focused Attacks",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "rogue"
            }
          }
        },
        find_weakness = {
          id = 22,
          type = "int32",
          label = "optional"
        },
        master_poisoner = {
          id = 23,
          type = "int32",
          label = "optional"
        },
        mutilate = {
          id = 24,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 48666,
              label = "Mutilate",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              threat_multiplier = "1",
              class_token = "rogue"
            }
          }
        },
        turn_the_tables = {
          id = 25,
          type = "int32",
          label = "optional"
        },
        cut_to_the_chase = {
          id = 26,
          type = "int32",
          label = "optional"
        },
        hunger_for_blood = {
          id = 27,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 51662,
              label = "Hunger For Blood",
              flags = "SpellFlagAPL",
              class_token = "rogue"
            },
            aura = {
              class = "rogue",
              spell_id = 51662,
              label = "Hunger for Blood",
              duration_raw = "time.Minute",
              class_token = "rogue"
            }
          }
        },
        improved_gouge = {
          id = 28,
          type = "int32",
          label = "optional"
        },
        improved_sinister_strike = {
          id = 29,
          type = "int32",
          label = "optional"
        },
        dual_wield_specialization = {
          id = 30,
          type = "int32",
          label = "optional"
        },
        improved_slice_and_dice = {
          id = 31,
          type = "int32",
          label = "optional"
        },
        deflection = {
          id = 32,
          type = "int32",
          label = "optional"
        },
        precision = {
          id = 33,
          type = "int32",
          label = "optional"
        },
        endurance = {
          id = 34,
          type = "int32",
          label = "optional"
        },
        riposte = {
          id = 35,
          type = "bool",
          label = "optional"
        },
        close_quarters_combat = {
          id = 36,
          type = "int32",
          label = "optional"
        },
        improved_kick = {
          id = 37,
          type = "int32",
          label = "optional"
        },
        improved_sprint = {
          id = 38,
          type = "int32",
          label = "optional"
        },
        lightning_reflexes = {
          id = 39,
          type = "int32",
          label = "optional"
        },
        aggression = {
          id = 40,
          type = "int32",
          label = "optional"
        },
        mace_specialization = {
          id = 41,
          type = "int32",
          label = "optional"
        },
        blade_flurry = {
          id = 42,
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
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreAttackerModifiers",
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
        hack_and_slash = {
          id = 43,
          type = "int32",
          label = "optional"
        },
        weapon_expertise = {
          id = 44,
          type = "int32",
          label = "optional"
        },
        blade_twisting = {
          id = 45,
          type = "int32",
          label = "optional"
        },
        vitality = {
          id = 46,
          type = "int32",
          label = "optional"
        },
        adrenaline_rush = {
          id = 47,
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
                priority = "core.CooldownPriorityBloodlust"
              },
              class_token = "rogue"
            },
            aura = {
              class = "rogue",
              spell_id = 13750,
              label = "Adrenaline Rush",
              duration = {
                cases = {
                  {
                    condition = "rogue.HasMajorGlyph(proto.RogueMajorGlyph_GlyphOfAdrenalineRush)",
                    raw = "(time.Second*20)",
                    seconds = 20.0
                  },
                  {
                    condition = "!(rogue.HasMajorGlyph(proto.RogueMajorGlyph_GlyphOfAdrenalineRush))",
                    raw = "(time.Second*15)",
                    seconds = 15.0
                  }
                },
                raw = "core.TernaryDuration(rogue.HasMajorGlyph(proto.RogueMajorGlyph_GlyphOfAdrenalineRush), time.Second*20, time.Second*15)"
              },
              duration_raw = "core.TernaryDuration(rogue.HasMajorGlyph(proto.RogueMajorGlyph_GlyphOfAdrenalineRush), time.Second*20, time.Second*15)",
              class_token = "rogue"
            }
          }
        },
        nerves_of_steel = {
          id = 48,
          type = "int32",
          label = "optional"
        },
        throwing_specialization = {
          id = 49,
          type = "int32",
          label = "optional"
        },
        combat_potency = {
          id = 50,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "rogue",
              spell_id = 35553,
              label = "Combat Potency",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "rogue"
            }
          }
        },
        unfair_advantage = {
          id = 51,
          type = "int32",
          label = "optional"
        },
        surprise_attacks = {
          id = 52,
          type = "bool",
          label = "optional"
        },
        savage_combat = {
          id = 53,
          type = "int32",
          label = "optional"
        },
        prey_on_the_weak = {
          id = 54,
          type = "int32",
          label = "optional"
        },
        killing_spree = {
          id = 55,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              {
                class = "rogue",
                spell_id = 51690,
                label = "Killing Spree",
                cooldown = {
                  raw = "time.Minute*2 - core.TernaryDuration(rogue.HasMajorGlyph(proto.RogueMajorGlyph_GlyphOfKillingSpree), time.Second*45, 0)",
                  cases = {
                    {
                      condition = "rogue.HasMajorGlyph(proto.RogueMajorGlyph_GlyphOfKillingSpree)",
                      raw = "time.Minute*2 - (time.Second*45)",
                      seconds = 75.0
                    },
                    {
                      condition = "!(rogue.HasMajorGlyph(proto.RogueMajorGlyph_GlyphOfKillingSpree))",
                      raw = "time.Minute*2 - (0)",
                      seconds = 120.0
                    }
                  }
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS",
                  priority = "core.CooldownPriorityLow"
                },
                flags = "SpellFlagAPL",
                class_token = "rogue"
              },
              {
                class = "rogue",
                spell_id = 51690,
                label = "Killing Spree",
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
                spell_school = "2",
                proc_mask = "ProcMaskMeleeOHSpecial",
                damage_multiplier = "(1 + 0.02*float64(rogue.Talents.FindWeakness)) * rogue.dwsMultiplier()",
                crit_multiplier = "rogue.MeleeCritMultiplier(false)",
                threat_multiplier = "1",
                class_token = "rogue"
              },
              {
                class = "rogue",
                spell_id = 51690,
                label = "Killing Spree",
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
                spell_school = "2",
                proc_mask = "ProcMaskMeleeMHSpecial",
                damage_multiplier = "1 + 0.02*float64(rogue.Talents.FindWeakness)",
                crit_multiplier = "rogue.MeleeCritMultiplier(false)",
                threat_multiplier = "1",
                class_token = "rogue"
              }
            },
            aura = {
              class = "rogue",
              spell_id = 51690,
              label = "Killing Spree",
              duration = {
                raw = "time.Second*2 + 1",
                seconds = 3.0
              },
              class_token = "rogue"
            }
          }
        },
        relentless_strikes = {
          id = 56,
          type = "int32",
          label = "optional"
        },
        master_of_deception = {
          id = 57,
          type = "int32",
          label = "optional"
        },
        opportunity = {
          id = 58,
          type = "int32",
          label = "optional"
        },
        sleight_of_hand = {
          id = 59,
          type = "int32",
          label = "optional"
        },
        dirty_tricks = {
          id = 60,
          type = "int32",
          label = "optional"
        },
        camouflage = {
          id = 61,
          type = "int32",
          label = "optional"
        },
        elusiveness = {
          id = 62,
          type = "int32",
          label = "optional"
        },
        ghostly_strike = {
          id = 63,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 14278,
              label = "Ghostly Strike",
              cooldown = {
                raw = "time.Second*20 + core.TernaryDuration(hasGlyph, time.Second*10, 0)",
                cases = {
                  {
                    condition = "hasGlyph",
                    raw = "time.Second*20 + (time.Second*10)",
                    seconds = 30.0
                  },
                  {
                    condition = "!(hasGlyph)",
                    raw = "time.Second*20 + (0)",
                    seconds = 20.0
                  }
                }
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | SpellFlagBuilder | SpellFlagColdBlooded | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "core.TernaryFloat64(rogue.HasDagger(core.MainHand), 1.8, 1.25) * core.TernaryFloat64(hasGlyph, 1.4, 1) * (1 + 0.02*float64(rogue.Talents.FindWeakness))",
              crit_multiplier = "rogue.MeleeCritMultiplier(true)",
              threat_multiplier = "1",
              class_token = "rogue"
            }
          }
        },
        serrated_blades = {
          id = 64,
          type = "int32",
          label = "optional"
        },
        setup = {
          id = 65,
          type = "int32",
          label = "optional"
        },
        initiative = {
          id = 66,
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
        improved_ambush = {
          id = 67,
          type = "int32",
          label = "optional"
        },
        heightened_senses = {
          id = 68,
          type = "int32",
          label = "optional"
        },
        preparation = {
          id = 69,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 14185,
              label = "Preparation",
              cooldown = {
                raw = "time.Minute*8 - time.Second*90*rogue.Talents.FilthyTricks"
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
          id = 70,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "rogue",
              spell_id = 14083,
              label = "Dirty Deeds",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "rogue"
            }
          }
        },
        hemorrhage = {
          id = 71,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 48660,
              label = "Hemorrhage",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | SpellFlagBuilder | SpellFlagColdBlooded | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "core.TernaryFloat64(rogue.HasDagger(core.MainHand), 1.6, 1.1) * (1 + 0.02*float64(rogue.Talents.FindWeakness) + core.TernaryFloat64(rogue.HasSetBonus(Tier6, 4), 0.06, 0)) * (1 + 0.02*float64(rogue.Talents.SinisterCalling))",
              crit_multiplier = "rogue.MeleeCritMultiplier(true)",
              threat_multiplier = "1",
              class_token = "rogue"
            },
            aura = {
              class = "rogue",
              spell_id = 48660,
              label = "Hemorrhage",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "rogue"
            }
          }
        },
        master_of_subtlety = {
          id = 72,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "rogue",
              label = "Master of Subtlety",
              duration = {
                cases = {
                  {
                    raw = "time.Second * 6",
                    seconds = 6.0
                  },
                  {
                    condition = "rogue.StealthAura.IsActive()",
                    raw = "core.NeverExpires"
                  }
                },
                raw = "time.Second * 6"
              },
              duration_raw = "effectDuration",
              class_token = "rogue"
            }
          }
        },
        deadliness = {
          id = 73,
          type = "int32",
          label = "optional"
        },
        enveloping_shadows = {
          id = 74,
          type = "int32",
          label = "optional"
        },
        premeditation = {
          id = 75,
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
              flags = "SpellFlagAPL",
              class_token = "rogue"
            }
          }
        },
        cheat_death = {
          id = 76,
          type = "int32",
          label = "optional"
        },
        sinister_calling = {
          id = 77,
          type = "int32",
          label = "optional"
        },
        waylay = {
          id = 78,
          type = "int32",
          label = "optional"
        },
        honor_among_thieves = {
          id = 79,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "rogue",
              spell_id = 51701,
              label = "Honor Among Thieves",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "rogue"
            }
          }
        },
        shadowstep = {
          id = 80,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 36554,
              label = "Shadowstep",
              cooldown = {
                raw = "time.Second * 30-5*rogue.Talents.FilthyTricks"
              },
              flags = "SpellFlagAPL",
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
        },
        filthy_tricks = {
          id = 81,
          type = "int32",
          label = "optional"
        },
        slaughter_from_the_shadows = {
          id = 82,
          type = "int32",
          label = "optional"
        },
        shadow_dance = {
          id = 83,
          type = "bool",
          label = "optional",
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
              flags = "SpellFlagAPL",
              class_token = "rogue"
            },
            aura = {
              class = "rogue",
              spell_id = 51713,
              label = "Shadow Dance",
              duration = {
                cases = {
                  {
                    raw = "time.Second * 6",
                    seconds = 6.0
                  },
                  {
                    condition = "rogue.HasMajorGlyph(proto.RogueMajorGlyph_GlyphOfShadowDance)",
                    raw = "time.Second * 8",
                    seconds = 8.0
                  }
                },
                raw = "time.Second * 6"
              },
              duration_raw = "duration",
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
        "blood_spatter",
        "puncturing_wounds",
        "vigor",
        "improved_expose_armor",
        "lethality",
        "vile_poisons",
        "improved_poisons",
        "fleet_footed",
        "cold_blood",
        "improved_kidney_shot",
        "quick_recovery",
        "seal_fate",
        "murder",
        "deadly_brew",
        "overkill",
        "deadened_nerves",
        "focused_attacks",
        "find_weakness",
        "master_poisoner",
        "mutilate",
        "turn_the_tables",
        "cut_to_the_chase",
        "hunger_for_blood",
        "improved_gouge",
        "improved_sinister_strike",
        "dual_wield_specialization",
        "improved_slice_and_dice",
        "deflection",
        "precision",
        "endurance",
        "riposte",
        "close_quarters_combat",
        "improved_kick",
        "improved_sprint",
        "lightning_reflexes",
        "aggression",
        "mace_specialization",
        "blade_flurry",
        "hack_and_slash",
        "weapon_expertise",
        "blade_twisting",
        "vitality",
        "adrenaline_rush",
        "nerves_of_steel",
        "throwing_specialization",
        "combat_potency",
        "unfair_advantage",
        "surprise_attacks",
        "savage_combat",
        "prey_on_the_weak",
        "killing_spree",
        "relentless_strikes",
        "master_of_deception",
        "opportunity",
        "sleight_of_hand",
        "dirty_tricks",
        "camouflage",
        "elusiveness",
        "ghostly_strike",
        "serrated_blades",
        "setup",
        "initiative",
        "improved_ambush",
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
        "waylay",
        "honor_among_thieves",
        "shadowstep",
        "filthy_tricks",
        "slaughter_from_the_shadows",
        "shadow_dance"
      }
    },
    Rogue = {
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
    WarlockTalents = {
      fields = {
        improved_curse_of_agony = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        suppression = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        improved_corruption = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        improved_curse_of_weakness = {
          id = 4,
          type = "int32",
          label = "optional"
        },
        improved_drain_soul = {
          id = 5,
          type = "int32",
          label = "optional"
        },
        improved_life_tap = {
          id = 6,
          type = "int32",
          label = "optional"
        },
        soul_siphon = {
          id = 7,
          type = "int32",
          label = "optional"
        },
        improved_fear = {
          id = 8,
          type = "int32",
          label = "optional"
        },
        fel_concentration = {
          id = 9,
          type = "int32",
          label = "optional"
        },
        amplify_curse = {
          id = 10,
          type = "bool",
          label = "optional"
        },
        grim_reach = {
          id = 11,
          type = "int32",
          label = "optional"
        },
        nightfall = {
          id = 12,
          type = "int32",
          label = "optional"
        },
        empowered_corruption = {
          id = 13,
          type = "int32",
          label = "optional"
        },
        shadow_embrace = {
          id = 14,
          type = "int32",
          label = "optional"
        },
        siphon_life = {
          id = 15,
          type = "bool",
          label = "optional"
        },
        curse_of_exhaustion = {
          id = 16,
          type = "bool",
          label = "optional"
        },
        improved_felhunter = {
          id = 17,
          type = "int32",
          label = "optional"
        },
        shadow_mastery = {
          id = 18,
          type = "int32",
          label = "optional"
        },
        eradication = {
          id = 19,
          type = "int32",
          label = "optional"
        },
        contagion = {
          id = 20,
          type = "int32",
          label = "optional"
        },
        dark_pact = {
          id = 21,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 59092,
              label = "Dark Pact",
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolShadow",
              proc_mask = "2",
              threat_multiplier = "1 - 0.1*float64(warlock.Talents.ImprovedDrainSoul)",
              class_token = "warlock"
            }
          }
        },
        improved_howl_of_terror = {
          id = 22,
          type = "int32",
          label = "optional"
        },
        malediction = {
          id = 23,
          type = "int32",
          label = "optional"
        },
        deaths_embrace = {
          id = 24,
          type = "int32",
          label = "optional"
        },
        unstable_affliction = {
          id = 25,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 47843,
              label = "UnstableAffliction",
              flags = "core.SpellFlagHauntSE | core.SpellFlagAPL",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier_additive = "1 + warlock.GrandSpellstoneBonus() + 0.03*float64(warlock.Talents.ShadowMastery) + core.TernaryFloat64(warlock.Talents.SiphonLife, 0.05, 0) + core.TernaryFloat64(warlock.HasSetBonus(ItemSetDeathbringerGarb, 2), 0.2, 0) + core.TernaryFloat64(warlock.HasSetBonus(ItemSetGuldansRegalia, 4), 0.1, 0)",
              crit_multiplier = "warlock.SpellCritMultiplier(1, 1)",
              threat_multiplier = "1 - 0.1*float64(warlock.Talents.ImprovedDrainSoul)",
              class_token = "warlock"
            }
          }
        },
        pandemic = {
          id = 26,
          type = "bool",
          label = "optional"
        },
        everlasting_affliction = {
          id = 27,
          type = "int32",
          label = "optional"
        },
        haunt = {
          id = 28,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 59164,
              label = "Haunt",
              cooldown = {
                raw = "time.Second * 8",
                seconds = 8.0
              },
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier_additive = "1 + warlock.GrandFirestoneBonus() + 0.03*float64(warlock.Talents.ShadowMastery)",
              crit_multiplier = "warlock.SpellCritMultiplier(1, core.TernaryFloat64(warlock.Talents.Pandemic, 1, 0))",
              threat_multiplier = "1 - 0.1*float64(warlock.Talents.ImprovedDrainSoul)",
              class_token = "warlock"
            },
            aura = {
              class = "warlock",
              spell_id = 59164,
              label = "Haunt",
              duration = {
                raw = "time.Second * 12",
                seconds = 12.0
              },
              class_token = "warlock"
            }
          }
        },
        improved_healthstone = {
          id = 29,
          type = "int32",
          label = "optional"
        },
        improved_imp = {
          id = 30,
          type = "int32",
          label = "optional"
        },
        demonic_embrace = {
          id = 31,
          type = "int32",
          label = "optional"
        },
        fel_synergy = {
          id = 32,
          type = "int32",
          label = "optional"
        },
        improved_health_funnel = {
          id = 33,
          type = "int32",
          label = "optional"
        },
        demonic_brutality = {
          id = 34,
          type = "int32",
          label = "optional"
        },
        fel_vitality = {
          id = 35,
          type = "int32",
          label = "optional"
        },
        improved_sayaad = {
          id = 36,
          type = "int32",
          label = "optional"
        },
        soul_link = {
          id = 37,
          type = "bool",
          label = "optional"
        },
        fel_domination = {
          id = 38,
          type = "bool",
          label = "optional"
        },
        demonic_aegis = {
          id = 39,
          type = "int32",
          label = "optional"
        },
        unholy_power = {
          id = 40,
          type = "int32",
          label = "optional"
        },
        master_summoner = {
          id = 41,
          type = "int32",
          label = "optional"
        },
        mana_feed = {
          id = 42,
          type = "bool",
          label = "optional"
        },
        master_conjuror = {
          id = 43,
          type = "int32",
          label = "optional"
        },
        master_demonologist = {
          id = 44,
          type = "int32",
          label = "optional"
        },
        molten_core = {
          id = 45,
          type = "int32",
          label = "optional"
        },
        demonic_resilience = {
          id = 46,
          type = "int32",
          label = "optional"
        },
        demonic_empowerment = {
          id = 47,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 47193,
              label = "Demonic Empowerment",
              cooldown = {
                raw = "60-6*warlock.Talents.Nemesis * time.Second"
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              class_token = "warlock"
            },
            aura = {
              class = "warlock",
              spell_id = 47193,
              label = "Demonic Empowerment Aura",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "warlock"
            }
          }
        },
        demonic_knowledge = {
          id = 48,
          type = "int32",
          label = "optional"
        },
        demonic_tactics = {
          id = 49,
          type = "int32",
          label = "optional"
        },
        decimation = {
          id = 50,
          type = "int32",
          label = "optional"
        },
        improved_demonic_tactics = {
          id = 51,
          type = "int32",
          label = "optional"
        },
        summon_felguard = {
          id = 52,
          type = "bool",
          label = "optional"
        },
        nemesis = {
          id = 53,
          type = "int32",
          label = "optional"
        },
        demonic_pact = {
          id = 54,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "core",
              spell_id = 47240,
              label = "Demonic Pact",
              duration = {
                raw = "time.Second * 45",
                seconds = 45.0
              },
              class_token = "core"
            }
          }
        },
        metamorphosis = {
          id = 55,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              {
                class = "warlock",
                spell_id = 50589,
                label = "Immolation Aura",
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
              {
                class = "warlock",
                spell_id = 47241,
                label = "Metamorphosis",
                cooldown = {
                  raw = "180-18*warlock.Talents.Nemesis * time.Second"
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                class_token = "warlock"
              }
            },
            aura = {
              class = "warlock",
              spell_id = 47241,
              label = "Metamorphosis Aura",
              duration = {
                cases = {
                  {
                    condition = "warlock.HasMajorGlyph(proto.WarlockMajorGlyph_GlyphOfMetamorphosis)",
                    raw = "time.Second * (30 + 6*(1))",
                    seconds = 36.0
                  },
                  {
                    condition = "!(warlock.HasMajorGlyph(proto.WarlockMajorGlyph_GlyphOfMetamorphosis))",
                    raw = "time.Second * (30 + 6*(0))",
                    seconds = 30.0
                  }
                },
                raw = "time.Second * (30 + 6*core.TernaryDuration(warlock.HasMajorGlyph(proto.WarlockMajorGlyph_GlyphOfMetamorphosis), 1, 0))"
              },
              duration_raw = "time.Second * (30 + 6*core.TernaryDuration(warlock.HasMajorGlyph(proto.WarlockMajorGlyph_GlyphOfMetamorphosis), 1, 0))",
              class_token = "warlock"
            }
          }
        },
        improved_shadow_bolt = {
          id = 56,
          type = "int32",
          label = "optional"
        },
        bane = {
          id = 57,
          type = "int32",
          label = "optional"
        },
        aftermath = {
          id = 58,
          type = "int32",
          label = "optional"
        },
        molten_skin = {
          id = 59,
          type = "int32",
          label = "optional"
        },
        cataclysm = {
          id = 60,
          type = "int32",
          label = "optional"
        },
        demonic_power = {
          id = 61,
          type = "int32",
          label = "optional"
        },
        shadowburn = {
          id = 62,
          type = "bool",
          label = "optional"
        },
        ruin = {
          id = 63,
          type = "int32",
          label = "optional"
        },
        intensity = {
          id = 64,
          type = "int32",
          label = "optional"
        },
        destructive_reach = {
          id = 65,
          type = "int32",
          label = "optional"
        },
        improved_searing_pain = {
          id = 66,
          type = "int32",
          label = "optional"
        },
        backlash = {
          id = 67,
          type = "int32",
          label = "optional"
        },
        improved_immolate = {
          id = 68,
          type = "int32",
          label = "optional"
        },
        devastation = {
          id = 69,
          type = "bool",
          label = "optional"
        },
        nether_protection = {
          id = 70,
          type = "int32",
          label = "optional"
        },
        emberstorm = {
          id = 71,
          type = "int32",
          label = "optional"
        },
        conflagrate = {
          id = 72,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 17962,
              label = "Conflagrate",
              cooldown = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier_additive = "1 + warlock.GrandFirestoneBonus() + 0.03*float64(warlock.Talents.Emberstorm) + 0.03*float64(warlock.Talents.Aftermath) + 0.1*float64(warlock.Talents.ImprovedImmolate) + core.TernaryFloat64(warlock.HasMajorGlyph(proto.WarlockMajorGlyph_GlyphOfImmolate), 0.1, 0) + core.TernaryFloat64(warlock.HasSetBonus(ItemSetDeathbringerGarb, 2), 0.1, 0) + core.TernaryFloat64(warlock.HasSetBonus(ItemSetGuldansRegalia, 4), 0.1, 0)",
              crit_multiplier = "warlock.SpellCritMultiplier(1, float64(warlock.Talents.Ruin)/5)",
              threat_multiplier = "1 - 0.1*float64(warlock.Talents.DestructiveReach)",
              class_token = "warlock"
            }
          }
        },
        soul_leech = {
          id = 73,
          type = "int32",
          label = "optional"
        },
        pyroclasm = {
          id = 74,
          type = "int32",
          label = "optional"
        },
        shadow_and_flame = {
          id = 75,
          type = "int32",
          label = "optional"
        },
        improved_soul_leech = {
          id = 76,
          type = "int32",
          label = "optional"
        },
        backdraft = {
          id = 77,
          type = "int32",
          label = "optional"
        },
        shadowfury = {
          id = 78,
          type = "bool",
          label = "optional"
        },
        empowered_imp = {
          id = 79,
          type = "int32",
          label = "optional"
        },
        fire_and_brimstone = {
          id = 80,
          type = "int32",
          label = "optional"
        },
        chaos_bolt = {
          id = 81,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 59172,
              label = "Chaos Bolt",
              cooldown = {
                raw = "time.Second * (12 - 2*core.TernaryDuration(warlock.HasMajorGlyph(proto.WarlockMajorGlyph_GlyphOfChaosBolt), 1, 0))",
                cases = {
                  {
                    condition = "warlock.HasMajorGlyph(proto.WarlockMajorGlyph_GlyphOfChaosBolt)",
                    raw = "time.Second * (12 - 2*(1))",
                    seconds = 10.0
                  },
                  {
                    condition = "!(warlock.HasMajorGlyph(proto.WarlockMajorGlyph_GlyphOfChaosBolt))",
                    raw = "time.Second * (12 - 2*(0))",
                    seconds = 12.0
                  }
                }
              },
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier_additive = "1 + warlock.GrandFirestoneBonus() + 0.03*float64(warlock.Talents.Emberstorm)",
              crit_multiplier = "warlock.SpellCritMultiplier(1, float64(warlock.Talents.Ruin)/5)",
              threat_multiplier = "1 - 0.1*float64(warlock.Talents.DestructiveReach)",
              class_token = "warlock"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "improved_curse_of_agony",
        "suppression",
        "improved_corruption",
        "improved_curse_of_weakness",
        "improved_drain_soul",
        "improved_life_tap",
        "soul_siphon",
        "improved_fear",
        "fel_concentration",
        "amplify_curse",
        "grim_reach",
        "nightfall",
        "empowered_corruption",
        "shadow_embrace",
        "siphon_life",
        "curse_of_exhaustion",
        "improved_felhunter",
        "shadow_mastery",
        "eradication",
        "contagion",
        "dark_pact",
        "improved_howl_of_terror",
        "malediction",
        "deaths_embrace",
        "unstable_affliction",
        "pandemic",
        "everlasting_affliction",
        "haunt",
        "improved_healthstone",
        "improved_imp",
        "demonic_embrace",
        "fel_synergy",
        "improved_health_funnel",
        "demonic_brutality",
        "fel_vitality",
        "improved_sayaad",
        "soul_link",
        "fel_domination",
        "demonic_aegis",
        "unholy_power",
        "master_summoner",
        "mana_feed",
        "master_conjuror",
        "master_demonologist",
        "molten_core",
        "demonic_resilience",
        "demonic_empowerment",
        "demonic_knowledge",
        "demonic_tactics",
        "decimation",
        "improved_demonic_tactics",
        "summon_felguard",
        "nemesis",
        "demonic_pact",
        "metamorphosis",
        "improved_shadow_bolt",
        "bane",
        "aftermath",
        "molten_skin",
        "cataclysm",
        "demonic_power",
        "shadowburn",
        "ruin",
        "intensity",
        "destructive_reach",
        "improved_searing_pain",
        "backlash",
        "improved_immolate",
        "devastation",
        "nether_protection",
        "emberstorm",
        "conflagrate",
        "soul_leech",
        "pyroclasm",
        "shadow_and_flame",
        "improved_soul_leech",
        "backdraft",
        "shadowfury",
        "empowered_imp",
        "fire_and_brimstone",
        "chaos_bolt"
      }
    },
    Warlock = {
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
        spiritual_focus = {
          id = 1,
          type = "int32",
          label = "optional"
        },
        seals_of_the_pure = {
          id = 2,
          type = "int32",
          label = "optional"
        },
        healing_light = {
          id = 3,
          type = "int32",
          label = "optional"
        },
        divine_intellect = {
          id = 4,
          type = "int32",
          label = "optional"
        },
        unyielding_faith = {
          id = 5,
          type = "int32",
          label = "optional"
        },
        aura_mastery = {
          id = 6,
          type = "bool",
          label = "optional"
        },
        illumination = {
          id = 7,
          type = "int32",
          label = "optional"
        },
        improved_lay_on_hands = {
          id = 8,
          type = "int32",
          label = "optional"
        },
        improved_concentration_aura = {
          id = 9,
          type = "int32",
          label = "optional"
        },
        improved_blessing_of_wisdom = {
          id = 10,
          type = "int32",
          label = "optional"
        },
        blessed_hands = {
          id = 11,
          type = "int32",
          label = "optional"
        },
        pure_of_heart = {
          id = 12,
          type = "int32",
          label = "optional"
        },
        divine_favor = {
          id = 13,
          type = "bool",
          label = "optional"
        },
        sanctified_light = {
          id = 14,
          type = "int32",
          label = "optional"
        },
        purifying_power = {
          id = 15,
          type = "int32",
          label = "optional"
        },
        holy_power = {
          id = 16,
          type = "int32",
          label = "optional"
        },
        lights_grace = {
          id = 17,
          type = "int32",
          label = "optional"
        },
        holy_shock = {
          id = 18,
          type = "bool",
          label = "optional"
        },
        blessed_life = {
          id = 19,
          type = "int32",
          label = "optional"
        },
        sacred_cleansing = {
          id = 20,
          type = "int32",
          label = "optional"
        },
        holy_guidance = {
          id = 21,
          type = "int32",
          label = "optional"
        },
        divine_illumination = {
          id = 22,
          type = "bool",
          label = "optional"
        },
        judgements_of_the_pure = {
          id = 23,
          type = "int32",
          label = "optional"
        },
        infusion_of_light = {
          id = 24,
          type = "int32",
          label = "optional"
        },
        enlightened_judgements = {
          id = 25,
          type = "int32",
          label = "optional"
        },
        beacon_of_light = {
          id = 26,
          type = "bool",
          label = "optional"
        },
        divinity = {
          id = 27,
          type = "int32",
          label = "optional"
        },
        divine_strength = {
          id = 28,
          type = "int32",
          label = "optional"
        },
        stoicism = {
          id = 29,
          type = "int32",
          label = "optional"
        },
        guardians_favor = {
          id = 30,
          type = "int32",
          label = "optional"
        },
        anticipation = {
          id = 31,
          type = "int32",
          label = "optional"
        },
        divine_sacrifice = {
          id = 32,
          type = "bool",
          label = "optional"
        },
        improved_righteous_fury = {
          id = 33,
          type = "int32",
          label = "optional"
        },
        toughness = {
          id = 34,
          type = "int32",
          label = "optional"
        },
        divine_guardian = {
          id = 35,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "core",
              spell_id = 53530,
              label = "DivineGuardian",
              tag = "DivineGuardian",
              duration = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              class_token = "core"
            }
          }
        },
        improved_hammer_of_justice = {
          id = 36,
          type = "int32",
          label = "optional"
        },
        improved_devotion_aura = {
          id = 37,
          type = "int32",
          label = "optional"
        },
        blessing_of_sanctuary = {
          id = 38,
          type = "bool",
          label = "optional"
        },
        reckoning = {
          id = 39,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "paladin",
                label = "Reckoning",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "paladin"
              },
              {
                class = "paladin",
                spell_id = 20182,
                label = "Reckoning Proc",
                duration = {
                  raw = "time.Second * 8",
                  seconds = 8.0
                },
                class_token = "paladin"
              }
            }
          }
        },
        sacred_duty = {
          id = 40,
          type = "int32",
          label = "optional"
        },
        one_handed_weapon_specialization = {
          id = 41,
          type = "int32",
          label = "optional"
        },
        spiritual_attunement = {
          id = 42,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "paladin",
              label = "Spiritual Attunement",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "paladin"
            }
          }
        },
        holy_shield = {
          id = 43,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              {
                class = "paladin",
                spell_id = 48952,
                label = "Holy Shield",
                cooldown = {
                  raw = "time.Second * 8",
                  seconds = 8.0
                },
                flags = "SpellFlagAPL",
                spell_school = "SpellSchoolHoly",
                class_token = "paladin"
              },
              {
                class = "paladin",
                spell_id = 48952,
                label = "Holy Shield",
                spell_school = "SpellSchoolHoly",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "paladin"
              }
            },
            aura = {
              class = "paladin",
              spell_id = 48952,
              label = "Holy Shield",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "paladin"
            }
          }
        },
        ardent_defender = {
          id = 44,
          type = "int32",
          label = "optional",
          _metadata = {
            spell = {
              class = "paladin",
              spell_id = 66233,
              label = "Ardent Defender",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskSpellHealing",
              damage_multiplier = "1",
              crit_multiplier = "1",
              threat_multiplier = "0.25",
              class_token = "paladin"
            },
            aura = {
              class = "paladin",
              spell_id = 66233,
              label = "Ardent Defender",
              duration = {
                raw = "time.Second * 120.0",
                seconds = 120.0
              },
              class_token = "paladin"
            }
          }
        },
        redoubt = {
          id = 45,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              {
                class = "paladin",
                label = "Redoubt",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "paladin"
              },
              {
                class = "paladin",
                spell_id = 20132,
                label = "Redoubt Proc",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "paladin"
              }
            }
          }
        },
        combat_expertise = {
          id = 46,
          type = "int32",
          label = "optional"
        },
        touched_by_the_light = {
          id = 47,
          type = "int32",
          label = "optional"
        },
        avengers_shield = {
          id = 48,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "paladin",
              spell_id = 48827,
              label = "Avengers Shield",
              cooldown = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "core.TernaryFloat64(glyphedSingleTargetAS, 2, 1)",
              crit_multiplier = "paladin.MeleeCritMultiplier()",
              threat_multiplier = "1",
              class_token = "paladin"
            }
          }
        },
        guarded_by_the_light = {
          id = 49,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "paladin",
              label = "Guarded By The Light",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "paladin"
            }
          }
        },
        shield_of_the_templar = {
          id = 50,
          type = "int32",
          label = "optional"
        },
        judgements_of_the_just = {
          id = 51,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "paladin",
              label = "Judgements Of The Just Talent",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "paladin"
            },
            spell = {
              class = "paladin",
              spell_id = 68055,
              label = "Judgements Of The Just",
              proc_mask = "ProcMaskProc",
              class_token = "paladin"
            }
          }
        },
        hammer_of_the_righteous = {
          id = 52,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "paladin",
              spell_id = 53595,
              label = "Hammer Of The Righteous",
              cooldown = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier_additive = "1 + paladin.getItemSetRedemptionPlateBonus2() + paladin.getItemSetT9PlateBonus2() + paladin.getItemSetLightswornPlateBonus2()",
              crit_multiplier = "paladin.MeleeCritMultiplier()",
              threat_multiplier = "1",
              class_token = "paladin"
            }
          }
        },
        deflection = {
          id = 53,
          type = "int32",
          label = "optional"
        },
        benediction = {
          id = 54,
          type = "int32",
          label = "optional"
        },
        improved_judgements = {
          id = 55,
          type = "int32",
          label = "optional"
        },
        heart_of_the_crusader = {
          id = 56,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "paladin",
              label = "Heart of the Crusader",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "paladin"
            }
          }
        },
        improved_blessing_of_might = {
          id = 57,
          type = "int32",
          label = "optional"
        },
        vindication = {
          id = 58,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "paladin",
              label = "Vindication Talent",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "paladin"
            }
          }
        },
        conviction = {
          id = 59,
          type = "int32",
          label = "optional"
        },
        seal_of_command = {
          id = 60,
          type = "bool",
          label = "optional"
        },
        pursuit_of_justice = {
          id = 61,
          type = "int32",
          label = "optional"
        },
        eye_for_an_eye = {
          id = 62,
          type = "int32",
          label = "optional"
        },
        sanctity_of_battle = {
          id = 63,
          type = "int32",
          label = "optional"
        },
        crusade = {
          id = 64,
          type = "int32",
          label = "optional"
        },
        two_handed_weapon_specialization = {
          id = 65,
          type = "int32",
          label = "optional"
        },
        sanctified_retribution = {
          id = 66,
          type = "bool",
          label = "optional"
        },
        vengeance = {
          id = 67,
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
                spell_id = 20057,
                label = "Vengeance Proc",
                duration = {
                  raw = "time.Second * 30",
                  seconds = 30.0
                },
                class_token = "paladin"
              }
            }
          }
        },
        divine_purpose = {
          id = 68,
          type = "int32",
          label = "optional"
        },
        the_art_of_war = {
          id = 69,
          type = "int32",
          label = "optional"
        },
        repentance = {
          id = 70,
          type = "bool",
          label = "optional"
        },
        judgements_of_the_wise = {
          id = 71,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "paladin",
              label = "Judgements of the Wise",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "paladin"
            },
            spell = {
              class = "paladin",
              spell_id = 31878,
              label = "Judgements Of The Wise",
              class_token = "paladin"
            }
          }
        },
        fanaticism = {
          id = 72,
          type = "int32",
          label = "optional"
        },
        sanctified_wrath = {
          id = 73,
          type = "int32",
          label = "optional"
        },
        swift_retribution = {
          id = 74,
          type = "int32",
          label = "optional"
        },
        crusader_strike = {
          id = 75,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "paladin",
              spell_id = 35395,
              label = "Crusader Strike",
              cooldown = {
                raw = "time.Second * 4",
                seconds = 4.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "0.75",
              damage_multiplier_additive = "1 + paladin.getTalentSanctityOfBattleBonus() + paladin.getTalentTheArtOfWarBonus() + paladin.getItemSetGladiatorsVindicationBonusGloves()",
              crit_multiplier = "paladin.MeleeCritMultiplier()",
              threat_multiplier = "1",
              class_token = "paladin"
            }
          }
        },
        sheath_of_light = {
          id = 76,
          type = "int32",
          label = "optional"
        },
        righteous_vengeance = {
          id = 77,
          type = "int32",
          label = "optional",
          _metadata = {
            aura = {
              class = "paladin",
              label = "Righteous Vengeance",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "paladin"
            },
            spell = {
              {
                class = "paladin",
                spell_id = 61840,
                label = "Righteous Vengeance",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreModifiers",
                spell_school = "SpellSchoolHoly",
                proc_mask = "ProcMaskProc",
                class_token = "paladin"
              },
              {
                class = "paladin",
                spell_id = 61840,
                label = "Righteous Vengeance",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagMeleeMetrics | core.SpellFlagIgnoreModifiers",
                spell_school = "SpellSchoolHoly",
                proc_mask = "2",
                damage_multiplier = "1",
                crit_multiplier = "paladin.MeleeCritMultiplier()",
                threat_multiplier = "1",
                class_token = "paladin"
              }
            }
          }
        },
        divine_storm = {
          id = 78,
          type = "bool",
          label = "optional",
          _metadata = {
            spell = {
              class = "paladin",
              spell_id = 53385,
              label = "Divine Storm",
              cooldown = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1.1",
              damage_multiplier_additive = "1 + paladin.getTalentTheArtOfWarBonus() + paladin.getItemSetRedemptionBattlegearBonus2()",
              crit_multiplier = "paladin.MeleeCritMultiplier()",
              threat_multiplier = "1",
              class_token = "paladin"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "spiritual_focus",
        "seals_of_the_pure",
        "healing_light",
        "divine_intellect",
        "unyielding_faith",
        "aura_mastery",
        "illumination",
        "improved_lay_on_hands",
        "improved_concentration_aura",
        "improved_blessing_of_wisdom",
        "blessed_hands",
        "pure_of_heart",
        "divine_favor",
        "sanctified_light",
        "purifying_power",
        "holy_power",
        "lights_grace",
        "holy_shock",
        "blessed_life",
        "sacred_cleansing",
        "holy_guidance",
        "divine_illumination",
        "judgements_of_the_pure",
        "infusion_of_light",
        "enlightened_judgements",
        "beacon_of_light",
        "divinity",
        "divine_strength",
        "stoicism",
        "guardians_favor",
        "anticipation",
        "divine_sacrifice",
        "improved_righteous_fury",
        "toughness",
        "divine_guardian",
        "improved_hammer_of_justice",
        "improved_devotion_aura",
        "blessing_of_sanctuary",
        "reckoning",
        "sacred_duty",
        "one_handed_weapon_specialization",
        "spiritual_attunement",
        "holy_shield",
        "ardent_defender",
        "redoubt",
        "combat_expertise",
        "touched_by_the_light",
        "avengers_shield",
        "guarded_by_the_light",
        "shield_of_the_templar",
        "judgements_of_the_just",
        "hammer_of_the_righteous",
        "deflection",
        "benediction",
        "improved_judgements",
        "heart_of_the_crusader",
        "improved_blessing_of_might",
        "vindication",
        "conviction",
        "seal_of_command",
        "pursuit_of_justice",
        "eye_for_an_eye",
        "sanctity_of_battle",
        "crusade",
        "two_handed_weapon_specialization",
        "sanctified_retribution",
        "vengeance",
        "divine_purpose",
        "the_art_of_war",
        "repentance",
        "judgements_of_the_wise",
        "fanaticism",
        "sanctified_wrath",
        "swift_retribution",
        "crusader_strike",
        "sheath_of_light",
        "righteous_vengeance",
        "divine_storm"
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
        glyph_ids = {
          id = 7,
          type = "message",
          label = "repeated",
          message_type = "GlyphID"
        }
      },
      oneofs = {

      },
      field_order = {
        "items",
        "enchants",
        "gems",
        "encounters",
        "zones",
        "npcs",
        "item_icons",
        "spell_icons",
        "glyph_ids"
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
        heroic = {
          id = 19,
          type = "bool",
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
        "weapon_damage_min",
        "weapon_damage_max",
        "weapon_speed",
        "ilvl",
        "phase",
        "quality",
        "unique",
        "heroic",
        "class_allowlist",
        "required_profession",
        "set_name",
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
        }
      },
      oneofs = {

      },
      field_order = {
        "id",
        "name",
        "icon"
      }
    },
    GlyphID = {
      fields = {
        item_id = {
          id = 1,
          type = "int32",
          label = "optional"
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
        "item_id",
        "spell_id"
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
        consumes = {
          id = 4,
          type = "message",
          label = "optional",
          message_type = "Consumes"
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
        nibelung_average_casts = {
          id = 15,
          type = "double",
          label = "optional"
        },
        nibelung_average_casts_set = {
          id = 16,
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
        "consumes",
        "race",
        "professions",
        "enable_item_swap",
        "item_swap",
        "reaction_time_ms",
        "channel_clip_delay_ms",
        "in_front_of_target",
        "distance_from_target",
        "healing_model",
        "nibelung_average_casts",
        "nibelung_average_casts_set"
      }
    },
    SavedTalents = {
      fields = {
        talents_string = {
          id = 1,
          type = "string",
          label = "optional"
        },
        glyphs = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "Glyphs"
        }
      },
      oneofs = {

      },
      field_order = {
        "talents_string",
        "glyphs"
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
          id = 16,
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
        consumes = {
          id = 4,
          type = "message",
          label = "optional",
          message_type = "Consumes"
        },
        bonus_stats = {
          id = 36,
          type = "message",
          label = "optional",
          message_type = "UnitStats"
        },
        enable_item_swap = {
          id = 46,
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
          id = 15,
          type = "message",
          label = "optional",
          message_type = "IndividualBuffs"
        },
        balance_druid = {
          id = 6,
          type = "message",
          label = "optional",
          message_type = "BalanceDruid"
        },
        feral_druid = {
          id = 22,
          type = "message",
          label = "optional",
          message_type = "FeralDruid"
        },
        feral_tank_druid = {
          id = 26,
          type = "message",
          label = "optional",
          message_type = "FeralTankDruid"
        },
        restoration_druid = {
          id = 37,
          type = "message",
          label = "optional",
          message_type = "RestorationDruid"
        },
        hunter = {
          id = 7,
          type = "message",
          label = "optional",
          message_type = "Hunter"
        },
        mage = {
          id = 8,
          type = "message",
          label = "optional",
          message_type = "Mage"
        },
        retribution_paladin = {
          id = 9,
          type = "message",
          label = "optional",
          message_type = "RetributionPaladin"
        },
        protection_paladin = {
          id = 25,
          type = "message",
          label = "optional",
          message_type = "ProtectionPaladin"
        },
        holy_paladin = {
          id = 38,
          type = "message",
          label = "optional",
          message_type = "HolyPaladin"
        },
        healing_priest = {
          id = 34,
          type = "message",
          label = "optional",
          message_type = "HealingPriest"
        },
        shadow_priest = {
          id = 10,
          type = "message",
          label = "optional",
          message_type = "ShadowPriest"
        },
        smite_priest = {
          id = 20,
          type = "message",
          label = "optional",
          message_type = "SmitePriest"
        },
        rogue = {
          id = 11,
          type = "message",
          label = "optional",
          message_type = "Rogue"
        },
        elemental_shaman = {
          id = 12,
          type = "message",
          label = "optional",
          message_type = "ElementalShaman"
        },
        enhancement_shaman = {
          id = 18,
          type = "message",
          label = "optional",
          message_type = "EnhancementShaman"
        },
        restoration_shaman = {
          id = 39,
          type = "message",
          label = "optional",
          message_type = "RestorationShaman"
        },
        warlock = {
          id = 13,
          type = "message",
          label = "optional",
          message_type = "Warlock"
        },
        warrior = {
          id = 14,
          type = "message",
          label = "optional",
          message_type = "Warrior"
        },
        protection_warrior = {
          id = 21,
          type = "message",
          label = "optional",
          message_type = "ProtectionWarrior"
        },
        deathknight = {
          id = 31,
          type = "message",
          label = "optional",
          message_type = "Deathknight"
        },
        tank_deathknight = {
          id = 32,
          type = "message",
          label = "optional",
          message_type = "TankDeathknight"
        },
        talents_string = {
          id = 17,
          type = "string",
          label = "optional"
        },
        glyphs = {
          id = 28,
          type = "message",
          label = "optional",
          message_type = "Glyphs"
        },
        profession1 = {
          id = 29,
          type = "enum",
          label = "optional",
          enum_type = "Profession"
        },
        profession2 = {
          id = 30,
          type = "enum",
          label = "optional",
          enum_type = "Profession"
        },
        cooldowns = {
          id = 19,
          type = "message",
          label = "optional",
          message_type = "Cooldowns"
        },
        rotation = {
          id = 40,
          type = "message",
          label = "optional",
          message_type = "APLRotation"
        },
        reaction_time_ms = {
          id = 41,
          type = "int32",
          label = "optional"
        },
        channel_clip_delay_ms = {
          id = 42,
          type = "int32",
          label = "optional"
        },
        in_front_of_target = {
          id = 23,
          type = "bool",
          label = "optional"
        },
        distance_from_target = {
          id = 33,
          type = "double",
          label = "optional"
        },
        healing_model = {
          id = 27,
          type = "message",
          label = "optional",
          message_type = "HealingModel"
        },
        database = {
          id = 35,
          type = "message",
          label = "optional",
          message_type = "SimDatabase"
        },
        nibelung_average_casts = {
          id = 43,
          type = "double",
          label = "optional"
        },
        nibelung_average_casts_set = {
          id = 44,
          type = "bool",
          label = "optional"
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
          "smite_priest",
          "rogue",
          "elemental_shaman",
          "enhancement_shaman",
          "restoration_shaman",
          "warlock",
          "warrior",
          "protection_warrior",
          "deathknight",
          "tank_deathknight"
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
        "smite_priest",
        "rogue",
        "elemental_shaman",
        "enhancement_shaman",
        "restoration_shaman",
        "warlock",
        "warrior",
        "protection_warrior",
        "deathknight",
        "tank_deathknight",
        "talents_string",
        "glyphs",
        "profession1",
        "profession2",
        "cooldowns",
        "rotation",
        "reaction_time_ms",
        "channel_clip_delay_ms",
        "in_front_of_target",
        "distance_from_target",
        "healing_model",
        "database",
        "nibelung_average_casts",
        "nibelung_average_casts_set"
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
        "interactive"
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
        }
      },
      oneofs = {

      },
      field_order = {
        "id",
        "is_melee",
        "targets"
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
        crits = {
          id = 3,
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
        "crits",
        "misses",
        "dodges",
        "parries",
        "blocks",
        "glances",
        "damage",
        "threat",
        "healing",
        "shielding",
        "cast_time_ms"
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
        }
      },
      oneofs = {

      },
      field_order = {
        "id",
        "uptime_seconds_avg",
        "uptime_seconds_stdev",
        "procs_avg"
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
        "all_values"
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
        error_result = {
          id = 5,
          type = "string",
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
        "error_result"
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
        "has_cast_time"
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
        "p_death"
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
        glyphs = {
          id = 2,
          type = "message",
          label = "optional",
          message_type = "Glyphs"
        },
        name = {
          id = 3,
          type = "string",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "talents_string",
        "glyphs",
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
        auto_gem = {
          id = 5,
          type = "bool",
          label = "optional"
        },
        default_red_gem = {
          id = 6,
          type = "int32",
          label = "optional"
        },
        default_blue_gem = {
          id = 7,
          type = "int32",
          label = "optional"
        },
        default_yellow_gem = {
          id = 8,
          type = "int32",
          label = "optional"
        },
        default_meta_gem = {
          id = 9,
          type = "int32",
          label = "optional"
        },
        ensure_meta_req_met = {
          id = 10,
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
        "auto_gem",
        "default_red_gem",
        "default_blue_gem",
        "default_yellow_gem",
        "default_meta_gem",
        "ensure_meta_req_met",
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
        error_result = {
          id = 3,
          type = "string",
          label = "optional"
        }
      },
      oneofs = {

      },
      field_order = {
        "results",
        "equipped_gear_result",
        "error_result"
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
              spell_id = 48638,
              label = "Sinister Strike",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | SpellFlagBuilder | SpellFlagColdBlooded | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1 + 0.02*float64(rogue.Talents.FindWeakness) + 0.03*float64(rogue.Talents.Aggression) + 0.05*float64(rogue.Talents.BladeTwisting) + core.TernaryFloat64(rogue.Talents.SurpriseAttacks, 0.1, 0) + core.TernaryFloat64(rogue.HasSetBonus(Tier6, 4), 0.06, 0)",
              crit_multiplier = "rogue.MeleeCritMultiplier(true)",
              threat_multiplier = "1",
              class_token = "rogue"
            }
          }
        },
        shiv = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 5938,
              label = "Shiv",
              flags = "core.SpellFlagMeleeMetrics | SpellFlagBuilder | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeOHSpecial",
              damage_multiplier = "(1 + 0.02*float64(rogue.Talents.FindWeakness) + core.TernaryFloat64(rogue.Talents.SurpriseAttacks, 0.1, 0)) * rogue.dwsMultiplier()",
              crit_multiplier = "rogue.MeleeCritMultiplier(true)",
              threat_multiplier = "1",
              class_token = "rogue"
            }
          }
        },
        slice_and_dice = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 6774,
              label = "Slice And Dice",
              flags = "SpellFlagFinisher | core.SpellFlagAPL",
              class_token = "rogue"
            },
            aura = {
              class = "rogue",
              spell_id = 6774,
              label = "Slice and Dice",
              duration = {
                raw = "rogue.sliceAndDiceDurations[5]"
              },
              class_token = "rogue"
            }
          }
        },
        backstab = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 48657,
              label = "Backstab",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | SpellFlagBuilder | SpellFlagColdBlooded | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1.5 * (1 + 0.02*float64(rogue.Talents.FindWeakness) + 0.1*float64(rogue.Talents.Opportunity) + 0.03*float64(rogue.Talents.Aggression) + 0.05*float64(rogue.Talents.BladeTwisting) + core.TernaryFloat64(rogue.Talents.SurpriseAttacks, 0.1, 0) + core.TernaryFloat64(rogue.HasSetBonus(Tier6, 4), 0.06, 0)) * (1 + 0.02*float64(rogue.Talents.SinisterCalling))",
              crit_multiplier = "rogue.MeleeCritMultiplier(true)",
              threat_multiplier = "1",
              class_token = "rogue"
            }
          }
        },
        tricks_of_the_trade = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 57934,
              label = "Tricks Of The Trade",
              cooldown = {
                raw = "time.Second * 30-5*rogue.Talents.FilthyTricks"
              },
              flags = "SpellFlagAPL",
              class_token = "rogue"
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
                  cases = {
                    {
                      condition = "hasGlyph",
                      raw = "(time.Second*10)",
                      seconds = 10.0
                    },
                    {
                      condition = "!(hasGlyph)",
                      raw = "(time.Second*6)",
                      seconds = 6.0
                    }
                  },
                  raw = "core.TernaryDuration(hasGlyph, time.Second*10, time.Second*6)"
                },
                duration_raw = "core.TernaryDuration(hasGlyph, time.Second*10, time.Second*6)",
                class_token = "rogue"
              }
            }
          }
        },
        vanish = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 26889,
              label = "Vanish",
              cooldown = {
                raw = "time.Second * 180-30*rogue.Talents.Elusiveness"
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS",
                priority = "core.CooldownPriorityDrums"
              },
              flags = "SpellFlagAPL",
              spell_school = "2",
              class_token = "rogue"
            }
          }
        },
        fan_of_knives = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 51723,
              label = "Fan Of Knives",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              spell_school = "2",
              class_token = "rogue"
            }
          }
        },
        make_fan_of_knives_weapon_hit = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 51723,
              label = "Make Fan Of Knives Weapon Hit",
              flags = "core.SpellFlagMeleeMetrics | SpellFlagColdBlooded",
              spell_school = "2",
              proc_mask = "core.ProcMaskMeleeMHSpecial",
              damage_multiplier = "weaponMultiplier * (1 + 0.02*float64(rogue.Talents.FindWeakness) + core.TernaryFloat64(rogue.HasMajorGlyph(proto.RogueMajorGlyph_GlyphOfFanOfKnives), 0.2, 0.0))",
              crit_multiplier = "rogue.MeleeCritMultiplier(false)",
              threat_multiplier = "1",
              class_token = "rogue"
            }
          }
        },
        feint = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 48659,
              label = "Feint",
              cooldown = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "2",
              damage_multiplier = "0",
              threat_multiplier = "1",
              class_token = "rogue"
            }
          }
        },
        stealth = {
          id = 10,
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
          id = 11,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 48676,
              label = "Garrote",
              tag = "RogueBleed",
              flags = "core.SpellFlagMeleeMetrics | SpellFlagBuilder | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1 + glyphMultiplier + 0.15*float64(rogue.Talents.BloodSpatter) + 0.10*float64(rogue.Talents.Opportunity) + 0.02*float64(rogue.Talents.FindWeakness)",
              threat_multiplier = "1",
              class_token = "rogue"
            }
          }
        },
        make_instant_poison = {
          id = 12,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "rogue",
                spell_id = 57965,
                label = "Make Instant Poison",
                spell_school = "SpellSchoolNature",
                proc_mask = "ProcMaskWeaponProc",
                damage_multiplier = "[]float64{1, 1.07, 1.14, 1.20}[rogue.Talents.VilePoisons]",
                crit_multiplier = "rogue.SpellCritMultiplier()",
                threat_multiplier = "1",
                class_token = "rogue"
              },
              {
                class = "rogue",
                spell_id = 57965,
                label = "Make Instant Poison",
                spell_school = "SpellSchoolNature",
                proc_mask = "ProcMaskWeaponProc",
                damage_multiplier = "[]float64{1, 1.07, 1.14, 1.20}[rogue.Talents.VilePoisons]",
                crit_multiplier = "rogue.SpellCritMultiplier()",
                threat_multiplier = "1",
                class_token = "rogue"
              },
              {
                class = "rogue",
                spell_id = 57965,
                label = "Make Instant Poison",
                spell_school = "SpellSchoolNature",
                proc_mask = "ProcMaskWeaponProc",
                damage_multiplier = "[]float64{1, 1.07, 1.14, 1.20}[rogue.Talents.VilePoisons]",
                crit_multiplier = "rogue.SpellCritMultiplier()",
                threat_multiplier = "1",
                class_token = "rogue"
              }
            }
          }
        },
        make_wound_poison = {
          id = 13,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "rogue",
                spell_id = 57975,
                label = "Make Wound Poison",
                spell_school = "SpellSchoolNature",
                proc_mask = "ProcMaskWeaponProc",
                damage_multiplier = "[]float64{1, 1.07, 1.14, 1.20}[rogue.Talents.VilePoisons]",
                crit_multiplier = "rogue.SpellCritMultiplier()",
                threat_multiplier = "1",
                class_token = "rogue"
              },
              {
                class = "rogue",
                spell_id = 57975,
                label = "Make Wound Poison",
                spell_school = "SpellSchoolNature",
                proc_mask = "ProcMaskWeaponProc",
                damage_multiplier = "[]float64{1, 1.07, 1.14, 1.20}[rogue.Talents.VilePoisons]",
                crit_multiplier = "rogue.SpellCritMultiplier()",
                threat_multiplier = "1",
                class_token = "rogue"
              },
              {
                class = "rogue",
                spell_id = 57975,
                label = "Make Wound Poison",
                spell_school = "SpellSchoolNature",
                proc_mask = "ProcMaskWeaponProc",
                damage_multiplier = "[]float64{1, 1.07, 1.14, 1.20}[rogue.Talents.VilePoisons]",
                crit_multiplier = "rogue.SpellCritMultiplier()",
                threat_multiplier = "1",
                class_token = "rogue"
              }
            }
          }
        },
        instant_poison = {
          id = 14,
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
        wound_poison = {
          id = 15,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "rogue",
                spell_id = 57975,
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
          id = 16,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "rogue",
              label = "Deadly Poison",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "rogue"
            },
            spell = {
              class = "rogue",
              spell_id = 57970,
              label = "DeadlyPoison",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskWeaponProc",
              damage_multiplier = "[]float64{1, 1.07, 1.14, 1.20}[rogue.Talents.VilePoisons]",
              threat_multiplier = "1",
              class_token = "rogue"
            }
          }
        },
        ashtongue_talisman = {
          id = 17,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "rogue",
              label = "Ashtongue Talisman",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "rogue"
            }
          }
        },
        van_cleefs2pc = {
          id = 18,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "rogue",
                label = "VanCleef's 2pc",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "rogue"
              },
              {
                class = "rogue",
                spell_id = 67209,
                label = "VanCleef's 2pc Proc",
                duration = {
                  raw = "time.Second * 15",
                  seconds = 15.0
                },
                class_token = "rogue"
              }
            }
          }
        },
        rupture = {
          id = 19,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 48672,
              label = "Rupture",
              tag = "RogueBleed",
              flags = "core.SpellFlagMeleeMetrics | rogue.finisherFlags() | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1 + 0.15*float64(rogue.Talents.BloodSpatter) + 0.02*float64(rogue.Talents.FindWeakness) + core.TernaryFloat64(rogue.HasSetBonus(Tier7, 2), 0.1, 0) + core.TernaryFloat64(rogue.HasSetBonus(Tier8, 4), 0.2, 0) + 0.1*float64(rogue.Talents.SerratedBlades)",
              crit_multiplier = "rogue.MeleeCritMultiplier(false)",
              threat_multiplier = "1",
              class_token = "rogue"
            }
          }
        },
        eviscerate = {
          id = 20,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 48668,
              label = "Eviscerate",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | rogue.finisherFlags() | SpellFlagColdBlooded | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1 + []float64{0.0, 0.07, 0.14, 0.2}[rogue.Talents.ImprovedEviscerate] + 0.02*float64(rogue.Talents.FindWeakness) + 0.03*float64(rogue.Talents.Aggression)",
              crit_multiplier = "rogue.MeleeCritMultiplier(false)",
              threat_multiplier = "1",
              class_token = "rogue"
            }
          }
        },
        new_mutilate_hit = {
          id = 21,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "rogue",
                spell_id = 48665,
                label = "New Mutilate Hit",
                flags = "core.SpellFlagMeleeMetrics | SpellFlagBuilder | SpellFlagColdBlooded",
                spell_school = "2",
                proc_mask = "core.ProcMaskMeleeMHSpecial",
                damage_multiplier = "1 * core.TernaryFloat64(isMH, 1, rogue.dwsMultiplier())",
                damage_multiplier_additive = "1 + 0.1*float64(rogue.Talents.Opportunity) + 0.02*float64(rogue.Talents.FindWeakness) + core.TernaryFloat64(rogue.HasSetBonus(Tier6, 4), 0.06, 0)",
                crit_multiplier = "rogue.MeleeCritMultiplier(true)",
                threat_multiplier = "1",
                class_token = "rogue"
              },
              {
                class = "rogue",
                spell_id = 48665,
                label = "New Mutilate Hit",
                flags = "core.SpellFlagMeleeMetrics | SpellFlagBuilder | SpellFlagColdBlooded",
                spell_school = "2",
                proc_mask = "core.ProcMaskMeleeMHSpecial",
                damage_multiplier = "1 * core.TernaryFloat64(isMH, 1, rogue.dwsMultiplier())",
                damage_multiplier_additive = "1 + 0.1*float64(rogue.Talents.Opportunity) + 0.02*float64(rogue.Talents.FindWeakness) + core.TernaryFloat64(rogue.HasSetBonus(Tier6, 4), 0.06, 0)",
                crit_multiplier = "rogue.MeleeCritMultiplier(true)",
                threat_multiplier = "1",
                class_token = "rogue"
              }
            }
          }
        },
        ambush = {
          id = 22,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 48691,
              label = "Ambush",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | SpellFlagBuilder | SpellFlagColdBlooded | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "2.75 * (1 + 0.02*float64(rogue.Talents.FindWeakness) + 0.1*float64(rogue.Talents.Opportunity))",
              crit_multiplier = "rogue.MeleeCritMultiplier(true)",
              threat_multiplier = "1",
              class_token = "rogue"
            }
          }
        },
        envenom = {
          id = 23,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "rogue",
              spell_id = 57993,
              label = "Envenom",
              flags = "core.SpellFlagMeleeMetrics | rogue.finisherFlags() | SpellFlagColdBlooded | core.SpellFlagAPL",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1 + 0.02*float64(rogue.Talents.FindWeakness) + []float64{0.0, 0.07, 0.14, 0.2}[rogue.Talents.VilePoisons]",
              crit_multiplier = "rogue.MeleeCritMultiplier(false)",
              threat_multiplier = "1",
              class_token = "rogue"
            },
            aura = {
              class = "rogue",
              spell_id = 57993,
              label = "Envenom",
              class_token = "rogue"
            }
          }
        },
        thistle_tea = {
          id = 24,
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
        "shiv",
        "slice_and_dice",
        "backstab",
        "tricks_of_the_trade",
        "vanish",
        "fan_of_knives",
        "make_fan_of_knives_weapon_hit",
        "feint",
        "stealth",
        "garrote",
        "make_instant_poison",
        "make_wound_poison",
        "instant_poison",
        "wound_poison",
        "deadly_poison",
        "ashtongue_talisman",
        "van_cleefs2pc",
        "rupture",
        "eviscerate",
        "new_mutilate_hit",
        "ambush",
        "envenom",
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
                raw = "(time.Second * 60.0) - cdSetBonus"
              },
              flags = "SpellFlagOmenTrigger | core.SpellFlagAPL",
              class_token = "druid"
            },
            aura = {
              class = "druid",
              spell_id = 22812,
              label = "Barkskin",
              duration = {
                raw = "(time.Second * 12) + setBonus"
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
              {
                class = "druid",
                spell_id = 48465,
                label = "Starfire",
                flags = "SpellFlagNaturesGrace | SpellFlagOmenTrigger | core.SpellFlagAPL",
                spell_school = "SpellSchoolArcane",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "(1 + []float64{0.0, 0.03, 0.06, 0.1}[druid.Talents.Moonfury]) * core.TernaryFloat64(druid.HasSetBonus(ItemSetMalfurionsRegalia, 4), 1.04, 1)",
                crit_multiplier = "druid.BalanceCritMultiplier()",
                threat_multiplier = "1",
                class_token = "druid"
              },
              {
                class = "druid",
                spell_id = 54845,
                label = "Starfire",
                flags = "SpellFlagNoLogs",
                proc_mask = "ProcMaskSuppressedProc",
                class_token = "druid"
              }
            }
          }
        },
        savage_defense_passive = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "druid",
              spell_id = 62606,
              label = "Savage Defense",
              duration = {
                raw = "10 * time.Second",
                seconds = 10.0
              },
              class_token = "druid"
            }
          }
        },
        savage_roar = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 52610,
              label = "Savage Roar",
              flags = "SpellFlagAPL",
              class_token = "druid"
            },
            aura = {
              class = "druid",
              spell_id = 52610,
              label = "Savage Roar Aura",
              duration = {
                raw = "9",
                seconds = 9.0
              },
              class_token = "druid"
            }
          }
        },
        bear_form = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 9634,
              label = "Bear Form",
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
              class_token = "druid"
            },
            aura = {
              class = "druid",
              spell_id = 9634,
              label = "Bear Form",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "druid"
            }
          }
        },
        cat_form = {
          id = 6,
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
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 48463,
              label = "Moonfire",
              flags = "SpellFlagNaturesGrace | SpellFlagOmenTrigger | core.SpellFlagAPL",
              spell_school = "SpellSchoolArcane",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "baseDamageMultiplier - malusInitialDamageMultiplier",
              crit_multiplier = "druid.BalanceCritMultiplier()",
              threat_multiplier = "1",
              class_token = "druid"
            }
          }
        },
        hurricane = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "druid",
                spell_id = 48467,
                label = "Hurricane",
                flags = "core.SpellFlagChanneled | core.SpellFlagAPL",
                spell_school = "SpellSchoolNature",
                proc_mask = "ProcMaskSpellDamage",
                class_token = "druid"
              },
              {
                class = "druid",
                spell_id = 48466,
                label = "Hurricane",
                flags = "core.SpellFlagAgentReserved2",
                spell_school = "SpellSchoolNature",
                proc_mask = "ProcMaskProc",
                damage_multiplier = "1 + 0.15*float64(druid.Talents.GaleWinds) + 0.01*float64(druid.Talents.Genesis)",
                crit_multiplier = "1",
                threat_multiplier = "1",
                class_token = "druid"
              }
            }
          }
        },
        innervate = {
          id = 9,
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
              flags = "core.SpellFlagAgentReserved2",
              class_token = "druid"
            }
          }
        },
        fake_gotw = {
          id = 10,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 48470,
              label = "Fake Gotw",
              flags = "SpellFlagOmenTrigger | core.SpellFlagHelpful | core.SpellFlagAPL",
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
        rake = {
          id = 12,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 48574,
              label = "Rake",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIgnoreResists | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1 + 0.1*float64(druid.Talents.SavageFury)",
              crit_multiplier = "druid.MeleeCritMultiplier(Cat)",
              threat_multiplier = "1",
              class_token = "druid"
            }
          }
        },
        shred = {
          id = 13,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 48572,
              label = "Shred",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "2.25",
              crit_multiplier = "druid.MeleeCritMultiplier(Cat)",
              threat_multiplier = "1",
              class_token = "druid"
            }
          }
        },
        rip = {
          id = 14,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 49800,
              label = "Rip",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1 + core.TernaryFloat64(druid.HasSetBonus(ItemSetThunderheartHarness, 4), 0.15, 0)",
              crit_multiplier = "druid.MeleeCritMultiplier(Cat)",
              threat_multiplier = "1",
              class_token = "druid"
            }
          }
        },
        wrath = {
          id = 15,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 48461,
              label = "Wrath",
              flags = "SpellFlagNaturesGrace | SpellFlagOmenTrigger | core.SpellFlagAPL",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "(1 + []float64{0.0, 0.03, 0.06, 0.1}[druid.Talents.Moonfury]) * core.TernaryFloat64(druid.HasSetBonus(ItemSetMalfurionsRegalia, 4), 1.04, 1)",
              crit_multiplier = "druid.BalanceCritMultiplier()",
              threat_multiplier = "1",
              class_token = "druid"
            }
          }
        },
        init = {
          id = 16,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "druid",
              label = "Init",
              label_raw = "label",
              class_token = "druid"
            }
          }
        },
        idolof_lunar_fury = {
          id = 17,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "druid",
              spell_id = 67360,
              label = "Idol of Lunar Fury",
              class_token = "druid"
            }
          }
        },
        brutal_gladiators_idolof_resolve = {
          id = 18,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "druid",
              label = "Brutal Gladiator's Idol of Resolve",
              class_token = "druid"
            }
          }
        },
        vengeful_gladiators_idolof_resolve = {
          id = 19,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "druid",
              label = "Vengeful Gladiator's Idol of Resolve",
              class_token = "druid"
            }
          }
        },
        idolofthe_crying_moon = {
          id = 20,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "druid",
              label = "Idol of the Crying Moon",
              class_token = "druid"
            }
          }
        },
        idolof_mutilation = {
          id = 21,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "druid",
              spell_id = 67355,
              label = "Idol of Mutilation",
              class_token = "druid"
            }
          }
        },
        idolofthe_corruptor = {
          id = 22,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "druid",
              spell_id = 64951,
              label = "Idol of the Corruptor",
              class_token = "druid"
            }
          }
        },
        idolofthe_raven_goddess = {
          id = 23,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "druid",
              label = "Idol of the Raven Goddess",
              class_token = "druid"
            }
          }
        },
        idolofthe_lunar_eclipse = {
          id = 24,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "druid",
              label = "Idol of the Lunar Eclipse",
              class_token = "druid"
            }
          }
        },
        idolofthe_unseen_moon = {
          id = 25,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "druid",
              spell_id = 43740,
              label = "Idol of the Unseen Moon",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "druid"
            }
          }
        },
        idolofthe_white_stag = {
          id = 26,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "druid",
              spell_id = 41037,
              label = "Idol of the White Stag",
              class_token = "druid"
            }
          }
        },
        ashtongue_talisman = {
          id = 27,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "druid",
              label = "Ashtongue Talisman",
              class_token = "druid"
            }
          }
        },
        nightsong2pc = {
          id = 28,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "druid",
              label = "Nightsong 2pc",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "druid"
            }
          }
        },
        swift_starfiretrigger = {
          id = 29,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "druid",
              label = "Swift Starfire trigger",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "druid"
            }
          }
        },
        swift_starfire = {
          id = 30,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "druid",
              spell_id = 46832,
              label = "Swift Starfire",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "druid"
            }
          }
        },
        languish = {
          id = 31,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "druid",
              label = "Languish proc",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "druid"
            },
            spell = {
              class = "druid",
              spell_id = 71023,
              label = "Languish",
              flags = "SpellFlagIgnoreAttackerModifiers | SpellFlagIgnoreTargetModifiers",
              spell_school = "SpellSchoolNature",
              proc_mask = "core.ProcMaskProc | core.ProcMaskNotInSpellbook",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "druid"
            }
          }
        },
        lacerate = {
          id = 32,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 48568,
              label = "Lacerate",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1 * core.TernaryFloat64(druid.HasSetBonus(ItemSetLasherweaveBattlegear, 2), 1.2, 1) * core.TernaryFloat64(druid.HasSetBonus(ItemSetDreamwalkerBattlegear, 2), 1.05, 1)",
              crit_multiplier = "druid.MeleeCritMultiplier(Bear)",
              threat_multiplier = "0.5",
              class_token = "druid"
            }
          }
        },
        rebirth = {
          id = 33,
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
        tigers_fury = {
          id = 34,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 50213,
              label = "Tigers Fury",
              cooldown = {
                raw = "time.Second*30 - cdReduction"
              },
              flags = "SpellFlagAPL",
              class_token = "druid"
            },
            aura = {
              class = "druid",
              spell_id = 50213,
              label = "Tiger's Fury Aura",
              duration = {
                raw = "6 * time.Second",
                seconds = 6.0
              },
              class_token = "druid"
            }
          }
        },
        maul = {
          id = 35,
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
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagNoOnCastComplete",
                spell_school = "2",
                proc_mask = "ProcMaskMeleeMHSpecial",
                damage_multiplier = "1 + 0.1*float64(druid.Talents.SavageFury)",
                crit_multiplier = "druid.MeleeCritMultiplier(Bear)",
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
        swipe_cat = {
          id = 36,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 62078,
              label = "Swipe Cat",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "fidm * weaponMulti",
              crit_multiplier = "druid.MeleeCritMultiplier(Cat)",
              threat_multiplier = "1",
              class_token = "druid"
            }
          }
        },
        swipe_bear = {
          id = 37,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 48562,
              label = "Swipe Bear",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "lbdm * thdm * fidm",
              crit_multiplier = "druid.MeleeCritMultiplier(Bear)",
              threat_multiplier = "1",
              class_token = "druid"
            }
          }
        },
        improved_lotp = {
          id = 38,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "druid",
              spell_id = 34300,
              label = "Improved Leader of the Pack",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "druid"
            }
          }
        },
        up_natures_grace = {
          id = 39,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "druid",
                label = "Natures Grace",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "druid"
              },
              {
                class = "druid",
                spell_id = 16886,
                label = "Natures Grace Proc",
                duration = {
                  raw = "time.Second * 3",
                  seconds = 3.0
                },
                class_token = "druid"
              }
            }
          }
        },
        ferocious_bite = {
          id = 40,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 48577,
              label = "Ferocious Bite",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "(1 + 0.03*float64(druid.Talents.FeralAggression)) * core.TernaryFloat64(druid.HasSetBonus(ItemSetThunderheartHarness, 4), 1.15, 1.0)",
              crit_multiplier = "druid.MeleeCritMultiplier(Cat)",
              threat_multiplier = "1",
              class_token = "druid"
            }
          }
        },
        mangle_cat = {
          id = 41,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 48566,
              label = "Mangle Cat",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "(1 + 0.1*float64(druid.Talents.SavageFury)) * 2.0 * glyphBonus",
              crit_multiplier = "druid.MeleeCritMultiplier(Cat)",
              threat_multiplier = "1",
              class_token = "druid"
            }
          }
        },
        mangle_bear = {
          id = 42,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "druid",
              spell_id = 48564,
              label = "Mangle Bear",
              cooldown = {
                raw = "time.Second * (6 - durReduction)"
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "(1 + 0.1*float64(druid.Talents.SavageFury)) * 1.15 * glyphBonus",
              crit_multiplier = "druid.MeleeCritMultiplier(Bear)",
              threat_multiplier = "core.TernaryFloat64(druid.HasSetBonus(ItemSetThunderheartHarness, 2), 1.15, 1)",
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
        "savage_defense_passive",
        "savage_roar",
        "bear_form",
        "cat_form",
        "moonfire",
        "hurricane",
        "innervate",
        "fake_gotw",
        "frenzied_regeneration",
        "rake",
        "shred",
        "rip",
        "wrath",
        "init",
        "idolof_lunar_fury",
        "brutal_gladiators_idolof_resolve",
        "vengeful_gladiators_idolof_resolve",
        "idolofthe_crying_moon",
        "idolof_mutilation",
        "idolofthe_corruptor",
        "idolofthe_raven_goddess",
        "idolofthe_lunar_eclipse",
        "idolofthe_unseen_moon",
        "idolofthe_white_stag",
        "ashtongue_talisman",
        "nightsong2pc",
        "swift_starfiretrigger",
        "swift_starfire",
        "languish",
        "lacerate",
        "rebirth",
        "tigers_fury",
        "maul",
        "swipe_cat",
        "swipe_bear",
        "improved_lotp",
        "up_natures_grace",
        "ferocious_bite",
        "mangle_cat",
        "mangle_bear"
      },
      synthetic = true
    },
    DeathknightSpells = {
      fields = {
        death_pact = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 48743,
              label = "Death Pact",
              cooldown = {
                raw = "time.Minute * 2",
                seconds = 120.0
              },
              major_cooldown = {
                type = "core.CooldownTypeSurvival"
              },
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
              class_token = "deathknight"
            }
          }
        },
        death_and_decay = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 49938,
              label = "Death and Decay",
              cooldown = {
                raw = "time.Second*30 - time.Second*5*dk.Talents.Morbidity"
              },
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolShadow",
              proc_mask = "2",
              damage_multiplier = "glyphBonus * dk.scourgelordsPlateDamageBonus()",
              crit_multiplier = "dk.DefaultMeleeCritMultiplier()",
              threat_multiplier = "1.9",
              class_token = "deathknight"
            }
          }
        },
        mind_freeze = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 47528,
              label = "Mind Freeze",
              cooldown = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreModifiers",
              spell_school = "SpellSchoolArcane | SpellSchoolFire | SpellSchoolFrost | SpellSchoolHoly | SpellSchoolNature | SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "0",
              class_token = "deathknight"
            }
          }
        },
        blood_tap = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 45529,
              label = "Blood Tap",
              cooldown = {
                raw = "time.Minute * 1",
                seconds = 60.0
              },
              major_cooldown = {
                type = "core.CooldownTypeSurvival"
              },
              flags = "SpellFlagAPL",
              class_token = "deathknight"
            },
            aura = {
              class = "deathknight",
              spell_id = 45529,
              label = "Blood Tap",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "deathknight"
            }
          }
        },
        drw_blood_strike = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 49930,
              label = "Drw Blood Strike",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "0.4 * dk.bloodOfTheNorthCoeff() * dk.thassariansPlateDamageBonus() * dk.bloodyStrikesBonus(BloodyStrikesBS)",
              crit_multiplier = "dk.bonusCritMultiplier(dk.Talents.MightOfMograine + dk.Talents.GuileOfGorefiend)",
              threat_multiplier = "1",
              class_token = "deathknight"
            }
          }
        },
        new_blood_strike = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 49930,
              label = "New Blood Strike",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
              spell_school = "2",
              proc_mask = "dk.threatOfThassarianProcMask(isMH)",
              damage_multiplier = "0.4 * core.TernaryFloat64(isMH, 1, dk.nervesOfColdSteelBonus()) * dk.bloodOfTheNorthCoeff() * dk.thassariansPlateDamageBonus() * dk.bloodyStrikesBonus(BloodyStrikesBS)",
              crit_multiplier = "dk.bonusCritMultiplier(dk.Talents.MightOfMograine + dk.Talents.GuileOfGorefiend)",
              threat_multiplier = "1",
              class_token = "deathknight"
            }
          }
        },
        blood_caked_blade_hit = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "deathknight",
                spell_id = 50463,
                label = "Blood Caked Blade Hit",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagMeleeMetrics",
                spell_school = "2",
                proc_mask = "ProcMaskProc",
                damage_multiplier = "1 * core.TernaryFloat64(isMh, 1, dk.nervesOfColdSteelBonus())",
                threat_multiplier = "1",
                class_token = "deathknight"
              },
              {
                class = "deathknight",
                spell_id = 50463,
                label = "Blood Caked Blade Hit",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagMeleeMetrics",
                spell_school = "2",
                proc_mask = "ProcMaskProc",
                damage_multiplier = "1 * core.TernaryFloat64(isMh, 1, dk.nervesOfColdSteelBonus())",
                threat_multiplier = "1",
                class_token = "deathknight"
              }
            }
          }
        },
        drw_plague_strike = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 49921,
              label = "Drw Plague Strike",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "0.5 * (1.0 + 0.1*float64(dk.Talents.Outbreak))",
              crit_multiplier = "dk.bonusCritMultiplier(dk.Talents.ViciousStrikes)",
              threat_multiplier = "1",
              class_token = "deathknight"
            }
          }
        },
        new_plague_strike = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 49921,
              label = "New Plague Strike",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
              spell_school = "2",
              proc_mask = "dk.threatOfThassarianProcMask(isMH)",
              damage_multiplier = ".5 * core.TernaryFloat64(isMH, 1, dk.nervesOfColdSteelBonus()) * (1.0 + 0.1*float64(dk.Talents.Outbreak)) * core.TernaryFloat64(dk.HasMajorGlyph(proto.DeathknightMajorGlyph_GlyphOfPlagueStrike), 1.2, 1.0)",
              crit_multiplier = "dk.bonusCritMultiplier(dk.Talents.ViciousStrikes)",
              threat_multiplier = "1",
              class_token = "deathknight"
            }
          }
        },
        empower_rune_weapon = {
          id = 10,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 47568,
              label = "Empower Rune Weapon",
              cooldown = {
                raw = "time.Minute * 5",
                seconds = 300.0
              },
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
              class_token = "deathknight"
            }
          }
        },
        drw_pestilence = {
          id = 11,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 50842,
              label = "Drw Pestilence",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "0",
              threat_multiplier = "0",
              class_token = "deathknight"
            }
          }
        },
        pestilence = {
          id = 12,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 50842,
              label = "Pestilence",
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "0",
              threat_multiplier = "0",
              class_token = "deathknight"
            }
          }
        },
        claw = {
          id = 13,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 47468,
              label = "Claw",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1.5",
              crit_multiplier = "2",
              threat_multiplier = "1",
              class_token = "deathknight"
            }
          }
        },
        army_of_the_dead = {
          id = 14,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 42650,
              label = "Army Of The Dead",
              cooldown = {
                raw = "time.Minute*10 - time.Minute*2*dk.Talents.NightOfTheDead"
              },
              flags = "SpellFlagAPL",
              class_token = "deathknight"
            },
            aura = {
              class = "deathknight",
              spell_id = 42650,
              label = "Army of the Dead",
              duration = {
                raw = "time.Millisecond * 500 * 8",
                seconds = 4.0
              },
              class_token = "deathknight"
            }
          }
        },
        icebound_fortitude = {
          id = 15,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 48792,
              label = "Icebound Fortitude",
              cooldown = {
                raw = "time.Minute * 2",
                seconds = 120.0
              },
              major_cooldown = {
                type = "core.CooldownTypeSurvival"
              },
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
              class_token = "deathknight"
            },
            aura = {
              class = "deathknight",
              spell_id = 48792,
              label = "Icebound Fortitude",
              duration = {
                raw = "time.Second*12 + time.Second*2*time.Duration(float64(dk.Talents.GuileOfGorefiend)) + dk.scourgebornePlateIFDurationBonus()"
              },
              class_token = "deathknight"
            }
          }
        },
        drw_death_strike = {
          id = 16,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 49924,
              label = "Drw Death Strike",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = ".75 * dk.improvedDeathStrikeDamageBonus()",
              crit_multiplier = "dk.bonusCritMultiplier(dk.Talents.MightOfMograine)",
              threat_multiplier = "1",
              class_token = "deathknight"
            }
          }
        },
        new_death_strike = {
          id = 17,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 49924,
              label = "New Death Strike",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
              spell_school = "2",
              proc_mask = "dk.threatOfThassarianProcMask(isMH)",
              damage_multiplier = ".75 * core.TernaryFloat64(isMH, 1, dk.nervesOfColdSteelBonus()) * dk.improvedDeathStrikeDamageBonus()",
              crit_multiplier = "dk.bonusCritMultiplier(dk.Talents.MightOfMograine)",
              threat_multiplier = "1",
              class_token = "deathknight"
            }
          }
        },
        drw_icy_touch = {
          id = 18,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 59131,
              label = "Drw Icy Touch",
              spell_school = "SpellSchoolFrost",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1 + 0.05*float64(dk.Talents.ImprovedIcyTouch)",
              crit_multiplier = "dk.DefaultMeleeCritMultiplier()",
              threat_multiplier = "1",
              class_token = "deathknight"
            }
          }
        },
        icy_touch = {
          id = 19,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 59131,
              label = "Icy Touch",
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolFrost",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1 + 0.05*float64(dk.Talents.ImprovedIcyTouch)",
              crit_multiplier = "dk.DefaultMeleeCritMultiplier()",
              threat_multiplier = "1.0",
              class_token = "deathknight"
            }
          }
        },
        frost_presence = {
          id = 20,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 48263,
              label = "Frost Presence",
              cooldown = {
                raw = "time.Second",
                seconds = 1.0
              },
              flags = "SpellFlagAPL",
              class_token = "deathknight"
            },
            aura = {
              class = "deathknight",
              spell_id = 48263,
              label = "Frost Presence",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "deathknight"
            }
          }
        },
        unholy_presence = {
          id = 21,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 48265,
              label = "Unholy Presence",
              cooldown = {
                raw = "time.Second",
                seconds = 1.0
              },
              flags = "SpellFlagAPL",
              class_token = "deathknight"
            },
            aura = {
              class = "deathknight",
              spell_id = 48265,
              label = "Unholy Presence",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "deathknight"
            }
          }
        },
        blood_presence = {
          id = 22,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 50689,
              label = "Blood Presence",
              cooldown = {
                raw = "time.Second",
                seconds = 1.0
              },
              flags = "SpellFlagAPL",
              class_token = "deathknight"
            },
            aura = {
              class = "deathknight",
              spell_id = 50689,
              label = "Blood Presence",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "deathknight"
            }
          }
        },
        new_frost_strike_hit = {
          id = 23,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "deathknight",
              label = "New Frost Strike Hit",
              flags = "SpellFlagMeleeMetrics",
              spell_school = "SpellSchoolFrost",
              proc_mask = "dk.threatOfThassarianProcMask(isMH)",
              damage_multiplier = ".55 * core.TernaryFloat64(isMH, 1, dk.nervesOfColdSteelBonus()) * dk.bloodOfTheNorthCoeff()",
              crit_multiplier = "dk.bonusCritMultiplier(dk.Talents.GuileOfGorefiend)",
              threat_multiplier = "1",
              class_token = "deathknight"
            }
          }
        },
        drw_death_coil = {
          id = 24,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 49895,
              label = "Drw Death Coil",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "(1.0 + float64(dk.Talents.Morbidity)*0.05) * core.TernaryFloat64(dk.HasMajorGlyph(proto.DeathknightMajorGlyph_GlyphOfDarkDeath), 1.15, 1.0)",
              crit_multiplier = "dk.RuneWeapon.DefaultMeleeCritMultiplier()",
              threat_multiplier = "1.0",
              class_token = "deathknight"
            }
          }
        },
        death_coil = {
          id = 25,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 49895,
              label = "Death Coil",
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "(1 + float64(dk.Talents.Morbidity)*0.05) + core.TernaryFloat64(dk.HasMajorGlyph(proto.DeathknightMajorGlyph_GlyphOfDarkDeath), 0.15, 0.0)",
              crit_multiplier = "dk.DefaultMeleeCritMultiplier()",
              threat_multiplier = "1.0",
              class_token = "deathknight"
            }
          }
        },
        raise_dead = {
          id = 26,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 46584,
              label = "Raise Dead",
              cooldown = {
                raw = "time.Minute*3 - time.Second*45*dk.Talents.NightOfTheDead"
              },
              flags = "SpellFlagAPL",
              class_token = "deathknight"
            },
            aura = {
              class = "deathknight",
              spell_id = 46584,
              label = "Raise Dead",
              duration = {
                raw = "time.Minute * 1",
                seconds = 60.0
              },
              class_token = "deathknight"
            }
          }
        },
        gladiators_sigil = {
          id = 27,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "deathknight",
                label = " Gladiator's Sigil of Strife",
                class_token = "deathknight"
              },
              {
                class = "deathknight",
                label = " Gladiator's Sigil of Strife",
                class_token = "deathknight"
              },
              {
                class = "deathknight",
                label = " Gladiator's Sigil of Strife",
                class_token = "deathknight"
              },
              {
                class = "deathknight",
                label = " Gladiator's Sigil of Strife",
                class_token = "deathknight"
              },
              {
                class = "deathknight",
                label = " Gladiator's Sigil of Strife",
                class_token = "deathknight"
              },
              {
                class = "deathknight",
                label = " Gladiator's Sigil of Strife",
                class_token = "deathknight"
              }
            }
          }
        },
        scourgelords_plate = {
          id = 28,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "deathknight",
                label = "Blood Armor",
                class_token = "deathknight"
              },
              {
                class = "deathknight",
                spell_id = 70654,
                label = "Blood Armor Proc",
                duration = {
                  raw = "time.Second * 10.0",
                  seconds = 10.0
                },
                class_token = "deathknight"
              }
            }
          }
        },
        scourgelords_battlegear = {
          id = 29,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "deathknight",
              spell_id = 70657,
              label = "Advantage",
              duration = {
                raw = "15 * time.Second",
                seconds = 15.0
              },
              class_token = "deathknight"
            }
          }
        },
        thassarians_battlegear = {
          id = 30,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "deathknight",
              spell_id = 67117,
              label = "Unholy Might",
              class_token = "deathknight"
            }
          }
        },
        new_heart_strike = {
          id = 31,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "deathknight",
                spell_id = 55262,
                label = "New Heart Strike",
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
                spell_school = "2",
                proc_mask = "ProcMaskMeleeMHSpecial",
                damage_multiplier = ".5 * core.TernaryFloat64(isMainTarget, 1, 0.5) * dk.thassariansPlateDamageBonus() * dk.scourgelordsBattlegearDamageBonus(ScourgelordBonusSpellHS) * dk.bloodyStrikesBonus(BloodyStrikesHS)",
                crit_multiplier = "dk.bonusCritMultiplier(dk.Talents.MightOfMograine)",
                threat_multiplier = "1",
                class_token = "deathknight"
              },
              {
                class = "deathknight",
                spell_id = 55262,
                label = "New Heart Strike",
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
                spell_school = "2",
                proc_mask = "ProcMaskMeleeMHSpecial",
                damage_multiplier = ".5 * core.TernaryFloat64(isMainTarget, 1, 0.5) * dk.thassariansPlateDamageBonus() * dk.scourgelordsBattlegearDamageBonus(ScourgelordBonusSpellHS) * dk.bloodyStrikesBonus(BloodyStrikesHS)",
                crit_multiplier = "dk.bonusCritMultiplier(dk.Talents.MightOfMograine)",
                threat_multiplier = "1",
                class_token = "deathknight"
              }
            }
          }
        },
        gargoyle_strike = {
          id = 32,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 51963,
              label = "Gargoyle Strike",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "1.5",
              threat_multiplier = "1",
              class_token = "deathknight"
            }
          }
        },
        scourge_strike_shadow_damage = {
          id = 33,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 55271,
              label = "Scourge Strike Shadow Damage",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIgnoreAttackerModifiers",
              spell_school = "SpellSchoolShadow",
              proc_mask = "core.ProcMaskSpellDamage | core.ProcMaskProc",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "deathknight"
            }
          }
        },
        drw_blood_boil = {
          id = 34,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 49941,
              label = "Drw Blood Boil",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "dk.bloodyStrikesBonus(BloodyStrikesBB)",
              crit_multiplier = "dk.bonusCritMultiplier(dk.Talents.MightOfMograine)",
              threat_multiplier = "1",
              class_token = "deathknight"
            }
          }
        },
        blood_boil = {
          id = 35,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 49941,
              label = "Blood Boil",
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "dk.bloodyStrikesBonus(BloodyStrikesBB)",
              crit_multiplier = "dk.bonusCritMultiplier(dk.Talents.MightOfMograine)",
              threat_multiplier = "1.0",
              class_token = "deathknight"
            }
          }
        },
        anti_magic_shell = {
          id = 36,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "deathknight",
              spell_id = 48707,
              label = "Anti-Magic Shell",
              duration = {
                cases = {
                  {
                    condition = "dk.HasMajorGlyph(proto.DeathknightMajorGlyph_GlyphOfAntiMagicShell)",
                    raw = "time.Second*5 + (2*time.Second)",
                    seconds = 7.0
                  },
                  {
                    condition = "!(dk.HasMajorGlyph(proto.DeathknightMajorGlyph_GlyphOfAntiMagicShell))",
                    raw = "time.Second*5 + (0)",
                    seconds = 5.0
                  }
                },
                raw = "time.Second*5 + core.TernaryDuration(dk.HasMajorGlyph(proto.DeathknightMajorGlyph_GlyphOfAntiMagicShell), 2*time.Second, 0)"
              },
              duration_raw = "time.Second*5 + core.TernaryDuration(dk.HasMajorGlyph(proto.DeathknightMajorGlyph_GlyphOfAntiMagicShell), 2*time.Second, 0)",
              class_token = "deathknight"
            },
            spell = {
              {
                class = "deathknight",
                spell_id = 49375,
                label = "Anti Magic Shell",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagNoMetrics",
                spell_school = "SpellSchoolArcane | SpellSchoolFire | SpellSchoolFrost | SpellSchoolHoly | SpellSchoolNature | SpellSchoolShadow",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                class_token = "deathknight"
              },
              {
                class = "deathknight",
                spell_id = 48707,
                label = "Anti Magic Shell",
                cooldown = {
                  raw = "time.Second * 45",
                  seconds = 45.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS",
                  priority = "core.CooldownPriorityLow"
                },
                flags = "SpellFlagAPL",
                class_token = "deathknight"
              }
            }
          }
        },
        drw_blood_plague = {
          id = 37,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 55078,
              label = "DrwBloodPlague",
              flags = "SpellFlagDisease",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "dk.RuneWeapon.DefaultMeleeCritMultiplier()",
              threat_multiplier = "1",
              class_token = "deathknight"
            }
          }
        },
        drw_frost_fever = {
          id = 38,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 55095,
              label = "DrwFrostFever",
              flags = "SpellFlagDisease",
              spell_school = "SpellSchoolFrost",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "core.TernaryFloat64(dk.HasMajorGlyph(proto.DeathknightMajorGlyph_GlyphOfIcyTouch), 1.2, 1.0)",
              threat_multiplier = "1",
              class_token = "deathknight"
            }
          }
        },
        blood_plague = {
          id = 39,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "deathknight",
                spell_id = 55078,
                label = "BloodPlague",
                tag = "BloodPlague",
                flags = "SpellFlagDisease",
                spell_school = "SpellSchoolShadow",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "dk.DefaultMeleeCritMultiplier()",
                threat_multiplier = "1",
                class_token = "deathknight"
              },
              {
                class = "deathknight",
                spell_id = 55078,
                label = "Blood Plague",
                flags = "core.SpellFlagNoLogs | core.SpellFlagNoMetrics",
                spell_school = "SpellSchoolShadow",
                proc_mask = "ProcMaskProc",
                class_token = "deathknight"
              }
            }
          }
        },
        drw_rune_strike = {
          id = 40,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 56815,
              label = "Drw Rune Strike",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1.5 * dk.darkrunedPlateRuneStrikeDamageBonus()",
              crit_multiplier = "dk.DefaultMeleeCritMultiplier()",
              threat_multiplier = "1.75",
              class_token = "deathknight"
            }
          }
        },
        rune_strike = {
          id = 41,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "deathknight",
                label = "Rune Strike Trigger",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "deathknight"
              },
              {
                class = "deathknight",
                spell_id = 56815,
                label = "Rune Strike",
                duration = {
                  raw = "6 * time.Second",
                  seconds = 6.0
                },
                class_token = "deathknight"
              }
            },
            spell = {
              class = "deathknight",
              spell_id = 56815,
              label = "Rune Strike",
              flags = "SpellFlagAPL",
              class_token = "deathknight"
            }
          }
        },
        new_rune_strike = {
          id = 42,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 56815,
              label = "New Rune Strike",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
              spell_school = "2",
              proc_mask = "dk.threatOfThassarianRuneStrikeProcMask(isMH)",
              damage_multiplier = "1.5 * dk.darkrunedPlateRuneStrikeDamageBonus()",
              crit_multiplier = "dk.DefaultMeleeCritMultiplier()",
              threat_multiplier = "1.75",
              class_token = "deathknight"
            }
          }
        },
        new_obliterate_hit = {
          id = 43,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "deathknight",
              spell_id = 51425,
              label = "New Obliterate Hit",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
              spell_school = "2",
              proc_mask = "dk.threatOfThassarianProcMask(isMH)",
              damage_multiplier = ".8 * core.TernaryFloat64(isMH, 1, dk.nervesOfColdSteelBonus()) * core.TernaryFloat64(dk.HasMajorGlyph(proto.DeathknightMajorGlyph_GlyphOfObliterate), 1.25, 1.0) * dk.scourgelordsBattlegearDamageBonus(ScourgelordBonusSpellOB)",
              crit_multiplier = "dk.bonusCritMultiplier(dk.Talents.GuileOfGorefiend)",
              threat_multiplier = "1",
              class_token = "deathknight"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "death_pact",
        "death_and_decay",
        "mind_freeze",
        "blood_tap",
        "drw_blood_strike",
        "new_blood_strike",
        "blood_caked_blade_hit",
        "drw_plague_strike",
        "new_plague_strike",
        "empower_rune_weapon",
        "drw_pestilence",
        "pestilence",
        "claw",
        "army_of_the_dead",
        "icebound_fortitude",
        "drw_death_strike",
        "new_death_strike",
        "drw_icy_touch",
        "icy_touch",
        "frost_presence",
        "unholy_presence",
        "blood_presence",
        "new_frost_strike_hit",
        "drw_death_coil",
        "death_coil",
        "raise_dead",
        "gladiators_sigil",
        "scourgelords_plate",
        "scourgelords_battlegear",
        "thassarians_battlegear",
        "new_heart_strike",
        "gargoyle_strike",
        "scourge_strike_shadow_damage",
        "drw_blood_boil",
        "blood_boil",
        "anti_magic_shell",
        "drw_blood_plague",
        "drw_frost_fever",
        "blood_plague",
        "drw_rune_strike",
        "rune_strike",
        "new_rune_strike",
        "new_obliterate_hit"
      },
      synthetic = true
    },
    ShamanSpells = {
      fields = {
        call_of_the_elements = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 66842,
              label = "Call Of The Elements",
              flags = "SpellFlagAPL",
              class_token = "shaman"
            }
          }
        },
        tremor_totem = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 8143,
              label = "Tremor Totem",
              flags = "SpellFlagTotem | core.SpellFlagAPL",
              class_token = "shaman"
            }
          }
        },
        healing_stream_totem = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "shaman",
                spell_id = 58757,
                label = "Healing Stream Totem",
                flags = "SpellFlagTotem | core.SpellFlagAPL",
                class_token = "shaman"
              },
              {
                class = "shaman",
                spell_id = 52042,
                label = "Healing Stream Totem",
                flags = "core.SpellFlagHelpful | core.SpellFlagNoOnCastComplete",
                spell_school = "SpellSchoolNature",
                proc_mask = "2",
                damage_multiplier = "1 + (.02 * float64(shaman.Talents.Purification)) + 0.15*float64(shaman.Talents.RestorativeTotems)",
                crit_multiplier = "1",
                threat_multiplier = "1 - (float64(shaman.Talents.HealingGrace) * 0.05)",
                class_token = "shaman"
              }
            }
          }
        },
        frost_shock = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 49236,
              label = "Frost Shock",
              cooldown = {
                raw = "shaman.ShockCD()"
              },
              flags = "SpellFlagShock | core.SpellFlagAPL",
              spell_school = "core.SpellSchoolFrost",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1 + 0.01*float64(shaman.Talents.Concussion) + core.TernaryFloat64(shaman.HasSetBonus(ItemSetThrallsBattlegear, 4), 0.25, 0)",
              crit_multiplier = "shaman.ElementalCritMultiplier(0)",
              threat_multiplier = "shaman.spellThreatMultiplier()",
              class_token = "shaman"
            }
          }
        },
        flame_shock = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 49233,
              label = "Flame Shock",
              cooldown = {
                raw = "shaman.ShockCD()"
              },
              flags = "SpellFlagShock | core.SpellFlagAPL",
              spell_school = "core.SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1 + 0.01*float64(shaman.Talents.Concussion) + core.TernaryFloat64(shaman.HasSetBonus(ItemSetThrallsBattlegear, 4), 0.25, 0)",
              crit_multiplier = "shaman.ElementalCritMultiplier(0)",
              threat_multiplier = "shaman.spellThreatMultiplier()",
              class_token = "shaman"
            }
          }
        },
        earth_shock = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 49231,
              label = "Earth Shock",
              cooldown = {
                raw = "shaman.ShockCD()"
              },
              flags = "SpellFlagShock | core.SpellFlagAPL",
              spell_school = "core.SpellSchoolNature",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1 + 0.01*float64(shaman.Talents.Concussion) + core.TernaryFloat64(shaman.HasSetBonus(ItemSetThrallsBattlegear, 4), 0.25, 0)",
              crit_multiplier = "shaman.ElementalCritMultiplier(0)",
              threat_multiplier = "shaman.spellThreatMultiplier()",
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
              spell_id = 58734,
              label = "MagmaTotem",
              flags = "SpellFlagTotem | core.SpellFlagAPL",
              spell_school = "SpellSchoolFire",
              proc_mask = "2",
              damage_multiplier = "1 + float64(shaman.Talents.CallOfFlame)*0.05",
              crit_multiplier = "shaman.ElementalCritMultiplier(0)",
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
              spell_id = 58704,
              label = "SearingTotem",
              flags = "SpellFlagTotem | core.SpellFlagAPL",
              spell_school = "SpellSchoolFire",
              proc_mask = "2",
              damage_multiplier = "1 + float64(shaman.Talents.CallOfFlame)*0.05",
              crit_multiplier = "shaman.ElementalCritMultiplier(0)",
              class_token = "shaman"
            }
          }
        },
        fire_shield = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "shaman",
              spell_id = 11350,
              label = "Fire Shield",
              duration = {
                raw = "time.Minute * 2",
                seconds = 120.0
              },
              class_token = "shaman"
            },
            spell = {
              class = "shaman",
              spell_id = 11350,
              label = "FireShield",
              spell_school = "SpellSchoolFire",
              proc_mask = "2",
              damage_multiplier = "1",
              crit_multiplier = "fireElemental.DefaultSpellCritMultiplier()",
              threat_multiplier = "1",
              class_token = "shaman"
            }
          }
        },
        fire_nova = {
          id = 10,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "shaman",
                spell_id = 12470,
                label = "Fire Nova",
                cooldown = {
                  raw = "time.Second",
                  seconds = 1.0
                },
                spell_school = "SpellSchoolFire",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "fireElemental.DefaultSpellCritMultiplier()",
                threat_multiplier = "1",
                class_token = "shaman"
              },
              {
                class = "shaman",
                spell_id = 61657,
                label = "Fire Nova",
                cooldown = {
                  raw = "time.Second * fireNovaCooldown"
                },
                flags = "SpellFlagFocusable | core.SpellFlagAPL",
                spell_school = "SpellSchoolFire",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1 + float64(shaman.Talents.CallOfFlame)*0.05 + float64(shaman.Talents.ImprovedFireNova)*0.1",
                crit_multiplier = "shaman.ElementalCritMultiplier(0)",
                threat_multiplier = "shaman.spellThreatMultiplier()",
                class_token = "shaman"
              }
            }
          }
        },
        fire_blast = {
          id = 11,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 13339,
              label = "Fire Blast",
              cooldown = {
                raw = "time.Second",
                seconds = 1.0
              },
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "fireElemental.DefaultSpellCritMultiplier()",
              threat_multiplier = "1",
              class_token = "shaman"
            }
          }
        },
        chain_heal = {
          id = 12,
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
              damage_multiplier = "1 + .02*float64(shaman.Talents.Purification) + 0.1*float64(shaman.Talents.ImprovedChainHeal)",
              crit_multiplier = "shaman.DefaultHealingCritMultiplier()",
              threat_multiplier = "1 - (float64(shaman.Talents.HealingGrace) * 0.05)",
              class_token = "shaman"
            }
          }
        },
        healing_wave = {
          id = 13,
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
              damage_multiplier = "1 * (1 + .02*float64(shaman.Talents.Purification))",
              crit_multiplier = "shaman.DefaultHealingCritMultiplier()",
              threat_multiplier = "1 - (float64(shaman.Talents.HealingGrace) * 0.05)",
              class_token = "shaman"
            }
          }
        },
        lesser_healing_wave = {
          id = 14,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 49276,
              label = "Lesser Healing Wave",
              flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellHealing",
              damage_multiplier = "1 * (1 + .02*float64(shaman.Talents.Purification))",
              crit_multiplier = "shaman.DefaultHealingCritMultiplier()",
              threat_multiplier = "1 - (float64(shaman.Talents.HealingGrace) * 0.05)",
              class_token = "shaman"
            }
          }
        },
        bizuris_totemof_shattered_ice = {
          id = 15,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "shaman",
              label = "Bizuri's Totem of Shattered Ice Aura",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "shaman"
            }
          }
        },
        furious = {
          id = 16,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "shaman",
              spell_id = 71199,
              label = "Furious",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "shaman"
            }
          }
        },
        totemofthe_avalanche = {
          id = 17,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "shaman",
              label = "Totem of the Avalanche",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "shaman"
            }
          }
        },
        enraged = {
          id = 18,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "shaman",
              spell_id = 71216,
              label = "Enraged",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "shaman"
            }
          }
        },
        totemof_electrifying_wind = {
          id = 19,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "shaman",
              spell_id = 67385,
              label = "Totem of Electrifying Wind",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "shaman"
            }
          }
        },
        totemofthe_elemental_plane = {
          id = 20,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "shaman",
              spell_id = 60771,
              label = "Totem of the Elemental Plane",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "shaman"
            }
          }
        },
        shaman_t10_elemental4_p_bonus = {
          id = 21,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "shaman",
              label = "Shaman T10 Elemental 4P Bonus",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "shaman"
            }
          }
        },
        lava_burst = {
          id = 22,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "shaman",
                spell_id = 60043,
                label = "Lava Burst",
                cooldown = {
                  raw = "time.Second * 8",
                  seconds = 8.0
                },
                flags = "SpellFlagFocusable | core.SpellFlagAPL",
                spell_school = "SpellSchoolFire",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1 + 0.01*float64(shaman.Talents.Concussion) + 0.02*float64(shaman.Talents.CallOfFlame)",
                crit_multiplier = "shaman.ElementalCritMultiplier([]float64{0, 0.06, 0.12, 0.24}[shaman.Talents.LavaFlows] + core.TernaryFloat64(shaman.HasSetBonus(ItemSetEarthShatterGarb, 4), 0.1, 0))",
                threat_multiplier = "shaman.spellThreatMultiplier()",
                class_token = "shaman"
              },
              {
                class = "shaman",
                spell_id = 71824,
                label = "LavaBursted",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreModifiers",
                spell_school = "SpellSchoolFire",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "shaman"
              }
            }
          }
        },
        healing_spells = {
          id = 23,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "shaman",
              spell_id = 53390,
              label = "Tidal Wave Proc",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "shaman"
            }
          }
        },
        spell_pvp_totem = {
          id = 24,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "shaman",
                spell_id = 60570,
                label = "Wrathful Gladiator's Totem of Survival",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "shaman"
              },
              {
                class = "shaman",
                spell_id = 60569,
                label = "Relentless Gladiator's Totem of Survival",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "shaman"
              },
              {
                class = "shaman",
                spell_id = 60568,
                label = "Furious Gladiator's Totem of Survival",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "shaman"
              },
              {
                class = "shaman",
                spell_id = 60567,
                label = "Deadly Gladiator's Totem of Survival",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "shaman"
              },
              {
                class = "shaman",
                spell_id = 60566,
                label = "Hateful Gladiator's Totem of Survival",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "shaman"
              },
              {
                class = "shaman",
                spell_id = 60565,
                label = "Savage Gladiator's Totem of Survival",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "shaman"
              }
            }
          }
        },
        stonebreakers_totem = {
          id = 25,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "shaman",
              spell_id = 43749,
              label = "Stonebreakers Totem",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "shaman"
            }
          }
        },
        skycall_totem = {
          id = 26,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "shaman",
              spell_id = 43751,
              label = "Skycall Totem",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "shaman"
            }
          }
        },
        new_chain_lightning = {
          id = 27,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 49271,
              label = "New Chain Lightning",
              flags = "flags",
              spell_school = "SpellSchoolNature",
              proc_mask = "mask",
              damage_multiplier = "1 + 0.01*float64(shaman.Talents.Concussion)",
              crit_multiplier = "shaman.ElementalCritMultiplier(0)",
              threat_multiplier = "shaman.spellThreatMultiplier()",
              class_token = "shaman"
            }
          }
        },
        new_flametongue_imbue = {
          id = 28,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "shaman",
                spell_id = 58790,
                label = "New Flametongue Imbue",
                spell_school = "SpellSchoolFire",
                proc_mask = "ProcMaskWeaponProc",
                damage_multiplier = "1",
                crit_multiplier = "shaman.ElementalCritMultiplier(0)",
                threat_multiplier = "1",
                class_token = "shaman"
              },
              {
                class = "shaman",
                spell_id = 58790,
                label = "New Flametongue Imbue",
                spell_school = "SpellSchoolFire",
                proc_mask = "ProcMaskWeaponProc",
                damage_multiplier = "1",
                crit_multiplier = "shaman.ElementalCritMultiplier(0)",
                threat_multiplier = "1",
                class_token = "shaman"
              }
            }
          }
        },
        new_earthliving_imbue = {
          id = 29,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 51994,
              label = "Earthliving",
              spell_school = "SpellSchoolNature",
              proc_mask = "2",
              damage_multiplier = "1",
              crit_multiplier = "shaman.ElementalCritMultiplier(0)",
              threat_multiplier = "1",
              class_token = "shaman"
            }
          }
        },
        frostbrand_imbue = {
          id = 30,
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
          id = 31,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 58796,
              label = "New Frostbrand Imbue",
              spell_school = "SpellSchoolFrost",
              proc_mask = "2",
              damage_multiplier = "1",
              crit_multiplier = "shaman.ElementalCritMultiplier(0)",
              threat_multiplier = "1",
              class_token = "shaman"
            }
          }
        },
        frostbrand_debuff = {
          id = 32,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "shaman",
              spell_id = 58799,
              label = "Frostbrand Attack",
              duration = {
                raw = "time.Second * 8",
                seconds = 8.0
              },
              class_token = "shaman"
            }
          }
        },
        new_windfury_imbue = {
          id = 33,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 58804,
              label = "New Windfury Imbue",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
              spell_school = "2",
              proc_mask = "core.ProcMaskMeleeMHSpecial",
              damage_multiplier = "[]float64{1, 1.13, 1.27, 1.4}[shaman.Talents.ElementalWeapons]",
              crit_multiplier = "shaman.DefaultMeleeCritMultiplier()",
              threat_multiplier = "1",
              class_token = "shaman"
            }
          }
        },
        lightning_shield = {
          id = 34,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "shaman",
                spell_id = 49281,
                label = "Lightning Shield",
                flags = "SpellFlagAPL",
                class_token = "shaman"
              },
              {
                class = "shaman",
                spell_id = 49279,
                label = "Lightning Shield",
                spell_school = "SpellSchoolNature",
                proc_mask = "2",
                damage_multiplier = "1 + 0.05*float64(shaman.Talents.ImprovedShields) + core.TernaryFloat64(shaman.HasSetBonus(ItemSetEarthshatterBattlegear, 2), 0.1, 0) + core.TernaryFloat64(shaman.HasMajorGlyph(proto.ShamanMajorGlyph_GlyphOfLightningShield), 0.2, 0)",
                threat_multiplier = "1",
                class_token = "shaman"
              }
            },
            aura = {
              class = "shaman",
              spell_id = 49281,
              label = "Lightning Shield",
              duration = {
                raw = "time.Minute * 10",
                seconds = 600.0
              },
              class_token = "shaman"
            }
          }
        },
        fire_elemental_totem = {
          id = 35,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 2894,
              label = "Fire Elemental Totem",
              cooldown = {
                raw = "time.Minute * core.TernaryFloat64(shaman.HasMajorGlyph(proto.ShamanMajorGlyph_GlyphOfFireElementalTotem), 5, 10)",
                cases = {
                  {
                    condition = "shaman.HasMajorGlyph(proto.ShamanMajorGlyph_GlyphOfFireElementalTotem)",
                    raw = "time.Minute * time.Duration((5))",
                    seconds = 300.0
                  },
                  {
                    condition = "!(shaman.HasMajorGlyph(proto.ShamanMajorGlyph_GlyphOfFireElementalTotem))",
                    raw = "time.Minute * time.Duration((10))",
                    seconds = 600.0
                  }
                }
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              class_token = "shaman"
            },
            aura = {
              class = "shaman",
              spell_id = 2894,
              label = "Fire Elemental Totem",
              duration = {
                raw = "time.Second * 120",
                seconds = 120.0
              },
              class_token = "shaman"
            }
          }
        },
        stormstrike_debuff = {
          id = 36,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "shaman",
              spell_id = 17364,
              label = "Stormstrike",
              duration = {
                raw = "time.Second * 12",
                seconds = 12.0
              },
              class_token = "shaman"
            }
          }
        },
        new_lightning_bolt_spell_config = {
          id = 37,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "shaman",
              spell_id = 64930,
              label = "Electrified",
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreModifiers",
              spell_school = "SpellSchoolNature",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "shaman"
            }
          }
        },
        lightning_bolt = {
          id = 38,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "shaman",
                spell_id = 64930,
                label = "Electrified",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreModifiers",
                spell_school = "SpellSchoolNature",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "shaman"
              },
              {
                class = "shaman",
                spell_id = 64930,
                label = "Electrified",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreModifiers",
                spell_school = "SpellSchoolNature",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "shaman"
              }
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "call_of_the_elements",
        "tremor_totem",
        "healing_stream_totem",
        "frost_shock",
        "flame_shock",
        "earth_shock",
        "magma_totem",
        "searing_totem",
        "fire_shield",
        "fire_nova",
        "fire_blast",
        "chain_heal",
        "healing_wave",
        "lesser_healing_wave",
        "bizuris_totemof_shattered_ice",
        "furious",
        "totemofthe_avalanche",
        "enraged",
        "totemof_electrifying_wind",
        "totemofthe_elemental_plane",
        "shaman_t10_elemental4_p_bonus",
        "lava_burst",
        "healing_spells",
        "spell_pvp_totem",
        "stonebreakers_totem",
        "skycall_totem",
        "new_chain_lightning",
        "new_flametongue_imbue",
        "new_earthliving_imbue",
        "frostbrand_imbue",
        "new_frostbrand_imbue",
        "frostbrand_debuff",
        "new_windfury_imbue",
        "lightning_shield",
        "fire_elemental_totem",
        "stormstrike_debuff",
        "new_lightning_bolt_spell_config",
        "lightning_bolt"
      },
      synthetic = true
    },
    CoreSpells = {
      fields = {
        race_effects = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "core",
                spell_id = 50613,
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
                spell_id = 50613,
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
                spell_id = 50613,
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
                spell_id = 50613,
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
              class = "core",
              spell_id = 50613,
              label = "Berserking (Troll)",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "core"
            }
          }
        },
        minor_crit_debuff = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "core",
                spell_id = 20337,
                label = "Heart of the Crusader",
                duration = {
                  raw = "time.Second*20",
                  seconds = 20.0
                },
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 58410,
                label = "Master Poisoner",
                duration = {
                  raw = "time.Second*20",
                  seconds = 20.0
                },
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 30708,
                label = "Totem of Wrath Debuff",
                duration = {
                  raw = "time.Minute*5",
                  seconds = 300.0
                },
                class_token = "core"
              }
            }
          }
        },
        major_spell_crit_debuff = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "core",
                spell_id = 12873,
                label = "Improved Scorch",
                duration = {
                  raw = "time.Second * 30",
                  seconds = 30.0
                },
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 17800,
                label = "Shadow Mastery",
                duration = {
                  raw = "time.Second * 30",
                  seconds = 30.0
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
              {
                class = "core",
                spell_id = 57393,
                label = "Stampede",
                duration = {
                  raw = "time.Second * 12",
                  seconds = 12.0
                },
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 46855,
                label = "Trauma",
                duration = {
                  raw = "time.Second * 60",
                  seconds = 60.0
                },
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 48566,
                label = "Mangle",
                duration_raw = "time.Minute",
                class_token = "core"
              }
            }
          }
        },
        blood_frenzy_savage_combat = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "core",
                spell_id = 58413,
                label = "Blood Frenzy Savage Combat",
                label_raw = [[label + "-" + strconv.Itoa(int(points))]],
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 29859,
                label = "Blood Frenzy Savage Combat",
                label_raw = [[label + "-" + strconv.Itoa(int(points))]],
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "core"
              }
            }
          }
        },
        ebon_plaguebringer_or_crypt_fever = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              spell_id = 51161,
              label = "Ebon Plaguebringer Or Crypt Fever",
              label_raw = [["EbonPlaguebringer" + strconv.Itoa(casterIndex)]],
              tag = "EbonPlaguebringer",
              duration = {
                raw = "time.Second * (15 + 3*time.Duration(epidemicPoints))"
              },
              class_token = "core"
            },
            spell = {
              class = "core",
              spell_id = 52789,
              label = "Ebon Plaguebringer Or Crypt Fever",
              flags = "SpellFlagNoLogs | SpellFlagNoMetrics | SpellFlagNoOnCastComplete | SpellFlagIgnoreModifiers",
              spell_school = "SpellSchoolArcane | SpellSchoolFire | SpellSchoolFrost | SpellSchoolHoly | SpellSchoolNature | SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "0",
              class_token = "core"
            }
          }
        },
        rune_of_razorice_vulnerability = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              spell_id = 50401,
              label = "RuneOfRazoriceVulnerability",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "core"
            }
          }
        },
        shattering_throw = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              spell_id = 64382,
              label = "Shattering Throw",
              tag = "ShatteringThrow",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "core"
            }
          }
        },
        temporary_stats_on_use = {
          id = 9,
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
        finalize = {
          id = 11,
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
          id = 12,
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
          id = 13,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "core",
              label = "Enable Rage Bar",
              class_token = "core"
            }
          }
        },
        new_cobalt_frag_bomb = {
          id = 14,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "core",
              label = "New Cobalt Frag Bomb",
              spell_school = "SpellSchoolFire",
              proc_mask = "2",
              damage_multiplier = "1",
              crit_multiplier = "2",
              threat_multiplier = "1",
              class_token = "core"
            }
          }
        },
        new_saronite_bomb = {
          id = 15,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "core",
              label = "New Saronite Bomb",
              spell_school = "SpellSchoolFire",
              proc_mask = "2",
              damage_multiplier = "1",
              crit_multiplier = "2",
              threat_multiplier = "1",
              class_token = "core"
            }
          }
        },
        new_explosive_decoy = {
          id = 16,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "core",
              label = "New Explosive Decoy",
              cooldown = {
                raw = "time.Minute * 2",
                seconds = 120.0
              },
              spell_school = "SpellSchoolPhysical",
              proc_mask = "2",
              damage_multiplier = "1",
              crit_multiplier = "2",
              threat_multiplier = "1",
              class_token = "core"
            }
          }
        },
        new_thermal_sapper = {
          id = 17,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "core",
              label = "New Thermal Sapper",
              cooldown = {
                raw = "time.Minute * 5",
                seconds = 300.0
              },
              spell_school = "SpellSchoolFire",
              proc_mask = "2",
              damage_multiplier = "1",
              crit_multiplier = "2",
              threat_multiplier = "1",
              class_token = "core"
            }
          }
        },
        make_potion_activation_internal = {
          id = 18,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "core",
                label = "Make Potion Activation Internal",
                flags = "SpellFlagNoOnCastComplete",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Potion Activation Internal",
                flags = "SpellFlagNoOnCastComplete",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Potion Activation Internal",
                flags = "SpellFlagNoOnCastComplete",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Potion Activation Internal",
                flags = "SpellFlagNoOnCastComplete",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Potion Activation Internal",
                flags = "SpellFlagNoOnCastComplete",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Potion Activation Internal",
                flags = "SpellFlagNoOnCastComplete",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Potion Activation Internal",
                flags = "SpellFlagNoOnCastComplete",
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 38927,
                label = "Make Potion Activation Internal",
                flags = "SpellFlagNoOnCastComplete",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Potion Activation Internal",
                flags = "SpellFlagNoOnCastComplete",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Potion Activation Internal",
                flags = "SpellFlagNoOnCastComplete",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Potion Activation Internal",
                flags = "SpellFlagNoOnCastComplete",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Potion Activation Internal",
                flags = "SpellFlagNoOnCastComplete",
                class_token = "core"
              },
              {
                class = "core",
                label = "Make Potion Activation Internal",
                flags = "SpellFlagNoOnCastComplete",
                class_token = "core"
              }
            }
          }
        },
        conjured = {
          id = 19,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "core",
                label = "Conjured",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
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
                  raw = "time.Minute * 3",
                  seconds = 180.0
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
                spell_school = "SpellSchoolFire",
                proc_mask = "2",
                damage_multiplier = "1",
                crit_multiplier = "character.DefaultSpellCritMultiplier()",
                threat_multiplier = "1",
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
            },
            aura = {
              class = "core",
              label = "Flame Cap",
              duration_raw = "time.Minute",
              class_token = "core"
            }
          }
        },
        consume_effects = {
          id = 20,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              label = "Gift of Arthas",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "core"
            },
            spell = {
              class = "core",
              spell_id = 11374,
              label = "Consume Effects",
              spell_school = "SpellSchoolNature",
              proc_mask = "2",
              threat_multiplier = "1",
              class_token = "core"
            }
          }
        },
        new_temporary_stats_aura_wrapped = {
          id = 21,
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
          id = 22,
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
        external_consecutive_cd_approximation = {
          id = 23,
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
                  raw = "time.Second * 10",
                  seconds = 10.0
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
                spell_id = 64382,
                label = "External Consecutive Cd Approximation",
                cooldown = {
                  raw = "time.Second * 10",
                  seconds = 10.0
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
                spell_id = 47788,
                label = "External Consecutive Cd Approximation",
                cooldown = {
                  raw = "time.Second * 10",
                  seconds = 10.0
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
                spell_id = 33206,
                label = "External Consecutive Cd Approximation",
                cooldown = {
                  raw = "time.Second * 8",
                  seconds = 8.0
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
                spell_id = 6940,
                label = "External Consecutive Cd Approximation",
                cooldown = {
                  raw = "time.Millisecond * 10500",
                  seconds = 10.5
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
                spell_id = 53530,
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
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 57933,
                label = "External Consecutive Cd Approximation",
                cooldown = {
                  raw = "TotTAura.Duration"
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
          id = 24,
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
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "core"
            }
          }
        },
        hand_of_sacrifice = {
          id = 25,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              spell_id = 6940,
              label = "HandOfSacrifice",
              tag = "HandOfSacrifice",
              duration = {
                raw = "time.Millisecond * 10500",
                seconds = 10.5
              },
              class_token = "core"
            }
          }
        },
        tricks_of_the_trade = {
          id = 26,
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
                raw = "TernaryDuration(glyphed, time.Second*10, time.Second*6)"
              },
              class_token = "core"
            }
          }
        },
        revitalize_hot = {
          id = 27,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "core",
                spell_id = 53251,
                label = "Revitalize",
                duration = {
                  raw = "time.Duration(ticks) * tickPeriod"
                },
                class_token = "core"
              },
              {
                class = "core",
                spell_id = 26982,
                label = "Revitalize",
                duration = {
                  raw = "time.Duration(ticks) * tickPeriod"
                },
                class_token = "core"
              }
            }
          }
        },
        replenishment = {
          id = 28,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              spell_id = 57669,
              label = "Replenishment",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "core"
            }
          }
        },
        retribution = {
          id = 29,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "core",
              spell_id = 54043,
              label = "Retribution Aura",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "core"
            },
            spell = {
              class = "core",
              spell_id = 54043,
              label = "Retribution",
              flags = "SpellFlagBinary",
              spell_school = "SpellSchoolHoly",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "core"
            }
          }
        },
        new_fake_elemental_shaman = {
          id = 30,
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
        },
        profession_effects = {
          id = 31,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "core",
              spell_id = 55503,
              label = "Profession Effects",
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180.0
              },
              major_cooldown = {
                type = "CooldownTypeSurvival"
              },
              spell_school = "SpellSchoolNature",
              class_token = "core"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "race_effects",
        "minor_crit_debuff",
        "major_spell_crit_debuff",
        "bleed_damage",
        "blood_frenzy_savage_combat",
        "ebon_plaguebringer_or_crypt_fever",
        "rune_of_razorice_vulnerability",
        "shattering_throw",
        "temporary_stats_on_use",
        "enable_mana_bar_with_modifier",
        "finalize",
        "track_chance_of_death",
        "enable_rage_bar",
        "new_cobalt_frag_bomb",
        "new_saronite_bomb",
        "new_explosive_decoy",
        "new_thermal_sapper",
        "make_potion_activation_internal",
        "conjured",
        "consume_effects",
        "new_temporary_stats_aura_wrapped",
        "make_proc_trigger",
        "external_consecutive_cd_approximation",
        "innervate",
        "hand_of_sacrifice",
        "tricks_of_the_trade",
        "revitalize_hot",
        "replenishment",
        "retribution",
        "new_fake_elemental_shaman",
        "profession_effects"
      },
      synthetic = true
    },
    HunterSpells = {
      fields = {
        new_special = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "hunter",
                spell_id = 53575,
                label = "New Special",
                cooldown = {
                  raw = "hp.hunterOwner.applyLongevity(config.CD)"
                },
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
                spell_school = "core.SpellSchoolPhysical",
                proc_mask = "core.ProcMaskSpellDamage",
                damage_multiplier = "1 * hp.hunterOwner.markedForDeathMultiplier()",
                crit_multiplier = "2",
                threat_multiplier = "1",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 53533,
                label = "New Special",
                cooldown = {
                  raw = "hp.hunterOwner.applyLongevity(config.CD)"
                },
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
                spell_school = "core.SpellSchoolPhysical",
                proc_mask = "core.ProcMaskSpellDamage",
                damage_multiplier = "1 * hp.hunterOwner.markedForDeathMultiplier()",
                crit_multiplier = "2",
                threat_multiplier = "1",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 56631,
                label = "New Special",
                cooldown = {
                  raw = "hp.hunterOwner.applyLongevity(config.CD)"
                },
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
                spell_school = "core.SpellSchoolNature",
                proc_mask = "core.ProcMaskSpellDamage",
                damage_multiplier = "1 * hp.hunterOwner.markedForDeathMultiplier()",
                crit_multiplier = "2",
                threat_multiplier = "1",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 57393,
                label = "New Special",
                cooldown = {
                  raw = "hp.hunterOwner.applyLongevity(config.CD)"
                },
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
                spell_school = "core.SpellSchoolPhysical",
                proc_mask = "core.ProcMaskSpellDamage",
                damage_multiplier = "1 * hp.hunterOwner.markedForDeathMultiplier()",
                crit_multiplier = "2",
                threat_multiplier = "1",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 61198,
                label = "SpiritStrike",
                cooldown = {
                  raw = "hp.hunterOwner.applyLongevity(config.CD)"
                },
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
                spell_school = "core.SpellSchoolArcane",
                proc_mask = "core.ProcMaskSpellDamage",
                damage_multiplier = "1 * hp.hunterOwner.markedForDeathMultiplier()",
                crit_multiplier = "2",
                threat_multiplier = "1",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 53568,
                label = "New Special",
                cooldown = {
                  raw = "hp.hunterOwner.applyLongevity(config.CD)"
                },
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
                spell_school = "core.SpellSchoolNature",
                proc_mask = "core.ProcMaskSpellDamage",
                damage_multiplier = "1 * hp.hunterOwner.markedForDeathMultiplier()",
                crit_multiplier = "2",
                threat_multiplier = "1",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 53543,
                label = "New Special",
                cooldown = {
                  raw = "hp.hunterOwner.applyLongevity(config.CD)"
                },
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
                spell_school = "core.SpellSchoolPhysical",
                proc_mask = "core.ProcMaskSpellDamage",
                damage_multiplier = "1 * hp.hunterOwner.markedForDeathMultiplier()",
                crit_multiplier = "2",
                threat_multiplier = "1",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 53562,
                label = "New Special",
                cooldown = {
                  raw = "hp.hunterOwner.applyLongevity(config.CD)"
                },
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
                spell_school = "core.SpellSchoolPhysical",
                proc_mask = "core.ProcMaskSpellDamage",
                damage_multiplier = "1 * hp.hunterOwner.markedForDeathMultiplier()",
                crit_multiplier = "2",
                threat_multiplier = "1",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 59886,
                label = "Rake",
                cooldown = {
                  raw = "hp.hunterOwner.applyLongevity(config.CD)"
                },
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
                spell_school = "core.SpellSchoolPhysical",
                proc_mask = "core.ProcMaskSpellDamage",
                damage_multiplier = "1 * hp.hunterOwner.markedForDeathMultiplier()",
                crit_multiplier = "2",
                threat_multiplier = "1",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 53589,
                label = "New Special",
                cooldown = {
                  raw = "hp.hunterOwner.applyLongevity(config.CD)"
                },
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
                spell_school = "core.SpellSchoolShadow",
                proc_mask = "core.ProcMaskSpellDamage",
                damage_multiplier = "1 * hp.hunterOwner.markedForDeathMultiplier()",
                crit_multiplier = "2",
                threat_multiplier = "1",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 55499,
                label = "New Special",
                cooldown = {
                  raw = "hp.hunterOwner.applyLongevity(config.CD)"
                },
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
                spell_school = "core.SpellSchoolPhysical",
                proc_mask = "core.ProcMaskSpellDamage",
                damage_multiplier = "1 * hp.hunterOwner.markedForDeathMultiplier()",
                crit_multiplier = "2",
                threat_multiplier = "1",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 25012,
                label = "New Special",
                cooldown = {
                  raw = "hp.hunterOwner.applyLongevity(config.CD)"
                },
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
                spell_school = "core.SpellSchoolNature",
                proc_mask = "core.ProcMaskSpellDamage",
                damage_multiplier = "1 * hp.hunterOwner.markedForDeathMultiplier()",
                crit_multiplier = "2",
                threat_multiplier = "1",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 58611,
                label = "New Special",
                cooldown = {
                  raw = "hp.hunterOwner.applyLongevity(config.CD)"
                },
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
                spell_school = "core.SpellSchoolFire",
                proc_mask = "core.ProcMaskSpellDamage",
                damage_multiplier = "1 * hp.hunterOwner.markedForDeathMultiplier()",
                crit_multiplier = "2",
                threat_multiplier = "1",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 35295,
                label = "New Special",
                cooldown = {
                  raw = "hp.hunterOwner.applyLongevity(config.CD)"
                },
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
                spell_school = "core.SpellSchoolPhysical",
                proc_mask = "core.ProcMaskSpellDamage",
                damage_multiplier = "1 * hp.hunterOwner.markedForDeathMultiplier()",
                crit_multiplier = "2",
                threat_multiplier = "1",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 55492,
                label = "New Special",
                cooldown = {
                  raw = "hp.hunterOwner.applyLongevity(config.CD)"
                },
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
                spell_school = "core.SpellSchoolFrost",
                proc_mask = "core.ProcMaskSpellDamage",
                damage_multiplier = "1 * hp.hunterOwner.markedForDeathMultiplier()",
                crit_multiplier = "2",
                threat_multiplier = "1",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 55485,
                label = "Fire Breath",
                cooldown = {
                  raw = "hp.hunterOwner.applyLongevity(config.CD)"
                },
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
                spell_school = "core.SpellSchoolFire",
                proc_mask = "core.ProcMaskSpellDamage",
                damage_multiplier = "1 * hp.hunterOwner.markedForDeathMultiplier()",
                crit_multiplier = "2",
                threat_multiplier = "1",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 55487,
                label = "New Special",
                cooldown = {
                  raw = "hp.hunterOwner.applyLongevity(config.CD)"
                },
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
                spell_school = "core.SpellSchoolPhysical",
                proc_mask = "core.ProcMaskSpellDamage",
                damage_multiplier = "1 * hp.hunterOwner.markedForDeathMultiplier()",
                crit_multiplier = "2",
                threat_multiplier = "1",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 55754,
                label = "New Special",
                cooldown = {
                  raw = "hp.hunterOwner.applyLongevity(config.CD)"
                },
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
                spell_school = "core.SpellSchoolNature",
                proc_mask = "core.ProcMaskSpellDamage",
                damage_multiplier = "1 * hp.hunterOwner.markedForDeathMultiplier()",
                crit_multiplier = "2",
                threat_multiplier = "1",
                class_token = "hunter"
              }
            }
          }
        },
        new_focus_dump = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "hunter",
                spell_id = 52476,
                label = "New Focus Dump",
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
                spell_school = "2",
                proc_mask = "ProcMaskMeleeMHSpecial",
                damage_multiplier = "1 * hp.hunterOwner.markedForDeathMultiplier()",
                crit_multiplier = "2",
                threat_multiplier = "1",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 52472,
                label = "New Focus Dump",
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
                spell_school = "2",
                proc_mask = "ProcMaskMeleeMHSpecial",
                damage_multiplier = "1 * hp.hunterOwner.markedForDeathMultiplier()",
                crit_multiplier = "2",
                threat_multiplier = "1",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 52474,
                label = "New Focus Dump",
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
                spell_school = "2",
                proc_mask = "ProcMaskMeleeMHSpecial",
                damage_multiplier = "1 * hp.hunterOwner.markedForDeathMultiplier()",
                crit_multiplier = "2",
                threat_multiplier = "1",
                class_token = "hunter"
              }
            }
          }
        },
        new_venom_web_spray = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 55509,
              label = "VenomWebSpray",
              cooldown = {
                raw = "hp.hunterOwner.applyLongevity(time.Second * 40)"
              },
              spell_school = "SpellSchoolNature",
              proc_mask = "2",
              damage_multiplier = "1 * hp.hunterOwner.markedForDeathMultiplier()",
              threat_multiplier = "1",
              class_token = "hunter"
            }
          }
        },
        new_spore_cloud = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 53598,
              label = "SporeCloud",
              cooldown = {
                raw = "hp.hunterOwner.applyLongevity(time.Second * 10)"
              },
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1 * hp.hunterOwner.markedForDeathMultiplier()",
              threat_multiplier = "1",
              class_token = "hunter"
            }
          }
        },
        new_scorpid_poison = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 55728,
              label = "ScorpidPoison",
              cooldown = {
                raw = "hp.hunterOwner.applyLongevity(time.Second * 10)"
              },
              spell_school = "SpellSchoolNature",
              proc_mask = "2",
              damage_multiplier = "1 * hp.hunterOwner.markedForDeathMultiplier()",
              threat_multiplier = "1",
              class_token = "hunter"
            }
          }
        },
        new_savage_rend = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 53582,
              label = "SavageRend",
              cooldown = {
                raw = "hp.hunterOwner.applyLongevity(time.Second * 60)"
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagApplyArmorReduction",
              spell_school = "2",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1 * hp.hunterOwner.markedForDeathMultiplier()",
              crit_multiplier = "2",
              threat_multiplier = "1",
              class_token = "hunter"
            },
            aura = {
              class = "hunter",
              spell_id = 53582,
              label = "Savage Rend",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "hunter"
            }
          }
        },
        new_poison_spit = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 55557,
              label = "PoisonSpit",
              cooldown = {
                raw = "hp.hunterOwner.applyLongevity(time.Second * 10)"
              },
              spell_school = "SpellSchoolNature",
              proc_mask = "2",
              damage_multiplier = "1 * hp.hunterOwner.markedForDeathMultiplier()",
              threat_multiplier = "1",
              class_token = "hunter"
            }
          }
        },
        new_pin = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 53548,
              label = "Pin",
              cooldown = {
                raw = "hp.hunterOwner.applyLongevity(time.Second * 40)"
              },
              spell_school = "2",
              proc_mask = "2",
              damage_multiplier = "1 * hp.hunterOwner.markedForDeathMultiplier()",
              threat_multiplier = "1",
              class_token = "hunter"
            }
          }
        },
        new_monstrous_bite = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "hunter",
              spell_id = 55499,
              label = "Monstrous Bite",
              duration = {
                raw = "time.Second * 12",
                seconds = 12.0
              },
              class_token = "hunter"
            }
          }
        },
        new_furious_howl = {
          id = 10,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "hunter",
                spell_id = 64495,
                label = "New Furious Howl",
                flags = "core.SpellFlagAPL | core.SpellFlagMCD",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 64495,
                label = "New Furious Howl",
                cooldown = {
                  raw = "hp.hunterOwner.applyLongevity(time.Second * 40)"
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                class_token = "hunter"
              }
            }
          }
        },
        steady_shot = {
          id = 11,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 49052,
              label = "Steady Shot",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskRangedSpecial",
              damage_multiplier = "1 * hunter.markedForDeathMultiplier()",
              damage_multiplier_additive = "1 + .03*float64(hunter.Talents.FerociousInspiration) + core.TernaryFloat64(hunter.HasSetBonus(ItemSetGronnstalker, 4), .1, 0)",
              crit_multiplier = "hunter.critMultiplier(true, true, false)",
              threat_multiplier = "1",
              class_token = "hunter"
            },
            aura = {
              class = "hunter",
              spell_id = 53220,
              label = "Improved Steady Shot",
              duration = {
                raw = "time.Second * 12",
                seconds = 12.0
              },
              class_token = "hunter"
            }
          }
        },
        volley = {
          id = 12,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 58434,
              label = "Volley",
              flags = "core.SpellFlagChanneled | core.SpellFlagAPL",
              spell_school = "SpellSchoolArcane",
              proc_mask = "ProcMaskRangedSpecial",
              damage_multiplier = "1 * (1 + 0.04*float64(hunter.Talents.Barrage))",
              crit_multiplier = "hunter.critMultiplier(true, false, false)",
              threat_multiplier = "1",
              class_token = "hunter"
            }
          }
        },
        chimera_shot_serpent_sting = {
          id = 13,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 53353,
              label = "Chimera Shot Serpent Sting",
              flags = "SpellFlagMeleeMetrics",
              spell_school = "SpellSchoolNature",
              proc_mask = "ProcMaskRangedSpecial",
              damage_multiplier = "1 * (2.0 + core.TernaryFloat64(hunter.HasMajorGlyph(proto.HunterMajorGlyph_GlyphOfSerpentSting), 0.8, 0)) * hunter.markedForDeathMultiplier()",
              damage_multiplier_additive = "1 + 0.1*float64(hunter.Talents.ImprovedStings) + core.TernaryFloat64(hunter.HasSetBonus(ItemSetScourgestalkerBattlegear, 2), .1, 0)",
              crit_multiplier = "hunter.critMultiplier(true, false, false)",
              threat_multiplier = "1",
              class_token = "hunter"
            }
          }
        },
        aspect_of_the_viper = {
          id = 14,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 34074,
              label = "Aspect Of The Viper",
              flags = "SpellFlagAPL",
              class_token = "hunter"
            },
            aura = {
              class = "hunter",
              spell_id = 34074,
              label = "Aspect of the Viper",
              class_token = "hunter"
            }
          }
        },
        aspect_of_the_dragonhawk = {
          id = 15,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 61847,
              label = "Aspect Of The Dragonhawk",
              flags = "SpellFlagAPL",
              class_token = "hunter"
            },
            aura = {
              class = "hunter",
              spell_id = 19556,
              label = "Improved Aspect of the Hawk",
              duration = {
                raw = "time.Second * 12",
                seconds = 12.0
              },
              class_token = "hunter"
            }
          }
        },
        kill_command = {
          id = 16,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 34026,
              label = "Kill Command",
              cooldown = {
                raw = "time.Minute - time.Second*10*hunter.Talents.CatlikeReflexes"
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              flags = "SpellFlagNoOnCastComplete",
              spell_school = "2",
              class_token = "hunter"
            },
            aura = {
              class = "hunter",
              spell_id = 34026,
              label = "Kill Command",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "hunter"
            }
          }
        },
        kill_shot = {
          id = 17,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 61006,
              label = "Kill Shot",
              cooldown = {
                raw = "time.Second*15 - core.TernaryDuration(hunter.HasMajorGlyph(proto.HunterMajorGlyph_GlyphOfKillShot), time.Second*6, 0)",
                cases = {
                  {
                    condition = "hunter.HasMajorGlyph(proto.HunterMajorGlyph_GlyphOfKillShot)",
                    raw = "time.Second*15 - (time.Second*6)",
                    seconds = 9.0
                  },
                  {
                    condition = "!(hunter.HasMajorGlyph(proto.HunterMajorGlyph_GlyphOfKillShot))",
                    raw = "time.Second*15 - (0)",
                    seconds = 15.0
                  }
                }
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskRangedSpecial",
              damage_multiplier = "1 * hunter.markedForDeathMultiplier()",
              crit_multiplier = "hunter.critMultiplier(true, true, false)",
              threat_multiplier = "1",
              class_token = "hunter"
            }
          }
        },
        explosive_trap = {
          id = 18,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              label = "Explosive Trap",
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagNoMetrics | core.SpellFlagNoLogs | core.SpellFlagAPL",
              class_token = "hunter"
            }
          }
        },
        serpent_sting = {
          id = 19,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 49001,
              label = "SerpentSting",
              tag = "SerpentSting",
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolNature",
              proc_mask = "2",
              damage_multiplier_additive = "1 + 0.1*float64(hunter.Talents.ImprovedStings) + core.TernaryFloat64(hunter.HasSetBonus(ItemSetScourgestalkerBattlegear, 2), .1, 0)",
              crit_multiplier = "hunter.critMultiplier(true, false, true)",
              threat_multiplier = "1",
              class_token = "hunter"
            }
          }
        },
        raptor_strike = {
          id = 20,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 48996,
              label = "Raptor Strike",
              cooldown = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
              spell_school = "2",
              proc_mask = "core.ProcMaskMeleeMHAuto | core.ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              crit_multiplier = "hunter.critMultiplier(false, false, false)",
              threat_multiplier = "1",
              class_token = "hunter"
            }
          }
        },
        ashtongue_talisman = {
          id = 21,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "hunter",
              label = "Ashtongue Talisman",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "hunter"
            }
          }
        },
        black_bowofthe_betrayer = {
          id = 22,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "hunter",
              spell_id = 46939,
              label = "Black Bow of the Betrayer",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "hunter"
            }
          }
        },
        init = {
          id = 23,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              label = "Init",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagNoOnCastComplete",
              spell_school = "2",
              proc_mask = "ProcMaskRangedAuto",
              damage_multiplier = "0.5",
              crit_multiplier = "hunter.AutoAttacks.RangedConfig().CritMultiplier",
              threat_multiplier = "1",
              class_token = "hunter"
            }
          }
        },
        ahn_kahar4pc = {
          id = 24,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "hunter",
                label = "AhnKahar 4pc",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 70730,
                label = "AhnKahar 4pc Proc",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "hunter"
              }
            }
          }
        },
        ahn_kahar2pc = {
          id = 25,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "hunter",
                label = "AhnKahar 2pc",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 70727,
                label = "AhnKahar 2pc Proc",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "hunter"
              }
            }
          }
        },
        windrunner4pc = {
          id = 26,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "hunter",
                label = "Windrunner 4pc",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "hunter"
              },
              {
                class = "hunter",
                label = "Windrunner 4pc",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "hunter"
              }
            }
          }
        },
        rapid_fire = {
          id = 27,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "hunter",
              spell_id = 3045,
              label = "Rapid Fire",
              cooldown = {
                raw = "time.Minute*5 - time.Minute*hunter.Talents.RapidKilling"
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
        make_explosive_shot = {
          id = 28,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "hunter",
                spell_id = 60053,
                label = "ExplosiveShot",
                cooldown = {
                  raw = "time.Second * 6",
                  seconds = 6.0
                },
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
                spell_school = "SpellSchoolFire",
                proc_mask = "ProcMaskRangedSpecial",
                damage_multiplier = "1",
                damage_multiplier_additive = "1 + .02*float64(hunter.Talents.TNT)",
                crit_multiplier = "hunter.critMultiplier(true, false, false)",
                threat_multiplier = "1",
                class_token = "hunter"
              },
              {
                class = "hunter",
                spell_id = 60053,
                label = "ExplosiveShot",
                cooldown = {
                  raw = "time.Second * 6",
                  seconds = 6.0
                },
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
                spell_school = "SpellSchoolFire",
                proc_mask = "ProcMaskRangedSpecial",
                damage_multiplier = "1",
                damage_multiplier_additive = "1 + .02*float64(hunter.Talents.TNT)",
                crit_multiplier = "hunter.critMultiplier(true, false, false)",
                threat_multiplier = "1",
                class_token = "hunter"
              }
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "new_special",
        "new_focus_dump",
        "new_venom_web_spray",
        "new_spore_cloud",
        "new_scorpid_poison",
        "new_savage_rend",
        "new_poison_spit",
        "new_pin",
        "new_monstrous_bite",
        "new_furious_howl",
        "steady_shot",
        "volley",
        "chimera_shot_serpent_sting",
        "aspect_of_the_viper",
        "aspect_of_the_dragonhawk",
        "kill_command",
        "kill_shot",
        "explosive_trap",
        "serpent_sting",
        "raptor_strike",
        "ashtongue_talisman",
        "black_bowofthe_betrayer",
        "init",
        "ahn_kahar4pc",
        "ahn_kahar2pc",
        "windrunner4pc",
        "rapid_fire",
        "make_explosive_shot"
      },
      synthetic = true
    },
    PriestSpells = {
      fields = {
        flash_heal = {
          id = 1,
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
              crit_multiplier = "priest.DefaultHealingCritMultiplier()",
              threat_multiplier = "1 - []float64{0, .07, .14, .20}[priest.Talents.SilentResolve]",
              class_token = "priest"
            }
          }
        },
        get_mind_flay_tick = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              spell_id = 58381,
              label = "Get Mind Flay Tick (Spell 58381)",
              spell_school = "SpellSchoolShadow",
              proc_mask = "core.ProcMaskProc | core.ProcMaskNotInSpellbook",
              damage_multiplier = "1 + 0.02*float64(priest.Talents.Darkness) + 0.01*float64(priest.Talents.TwinDisciplines)",
              crit_multiplier = "priest.SpellCritMultiplier(1, float64(priest.Talents.ShadowPower)/5)",
              threat_multiplier = "1 - 0.08*float64(priest.Talents.ShadowAffinity)",
              class_token = "priest"
            }
          }
        },
        get_pain_and_suffering = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              spell_id = 47948,
              label = "Get Pain And Suffering",
              flags = "SpellFlagNoLogs",
              proc_mask = "ProcMaskSuppressedProc",
              class_token = "priest"
            }
          }
        },
        initialize = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "priest",
              spell_id = 61792,
              label = "Shadowy Insight",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "priest"
            }
          }
        },
        new_shadowfiend = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              spell_id = 63619,
              label = "New Shadowfiend",
              flags = "SpellFlagNoLogs",
              spell_school = "SpellSchoolArcane | SpellSchoolFire | SpellSchoolFrost | SpellSchoolHoly | SpellSchoolNature | SpellSchoolShadow",
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
        shadowfiend = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              spell_id = 34433,
              label = "Shadowfiend",
              cooldown = {
                raw = "time.Minute * 5-priest.Talents.VeiledShadows"
              },
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolShadow",
              proc_mask = "2",
              class_token = "priest"
            },
            aura = {
              class = "priest",
              spell_id = 34433,
              label = "Shadowfiend",
              duration = {
                raw = "time.Second * 15.0",
                seconds = 15.0
              },
              class_token = "priest"
            }
          }
        },
        shadow_word_death = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              spell_id = 48158,
              label = "Shadow Word Death",
              cooldown = {
                raw = "time.Second * 12",
                seconds = 12.0
              },
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1 + 0.02*float64(priest.Talents.Darkness) + 0.01*float64(priest.Talents.TwinDisciplines)",
              crit_multiplier = "priest.SpellCritMultiplier(1, float64(priest.Talents.ShadowPower)/5)",
              threat_multiplier = "1 - 0.08*float64(priest.Talents.ShadowAffinity)",
              class_token = "priest"
            }
          }
        },
        devouring_plague = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "priest",
                spell_id = 48300,
                label = "DevouringPlague",
                flags = "core.SpellFlagDisease | core.SpellFlagAPL",
                spell_school = "SpellSchoolShadow",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1 + 0.02*float64(priest.Talents.Darkness) + 0.01*float64(priest.Talents.TwinDisciplines) + 0.05*float64(priest.Talents.ImprovedDevouringPlague) + core.TernaryFloat64(priest.HasSetBonus(ItemSetConquerorSanct, 2), 0.15, 0)",
                crit_multiplier = "priest.SpellCritMultiplier(1, 1)",
                threat_multiplier = "1 - 0.05*float64(priest.Talents.ShadowAffinity)",
                class_token = "priest"
              },
              {
                class = "priest",
                spell_id = 63675,
                label = "Devouring Plague",
                flags = "SpellFlagDisease",
                spell_school = "SpellSchoolShadow",
                proc_mask = "ProcMaskSuppressedProc",
                damage_multiplier = "1 + 0.02*float64(priest.Talents.Darkness) + 0.01*float64(priest.Talents.TwinDisciplines) + 0.05*float64(priest.Talents.ImprovedDevouringPlague) + core.TernaryFloat64(priest.HasSetBonus(ItemSetConquerorSanct, 2), 0.15, 0)",
                crit_multiplier = "priest.DefaultSpellCritMultiplier()",
                threat_multiplier = "1 - 0.05*float64(priest.Talents.ShadowAffinity)",
                class_token = "priest"
              }
            }
          }
        },
        power_word_shield = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "priest",
                label = "Power Word Shield",
                flags = "SpellFlagHelpful",
                spell_school = "SpellSchoolHoly",
                proc_mask = "ProcMaskSpellHealing",
                damage_multiplier = "0.2 * (1 + .01*float64(priest.Talents.BlessedResilience)) * (1 + .02*float64(priest.Talents.FocusedPower)) * (1 + .05*float64(priest.Talents.ImprovedPowerWordShield) + .01*float64(priest.Talents.TwinDisciplines)) * core.TernaryFloat64(priest.HasSetBonus(ItemSetCrimsonAcolytesRaiment, 4), 1.05, 1)",
                threat_multiplier = "1 - []float64{0, .07, .14, .20}[priest.Talents.SilentResolve]",
                class_token = "priest"
              },
              {
                class = "priest",
                spell_id = 48066,
                label = "Power Word Shield",
                flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
                spell_school = "SpellSchoolHoly",
                proc_mask = "ProcMaskSpellHealing",
                damage_multiplier = "1 * (1 + .05*float64(priest.Talents.ImprovedPowerWordShield)) * (1 + .01*float64(priest.Talents.TwinDisciplines) + .02*float64(priest.Talents.FocusedPower) + .02*float64(priest.Talents.SpiritualHealing)) * core.TernaryFloat64(priest.HasSetBonus(ItemSetCrimsonAcolytesRaiment, 4), 1.05, 1)",
                threat_multiplier = "1 - []float64{0, .07, .14, .20}[priest.Talents.SilentResolve]",
                class_token = "priest"
              }
            },
            aura = {
              class = "priest",
              spell_id = 6788,
              label = "Weakened Soul",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "priest"
            }
          }
        },
        renew = {
          id = 10,
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
                damage_multiplier = "1 * float64(priest.renewTicks()) * priest.renewHealingMultiplier() * .05 * float64(priest.Talents.EmpoweredRenew) * core.TernaryFloat64(priest.HasSetBonus(ItemSetZabrasRaiment, 4), 1.1, 1)",
                crit_multiplier = "priest.DefaultHealingCritMultiplier()",
                threat_multiplier = "1 - []float64{0, .07, .14, .20}[priest.Talents.SilentResolve]",
                class_token = "priest"
              }
            }
          }
        },
        smite = {
          id = 11,
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
              crit_multiplier = "priest.DefaultSpellCritMultiplier()",
              threat_multiplier = "1 - []float64{0, .07, .14, .20}[priest.Talents.SilentResolve]",
              class_token = "priest"
            }
          }
        },
        binding_heal = {
          id = 12,
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
              crit_multiplier = "priest.DefaultHealingCritMultiplier()",
              threat_multiplier = "0.5 * (1 - []float64{0, .07, .14, .20}[priest.Talents.SilentResolve])",
              class_token = "priest"
            }
          }
        },
        new_mind_sear = {
          id = 13,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              label = "New Mind Sear",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskProc",
              damage_multiplier = "1 + 0.02*float64(priest.Talents.Darkness) + 0.01*float64(priest.Talents.TwinDisciplines)",
              crit_multiplier = "priest.DefaultSpellCritMultiplier()",
              threat_multiplier = "1 - 0.08*float64(priest.Talents.ShadowAffinity)",
              class_token = "priest"
            }
          }
        },
        get_mind_sear_tick = {
          id = 14,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              label = "Get Mind Sear Tick",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskProc",
              damage_multiplier = "1 + 0.02*float64(priest.Talents.Darkness) + 0.01*float64(priest.Talents.TwinDisciplines)",
              crit_multiplier = "priest.DefaultSpellCritMultiplier()",
              threat_multiplier = "1 - 0.08*float64(priest.Talents.ShadowAffinity)",
              class_token = "priest"
            }
          }
        },
        make_prayer_of_mending = {
          id = 15,
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
          id = 16,
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
              damage_multiplier = "1 * (1 + .02*float64(priest.Talents.SpiritualHealing)) * (1 + .01*float64(priest.Talents.BlessedResilience)) * (1 + .02*float64(priest.Talents.FocusedPower)) * (1 + .02*float64(priest.Talents.DivineProvidence)) * (1 + .01*float64(priest.Talents.TwinDisciplines)) * core.TernaryFloat64(priest.HasSetBonus(ItemSetZabrasRaiment, 2), 1.2, 1)",
              crit_multiplier = "priest.DefaultHealingCritMultiplier()",
              threat_multiplier = "1 - []float64{0, .07, .14, .20}[priest.Talents.SilentResolve]",
              class_token = "priest"
            }
          }
        },
        crimson_acolytes_raiment2pc = {
          id = 17,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "priest",
              label = "Crimson Acolytes Raiment 2pc",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "priest"
            }
          }
        },
        crimson_acolyte_raiment2pc = {
          id = 18,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              spell_id = 70770,
              label = "CrimsonAcolyteRaiment2pc",
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreModifiers | core.SpellFlagHelpful",
              spell_school = "SpellSchoolHoly",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1 - []float64{0, .07, .14, .20}[priest.Talents.SilentResolve]",
              class_token = "priest"
            }
          }
        },
        sancitifcation_reglia4pc = {
          id = 19,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "priest",
              label = "Sancitifcation Reglia 4pc",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "priest"
            }
          }
        },
        devious_mind = {
          id = 20,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "priest",
              label = "Devious Mind Proc",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "priest"
            }
          }
        },
        prayer_of_healing = {
          id = 21,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "priest",
                label = "PoH Glyph",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagHelpful",
                spell_school = "SpellSchoolHoly",
                proc_mask = "ProcMaskSpellHealing",
                damage_multiplier = "priest.PrayerOfHealing.DamageMultiplier * 0.2 / 2",
                threat_multiplier = "1 - []float64{0, .07, .14, .20}[priest.Talents.SilentResolve]",
                class_token = "priest"
              },
              {
                class = "priest",
                spell_id = 48072,
                label = "Prayer Of Healing",
                flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
                spell_school = "SpellSchoolHoly",
                proc_mask = "ProcMaskSpellHealing",
                damage_multiplier = "1 * (1 + .02*float64(priest.Talents.SpiritualHealing)) * (1 + .01*float64(priest.Talents.BlessedResilience)) * (1 + .02*float64(priest.Talents.FocusedPower)) * (1 + .02*float64(priest.Talents.DivineProvidence))",
                crit_multiplier = "priest.DefaultHealingCritMultiplier()",
                threat_multiplier = "1 - []float64{0, .07, .14, .20}[priest.Talents.SilentResolve]",
                class_token = "priest"
              }
            }
          }
        },
        mind_trauma = {
          id = 22,
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
        mind_blast = {
          id = 23,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "priest",
                spell_id = 48127,
                label = "Mind Blast",
                cooldown = {
                  raw = "time.Second*8 - time.Millisecond*500*priest.Talents.ImprovedMindBlast"
                },
                flags = "SpellFlagAPL",
                spell_school = "SpellSchoolShadow",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1 * (1 + 0.02*float64(priest.Talents.Darkness)) * core.TernaryFloat64(priest.HasSetBonus(ItemSetAbsolution, 4), 1.1, 1)",
                crit_multiplier = "priest.SpellCritMultiplier(1, float64(priest.Talents.ShadowPower)/5)",
                threat_multiplier = "1 - 0.08*float64(priest.Talents.ShadowAffinity)",
                class_token = "priest"
              },
              {
                class = "priest",
                spell_id = 48301,
                label = "Mind Blast",
                flags = "SpellFlagNoMetrics",
                spell_school = "SpellSchoolShadow",
                proc_mask = "ProcMaskProc",
                class_token = "priest"
              }
            }
          }
        },
        greater_heal = {
          id = 24,
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
              damage_multiplier = "1 * (1 + .02*float64(priest.Talents.SpiritualHealing)) * (1 + .01*float64(priest.Talents.BlessedResilience)) * (1 + .02*float64(priest.Talents.FocusedPower)) * core.TernaryFloat64(priest.HasSetBonus(ItemSetVestmentsOfAbsolution, 4), 1.05, 1)",
              crit_multiplier = "priest.DefaultHealingCritMultiplier()",
              threat_multiplier = "1 - []float64{0, .07, .14, .20}[priest.Talents.SilentResolve]",
              class_token = "priest"
            }
          }
        },
        holy_fire = {
          id = 25,
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
              crit_multiplier = "priest.DefaultSpellCritMultiplier()",
              threat_multiplier = "1 - []float64{0, .07, .14, .20}[priest.Talents.SilentResolve]",
              class_token = "priest"
            }
          }
        },
        make_penance = {
          id = 26,
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
                  raw = "time.Second*12-core.TernaryDuration(priest.HasMajorGlyph(proto.PriestMajorGlyph_GlyphOfPenance), time.Second*2, 0) * (1 - .1*priest.Talents.Aspiration)",
                  cases = {
                    {
                      condition = "priest.HasMajorGlyph(proto.PriestMajorGlyph_GlyphOfPenance)",
                      raw = "time.Duration(float64(time.Second*12-(time.Second*2)) * (1 - .1*float64(priest.Talents.Aspiration)))"
                    },
                    {
                      condition = "!(priest.HasMajorGlyph(proto.PriestMajorGlyph_GlyphOfPenance))",
                      raw = "time.Duration(float64(time.Second*12-(0)) * (1 - .1*float64(priest.Talents.Aspiration)))"
                    }
                  }
                },
                flags = "core.SpellFlagChanneled | core.SpellFlagAPL",
                spell_school = "SpellSchoolHoly",
                proc_mask = "core.ProcMaskSpellHealing",
                damage_multiplier = "1 + core.TernaryFloat64(isHeal, 1* (1+.02*float64(priest.Talents.SpiritualHealing))* (1+.01*float64(priest.Talents.BlessedResilience))* (1+.02*float64(priest.Talents.FocusedPower)), .05*float64(priest.Talents.SearingLight)) + .01*float64(priest.Talents.TwinDisciplines)",
                crit_multiplier = "core.TernaryFloat64(isHeal, priest.DefaultHealingCritMultiplier(), priest.DefaultSpellCritMultiplier())",
                threat_multiplier = "0",
                class_token = "priest"
              },
              {
                class = "priest",
                spell_id = 53007,
                label = "Penance",
                cooldown = {
                  raw = "time.Second*12-core.TernaryDuration(priest.HasMajorGlyph(proto.PriestMajorGlyph_GlyphOfPenance), time.Second*2, 0) * (1 - .1*priest.Talents.Aspiration)",
                  cases = {
                    {
                      condition = "priest.HasMajorGlyph(proto.PriestMajorGlyph_GlyphOfPenance)",
                      raw = "time.Duration(float64(time.Second*12-(time.Second*2)) * (1 - .1*float64(priest.Talents.Aspiration)))"
                    },
                    {
                      condition = "!(priest.HasMajorGlyph(proto.PriestMajorGlyph_GlyphOfPenance))",
                      raw = "time.Duration(float64(time.Second*12-(0)) * (1 - .1*float64(priest.Talents.Aspiration)))"
                    }
                  }
                },
                flags = "core.SpellFlagChanneled | core.SpellFlagAPL",
                spell_school = "SpellSchoolHoly",
                proc_mask = "core.ProcMaskSpellHealing",
                damage_multiplier = "1 + core.TernaryFloat64(isHeal, 1* (1+.02*float64(priest.Talents.SpiritualHealing))* (1+.01*float64(priest.Talents.BlessedResilience))* (1+.02*float64(priest.Talents.FocusedPower)), .05*float64(priest.Talents.SearingLight)) + .01*float64(priest.Talents.TwinDisciplines)",
                crit_multiplier = "core.TernaryFloat64(isHeal, priest.DefaultHealingCritMultiplier(), priest.DefaultSpellCritMultiplier())",
                threat_multiplier = "0",
                class_token = "priest"
              }
            }
          }
        },
        shadow_word_pain = {
          id = 27,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "priest",
              spell_id = 48125,
              label = "ShadowWordPain",
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1 + float64(priest.Talents.Darkness)*0.02 + float64(priest.Talents.TwinDisciplines)*0.01 + float64(priest.Talents.ImprovedShadowWordPain)*0.03",
              crit_multiplier = "priest.SpellCritMultiplier(1, 1)",
              threat_multiplier = "1 - 0.08*float64(priest.Talents.ShadowAffinity)",
              class_token = "priest"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "flash_heal",
        "get_mind_flay_tick",
        "get_pain_and_suffering",
        "initialize",
        "new_shadowfiend",
        "shadowfiend",
        "shadow_word_death",
        "devouring_plague",
        "power_word_shield",
        "renew",
        "smite",
        "binding_heal",
        "new_mind_sear",
        "get_mind_sear_tick",
        "make_prayer_of_mending",
        "prayer_of_mending",
        "crimson_acolytes_raiment2pc",
        "crimson_acolyte_raiment2pc",
        "sancitifcation_reglia4pc",
        "devious_mind",
        "prayer_of_healing",
        "mind_trauma",
        "mind_blast",
        "greater_heal",
        "holy_fire",
        "make_penance",
        "shadow_word_pain"
      },
      synthetic = true
    },
    WarlockSpells = {
      fields = {
        firebolt = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 47964,
              label = "Firebolt",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "(1 + 0.1*float64(wp.owner.Talents.ImprovedImp)) * (1 + 0.2*core.TernaryFloat64(wp.owner.HasMajorGlyph(proto.WarlockMajorGlyph_GlyphOfImp), 1, 0))",
              crit_multiplier = "2",
              threat_multiplier = "1",
              class_token = "warlock"
            }
          }
        },
        shadow_bite = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 54053,
              label = "Shadow Bite",
              cooldown = {
                raw = "time.Second * (6 - 2*wp.owner.Talents.ImprovedFelhunter)"
              },
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1 + 0.03*float64(wp.owner.Talents.ShadowMastery)",
              crit_multiplier = "1.5 + 0.1*float64(wp.owner.Talents.Ruin)",
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
              spell_id = 47992,
              label = "Lash Of Pain",
              cooldown = {
                raw = "time.Second * (12 - 3*wp.owner.Talents.DemonicPower)"
              },
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "1.5",
              threat_multiplier = "1",
              class_token = "warlock"
            }
          }
        },
        cleave = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 47994,
              label = "Cleave",
              cooldown = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              crit_multiplier = "2",
              threat_multiplier = "1",
              class_token = "warlock"
            }
          }
        },
        corruption = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 47813,
              label = "Corruption",
              flags = "core.SpellFlagHauntSE | core.SpellFlagAPL",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier_additive = "1 + warlock.GrandSpellstoneBonus() + 0.03*float64(warlock.Talents.ShadowMastery) + 0.01*float64(warlock.Talents.Contagion) + 0.02*float64(warlock.Talents.ImprovedCorruption) + core.TernaryFloat64(warlock.Talents.SiphonLife, 0.05, 0) + core.TernaryFloat64(warlock.HasSetBonus(ItemSetGuldansRegalia, 4), 0.1, 0)",
              crit_multiplier = "warlock.SpellCritMultiplier(1, 1)",
              threat_multiplier = "1 - 0.1*float64(warlock.Talents.ImprovedDrainSoul)",
              class_token = "warlock"
            }
          }
        },
        drain_soul = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 47855,
              label = "Drain Soul",
              flags = "core.SpellFlagChanneled | core.SpellFlagHauntSE | core.SpellFlagAPL",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              damage_multiplier_additive = "1 + warlock.GrandSpellstoneBonus() + 0.03*float64(warlock.Talents.ShadowMastery)",
              threat_multiplier = "1 - 0.1*float64(warlock.Talents.ImprovedDrainSoul)",
              class_token = "warlock"
            }
          }
        },
        new_warlock_pet = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "warlock",
                spell_id = 35706,
                label = "Master Demonologist",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "warlock"
              },
              {
                class = "warlock",
                spell_id = 35706,
                label = "Master Demonologist",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "warlock"
              },
              {
                class = "warlock",
                label = "Demonic Frenzy Hidden Aura",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "warlock"
              },
              {
                class = "warlock",
                spell_id = 32851,
                label = "Demonic Frenzy",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "warlock"
              }
            }
          }
        },
        soul_fire = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 47825,
              label = "Soul Fire",
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier_additive = "1 + warlock.GrandFirestoneBonus() + 0.03*float64(warlock.Talents.Emberstorm)",
              crit_multiplier = "warlock.SpellCritMultiplier(1, float64(warlock.Talents.Ruin)/5)",
              threat_multiplier = "1 - 0.1*float64(warlock.Talents.DestructiveReach)",
              class_token = "warlock"
            }
          }
        },
        life_tap = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 57946,
              label = "Life Tap",
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              threat_multiplier = "1",
              class_token = "warlock"
            }
          }
        },
        curse_of_doom = {
          id = 10,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 47867,
              label = "CurseofDoom",
              cooldown = {
                raw = "time.Minute",
                seconds = 60.0
              },
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier_additive = "1 + 0.03*float64(warlock.Talents.ShadowMastery)",
              threat_multiplier = "1 - 0.1*float64(warlock.Talents.ImprovedDrainSoul)",
              class_token = "warlock"
            }
          }
        },
        curse_of_agony = {
          id = 11,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 47864,
              label = "CurseofAgony",
              flags = "core.SpellFlagHauntSE | core.SpellFlagAPL",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier_additive = "1 + 0.03*float64(warlock.Talents.ShadowMastery) + 0.01*float64(warlock.Talents.Contagion) + 0.05*float64(warlock.Talents.ImprovedCurseOfAgony)",
              threat_multiplier = "1 - 0.1*float64(warlock.Talents.ImprovedDrainSoul)",
              class_token = "warlock"
            }
          }
        },
        curse_of_tongues = {
          id = 12,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 11719,
              label = "Curse Of Tongues",
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolShadow",
              proc_mask = "2",
              threat_multiplier = "1 - 0.1*float64(warlock.Talents.ImprovedDrainSoul)",
              class_token = "warlock"
            },
            aura = {
              class = "warlock",
              spell_id = 11719,
              label = "Curse of Tongues",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "warlock"
            }
          }
        },
        immolate = {
          id = 13,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 47811,
              label = "Immolate",
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier_additive = "1 + warlock.GrandFirestoneBonus() + 0.03*float64(warlock.Talents.Emberstorm) + 0.1*float64(warlock.Talents.ImprovedImmolate) + core.TernaryFloat64(warlock.HasSetBonus(ItemSetDeathbringerGarb, 2), 0.1, 0) + core.TernaryFloat64(warlock.HasSetBonus(ItemSetGuldansRegalia, 4), 0.1, 0)",
              crit_multiplier = "warlock.SpellCritMultiplier(1, float64(warlock.Talents.Ruin)/5)",
              threat_multiplier = "1 - 0.1*float64(warlock.Talents.DestructiveReach)",
              class_token = "warlock"
            }
          }
        },
        initialize = {
          id = 14,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 20153,
              label = "Immolation",
              spell_school = "SpellSchoolFire",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "warlock"
            }
          }
        },
        inferno = {
          id = 15,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 1122,
              label = "Inferno",
              cooldown = {
                raw = "time.Second * 600",
                seconds = 600.0
              },
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolFire",
              proc_mask = "2",
              damage_multiplier = "1",
              crit_multiplier = "warlock.SpellCritMultiplier(1, 0)",
              threat_multiplier = "1",
              class_token = "warlock"
            },
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
        shadow_burn = {
          id = 16,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 47827,
              label = "Shadow Burn",
              cooldown = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier_additive = "1 + warlock.GrandFirestoneBonus() + 0.03*float64(warlock.Talents.ShadowMastery)",
              crit_multiplier = "warlock.SpellCritMultiplier(1, float64(warlock.Talents.Ruin)/5)",
              threat_multiplier = "1 - 0.1*float64(warlock.Talents.DestructiveReach)",
              class_token = "warlock"
            }
          }
        },
        incinerate = {
          id = 17,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 47838,
              label = "Incinerate",
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier_additive = "1 + warlock.GrandFirestoneBonus() + 0.03*float64(warlock.Talents.Emberstorm) + core.TernaryFloat64(warlock.HasMajorGlyph(proto.WarlockMajorGlyph_GlyphOfIncinerate), 0.05, 0) + core.TernaryFloat64(warlock.HasSetBonus(ItemSetMaleficRaiment, 4), 0.06, 0)",
              crit_multiplier = "warlock.SpellCritMultiplier(1, float64(warlock.Talents.Ruin)/5)",
              threat_multiplier = "1 - 0.1*float64(warlock.Talents.DestructiveReach)",
              class_token = "warlock"
            }
          }
        },
        shadow_bolt = {
          id = 18,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 47809,
              label = "Shadow Bolt",
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier_additive = "1 + warlock.GrandFirestoneBonus() + 0.03*float64(warlock.Talents.ShadowMastery) + 0.02*float64(warlock.Talents.ImprovedShadowBolt) + core.TernaryFloat64(warlock.HasSetBonus(ItemSetMaleficRaiment, 4), 0.06, 0)",
              crit_multiplier = "warlock.SpellCritMultiplier(1, float64(warlock.Talents.Ruin)/5)",
              threat_multiplier = "1 - 0.1*float64(warlock.Talents.DestructiveReach)",
              class_token = "warlock"
            }
          }
        },
        ashtongue_talisman = {
          id = 19,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warlock",
              spell_id = 40478,
              label = "Ashtongue Talisman",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "warlock"
            }
          }
        },
        black_book = {
          id = 20,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 23720,
              label = "Black Book",
              cooldown = {
                raw = "5 * time.Minute",
                seconds = 300.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              spell_school = "SpellSchoolShadow",
              class_token = "warlock"
            }
          }
        },
        ["4p_t10_hidden"] = {
          id = 21,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warlock",
              label = "4pT10 Hidden Aura",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "warlock"
            }
          }
        },
        devious_minds = {
          id = 22,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "warlock",
                spell_id = 70840,
                label = "Devious Minds",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "warlock"
              },
              {
                class = "warlock",
                spell_id = 70840,
                label = "Devious Minds",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "warlock"
              }
            }
          }
        },
        ["4p_t7_hidden"] = {
          id = 23,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warlock",
              label = "4pT7 Hidden Aura",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "warlock"
            }
          }
        },
        spiritsofthe_damned = {
          id = 24,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warlock",
              spell_id = 61082,
              label = "Spirits of the Damned",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "warlock"
            }
          }
        },
        ["2p_t7_hidden"] = {
          id = 25,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warlock",
              label = "2pT7 Hidden Aura",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "warlock"
            }
          }
        },
        demonic_soul = {
          id = 26,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warlock",
              spell_id = 61595,
              label = "Demonic Soul",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "warlock"
            }
          }
        },
        searing_pain = {
          id = 27,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warlock",
              spell_id = 47815,
              label = "Searing Pain",
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier_additive = "1 + warlock.GrandFirestoneBonus() + 0.03*float64(warlock.Talents.Emberstorm)",
              crit_multiplier = "warlock.SpellCritMultiplier(1, float64(warlock.Talents.Ruin)/5+ core.TernaryFloat64(warlock.HasMajorGlyph(proto.WarlockMajorGlyph_GlyphOfSearingPain), 0.2, 0))",
              threat_multiplier = "1 - 0.1*float64(warlock.Talents.DestructiveReach)",
              class_token = "warlock"
            }
          }
        },
        seed = {
          id = 28,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "warlock",
                spell_id = 47836,
                label = "Seed",
                flags = "core.SpellFlagHauntSE | core.SpellFlagAPL",
                spell_school = "SpellSchoolShadow",
                proc_mask = "2",
                damage_multiplier_additive = "1 + warlock.GrandSpellstoneBonus() + 0.03*float64(warlock.Talents.ShadowMastery) + 0.01*float64(warlock.Talents.Contagion) + core.TernaryFloat64(warlock.Talents.SiphonLife, 0.05, 0)",
                threat_multiplier = "1 - 0.1*float64(warlock.Talents.ImprovedDrainSoul)",
                class_token = "warlock"
              },
              {
                class = "warlock",
                spell_id = 47836,
                label = "Seed",
                flags = "core.SpellFlagHauntSE | core.SpellFlagNoLogs",
                spell_school = "SpellSchoolShadow",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier_additive = "1 + warlock.GrandFirestoneBonus() + 0.03*float64(warlock.Talents.ShadowMastery) + 0.01*float64(warlock.Talents.Contagion)",
                crit_multiplier = "warlock.DefaultSpellCritMultiplier()",
                threat_multiplier = "1 - 0.1*float64(warlock.Talents.ImprovedDrainSoul)",
                class_token = "warlock"
              }
            }
          }
        },
        up_demonic_pact = {
          id = 29,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warlock",
              label = "Demonic Pact Hidden Aura",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "warlock"
            }
          }
        },
        up_improved_soul_leech = {
          id = 30,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warlock",
              spell_id = 54118,
              label = "Improved Soul Leech Hidden Aura",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "warlock"
            }
          }
        },
        up_backdraft = {
          id = 31,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "warlock",
                label = "Backdraft Hidden Aura",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "warlock"
              },
              {
                class = "warlock",
                spell_id = 54277,
                label = "Backdraft Proc Aura",
                duration = {
                  raw = "time.Second * 15",
                  seconds = 15.0
                },
                class_token = "warlock"
              }
            }
          }
        },
        up_molten_core = {
          id = 32,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "warlock",
                label = "Molten Core Hidden Aura",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "warlock"
              },
              {
                class = "warlock",
                spell_id = 71165,
                label = "Molten Core Proc Aura",
                duration = {
                  raw = "time.Second * 15",
                  seconds = 15.0
                },
                class_token = "warlock"
              }
            }
          }
        },
        up_nightfall = {
          id = 33,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "warlock",
                label = "Nightfall Hidden Aura",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
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
        up_shadow_embrace = {
          id = 34,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warlock",
              label = "Shadow Embrace Talent Hidden Aura",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "warlock"
            }
          }
        },
        shadow_embrace_debuff = {
          id = 35,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warlock",
              spell_id = 32391,
              label = "Shadow Embrace",
              duration = {
                raw = "time.Second * 12",
                seconds = 12.0
              },
              class_token = "warlock"
            }
          }
        },
        up_eradication = {
          id = 36,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "warlock",
                label = "Eradication Talent Hidden Aura",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "warlock"
              },
              {
                class = "warlock",
                spell_id = 64371,
                label = "Eradication",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "warlock"
              }
            }
          }
        },
        up_pyroclasm = {
          id = 37,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "warlock",
                label = "Pyroclasm Talent Hidden Aura",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "warlock"
              },
              {
                class = "warlock",
                spell_id = 63244,
                label = "Pyroclasm",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "warlock"
              }
            }
          }
        },
        up_decimation = {
          id = 38,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "warlock",
                label = "Decimation Talent Hidden Aura",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "warlock"
              },
              {
                class = "warlock",
                spell_id = 63167,
                label = "Decimation Proc Aura",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "warlock"
              }
            }
          }
        },
        up_empowered_imp = {
          id = 39,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "warlock",
                label = "Empowered Imp Hidden Aura",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "warlock"
              },
              {
                class = "warlock",
                spell_id = 47283,
                label = "Empowered Imp Proc Aura",
                duration = {
                  raw = "time.Second * 8",
                  seconds = 8.0
                },
                class_token = "warlock"
              }
            }
          }
        },
        up_glyph_of_life_tap = {
          id = 40,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "warlock",
              spell_id = 63321,
              label = "Glyph Of LifeTap Aura",
              duration = {
                raw = "time.Second * 40",
                seconds = 40.0
              },
              class_token = "warlock"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "firebolt",
        "shadow_bite",
        "lash_of_pain",
        "cleave",
        "corruption",
        "drain_soul",
        "new_warlock_pet",
        "soul_fire",
        "life_tap",
        "curse_of_doom",
        "curse_of_agony",
        "curse_of_tongues",
        "immolate",
        "initialize",
        "inferno",
        "shadow_burn",
        "incinerate",
        "shadow_bolt",
        "ashtongue_talisman",
        "black_book",
        "4p_t10_hidden",
        "devious_minds",
        "4p_t7_hidden",
        "spiritsofthe_damned",
        "2p_t7_hidden",
        "demonic_soul",
        "searing_pain",
        "seed",
        "up_demonic_pact",
        "up_improved_soul_leech",
        "up_backdraft",
        "up_molten_core",
        "up_nightfall",
        "up_shadow_embrace",
        "shadow_embrace_debuff",
        "up_eradication",
        "up_pyroclasm",
        "up_decimation",
        "up_empowered_imp",
        "up_glyph_of_life_tap"
      },
      synthetic = true
    },
    PaladinSpells = {
      fields = {
        shield_of_righteousness = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "paladin",
              spell_id = 61411,
              label = "Shield Of Righteousness",
              cooldown = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              crit_multiplier = "paladin.MeleeCritMultiplier()",
              threat_multiplier = "1",
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
              spell_id = 48806,
              label = "Hammer Of Wrath",
              cooldown = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              damage_multiplier_additive = "1 + paladin.getItemSetLightbringerBattlegearBonus4() + paladin.getItemSetAegisBattlegearBonus2()",
              crit_multiplier = "paladin.MeleeCritMultiplier()",
              threat_multiplier = "1",
              class_token = "paladin"
            }
          }
        },
        consecration = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "paladin",
              spell_id = 48819,
              label = "Consecration",
              cooldown = {
                raw = "(time.Second * 8) + core.TernaryDuration(paladin.HasMajorGlyph(proto.PaladinMajorGlyph_GlyphOfConsecration), time.Second*2, 0)",
                cases = {
                  {
                    condition = "paladin.HasMajorGlyph(proto.PaladinMajorGlyph_GlyphOfConsecration)",
                    raw = "(time.Second * 8) + (time.Second*2)",
                    seconds = 10.0
                  },
                  {
                    condition = "!(paladin.HasMajorGlyph(proto.PaladinMajorGlyph_GlyphOfConsecration))",
                    raw = "(time.Second * 8) + (0)",
                    seconds = 8.0
                  }
                }
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
        divine_plea = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "paladin",
              spell_id = 54428,
              label = "Divine Plea",
              cooldown = {
                raw = "time.Minute * 1",
                seconds = 60.0
              },
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolHoly",
              class_token = "paladin"
            },
            aura = {
              class = "paladin",
              spell_id = 54428,
              label = "Divine Plea",
              duration = {
                raw = "time.Second*15 + 1",
                seconds = 16.0
              },
              class_token = "paladin"
            }
          }
        },
        activate_righteous_fury = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "paladin",
              spell_id = 25780,
              label = "Righteous Fury",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
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
              spell_id = 48817,
              label = "Holy Wrath",
              cooldown = {
                raw = "time.Second*30 - core.TernaryDuration(paladin.HasMajorGlyph(proto.PaladinMajorGlyph_GlyphOfHolyWrath), time.Second*15, 0)",
                cases = {
                  {
                    condition = "paladin.HasMajorGlyph(proto.PaladinMajorGlyph_GlyphOfHolyWrath)",
                    raw = "time.Second*30 - (time.Second*15)",
                    seconds = 15.0
                  },
                  {
                    condition = "!(paladin.HasMajorGlyph(proto.PaladinMajorGlyph_GlyphOfHolyWrath))",
                    raw = "time.Second*30 - (0)",
                    seconds = 30.0
                  }
                }
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "paladin.SpellCritMultiplier()",
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
              spell_id = 48801,
              label = "Exorcism",
              cooldown = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              damage_multiplier_additive = "1 + paladin.getTalentSanctityOfBattleBonus() + paladin.getMajorGlyphOfExorcismBonus() + paladin.getItemSetAegisBattlegearBonus2()",
              crit_multiplier = "paladin.SpellCritMultiplier()",
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
              spell_id = 31884,
              label = "Avenging Wrath",
              cooldown = {
                raw = "time.Minute*3 - (time.Second * 30*paladin.Talents.SanctifiedWrath)"
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
              class_token = "paladin"
            },
            aura = {
              class = "paladin",
              spell_id = 31884,
              label = "Avenging Wrath",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "paladin"
            }
          }
        },
        seal_of_command_spell_and = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "paladin",
                spell_id = 20375,
                label = "Seal Of Command Spell And",
                flags = "SpellFlagAPL",
                spell_school = "SpellSchoolHoly",
                proc_mask = "2",
                threat_multiplier = "1",
                class_token = "paladin"
              },
              {
                class = "paladin",
                spell_id = 20424,
                label = "Seal Of Command Spell And",
                flags = "SpellFlagMeleeMetrics",
                spell_school = "SpellSchoolHoly",
                proc_mask = "2",
                damage_multiplier = "1 * (1 + paladin.getItemSetLightswornBattlegearBonus4()) * (1 + paladin.getTalentTwoHandedWeaponSpecializationBonus()) * 0.36",
                crit_multiplier = "paladin.MeleeCritMultiplier()",
                threat_multiplier = "1",
                class_token = "paladin"
              },
              {
                class = "paladin",
                spell_id = 20424,
                label = "Seal Of Command Spell And",
                flags = "SpellFlagMeleeMetrics",
                spell_school = "SpellSchoolHoly",
                proc_mask = "2",
                damage_multiplier = "1 * (1 + paladin.getItemSetLightswornBattlegearBonus4()) * (1 + paladin.getTalentTwoHandedWeaponSpecializationBonus()) * 0.36",
                crit_multiplier = "paladin.MeleeCritMultiplier()",
                threat_multiplier = "1",
                class_token = "paladin"
              },
              {
                class = "paladin",
                spell_id = 20467,
                label = "Seal Of Command Spell And",
                flags = "core.SpellFlagMeleeMetrics | SpellFlagSecondaryJudgement",
                spell_school = "SpellSchoolHoly",
                proc_mask = "ProcMaskMeleeMHSpecial | ProcMaskMeleeOHSpecial",
                damage_multiplier = "1 * (1 + paladin.getItemSetLightswornBattlegearBonus4() + paladin.getMajorGlyphOfJudgementBonus() + paladin.getTalentTheArtOfWarBonus()) * (1 + paladin.getTalentTwoHandedWeaponSpecializationBonus())",
                crit_multiplier = "paladin.MeleeCritMultiplier()",
                threat_multiplier = "1",
                class_token = "paladin"
              }
            },
            aura = {
              class = "paladin",
              spell_id = 20375,
              label = "Seal of Command",
              tag = "Seal",
              duration = {
                raw = "time.Minute * 30",
                seconds = 1800.0
              },
              class_token = "paladin"
            }
          }
        },
        forbearance_de = {
          id = 10,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "paladin",
              spell_id = 25771,
              label = "Forbearance",
              duration = {
                cases = {
                  {
                    condition = "paladin.HasSetBonus(ItemSetTuralyonsPlate, 4)",
                    raw = "(90*time.Second)",
                    seconds = 90.0
                  },
                  {
                    condition = "!(paladin.HasSetBonus(ItemSetTuralyonsPlate, 4))",
                    raw = "(120*time.Second)",
                    seconds = 120.0
                  }
                },
                raw = "core.TernaryDuration(paladin.HasSetBonus(ItemSetTuralyonsPlate, 4), 90*time.Second, 120*time.Second)"
              },
              duration_raw = "duration",
              class_token = "paladin"
            }
          }
        },
        divine_protection = {
          id = 11,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "paladin",
              spell_id = 498,
              label = "Divine Protection",
              cooldown = {
                raw = [[time.Minute*3 -
		30*time.Second*paladin.Talents.SacredDuty -
		core.TernaryDuration(paladin.HasSetBonus(ItemSetTuralyonsPlate, 4), 30*time.Second, 0)]],
                cases = {
                  {
                    condition = "paladin.HasSetBonus(ItemSetTuralyonsPlate, 4)",
                    raw = [[time.Minute*3 -
		30*time.Second*time.Duration(paladin.Talents.SacredDuty) -
		(30*time.Second)]]
                  },
                  {
                    condition = "!(paladin.HasSetBonus(ItemSetTuralyonsPlate, 4))",
                    raw = [[time.Minute*3 -
		30*time.Second*time.Duration(paladin.Talents.SacredDuty) -
		(0)]]
                  }
                }
              },
              major_cooldown = {
                type = "core.CooldownTypeSurvival"
              },
              flags = "SpellFlagAPL",
              class_token = "paladin"
            },
            aura = {
              class = "paladin",
              spell_id = 498,
              label = "Divine Protection",
              duration = {
                cases = {
                  {
                    condition = "paladin.HasSetBonus(ItemSetRedemptionPlate, 4)",
                    raw = "time.Second*12 + (time.Second*3)",
                    seconds = 15.0
                  },
                  {
                    condition = "!(paladin.HasSetBonus(ItemSetRedemptionPlate, 4))",
                    raw = "time.Second*12 + (0)",
                    seconds = 12.0
                  }
                },
                raw = "time.Second*12 + core.TernaryDuration(paladin.HasSetBonus(ItemSetRedemptionPlate, 4), time.Second*3, 0)"
              },
              duration_raw = "duration",
              class_token = "paladin"
            }
          }
        },
        ashtongue_talismanof_zeal = {
          id = 12,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "paladin",
              label = "Ashtongue Talisman of Zeal",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "paladin"
            }
          }
        },
        ashtongue_talisman_of_zeal = {
          id = 13,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "paladin",
              label = "AshtongueTalismanOfZeal",
              spell_school = "SpellSchoolHoly",
              proc_mask = "2",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "paladin"
            }
          }
        },
        libramofthe_sacred_shield = {
          id = 14,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "paladin",
              spell_id = 65182,
              label = "Libram of the Sacred Shield",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "paladin"
            }
          }
        },
        libramof_obstruction = {
          id = 15,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "paladin",
              spell_id = 60794,
              label = "Libram of Obstruction",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "paladin"
            }
          }
        },
        tomeofthe_lightbringer = {
          id = 16,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "paladin",
              spell_id = 41042,
              label = "Tome of the Lightbringer",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "paladin"
            }
          }
        },
        libram_of_valiance = {
          id = 17,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "paladin",
              spell_id = 67365,
              label = "Libram Of Valiance",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "paladin"
            }
          }
        },
        libram_of_three_truths = {
          id = 18,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "paladin",
              label = "Libram Of Three Truths",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "paladin"
            }
          }
        },
        wrathful_gladiators_libramof_fortitude = {
          id = 19,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "paladin",
              spell_id = 60636,
              label = "Wrathful Gladiator's Libram of Fortitude",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "paladin"
            }
          }
        },
        relentless_gladiators_libramof_fortitude = {
          id = 20,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "paladin",
              spell_id = 60635,
              label = "Relentless Gladiator's Libram of Fortitude",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "paladin"
            }
          }
        },
        furious_gladiators_libramof_fortitude = {
          id = 21,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "paladin",
              spell_id = 60634,
              label = "Furious Gladiator's Libram of Fortitude",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "paladin"
            }
          }
        },
        deadly_gladiators_libramof_fortitude = {
          id = 22,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "paladin",
              spell_id = 60633,
              label = "Deadly Gladiator's Libram of Fortitude",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "paladin"
            }
          }
        },
        savage_gladiators_libramof_fortitude = {
          id = 23,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "paladin",
                spell_id = 60632,
                label = "Savage Gladiator's Libram of Fortitude",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "paladin"
              },
              {
                class = "paladin",
                spell_id = 60577,
                label = "Savage Gladiator's Libram of Fortitude",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "paladin"
              }
            }
          }
        },
        libramof_reciprocation = {
          id = 24,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "paladin",
              spell_id = 60819,
              label = "Libram of Reciprocation",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "paladin"
            }
          }
        },
        libramof_furious_blows = {
          id = 25,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "paladin",
              spell_id = 48835,
              label = "Libram of Furious Blows",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "paladin"
            }
          }
        },
        lightsworn_battlegear2pc = {
          id = 26,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "paladin",
              label = "Lightsworn Battlegear 2pc",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "paladin"
            }
          }
        },
        proc = {
          id = 27,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "paladin",
              spell_id = 70765,
              label = "Proc",
              class_token = "paladin"
            }
          }
        },
        lightbringer_battlegear2pc = {
          id = 28,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "paladin",
              label = "Lightbringer Battlegear 2pc",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "paladin"
            }
          }
        },
        seal_of_righteousness_spell_and = {
          id = 29,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "paladin",
                spell_id = 21084,
                label = "Seal Of Righteousness Spell And",
                flags = "SpellFlagAPL",
                spell_school = "SpellSchoolHoly",
                class_token = "paladin"
              },
              {
                class = "paladin",
                spell_id = 20154,
                label = "Seal Of Righteousness Spell And",
                flags = "SpellFlagMeleeMetrics",
                spell_school = "SpellSchoolHoly",
                proc_mask = "2",
                damage_multiplier = "1 * (1 + paladin.getItemSetLightswornBattlegearBonus4() + paladin.getItemSetAegisPlateBonus2() + paladin.getTalentSealsOfThePureBonus()) * (1 + paladin.getMajorGlyphSealOfRighteousnessBonus()) * (1 + paladin.getTalentTwoHandedWeaponSpecializationBonus())",
                threat_multiplier = "1",
                class_token = "paladin"
              },
              {
                class = "paladin",
                spell_id = 20187,
                label = "Seal Of Righteousness Spell And",
                flags = "core.SpellFlagMeleeMetrics | SpellFlagSecondaryJudgement",
                spell_school = "SpellSchoolHoly",
                proc_mask = "ProcMaskMeleeMHSpecial | ProcMaskMeleeOHSpecial",
                damage_multiplier = "1 * (1 + paladin.getItemSetLightswornBattlegearBonus4() + paladin.getTalentSealsOfThePureBonus() + paladin.getMajorGlyphOfJudgementBonus() + paladin.getTalentTheArtOfWarBonus()) * (1 + paladin.getTalentTwoHandedWeaponSpecializationBonus())",
                crit_multiplier = "paladin.MeleeCritMultiplier()",
                threat_multiplier = "1",
                class_token = "paladin"
              }
            },
            aura = {
              class = "paladin",
              spell_id = 21084,
              label = "Seal of Righteousness",
              tag = "Seal",
              duration = {
                raw = "time.Minute * 30",
                seconds = 1800.0
              },
              class_token = "paladin"
            }
          }
        },
        hand_of_reckoning = {
          id = 30,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "paladin",
              spell_id = 67485,
              label = "Hand Of Reckoning",
              cooldown = {
                raw = "time.Second * core.TernaryInt(paladin.HasSetBonus(ItemSetTuralyonsPlate, 2), 6, 8)",
                cases = {
                  {
                    condition = "paladin.HasSetBonus(ItemSetTuralyonsPlate, 2)",
                    raw = "time.Second * time.Duration((6))",
                    seconds = 6.0
                  },
                  {
                    condition = "!(paladin.HasSetBonus(ItemSetTuralyonsPlate, 2))",
                    raw = "time.Second * time.Duration((8))",
                    seconds = 8.0
                  }
                }
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              damage_multiplier_additive = "1",
              crit_multiplier = "paladin.SpellCritMultiplier()",
              threat_multiplier = "1",
              class_token = "paladin"
            }
          }
        },
        seal_of_vengeance_spell_and = {
          id = 31,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "paladin",
                spell_id = 31801,
                label = "Seal Of Vengeance Spell And",
                flags = "SpellFlagAPL",
                spell_school = "SpellSchoolHoly",
                class_token = "paladin"
              },
              {
                class = "paladin",
                spell_id = 42463,
                label = "Seal Of Vengeance Spell And",
                flags = "SpellFlagMeleeMetrics",
                spell_school = "SpellSchoolHoly",
                proc_mask = "ProcMaskProc",
                damage_multiplier = "1 * (1 + paladin.getItemSetLightswornBattlegearBonus4() + paladin.getItemSetAegisPlateBonus2() + paladin.getTalentSealsOfThePureBonus()) * (1 + paladin.getTalentTwoHandedWeaponSpecializationBonus()) * .33 / 5",
                crit_multiplier = "paladin.MeleeCritMultiplier()",
                threat_multiplier = "1",
                class_token = "paladin"
              },
              {
                class = "paladin",
                spell_id = 31804,
                label = "Seal Of Vengeance Spell And",
                flags = "core.SpellFlagMeleeMetrics | SpellFlagSecondaryJudgement",
                spell_school = "SpellSchoolHoly",
                proc_mask = "ProcMaskMeleeMHSpecial | ProcMaskMeleeOHSpecial",
                damage_multiplier = "1 * (1 + paladin.getItemSetLightswornBattlegearBonus4() + paladin.getTalentSealsOfThePureBonus() + paladin.getMajorGlyphOfJudgementBonus() + paladin.getTalentTheArtOfWarBonus()) * (1 + paladin.getTalentTwoHandedWeaponSpecializationBonus())",
                crit_multiplier = "paladin.MeleeCritMultiplier()",
                threat_multiplier = "1",
                class_token = "paladin"
              },
              {
                class = "paladin",
                spell_id = 31803,
                label = "Seal Of Vengeance Spell And",
                spell_school = "SpellSchoolHoly",
                proc_mask = "ProcMaskProc",
                damage_multiplier = "1 * (1 + paladin.getItemSetLightswornBattlegearBonus4() + paladin.getItemSetAegisPlateBonus2() + paladin.getTalentSealsOfThePureBonus())",
                threat_multiplier = "1",
                class_token = "paladin"
              },
              {
                class = "paladin",
                spell_id = 31803,
                label = "Holy Vengeance (DoT)",
                flags = "SpellFlagMeleeMetrics",
                spell_school = "SpellSchoolHoly",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1 * (1 + paladin.getItemSetLightswornBattlegearBonus4() + paladin.getItemSetAegisPlateBonus2() + paladin.getTalentSealsOfThePureBonus())",
                threat_multiplier = "1",
                class_token = "paladin"
              }
            },
            aura = {
              class = "paladin",
              spell_id = 31801,
              label = "Seal of Vengeance",
              tag = "Seal",
              duration = {
                raw = "time.Minute * 30",
                seconds = 1800.0
              },
              class_token = "paladin"
            }
          }
        },
        art_of_war = {
          id = 32,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "paladin",
                label = "The Art of War",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "paladin"
              },
              {
                class = "paladin",
                spell_id = 53488,
                label = "Art Of War",
                duration = {
                  raw = "time.Second * 15",
                  seconds = 15.0
                },
                class_token = "paladin"
              }
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "shield_of_righteousness",
        "hammer_of_wrath",
        "consecration",
        "divine_plea",
        "activate_righteous_fury",
        "holy_wrath",
        "exorcism",
        "avenging_wrath",
        "seal_of_command_spell_and",
        "forbearance_de",
        "divine_protection",
        "ashtongue_talismanof_zeal",
        "ashtongue_talisman_of_zeal",
        "libramofthe_sacred_shield",
        "libramof_obstruction",
        "tomeofthe_lightbringer",
        "libram_of_valiance",
        "libram_of_three_truths",
        "wrathful_gladiators_libramof_fortitude",
        "relentless_gladiators_libramof_fortitude",
        "furious_gladiators_libramof_fortitude",
        "deadly_gladiators_libramof_fortitude",
        "savage_gladiators_libramof_fortitude",
        "libramof_reciprocation",
        "libramof_furious_blows",
        "lightsworn_battlegear2pc",
        "proc",
        "lightbringer_battlegear2pc",
        "seal_of_righteousness_spell_and",
        "hand_of_reckoning",
        "seal_of_vengeance_spell_and",
        "art_of_war"
      },
      synthetic = true
    },
    MageSpells = {
      fields = {
        fireblast = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 59637,
              label = "Fireblast",
              cooldown = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              spell_school = "SpellSchoolFrost",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "mi.DefaultSpellCritMultiplier()",
              threat_multiplier = "1",
              class_token = "mage"
            }
          }
        },
        frostbolt = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "mage",
                spell_id = 59638,
                label = "Frostbolt",
                spell_school = "SpellSchoolFrost",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "mi.DefaultSpellCritMultiplier()",
                threat_multiplier = "1",
                class_token = "mage"
              },
              {
                class = "mage",
                spell_id = 42842,
                label = "Frostbolt",
                flags = "SpellFlagMage | BarrageSpells | core.SpellFlagAPL",
                spell_school = "SpellSchoolFrost",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier_additive = "1 + .01*float64(mage.Talents.ChilledToTheBone) + core.TernaryFloat64(mage.HasMajorGlyph(proto.MageMajorGlyph_GlyphOfFrostbolt), .05, 0) + core.TernaryFloat64(mage.HasSetBonus(ItemSetTempestRegalia, 4), .05, 0)",
                crit_multiplier = "mage.SpellCritMultiplier(1, mage.bonusCritDamage+float64(mage.Talents.IceShards)/3)",
                threat_multiplier = "1 - (0.1/3)*float64(mage.Talents.FrostChanneling)",
                class_token = "mage"
              }
            }
          }
        },
        mirror_image = {
          id = 3,
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
                type = "core.CooldownTypeDPS",
                priority = "core.CooldownPriorityDrums + 1000"
              },
              flags = "SpellFlagAPL",
              class_token = "mage"
            },
            aura = {
              class = "mage",
              spell_id = 70748,
              label = "Mirror Image Bonus Damage T10 4PC",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "mage"
            }
          }
        },
        arcane_blast = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 42897,
              label = "Arcane Blast",
              flags = "SpellFlagMage | BarrageSpells | core.SpellFlagAPL",
              spell_school = "SpellSchoolArcane",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1 * (1 + .04*float64(mage.Talents.TormentTheWeak))",
              damage_multiplier_additive = "1 + .02*float64(mage.Talents.SpellImpact)",
              crit_multiplier = "mage.SpellCritMultiplier(1, mage.bonusCritDamage)",
              threat_multiplier = "1 - 0.2*float64(mage.Talents.ArcaneSubtlety)",
              class_token = "mage"
            },
            aura = {
              class = "mage",
              spell_id = 36032,
              label = "Arcane Blast",
              duration = {
                raw = "time.Second * 8",
                seconds = 8.0
              },
              class_token = "mage"
            }
          }
        },
        frostfire_bolt = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 47610,
              label = "FrostfireBolt",
              flags = "SpellFlagMage | BarrageSpells | HotStreakSpells | core.SpellFlagAPL",
              spell_school = "core.SpellSchoolFire | core.SpellSchoolFrost",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1 * // Need to re-apply these frost talents because FFB only inherits the fire multipliers from core. (1 + .02*float64(mage.Talents.PiercingIce)) * (1 + .01*float64(mage.Talents.ArcticWinds)) * (1 + .04*float64(mage.Talents.TormentTheWeak))",
              damage_multiplier_additive = "1 + .02*float64(mage.Talents.FirePower) + .01*float64(mage.Talents.ChilledToTheBone) + core.TernaryFloat64(mage.HasMajorGlyph(proto.MageMajorGlyph_GlyphOfFrostfire), .02, 0)",
              crit_multiplier = "mage.SpellCritMultiplier(1, mage.bonusCritDamage+float64(mage.Talents.IceShards)/3)",
              threat_multiplier = "1 - 0.1*float64(mage.Talents.BurningSoul) - .04*float64(mage.Talents.FrostChanneling)",
              class_token = "mage"
            }
          }
        },
        scorch = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 42859,
              label = "Scorch",
              flags = "SpellFlagMage | HotStreakSpells | core.SpellFlagAPL",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier_additive = "1 + .02*float64(mage.Talents.SpellImpact) + .02*float64(mage.Talents.FirePower) + core.TernaryFloat64(mage.HasMajorGlyph(proto.MageMajorGlyph_GlyphOfScorch), 0.2, 0)",
              crit_multiplier = "mage.SpellCritMultiplier(1, mage.bonusCritDamage)",
              threat_multiplier = "1 - 0.1*float64(mage.Talents.BurningSoul)",
              class_token = "mage"
            }
          }
        },
        arcane_missiles = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "mage",
                spell_id = 42846,
                label = "ArcaneMissiles",
                flags = "SpellFlagMage | core.SpellFlagChanneled | core.SpellFlagAPL",
                spell_school = "SpellSchoolArcane",
                proc_mask = "ProcMaskSpellDamage",
                class_token = "mage"
              },
              {
                class = "mage",
                spell_id = 42845,
                label = "Arcane Missiles",
                flags = "SpellFlagMage | core.SpellFlagNoLogs",
                spell_school = "SpellSchoolArcane",
                proc_mask = "core.ProcMaskSpellDamage | core.ProcMaskNotInSpellbook",
                damage_multiplier = "1 + .04*float64(mage.Talents.TormentTheWeak)",
                damage_multiplier_additive = "1 + core.TernaryFloat64(mage.HasSetBonus(ItemSetTempestRegalia, 4), .05, 0)",
                crit_multiplier = "mage.SpellCritMultiplier(1, mage.bonusCritDamage+core.TernaryFloat64(mage.HasMajorGlyph(proto.MageMajorGlyph_GlyphOfArcaneMissiles), .25, 0))",
                threat_multiplier = "1 - 0.2*float64(mage.Talents.ArcaneSubtlety)",
                class_token = "mage"
              }
            }
          }
        },
        blizzard = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "mage",
                spell_id = 42940,
                label = "Blizzard",
                flags = "SpellFlagMage | core.SpellFlagChanneled | core.SpellFlagAPL",
                spell_school = "SpellSchoolFrost",
                proc_mask = "ProcMaskSpellDamage",
                class_token = "mage"
              },
              {
                class = "mage",
                spell_id = 42938,
                label = "Blizzard",
                flags = "core.SpellFlagAgentReserved1",
                spell_school = "SpellSchoolFrost",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "mage.SpellCritMultiplier(1, mage.bonusCritDamage+float64(mage.Talents.IceShards)/3)",
                threat_multiplier = "1 - (0.1/3)*float64(mage.Talents.FrostChanneling)",
                class_token = "mage"
              },
              {
                class = "mage",
                spell_id = 12488,
                label = "Blizzard",
                flags = "SpellFlagMage | core.SpellFlagNoLogs",
                proc_mask = "ProcMaskProc",
                class_token = "mage"
              }
            },
            aura = {
              class = "mage",
              spell_id = 12488,
              label = "Improved Blizzard",
              duration = {
                raw = "time.Millisecond * 1500",
                seconds = 1.5
              },
              class_token = "mage"
            }
          }
        },
        flamestrike = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 42926,
              label = "Flamestrike (Rank 9)",
              flags = "SpellFlagMage | core.SpellFlagAPL",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier_additive = "1 + .02*float64(mage.Talents.SpellImpact) + .02*float64(mage.Talents.FirePower)",
              crit_multiplier = "mage.SpellCritMultiplier(1, mage.bonusCritDamage)",
              threat_multiplier = "1 - 0.05*float64(mage.Talents.BurningSoul)",
              class_token = "mage"
            }
          }
        },
        bloodmages_regalia2pc = {
          id = 10,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "mage",
              spell_id = 70752,
              label = "Spec Based Haste T10 2PC",
              duration = {
                raw = "time.Second * 5",
                seconds = 5.0
              },
              class_token = "mage"
            }
          }
        },
        fireball = {
          id = 11,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 42833,
              label = "Fireball",
              flags = "SpellFlagMage | BarrageSpells | HotStreakSpells | core.SpellFlagAPL",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1 * (1 + .04*float64(mage.Talents.TormentTheWeak))",
              damage_multiplier_additive = "1 + .02*float64(mage.Talents.SpellImpact) + .02*float64(mage.Talents.FirePower) + core.TernaryFloat64(mage.HasSetBonus(ItemSetTempestRegalia, 4), .05, 0)",
              crit_multiplier = "mage.SpellCritMultiplier(1, mage.bonusCritDamage)",
              threat_multiplier = "1 - 0.1*float64(mage.Talents.BurningSoul)",
              class_token = "mage"
            }
          }
        },
        evocation = {
          id = 12,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 12051,
              label = "Evocation",
              cooldown = {
                raw = "time.Minute * 4-mage.Talents.ArcaneFlows"
              },
              major_cooldown = {
                type = "core.CooldownTypeMana"
              },
              flags = "core.SpellFlagHelpful | core.SpellFlagChanneled | core.SpellFlagAPL",
              class_token = "mage"
            }
          }
        },
        ice_lance = {
          id = 13,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 42914,
              label = "Ice Lance",
              flags = "SpellFlagMage | core.SpellFlagAPL",
              spell_school = "SpellSchoolFrost",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier_additive = "1 + .01*float64(mage.Talents.ChilledToTheBone)",
              crit_multiplier = "mage.SpellCritMultiplier(1, mage.bonusCritDamage+float64(mage.Talents.IceShards)/3)",
              threat_multiplier = "1 - (0.1/3)*float64(mage.Talents.FrostChanneling)",
              class_token = "mage"
            }
          }
        },
        arcane_explosion = {
          id = 14,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 42921,
              label = "Arcane Explosion",
              flags = "SpellFlagMage | core.SpellFlagAPL",
              spell_school = "SpellSchoolArcane",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "mage.SpellCritMultiplier(1, mage.bonusCritDamage)",
              threat_multiplier = "1 - 0.2*float64(mage.Talents.ArcaneSubtlety)",
              class_token = "mage"
            }
          }
        },
        waterbolt = {
          id = 15,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 31707,
              label = "Waterbolt",
              spell_school = "SpellSchoolFrost",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "we.DefaultSpellCritMultiplier()",
              threat_multiplier = "1",
              class_token = "mage"
            }
          }
        },
        mana_gems = {
          id = 16,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 61062,
              label = "Mana Gems",
              cooldown = {
                raw = "time.Minute * 2",
                seconds = 120.0
              },
              major_cooldown = {
                type = "core.CooldownTypeMana",
                priority = "core.CooldownPriorityDefault"
              },
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
              class_token = "mage"
            }
          }
        },
        fire_starter = {
          id = 17,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "mage",
                label = "Firestarter talent",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "mage"
              },
              {
                class = "mage",
                spell_id = 54741,
                label = "Firestarter",
                duration = {
                  raw = "10 * time.Second",
                  seconds = 10.0
                },
                class_token = "mage"
              }
            }
          }
        },
        fire_blast = {
          id = 18,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "mage",
              spell_id = 42873,
              label = "Fire Blast",
              cooldown = {
                raw = "time.Second*8 - time.Second*mage.Talents.ImprovedFireBlast"
              },
              flags = "SpellFlagMage | HotStreakSpells | core.SpellFlagAPL",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier_additive = "1 + .02*float64(mage.Talents.SpellImpact) + .02*float64(mage.Talents.FirePower)",
              crit_multiplier = "mage.SpellCritMultiplier(1, mage.bonusCritDamage)",
              threat_multiplier = "1 - 0.1*float64(mage.Talents.BurningSoul)",
              class_token = "mage"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "fireblast",
        "frostbolt",
        "mirror_image",
        "arcane_blast",
        "frostfire_bolt",
        "scorch",
        "arcane_missiles",
        "blizzard",
        "flamestrike",
        "bloodmages_regalia2pc",
        "fireball",
        "evocation",
        "ice_lance",
        "arcane_explosion",
        "waterbolt",
        "mana_gems",
        "fire_starter",
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
                raw = "warrior.intensifyRageCooldown(time.Second * 30)"
              },
              flags = "SpellFlagAPL",
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
                spell_id = 58398,
                label = "Glyph of Revenge",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "warrior"
              },
              {
                class = "warrior",
                spell_id = 57823,
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
                raw = [[time.Minute*5 -
		30*time.Second*warrior.Talents.ImprovedDisciplines -
		core.TernaryDuration(hasGlyph, 2*time.Minute, 0)]],
                cases = {
                  {
                    condition = "hasGlyph",
                    raw = [[time.Minute*5 -
		30*time.Second*time.Duration(warrior.Talents.ImprovedDisciplines) -
		(2*time.Minute)]]
                  },
                  {
                    condition = "!(hasGlyph)",
                    raw = [[time.Minute*5 -
		30*time.Second*time.Duration(warrior.Talents.ImprovedDisciplines) -
		(0)]]
                  }
                }
              },
              major_cooldown = {
                type = "core.CooldownTypeSurvival"
              },
              class_token = "warrior"
            },
            aura = {
              class = "warrior",
              spell_id = 871,
              label = "Shield Wall",
              duration = {
                cases = {
                  {
                    condition = "warrior.HasSetBonus(ItemSetDreadnaughtPlate, 4)",
                    raw = "time.Second*12 + (time.Second*3)",
                    seconds = 15.0
                  },
                  {
                    condition = "!(warrior.HasSetBonus(ItemSetDreadnaughtPlate, 4))",
                    raw = "time.Second*12 + (0)",
                    seconds = 12.0
                  }
                },
                raw = "time.Second*12 + core.TernaryDuration(warrior.HasSetBonus(ItemSetDreadnaughtPlate, 4), time.Second*3, 0)"
              },
              duration_raw = "duration",
              class_token = "warrior"
            }
          }
        },
        bloodrage = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 2687,
              label = "Bloodrage",
              cooldown = {
                raw = "warrior.intensifyRageCooldown(time.Minute)"
              },
              class_token = "warrior"
            }
          }
        },
        slam = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 47475,
              label = "Slam",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1 + 0.02*float64(warrior.Talents.UnendingFury) + core.TernaryFloat64(warrior.HasSetBonus(ItemSetDreadnaughtBattlegear, 2), 0.1, 0)",
              crit_multiplier = "warrior.critMultiplier(mh)",
              threat_multiplier = "1",
              class_token = "warrior"
            }
          }
        },
        shield_block = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 2565,
              label = "Shield Block",
              cooldown = {
                raw = "time.Second*60 - time.Second*10*warrior.Talents.ShieldMastery",
                cases = {
                  {
                    raw = "time.Second*60 - time.Second*10*time.Duration(warrior.Talents.ShieldMastery)"
                  },
                  {
                    condition = "warrior.HasSetBonus(ItemSetWrynnsPlate, 4)",
                    raw = "(cooldownDur-time.Second*10)"
                  },
                  {
                    condition = "!(warrior.HasSetBonus(ItemSetWrynnsPlate, 4))",
                    raw = "(cooldownDur)"
                  }
                }
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              spell_school = "2",
              class_token = "warrior"
            },
            aura = {
              class = "warrior",
              spell_id = 2565,
              label = "Shield Block",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "warrior"
            }
          }
        },
        rend = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 47465,
              label = "Rend",
              tag = "Rend",
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1 + 0.1*float64(warrior.Talents.ImprovedRend)",
              threat_multiplier = "1",
              class_token = "warrior"
            }
          }
        },
        new_sunder_armor = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 47467,
              label = "New Sunder Armor",
              flags = "SpellFlagMeleeMetrics",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              threat_multiplier = "1",
              class_token = "warrior"
            }
          }
        },
        recklessness = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 1719,
              label = "Recklessness",
              cooldown = {
                raw = "warrior.intensifyRageCooldown(time.Minute * 5)"
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
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
        shield_slam = {
          id = 10,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 47488,
              label = "Shield Slam",
              cooldown = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1 + .05*float64(warrior.Talents.GagOrder) + core.TernaryFloat64(warrior.HasSetBonus(ItemSetOnslaughtArmor, 4), .10, 0) + core.TernaryFloat64(warrior.HasSetBonus(ItemSetDreadnaughtPlate, 2), .10, 0) + core.TernaryFloat64(warrior.HasSetBonus(ItemSetYmirjarLordsPlate, 2), .20, 0)",
              crit_multiplier = "warrior.critMultiplier(mh)",
              threat_multiplier = "1.3",
              class_token = "warrior"
            },
            aura = {
              class = "warrior",
              spell_id = 58397,
              label = "Glyph of Blocking",
              duration = {
                raw = "10 * time.Second",
                seconds = 10.0
              },
              class_token = "warrior"
            }
          }
        },
        make_shout_spell_helper = {
          id = 11,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "warrior",
                spell_id = 47440,
                label = "Make Shout Spell Helper",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL | core.SpellFlagHelpful",
                class_token = "warrior"
              },
              {
                class = "warrior",
                spell_id = 47436,
                label = "Make Shout Spell Helper",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL | core.SpellFlagHelpful",
                class_token = "warrior"
              }
            }
          }
        },
        overpower = {
          id = 12,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "warrior",
                spell_id = 68051,
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
        ymirjar_lords_battlegear2pc = {
          id = 13,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "warrior",
                label = "Ymirjar Lord's Battlegear 2pc",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "warrior"
              },
              {
                class = "warrior",
                spell_id = 70855,
                label = "Ymirjar Lord's Battlegear 2pc Proc",
                duration = {
                  raw = "time.Second * 10",
                  seconds = 10.0
                },
                class_token = "warrior"
              }
            }
          }
        },
        siegebreaker_battlegear2pc = {
          id = 14,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "warrior",
                label = "Siegebreaker Battlegear 2pc",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "warrior"
              },
              {
                class = "warrior",
                spell_id = 64937,
                label = "Siegebreaker Battlegear 2pc Proc",
                duration = {
                  raw = "time.Second * 5",
                  seconds = 5.0
                },
                class_token = "warrior"
              }
            }
          }
        },
        dreadnaught_battlegear4pc = {
          id = 15,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "warrior",
                label = "Dreadnaught Battlegear 4pc",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "warrior"
              },
              {
                class = "warrior",
                spell_id = 61571,
                label = "Dreadnaught Battlegear 4pc Proc",
                duration = {
                  raw = "time.Second * 30",
                  seconds = 30.0
                },
                class_token = "warrior"
              }
            }
          }
        },
        whirlwind = {
          id = 16,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "warrior",
                spell_id = 1680,
                label = "Whirlwind",
                cooldown = {
                  raw = "core.TernaryDuration(warrior.HasMajorGlyph(proto.WarriorMajorGlyph_GlyphOfWhirlwind), time.Second*8, time.Second*10)",
                  cases = {
                    {
                      condition = "warrior.HasMajorGlyph(proto.WarriorMajorGlyph_GlyphOfWhirlwind)",
                      raw = "(time.Second*8)",
                      seconds = 8.0
                    },
                    {
                      condition = "!(warrior.HasMajorGlyph(proto.WarriorMajorGlyph_GlyphOfWhirlwind))",
                      raw = "(time.Second*10)",
                      seconds = 10.0
                    }
                  }
                },
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | SpellFlagBloodsurge | core.SpellFlagAPL",
                spell_school = "2",
                proc_mask = "ProcMaskMeleeMHSpecial",
                damage_multiplier = "1 * (1 + 0.02*float64(warrior.Talents.UnendingFury) + 0.1*float64(warrior.Talents.ImprovedWhirlwind))",
                crit_multiplier = "warrior.critMultiplier(mh)",
                threat_multiplier = "1.25",
                class_token = "warrior"
              },
              {
                class = "warrior",
                spell_id = 1680,
                label = "Whirlwind",
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagNoOnCastComplete | SpellFlagWhirlwindOH",
                spell_school = "2",
                proc_mask = "2",
                damage_multiplier = "1 * (1 + 0.02*float64(warrior.Talents.UnendingFury) + 0.1*float64(warrior.Talents.ImprovedWhirlwind)) * (1 + 0.05*float64(warrior.Talents.DualWieldSpecialization))",
                crit_multiplier = "warrior.critMultiplier(oh)",
                threat_multiplier = "1.25",
                class_token = "warrior"
              }
            }
          }
        },
        make_stance = {
          id = 17,
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
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
                class_token = "warrior"
              },
              {
                class = "warrior",
                label = "Make Stance",
                cooldown = {
                  raw = "time.Second",
                  seconds = 1.0
                },
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
                class_token = "warrior"
              },
              {
                class = "warrior",
                label = "Make Stance",
                cooldown = {
                  raw = "time.Second",
                  seconds = 1.0
                },
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
                class_token = "warrior"
              }
            }
          }
        },
        berserker_stance = {
          id = 18,
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
          id = 19,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "warrior",
                spell_id = 71,
                label = "Defensive Stance",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "warrior"
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
                spell_id = 57516,
                label = "Enrage",
                duration = {
                  raw = "12 * time.Second",
                  seconds = 12.0
                },
                class_token = "warrior"
              }
            }
          }
        },
        battle_stance = {
          id = 20,
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
          id = 21,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "warrior",
                label = "Make Queue Spells And",
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
                spell_school = "2",
                proc_mask = "ProcMaskMeleeMHSpecial",
                class_token = "warrior"
              },
              {
                class = "warrior",
                label = "Make Queue Spells And",
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
                spell_school = "2",
                proc_mask = "ProcMaskMeleeMHSpecial",
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
          id = 22,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 47520,
              label = "Cleave",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              crit_multiplier = "warrior.critMultiplier(mh)",
              threat_multiplier = "1",
              class_token = "warrior"
            }
          }
        },
        heroic_strike = {
          id = 23,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 47450,
              label = "Heroic Strike",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagNoOnCastComplete | SpellFlagBloodsurge",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              crit_multiplier = "warrior.critMultiplier(mh)",
              threat_multiplier = "1",
              class_token = "warrior"
            }
          }
        },
        shattering_throw = {
          id = 24,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 64382,
              label = "Shattering Throw",
              cooldown = {
                raw = "time.Minute * 5",
                seconds = 300.0
              },
              major_cooldown = {
                type = "core.CooldownTypeDPS"
              },
              flags = "SpellFlagMeleeMetrics",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              crit_multiplier = "warrior.critMultiplier(mh)",
              threat_multiplier = "1",
              class_token = "warrior"
            }
          }
        },
        heroic_throw = {
          id = 25,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 57755,
              label = "Heroic Throw",
              cooldown = {
                raw = "time.Minute * 1",
                seconds = 60.0
              },
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              crit_multiplier = "warrior.critMultiplier(mh)",
              threat_multiplier = "1.5",
              class_token = "warrior"
            }
          }
        },
        execute = {
          id = 26,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "warrior",
              spell_id = 47471,
              label = "Execute",
              flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagAPL",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              crit_multiplier = "warrior.critMultiplier(mh)",
              threat_multiplier = "1.25",
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
        "shield_wall",
        "bloodrage",
        "slam",
        "shield_block",
        "rend",
        "new_sunder_armor",
        "recklessness",
        "shield_slam",
        "make_shout_spell_helper",
        "overpower",
        "ymirjar_lords_battlegear2pc",
        "siegebreaker_battlegear2pc",
        "dreadnaught_battlegear4pc",
        "whirlwind",
        "make_stance",
        "berserker_stance",
        "defensive_stance",
        "battle_stance",
        "make_queue_spells_and",
        "cleave",
        "heroic_strike",
        "shattering_throw",
        "heroic_throw",
        "execute"
      },
      synthetic = true
    },
    CommonWotlkSpells = {
      fields = {
        new_proc_damage = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "common",
                spec = "wotlk",
                label = "New Proc Damage",
                spell_school = "core.SpellSchoolShadow",
                proc_mask = "2",
                damage_multiplier = "1",
                crit_multiplier = "character.DefaultSpellCritMultiplier()",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                label = "New Proc Damage",
                spell_school = "core.SpellSchoolShadow",
                proc_mask = "2",
                damage_multiplier = "1",
                crit_multiplier = "character.DefaultSpellCritMultiplier()",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                label = "New Proc Damage",
                spell_school = "core.SpellSchoolArcane",
                proc_mask = "2",
                damage_multiplier = "1",
                crit_multiplier = "character.DefaultSpellCritMultiplier()",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                label = "New Proc Damage",
                spell_school = "core.SpellSchoolHoly",
                proc_mask = "2",
                damage_multiplier = "1",
                crit_multiplier = "character.DefaultSpellCritMultiplier()",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                label = "New Proc Damage",
                spell_school = "core.SpellSchoolShadow",
                proc_mask = "2",
                damage_multiplier = "1",
                crit_multiplier = "character.DefaultSpellCritMultiplier()",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                label = "New Proc Damage",
                spell_school = "core.SpellSchoolFire",
                proc_mask = "2",
                damage_multiplier = "1",
                crit_multiplier = "character.DefaultSpellCritMultiplier()",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "wotlk"
              }
            }
          }
        },
        shard_of_the_gods_healing = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "common",
                spec = "wotlk",
                spell_id = 69733,
                label = "Shard Of The Gods Healing",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagHelpful",
                spell_school = "SpellSchoolHoly",
                proc_mask = "ProcMaskSpellHealing",
                damage_multiplier = "1",
                crit_multiplier = "character.DefaultHealingCritMultiplier()",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                spell_id = 69733,
                label = "Shard Of The Gods Healing",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagHelpful",
                spell_school = "SpellSchoolHoly",
                proc_mask = "ProcMaskSpellHealing",
                damage_multiplier = "1",
                crit_multiplier = "character.DefaultHealingCritMultiplier()",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "wotlk"
              }
            }
          }
        },
        shard_of_the_gods_damage = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "common",
              spec = "wotlk",
              spell_id = 69729,
              label = "Searing Flames",
              spell_school = "SpellSchoolFire",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "common",
              spec_token = "wotlk"
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
                spec = "wotlk",
                spell_id = 55341,
                label = "Init",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagHelpful",
                spell_school = "2",
                proc_mask = "ProcMaskSpellHealing",
                damage_multiplier = "1",
                crit_multiplier = "character.DefaultHealingCritMultiplier()",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                spell_id = 71904,
                label = "Init",
                spell_school = "SpellSchoolShadow",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                spell_id = 71434,
                label = "Init",
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagNoOnCastComplete",
                spell_school = "2",
                proc_mask = "ProcMaskMeleeOHSpecial",
                damage_multiplier = "character.AutoAttacks.OHConfig().DamageMultiplier * 0.5",
                crit_multiplier = "character.AutoAttacks.OHConfig().CritMultiplier",
                threat_multiplier = "character.AutoAttacks.OHConfig().ThreatMultiplier",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                spell_id = 71433,
                label = "Init",
                flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIncludeTargetBonusDamage | core.SpellFlagNoOnCastComplete",
                spell_school = "2",
                proc_mask = "ProcMaskMeleeMHSpecial",
                damage_multiplier = "character.AutoAttacks.MHConfig().DamageMultiplier * 0.5",
                crit_multiplier = "character.AutoAttacks.MHConfig().CritMultiplier",
                threat_multiplier = "character.AutoAttacks.MHConfig().ThreatMultiplier",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                spell_id = 54758,
                label = "Init",
                cooldown = {
                  raw = "time.Second * 60",
                  seconds = 60.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS",
                  priority = "core.CooldownPriorityLow"
                },
                flags = "SpellFlagNoOnCastComplete",
                spell_school = "core.SpellSchoolPhysical | core.SpellSchoolMagic",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                spell_id = 54757,
                label = "Init",
                cooldown = {
                  raw = "time.Second * 45",
                  seconds = 45.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS",
                  priority = "core.CooldownPriorityLow"
                },
                flags = "SpellFlagNoOnCastComplete",
                spell_school = "SpellSchoolFire",
                proc_mask = "2",
                damage_multiplier = "1",
                crit_multiplier = "character.DefaultSpellCritMultiplier()",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                label = "Init",
                spell_school = "2",
                proc_mask = "2",
                damage_multiplier = "1",
                crit_multiplier = "character.DefaultMeleeCritMultiplier()",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                spell_id = 44525,
                label = "Init",
                spell_school = "SpellSchoolFire",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "character.DefaultSpellCritMultiplier()",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                spell_id = 44622,
                label = "Init",
                spell_school = "2",
                proc_mask = "2",
                damage_multiplier = "1",
                crit_multiplier = "character.DefaultSpellCritMultiplier()",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                label = "Init",
                cooldown = {
                  raw = "time.Second * 180",
                  seconds = 180.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeSurvival"
                },
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                spell_id = 51460,
                label = "Init",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreModifiers",
                spell_school = "SpellSchoolShadow",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                label = "Init",
                spell_school = "SpellSchoolShadow",
                proc_mask = "2",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                label = "Init",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "SpellFlagNoOnCastComplete",
                spell_school = "2",
                proc_mask = "2",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                label = "Init",
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagHelpful",
                spell_school = "2",
                proc_mask = "ProcMaskSpellHealing",
                damage_multiplier = "1",
                crit_multiplier = "character.DefaultHealingCritMultiplier()",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                label = "Init",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagHelpful",
                spell_school = "SpellSchoolHoly",
                proc_mask = "ProcMaskSpellHealing",
                damage_multiplier = "1",
                crit_multiplier = "character.DefaultHealingCritMultiplier()",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                spell_id = 71586,
                label = "Init",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagHelpful",
                spell_school = "SpellSchoolHoly",
                proc_mask = "ProcMaskSpellHealing",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                spell_id = 56186,
                label = "Init",
                cooldown = {
                  raw = "time.Minute * 5",
                  seconds = 300.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                label = "Init",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                label = "Init",
                cooldown = {
                  raw = "time.Minute * 3",
                  seconds = 180.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                spell_id = 64413,
                label = "Init",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagHelpful",
                spell_school = "SpellSchoolNature",
                proc_mask = "ProcMaskSpellHealing",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                label = "Init",
                cooldown = {
                  raw = "time.Minute * 1",
                  seconds = 60.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "SpellFlagNoOnCastComplete",
                spell_school = "SpellSchoolNature",
                proc_mask = "2",
                damage_multiplier = "1",
                crit_multiplier = "character.DefaultSpellCritMultiplier()",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                label = "Init",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "SpellFlagNoOnCastComplete",
                spell_school = "2",
                proc_mask = "2",
                class_token = "common",
                spec_token = "wotlk"
              }
            }
          }
        },
        shadowmourne = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "wotlk",
              spell_id = 73422,
              label = "Shadowmourne",
              class_token = "common",
              spec_token = "wotlk"
            }
          }
        },
        soul_fragment = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "wotlk",
              spell_id = 71905,
              label = "Soul Fragment",
              duration_raw = "time.Minute",
              class_token = "common",
              spec_token = "wotlk"
            }
          }
        },
        make_capacitor = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "common",
                spec = "wotlk",
                label = "Make Capacitor",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                label = "Make Capacitor",
                class_token = "common",
                spec_token = "wotlk"
              }
            }
          }
        },
        new_capacitor_damage = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "common",
                spec = "wotlk",
                label = "New Capacitor Damage",
                spell_school = "core.SpellSchoolFire",
                proc_mask = "2",
                damage_multiplier = "1",
                crit_multiplier = "character.DefaultSpellCritMultiplier()",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                label = "New Capacitor Damage",
                spell_school = "core.SpellSchoolFire",
                proc_mask = "2",
                damage_multiplier = "1",
                crit_multiplier = "character.DefaultSpellCritMultiplier()",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                label = "New Capacitor Damage",
                spell_school = "core.SpellSchoolFire",
                proc_mask = "2",
                damage_multiplier = "1",
                crit_multiplier = "character.DefaultSpellCritMultiplier()",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                label = "New Capacitor Damage",
                spell_school = "core.SpellSchoolFire",
                proc_mask = "2",
                damage_multiplier = "1",
                crit_multiplier = "character.DefaultSpellCritMultiplier()",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                label = "New Capacitor Damage",
                spell_school = "core.SpellSchoolNature",
                proc_mask = "2",
                damage_multiplier = "1",
                crit_multiplier = "character.DefaultSpellCritMultiplier()",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "wotlk"
              }
            }
          }
        },
        new_stacking_stat_bonus = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "common",
                spec = "wotlk",
                label = "New Stacking Stat Bonus",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                label = "New Stacking Stat Bonus",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                label = "New Stacking Stat Bonus",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                label = "New Stacking Stat Bonus",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                label = "New Stacking Stat Bonus",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                label = "New Stacking Stat Bonus",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                label = "New Stacking Stat Bonus",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                label = "New Stacking Stat Bonus",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                label = "New Stacking Stat Bonus",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                label = "New Stacking Stat Bonus",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                label = "New Stacking Stat Bonus",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                label = "New Stacking Stat Bonus",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                label = "New Stacking Stat Bonus",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                label = "New Stacking Stat Bonus",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                label = "New Stacking Stat Bonus",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                label = "New Stacking Stat Bonus",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                label = "New Stacking Stat Bonus",
                cooldown = {
                  raw = "time.Minute * 2",
                  seconds = 120.0
                },
                major_cooldown = {
                  type = "core.CooldownTypeDPS"
                },
                flags = "SpellFlagNoOnCastComplete",
                class_token = "common",
                spec_token = "wotlk"
              }
            }
          }
        },
        blood_reserve = {
          id = 10,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "wotlk",
              spell_id = 64568,
              label = "Blood Reserve",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "common",
              spec_token = "wotlk"
            }
          }
        },
        swordguard_embroidery = {
          id = 11,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "wotlk",
              spell_id = 55775,
              label = "Swordguard Embroidery",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common",
              spec_token = "wotlk"
            }
          }
        },
        darkglow_embroidery = {
          id = 12,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "wotlk",
              spell_id = 55767,
              label = "Darkglow Embroidery",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common",
              spec_token = "wotlk"
            }
          }
        },
        lightweave_embroidery = {
          id = 13,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "wotlk",
              label = "Lightweave Embroidery",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common",
              spec_token = "wotlk"
            }
          }
        },
        black_magic = {
          id = 14,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "wotlk",
              label = "Black Magic",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common",
              spec_token = "wotlk"
            }
          }
        },
        lifeward = {
          id = 15,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "wotlk",
              label = "Lifeward",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common",
              spec_token = "wotlk"
            }
          }
        },
        berserking_enchant = {
          id = 16,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "wotlk",
              spell_id = 59620,
              label = "Berserking (Enchant)",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common",
              spec_token = "wotlk"
            }
          }
        },
        titanium_shield_spike = {
          id = 17,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "wotlk",
              label = "Titanium Shield Spike",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common",
              spec_token = "wotlk"
            }
          }
        },
        icebreaker = {
          id = 18,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "wotlk",
              label = "Icebreaker",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common",
              spec_token = "wotlk"
            }
          }
        },
        giant_slayer = {
          id = 19,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "wotlk",
              label = "Giant Slayer",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common",
              spec_token = "wotlk"
            }
          }
        },
        last_word = {
          id = 20,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "wotlk",
              spell_id = 71870,
              label = "Last Word",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "common",
              spec_token = "wotlk"
            }
          }
        },
        mercurial_shield = {
          id = 21,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "wotlk",
              spell_id = 26464,
              label = "Mercurial Shield",
              duration = {
                raw = "time.Second * 60",
                seconds = 60.0
              },
              class_token = "common",
              spec_token = "wotlk"
            }
          }
        },
        soul_preserver = {
          id = 22,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "wotlk",
              label = "Soul Preserver",
              duration = {
                raw = "time.Second * 15",
                seconds = 15.0
              },
              class_token = "common",
              spec_token = "wotlk"
            }
          }
        },
        bryntrollthe_bone_arbiter = {
          id = 23,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "wotlk",
              label = "Bryntroll, the Bone Arbiter",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common",
              spec_token = "wotlk"
            }
          }
        },
        glowing_twilight_scale = {
          id = 24,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "common",
              spec = "wotlk",
              label = "Glowing Twilight Scale",
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagHelpful",
              spell_school = "SpellSchoolHoly",
              proc_mask = "ProcMaskSpellHealing",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "common",
              spec_token = "wotlk"
            }
          }
        },
        heartpierce = {
          id = 25,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "wotlk",
              label = "Heartpierce",
              duration = {
                raw = "time.Second * 2 * time.Duration(numTicks)"
              },
              class_token = "common",
              spec_token = "wotlk"
            }
          }
        },
        forethought_talisman = {
          id = 26,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "common",
              spec = "wotlk",
              label = "Forethought Talisman",
              flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagHelpful",
              spell_school = "2",
              proc_mask = "ProcMaskSpellHealing",
              damage_multiplier = "1",
              threat_multiplier = "1",
              class_token = "common",
              spec_token = "wotlk"
            }
          }
        },
        touchedbya_troll = {
          id = 27,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "wotlk",
              spell_id = 60518,
              label = "Touched by a Troll",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "common",
              spec_token = "wotlk"
            }
          }
        },
        the_generals_heart = {
          id = 28,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "wotlk",
              label = "The General's Heart",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "common",
              spec_token = "wotlk"
            }
          }
        },
        essenceof_gossamer = {
          id = 29,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "wotlk",
              label = "Essence of Gossamer",
              duration = {
                raw = "time.Second * 10",
                seconds = 10.0
              },
              class_token = "common",
              spec_token = "wotlk"
            }
          }
        },
        make_nibelung_trigger = {
          id = 30,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "wotlk",
              spell_id = 71844,
              label = "Summon Val'kyr",
              duration = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              class_token = "common",
              spec_token = "wotlk"
            }
          }
        },
        smite = {
          id = 31,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "common",
                spec = "wotlk",
                label = "Smite",
                spell_school = "SpellSchoolHoly",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "valkyr.DefaultSpellCritMultiplier()",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "wotlk"
              },
              {
                class = "common",
                spec = "wotlk",
                label = "Smite",
                spell_school = "SpellSchoolHoly",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "valkyr.DefaultSpellCritMultiplier()",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "wotlk"
              }
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "new_proc_damage",
        "shard_of_the_gods_healing",
        "shard_of_the_gods_damage",
        "init",
        "shadowmourne",
        "soul_fragment",
        "make_capacitor",
        "new_capacitor_damage",
        "new_stacking_stat_bonus",
        "blood_reserve",
        "swordguard_embroidery",
        "darkglow_embroidery",
        "lightweave_embroidery",
        "black_magic",
        "lifeward",
        "berserking_enchant",
        "titanium_shield_spike",
        "icebreaker",
        "giant_slayer",
        "last_word",
        "mercurial_shield",
        "soul_preserver",
        "bryntrollthe_bone_arbiter",
        "glowing_twilight_scale",
        "heartpierce",
        "forethought_talisman",
        "touchedbya_troll",
        "the_generals_heart",
        "essenceof_gossamer",
        "make_nibelung_trigger",
        "smite"
      },
      synthetic = true
    },
    CommonTbcSpells = {
      fields = {
        bandofthe_eternal_sage = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "tbc",
              label = "Band of the Eternal Sage",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common",
              spec_token = "tbc"
            }
          }
        },
        thundering_skyfire_diamond = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "tbc",
              label = "Thundering Skyfire Diamond",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common",
              spec_token = "tbc"
            }
          }
        },
        insightful_earthstorm_diamond = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "tbc",
              label = "Insightful Earthstorm Diamond",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common",
              spec_token = "tbc"
            }
          }
        },
        mystical_skyfire_diamond = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "tbc",
              label = "Mystical Skyfire Diamond",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common",
              spec_token = "tbc"
            }
          }
        },
        felstriker = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "tbc",
              spell_id = 16551,
              label = "Felstriker",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common",
              spec_token = "tbc"
            }
          }
        },
        commendationof_kael_thas = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "tbc",
              label = "Commendation of Kael'Thas",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common",
              spec_token = "tbc"
            }
          }
        },
        bulwark_of_azzinoth = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "tbc",
              label = "Bulwark Of Azzinoth",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common",
              spec_token = "tbc"
            }
          }
        },
        syphonofthe_nathrezim = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "tbc",
              label = "Syphon of the Nathrezim",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common",
              spec_token = "tbc"
            }
          }
        },
        siphon_essence = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "tbc",
              spell_id = 40291,
              label = "Siphon Essence",
              duration = {
                raw = "time.Second * 6",
                seconds = 6.0
              },
              class_token = "common",
              spec_token = "tbc"
            }
          }
        },
        init = {
          id = 10,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "common",
                spec = "tbc",
                spell_id = 40291,
                label = "Init",
                spell_school = "SpellSchoolShadow",
                proc_mask = "2",
                damage_multiplier = "1",
                crit_multiplier = "character.DefaultSpellCritMultiplier()",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "tbc"
              },
              {
                class = "common",
                spec = "tbc",
                spell_id = 24585,
                label = "Init",
                spell_school = "SpellSchoolShadow",
                proc_mask = "2",
                damage_multiplier = "1",
                crit_multiplier = "character.DefaultSpellCritMultiplier()",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "tbc"
              },
              {
                class = "common",
                spec = "tbc",
                spell_id = 21992,
                label = "Init",
                spell_school = "SpellSchoolNature",
                proc_mask = "2",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "tbc"
              },
              {
                class = "common",
                spec = "tbc",
                spell_id = 21992,
                label = "Init",
                spell_school = "SpellSchoolNature",
                proc_mask = "2",
                damage_multiplier = "1",
                crit_multiplier = "character.DefaultSpellCritMultiplier()",
                threat_multiplier = "0.5",
                class_token = "common",
                spec_token = "tbc"
              },
              {
                class = "common",
                spec = "tbc",
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
                spec_token = "tbc"
              },
              {
                class = "common",
                spec = "tbc",
                spell_id = 26470,
                label = "Init",
                flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagHelpful",
                spell_school = "SpellSchoolNature",
                proc_mask = "ProcMaskSpellHealing",
                damage_multiplier = "1",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "tbc"
              },
              {
                class = "common",
                spec = "tbc",
                spell_id = 46579,
                label = "Init",
                spell_school = "SpellSchoolFrost",
                proc_mask = "2",
                damage_multiplier = "1",
                crit_multiplier = "character.DefaultSpellCritMultiplier()",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "tbc"
              }
            }
          }
        },
        rodofthe_sun_king = {
          id = 11,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "tbc",
              label = "Rod of the Sun King",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common",
              spec_token = "tbc"
            }
          }
        },
        bandofthe_eternal_champion = {
          id = 12,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "tbc",
              label = "Band of the Eternal Champion",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common",
              spec_token = "tbc"
            }
          }
        },
        bandofthe_eternal_defender = {
          id = 13,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "tbc",
              label = "Band of the Eternal Defender",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common",
              spec_token = "tbc"
            }
          }
        },
        thunderfury = {
          id = 14,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "common",
                spec = "tbc",
                label = "Thunderfury",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "common",
                spec_token = "tbc"
              },
              {
                class = "common",
                spec = "tbc",
                spell_id = 21992,
                label = "Thunderfury",
                duration = {
                  raw = "time.Second * 12",
                  seconds = 12.0
                },
                class_token = "common",
                spec_token = "tbc"
              }
            }
          }
        },
        deathfrost = {
          id = 15,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "common",
                spec = "tbc",
                spell_id = 46579,
                label = "Deathfrost",
                duration = {
                  raw = "time.Second * 8",
                  seconds = 8.0
                },
                class_token = "common",
                spec_token = "tbc"
              },
              {
                class = "common",
                spec = "tbc",
                label = "Deathfrost",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "common",
                spec_token = "tbc"
              }
            }
          }
        },
        executioner = {
          id = 16,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "tbc",
              spell_id = 42976,
              label = "Executioner",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common",
              spec_token = "tbc"
            }
          }
        },
        mongoose_enchant = {
          id = 17,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "tbc",
              spell_id = 28093,
              label = "Mongoose Enchant",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common",
              spec_token = "tbc"
            }
          }
        },
        crusader_enchant = {
          id = 18,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "tbc",
              spell_id = 20007,
              label = "Crusader Enchant",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common",
              spec_token = "tbc"
            }
          }
        },
        shardof_contempt = {
          id = 19,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "tbc",
              label = "Shard of Contempt",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common",
              spec_token = "tbc"
            }
          }
        },
        blackened_naaru_sliver = {
          id = 20,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "common",
                spec = "tbc",
                label = "Blackened Naaru Sliver",
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "common",
                spec_token = "tbc"
              },
              {
                class = "common",
                spec = "tbc",
                label = "Blackened Naaru Sliver Proc",
                duration = {
                  raw = "time.Second * 20",
                  seconds = 20.0
                },
                class_token = "common",
                spec_token = "tbc"
              }
            }
          }
        },
        madnessofthe_betrayer = {
          id = 21,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "tbc",
              label = "Madness of the Betrayer",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common",
              spec_token = "tbc"
            }
          }
        },
        tsunami_talisman = {
          id = 22,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "tbc",
              label = "Tsunami Talisman",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common",
              spec_token = "tbc"
            }
          }
        },
        dragonspine_trophy = {
          id = 23,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "tbc",
              label = "Dragonspine Trophy",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common",
              spec_token = "tbc"
            }
          }
        },
        handof_justice = {
          id = 24,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "tbc",
              label = "Hand of Justice",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common",
              spec_token = "tbc"
            }
          }
        },
        twin_bladesof_azzinoth = {
          id = 25,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "tbc",
              label = "Twin Blades of Azzinoth",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common",
              spec_token = "tbc"
            }
          }
        },
        stormshround_armor3pc = {
          id = 26,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "tbc",
              spell_id = 18979,
              label = "Stormshround Armor 3pc",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common",
              spec_token = "tbc"
            }
          }
        },
        proc = {
          id = 27,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "common",
                spec = "tbc",
                spell_id = 23864,
                label = "Proc",
                spell_school = "SpellSchoolNature",
                class_token = "common",
                spec_token = "tbc"
              },
              {
                class = "common",
                spec = "tbc",
                spell_id = 18980,
                label = "Proc",
                spell_school = "SpellSchoolNature",
                proc_mask = "2",
                damage_multiplier = "1",
                crit_multiplier = "char.DefaultSpellCritMultiplier()",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "tbc"
              },
              {
                class = "common",
                spec = "tbc",
                spell_id = 41989,
                label = "Proc",
                spell_school = "SpellSchoolFire",
                proc_mask = "2",
                damage_multiplier = "1",
                crit_multiplier = "character.DefaultSpellCritMultiplier()",
                threat_multiplier = "1",
                class_token = "common",
                spec_token = "tbc"
              }
            }
          }
        },
        stormshround_armor2pc = {
          id = 28,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "tbc",
              spell_id = 18979,
              label = "Stormshround Armor 2pc",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
              },
              class_token = "common",
              spec_token = "tbc"
            }
          }
        },
        fistsof_fury = {
          id = 29,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "common",
              spec = "tbc",
              label = "Fists of Fury",
              duration = {
                raw = "time.Duration(math.MaxInt64)"
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
        "bandofthe_eternal_sage",
        "thundering_skyfire_diamond",
        "insightful_earthstorm_diamond",
        "mystical_skyfire_diamond",
        "felstriker",
        "commendationof_kael_thas",
        "bulwark_of_azzinoth",
        "syphonofthe_nathrezim",
        "siphon_essence",
        "init",
        "rodofthe_sun_king",
        "bandofthe_eternal_champion",
        "bandofthe_eternal_defender",
        "thunderfury",
        "deathfrost",
        "executioner",
        "mongoose_enchant",
        "crusader_enchant",
        "shardof_contempt",
        "blackened_naaru_sliver",
        "madnessofthe_betrayer",
        "tsunami_talisman",
        "dragonspine_trophy",
        "handof_justice",
        "twin_bladesof_azzinoth",
        "stormshround_armor3pc",
        "proc",
        "stormshround_armor2pc",
        "fistsof_fury"
      },
      synthetic = true
    },
    EncounterSpells = {
      fields = {
        leeching_swarm = {
          id = 1,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "encounters",
                spec = "toc",
                spell_id = 66118,
                label = "Leeching Swarm",
                flags = "SpellFlagIgnoreAttackerModifiers | SpellFlagIgnoreTargetModifiers",
                spell_school = "SpellSchoolNature",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "1",
                class_token = "encounters",
                spec_token = "toc"
              },
              {
                class = "encounters",
                spec = "toc",
                spell_id = 66118,
                label = "Leeching Swarm",
                flags = "SpellFlagNoOnDamageDealt",
                class_token = "encounters",
                spec_token = "toc"
              }
            }
          }
        },
        freezing_slash = {
          id = 2,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "encounters",
              spec = "toc",
              spell_id = 66012,
              label = "Freezing Slash",
              cooldown = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              flags = "2",
              spell_school = "SpellSchoolFrost",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              crit_multiplier = "1",
              class_token = "encounters",
              spec_token = "toc"
            }
          }
        },
        rising_anger = {
          id = 3,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "encounters",
              spec = "toc",
              spell_id = 66636,
              label = "Rising Anger",
              cooldown = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              flags = "0",
              spell_school = "2",
              proc_mask = "2",
              damage_multiplier = "1",
              crit_multiplier = "1",
              class_token = "encounters",
              spec_token = "toc"
            },
            aura = {
              class = "encounters",
              spec = "toc",
              spell_id = 66636,
              label = "Rising Anger",
              duration = {
                raw = "time.Second * 120",
                seconds = 120.0
              },
              class_token = "encounters",
              spec_token = "toc"
            }
          }
        },
        staggering_stomp = {
          id = 4,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "encounters",
              spec = "toc",
              spell_id = 66330,
              label = "Staggering Stomp",
              cooldown = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              flags = "0",
              spell_school = "2",
              proc_mask = "2",
              damage_multiplier = "1",
              crit_multiplier = "1",
              class_token = "encounters",
              spec_token = "toc"
            }
          }
        },
        frozen_blow = {
          id = 5,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              {
                class = "encounters",
                spec = "ulduar",
                label = "Frozen Blow",
                spell_school = "SpellSchoolFrost",
                proc_mask = "ProcMaskSpellDamage",
                damage_multiplier = "1",
                crit_multiplier = "1",
                class_token = "encounters",
                spec_token = "ulduar"
              },
              {
                class = "encounters",
                spec = "ulduar",
                label = "Frozen Blow",
                flags = "SpellFlagMeleeMetrics",
                spell_school = "2",
                proc_mask = "ProcMaskMeleeMHAuto",
                damage_multiplier = "1",
                crit_multiplier = "ai.Target.AutoAttacks.MH().CritMultiplier",
                class_token = "encounters",
                spec_token = "ulduar"
              },
              {
                class = "encounters",
                spec = "ulduar",
                label = "Frozen Blow",
                cooldown = {
                  raw = "time.Minute",
                  seconds = 60.0
                },
                flags = "SpellFlagMeleeMetrics",
                spell_school = "2",
                proc_mask = "ProcMaskMeleeMHAuto",
                class_token = "encounters",
                spec_token = "ulduar"
              }
            },
            aura = {
              class = "encounters",
              spec = "ulduar",
              label = "Hodir Frozen Blows",
              duration = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              class_token = "encounters",
              spec_token = "ulduar"
            }
          }
        },
        flash_freeze = {
          id = 6,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "encounters",
              spec = "ulduar",
              spell_id = 61968,
              label = "Flash Freeze",
              cooldown = {
                raw = "time.Second * 45",
                seconds = 45.0
              },
              class_token = "encounters",
              spec_token = "ulduar"
            }
          }
        },
        buffs_debuffs = {
          id = 7,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              {
                class = "encounters",
                spec = "ulduar",
                spell_id = 63711,
                label = "Buffs Debuffs",
                label_raw = [["Stormcloud" + strconv.Itoa(int(character.Index))]],
                duration = {
                  raw = "30 * time.Second",
                  seconds = 30.0
                },
                class_token = "encounters",
                spec_token = "ulduar"
              },
              {
                class = "encounters",
                spec = "ulduar",
                spell_id = 62807,
                label = "Buffs Debuffs",
                label_raw = [["Starlight" + strconv.Itoa(int(character.UnitIndex))]],
                duration = {
                  raw = "time.Second * 30",
                  seconds = 30.0
                },
                class_token = "encounters",
                spec_token = "ulduar"
              },
              {
                class = "encounters",
                spec = "ulduar",
                spell_id = 65280,
                label = "Singed",
                duration = {
                  raw = "time.Second * 25",
                  seconds = 25.0
                },
                class_token = "encounters",
                spec_token = "ulduar"
              },
              {
                class = "encounters",
                spec = "ulduar",
                spell_id = 62821,
                label = "Buffs Debuffs",
                label_raw = [["Toasty Fire" + strconv.Itoa(int(character.Index))]],
                duration = {
                  raw = "time.Duration(math.MaxInt64)"
                },
                class_token = "encounters",
                spec_token = "ulduar"
              }
            }
          }
        },
        cosmic_smash = {
          id = 8,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "encounters",
              spec = "ulduar",
              spell_id = 64596,
              label = "Cosmic Smash",
              cooldown = {
                raw = "time.Millisecond * 25000",
                seconds = 25.0
              },
              flags = "2",
              spell_school = "SpellSchoolFire",
              proc_mask = "2",
              damage_multiplier = "1",
              crit_multiplier = "1",
              class_token = "encounters",
              spec_token = "ulduar"
            }
          }
        },
        black_hole_explosion = {
          id = 9,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "encounters",
              spec = "ulduar",
              spell_id = 65108,
              label = "Black Hole Explosion",
              cooldown = {
                raw = "time.Millisecond * 30000",
                seconds = 30.0
              },
              flags = "0",
              spell_school = "SpellSchoolShadow",
              proc_mask = "2",
              damage_multiplier = "1",
              crit_multiplier = "1",
              class_token = "encounters",
              spec_token = "ulduar"
            }
          }
        },
        phase_punch = {
          id = 10,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "encounters",
              spec = "ulduar",
              spell_id = 64412,
              label = "Phase Punch",
              cooldown = {
                raw = "time.Millisecond * 16000",
                seconds = 16.0
              },
              flags = "SpellFlagMeleeMetrics",
              spell_school = "SpellSchoolArcane",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              crit_multiplier = "1",
              class_token = "encounters",
              spec_token = "ulduar"
            }
          }
        },
        quantum_strike = {
          id = 11,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "encounters",
              spec = "ulduar",
              spell_id = 64592,
              label = "Quantum Strike",
              cooldown = {
                raw = "time.Millisecond * 3200",
                seconds = 3.2
              },
              flags = "SpellFlagMeleeMetrics",
              spell_school = "2",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              crit_multiplier = "1",
              class_token = "encounters",
              spec_token = "ulduar"
            }
          }
        },
        soul_reaper = {
          id = 12,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "encounters",
              spec = "icc",
              spell_id = 69409,
              label = "Soul Reaper",
              cooldown = {
                raw = "time.Second * 30",
                seconds = 30.0
              },
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolShadow",
              proc_mask = "ProcMaskMeleeMHSpecial",
              damage_multiplier = "1",
              crit_multiplier = "1",
              class_token = "encounters",
              spec_token = "icc"
            },
            aura = {
              class = "encounters",
              spec = "icc",
              spell_id = 69410,
              label = "Soul Reaper",
              duration = {
                raw = "time.Second * 5",
                seconds = 5.0
              },
              class_token = "encounters",
              spec_token = "icc"
            }
          }
        },
        permeating_chill = {
          id = 13,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "encounters",
              spec = "icc",
              spell_id = 70106,
              label = "Chilled to the Bone",
              flags = "0",
              spell_school = "SpellSchoolFrost",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "1",
              threat_multiplier = "0",
              class_token = "encounters",
              spec_token = "icc"
            }
          }
        },
        frost_breath = {
          id = 14,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "encounters",
              spec = "icc",
              spell_id = 73061,
              label = "Frost Breath",
              cooldown = {
                raw = "time.Second * 20",
                seconds = 20.0
              },
              flags = "SpellFlagAPL",
              spell_school = "SpellSchoolFrost",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "1",
              class_token = "encounters",
              spec_token = "icc"
            },
            aura = {
              class = "encounters",
              spec = "icc",
              spell_id = 73061,
              label = "Frost Breath",
              duration_raw = "time.Minute",
              class_token = "encounters",
              spec_token = "icc"
            }
          }
        },
        frost_aura = {
          id = 15,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            spell = {
              class = "encounters",
              spec = "icc",
              spell_id = 70084,
              label = "Frost Aura",
              flags = "0",
              spell_school = "SpellSchoolFrost",
              proc_mask = "ProcMaskSpellDamage",
              damage_multiplier = "1",
              crit_multiplier = "1",
              class_token = "encounters",
              spec_token = "icc"
            }
          }
        },
        mystic_buffet_auras = {
          id = 16,
          type = "bool",
          label = "optional",
          synthetic = true,
          _metadata = {
            aura = {
              class = "encounters",
              spec = "icc",
              spell_id = 70127,
              label = "Mystic Buffet",
              duration = {
                raw = "time.Second * 8",
                seconds = 8.0
              },
              class_token = "encounters",
              spec_token = "icc"
            }
          }
        },
        hateful_strike = {
          id = 17,
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
              crit_multiplier = "1",
              class_token = "encounters",
              spec_token = "naxxramas"
            }
          }
        }
      },
      oneofs = {

      },
      field_order = {
        "leeching_swarm",
        "freezing_slash",
        "rising_anger",
        "staggering_stomp",
        "frozen_blow",
        "flash_freeze",
        "buffs_debuffs",
        "cosmic_smash",
        "black_hole_explosion",
        "phase_punch",
        "quantum_strike",
        "soul_reaper",
        "permeating_chill",
        "frost_breath",
        "frost_aura",
        "mystic_buffet_auras",
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
    PriestMajorGlyph = {
      PriestMajorGlyphNone = 0,
      GlyphOfCircleOfHealing = 42396,
      GlyphOfDispelMagic = 42397,
      GlyphOfDispersion = 45753,
      GlyphOfFade = 42398,
      GlyphOfFearWard = 42399,
      GlyphOfFlashHeal = 42400,
      GlyphOfGuardianSpirit = 45755,
      GlyphOfHolyNova = 42401,
      GlyphOfHymnOfHope = 45758,
      GlyphOfInnerFire = 42402,
      GlyphOfLightwell = 42403,
      GlyphOfMassDispel = 42404,
      GlyphOfMindControl = 42405,
      GlyphOfMindFlay = 42415,
      GlyphOfMindSear = 45757,
      GlyphOfPainSuppression = 45760,
      GlyphOfPenance = 45756,
      GlyphOfPowerWordShield = 42408,
      GlyphOfPrayerOfHealing = 42409,
      GlyphOfPsychicScream = 42410,
      GlyphOfRenew = 42411,
      GlyphOfScourgeImprisonment = 42412,
      GlyphOfShadow = 42407,
      GlyphOfShadowWordDeath = 42414,
      GlyphOfShadowWordPain = 42406,
      GlyphOfSmite = 42416,
      GlyphOfSpiritOfRedemption = 42417
    },
    PriestMinorGlyph = {
      PriestMinorGlyphNone = 0,
      GlyphOfFading = 43342,
      GlyphOfFortitude = 43371,
      GlyphOfLevitate = 43370,
      GlyphOfShackleUndead = 43373,
      GlyphOfShadowProtection = 43372,
      GlyphOfShadowfiend = 43374
    },
    TristateEffect = {
      TristateEffectMissing = 0,
      TristateEffectRegular = 1,
      TristateEffectImproved = 2
    },
    Flask = {
      FlaskUnknown = 0,
      FlaskOfTheFrostWyrm = 1,
      FlaskOfEndlessRage = 2,
      FlaskOfPureMojo = 3,
      FlaskOfStoneblood = 4,
      LesserFlaskOfToughness = 5,
      LesserFlaskOfResistance = 6,
      FlaskOfBlindingLight = 7,
      FlaskOfMightyRestoration = 8,
      FlaskOfPureDeath = 9,
      FlaskOfRelentlessAssault = 10,
      FlaskOfSupremePower = 11,
      FlaskOfFortification = 12,
      FlaskOfChromaticWonder = 13
    },
    BattleElixir = {
      BattleElixirUnknown = 0,
      ElixirOfAccuracy = 1,
      ElixirOfArmorPiercing = 2,
      ElixirOfDeadlyStrikes = 3,
      ElixirOfExpertise = 4,
      ElixirOfLightningSpeed = 5,
      ElixirOfMightyAgility = 6,
      ElixirOfMightyStrength = 7,
      GurusElixir = 8,
      SpellpowerElixir = 9,
      WrathElixir = 10,
      AdeptsElixir = 11,
      ElixirOfDemonslaying = 12,
      ElixirOfMajorAgility = 13,
      ElixirOfMajorFirePower = 14,
      ElixirOfMajorFrostPower = 15,
      ElixirOfMajorShadowPower = 16,
      ElixirOfMajorStrength = 17,
      ElixirOfMastery = 18,
      ElixirOfTheMongoose = 19,
      FelStrengthElixir = 20,
      GreaterArcaneElixir = 21
    },
    GuardianElixir = {
      GuardianElixirUnknown = 0,
      ElixirOfMightyDefense = 1,
      ElixirOfMightyFortitude = 2,
      ElixirOfMightyMageblood = 3,
      ElixirOfMightyThoughts = 4,
      ElixirOfProtection = 5,
      ElixirOfSpirit = 6,
      GiftOfArthas = 7,
      ElixirOfDraenicWisdom = 8,
      ElixirOfIronskin = 9,
      ElixirOfMajorDefense = 10,
      ElixirOfMajorFortitude = 11,
      ElixirOfMajorMageblood = 12
    },
    Food = {
      FoodUnknown = 0,
      FoodFishFeast = 1,
      FoodGreatFeast = 2,
      FoodBlackenedDragonfin = 3,
      FoodHeartyRhino = 4,
      FoodMegaMammothMeal = 5,
      FoodSpicedWormBurger = 6,
      FoodRhinoliciousWormsteak = 7,
      FoodImperialMantaSteak = 8,
      FoodSnapperExtreme = 9,
      FoodMightyRhinoDogs = 10,
      FoodFirecrackerSalmon = 11,
      FoodCuttlesteak = 12,
      FoodDragonfinFilet = 13,
      FoodBlackenedBasilisk = 14,
      FoodGrilledMudfish = 15,
      FoodRavagerDog = 16,
      FoodRoastedClefthoof = 17,
      FoodSkullfishSoup = 18,
      FoodSpicyHotTalbuk = 19,
      FoodFishermansFeast = 20
    },
    PetFood = {
      PetFoodUnknown = 0,
      PetFoodSpicedMammothTreats = 1,
      PetFoodKiblersBits = 2
    },
    Potions = {
      UnknownPotion = 0,
      RunicHealingPotion = 1,
      RunicManaPotion = 2,
      IndestructiblePotion = 3,
      PotionOfSpeed = 4,
      PotionOfWildMagic = 5,
      DestructionPotion = 6,
      SuperManaPotion = 7,
      HastePotion = 8,
      MightyRagePotion = 9,
      FelManaPotion = 10,
      InsaneStrengthPotion = 11,
      IronshieldPotion = 12,
      HeroicPotion = 13,
      RunicManaInjector = 14,
      RunicHealingInjector = 15
    },
    Conjured = {
      ConjuredUnknown = 0,
      ConjuredDarkRune = 1,
      ConjuredFlameCap = 2,
      ConjuredHealthstone = 5,
      ConjuredRogueThistleTea = 4
    },
    Explosive = {
      ExplosiveUnknown = 0,
      ExplosiveSaroniteBomb = 1,
      ExplosiveCobaltFragBomb = 2
    },
    InputType = {
      Bool = 0,
      Number = 1
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
      OtherActionBloodRuneGain = 13,
      OtherActionFrostRuneGain = 14,
      OtherActionUnholyRuneGain = 15,
      OtherActionDeathRuneGain = 16,
      OtherActionPotion = 17
    },
    Spec = {
      SpecBalanceDruid = 0,
      SpecFeralDruid = 12,
      SpecFeralTankDruid = 14,
      SpecRestorationDruid = 18,
      SpecElementalShaman = 1,
      SpecEnhancementShaman = 9,
      SpecRestorationShaman = 19,
      SpecHunter = 8,
      SpecMage = 2,
      SpecHolyPaladin = 20,
      SpecProtectionPaladin = 13,
      SpecRetributionPaladin = 3,
      SpecRogue = 7,
      SpecHealingPriest = 17,
      SpecShadowPriest = 4,
      SpecSmitePriest = 10,
      SpecWarlock = 5,
      SpecWarrior = 6,
      SpecProtectionWarrior = 11,
      SpecDeathknight = 15,
      SpecTankDeathknight = 16
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
      ClassDruid = 1,
      ClassHunter = 2,
      ClassMage = 3,
      ClassPaladin = 4,
      ClassPriest = 5,
      ClassRogue = 6,
      ClassShaman = 7,
      ClassWarlock = 8,
      ClassWarrior = 9,
      ClassDeathknight = 10
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
      StatSpirit = 4,
      StatSpellPower = 5,
      StatMP5 = 6,
      StatSpellHit = 7,
      StatSpellCrit = 8,
      StatSpellHaste = 9,
      StatSpellPenetration = 10,
      StatAttackPower = 11,
      StatMeleeHit = 12,
      StatMeleeCrit = 13,
      StatMeleeHaste = 14,
      StatArmorPenetration = 15,
      StatExpertise = 16,
      StatMana = 17,
      StatEnergy = 18,
      StatRage = 19,
      StatArmor = 20,
      StatRangedAttackPower = 21,
      StatDefense = 22,
      StatBlock = 23,
      StatBlockValue = 24,
      StatDodge = 25,
      StatParry = 26,
      StatResilience = 27,
      StatHealth = 28,
      StatArcaneResistance = 29,
      StatFireResistance = 30,
      StatFrostResistance = 31,
      StatNatureResistance = 32,
      StatShadowResistance = 33,
      StatBonusArmor = 34,
      StatRunicPower = 35,
      StatBloodRune = 36,
      StatFrostRune = 37,
      StatUnholyRune = 38,
      StatDeathRune = 39
    },
    PseudoStat = {
      PseudoStatMainHandDps = 0,
      PseudoStatOffHandDps = 1,
      PseudoStatRangedDps = 2,
      PseudoStatBlockValueMultiplier = 3,
      PseudoStatDodge = 4,
      PseudoStatParry = 5
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
    AplType = {
      SingleTarget = 0,
      Aoe = 1
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
    APLValueRuneType = {
      RuneUnknown = 0,
      RuneBlood = 1,
      RuneFrost = 2,
      RuneUnholy = 3,
      RuneDeath = 4
    },
    APLValueRuneSlot = {
      SlotUnknown = 0,
      SlotLeftBlood = 1,
      SlotRightBlood = 2,
      SlotLeftFrost = 3,
      SlotRightFrost = 4,
      SlotLeftUnholy = 5,
      SlotRightUnholy = 6
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
      WindfuryTotem = 2,
      WrathOfAirTotem = 3
    },
    FireTotem = {
      NoFireTotem = 0,
      MagmaTotem = 1,
      SearingTotem = 2,
      TotemOfWrath = 3,
      FlametongueTotem = 4
    },
    WaterTotem = {
      NoWaterTotem = 0,
      ManaSpringTotem = 1,
      HealingStreamTotem = 2
    },
    ShamanMajorGlyph = {
      ShamanMajorGlyphNone = 0,
      GlyphOfChainHeal = 41517,
      GlyphOfChainLightning = 41518,
      GlyphOfEarthShield = 45775,
      GlyphOfEarthlivingWeapon = 41527,
      GlyphOfElementalMastery = 41552,
      GlyphOfFeralSpirit = 45771,
      GlyphOfFireElementalTotem = 41529,
      GlyphOfFireNova = 41530,
      GlyphOfFlameShock = 41531,
      GlyphOfFlametongueWeapon = 41532,
      GlyphOfFrostShock = 41547,
      GlyphOfHealingStreamTotem = 41533,
      GlyphOfHealingWave = 41534,
      GlyphOfHex = 45777,
      GlyphOfLava = 41524,
      GlyphOfLavaLash = 41540,
      GlyphOfLesserHealingWave = 41535,
      GlyphOfLightningBolt = 41536,
      GlyphOfLightningShield = 41537,
      GlyphOfManaTide = 41538,
      GlyphOfRiptide = 45772,
      GlyphOfShocking = 41526,
      GlyphOfStoneclawTotem = 45778,
      GlyphOfStormstrike = 41539,
      GlyphOfThunder = 45770,
      GlyphOfTotemOfWrath = 45776,
      GlyphOfWaterMastery = 41541,
      GlyphOfWindfuryWeapon = 41542
    },
    ShamanMinorGlyph = {
      ShamanMinorGlyphNone = 0,
      GlyphOfAstralRecall = 43381,
      GlyphOfGhostWolf = 43725,
      GlyphOfRenewedLife = 43385,
      GlyphOfThunderstorm = 44923,
      GlyphOfWaterBreathing = 43344,
      GlyphOfWaterShield = 43386,
      GlyphOfWaterWalking = 43388
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
      FlametongueWeaponDownrank = 3,
      FrostbrandWeapon = 4
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
    DruidMajorGlyph = {
      DruidMajorGlyphNone = 0,
      GlyphOfBarkskin = 45623,
      GlyphOfBerserk = 45601,
      GlyphOfClaw = 48720,
      GlyphOfEntanglingRoots = 40924,
      GlyphOfFocus = 44928,
      GlyphOfFrenziedRegeneration = 40896,
      GlyphOfGrowling = 40899,
      GlyphOfHealingTouch = 40914,
      GlyphOfHurricane = 40920,
      GlyphOfInnervate = 40908,
      GlyphOfInsectSwarm = 40919,
      GlyphOfLifebloom = 40915,
      GlyphOfMangle = 40900,
      GlyphOfMaul = 40897,
      GlyphOfMonsoon = 45622,
      GlyphOfMoonfire = 40923,
      GlyphOfNourish = 45603,
      GlyphOfOmenOfClarity = 206580,
      GlyphOfRake = 40903,
      GlyphOfRapidRejuvenation = 50125,
      GlyphOfRebirth = 40909,
      GlyphOfRegrowth = 40912,
      GlyphOfRejuvenation = 40913,
      GlyphOfRip = 40902,
      GlyphOfSavageRoar = 45604,
      GlyphOfShred = 40901,
      GlyphOfStarfall = 40921,
      GlyphOfStarfire = 40916,
      GlyphOfSurvivalInstincts = 46372,
      GlyphOfSwiftmend = 40906,
      GlyphOfWildGrowth = 45602,
      GlyphOfWrath = 40922
    },
    DruidMinorGlyph = {
      DruidMinorGlyphNone = 0,
      GlyphOfAquaticForm = 43316,
      GlyphOfChallengingRoar = 43334,
      GlyphOfDash = 43674,
      GlyphOfTheWild = 43335,
      GlyphOfThorns = 43332,
      GlyphOfTyphoon = 44922,
      GlyphOfUnburdenedRebirth = 43331
    },
    WarriorMajorGlyph = {
      WarriorMajorGlyphNone = 0,
      GlyphOfBarbaricInsults = 43420,
      GlyphOfBladestorm = 45790,
      GlyphOfBlocking = 43425,
      GlyphOfBloodthirst = 43412,
      GlyphOfCleaving = 43414,
      GlyphOfDevastate = 43415,
      GlyphOfEnragedRegeneration = 45794,
      GlyphOfExecution = 43416,
      GlyphOfHamstring = 43417,
      GlyphOfHeroicStrike = 43418,
      GlyphOfIntervene = 43419,
      GlyphOfLastStand = 43426,
      GlyphOfMortalStrike = 43421,
      GlyphOfOverpower = 43422,
      GlyphOfRapidCharge = 43413,
      GlyphOfRending = 43423,
      GlyphOfResonatingPower = 43430,
      GlyphOfRevenge = 43424,
      GlyphOfShieldWall = 45797,
      GlyphOfShockwave = 45792,
      GlyphOfSpellReflection = 45795,
      GlyphOfSunderArmor = 43427,
      GlyphOfSweepingStrikes = 43428,
      GlyphOfTaunt = 43429,
      GlyphOfVictoryRush = 43431,
      GlyphOfVigilance = 45793,
      GlyphOfWhirlwind = 43432
    },
    WarriorMinorGlyph = {
      WarriorMinorGlyphNone = 0,
      GlyphOfBattle = 43395,
      GlyphOfBloodrage = 43396,
      GlyphOfCharge = 43397,
      GlyphOfCommand = 49084,
      GlyphOfEnduringVictory = 43400,
      GlyphOfMockingBlow = 43398,
      GlyphOfThunderClap = 43399,
      GlyphOfShatteringThrow = 206953
    },
    WarriorShout = {
      WarriorShoutNone = 0,
      WarriorShoutBattle = 1,
      WarriorShoutCommanding = 2
    },
    MageMajorGlyph = {
      MageMajorGlyphNone = 0,
      GlyphOfArcaneBarrage = 45738,
      GlyphOfArcaneBlast = 44955,
      GlyphOfArcaneExplosion = 42734,
      GlyphOfArcaneMissiles = 42735,
      GlyphOfArcanePower = 42736,
      GlyphOfBlink = 42737,
      GlyphOfDeepFreeze = 45736,
      GlyphOfEternalWater = 50045,
      GlyphOfEvocation = 42738,
      GlyphOfFireBlast = 42740,
      GlyphOfFireball = 42739,
      GlyphOfFrostNova = 42741,
      GlyphOfFrostbolt = 42742,
      GlyphOfFrostfire = 44684,
      GlyphOfIceArmor = 42743,
      GlyphOfIceBarrier = 45740,
      GlyphOfIceBlock = 42744,
      GlyphOfIceLance = 42745,
      GlyphOfIcyVeins = 42746,
      GlyphOfInvisibility = 42748,
      GlyphOfLivingBomb = 45737,
      GlyphOfMageArmor = 42749,
      GlyphOfManaGem = 42750,
      GlyphOfMirrorImage = 45739,
      GlyphOfMoltenArmor = 42751,
      GlyphOfPolymorph = 42752,
      GlyphOfRemoveCurse = 42753,
      GlyphOfScorch = 42747,
      GlyphOfWaterElemental = 42754
    },
    MageMinorGlyph = {
      MageMinorGlyphNone = 0,
      GlyphOfArcaneIntellect = 43339,
      GlyphOfBlastWave = 44920,
      GlyphOfFireWard = 43357,
      GlyphOfFrostArmor = 43359,
      GlyphOfFrostWard = 43360,
      GlyphOfSlowFall = 43364,
      GlyphOfThePenguin = 43361
    },
    HunterMajorGlyph = {
      HunterMajorGlyphNone = 0,
      GlyphOfAimedShot = 42897,
      GlyphOfArcaneShot = 42898,
      GlyphOfAspectOfTheViper = 42901,
      GlyphOfBestialWrath = 42902,
      GlyphOfChimeraShot = 45625,
      GlyphOfDeterrence = 42903,
      GlyphOfDisengage = 42904,
      GlyphOfExplosiveShot = 45731,
      GlyphOfExplosiveTrap = 45733,
      GlyphOfFreezingTrap = 42905,
      GlyphOfFrostTrap = 42906,
      GlyphOfHuntersMark = 42907,
      GlyphOfImmolationTrap = 42908,
      GlyphOfKillShot = 45732,
      GlyphOfMending = 42900,
      GlyphOfMultiShot = 42910,
      GlyphOfRapidFire = 42911,
      GlyphOfRaptorStrike = 45735,
      GlyphOfScatterShot = 45734,
      GlyphOfSerpentSting = 42912,
      GlyphOfSnakeTrap = 42913,
      GlyphOfSteadyShot = 42914,
      GlyphOfTheBeast = 42899,
      GlyphOfTheHawk = 42909,
      GlyphOfTrueshotAura = 42915,
      GlyphOfVolley = 42916,
      GlyphOfWyvernSting = 42917
    },
    HunterMinorGlyph = {
      HunterMinorGlyphNone = 0,
      GlyphOfFeignDeath = 43351,
      GlyphOfMendPet = 43350,
      GlyphOfPossessedStrength = 43354,
      GlyphOfRevivePet = 43338,
      GlyphOfScareBeast = 43356,
      GlyphOfThePack = 43355
    },
    DeathknightMajorGlyph = {
      DeathknightMajorGlyphNone = 0,
      GlyphOfAntiMagicShell = 43533,
      GlyphOfBloodStrike = 43826,
      GlyphOfBoneShield = 43536,
      GlyphOfChainsOfIce = 43537,
      GlyphOfDancingRuneWeapon = 45799,
      GlyphOfDarkCommand = 43538,
      GlyphOfDarkDeath = 45804,
      GlyphOfDeathAndDecay = 43542,
      GlyphOfDeathGrip = 43541,
      GlyphOfDeathStrike = 43827,
      GlyphOfDisease = 45805,
      GlyphOfFrostStrike = 43543,
      GlyphOfHeartStrike = 43534,
      GlyphOfHowlingBlast = 45806,
      GlyphOfHungeringCold = 45800,
      GlyphOfIceboundFortitude = 43545,
      GlyphOfIcyTouch = 43546,
      GlyphOfObliterate = 43547,
      GlyphOfPlagueStrike = 43548,
      GlyphOfRuneStrike = 43550,
      GlyphOfRuneTap = 43825,
      GlyphOfScourgeStrike = 43551,
      GlyphOfStrangulate = 43552,
      GlyphOfTheGhoul = 43549,
      GlyphOfUnbreakableArmor = 43553,
      GlyphOfUnholyBlight = 45803,
      GlyphOfVampiricBlood = 43554
    },
    DeathknightMinorGlyph = {
      DeathknightMinorGlyphNone = 0,
      GlyphOfBloodTap = 43535,
      GlyphOfCorpseExplosion = 43671,
      GlyphOfDeathSEmbrace = 43539,
      GlyphOfHornOfWinter = 43544,
      GlyphOfPestilence = 43672,
      GlyphOfRaiseDead = 43673
    },
    RogueMajorGlyph = {
      RogueMajorGlyphNone = 0,
      GlyphOfAdrenalineRush = 42954,
      GlyphOfAmbush = 42955,
      GlyphOfBackstab = 42956,
      GlyphOfBladeFlurry = 42957,
      GlyphOfCloakOfShadows = 45769,
      GlyphOfCripplingPoison = 42958,
      GlyphOfDeadlyThrow = 42959,
      GlyphOfEvasion = 42960,
      GlyphOfEviscerate = 42961,
      GlyphOfExposeArmor = 42962,
      GlyphOfFanOfKnives = 45766,
      GlyphOfFeint = 42963,
      GlyphOfGarrote = 42964,
      GlyphOfGhostlyStrike = 42965,
      GlyphOfGouge = 42966,
      GlyphOfHemorrhage = 42967,
      GlyphOfHungerForBlood = 45761,
      GlyphOfKillingSpree = 45762,
      GlyphOfMutilate = 45768,
      GlyphOfPreparation = 42968,
      GlyphOfRupture = 42969,
      GlyphOfSap = 42970,
      GlyphOfShadowDance = 45764,
      GlyphOfSinisterStrike = 42972,
      GlyphOfSliceAndDice = 42973,
      GlyphOfSprint = 42974,
      GlyphOfTricksOfTheTrade = 45767,
      GlyphOfVigor = 42971
    },
    RogueMinorGlyph = {
      RogueMinorGlyphNone = 0,
      GlyphOfBlurredSpeed = 43379,
      GlyphOfDistract = 43376,
      GlyphOfPickLock = 43377,
      GlyphOfPickPocket = 43343,
      GlyphOfSafeFall = 43378,
      GlyphOfVanish = 43380
    },
    WarlockMajorGlyph = {
      WarlockMajorGlyphNone = 0,
      GlyphOfChaosBolt = 45781,
      GlyphOfConflagrate = 42454,
      GlyphOfCorruption = 42455,
      GlyphOfCurseOfAgony = 42456,
      GlyphOfDeathCoil = 42457,
      GlyphOfDemonicCircle = 45782,
      GlyphOfFear = 42458,
      GlyphOfFelguard = 42459,
      GlyphOfFelhunter = 42460,
      GlyphOfHaunt = 45779,
      GlyphOfHealthFunnel = 42461,
      GlyphOfHealthstone = 42462,
      GlyphOfHowlOfTerror = 42463,
      GlyphOfImmolate = 42464,
      GlyphOfImp = 42465,
      GlyphOfIncinerate = 42453,
      GlyphOfLifeTap = 45785,
      GlyphOfMetamorphosis = 45780,
      GlyphOfQuickDecay = 50077,
      GlyphOfSearingPain = 42466,
      GlyphOfShadowBolt = 42467,
      GlyphOfShadowburn = 42468,
      GlyphOfShadowflame = 45783,
      GlyphOfSiphonLife = 42469,
      GlyphOfSoulLink = 45789,
      GlyphOfSoulstone = 42470,
      GlyphOfSuccubus = 42471,
      GlyphOfUnstableAffliction = 42472,
      GlyphOfVoidwalker = 42473
    },
    WarlockMinorGlyph = {
      WarlockMinorGlyphNone = 0,
      GlyphOfCurseOfExhausion = 43392,
      GlyphOfDrainSoul = 43390,
      GlyphOfSubjugateDemon = 43393,
      GlyphOfKilrogg = 43391,
      GlyphOfSouls = 43394,
      GlyphOfUnendingBreath = 43389
    },
    PaladinMajorGlyph = {
      PaladinMajorGlyphNone = 0,
      GlyphOfAvengerSShield = 41101,
      GlyphOfAvengingWrath = 41107,
      GlyphOfBeaconOfLight = 45741,
      GlyphOfCleansing = 41104,
      GlyphOfConsecration = 41099,
      GlyphOfCrusaderStrike = 41098,
      GlyphOfDivinePlea = 45745,
      GlyphOfDivineStorm = 45743,
      GlyphOfDivinity = 41108,
      GlyphOfExorcism = 41103,
      GlyphOfFlashOfLight = 41105,
      GlyphOfHammerOfJustice = 41095,
      GlyphOfHammerOfTheRighteous = 45742,
      GlyphOfHammerOfWrath = 41097,
      GlyphOfHolyLight = 41106,
      GlyphOfHolyShock = 45746,
      GlyphOfHolyWrath = 43867,
      GlyphOfJudgement = 41092,
      GlyphOfRighteousDefense = 41100,
      GlyphOfSalvation = 45747,
      GlyphOfSealOfCommand = 41094,
      GlyphOfSealOfLight = 41110,
      GlyphOfSealOfRighteousness = 43868,
      GlyphOfSealOfVengeance = 43869,
      GlyphOfSealOfWisdom = 41109,
      GlyphOfShieldOfRighteousness = 45744,
      GlyphOfSpiritualAttunement = 41096,
      GlyphOfTurnEvil = 41102,
      GlyphOfReckoning = 204385
    },
    PaladinMinorGlyph = {
      PaladinMinorGlyphNone = 0,
      GlyphOfBlessingOfKings = 43365,
      GlyphOfBlessingOfMight = 43340,
      GlyphOfBlessingOfWisdom = 43366,
      GlyphOfLayOnHands = 43367,
      GlyphOfSenseUndead = 43368,
      GlyphOfTheWise = 43369
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
    PaladinAura = {
      NoPaladinAura = 0,
      DevotionAura = 2,
      RetributionAura = 3
    },
    PaladinSeal = {
      Vengeance = 0,
      Command = 1,
      Righteousness = 2
    },
    PaladinJudgement = {
      JudgementOfWisdom = 0,
      JudgementOfLight = 1,
      NoJudgement = 2
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
      DifficultyNormal = 1,
      DifficultyHeroic = 2,
      DifficultyTitanRuneAlpha = 7,
      DifficultyTitanRuneBeta = 8,
      DifficultyRaid10 = 3,
      DifficultyRaid10H = 4,
      DifficultyRaid25 = 5,
      DifficultyRaid25H = 6
    },
    RepFaction = {
      RepFactionUnknown = 0
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
      SourceDungeonH = 4,
      SourceDungeonTRA = 9,
      SourceDungeonTRB = 10,
      SourceRaid10 = 5,
      SourceRaid10H = 6,
      SourceRaid25 = 7,
      SourceRaid25H = 8
    },
    RaidFilterOption = {
      RaidUnknown = 0,
      RaidVanilla = 1,
      RaidTbc = 2,
      RaidNaxxramas = 3,
      RaidEyeOfEternity = 4,
      RaidObsidianSanctum = 5,
      RaidVaultOfArchavon = 6,
      RaidUlduar = 7,
      RaidTrialOfTheCrusader = 8,
      RaidOnyxiasLair = 9,
      RaidIcecrownCitadel = 10,
      RaidRubySanctum = 11
    },
    ResourceType = {
      ResourceTypeNone = 0,
      ResourceTypeMana = 1,
      ResourceTypeEnergy = 2,
      ResourceTypeRage = 3,
      ResourceTypeComboPoints = 4,
      ResourceTypeFocus = 5,
      ResourceTypeHealth = 6,
      ResourceTypeRunicPower = 7,
      ResourceTypeBloodRune = 8,
      ResourceTypeFrostRune = 9,
      ResourceTypeUnholyRune = 10,
      ResourceTypeDeathRune = 11
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
    }
  }
}
