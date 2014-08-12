Feature: Registering
    In order to authenticate
    As a user
    I want to register for the site

    Scenario: Signing up
        Given I am on the signup page
        When I fill in my details
        And click the signup button
        Then I should see a successful registration message