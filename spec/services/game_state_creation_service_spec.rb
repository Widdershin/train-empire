require 'rails_helper'

describe GameStateCreationService do
  let (:creation_service) { GameStateCreationService.new }

  it 'makes GameStates' do
    expect(creation_service.make).to be_a GameState

  end
end
