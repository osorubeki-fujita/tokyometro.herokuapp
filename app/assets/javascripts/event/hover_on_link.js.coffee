class LinkDomainsToSetHoverEvent

  constructor: ->

  li_domains_in_left_side_menu = (v) ->
    return $( 'ul#links_to_main_contents , ul#links_to_other_websites , ul#links_to_documents' )
      .children( 'li' )

  li_domains_of_links_to_document_pages = (v) ->
    return $( 'ul#links_to_document_pages' )
      .children( 'li' )

  # li_domains_of_links_to_year_pages = (v) ->
    # return $( 'ul#links_to_year_pages' )
      # .find( 'li.tokyo_metro' )

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

  li_domains_to_railway_line_page_of_passenger_survey = (v) ->
    return railway_line_domains_in_links_to_passenger_survey(v)
      .children( 'li.railway_line' )

  li_domains_to_railway_line_each_year_page_of_passenger_survey = (v) ->
    return railway_line_domains_in_links_to_passenger_survey(v)
      .children( 'li.survey_year' )

  li_domains_to_operator_page_of_passenger_survey = (v) ->
    return operator_domains_in_links_to_passenger_survey(v)
      .children( 'li.tokyo_metro' )

  li_domains_to_operator_each_year_page_of_passenger_survey = (v) ->
    return operator_domains_in_links_to_passenger_survey(v)
      .children( 'li.survey_year' )

  li_domains_to_operator_each_year_page_of_passenger_survey_on_index_page = (v) ->
    return $( 'div.links_to_passenger_survey' )
      .children( 'ul#links_to_year_pages_on_index_page' )
      .children( 'li.survey_year' )

  railway_line_domains_in_links_to_passenger_survey = (v) ->
    return $( 'ul#links_to_passenger_survey_pages' )
      .children( 'ul#links_to_railway_line_pages , ul#links_to_railway_line_pages_of_this_station' )
      .children( 'ul.each_railway_line' )

  operator_domains_in_links_to_passenger_survey = (v) ->
    return $( 'ul#links_to_passenger_survey_pages' )
      .children( 'ul#links_to_year_pages' )
      .children( 'ul.operator' )

  list = (v) ->
    ary = []

    ary.push li_domains_in_left_side_menu(v)
    ary.push li_domains_of_links_to_document_pages(v)
    # ary.push li_domains_of_links_to_year_pages(v)
    ary.push li_domains_of_link_to_fare_contents_of_railway_lines(v)
    ary.push li_domains_of_links_to_station_info_pages(v)
    ary.push li_domains_of_links_to_railway_line_pages_from_station_facility_page(v)
    ary.push li_domains_of_links_to_railway_line_pages_from_platform_info(v)
    ary.push li_domains_of_links_to_railway_line_pages_from_railway_line_info(v)
    ary.push li_domains_of_platform_info_tabs(v)

    ary.push li_domains_to_railway_line_page_of_passenger_survey(v)
    ary.push li_domains_to_railway_line_each_year_page_of_passenger_survey(v)

    ary.push li_domains_to_operator_page_of_passenger_survey(v)
    ary.push li_domains_to_operator_each_year_page_of_passenger_survey(v)

    ary.push li_domains_to_operator_each_year_page_of_passenger_survey_on_index_page(v)

    return ary

  process: ->
    set_hover_event_of_escaping_class( @ , 'this_station' )
    set_hover_main_event(@)
    set_hover_event_to_li_domains_to_each_year_page_of_passenger_survey(@)
    return

  set_hover_event_of_escaping_class = ( v , class_name ) ->

    escaping = ->
      if $(@).hasClass( class_name )
        $(@).removeClass( class_name , { duration: 10 , children: true } )
        $(@).addClass( "_#{ class_name }" )
      return

    reviving = ->
      if $(@).hasClass( "_#{ class_name }" )
        $(@).removeClass( "_#{ class_name }" , { duration: 10 , children: true } )
        $(@).addClass( class_name )
      return

    $.each list(v) , ->
      @.hover( escaping , reviving )
      return

    return

  set_hover_main_event = (v) ->

    add_class_hover = ->
      $(@).addClass( 'hover' , { duration: 200 , children: true } )
      # console.log 'add_class_hover'
      return

    remove_class_hover = ->
      $(@).removeClass( 'hover' , { duration: 300 , children: true } )
      # console.log 'remove_class_hover'
      return

    $.each list(v) , ->
      # '.this_station' は除外しない
      @.not( '.same_category, .this_page' ).hover( add_class_hover , remove_class_hover )
      return

    return

  set_hover_event_to_li_domains_to_each_year_page_of_passenger_survey = (v) ->
    hover_on_railway_line = hover_on_event_to_li_domains_to_each_year_page_of_passenger_survey( v , 'li.railway_line' )
    hover_off_railway_line = hover_off_event_to_li_domains_to_each_year_page_of_passenger_survey( v , 'li.railway_line' )

    li_domains_to_railway_line_each_year_page_of_passenger_survey(v).each ->
      $(@).hover( hover_on_railway_line , hover_off_railway_line )
      return

    hover_on_operator = hover_on_event_to_li_domains_to_each_year_page_of_passenger_survey( v , 'li.tokyo_metro' )
    hover_off_operator = hover_off_event_to_li_domains_to_each_year_page_of_passenger_survey( v , 'li.tokyo_metro' )

    li_domains_to_operator_each_year_page_of_passenger_survey(v).each ->
      $(@).hover( hover_on_operator , hover_off_operator )
      return

    return

  hover_on_event_to_li_domains_to_each_year_page_of_passenger_survey = ( v , selector ) ->
    e = ->
      $(@)
        .prevAll( selector )
        .addClass( '_hover' , { duration: 200 , children: true } )
      return
    return e

  hover_off_event_to_li_domains_to_each_year_page_of_passenger_survey = ( v , selector ) ->
    e = ->
      $(@)
        .prevAll( selector )
        .removeClass( '_hover' , { duration: 300 , children: true } )
      return
    return e

window.LinkDomainsToSetHoverEvent = LinkDomainsToSetHoverEvent