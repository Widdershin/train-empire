Revised Architecture

User
  - username
  - email
  - players
  - games

Game
  - players

Player
  - belong_to game
  - belong_to user
  - actions

Action
  - apply_to_game

  DrawRailcarCard
  DrawRouteCard
  KeepRouteCard
  ClaimRoute

Route
  - city_a
  - city_b
  - color
  - cost

RouteCard
  - city_a
  - city_b
  - points

RailcarCard
  - color