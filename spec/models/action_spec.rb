require 'rails_helper'

RSpec.describe Action, :type => :model do
  it { should validate_presence_of :type }
  it { should belong_to :player }

  describe 'defrosting' do
    it 'returns an instance of an action modifier (words?) given a gamestate' do
      fake_player = double :player, id: 1
      card_index = 1

      action = Action.create(
        action: 'draw_train_card',
        player_id: fake_player.id,
        card_index: card_index,
      )

      expect(action.defrost).to be_a Actions::DrawRailcarCard
    end
  end
end
