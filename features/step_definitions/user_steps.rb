Given(/^I am logged in$/) do
  @user = create :user

  visit '/users/sign_in'
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: 'swordfish'
  click_button 'Sign in'
end


Given(/^I am on the signup page$/) do
  visit '/users/sign_up'
end

When(/^I fill in my details$/) do
  fill_in 'Username', with: 'regina_filange'
  fill_in 'Email', with: 'test@foo.com'
  fill_in 'Password', with: 'swordfish'
  fill_in 'Password confirmation', with: 'swordfish'
end

When(/^click the signup button$/) do
  click_button 'Sign up'
end

Then(/^I should see a successful registration message$/) do
  expect(page).to have_content 'Welcome! You have signed up successfully.'
end

