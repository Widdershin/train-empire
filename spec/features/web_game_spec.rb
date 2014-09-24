require 'rails_helper'

describe 'web game', type: :feature do
  let(:user) { create :user }

  before do
    visit '/games'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'swordfish'

    click_button 'Sign in'

    visit '/games'

    click_link 'Host Game'
  end

  it 'only lets you draw route cards at the start of the game' do
    first('.cards .card').click
    expect(page).to have_content 'You must draw route cards to start'
  end

  it 'lets you draw at least two route cards' do
    checkboxes = all('.route-cards input[type=checkbox]')
    expect(checkboxes.count).to eq 3
    checkboxes.first.set(true)
    checkboxes.last.set(true)
    click_button 'Keep Route Cards'

    expect(page).to have_no_selector('.flash.error')
  end

end
