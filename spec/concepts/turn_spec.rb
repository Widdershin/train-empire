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

  describe "#options" do
    it 'gives a list of all valid next actions' do
      turn = Turn.new([])

      expect(turn.options).to eq [
        StateModifiers::ClaimLink,
        StateModifiers::DrawTrainCard,
        StateModifiers::DrawRouteCards,
      ]

      turn = Turn.new([StateModifiers::DrawRouteCards.new(nil)], current: true)

      expect(turn.options).to eq [
        StateModifiers::KeepRouteCards,
      ]
    end
  end
end
