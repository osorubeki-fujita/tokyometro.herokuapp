class LinkDomainsToSetHoverEvent

  constructor: ->

  li_domains_in_left_side_menu = (v) ->
    return $( 'ul#links_to_main_contents , ul#links_to_other_websites , ul#links_to_documents' )
      .children( 'li' )

  li_domains_of_links_to_document_pages = (v) ->
    return $( 'ul#links_to_document_pages' )
      .children( 'li' )

  li_domains_of_links_to_year_pages = (v) ->
    return $( 'ul#links_to_year_pages' )
      .find( 'li.tokyo_metro' )

  li_domains_of_link_to_fare_contents_of_railway_lines = (v) ->
    return $( '#fare_contents' )
      .children( 'ul#links_to_railway_line_pages' )
      .find( 'li.railway_line' )
      .not( '.title' )

  li_domains_of_links_to_station_info_pages = (v) ->
    return $( '#links_to_station_info_pages' )
      .children( 'ul#links , ul#links_to_station_facility_info_of_connecting_other_stations' )
      .children( 'li' )

  li_domains_of_links_to_railway_line_pages_from_station_facility_page = (v) ->
    return $( '#tokyo_metro_railway_lines' )
      .children( 'ul#railway_lines_in_this_station , ul#railway_lines_in_another_station' )
      .children( 'li' )

  li_domains_of_links_to_railway_line_pages_from_platform_info = (v) ->
    return $( 'ul.transfer_infos_for_this_position' )
      .children( 'li.transfer_info' )

  li_domains_of_links_to_railway_line_pages_from_railway_line_info = (v) ->
    return $( '#travel_time' )
      .find( 'td.transfer' )
      .children( 'ul.railway_lines' )
      .children( 'li.railway_line' )

  li_domains_of_platform_info_tabs = (v) ->
    return $( 'ul#platform_info_tabs' )
      .children( 'li' )

  list = (v) ->
    ary = []
    ary.push li_domains_in_left_side_menu(v)
    ary.push li_domains_of_links_to_document_pages(v)
    ary.push li_domains_of_links_to_year_pages(v)
    ary.push li_domains_of_link_to_fare_contents_of_railway_lines(v)
    ary.push li_domains_of_links_to_station_info_pages(v)
    ary.push li_domains_of_links_to_railway_line_pages_from_station_facility_page(v)
    ary.push li_domains_of_links_to_railway_line_pages_from_platform_info(v)
    ary.push li_domains_of_links_to_railway_line_pages_from_railway_line_info(v)
    ary.push li_domains_of_platform_info_tabs(v)
    return ary

  set_hover_event: ( mouse_in , mouse_out ) ->
    $.each list(@) , ->
      $(@).hover( mouse_in , mouse_out )
      return
    return

$(document).on 'page:change', ->
  $ ->

    add_class_hover = ->
      $( this ).addClass( 'hover' , { duration: 200 , children: true } )
      # console.log 'add_class_hover'
      return

    remove_class_hover = ->
      $( this ).removeClass( 'hover' , { duration: 300 , children: true } )
      # console.log 'remove_class_hover'
      return

    p = new LinkDomainsToSetHoverEvent()
    p.set_hover_event( add_class_hover , remove_class_hover )

    #--------------------------------

    railway_line_domains_in_links_to_passenger_survey = $( 'ul#links_to_passenger_survey_pages' )
      .children( 'ul#links_to_railway_line_pages , ul#links_to_railway_line_pages_of_this_station' )
      .children( 'ul.each_railway_line' )

    railway_line_domains_in_links_to_passenger_survey
      .children( 'li.railway_line , li.survey_year' )
      .hover( add_class_hover , remove_class_hover )

    if railway_line_domains_in_links_to_passenger_survey.length > 0
      animation_for_railway_line_domain = new AnimationForRailwayLineDomains( railway_line_domains_in_links_to_passenger_survey )
      animation_for_railway_line_domain.process()
      return

    return

  return