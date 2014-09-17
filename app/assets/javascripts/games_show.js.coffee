# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

TicketToRide = do ->
  publik = {}
  currentTurn = 0

  getTurn = (callback) ->
    $.get "#{window.location.href}/action_count", (data) ->
      callback(parseInt(data))

  publik.updateIfNeeded = ->
    getTurn (newTurn) ->
      if newTurn > currentTurn
        console.log("updating from #{currentTurn} to #{newTurn}")
        location.reload()

  publik.startGame = ->
    getTurn (newTurn) ->
      console.log("Starting at #{newTurn}")
      currentTurn = newTurn
      setInterval(publik.updateIfNeeded, 1000)

  publik.startGame()

