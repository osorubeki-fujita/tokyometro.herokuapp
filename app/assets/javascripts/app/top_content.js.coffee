class TopContent

  constructor: ( @domain = $( 'div#top_content' ) ) ->

  text = (v) ->
    return v.domain.children( '.text' ).first()

  title = (v) ->
    return text(v).children( '.title' ).first()

  now_developing = (v) ->
    return text(v).children( '.now_developing' ).first()

  margin_top_of_now_developing = (v) ->
    return title(v).outerHeight() - now_developing(v).outerHeight()

  margin_top_and_bottom_of_text = (v) ->
    return ( v.domain.innerHeight() - title(v).outerHeight() ) * 0.5

  process: ->
    now_developing(@).css( 'margin-top' , margin_top_of_now_developing(@) )
    _margin_top_and_bottom_of_text = margin_top_and_bottom_of_text(@)
    text(@).css( 'margin-top' , _margin_top_and_bottom_of_text ).css( 'margin-bottom' , _margin_top_and_bottom_of_text )
    return

window.TopContent = TopContent