local _, data = ...

data.classes = {
    [0] = {
        name = "Consumable",
        subclasses = {
            [-3] = "Temporary Enchantments",
            [ 0] = nil,
            [ 1] = "Potions",
            [ 2] = "Elixirs",
            [ 3] = "Flasks",
            [ 4] = "Scrolls",
            [ 5] = "Food & Drinks",
            [ 6] = "Permanent Enchantments",
            [ 7] = "Bandages",
        },
    },
    [5] = {
        name = "Reagent",
        subclasses = {
            [ 0] = "Reagent",
        },
    },
    [7] = {
        name = "Trade Goods",
        subclasses = {
            [ 0] = nil,
            [ 1] = "Parts",
            [ 2] = "Explosives",
            [ 3] = "Devices",
            [ 5] = "Cloth",
            [ 6] = "Leather",
            [ 7] = "Metal & Stone",
            [ 8] = "Meat",
            [ 9] = "Herbs",
            [12] = "Enchanting",
            [90] = "Gems",
            [91] = "Poison Reagents",
            [92] = "Cooking Ingredients",
            [93] = "Elemental",
        },
    },
}
