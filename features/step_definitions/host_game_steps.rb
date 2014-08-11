Given(/^I am logged in$/) do
  test_password = 'foo@bar.com'

  @user = create :user

  visit '/users/sign_in'
  fill_in 'Email', with: 'foo@bar.com'
  fill_in 'Password', with: test_password
  click_button 'Sign in'
end

When(/^I visit the games page$/) do
  visit '/games'
end

When(/^click on the host game button$/) do
  click_link 'Host Game'
end

Then(/^I should see a new game$/) do
  expect(page).to have_content 'Welcome to your new game'
end