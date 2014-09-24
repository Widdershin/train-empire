require 'rails_helper'

describe 'playing a game' do
  before do
    @game = Game.create!
    test_seed = 500
    @game.seed = test_seed
    @game.users << User.create!(username: 'Widdershin', email: 'u@a.c', password: 'barbarbar')
    @game.users << User.create!(username: 'FooBazBar', email: 'hey@bar.com', password: 'nahdamn8chars')

    @player_1 = @game.players.find {|player| player.name == 'Widdershin'}
    @player_2 = @game.players.find {|player| player.name == 'FooBazBar'}

    def p1
      @state.players.players.find {|player| player.name == 'Widdershin' }
    end

    def p2
      @state.players.players.find {|player| player.name == 'FooBazBar' }
    end

    def display_cards
      puts "****" * 4
      puts @state.available_train_cards.cards
      puts "****" * 4
    end

    def update_state
      @state = @game.state
    end

    def draw_card(player, color)
      card_index = @state.available_train_cards.cards.find_index { |card| card.color == color }

      if card_index.nil?
        display_cards
        raise 'no card with that color found'
      end

      player.actions.create!(
        action: 'draw_train_card',
        card_index: card_index,
      )
      update_state
    end

    update_state
  end

  it 'can play a game' do
    expect(@state.current_player).to eq p1

    @player_1.actions.create!(
      action: 'keep_initial_route_cards',
      route_cards_to_keep: [0, 1]
    )

    update_state

    expect(p1.routes.size).to eq 2
    expect(@state.current_player).to eq p2

    expect(p2.potential_routes.size).to eq 3

    @player_2.actions.create!(
      action: 'keep_initial_route_cards',
      route_cards_to_keep: [0, 1]
    )

    update_state
    expect(@state.current_player).to eq p1

    draw_card(@player_1, :yellow)

    expect(@state.current_player).to eq p1

    expect(p1.hand.size).to eq 5

    draw_card(@player_1, :blue)

    expect(@state.current_player).to eq p2

    draw_card(@player_2, :purple)
    draw_card(@player_2, :red)

    expect(@state.available_train_cards.count).to eq 5

    link_id = 27
    @player_1.actions.create!(
      action: 'claim_link',
      link_id: link_id,
    )

    route = @state.link(link_id)
    expect {update_state}.to change {p1.trains}.by(-route.cost)

    expect(@state.link(link_id).owner).to eq p1
  end

  it 'lets you draw twice' do
    draw_card(@player_1, :purple)

    expect(@state.current_player).to eq p1

    draw_card(@player_1, :blue)

    expect(@state.current_player).to eq p2

    draw_card(@player_2, :red)

    expect(@state.current_player).to eq p2

    draw_card(@player_2, :white)

    expect(@state.current_player).to eq p1

    draw_card(@player_1, :yellow)

    expect(@state.current_player).to eq p1
  end

  it 'only lets you draw one wildcard per turn' do
    @game.seed = 999

    update_state

    @player_1.actions.create(
      action: 'draw_wild_card',
      card_index: 2
    )

    update_state

    expect(@state.current_player).to eq p2
  end
end
