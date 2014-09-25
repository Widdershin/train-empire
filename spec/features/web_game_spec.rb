require 'rails_helper'
require_relative 'web_game_helper'

describe 'web game', type: :feature do
  include WebGameHelper

  let(:fred) { create :user }
  let(:wilma) { create :user }

  before do
    log_in! fred

    visit '/games'

    click_link 'Host Game'
    Game.last.update_attributes!(seed: 1)
    @game_path = current_path
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
      as fred do
        keep_route_cards! [0, 1]
      end

      as wilma do
        click_link 'Join Game'

        keep_route_cards! [0, 1]
      end
    end

    it 'lets you draw two train cards' do
      as fred do
        draw_train_card!
        draw_train_card!
        expect(page).to have_selector('.hand .card', count: 6)
      end
    end

  end

end

