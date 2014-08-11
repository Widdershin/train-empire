User
  A user of the site
  email
  devise stuff
  games

Player
  A player in a Game

  has a user
  has Rail Car Cards in hand
  has accepted dest tickets
  has rail car count

Game
  A game of Ticket to Ride

  has users
  has a game state
  join game!

GameState
  The persistent state of a game

  has players
  has cities
  has routes
  has RailCarDeck
  has current_player???? - need to think about how to handle turns

RailCarDeck
  cards
  draw!

RailCarCard
  color

DestinationTicket
  city_a
  city_b
  points

City
  name
  location
  routes

Route
  city_a
  city_b
  color
  cost
  owner (Player)