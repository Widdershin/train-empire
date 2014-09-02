require 'rails_helper'

describe Actions::KeepRouteCards do
  let (:cards_to_keep) { [0, 2, 3] }
  let (:action) { Actions::KeepRouteCards.new cards_to_keep }

  it 'has a list of card indexes to keep' do
    expect(action.cards_to_keep).to eq cards_to_keep
  end
end
