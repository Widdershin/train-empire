Feature: Games List
    In order to play with others
    As a user
    I want to see games I can play

    Scenario: Seeing games I am in
        Given I am logged in
        And I am in a game
        When I visit the games page
        Then I should see the game I am in

    Scenario: Opening a game from the list
        Given I am logged in
        And I am in a game
        When I visit the games page
        And I click on the game
        Then I should see the page for the game

    Scenario: Joining a game
        Given I am logged in
        And someone else has hosted a game
        When I visit the games page
        And I click on the game
        Then I should see the page for the game