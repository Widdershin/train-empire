How is game state communicated to the client?
    - via JSON over a real time connection (WS, pusher, firebase...)


How are moves communicated to the server?
    - via JSON sent over HTTP. The server will provide a RESTful API


What is the responsibility of the client?
    - To display game state
    - To send player actions to the server


Is it important for players to see what other players did?
    - Probably. You should at least be able to see if a player draws a face up cardß


How are turns handled? How is midturn state handled? (ie, I draw one specific card, and now can draw another)
    - The GameState class has a current_turn_user
    - Basic flow:
        - Player loads game.
        - Current player makes move (POST to server)
        - Server redirects to game

    /games/id/actions/:action

    /games/id/actions/draw_railcar_card, index: 0-4 | random
    /games/id/actions/draw_destination_cards
    /games/id/actions/keep_destination_cards, cards_to_keep: [ids]
    /games/id/actions/claim_route, route_id

How should I handle authorization?