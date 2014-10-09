require 'rails_helper'
require_relative 'web_game_helper'

describe 'end game', type: :feature, js: true do
  include WebGameHelper

  it 'can be won', slow: true do
    pending 'being worth running'
    until smallest_train_count <= 3 do
      as fred do
        claim_or_draw
      end

      as wilma do
        claim_or_draw
      end
    end

    as fred do
      expect(smallest_train_count).to be < 5
      draw_route_cards
      keep_route_cards! [0, 1]
    end

    as wilma do
      draw_route_cards
      keep_route_cards! [0, 1]
    end

    as fred do
      expect(page).to have_content 'Game Over'
    end
  end


  it 'can be won fast' do
    visit '/games'

    game = load_game('near-end')
    fred, wilma = game.users.order(:id)

    log_in! fred

    as fred do
      expect(page).to_not have_content('Final Turn')
      claim_link!(id: 90, cards: [:green] * 2)
    end

    as wilma do
      expect(page).to have_content('Final Turn')
      draw_train_card
      draw_train_card
      expect(page).to have_content('Final Turn')
    end

    as fred do
      draw_train_card
      draw_train_card
      expect(page).to have_content('Game Over')
    end
  end
end
