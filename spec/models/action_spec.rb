require 'rails_helper'

describe Action, :type => :model do
  it { should validate_presence_of :action }
  it { should belong_to :player }

  describe 'defrosting' do
    let(:player) { mock_model('Player') }
    let(:card_index) { 1 }

    it 'returns an instance of an action modifier (words?)' do
      action = Action.create(
        action: 'draw_train_card',
        player: player,
        card_index: card_index,
      )

      expect(action.defrost).to be_a Actions::DrawTrainCard
      expect(action.card_index).to eq 1
    end

    it 'defrosts DrawRouteCards' do
      action = Action.create(
        action: 'draw_route_cards',
        player: player,
      )

      expect(action.defrost).to be_a Actions::DrawRouteCards
    end

    it 'defrosts KeepRouteCards' do
      cards_to_keep = [0, 2, 3]

      action = Action.create(
        action: 'keep_route_cards',
        player: player,
        route_cards_to_keep: cards_to_keep
      )

      expect(action.defrost).to be_a Actions::KeepRouteCards
      expect(action.reload.route_cards_to_keep).to eq cards_to_keep
    end

    it 'defrosts ClaimRoute' do
      route_id = 5

      action = Action.create(
        action: 'claim_route',
        player: player,
        route_id: route_id
      )

      expect(action.defrost).to be_a Actions::ClaimRoute
      expect(action.route_id).to eq route_id
    end
  end

  describe '#defrosted_class' do
    it 'returns the appropriate action class' do
      action = Action.create(
        action: 'draw_route_cards'
      )

      expect(action.defrosted_class).to eq Actions::DrawRouteCards
    end
  end
end
