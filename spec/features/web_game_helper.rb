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
    indexes = []

    my_hand = hand
    cards.each_with_index do |card, index|
      raise 'no card of that color in hand' unless my_hand.include? card

      card_index = my_hand.find_index(card)
      my_hand[card_index] = :taken

      indexes << card_index
    end

    checkboxes = all('.hand input[type=checkbox]')

    checkboxes.each_with_index do |box, index|
      box.set(true) if indexes.include? index
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
      page.execute_script(<<-JAVASCRIPT)
        var svgEl = document.querySelector("#{link_selector(id)}");
        var clickEvent = document.createEvent('MouseEvents');
        clickEvent.initMouseEvent('click',true,true);
        svgEl.dispatchEvent(clickEvent);
      JAVASCRIPT
    else
      find_link(id).click
    end
  end

  def draw_route_cards
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

  def draw_train_card(color = nil)
    color_class = ".#{color}" if color
    card = first(".cards .card#{color_class}:not(.wild)")

    if card.nil?
      p all('.cards .card').map { |card| card[:class] }
    end

    card.click

    check_for_errors!
  end

  def draw_wild_card!
    first('.cards .wild').click

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
    find('.hand', match: :first)
    within('.hand') do
      all('.card').map do |card|
        /card (\w+)/.match(card[:class])[1].to_sym
      end
    end
  end

  def smallest_train_count
    page.text.scan(/\d+ trains/).map(&:to_i).min
  end

  def claim_or_draw
    hand_without_wild, wild_cards = hand.partition { |color| color != :wild }

    biggest_card_group = hand_without_wild
      .group_by { |c| c }
      .map { |_, cards_of_color| cards_of_color }
      .max_by(&:size).to_a + wild_cards

    link = cheapest_link

    if hand.any? && biggest_card_group.size >= link.cost
      claim_link!(id: link.id, cards: biggest_card_group[0..link.cost - 1])
    else
      if first('.cards .wild')
        draw_wild_card!
      else
        colors = []

        color = biggest_card_group.first
        if color == :wild
          color = nil
        end

        card_with_right_color_count = all(".cards .card#{ ".#{color}" if color}").size

        if color.nil?
          card_with_right_color_count = 0
        end

        card_with_right_color_count.times { colors << color }
        until(colors.size >= 2)
          colors << nil
        end

        draw_train_card!(colors.shift)
        draw_train_card!(colors.shift)
      end
    end
  end

  def cheapest_link
    link = all('.link.gray').min_by { |link| link['data-cost'].to_i }
    Struct.new(:id, :cost).new(link['data-id'].to_i, link['data-cost'].to_i)
  end

  def save_game(name)
    game_json = GameSerializerService.new.serialize(Game.last)
    File.open("#{Rails.root}/spec/fixtures/#{name}.json", 'w') { |file| file.write(game_json) }
  end

  def load_game(name)
    game_json = File.read("#{Rails.root}/spec/fixtures/#{name}.json")
    game = GameSerializerService.new.deserialize(game_json)

    @game_path = game_path(game)
    game
  end
end
