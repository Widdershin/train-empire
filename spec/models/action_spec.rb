require 'rails_helper'

describe Action, :type => :model do
  it { should validate_presence_of :name }
  it { should belong_to :player }
  it { should respond_to :cards_to_spend }

  describe 'to_modifier' do
    let(:player) { mock_model('Player') }
    let(:card_index) { 1 }

    it 'returns an instance of a state modifier modifier (words?)' do
      action = Action.create(
        name: 'draw_train_card',
        player: player,
        card_index: card_index,
      )

      expect(action.to_modifier).to be_a StateModifiers::DrawTrainCard
      expect(action.card_index).to eq 1
    end

    it 'defrosts DrawRouteCards' do
      action = Action.create(
        name: 'draw_route_cards',
        player: player,
      )

      expect(action.to_modifier).to be_a StateModifiers::DrawRouteCards
    end

    it 'defrosts KeepRouteCards' do
      cards_to_keep = [0, 2, 3]

      action = Action.create(
        name: 'keep_route_cards',
        player: player,
        route_cards_to_keep: cards_to_keep
      )

      expect(action.to_modifier).to be_a StateModifiers::KeepRouteCards
      expect(action.reload.route_cards_to_keep).to eq cards_to_keep
    end

    it 'defrosts ClaimLink' do
      link_id = 5

      action = Action.create(
        name: 'claim_link',
        player: player,
        link_id: link_id
      )

      expect(action.to_modifier).to be_a StateModifiers::ClaimLink
      expect(action.link_id).to eq link_id
    end
  end
end
