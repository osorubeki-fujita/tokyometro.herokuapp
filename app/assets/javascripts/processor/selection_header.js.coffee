class SelectionHeaderProcessor

  constructor: ( @domains = $( '.selection_header' ) ) ->

  selection_headers_are_present = (v) ->
    return v.domains.length > 0

  process: ->
    if selection_headers_are_present(@)
      p = new ContentHeaderProcessor( @domains )
      p.process()
      return
    return

window.SelectionHeaderProcessor = SelectionHeaderProcessor
