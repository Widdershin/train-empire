# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

TrainEmpire = do ->
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


  $('.hand .card').on 'click', (e) ->
    $checkbox = $(this).find('input[type=checkbox]')

    if e.target == this
      $checkbox.prop('checked', not $checkbox.prop('checked'))


  $('.city-label').css('display', 'none')

  displayLabel = (id) ->
    $(".city-label[data-id='#{id}']").show()

  hideLabel = (id) ->
    $(".city-label[data-id='#{id}']").hide()


  $('.route-card').mouseenter ->
    fromCity = $(this).data('from')
    toCity = $(this).data('to')

    displayLabel(fromCity)
    displayLabel(toCity)


  $('.route-card').mouseleave ->
    fromCity = $(this).data('from')
    toCity = $(this).data('to')

    hideLabel(fromCity)
    hideLabel(toCity)


  $('circle').mouseenter ->
    $(this).parent().find('.city-label').show()


  $('circle').mouseleave ->
    $(this).parent().find('.city-label').hide()


  publik.startGame()

