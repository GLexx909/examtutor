jQuery ->
  new Moduls()

class Moduls
  constructor: ->
    @init_sortable()

  init_sortable: =>
    $('#moduls_sortable').sortable
      axis: 'y'
      handle: '.handle'
      update: ->
        $.post($(this).data('update-url'), $(this).sortable('serialize'))
