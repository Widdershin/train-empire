Feature: Hosting Games
    In order to play with others
    As a user
    I want to host a game

    Scenario: Hosting a new game
        Given I am logged in
        When I visit the games page
        And click on the host game button
        Then I should see a new game
