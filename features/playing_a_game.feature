Feature: Playing Games
    In order to play with others
    As a user I want to play

    Scenario: Drawing a card
        Given I am logged in
        And I am playing a game
        When I draw a train card
        Then I should have a new card in my hand

    Scenario: Drawing route cards
        Given I am logged in
        And I am playing a game
        When I draw route cards
        Then I should see some route cards
