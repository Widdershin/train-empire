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
        location.reload()

  publik.startGame = ->
    getTurn (newTurn) ->
      currentTurn = newTurn
      setInterval(publik.updateIfNeeded, 1000)

  $('.link').on 'click', ->
    linkToClaim = $(this).data('id')

    cardsToSpendInputs = ''

    cardsToSpend = $('.hand input[type=checkbox]').each (index, checkbox) ->
      if $(checkbox).is(":checked")
        cardsToSpendInputs += "<input type='checkbox' name='cards_to_spend[]' value='#{index}' checked />"

    form = $("<form action='#{window.location.href}/actions/create' method='POST'>" +
      "<input type='hidden' name='action_type' value='claim_link'>" +
      "<input type='hidden' name='link_id' value='#{linkToClaim}'>" +
      cardsToSpendInputs + '</form>')

    $(document.body).append(form)

    form.submit()
  publik.startGame()

