require 'rails_helper'

RSpec.describe GameState do
  describe 'make' do
    let (:players) { double :players, map: self }
    let (:game) { double :game, seed: 10, players: players }
    let (:fake_deck) { double :deck }
    let (:creation_service) { double :creation_service, make: fake_deck }
    let(:player_states) { double :player_states }
    let (:fake_game_state) { double :game_state }

    before do
      allow(DeckCreationService)
        .to receive(:new)
        .and_return(creation_service)

      allow(PlayerStateCreationService)
        .to receive(:from_players)
        .and_return(player_states)

      allow(GameState)
        .to receive(:new)
        .and_return(fake_game_state)

      allow(fake_game_state)
        .to receive(:replenish_available_cards)
        .and_return(fake_game_state)
    end

    describe "collaboration" do
      it "creates a train deck with the game's seed" do
        expect(creation_service)
          .to receive(:make)
          .with(:train, game.seed)
      end

      it "passes the game's players to PlayerStateCreationService" do
        expect(PlayerStateCreationService)
          .to receive(:from_players)
          .with(game.players)
      end

      it "creates an instance on GameState with a deck and players" do
        expect(GameState)
          .to receive(:new)
          .with(player_states, fake_deck)
      end

      it "replenishes the available cards" do
        expect(fake_game_state)
          .to receive(:replenish_available_cards)
      end

      after { GameState.make game }
    end

    it "returns the created instance" do
      expect(GameState.make game).to eq fake_game_state
    end
  end

  describe "#replenish_available_cards" do
    let(:card) { double :card }
    let(:fake_deck) { double :deck, draw: card }
    let(:game_state) { GameState.new([], fake_deck) }

    it 'draws from the train_deck until full' do
      expect(fake_deck)
        .to receive(:draw)
        .exactly(GameState::AVAILABLE_TRAIN_CARDS).times
    end

    it 'adds the drawn cards to the available_train_cards' do
      expect(game_state.available_train_cards)
        .to receive(:<<)
        .with(card)
        .exactly(GameState::AVAILABLE_TRAIN_CARDS).times
        .and_call_original
    end

    after { game_state.replenish_available_cards }
  end

  it 'has a nice string representation' do
    game_state = GameState.new(
      [double(:player), double(:player)],
      double(:deck, count: 105)
    )

    expect(game_state.to_s)
      .to eq 'GameState - 2 players, 105 cards in deck'
  end

  describe '#take_available_train_card' do
    # TODO - make this test elegant

    it 'removes the card at the given index and returns it' do
      game_state = GameState.new(double(:player_states), double(:deck))
      card_index = 2

      card = double :card
      desired_card = double :desired_card

      fake_available_train_cards = [card, card, desired_card, card, card]

      allow(game_state)
        .to receive(:available_train_cards)
        .and_return(fake_available_train_cards)

      expect(game_state.take_available_train_card card_index)
        .to eq desired_card
    end
  end

  describe "#player" do
    it 'returns the player state for the player with the given id' do
      player = double :player, name: 'Tim', id: 5

      game_state = GameState.new([player], double(:deck))

      expect(game_state.player player.id).to eq player
    end
  end
end
