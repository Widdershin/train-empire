require 'rails_helper'

describe Turn do
  let (:turn) { Turn.new [] }

  subject { turn }

  it { should respond_to :current? }

  describe '#valid?' do
    it 'is true when the modifiers match a turn pattern' do
      turn = Turn.new [StateModifiers::ClaimLink.new(nil, nil)]

      expect(turn).to be_valid
    end

    it 'is false when the modifiers are not in a known pattern' do
      turn = Turn.new([
        StateModifiers::DrawRouteCards.new(nil),
        StateModifiers::DrawTrainCard.new(nil, nil),
      ])

      expect(turn.valid?).to eq false
    end
  end
end
