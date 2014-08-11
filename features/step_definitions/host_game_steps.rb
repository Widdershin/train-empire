Given(/^I am logged in$/) do
  @user = User.create
end

When(/^I visit the games page$/) do
  visit '/games'
end

When(/^click on the host game button$/) do
  click_link 'Host Game'
end

Then(/^I should see a new game$/) do
  page.should have_content 'Welcome to your new game'
end