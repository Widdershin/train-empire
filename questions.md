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

How should I handle authorization?