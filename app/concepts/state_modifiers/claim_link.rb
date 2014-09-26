class StateModifiers::ClaimLink
  attr_reader :errors, :player_id

  def self.from_action(action)
    new(action.player_id, action.link_id, action.cards_to_spend)
  end

  def initialize(player_id, link_id, cards_to_spend)
    @player_id = player_id
    @link_id = link_id
    @errors = []
    @cards_to_spend = cards_to_spend.map(&:to_i)
  end

  def process(player, game_state)
    link = game_state.link(@link_id)
    player.claim link, @cards_to_spend
  end

  def valid?(player, game_state)
    link = game_state.link(@link_id)
    @errors = []

    player_card_count = player.hand.count { |card| card.can_buy? link.color }

    if player_card_count < link.cost
      @errors << "#{player.name} needs more #{link.color} cards. " +
                 "Has #{player_card_count}, needs #{link.cost}."
    end

    if player.trains < link.cost
      @errors << "#{player} doesn't have enough trains."
    end

    errors.empty?
  end
end
