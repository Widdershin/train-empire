Feature: Games List
    In order to play with others
    As a user
    I want to see games I can play

    Scenario: Games I am in
        Given I am logged in
        And I am in a game
        When I visit the games page
        Then I should see the game I am in
