class ConnectingRailwayLineInfo

  constructor: ->

  transfer_infos = (v) ->
    return $( 'li.transfer_info' )

  railway_lines = (v) ->
    return $( 'li.railway_line' )

  set_tooltip = (v) ->
    _option =
      potision:
        my: "left top"
        at: "left bottom"
      content: ->
        element = $(@)
        if checkAttr( "title" , { is_included_in: element } )
          str = ""
          str += "<div class='text_ja'>"
          for item in element.attr( "title" ).split( "／" )
            str += "<p>#{ item }</p>"
          str += "</div>"
          return str
      items: "[title]"
      track: false
      tooltipClass: 'connecting_railway_line'

    $.each [ transfer_infos(v) , railway_lines(v) ] , ->
      @.find( '.info , .remark' ).tooltip( _option )
      return
    return

  process: ->
    set_tooltip(@)
    return

window.ConnectingRailwayLineInfo = ConnectingRailwayLineInfo
