Given(/^I am logged in$/) do
  @user = create :user

  visit '/users/sign_in'
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: 'swordfish'
  click_button 'Sign in'
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