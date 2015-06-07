class NowDevelopingProcessor

  constructor: ( @domain = $( "#now_developing" ) ) ->

  content_header = (v) ->
    return v.domain.children( '.content_header' ).first()

  domain_is_present = (v) ->
    return v.domain.length > 0

  process: ->
    if domain_is_present(@)
      process_header(@)
    return

  process_header = (v) ->
    p = new ContentHeaderProcessor( content_header(v) )
    p.process()
    return

window.NowDevelopingProcessor = NowDevelopingProcessor
