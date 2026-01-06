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
})

function Find_Level_Difference() --  Quixote Function
	local highest = 1
	local second_highest = 1
	local highest_key
	local level
	for i, j in pairs(G.GAME.hands) do
		if type(j.level) == "table" then
			level = j.level:to_number()
		else
			level = j.level
		end
		if level > highest then
			highest = level
			highest_key = i
		end
	end
	for i, j in pairs(G.GAME.hands) do
		if type(j.level) == "table" then
			level = j.level:to_number()
		else
			level = j.level
		end
		if level > second_highest and i ~= highest_key then
			second_highest = level
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
				"poker hand and gives {C:money}$5{}" },
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
		local level
		for i, j in pairs(G.GAME.hands) do
		if type(j.level) == "table" then
			level = j.level:to_number()
		else
			level = j.level
		end
			if level > highest then
				highest = level
				highest_key = i
			end
		end
		SMODS.smart_level_up_hand(card, highest_key, false, 1)
		ease_dollars(5)
	end,
})

SMODS.PokerHand({
	key = "Devil's Hand", -- Faust's poker hand
	mult = 1,
	chips = 10,
	l_mult = 1,
	l_chips = 5,
	example = {
		{ "H_3", true },
		{ "C_7", true },
		{ "S_J", true },
		{ "D_A", true },
		{ "S_6", false },
	},
	prefix_config = {
		key = {
			mod = false,
			class = false,
		},
	},
	loc_txt = {
		name = "Devil's Hand",
		description = {
			"4 cards that do not",
			"have any matches in",
			"rank or suit",
		},
	},
	visible = function(self)
		if next(SMODS.find_card("j_hf_faust")) then
			return true
		end
	end,

	evaluate = function(parts, hand)
		if next(SMODS.find_card("j_hf_faust")) then
			local suits = {}
			local ranks = {}
			local scoring_cards = {}

			if #hand < 4 then
				return {}
			end

			for i, v in ipairs(hand) do
				local current_suit = v.base.suit
				local current_rank = v:get_id()

				if v.config.center.key == "m_stone" then
					if Contains(ranks, "stone") == false then
						ranks[#ranks + 1] = "stone"
						scoring_cards[#scoring_cards + 1] = v
					end
				elseif v.config.center.key == "m_wild" and Contains(ranks, current_rank) == false then
					ranks[#ranks + 1] = current_rank
					scoring_cards[#scoring_cards + 1] = v
				elseif Contains(ranks, current_rank) == false and Contains(suits, current_suit) == false then
					ranks[#ranks + 1] = current_rank
					suits[#suits + 1] = current_suit
					scoring_cards[#scoring_cards + 1] = v
				end
			end
			if #scoring_cards < 4 then
				return {}
			else
				return { scoring_cards }
			end
		end
	end,
})

SMODS.Consumable({ -- Faust's planet card
	key = "osiris",
	set = "Planet",
	loc_txt = {
		name = "Osiris",
		text = {
			"[lvl.#1#] Level up",
			"{C:attention}Devil's Hand{}",
			"{C:red}thrice{}",
			"{C:mult}+3{} Mult and",
			"{C:chips}+15{} chips",
		},
	},
	cost = 3,
	atlas = "Consumables",
	pos = { x = 1, y = 0 },
	config = { hand_type = "Devil's Hand", softlock = true },
	in_pool = function(self, args)
		if next(SMODS.find_card("j_hf_faust")) then
			return true
		end
	end,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				G.GAME.hands[card.ability.hand_type].level,
				card.ability.hand_type,
				G.GAME.hands[card.ability.hand_type].l_mult,
				G.GAME.hands[card.ability.hand_type].l_chips,
				colours = {
					(
						G.GAME.hands[card.ability.hand_type].level == 3 and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[card.ability.hand_type].level)]
					),
				},
			},
		}
	end,
	use = function(self, card, area)
		SMODS.smart_level_up_hand(card, "Devil's Hand", nil, 3)
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
	blueprint_compat = false,

	calculate = function(self, card, context)
		if not context.blueprint then
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
		end
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

SMODS.Joker({
	key = "myshkin",
	loc_txt = {
		name = "Myshkin",
		text = {
			"Adds {C:attention}+#1#{} Joker slots",
			"(Not including Myshkin)",
		},
	},
	config = { extra = { slots = 3 } },
	atlas = "Jokers",
	pos = { x = 10, y = 0 },
	soul_pos = { x = 10, y = 1 },
	rarity = 4,
	unlocked = true,
	discovered = true,
	cost = 20,
	blueprint_compat = false,
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.slots } }
	end,

	add_to_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.slots + 1
	end,

	remove_from_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.slots - 1
	end,
})

SMODS.Joker({
	key = "faust",
	loc_txt = {
		name = "Faust",
		text = {
			"Unlocks {C:attention}Devil's Hand{}.",
			"Gain a random {C:tarot}Tarot{}",
			"card when {C:attention}Devil's Hand{}",
			"is played",
		},
	},
	atlas = "Jokers",
	pos = { x = 11, y = 0 },
	soul_pos = { x = 11, y = 1 },
	rarity = 4,
	unlocked = true,
	discovered = true,
	cost = 20,
	blueprint_compat = true,

	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = { key = "j_hf_faust", set = "Other" }
	end,

	set_ability = function(self, card, initial, delay_sprites)
		local faustref = card.config.center
		if type(G.GAME.hands["Devil's Hand"].level) == "table" then
			if G.GAME.hands["Devil's Hand"].level:to_number() > 30 then
				faustref.soul_pos = { x = 11, y = 2 }
				card:set_sprites(faustref)
			else
				faustref.soul_pos = { x = 11, y = 1 }
				card:set_sprites(faustref)
			end
		elseif G.GAME.hands["Devil's Hand"].level > 30 then
			faustref.soul_pos = { x = 11, y = 2 }
			card:set_sprites(faustref)
		else
			faustref.soul_pos = { x = 11, y = 1 }
			card:set_sprites(faustref)
		end
	end,

	calculate = function(self, card, context)
		if context.setting_blind then
			card:set_ability(self, card)
		end

		if context.before and next(context.poker_hands["Devil's Hand"]) then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
			return {
				extra = {
					message = localize("k_plus_tarot"),
					message_card = card,
					func = function()
						G.E_MANAGER:add_event(Event({
							func = function()
								SMODS.add_card({
									set = "Tarot",
									key_append = "hf_faust",
								})
								G.GAME.consumeable_buffer = 0
								return true
							end,
						}))
					end,
				},
			}
		end
	end,
})

SMODS.Joker({
	key = "jigong",
	loc_txt = {
		name = "Ji Gong",
		text = {
			"After each {C:attention}discard{},",
			"{C:attention}hand size{} increases",
			"by the number of {C:attention}discards{}",
			"used this round",
		},
	},
	config = { extra = { cards = 0, hand_size = 0, tick = false } },
	atlas = "Jokers",
	pos = { x = 12, y = 0 },
	soul_pos = { x = 12, y = 1 },
	rarity = 4,
	unlocked = true,
	discovered = true,
	cost = 20,
	blueprint_compat = false,

	calculate = function(self, card, context)
		if not context.blueprint then
			if context.pre_discard then
				card.ability.extra.tick = true
			end

			if context.hand_drawn and card.ability.extra.tick then
				card.ability.extra.cards = card.ability.extra.cards + 1

				for i = 1, card.ability.extra.cards do
					if #G.deck.cards > 0 then
						G.E_MANAGER:add_event(Event({
							func = function()
								draw_card(G.deck, G.hand, 90, "up", true)
								return true
							end,
						}))
					end
				end
				G.hand:change_size(card.ability.extra.cards)
				card.ability.extra.hand_size = card.ability.extra.hand_size + card.ability.extra.cards
				card.ability.extra.tick = false
			end

			if context.end_of_round then
				G.hand:change_size(-card.ability.extra.hand_size)
				card.ability.extra.cards = 0
				card.ability.extra.hand_size = 0
			end
		end
	end,
})

SMODS.Joker({
	key = "havisham",
	loc_txt = {
		name = "Havisham",
		text = {
			"After playing {C:attention}10{} cards of",
			"the same {C:attention}Suit{} in a row ",
			"all cards with that suit give",
			"{X:mult,C:white}X#1#{} mult until",
			"another suit is played",
			"{C:inactive}(Currently {}{C:attention}#2#{} {C:spades}#4#{}{C:hearts}#5#{}{C:clubs}#6#{}{C:diamonds}#7#{}{C:inactive}){}",
		},
	},
	config = { extra = {
		played_cards = 0,
		xmult = 1.75,
		current_suit = "Spades",
	} },
	atlas = "Jokers",
	pos = { x = 13, y = 0 },
	soul_pos = { x = 13, y = 1 },
	rarity = 4,
	unlocked = true,
	discovered = true,
	cost = 20,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, center)
		if center.ability.extra.current_suit == "Spades" then
			return {
				vars = { center.ability.extra.xmult, center.ability.extra.played_cards, "", "Spades", "", "", "" },
			}
		elseif center.ability.extra.current_suit == "Hearts" then
			return {
				vars = { center.ability.extra.xmult, center.ability.extra.played_cards, "", "", "Hearts", "", "" },
			}
		elseif center.ability.extra.current_suit == "Clubs" then
			return {
				vars = { center.ability.extra.xmult, center.ability.extra.played_cards, "", "", "", "Clubs", "" },
			}
		elseif center.ability.extra.current_suit == "Diamonds" then
			return {
				vars = { center.ability.extra.xmult, center.ability.extra.played_cards, "", "", "", "", "Diamonds" },
			}
		end
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card:is_suit(card.ability.extra.current_suit, true) then
				if card.ability.extra.played_cards >= 10 then
					return {
						xmult = card.ability.extra.xmult,
					}
				elseif card.ability.extra.played_cards < 10 then
					card.ability.extra.played_cards = card.ability.extra.played_cards + 1
					if card.ability.extra.played_cards == 10 then
						return { message_card = card, message = card.ability.extra.current_suit .. "!" }
					else
						return
					end
				end
			else
				card.ability.extra.current_suit = context.other_card.base.suit
				if card.ability.extra.played_cards >= 5 then
					card.ability.extra.played_cards = 1
					return {
						message_card = card,
						message = "Reset",
						colour = G.C.RED,
					}
				else
					card.ability.extra.played_cards = 1
					return
				end
			end
		end
	end,
})

SMODS.Joker({
	key = "icarus",
	loc_txt = {
		name = "Icarus",
		text = {
			"Gains {X:mult,C:white}X1{} Mult for",
			"every played {C:attention}seal{}",
			"on {C:attention}final hand{},",
			"{C:green}1 in #2# chance{}",
			"to destroy scored card",
			"{C:inactive}Currently {}{X:mult,C:white}X#1#{}{C:inactive} Mult{}",
		},
	},
	config = { extra = {
		tick = false,
		xmult = 1,
		odds = 2,
	} },
	atlas = "Jokers",
	pos = { x = 14, y = 0 },
	soul_pos = { x = 14, y = 1 },
	rarity = 4,
	unlocked = true,
	discovered = true,
	cost = 20,
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.xmult, center.ability.extra.odds } }
	end,
	blueprint_compat = true,

	calculate = function(self, card, context)
		if G.GAME.current_round.hands_left == 0 then
			if context.individual and context.cardarea == G.play then
				if context.other_card.seal ~= nil then
					card.ability.extra.xmult = card.ability.extra.xmult + 1
					return {
						message = localize("k_upgrade_ex"),
						colour = G.C.MULT,
					}
				end
			end

			if context.destroying_card and context.cardarea == G.play then
				if
					context.destroying_card.seal ~= nil
					and pseudorandom("Icarus") < G.GAME.probabilities.normal / card.ability.extra.odds
				then
					return { remove = true }
				end
			end
		end

		if context.joker_main then
			return { xmult = card.ability.extra.xmult }
		end
	end,
})