module WebGameHelper
  ERROR_SELECTOR = '.flash.error'

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

  def claim_link!(id:, cards:)
    checkboxes = all('.hand input[type=checkbox]')

    checkboxes.each_with_index do |box, index|
      box.set(true) if cards.include? index
    end

    click_city_link(id)

    check_for_errors!
  end

  def find_link(id)
    find(link_selector(id))
  end

  def link_selector(id)
    ".link[data-id='#{id}']"
  end

  def click_city_link(id)
    #https://github.com/teampoltergeist/poltergeist/issues/331
    if Capybara.javascript_driver == :poltergeist
      page.execute_script(<<-javascript)
        var svgEl = document.querySelector("#{link_selector(id)}");
        var clickEvent = document.createEvent('MouseEvents');
        clickEvent.initMouseEvent('click',true,true);
        svgEl.dispatchEvent(clickEvent);
      javascript
    else
      find_link(id).click
    end
  end

  def draw_route_cards!
    click_button 'Draw Route Cards'
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

  def draw_train_card!(color = nil)
    color_class = ".#{color}" if color
    card = first(".cards .card#{color_class}:not(.wild)")
    if card.nil?
      p all('.cards .card').map { |card| card[:class] }
    end
    card.click

    check_for_errors!
  end

  def check_for_errors!
    expect(page).to have_no_selector(ERROR_SELECTOR),
      -> { first(ERROR_SELECTOR).text }
  end

  def as(player)
    unless page.text.include? "Signed in as #{player.username}"
      log_out!
      log_in! player
    end

    unless current_path == @game_path
      visit @game_path
    end

    yield
  end

  def hand
    all('.hand .card').map do |card|
      /card (\w+)/.match(card[:class])[1].to_sym
    end
  end

end
