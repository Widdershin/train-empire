require 'rails_helper'
require_relative 'web_game_helper'

describe 'web game', type: :feature do
  include WebGameHelper

  let(:user) { create :user }
  let(:user2) { create :user }

  before do
    log_in! user

    visit '/games'

    click_link 'Host Game'
  end

  it 'only lets you draw route cards at the start of the game' do
    first('.cards .card').click
    expect(page).to have_content 'You must draw route cards to start'
  end

  it 'lets you draw at least two route cards' do
    keep_route_cards! [0, 1]

    expect(page).to have_no_selector('.flash.error')
  end

  describe 'after the initial round' do
    before do
      @game_path = current_path

      keep_route_cards! [0, 1]

      log_out!
      log_in! user2

      visit @game_path
      click_link 'Join Game'

      keep_route_cards! [0, 1]

      log_out!
      log_in! user

      visit @game_path
    end

    it 'lets you draw two train cards' do
      draw_train_card!
      draw_train_card!
      expect(page).to have_selector('.hand .card', count: 6)
    end
  end

end

