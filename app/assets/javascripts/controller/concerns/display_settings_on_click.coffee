class DisplaySettingsOnClick

  constructor: ( @domain , @button , @i_in_button ) ->

  visible = (v) ->
    return v.domain.hasClass( 'visible' )

  hidden = (v) ->
    return v.domain.hasClass( 'hidden' )

  process: ->
    if visible(@)
      @domain.removeClass( 'visible' ).addClass( 'hidden' )
      @button.removeClass( 'minimize' ).addClass( 'display' )
      @i_in_button.removeClass( 'fa-chevron-up' ).addClass( 'fa-chevron-down' )

    else if hidden(@)
      @domain.removeClass( 'hidden' ).addClass( 'visible' )
      @button.removeClass( 'display' ).addClass( 'minimize' )
      @i_in_button.removeClass( 'fa-chevron-down' ).addClass( 'fa-chevron-up' )
    return

window.DisplaySettingsOnClick = DisplaySettingsOnClick