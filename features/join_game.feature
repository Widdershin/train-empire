Feature: Joining games
    In order to play with others
    As a user
    I want to join a game

    Scenario: Joining a game
        Given I am logged in
        And someone else has hosted a game
        When I visit the games page
        And I click on the game
        And I click on the join button
        Then I should be in the game