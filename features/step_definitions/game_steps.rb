Given(/^I am logged in$/) do
  @user = create :user

  visit '/users/sign_in'
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: 'swordfish'
  click_button 'Sign in'
end

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