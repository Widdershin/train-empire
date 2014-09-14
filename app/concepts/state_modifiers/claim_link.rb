class StateModifiers::ClaimLink
  attr_reader :errors, :player_id

  def self.from_action(action)
    new(action.player_id, action.link_id)
  end

  def initialize(player_id, link_id)
    @link_id = link_id
    @errors = []
  end

  def process(player, game_state)
    link = game_state.link(@link_id)
    player.claim link
  end

  def end_of_turn?(player)
    true
  end

  def valid?(player, game_state)
    link = game_state.link(@link_id)
    @errors = []

    player_card_count = player.hand.count { |card| card.color == link.color }

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
