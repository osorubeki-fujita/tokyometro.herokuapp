class ButtonProcessor

  constructor: ( @domain ) ->

  has_icon = (v) ->
    return ( v.domain.children( 'i' ).length > 0 )

  icon = (v) ->
    return v.domain.children( 'i' ).first()

  process: ->
    if has_icon(@)
      _icon = icon(@)
      w = @domain.width()
      h = @domain.height()
      pw = new DomainsHorizontalAlignProcessor( icon(@) , w , 'center' )
      ph = new DomainsVerticalAlignProcessor( icon(@) , h , 'middle' )
      pw.process()
      ph.process()
    return

window.ButtonProcessor = ButtonProcessor