module WebGameHelper
  def log_in!(user)
    visit '/users/sign_in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'swordfish'

    click_button 'Sign in'
  end

  def log_out!
    visit '/games'
    click_on 'Sign Out'
  end

  def keep_route_cards!(indices)
    checkboxes = all('.route-cards input[type=checkbox]')
    expect(checkboxes.count).to eq 3

    checkboxes.each_with_index do |box, index|
      box.set(true) if indices.include? index
    end

    click_button 'Keep Route Cards'

    check_for_errors!
  end

  def draw_train_card!
    first('.cards .card:not(wild)').click

    check_for_errors!
  end

  def check_for_errors!
    expect(page).to have_no_selector('.flash.error'),
      -> { first('.flash.error').text }
  end

end
