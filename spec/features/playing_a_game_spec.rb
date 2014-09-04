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

    @state = @game.state

    expect(@state.current_player).to eq p1

    player_1.actions.create(
      action: 'draw_route_cards'
    )

    player_1.actions.create(
      action: 'keep_route_cards',
      route_cards_to_keep: [0, 1]
    )

    @state = @game.state

    expect(p1.routes.size).to eq 2
    expect(@state.current_player).to eq p2
  end
end
