SMODS.Atlas({
	key = "Jokers",
	path = "Jokers.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "Consumables",
	path = "Consumables.png",
	px = 71,
	py = 95,
})

SMODS.Sound ({
	key = "bell",
	path = "bell.ogg",
}
)

function Find_Level_Difference() --  Quixote Function
	local highest = 1
	local second_highest = 1
	local highest_key
	for i, j in pairs(G.GAME.hands) do
		if j.level > highest then
			highest = j.level
			highest_key = i
		end
	end
	for i, j in pairs(G.GAME.hands) do
		if j.level > second_highest and i ~= highest_key then
			second_highest = j.level
		end
	end

	return highest - second_highest
end

SMODS.Consumable({ -- Pierre's tarot card
	key = "great_comet",
	set = "Tarot",
	loc_txt = {
		name = "The Great Comet",
		text = { "Upgrades your highest level",
				"poker hand and gives {C:money)$5{}" },
	},
	cost = 3,
	in_pool = function(self)
		if next(SMODS.find_card("j_hf_pierre")) then
			return true
		end
	end,
	can_use = function(self, card)
		return true
	end,
	atlas = "Consumables",
	pos = { x = 0, y = 0 },
	use = function(self, card, area, copier)
		local highest = 1
		local highest_key = "High Card"
		for i, j in pairs(G.GAME.hands) do
			if j.level > highest then
				highest = j.level
				highest_key = i
			end
		end
		SMODS.smart_level_up_hand(card, highest_key, false, 1)
		ease_dollars(5)
	end,
})

SMODS.Joker({
	key = "quixote",
	loc_txt = {
		name = "Quixote",
		text = {
			"{X:mult,C:white}X#1#{} Mult for each",
			"level between highest",
			"level poker hand",
			"and second highest",
			"{C:inactive}(Currently {}{X:mult,C:white}X#2#{}{C:inactive} Mult){}",
		},
	},
	config = {
		extra = {
			Xmult = 1,
			exponent = 0.5,
		},
	},
	atlas = "Jokers",
	pos = { x = 0, y = 0 },
	soul_pos = { x = 0, y = 1 },
	rarity = 4,
	unlocked = true,
	discovered = true,
	cost = 20,
	blueprint_compat = true,

	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.exponent, 1 + center.ability.extra.exponent * Find_Level_Difference() } }
	end,

	calculate = function(self, card, context)
		if context.joker_main then
			return {
				xmult = 1 + (card.ability.extra.exponent * Find_Level_Difference()),
			}
		end
	end,
})

SMODS.Joker({
	key = "tam",
	loc_txt = {
		name = "Tam",
		text = {
			"The first {C:attention}2{} you draw",
			"each round permanently",
			"adds {C:mult}+#1#{} Mult to all",
			"cards in hand",
		},
	},
	config = {
		extra = {
			mult = 2,
			cutty_sark = true,
		},
	},
	atlas = "Jokers",
	pos = { x = 1, y = 0 },
	soul_pos = { x = 1, y = 1 },
	rarity = 4,
	unlocked = true,
	discovered = true,
	cost = 20,
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.mult } }
	end,
	blueprint_compat = true,

	calculate = function(self, card, context)
		if context.hand_drawn and card.ability.extra.cutty_sark then
			local tick
			for i, v in ipairs(G.hand.cards) do
				if v:get_id() == 2 then
					tick = true
					card.ability.extra.cutty_sark = false
				end
			end

			if tick then
				for i, v in ipairs(G.hand.cards) do
					v.ability.perma_mult = v.ability.perma_mult or 0
					v.ability.perma_mult = v.ability.perma_mult + card.ability.extra.mult
					v:juice_up(0.3, 0.5)
				end
				tick = false
				return { message = localize("k_upgrade_ex"), colour = G.C.MULT }
			end
		end

		if context.end_of_round then
			card.ability.extra.cutty_sark = true
		end
	end,
})

SMODS.Joker({
	key = "ophelia",
	loc_txt = {
		name = "Ophelia",
		text = {
			"Replenishes your {C:blue}hands{}",
			"or {C:red}discards{} by {C:attention}1{}",
			"if they reach 0",
			"{C:inactive}(Can do {}{C:attention}#1#{}{C:inactive} more times){}",
		},
	},
	atlas = "Jokers",
	pos = { x = 2, y = 0 },
	soul_pos = { x = 2, y = 1 },
	config = { extra = {
		replenishments = 10,
		tick = false,
		hand_tick = false,
		discard_tick = false
	} },
	rarity = 4,
	unlocked = true,
	discovered = true,
	cost = 20,
	blueprint_compat = false,
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.replenishments } }
	end,
	calculate = function(self, card, context)

	if context.before and G.GAME.current_round.hands_left == 0 and not card.ability.extra.hand_tick then
		card.ability.extra.hand_tick = true
	end
	if G.GAME.current_round.discards_left == 0 and not card.ability.extra.discard_tick then
		card.ability.extra.discard_tick = true
	end

	if not context.blueprint then

		if context.after and card.ability.extra.hand_tick then
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				func = function()
					card.ability.extra.hand_tick = false
					if G.GAME.chips < G.GAME.blind.chips then
						card_eval_status_text(card, 'jokers', nil, nil, nil, {message = '+1', colour = G.C.BLUE})
						card.ability.extra.hand_tick = false
						card.ability.extra.replenishments = card.ability.extra.replenishments - 1
						ease_hands_played(1, 1)
					end
					return true
				end,
			}))
		end
	end

		if context.hand_drawn and card.ability.extra.discard_tick then
			card.ability.extra.discard_tick = false
			card.ability.extra.replenishments = card.ability.extra.replenishments - 1
			G.E_MANAGER:add_event(Event({
				func = function()
					card_eval_status_text(card, "jokers", nil, nil, nil, { message = '+1', colour = G.C.RED })
					ease_discard(1, 1)
					return true
				end,
			}))
		end

	if card.ability.extra.replenishments <= 0 then
		if context.hand_drawn or context.end_of_round then
			G.E_MANAGER:add_event(Event({
				func = function()
					card_eval_status_text(card, "jokers", nil, nil, nil, { message = "Spent!", colour = G.C.RED })
					card:start_dissolve({ G.C.RED }, card)
					play_sound("whoosh2")
					return true
				end,
			}))
		end
	end
		
	end,
})

SMODS.Joker({
	key = "ivan",
	loc_txt = {
		name = "Ivan",
		text = {
			"When you choose to skip a",
			"round, you receive the {C:attention}tag{},",
			"but don't skip",
		},
	},
	atlas = "Jokers",
	pos = { x = 3, y = 0 },
	soul_pos = { x = 3, y = 1 },
	rarity = 4,
	unlocked = true,
	discovered = true,
	cost = 20,
	blueprint_compat = false,

	calculate = function(self, card, context)
		if context.skip_blind and not context.blueprint then
			G.E_MANAGER:add_event(Event({
				func = function()
					card_eval_status_text(card, "jokers", nil, nil, nil, { message = "No Skip", colour = G.C.RED })
					G.E_MANAGER:add_event(Event({
						delay = 0.2,
						func = function()
							G.GAME.hf_ivan_used = G.GAME.blind_on_deck
							save_run()
							return true
						end,
					}))
					return true
				end,
			}))
		end
	end,
})

SMODS.Joker({
	key = "falstaff",
	loc_txt = {
		name = "Falstaff",
		text = {
			"{C:chips}+500{} Chips,",
			"{C:chips}-50{} Chips per {C:money}$5{} owned",
			"at start of round",
			"{C:inactive}(Currently {}{C:chips}+#1#{}{C:inactive} Chips){}",
		},
	},
	config = { extra = {
		chips = 500,
		deduction = 0,
	} },
	atlas = "Jokers",
	pos = { x = 4, y = 0 },
	soul_pos = { x = 4, y = 1 },
	rarity = 4,
	unlocked = true,
	discovered = true,
	cost = 20,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, center)
		if G.STATE == G.STATES.SHOP or G.STATE == G.STATES.BLIND_SELECT then
			return { vars = { 500 - (50 * math.floor(G.GAME.dollars / 5)) } }
		else
			return { vars = { center.ability.extra.chips } }
		end
	end,
	calculate = function(self, card, context)
		if context.setting_blind then
			local set_chip_deduction = 50 * (math.floor(G.GAME.dollars / 5))
			card.ability.extra.chips = 500 - set_chip_deduction
		end

		if context.joker_main then
			return {
				chips = card.ability.extra.chips,
			}
		end
	end,
})

SMODS.Joker({
	key = "quasimodo",
	loc_txt = {
		name = "Quasimodo",
		text = {
			"Retrigger all cards",
			"with {C:hearts}Hearts{} suit",
			"or {C:clubs}Clubs{} suit,",
			"{C:green}#1# in #2# chance{} to",
			"retrigger twice",
		},
	},
	config = {
		extra = {
			repetition_chance = 4,
		},
	},
	atlas = "Jokers",
	pos = { x = 5, y = 0 },
	soul_pos = { x = 5, y = 1 },
	rarity = 4,
	unlocked = true,
	discovered = true,
	cost = 20,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, center)
		return { vars = { G.GAME.probabilities.normal, center.ability.extra.repetition_chance } }
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.repetition and not context.repetition_only then
			if context.other_card:is_suit("Hearts", true) or context.other_card:is_suit("Clubs", true) then
				return {
					repetitions = pseudorandom("Quasimodo")
								< G.GAME.probabilities.normal / card.ability.extra.repetition_chance
							and 2
						or 1,
						sound = "hf_bell",
						pitch = math.random(),
						volume = 0.3
				}
			end
		end
	end,
})

SMODS.Joker({
	key = "pierre",
	loc_txt = {
		name = "Pierre",
		text = {
			"When a {C:blue}Blue{} or {C:purple}Purple{} seal",
			"triggers, {C:green}#1# in 2 chance{}",
			"to gain a {C:planet}Meteor{}, {C:tarot}Charm{}",
			"or {C:spectral}Ethereal{} Tag",
		},
	},
	config = {
		extra = {
			odds = 2,
			tags = {
				[1] = "tag_charm",
				[2] = "tag_meteor",
				[3] = "tag_ethereal",
			},
		},
	},
	atlas = "Jokers",
	pos = { x = 6, y = 0 },
	soul_pos = { x = 6, y = 1 },
	rarity = 4,
	unlocked = true,
	discovered = true,
	cost = 20,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, center)
		return { vars = { G.GAME.probabilities.normal } }
	end,

	calculate = function(self, card, context)
		if context.discard then
			if
				context.other_card.seal == "Purple"
				and pseudorandom("Pierre") < G.GAME.probabilities.normal / card.ability.extra.odds
			then
				G.E_MANAGER:add_event(Event({
					func = function()
						add_tag(Tag(pseudorandom_element(card.ability.extra.tags, pseudoseed("Pierre"))))
						play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
						play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
						return true
					end,
				}))
			end
		end
		if context.end_of_round and context.cardarea == G.hand and context.repetition then
			if
				context.other_card.seal == "Blue"
				and pseudorandom("Pierre") < G.GAME.probabilities.normal / card.ability.extra.odds
			then
				G.E_MANAGER:add_event(Event({
					func = function()
						add_tag(Tag(pseudorandom_element(card.ability.extra.tags, pseudoseed("Pierre"))))
						play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
						play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
						return true
					end,
				}))
			end
		end
	
	end,
})

SMODS.Joker({
	key = "rakewell",
	loc_txt = {
		name = "Rakewell",
		text = {
			"Earn {C:money}$#1#{} at the",
			"end of the round,",
			"{C:red}-$1{} for every",
			"consumable used",
		},
	},
	config = { extra = { dollars = 20 } },
	atlas = "Jokers",
	pos = { x = 7, y = 0 },
	soul_pos = { x = 7, y = 1 },
	rarity = 4,
	unlocked = true,
	discovered = true,
	cost = 20,
	blueprint_compat = false,
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.dollars } }
	end,

	calculate = function(self, card, context)
		if context.using_consumeable and not context.blueprint then
			card.ability.extra.dollars = card.ability.extra.dollars - 1
			if card.ability.extra.dollars <= 0 then
				G.E_MANAGER:add_event(Event({
					func = function()
						card_eval_status_text(card, "jokers", nil, nil, nil, { message = "Spent!", colour = G.C.RED })
						card:start_dissolve({ G.C.RED }, card)
						play_sound("whoosh2")
						return true
					end,
				}))
			else
				return {
					card = card,
					message = "-1",
					colour = G.C.RED,
				}
			end
		end
	end,
	calc_dollar_bonus = function(self, card)
		return card.ability.extra.dollars
	end,
})

SMODS.Joker({
	key = "alice",
	loc_txt = {
		name = "Alice",
		text = {
			"Copies the ability of",
			"{C:attention}Joker{} to right and left.",
			"{C:red}-1{} hand size",
		},
	},

	config = { extra = {
		hand_size_deduction = 1,
	} },
	atlas = "Jokers",
	pos = { x = 8, y = 0 },
	soul_pos = { x = 8, y = 1 },
	rarity = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,

	calculate = function(self, card, context)
		local current_index
		for i = 1, #G.jokers.cards do
			if G.jokers.cards[i] == card then
				current_index = i
				break
			end
		end
		local left_ret = SMODS.blueprint_effect(card, G.jokers.cards[current_index - 1], context)
		local right_ret = SMODS.blueprint_effect(card, G.jokers.cards[current_index + 1], context)
		return SMODS.merge_effects({ left_ret or {}, right_ret or {} })
	end,

	add_to_deck = function(self, card, from_debuff)
		G.hand:change_size(-card.ability.extra.hand_size_deduction)
	end,

	remove_from_deck = function(self, card, from_debuff)
		G.hand:change_size(card.ability.extra.hand_size_deduction)
	end,
})

SMODS.Joker({
	key = "pandora",
	loc_txt = {
		name = "Pandora",
		text = {
			"Shuffle {C:attention}#1#{} copies of random cards in",
			"your {C:attention}first draw{} into the deck.",
			"The {C:attention}first discard{} destroys",
			"all selected cards",
		},
	},
	config = {
		extra = {
			first_discard = true,
			first_draw = true,
			tick = false,
			copies = 4,
		},
	},
	atlas = "Jokers",
	pos = { x = 9, y = 0 },
	soul_pos = { x = 9, y = 1 },
	rarity = 4,
	unlocked = true,
	discovered = true,
	cost = 20,
	blueprint_compat = false,
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.copies } }
	end,

	calculate = function(self, card, context)
		if context.hand_drawn and card.ability.extra.first_draw and not context.blueprint then
			local cards_to_copy = {}
			for i = 1, card.ability.extra.copies do
				cards_to_copy[#cards_to_copy + 1] = pseudorandom_element(G.hand.cards, "Pandora")
			end
			G.E_MANAGER:add_event(Event({
				func = function()
					for i, v in ipairs(cards_to_copy) do
						G.playing_card = (G.playing_card and G.playing_card + 1) or 1
						local new_card = copy_card(v, nil, nil, G.playing_card)
						new_card:add_to_deck()
						G.deck.config.card_limit = G.deck.config.card_limit + 1
						G.deck:emplace(new_card)
						table.insert(G.playing_cards, new_card)
						playing_card_joker_effects({ true })
						G.E_MANAGER:add_event(Event({
							func = function()
								new_card:start_materialize()
								return true
							end,
						}))
						v:juice_up(0.3, 0.5)
					end
					return true
				end,
			}))
			card.ability.extra.first_draw = false
			return { message = "Copied!", colour = G.C.ATTENTION }
		end

		if context.pre_discard and not context.blueprint then
			if card.ability.extra.first_discard then
				card.ability.extra.tick = true
				card.ability.extra.first_discard = false
				return {
					message = "Destroyed",
					colour = G.C.RED,
				}
			else
				card.ability.extra.tick = false
			end
		end

		if context.discard and card.ability.extra.tick then
			return { remove = true }
		end

		if context.end_of_round then
			card.ability.extra.first_draw = true
			card.ability.extra.first_discard = true
		end
	end,

})
