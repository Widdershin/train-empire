Player
  has many cards_in_hand
  has many destination cards

RailcarCard
  color

DestinationCard
  route
  route_value

City
  has many routes

Route
  origin_city
  destination_city
  owner, default: unclaimed
  color
