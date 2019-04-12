jQuery ->
  new Topics()

class Topics
  constructor: ->
    @init_sortable()

  init_sortable: =>
    $('#topics_sortable').sortable
      axis: 'y'
      handle: '.handle'
      update: ->
        $.post($(this).data('update-url'), $(this).sortable('serialize'))
