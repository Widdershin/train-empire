Given(/^someone else has hosted a game$/) do
  @other_user = create :user
  @game = @other_user.host_game
end

Given(/^I am in a game$/) do
  @game = @user.host_game
end

When(/^I visit the games page$/) do
  visit '/games'
end

When(/^I click on the host game button$/) do
  click_link 'Host Game'
end

When(/^I visit that game$/) do
  visit game_path @game
end

Then(/^I should see a new game$/) do
  expect(page).to have_content 'Welcome to your new game'
end

Then(/^I should see the game I am in$/) do
  expect(page).to have_content "Game: #{@game.id}"
end

When(/^I click on the game$/) do
  click_link "Game: #{@game.id}"
end

Then(/^I should see the page for the game$/) do
  expect(current_path).to eq game_path(@game)
end

Then(/^I should see my username$/) do
  expect(page).to have_content @user.username
end

When(/^I click on the join button$/) do
  click_link 'Join Game'
end

Then(/^I should be in the game$/) do
  expect(page).to have_content @user.username
end

Given(/^I am playing a game$/) do
  visit '/games'
  click_link 'Host Game'
end

When(/^I draw a train card$/) do
  first('input[type=submit][value="Draw"]').click
end

Then(/^I should have a new card in my hand$/) do
  expect(page).to have_selector('.hand .card', count: 1)
end
