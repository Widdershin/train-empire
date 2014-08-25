require 'rails_helper'

RSpec.describe Action, :type => :model do
  it { should validate_presence_of :action }
  it { should belong_to :player }

  describe 'defrosting' do
    it 'returns an instance of an action modifier (words?)' do
      card_index = 1

      player = mock_model('Player')

      action = Action.create(
        action: 'draw_train_card',
        player: player,
        card_index: card_index,
      )

      soft_action = double :soft_action

      expect(Actions::DrawTrainCard)
        .to receive(:new)
        .with(player.id, card_index)
        .and_return(soft_action)

      expect(action.defrost).to eq soft_action
    end
  end
end
