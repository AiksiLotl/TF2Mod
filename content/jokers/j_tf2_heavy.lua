-- Joker
local joker = {
    object_type = "Joker",
    name = "Heavy Joker",
    pos = {x = 1, y = 1},
    atlas = "tf2_mod_atlas_jokers",
    rarity = 2,
    cost = 6,
    discovered = true,
    config = {Xmult = 2.0, Xmult_mod = 2.0},
    loc_txt = {
        name = "Heavy Joker",
        text = {
            "Create a {C:attention,T:j_gros_michel}Gros Michel{} when obtained",
            "Each time {C:attention,T:j_gros_michel}Gros Michel{} vanishes,",
            "create a new one and gains {X:mult,C:white} X#2# {} Mult",
            "{C:inactive}(Currently {X:mult,C:white} X#1# {C:inactive} Mult)",
            "{C:inactive,s:0.8}Delicious!"
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {
            card.ability.Xmult,
            card.ability.Xmult_mod
        }}
    end,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
-- The function
    calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition then
            print("end_of_round")
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.name == "Gros Michel" then
                    print("banana!")
                    --[[ for k,v in pairs(G.jokers.cards[i].ability) do
                        print(k, v)
                    end
                    if G.jokers.cards[i].removed then
                        print("vanished!")
                    end ]]
                    --[[ if G.jokers.cards[i].states.drag.is then
                        print("vanished!")
                    end ]]
                    G.E_MANAGER:add_event(Event({
                        trigger = "condition",
                        blocking = false, 
                        func = function() 
                            if not G.jokers.cards[i] then
                                G.E_MANAGER:add_event(Event({
                                    trigger = "after",
                                    blocking = false,
                                    func = function()
                                        print("vanished!")
                                        return true
                                    end,
                                }))
                                return true
                            end
                            return false
                        end
                    }))
                end
            end
        end
	end,

    mod_credits = {
		idea = {
			"Aiksi"
		},
		art = {
			"Amy Lily"
		},
		code = {
			"Aiksi"
		}
    }
}

--[[ joker.update = function(self, card)
    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].ability.name == "Gros Michel" then
            print("banana is present!")
            if G.jokers.cards[i].states.drag.is then
                print("vanished!")
            end
        end
    end
end ]]

return joker