require 'rails_helper'

RSpec.describe Action, :type => :model do
  it { should validate_presence_of :action }
  it { should belong_to :player }

  describe 'defrosting' do
    it 'returns an instance of an action modifier (words?) given a gamestate' do
      card_index = 1

      player_state = double :player_state
      game_state = double :game_state
      player = create :player

      action = Action.create(
        action: 'draw_train_card',
        player: player,
        card_index: card_index,
      )

      allow(game_state)
        .to receive(:player)
        .with(player.id)
        .and_return(player_state)

      expect(action.defrost game_state).to be_a Actions::DrawTrainCard
    end
  end
end
