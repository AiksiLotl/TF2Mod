--- STEAMODDED HEADER
--- MOD_NAME: TF2Mod
--- MOD_ID: tf2mod
--- MOD_AUTHOR: [Aiksi, Amy Lily, Rufia]
--- MOD_DESCRIPTION: TF2 themed Jokers!
--- BADGE_COLOUR: fda200
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-1326a]
--- VERSION: 0.1

----------------------------------------------
------------MOD CODE -------------------------

local joker_list = {
    --- Uncommon
    "j_tf2_heavy",
    --- Rare
    "j_tf2_scout",
}

local deck_list = {

}

-- Jokers Atlas
SMODS.Atlas {
	key = "tf2_mod_atlas_jokers",
	path = "tf2_mod_atlas_jokers.png",
	px = 71,
	py = 95,
}

-- Decks Atlas
SMODS.Atlas {
	key = "tf2_mod_atlas_decks",
	path = "tf2_mod_atlas_decks.png",
	px = 71,
	py = 95,
}

-- Load all jokers
for _, v in ipairs(joker_list) do
    local joker = SMODS.load_file("content/jokers/" .. v .. ".lua")()

    --joker.discovered = true
    if joker.dependency and not (SMODS.Mods[joker.dependency] or {}).can_load then goto continue end
    if joker.antidependency and (SMODS.Mods[joker.antidependency] or {}).can_load then goto continue end
    joker.key = v

    if not joker.pos then
        joker.pos = { x = 0, y = 0 }
    end

    local joker_obj = SMODS.Joker(joker)

    for k_, v_ in pairs(joker) do
        if type(v_) == 'function' then
            joker_obj[k_] = joker[k_]
        end
    end

    ::continue::
end

-- Load all decks
for _, v in ipairs(deck_list) do
    local deck = SMODS.load_file("content/decks/" .. v .. ".lua")()

    if deck.dependency and not (SMODS.Mods[deck.dependency] or {}).can_load then goto continue end
    if deck.antidependency and (SMODS.Mods[deck.antidependency] or {}).can_load then goto continue end
    deck.key = v

    if not deck.pos then
        deck.pos = { x = 0, y = 0 }
    end

    local deck_obj = SMODS.Back(deck)

    for k_, v_ in pairs(deck) do
        if type(v_) == 'function' then
            deck_obj[k_] = deck[k_]
        end
    end

    ::continue::
end


----------------------------------------------
------------MOD CODE END----------------------