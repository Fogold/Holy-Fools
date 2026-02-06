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

SMODS.Atlas({
	key = "Enhancements",
	path = "Enhancements.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "Blinds",
	path = "Blinds.png",
	px = 34,
	py = 34,
	frames = 21,
	atlas_table = "ANIMATION_ATLAS",
})

SMODS.Atlas({
	key = "Vouchers",
	path = "Vouchers.png",
	px = 71,
	py = 95,
})

SMODS.Sound({
	key = "bell",
	path = "bell.ogg",
})

SMODS.Joker:take_ownership("gluttenous_joker", {
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card:is_suit("Clubs", true) or rank_bypass(context.other_card) then
				return {
					mult = 3,
				}
			end
		end
	end,
}, true)

SMODS.Joker:take_ownership("greedy_joker", {
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card:is_suit("Diamonds", true) or rank_bypass(context.other_card) then
				return {
					mult = 3,
				}
			end
		end
	end,
}, true)

SMODS.Joker:take_ownership("lusty_joker", {
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card:is_suit("Hearts", true) or rank_bypass(context.other_card) then
				return {
					mult = 3,
				}
			end
		end
	end,
}, true)

SMODS.Joker:take_ownership("wrathful_joker", {
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card:is_suit("Clubs", true) or rank_bypass(context.other_card) then
				return {
					mult = 3,
				}
			end
		end
	end,
}, true)

SMODS.Joker:take_ownership("onyx_agate", {
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card:is_suit("Clubs", true) or rank_bypass(context.other_card) then
				return {
					mult = 7,
				}
			end
		end
	end,
}, true)

SMODS.Joker:take_ownership("rough_gem", {
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card:is_suit("Diamonds", true) or rank_bypass(context.other_card) then
				return {
					dollars = 1,
				}
			end
		end
	end,
}, true)

SMODS.Joker:take_ownership("arrowhead", {
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card:is_suit("Spades", true) or rank_bypass(context.other_card) then
				return {
					chips = 50,
				}
			end
		end
	end,
}, true)

SMODS.Joker:take_ownership("bloodstone", {
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if
				(context.other_card:is_suit("Hearts", true) or rank_bypass(context.other_card))
				and pseudorandom("bloodstone") < G.GAME.probabilities.normal / 2
			then
				return {
					xmult = 1.5,
				}
			end
		end
	end,
}, true)

SMODS.Joker:take_ownership("ancient", {
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if
				context.other_card:is_suit(G.GAME.current_round.ancient_card.suit, true)
				or rank_bypass(context.other_card)
			then
				return {
					xmult = 1.5,
				}
			end
		end
	end,
}, true)

SMODS.Joker:take_ownership("flower_pot", {
	calculate = function(self, card, context)
		if context.joker_main then
			local suits = {
				["Hearts"] = 0,
				["Diamonds"] = 0,
				["Spades"] = 0,
				["Clubs"] = 0,
			}
			for i = 1, #context.scoring_hand do
				if SMODS.has_any_suit(context.scoring_hand[i]) then
					if
						(context.scoring_hand[i]:is_suit("Hearts") or rank_bypass(context.scoring_hand[i]))
						and suits["Hearts"] == 0
					then
						suits["Hearts"] = suits["Hearts"] + 1
					elseif
						(context.scoring_hand[i]:is_suit("Diamonds") or rank_bypass(context.scoring_hand[i]))
						and suits["Diamonds"] == 0
					then
						suits["Diamonds"] = suits["Diamonds"] + 1
					elseif
						(context.scoring_hand[i]:is_suit("Spades") or rank_bypass(context.scoring_hand[i]))
						and suits["Spades"] == 0
					then
						suits["Spades"] = suits["Spades"] + 1
					elseif
						(context.scoring_hand[i]:is_suit("Clubs") or rank_bypass(context.scoring_hand[i]))
						and suits["Clubs"] == 0
					then
						suits["Clubs"] = suits["Clubs"] + 1
					end
				end
			end
			for i = 1, #context.scoring_hand do
				if SMODS.has_any_suit(context.scoring_hand[i]) then
					if
						(context.scoring_hand[i]:is_suit("Hearts") or rank_bypass(context.scoring_hand[i]))
						and suits["Hearts"] == 0
					then
						suits["Hearts"] = suits["Hearts"] + 1
					elseif
						(context.scoring_hand[i]:is_suit("Diamonds") or rank_bypass(context.scoring_hand[i]))
						and suits["Diamonds"] == 0
					then
						suits["Diamonds"] = suits["Diamonds"] + 1
					elseif
						(context.scoring_hand[i]:is_suit("Spades") or rank_bypass(context.scoring_hand[i]))
						and suits["Spades"] == 0
					then
						suits["Spades"] = suits["Spades"] + 1
					elseif
						(context.scoring_hand[i]:is_suit("Clubs") or rank_bypass(context.scoring_hand[i]))
						and suits["Clubs"] == 0
					then
						suits["Clubs"] = suits["Clubs"] + 1
					end
				end
			end
			if suits["Hearts"] > 0 and suits["Diamonds"] > 0 and suits["Spades"] > 0 and suits["Clubs"] > 0 then
				return {
					xmult = 3,
				}
			end
		end
	end,
}, true)

SMODS.Joker:take_ownership("blackboard", {
	calculate = function(self, card, context)
		if context.joker_main then
			local all_black_suits = true
			for _, playing_card in ipairs(G.hand.cards) do
				if
					not playing_card:is_suit("Clubs", nil, true)
					and not playing_card:is_suit("Spades", nil, true)
					and not rank_bypass(playing_card)
				then
					all_black_suits = false
					break
				end
			end
			if all_black_suits then
				return {
					xmult = 3,
				}
			end
		end
	end,
}, true)

SMODS.Joker:take_ownership("seeing_double", {
	calculate = function(self, card, context)
		if context.joker_main then
			local has_non_club = false
			local has_club = false
			for i = 1, #context.scoring_hand do
				if SMODS.has_any_suit(context.scoring_hand[i]) then
					if context.scoring_hand[i]:is_suit("Clubs") or rank_bypass(context.scoring_hand[i]) then
						has_club = true
					elseif
						context.scoring_hand[i]:is_suit("Clubs") == false
						or rank_bypass(context.scoring_hand[i]) == false
					then
						has_non_club = true
					end
				end
			end
			if has_club and has_non_club then
				return {
					xmult = 2,
				}
			end
		end
	end,
}, true)

SMODS.Joker:take_ownership("even_steven", {
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if
				(
					context.other_card:get_id() <= 10
					and context.other_card:get_id() >= 0
					and context.other_card:get_id() % 2 == 0
				) or rank_bypass(context.other_card)
			then
				return {
					mult = 4,
				}
			end
		end
	end,
}, true)

SMODS.Joker:take_ownership("odd_todd", {
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if
				(
					context.other_card:get_id() == 14
					or context.other_card:get_id() % 2 == 1
					or rank_bypass(context.other_card)
				)
				and context.other_card:get_id() ~= 13
				and context.other_card:get_id() ~= 11
			then
				return {
					chips = 31,
				}
			end
		end
	end,
}, true)

SMODS.Joker:take_ownership("baron", {
	calculate = function(self, card, context)
		if
			context.individual
			and context.cardarea == G.hand
			and context.cardarea ~= G.play
			and not context.end_of_round
		then
			if context.other_card:get_id() == 13 or rank_bypass(context.other_card) then
				return {
					xmult = 1.5,
				}
			end
		end
	end,
}, true)

SMODS.Joker:take_ownership("sixth_sense", {
	calculate = function(self, card, context)
		if context.destroying_card and not context.blueprint then
			if
				#context.full_hand == 1
				and (context.full_hand[1]:get_id() == 6 or rank_bypass(context.full_hand[1]))
				and not context.full_hand[1].sixth_sense
				and G.GAME.current_round.hands_played == 0
			then
				context.full_hand[1].sixth_sense = true
				if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
					G.E_MANAGER:add_event(Event({
						trigger = "before",
						delay = 0.0,
						func = function()
							local card = create_card("Spectral", G.consumeables, nil, nil, nil, nil, nil, "sixth")
							card:add_to_deck()
							G.consumeables:emplace(card)
							G.GAME.consumeable_buffer = 0
							return true
						end,
					}))
					card_eval_status_text(
						self,
						"extra",
						nil,
						nil,
						nil,
						{ message = localize("k_plus_spectral"), colour = G.C.SECONDARY_SET.Spectral }
					)
				end
				return { remove = true }
			end
		end
	end,
}, true)

SMODS.Joker:take_ownership("mail", {
	calculate = function(self, card, context)
		if context.discard then
			if context.other_card:get_id() == G.GAME.current_round.mail_card.id or rank_bypass(context.other_card) then
				return {
					dollars = 5,
				}
			end
		end
	end,
}, true)

SMODS.Joker:take_ownership("8_ball", {
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if
				(context.other_card:get_id() == 8 or rank_bypass(context.other_card))
				and pseudorandom("8_ball") < G.GAME.probabilities.normal / 4
			then
				if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
					G.E_MANAGER:add_event(Event({
						trigger = "before",
						delay = 0.0,
						func = function()
							local card = create_card("Tarot", G.consumeables, nil, nil, nil, nil, nil, "8_ball")
							card:add_to_deck()
							G.consumeables:emplace(card)
							G.GAME.consumeable_buffer = 0
							return true
						end,
					}))
					card_eval_status_text(
						self,
						"extra",
						nil,
						nil,
						nil,
						{ message = localize("k_plus_tarot"), colour = G.C.SECONDARY_SET.Tarot }
					)
				end
			end
		end
	end,
}, true)

SMODS.Joker:take_ownership("idol", {
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if
				(
					context.other_card:get_id() == G.GAME.current_round.idol_card.id
					and context.other_card:is_suit(G.GAME.current_round.idol_card.suit)
				) or rank_bypass(context.other_card)
			then
				return {
					x_mult = 2,
				}
			end
		end
	end,
}, true)

SMODS.Joker:take_ownership("hack", {
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.repetition and not context.repetition_only then
			if
				context.other_card:get_id() == 2
				or context.other_card:get_id() == 3
				or context.other_card:get_id() == 4
				or context.other_card:get_id() == 5
				or rank_bypass(context.other_card)
			then
				return {
					repetitions = 1,
				}
			end
		end
	end,
}, true)

SMODS.Joker:take_ownership("fibonacci", {
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if
				context.other_card:get_id() == 14
				or context.other_card:get_id() == 2
				or context.other_card:get_id() == 3
				or context.other_card:get_id() == 5
				or context.other_card:get_id() == 8
				or rank_bypass(context.other_card)
			then
				return {
					mult = 8,
				}
			end
		end
	end,
}, true)

SMODS.Joker:take_ownership("walkie_talkie", {
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if
				context.other_card:get_id() == 10
				or context.other_card:get_id() == 4
				or rank_bypass(context.other_card)
			then
				return {
					chips = 10,
					mult = 4,
				}
			end
		end
	end,
}, true)

SMODS.Joker:take_ownership("scholar", {
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card:get_id() == 14 or rank_bypass(context.other_card) then
				return {
					chips = 20,
					mult = 4,
				}
			end
		end
	end,
}, true)

SMODS.Joker:take_ownership("shoot_the_moon", {
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.hand and context.end_of_round ~= true then
			if context.other_card:get_id() == 12 or rank_bypass(context.other_card) then
				return {
					mult = 13,
				}
			end
		end
	end,
}, true)

SMODS.Joker:take_ownership("triboulet", {
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.hand and not context.cardarea == G.play then
			if
				context.other_card:get_id() == 12
				or context.other_card:get_id() == 13
				or rank_bypass(context.other_card)
			then
				return {
					xmult = 2,
				}
			end
		end
	end,
}, true)

function Reset_Blinds_After_Bloom()
	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 0.3,
		func = function()
			local par = G.blind_select_opts.big.parent

			G.blind_select_opts.big:remove()
			G.blind_select_opts.big = UIBox({
				T = { par.T.x, 0, 0, 0 },
				definition = {
					n = G.UIT.ROOT,
					config = { align = "cm", colour = G.C.CLEAR },
					nodes = {
						UIBox_dyn_container(
							{ create_UIBox_blind_choice("Big") },
							false,
							get_blind_main_colour("Big"),
							mix_colours(G.C.BLACK, get_blind_main_colour("Big"), 0.8)
						),
					},
				},
				config = {
					align = "bmi",
					offset = { x = 0, y = G.ROOM.T.y + 9 },
					major = par,
					xy_bond = "Weak",
				},
			})
			par.config.object = G.blind_select_opts.big
			par.config.object:recalculate()
			G.blind_select_opts.big.parent = par
			G.blind_select_opts.big.alignment.offset.y = 0

			save_run()
			return true
		end,
	}))

	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 0.3,
		func = function()
			local par = G.blind_select_opts.small.parent

			G.blind_select_opts.small:remove()
			G.blind_select_opts.small = UIBox({
				T = { par.T.x, 0, 0, 0 },
				definition = {
					n = G.UIT.ROOT,
					config = { align = "cm", colour = G.C.CLEAR },
					nodes = {
						UIBox_dyn_container(
							{ create_UIBox_blind_choice("Small") },
							false,
							get_blind_main_colour("Big"),
							mix_colours(G.C.BLACK, get_blind_main_colour("Small"), 0.8)
						),
					},
				},
				config = {
					align = "bmi",
					offset = { x = 0, y = G.ROOM.T.y + 9 },
					major = par,
					xy_bond = "Weak",
				},
			})
			par.config.object = G.blind_select_opts.small
			par.config.object:recalculate()
			G.blind_select_opts.small.parent = par
			G.blind_select_opts.small.alignment.offset.y = 0

			save_run()
			return true
		end,
	}))
end

SMODS.Blind({
	key = "final_whale",
	loc_txt = {
		name = "White Whale",
		text = { "Chip requirement increased per", "blind skipped on this run" },
	},
	atlas = "Blinds",
	pos = { x = 0, y = 0 },
	boss = { showdown = true },
	mult = 2,
	boss_colour = HEX("D4E3E5"),
})

SMODS.PokerHand({
	key = "Devil's Hand", -- Faust's poker hand
	mult = 1,
	chips = 10,
	l_mult = 4,
	l_chips = 15,
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
			"{C:mult}+4{} Mult and",
			"{C:chips}+15{} chips",
		},
	},
	cost = 3,
	atlas = "Consumables",
	pos = { x = 0, y = 0 },
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
		SMODS.smart_level_up_hand(card, "Devil's Hand", nil, 1)
	end,
})

SMODS.Consumable({
	key = "forgiveness",
	set = "Tarot",
	config = { max_highlighted = 2, mod_conv = "m_glass" },
	loc_txt = {
		name = "Forgiveness",
		text = { "Enhances {C:attention}2{} selected", "cards to {C:attention}Glass Cards{}" },
	},
	atlas = "Consumables",
	pos = { x = 3, y = 0 },
	cost = 3,
	in_pool = function(self)
		if next(SMODS.find_card("j_hf_myshkin")) then
			return true
		end
	end,
})

SMODS.Consumable({
	key = "struggle",
	set = "Tarot",
	loc_txt = {
		name = "Struggle",
		text = {
			"Select {C:attention}2{} cards, decrease",
			"left card's rank by {C:attention}1{}",
			"and increase right card's",
			"rank by {C:attention}1{}",
		},
	},
	atlas = "Consumables",
	pos = { x = 4, y = 0 },
	config = { max_highlighted = 2 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.max_highlighted } }
	end,
	in_pool = function(self)
		if next(SMODS.find_card("j_hf_sisyphus")) then
			return true
		end
	end,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("tarot1")
				card:juice_up(0.3, 0.5)
				return true
			end,
		}))
		for i = 1, #G.hand.highlighted do
			local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.15,
				func = function()
					G.hand.highlighted[i]:flip()
					play_sound("card1", percent)
					G.hand.highlighted[i]:juice_up(0.3, 0.3)
					return true
				end,
			}))
		end
		local rightmost = G.hand.highlighted[1]
		for i = 1, #G.hand.highlighted do
			if G.hand.highlighted[i].T.x > rightmost.T.x then
				rightmost = G.hand.highlighted[i]
			end
		end
		local leftmost = nil
		for i = 1, #G.hand.highlighted do
			if G.hand.highlighted[i] ~= rightmost then
				leftmost = G.hand.highlighted[i]
			end
		end

		delay(0.2)
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.1,
			func = function()
				-- SMODS.modify_rank will increment/decrement a given card's rank by a given amount
				assert(SMODS.modify_rank(rightmost, 1))
				if leftmost then
					assert(SMODS.modify_rank(leftmost, -1))
				end
				return true
			end,
		}))
		for i = 1, #G.hand.highlighted do
			local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.15,
				func = function()
					G.hand.highlighted[i]:flip()
					play_sound("tarot2", percent, 0.6)
					G.hand.highlighted[i]:juice_up(0.3, 0.3)
					return true
				end,
			}))
		end
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.2,
			func = function()
				G.hand:unhighlight_all()
				return true
			end,
		}))
		delay(0.5)
	end,
})

SMODS.Consumable({
	key = "envoy",
	set = "Tarot",
	atlas = "Consumables",
	pos = { x = 5, y = 0 },
	loc_txt = {
		name = "The Envoy",
		text = {
			"The next 2 {C:attention}Devil's Hand{}",
			"you play creates an",
			"{C:purple}Osiris Card{} instead",
			"of upgrading your deck",
		},
	},
	in_pool = function(self)
		if next(SMODS.find_card("j_hf_faust")) then
			return true
		end
	end,
	can_use = function(self, card)
		return G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit
			or (card.area == G.consumeables)
	end,
	use = function(self, card, area) end,
})

SMODS.Consumable:take_ownership("strength", {
	in_pool = function(self, args)
		if next(SMODS.find_card("j_hf_sisyphus")) then
			return false
		else
			return true
		end
	end,
}, true)

SMODS.Consumable:take_ownership("justice", {
	in_pool = function(self, args)
		if next(SMODS.find_card("j_hf_myshkin")) then
			return false
		else
			return true
		end
	end,
}, true)

SMODS.Enhancement:take_ownership("glass", {

	calculate = function(self, card, context)
		if
			context.destroy_card
			and context.cardarea == G.play
			and context.destroy_card == card
			and SMODS.pseudorandom_probability(card, "glass", 1, card.ability.extra)
		then
			if G.jokers and G.jokers.cards then
				for i = 1, #G.jokers.cards do
					if G.jokers.cards[i].config.center.key == "j_hf_myshkin" then
						card:set_ability("m_hf_synaptic", nil, true)
						G.E_MANAGER:add_event(Event({
							func = function()
								local dissolve_time = 0.7
								card.dissolve = 0
								card.dissolve_colours = { { 1, 1, 1, 0.8 } }
								card:juice_up()
								local childParts = Particles(0, 0, 0, 0, {
									timer_type = "TOTAL",
									timer = 0.007 * dissolve_time,
									scale = 0.3,
									speed = 4,
									lifespan = 0.5 * dissolve_time,
									attach = card,
									colours = card.dissolve_colours,
									fill = card,
								})
								G.E_MANAGER:add_event(Event({
									trigger = "after",
									blockable = false,
									delay = 0.5 * dissolve_time,
									func = function()
										childParts:fade(0.15 * dissolve_time)
										return true
									end,
								}))
								G.E_MANAGER:add_event(Event({
									blockable = false,
									func = function()
										play_sound("glass" .. math.random(1, 6), math.random() * 0.2 + 0.9, 0.5)
										play_sound("generic1", math.random() * 0.2 + 0.9, 0.5)
										return true
									end,
								}))
								SMODS.calculate_context({ destroy_card = true, card = self })
								return true
							end,
						}))
						return
					end
				end
			end
			card.glass_trigger = true
			return { remove = true }
		end
	end,
}, true)

SMODS.Enhancement({
	key = "synaptic",
	loc_txt = {
		name = "Synaptic Card",
		text = {
			"{X:mult,C:white}X#1#{} mult",
			"{C:green}#2# in #3# chance{}",
			"to becoming an",
			"{C:purple}Ecstatic Card{}",
		},
	},
	config = { Xmult = 3, odds = 3 },
	atlas = "Enhancements",
	pos = { x = 1, y = 0 },
	shatters = true,
	in_pool = function(self, args)
		return false
	end,
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.Xmult, G.GAME.probabilities.normal, center.ability.odds } }
	end,
	calculate = function(self, card, context)
		if context.destroy_card and context.cardarea == G.play and context.destroy_card == card then
			if pseudorandom("synaptic") < G.GAME.probabilities.normal / card.ability.odds then
				card:set_ability("m_hf_ecstatic", nil, true)
				G.E_MANAGER:add_event(Event({
					func = function()
						local dissolve_time = 0.7
						card.dissolve = 0
						card.dissolve_colours = { { 1, 1, 1, 0.8 } }
						card:juice_up()
						local childParts = Particles(0, 0, 0, 0, {
							timer_type = "TOTAL",
							timer = 0.007 * dissolve_time,
							scale = 0.3,
							speed = 4,
							lifespan = 0.5 * dissolve_time,
							attach = card,
							colours = card.dissolve_colours,
							fill = card,
						})
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							blockable = false,
							delay = 0.5 * dissolve_time,
							func = function()
								childParts:fade(0.15 * dissolve_time)
								return true
							end,
						}))
						G.E_MANAGER:add_event(Event({
							blockable = false,
							func = function()
								play_sound("glass" .. math.random(1, 6), math.random() * 0.2 + 0.9, 0.5)
								play_sound("generic1", math.random() * 0.2 + 0.9, 0.5)
								return true
							end,
						}))
						return true
					end,
				}))
			end
		end
	end,
})

SMODS.Enhancement({
	key = "ecstatic",
	loc_txt = {
		name = "Ecstatic Card",
		text = {
			"{X:mult,C:white}X#1#{} mult",
			"{C:green}#2# in #3# chance{}",
			"to destroy itself",
			"after scoring",
		},
	},
	config = { Xmult = 5, odds = 2 },
	atlas = "Enhancements",
	pos = { x = 2, y = 0 },
	shatters = true,
	in_pool = function(self, args)
		return false
	end,
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.Xmult, G.GAME.probabilities.normal, center.ability.odds } }
	end,
	calculate = function(self, card, context)
		if context.destroy_card and context.cardarea == G.play and context.destroy_card == card then
			if pseudorandom("ecstatic") < G.GAME.probabilities.normal / card.ability.odds then
				return { remove = true }
			end
		end
	end,
})

SMODS.Enhancement({
	key = "tomb",
	loc_txt = {
		name = "Tomb Card",
		text = {
			"{C:mult}+1{} mult per {C:attention}1%{}",
			"{C:attention}Tomb Cards{}",
			"or {C:attention}Stone Cards{}",
			"in full deck,",
			"no rank or suit",
			"{C:inactive}Currently {}{C:mult}+#1#{}{C:inactive} Mult{}",
		},
	},
	config = {
		mult = 0,
		count = 0,
		total_cards = 0,
	},
	atlas = "Enhancements",
	pos = { x = 0, y = 0 },
	replace_base_card = true,
	no_rank = true,
	no_suit = true,
	always_scores = true,
	in_pool = function(self, args)
		if next(SMODS.find_card("j_hf_ozymandias")) then
			return true
		end
	end,
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.mult } }
	end,
	calculate = function(self, card, context)
		if
			context.before
			or context.using_consumeable
			or context.remove_playing_cards
			or context.drawing_cards
			or context.setting_ability
		then
			card.ability.total_cards = #G.playing_cards
			local count = 0
			for _, playing_card in ipairs(G.playing_cards) do
				if SMODS.has_enhancement(playing_card, "m_stone") then
					count = count + 1
				end
				if SMODS.has_enhancement(playing_card, "m_hf_tomb") then
					count = count + 1
				end
			end
			card.ability.count = count
			card.ability.mult = math.ceil(((count / #G.playing_cards) * 100))
		end
		if context.individual and (context.cardarea == G.play or context.cardarea == G.hand) then
			return { card.ability.mult }
		end
	end,
})

SMODS.Consumable({
	key = "hubris",
	set = "Tarot",
	config = { max_highlighted = 2, mod_conv = "m_hf_tomb" },
	loc_txt = {
		name = "Hubris",
		text = { "Enhances {C:attention}2{} selected", "cards to {C:attention}Tomb Cards{}" },
	},
	atlas = "Consumables",
	pos = { x = 2, y = 0 },
	cost = 3,
	in_pool = function(self)
		if next(SMODS.find_card("j_hf_ozymandias")) then
			return true
		end
	end,
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
		text = { "Upgrades your highest level", "poker hand and gives {C:money}$5{}" },
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
	pos = { x = 1, y = 0 },
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

SMODS.Voucher({
	key = "idle_pleasures",
	loc_txt = {
		name = "Idle Pleasures",
		text = {
			"Lucky Card rewards",
			"increased to {C:attention}150%{}",
			"base value",
		},
	},
	atlas = "Vouchers",
	pos = { x = 1, y = 0 },
	cost = 10,
	in_pool = function(self, args)
		if next(SMODS.find_card("j_hf_lampwick")) then
			return true
		end
	end,
	redeem = function(self, card)
		G.P_CENTERS.m_lucky.config.mult = 30
		G.P_CENTERS.m_lucky.config.p_dollars = 30
	end,
})

SMODS.Voucher({
	key = "pleasure_island",
	loc_txt = {
		name = "Pleasure Island",
		text = {
			"Lucky Card rewards",
			"increased to {C:attention}200%{}",
			"base value",
		},
	},
	atlas = "Vouchers",
	pos = { x = 2, y = 0 },
	cost = 10,
	requires = { "v_hf_idle_pleasures" },
	in_pool = function(self, args)
		if next(SMODS.find_card("j_hf_lampwick")) then
			return true
		end
	end,
	redeem = function(self, card)
		G.P_CENTERS.m_lucky.config.mult = 40
		G.P_CENTERS.m_lucky.config.p_dollars = 40
	end,
})

SMODS.Voucher({
	key = "creation",
	loc_txt = {
		name = "Creation",
		text = { "Creates a {C:dark_edition}Negative{}", "{C:purple}Legendary Joker{}", "{C:red}+1 Ante{}" },
	},
	atlas = "Vouchers",
	pos = { x = 0, y = 0 },
	in_pool = function(self, args)
		return false
	end,
	redeem = function(self, card)
		G.GAME.joker_buffer = 1
		G.E_MANAGER:add_event(Event({
			func = function()
				local new_card = SMODS.add_card({
					set = "Joker",
					rarity = "Legendary",
					key_append = "vremade_frankenstein",
				})
				new_card:set_edition("e_negative", true)
				G.GAME.joker_buffer = 0
				ease_ante(1)
				G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + 1
				return true
			end,
		}))
	end,
})

-------------------------------------------------------
---JOKERS
-------------------------------------------------------

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
			"adds {C:mult}+#1#{} mult to all",
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
				if v:get_id() == 2 or rank_bypass(v) then
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
		discard_tick = false,
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
							card_eval_status_text(card, "jokers", nil, nil, nil, { message = "+1", colour = G.C.BLUE })
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
					card_eval_status_text(card, "jokers", nil, nil, nil, { message = "+1", colour = G.C.RED })
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
	pos = { x = 3, y = 0 },
	soul_pos = { x = 3, y = 1 },
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
			if
				context.other_card:is_suit("Hearts", true)
				or context.other_card:is_suit("Clubs", true)
				or rank_bypass(context.other_card)
			then
				return {
					repetitions = pseudorandom("Quasimodo")
								< G.GAME.probabilities.normal / card.ability.extra.repetition_chance
							and 2
						or 1,
					sound = "hf_bell",
					pitch = math.random(),
					volume = 0.3,
				}
			end
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
	config = { extra = { dollars = 30 } },
	atlas = "Jokers",
	pos = { x = 5, y = 0 },
	soul_pos = { x = 5, y = 1 },
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
	key = "sisyphus",
	loc_txt = {
		name = "Sisyphus",
		text = {
			"Gain {X:mult,C:white}X#2#{} mult when",
			"played hand contains {C:attention}#1#{}",
			"and increase both values,",
			"Resets values when",
			"hand doesn't contain {C:attention}#1#{}",
			"{C:inactive}Currently {}{X:mult,C:white}X#3#{}{C:inactive} Mult{}",
		},
	},
	config = {
		extra = {
			rank = 2,
			xmult_mod = 0.2,
			xmult = 1,
			rank_names = { [11] = "Jack", [12] = "Queen", [13] = "King", [14] = "Ace" },
		},
	},
	atlas = "Jokers",
	pos = { x = 7, y = 0 },
	soul_pos = { x = 7, y = 1 },
	unlocked = true,
	rarity = 4,
	discovered = true,
	cost = 20,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				center.ability.extra.rank_names[center.ability.extra.rank] or center.ability.extra.rank,
				center.ability.extra.xmult_mod,
				center.ability.extra.xmult,
			},
		}
	end,
	calculate = function(self, card, context)
		if context.initial_scoring_step then
			for i = 1, #context.scoring_hand do
				if
					context.scoring_hand[i]:get_id() == card.ability.extra.rank or rank_bypass(context.scoring_hand[i])
				then
					card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
					card.ability.extra.xmult_mod = card.ability.extra.xmult_mod + 0.1
					card.ability.extra.rank = card.ability.extra.rank + 1

					if card.ability.extra.rank < 15 then
						return { message = localize("k_upgrade_ex"), colour = G.C.MULT }
					else
						card.ability.extra.xmult_mod = 0.2
						card.ability.extra.rank = 2
						return { message = localize("k_reset") }
					end
				end
			end

			if card.ability.extra.rank ~= 2 then
				card.ability.extra.xmult_mod = 0.2
				card.ability.extra.rank = 2
				return { message = localize("k_reset") }
			end
		end

		if context.joker_main then
			return { xmult = card.ability.extra.xmult }
		end
	end,
})

SMODS.Joker({
	key = "catherine",
	loc_txt = {
		name = "Catherine",
		text = {
			"Gain {C:mult}+#3#{} mult, {C:chips}-#6#{} chips",
			"per scored {C:spades}Spade{},",
			"Gain {C:chips}+#5#{} chips, {C:mult}-#4#{} mult",
			"per scored {C:diamonds}Diamond{},",
			"{C:inactive}(Currently {}{C:mult}#1#{}{C:inactive} mult,{}",
			"{C:chips}#2#{}{C:inactive} chips){}",
		},
	},
	config = { extra = { chips = 0, mult = 0, mult_plus = 2, mult_minus = 1, chips_plus = 6, chips_minus = 2 } },
	atlas = "Jokers",
	pos = { x = 8, y = 0 },
	soul_pos = { x = 8, y = 1 },
	rarity = 4,
	unlocked = true,
	discovered = true,
	cost = 20,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				center.ability.extra.mult,
				center.ability.extra.chips,
				center.ability.extra.mult_plus,
				center.ability.extra.mult_minus,
				center.ability.extra.chips_plus,
				center.ability.extra.chips_minus,
			},
		}
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and not context.blueprint then
			if context.other_card.config.center.key == "m_wild" or rank_bypass(context.other_card) then
				card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_plus
				card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_plus
				return {
					message = "Wild!",
					colour = G.C.ATTENTION,
				}
			end
			if context.other_card:is_suit("Spades", true) then
				card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_plus
				card.ability.extra.chips = card.ability.extra.chips - card.ability.extra.chips_minus
				if card.ability.extra.chips < 0 then
					card.ability.extra.chips = 0
				end
			end
			if context.other_card:is_suit("Diamonds", true) then
				card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_plus
				card.ability.extra.mult = card.ability.extra.mult - card.ability.extra.mult_minus
				if card.ability.extra.mult < 0 then
					card.ability.extra.mult = 0
				end
			end
		end

		if context.joker_main then
			return {
				mult = card.ability.extra.mult,
				chips = card.ability.extra.chips,
			}
		end
	end,
})

SMODS.Joker({
	key = "gwynplaine",
	loc_txt = {
		name = "Gwynplaine",
		text = {
			"{C:attention}Face{} cards count as",
			"every {C:attention}rank{} and {C:attention}suit{}",
			"for {C:attention}Joker Abilities{}",
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
})

SMODS.Joker({
	key = "dagonet",
	loc_txt = {
		name = "Dagonet",
		text = {
			"Once per {C:attention}Ante{}, If you",
			"lose to the {C:attention}Small{} or",
			"{C:attention}Big{} Blind, return",
			"to start of {C:attention}Ante{}",
		},
	},
	config = {
		extra = {
			tick = 1,
		},
	},
	atlas = "Jokers",
	pos = { x = 10, y = 0 },
	soul_pos = { x = 10, y = 1 },
	rarity = 4,
	unlocked = true,
	discovered = true,
	cost = 20,
	calculate = function(self, card, context)
		if
			context.game_over
			and context.end_of_round
			and context.main_eval
			and G.GAME.round_resets.blind_states.Big ~= "Defeated"
			and card.ability.extra.tick == 1
		then
			card.ability.extra.tick = 2
			return {
				message = "Run away!",
				saved = "ph_dagonet",
				colour = G.C.RED,
			}
		end

		if card.ability.extra.tick == 2 and context.starting_shop then
			G.GAME.round_resets.blind_states = { Small = "Select", Big = "Upcoming", Boss = "Upcoming" }
			card.ability.extra.tick = 0
		end

		if context.beat_boss then
			card.ability.extra.tick = 1
		end
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
	pos = { x = 11, y = 0 },
	soul_pos = { x = 11, y = 1 },
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
	key = "malvolio",
	loc_txt = {
		name = "Malvolio",
		text = {
			"If the highest ranked scored",
			"card is {C:attention}numbered{}, it adds {X:mult,C:white}X{} Mult",
			"equal to its rank {C:attention}halved{}",
		},
	},
	config = {
		extra = {
			highest_card_id = 0,
			xmult = 1,
		},
	},
	atlas = "Jokers",
	pos = { x = 12, y = 0 },
	soul_pos = { x = 12, y = 1 },
	rarity = 4,
	unlocked = true,
	discovered = true,
	cost = 20,
	calculate = function(self, card, context)
		if context.initial_scoring_step then
			local highest_rank = 0
			local highest_card = nil
			for i = 1, #context.scoring_hand do
				if rank_bypass(context.scoring_hand[i]) then
					highest_rank = 10
					highest_card = context.scoring_hand[i]
					break
				end
				local rank = context.scoring_hand[i]:get_id()
				if rank > 10 then
					return
				end
				if rank > highest_rank then
					highest_rank = rank
					highest_card = context.scoring_hand[i]
				end
			end
			card.ability.extra.highest_card_id = highest_card.unique_val
			card.ability.extra.xmult = highest_rank / 2
		end

		if context.individual and context.cardarea == G.play then
			if context.other_card.unique_val == card.ability.extra.highest_card_id then
				return { xmult = card.ability.extra.xmult }
			end
		end

		if context.after and card.ability.extra.highest_card_id ~= 0 then
			card.ability.extra.highest_card_id = 0
		end
	end,
})

SMODS.Joker({
	key = "bloom",
	loc_txt = {
		name = "Bloom",
		text = {
			"Adds {C:dark_edition}Negative{} to random {C:attention}Joker{}",
			"at end of every {C:attention}#1#{} rounds",
			"All Blinds have a {C:attention}Boss Blind Ability{}",
		},
	},
	atlas = "Jokers",
	pos = { x = 13, y = 0 },
	soul_pos = { x = 13, y = 1 },
	rarity = 4,
	unlocked = true,
	discovered = true,
	cost = 20,
	config = {
		extra = {
			round_count = 0,
			round_threshold = 3,
			tick = true,
		},
	},
	blueprint_compat = false,
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.round_threshold } }
	end,
	calculate = function(self, card, context)
		if context.end_of_round and card.ability.extra.tick and not context.blueprint then
			card.ability.extra.round_count = card.ability.extra.round_count + 1
			card.ability.extra.tick = false
			if card.ability.extra.round_count >= card.ability.extra.round_threshold then
				card.ability.extra.round_count = 0
				local valid_jokers = {}
				for k, v in pairs(G.jokers.cards) do
					if v ~= card and not v.edition then
						valid_jokers[#valid_jokers + 1] = v
					end
				end
				if #valid_jokers > 0 then
					local neg_joker = pseudorandom_element(valid_jokers, pseudoseed("Bloom"))
					neg_joker.edition = "e_negative"
					neg_joker.temp_edition = true
					neg_joker.temp_edition = nil
					neg_joker:set_edition({ negative = true }, true)
				end
			end
		end

		if context.starting_shop then
			card.ability.extra.tick = true
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		G.GAME.round_resets.blind_choices.Small = get_new_boss()
		G.GAME.round_resets.blind_choices.Big = get_new_boss()
		G.P_BLINDS[G.GAME.round_resets.blind_choices.Small].mult = 1
		G.P_BLINDS[G.GAME.round_resets.blind_choices.Big].mult = 1.5
		if G.P_BLINDS[G.GAME.round_resets.blind_choices.Boss].mult ~= 2 then
			G.P_BLINDS[G.GAME.round_resets.blind_choices.Boss].mult = 2
		end
	end,

	remove_from_deck = function(self, card, from_debuff)
		G.GAME.round_resets.blind_choices.Small = "bl_small"
		G.GAME.round_resets.blind_choices.Big = "bl_big"
		Reset_Blinds_After_Bloom()
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
			"to destroy card",
			"{C:inactive}(Currently {}{X:mult,C:white}X#1#{}{C:inactive} Mult){}",
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
						message_card = card,
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

SMODS.Joker({
	key = "myshkin",
	loc_txt = {
		name = "Myshkin",
		text = {
			"{C:attention}Glass cards{}",
			"become {C:purple}Synaptic{} cards",
			"when shattered",
		},
	},
	config = { extra = { odds = 4, tick = false, glass_joker_present = false } },
	atlas = "Jokers",
	pos = { x = 15, y = 0 },
	soul_pos = { x = 15, y = 1 },
	rarity = 4,
	unlocked = true,
	discovered = true,
	cost = 20,
	blueprint_compat = false,
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = { key = "info_synaptic_card", set = "Other" }
		info_queue[#info_queue + 1] = { key = "info_ecstatic_card", set = "Other" }
		return { vars = { G.GAME.probabilities.normal, center.ability.extra.odds } }
	end,
})

SMODS.Joker({
	key = "ahab",
	loc_txt = {
		name = "Ahab",
		text = {
			"When you {C:attention}skip{} a blind,",
			"increase the {C:attention}Boss{} Blind",
			"chip requirement by {C:attention}25%{}",
			"and gain {X:mult,C:white}X#2#{} Mult",
			"{C:inactive}Currently {}{X:mult,C:white}X#1#{}{C:inactive} Mult{}",
		},
	},
	config = {
		extra = {
			xmult = 1,
			xmult_mod = 1.5,
		},
	},

	atlas = "Jokers",
	pos = { x = 16, y = 0 },
	soul_pos = { x = 16, y = 1 },
	rarity = 4,
	unlocked = true,
	discovered = true,
	cost = 20,
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.xmult, center.ability.extra.xmult_mod } }
	end,
	blueprint_compat = true,

	calculate = function(self, card, context)
		if context.skip_blind then
			card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
			return {
				message = localize("k_upgrade_ex"),
				colour = G.C.MULT,
			}
		end

		if context.joker_main then
			return { xmult = card.ability.extra.xmult }
		end
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
	pos = { x = 17, y = 0 },
	soul_pos = { x = 17, y = 1 },
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
	key = "jigong",
	loc_txt = {
		name = "Ji Gong",
		text = {
			"Each {C:attention}discard{} increases",
			"{C:attention}hand size{} by the",
			"number of {C:attention}discards{}",
			"used this round,",
			"{C:inactive}Resets on round start{}",
		},
	},
	config = { extra = { hand_size = 1, total_extra = 0, tick = false } },
	atlas = "Jokers",
	pos = { x = 18, y = 0 },
	soul_pos = { x = 18, y = 1 },
	rarity = 4,
	unlocked = true,
	discovered = true,
	cost = 20,
	blueprint_compat = false,

	calculate = function(self, card, context)
		if not context.blueprint then
			if context.pre_discard then
				G.hand:change_size(card.ability.extra.hand_size)
				card.ability.extra.total_extra = card.ability.extra.total_extra + card.ability.extra.hand_size
				card.ability.extra.tick = true
				card.ability.extra.hand_size = card.ability.extra.hand_size + 1
			end

			if context.hand_drawn and card.ability.extra.tick then
				card.ability.extra.tick = false
				return {
					message = "+" .. card.ability.extra.hand_size - 1 .. " Hand Size",
					colour = G.C.ATTENTION,
				}
			end

			if context.setting_blind then
				G.hand:change_size(-card.ability.extra.total_extra)
				card.ability.extra.total_extra = 0
				card.ability.extra.hand_size = 1
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
	pos = { x = 19, y = 0 },
	soul_pos = { x = 19, y = 1 },
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
	key = "lampwick",
	loc_txt = {
		name = "Lampwick",
		text = {
			"Lucky cards have a {C:green}1 in 5{},",
			"chance to give {X:mult,C:white}X#1#{} Mult, {C:chips}+#2#{} Chips,",
			"or {C:money}$#3#{} and a {C:green}1 in 10{} chance to",
			"create an extra {C:attention}Voucher{} next shop",
		},
	},
	config = {
		extra = {
			xmult = 2,
			chips = 60,
			dollars = 10,
			vouchers = {},
		},
	},
	atlas = "Jokers",
	pos = { x = 20, y = 0 },
	soul_pos = { x = 20, y = 1 },
	rarity = 4,
	unlocked = true,
	discovered = true,
	cost = 20,
	set_ability = function(self, card, initial, delay_sprites)
		local lampwick_ref = card.config.center
		if G.GAME.used_vouchers["v_hf_pleasure_island"] == true then
			lampwick_ref.soul_pos = { x = 20, y = 3 }
			card.ability.extra.chips = 120
			card.ability.extra.dollars = 20
			card.ability.extra.xmult = 4
			card:set_sprites(lampwick_ref)
		elseif G.GAME.used_vouchers["v_hf_idle_pleasures"] == true then
			lampwick_ref.soul_pos = { x = 20, y = 2 }
			card.ability.extra.chips = 90
			card.ability.extra.dollars = 15
			card.ability.extra.xmult = 3
			card:set_sprites(lampwick_ref)
		end
	end,
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.xmult, center.ability.extra.chips, center.ability.extra.dollars } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and context.other_card.config.center.key == "m_lucky" then
			local return_modifiers = {}
			if pseudorandom("Lampwick") < G.GAME.probabilities.normal / 5 then
				return_modifiers.chips = card.ability.extra.chips
			end
			if pseudorandom("Lampwick") < G.GAME.probabilities.normal / 5 then
				return_modifiers.xmult = card.ability.extra.xmult
			end
			if pseudorandom("Lampwick") < G.GAME.probabilities.normal / 5 then
				return_modifiers.dollars = card.ability.extra.dollars
			end
			if pseudorandom("Lampwick") < G.GAME.probabilities.normal / 10 then
				local voucher_key = get_next_voucher_key(true)

				while Contains(card.ability.extra.vouchers, voucher_key) do
					voucher_key = get_next_voucher_key(true)
				end
				card.ability.extra.vouchers[#card.ability.extra.vouchers + 1] = voucher_key

				return_modifiers.message = "+1 Voucher!"
			end
			if next(return_modifiers) ~= nil then
				return return_modifiers
			end
		end

		if context.starting_shop then
			for i = 1, #card.ability.extra.vouchers do
				SMODS.add_voucher_to_shop(card.ability.extra.vouchers[i])
			end
			card.ability.extra.vouchers = {}
		end

		if context.buying_card and context.card.config.center.key == "v_hf_idle_pleasures" then
			card:juice_up()
			card:set_ability(self, card)
		end

		if context.buying_card and context.card.config.center.key == "v_hf_pleasure_island" then
			card:juice_up()
			card:set_ability(self, card)
		end
	end,
})

SMODS.Joker({
	key = "havisham",
	loc_txt = {
		name = "Havisham",
		text = {
			"After scoring {C:attention}10{} cards of",
			"the same {C:attention}Suit{} in a row ",
			"all cards with that suit give",
			"{X:mult,C:white}X#1#{} Mult",
			"{C:inactive}(Currently {}{C:attention}#2#{} {C:spades}#4#{}{C:hearts}#5#{}{C:clubs}#6#{}{C:diamonds}#7#{}{C:inactive}){}",
		},
	},
	config = { extra = {
		played_cards = 0,
		xmult = 1.75,
		current_suit = "Spades",
	} },
	atlas = "Jokers",
	pos = { x = 21, y = 0 },
	soul_pos = { x = 21, y = 1 },
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
			if context.other_card:is_suit(card.ability.extra.current_suit, true) or rank_bypass(context.other_card) then
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
	key = "polyphemus",
	loc_txt = {
		name = "Polyphemus",
		text = {
			"At round start, set the",
			"chip requirement to the",
			"{C:attention}Small{} Blind value",
			"{C:inactive}Doesn't affect{}",
			"{C:attention}Showdown Bosses{}",
		},
	},
	atlas = "Jokers",
	pos = { x = 22, y = 0 },
	soul_pos = { x = 22, y = 1 },
	rarity = 4,
	unlocked = true,
	discovered = true,
	cost = 20,
	blueprint_compat = false,
	calculate = function(self, card, context)
		if context.setting_blind then
			if G.GAME.blind_on_deck == "Big" then
				G.GAME.blind.chips = get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling
				G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
				return { message = "Puny!", colour = G.C.RED }
			elseif
				G.GAME.blind_on_deck == "Boss" and not G.P_BLINDS[G.GAME.round_resets.blind_choices.Boss].boss.showdown
			then
				G.GAME.blind.chips = get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling
				G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
				return { message = "Puny!", colour = G.C.RED }
			end
		end
	end,
})

SMODS.Joker({
	key = "ganymede",
	loc_txt = {
		name = "Ganymede",
		text = {
			"Gain {X:mult,C:white}X#1#{} Mult for every",
			"scored {C:attention}New Ace{}",
			"{C:inactive}(Currently {X:mult,C:white}X#2#{}{C:inactive} Mult){}",
		},
	},
	config = {
		extra = {
			xmult_mod = 1,
			xmult = 1,
			used_aces = {},
		},
	},
	atlas = "Jokers",
	pos = { x = 23, y = 0 },
	soul_pos = { x = 23, y = 1 },
	rarity = 4,
	unlocked = true,
	discovered = true,
	cost = 20,
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.xmult_mod, center.ability.extra.xmult } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and not context.repetition then
			if
				(context.other_card:get_id() == 14 or rank_bypass(context.other_card))
				and not card.ability.extra.used_aces[context.other_card.unique_val]
			then
				card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
				card.ability.extra.used_aces[context.other_card.unique_val] = true
				return {
					message_card = card,
					message = "New Ace!",
					colour = G.C.ATTENTION,
				}
			end
		end

		if context.joker_main then
			return { xmult = card.ability.extra.xmult }
		end
	end,
})

SMODS.Joker({
	key = "fagin",
	loc_txt = {
		name = "Fagin",
		text = {
			"Each scored card and other",
			"{C:attention}Joker{} in play gives {C:money}$1{}",
			"{C:inactive}Cannot earn interest{}",
		},
	},
	rarity = 4,
	unlocked = true,
	discovered = true,
	cost = 20,
	atlas = "Jokers",
	pos = { x = 24, y = 0 },
	soul_pos = { x = 24, y = 1 },
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			return {
				dollars = 1,
			}
		end
		if context.other_joker and context.other_joker.config.center.key ~= "j_hf_fagin" then
			return {
				message_card = context.other_joker,
				dollars = 1,
			}
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		G.GAME.modifiers.no_interest = true
	end,

	remove_from_deck = function(self, card, from_debuff)
		if G.GAME.selected_back ~= "Green Deck" then
			G.GAME.modifiers.no_interest = false
		end
	end,
})

SMODS.Joker({
	key = "pentheus",
	loc_txt = {
		name = "Pentheus",
		text = {
			"When you sell or destroy",
			"a {C:attention}Joker{}, the next shop",
			"copy will be {C:dark_edition}Negative{}",
			"and cost {C:money}$0{}",
		},
	},
	config = { extra = { removed_jokers = {} } },
	atlas = "Jokers",
	pos = { x = 25, y = 0 },
	soul_pos = { x = 25, y = 1 },
	rarity = 4,
	unlocked = true,
	discovered = true,
	cost = 20,
	blueprint_compat = false,

	calculate = function(self, card, context)
		if not context.blueprint then
			if (context.selling_card and context.card.ability.set == "Joker") or context.joker_type_destroyed then
				card.ability.extra.removed_jokers[context.card.ability.name] = true
			end

			if context.starting_shop or context.reroll_shop then
				local trigger = false
				for k, v in pairs(G.shop_jokers.cards) do
					if v.ability.set == "Joker" then
						if card.ability.extra.removed_jokers[v.ability.name] == true then
							trigger = true
							v.edition = nil
							v.edition = "e_negative"
							v.temp_edition = true
							v.temp_edition = nil
							v:set_edition({ negative = true }, true)
							v.ability.couponed = true
							v:set_cost()
							card.ability.extra.removed_jokers[v.ability.name] = nil
						end
					end
				end

				if trigger then
					trigger = false
					return { message = "Returned", colour = G.C.RED }
				end
			end
		end
	end,
})

SMODS.Joker({
	key = "ozymandias",
	loc_txt = {
		name = "Ozymandias",
		text = {
			"Unlocks {C:attention}Tomb Cards{},",
			"When {C:attention}Stone{} cards",
			"and {C:attention}Tomb{} cards",
			"are destroyed, gain a",
			"{C:spectral}Spectral{} card",
		},
	},
	atlas = "Jokers",
	pos = { x = 26, y = 0 },
	soul_pos = { x = 26, y = 1 },
	rarity = 4,
	unlocked = true,
	discovered = true,
	cost = 20,
	blueprint_compat = false,
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = { key = "info_tomb_card", set = "Other" }
	end,

	calculate = function(self, card, context)
		if context.remove_playing_cards and context.removed then
			local count = 0
			for k, v in pairs(context.removed) do
				if SMODS.has_enhancement(v, "m_stone") then
					count = count + 1
				end
				if SMODS.has_enhancement(v, "m_hf_tomb") then
					count = count + 1
				end
			end
			if count > 0 then
				for i = 1, count do
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
					G.E_MANAGER:add_event(Event({
						func = function()
							SMODS.add_card({
								set = "Spectral",
								key_append = "hf_ozymandias",
							})
							G.GAME.consumeable_buffer = 0
							return true
						end,
					}))
				end
			end
		end
	end,
})

SMODS.Joker({
	key = "lear",
	loc_txt = {
		name = "Lear",
		text = {
			"If multiple {C:attention}Queens{} of",
			"different {C:attention}Suits{} are played",
			"one permanently gains {X:mult,C:white}X#1#{} Mult",
		},
	},
	config = { extra = { xmult_mod = 0.25, tick = false } },
	atlas = "Jokers",
	pos = { x = 27, y = 0 },
	soul_pos = { x = 27, y = 1 },
	rarity = 4,
	unlocked = true,
	discovered = true,
	cost = 20,
	blueprint_compat = false,
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.xmult_mod } }
	end,
	calculate = function(self, card, context)
		if context.initial_scoring_step then
			local queen_suits = {}
			local queens = {}
			for i, v in pairs(context.scoring_hand) do
				if v:get_id() == 12 or rank_bypass(v) then
					if queen_suits.queen and queen_suits[v.base.suit] == nil then
						queens[#queens + 1] = v
						card.ability.extra.tick = true
						break
					end
					queen_suits[v.base.suit] = true
					queen_suits.queen = true
					queens[#queens + 1] = v
				end
			end
			if not card.ability.extra.tick then
				return
			else
				local amped_card = pseudorandom_element(queens, pseudoseed("Lear"))
				amped_card.ability.perma_x_mult = (amped_card.ability.perma_x_mult or 1) + card.ability.extra.xmult_mod
				return {
					message = "Upgrade!",
					colour = G.C.RED,
					message_card = amped_card,
				}
			end
		end
		if context.after then
			card.ability.extra.tick = false
		end
	end,
})

SMODS.Joker({
	key = "faust",
	loc_txt = {
		name = "Faust",
		text = {
			"Unlocks {C:attention}Devil's Hand{}.",
			"When {C:attention}Devil's Hand{} is",
			"played, add a random",
			"{C:attention}enhancement{}, {C:blue}seal{} or",
			"{C:purple}edition{} to a random card",
			"in deck",
		},
	},
	config = {
		extra = {
			enhancements = { "m_bonus", "m_mult", "m_lucky", "m_stone", "m_wild", "m_gold", "m_glass", "m_steel" },
			seals = { "Blue", "Purple", "Red", "Gold" },
			editions = { "e_foil", "e_holo", "e_polychrome" },
			osiris_uses = 0,
		},
	},
	atlas = "Jokers",
	pos = { x = 28, y = 0 },
	soul_pos = { x = 28, y = 1 },
	rarity = 4,
	unlocked = true,
	discovered = true,
	cost = 20,
	blueprint_compat = true,

	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = { key = "info_devils_hand", set = "Other" }
	end,

	set_ability = function(self, card, initial, delay_sprites)
		local faustref = card.config.center
		if type(G.GAME.hands["Devil's Hand"].level) == "table" then
			if G.GAME.hands["Devil's Hand"].level:to_number() > 30 then
				faustref.soul_pos = { x = 28, y = 2 }
				card:set_sprites(faustref)
			else
				faustref.soul_pos = { x = 28, y = 1 }
				card:set_sprites(faustref)
			end
		elseif G.GAME.hands["Devil's Hand"].level > 30 then
			faustref.soul_pos = { x = 28, y = 2 }
			card:set_sprites(faustref)
		else
			faustref.soul_pos = { x = 28, y = 1 }
			card:set_sprites(faustref)
		end
	end,

	calculate = function(self, card, context)
		if context.setting_blind then
			card:set_ability(self, card)
		end

		if context.before and next(context.poker_hands["Devil's Hand"]) then
			if card.ability.extra.osiris_uses > 0 then
				card.ability.extra.osiris_uses = card.ability.extra.osiris_uses - 1
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.4,
					func = function()
						if G.consumeables.config.card_limit > #G.consumeables.cards then
							play_sound("timpani")
							SMODS.add_card({ key = "c_hf_osiris" })
							card:juice_up(0.3, 0.5)
						end
						return true
					end,
				}))
				return {
					message = card.ability.extra.osiris_uses .. "Left",
					colour = G.C.ATTENTION,
				}
			end
			local random_card = pseudorandom_element(G.deck.cards, pseudoseed("Faust"))
			local random_result = pseudorandom("Faust")
			if random_result < 0.6 then
				random_card:set_ability(
					pseudorandom_element(card.ability.extra.enhancements, pseudoseed("Faust")),
					nil,
					true
				)
				return {
					message = "Enhanced!",
					colour = G.C.ATTENTION,
				}
			elseif random_result < 0.85 then
				random_card:set_seal(pseudorandom_element(card.ability.extra.seals, pseudoseed("Faust")))
				return {
					message = "Sealed!",
					colour = G.C.ATTENTION,
				}
			else
				random_card:set_edition(pseudorandom_element(card.ability.extra.editions, pseudoseed("Faust")))
				return {
					message = "Edition!",
					colour = G.C.ATTENTION,
				}
			end
		end

		if context.using_consumeable and context.consumeable.config.center_key == "c_hf_envoy" then
			card.ability.extra.osiris_uses = card.ability.extra.osiris_uses + 2
		end
	end,
})

SMODS.Joker({
	key = "frankenstein",
	loc_txt = {
		name = "Frankenstein",
		text = {
			"Spawns a {C:attention}Creation{}",
			"voucher at the start",
			"of each {C:attention}Ante{}",
		},
	},
	config = {
		extra = {
			tick = false,
		},
	},
	atlas = "Jokers",
	pos = { x = 29, y = 0 },
	soul_pos = { x = 29, y = 1 },
	rarity = 4,
	unlocked = true,
	discovered = true,
	cost = 20,
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = { key = "info_creation", set = "Other" }
	end,
	calculate = function(self, card, context)
		if context.beat_boss then
			card.ability.extra.tick = true
		end
		if context.starting_shop and card.ability.extra.tick then
			SMODS.add_voucher_to_shop("v_hf_creation")
			card.ability.extra.tick = false
		end
		if context.buying_card and context.card.config.center.key == "v_hf_creation" then
			return {
				message_card = card,
				message = "IT'S ALIVE!",
				colour = G.C.RED,
			}
		end
	end,
})
