class TooltipsOnLinksToStation

  constructor: ( @link_domains ) ->

  set: ->
    option =
      potision:
        my: "left top"
        at: "left bottom"
      content: ->
        element = $(@)
        t = new TooltipOnLinkToStation( element )
        return t.to_html()
      items: "[data-station_code_images] , [data-text_ja] , [data-text_hira] , [data-text_en]"
      tooltipClass: 'station_name_in_tooltip'
      track: false
    @link_domains.tooltip( option )
    return

window.TooltipsOnLinksToStation = TooltipsOnLinksToStation

class TooltipOnLinkToStation

  constructor: ( @element ) ->

  station_code_images = (v) ->
    return v.element.attr( 'data-station_code_images' )

  text_ja = (v) ->
    return v.element.attr( 'data-text_ja' )

  text_hiragana = (v) ->
    return v.element.attr( 'data-text_hira' )

  text_en = (v) ->
    return v.element.attr( 'data-text_en' )

  ary_of_station_code_images = (v) ->
    return station_code_images(v).split( '/' )

  to_html: ->
    str = ""
    str += station_code_images_in_html(@)
    str += text_in_html(@)
    return str

  station_code_images_in_html = (v) ->
    str = ""
    str += "<div class='station_codes'>"
    for station_code in ary_of_station_code_images(v)
      p = new TooltipOnLinkToStationImageName( station_code )
      str += p.to_html()
    str += "</div>"
    return str

  text_in_html = (v) ->
    str = ""
    str += "<div class='text'>"
    str += "<div class='text_ja'>#{ text_ja(v) }</div>"
    str += "<div class='text_ja text_hiragana'>#{ text_hiragana(v) }</div>"
    str += "<div class='text_en'>#{ text_en(v) }</div>"
    str += "</div>"
    return str

class TooltipOnLinkToStationImageName

  constructor: ( @station_code_base ) ->

  station_code = (v) ->
    regexp = /^m(\d{2})$/
    # console.log v.station_code_base
    if regexp.test( v.station_code_base )
      str = "mm#{ v.station_code_base.match( regexp )[1] }"
    else
      str = v.station_code_base.toLowerCase()
    return str

  src = (v) ->
    return "/assets/provided_by_tokyo_metro/station_number/#{ station_code(v) }.png"

  to_html: ->
    return "<img class='station_code' alt='#{ station_code(@) }' src=#{ src(@) }>"
