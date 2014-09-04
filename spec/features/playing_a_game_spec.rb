require 'rails_helper'

describe 'playing a game' do
  it 'can play a game' do
    @game = Game.create!
    @game.users << User.create!(username: 'Widdershin', email: 'u@a.c', password: 'barbarbar')
    @game.users << User.create!(username: 'FooBazBar', email: 'hey@bar.com', password: 'nahdamn8chars')

    player_1 = @game.players.find {|player| player.name == 'Widdershin'}
    player_2 = @game.players.find {|player| player.name == 'FooBazBar'}

    def p1
      @state.players.players.find {|player| player.name == 'Widdershin' }
    end

    def p2
      @state.players.players.find {|player| player.name == 'FooBazBar' }
    end

    def update_state
      @state = @game.state
    end

    update_state

    expect(@state.current_player).to eq p1

    player_1.actions.create(
      action: 'draw_route_cards'
    )

    player_1.actions.create(
      action: 'keep_route_cards',
      route_cards_to_keep: [0, 1]
    )

    update_state

    expect(p1.routes.size).to eq 2
    expect(@state.current_player).to eq p2

    player_2.actions.create(
      action: 'draw_route_cards'
    )

    update_state

    expect(p2.potential_routes.size).to eq 3

    player_2.actions.create(
      action: 'keep_route_cards',
      route_cards_to_keep: [0, 1]
    )

    update_state
    expect(@state.current_player).to eq p1

    player_1.actions.create(
      action: 'draw_train_card',
      card_index: 0,
    )

    update_state

    expect(p1.hand.size).to eq 1

    player_2.actions.create(
      action: 'draw_train_card',
      card_index: 1,
    )

    p @state.available_train_cards

  end
end
