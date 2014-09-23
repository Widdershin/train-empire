require 'rails_helper'

RSpec.describe Player, :type => :model do
  it { should belong_to :user }
  it { should belong_to :game }
  it { should have_many :actions }

  it 'has a name' do
    user = create :user
    player = user.players.create

    expect(player.name).to eq user.username
  end

  describe 'can_perform?' do
    let(:user) { create :user }
    let(:game) { Game.create }
    let(:player) { game.players.find_by(user: user) }

    before do
      game.users << user
      game.save!
    end

    it 'returns true if the action is one of the games next options' do
      action = double :action, to_modifier: StateModifiers::DrawTrainCard.new(1, 1)

      expect(player.can_perform?(action)).to eq true
    end

    it 'returns false if the action cant be performed' do
      player.actions << Action.create!(action: 'draw_train_card')
      action = double :action, to_modifier: StateModifiers::KeepRouteCards.new(1, [1])

      expect(player.can_perform?(action)).to eq false
    end

    it 'returns true if this action would be the start of a new valid turn' do
      previous_turn = Turn.new([
        StateModifiers::DrawTrainCard.new(1, 1),
        StateModifiers::DrawTrainCard.new(1, 2),
      ])

      allow(game).to receive(:turns) { [previous_turn] }

      action = double :action, to_modifier: StateModifiers::DrawTrainCard.new(1, 1)
      expect(player.can_perform?(action)).to eq true
    end
  end
end
