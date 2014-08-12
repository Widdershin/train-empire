Feature: Player List
    In order to see who is playing a game
    As a player
    I want to see the names of the players in the game

    Scenario: Finding my name
        Given I am logged in
        And I am in a game
        When I visit the games page
        Then I should see my username