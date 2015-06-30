class LinkDomainsToSetHoverEvent

  constructor: ->

  link_to_top_page_on_header = (v) ->
    return $( '#header' )
      .children( '.top_title' )
      .children( '.main' )

  li_domains_in_sns_accounts = (v) ->
    return $( 'ul#sns_accounts' )
      .children( 'li' )

  li_domains_in_left_side_menu = (v) ->
    return $( 'ul#links_to_main_contents , ul#links_to_other_websites , ul#links_to_documents' )
      .children( 'li' )

  li_domains_of_links_to_document_pages = (v) ->
    return $( 'ul#links_to_document_pages' )
      .children( 'li' )

  li_domains_of_link_to_fare_contents_of_railway_lines = (v) ->
    return $( '#fare_contents' )
      .children( 'ul#links_to_railway_line_pages' )
      .find( 'li.railway_line' )
      .not( '.title' )

  li_domains_of_links_to_station_info_pages = (v) ->
    return $( '#links_to_station_info_pages' )
      .children( 'ul#list_of_links_to_station_pages , ul#list_of_links_to_station_facility_page_of_connecting_other_stations' )
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

  li_domains_to_railway_line_page_of_passenger_survey = (v) ->
    return railway_line_domains_in_links_to_passenger_survey(v)
      .children( 'li.railway_line' )

  li_domains_for_railway_line_each_year_page_of_passenger_survey = (v) ->
    return railway_line_domains_in_links_to_passenger_survey(v)
      .children( 'li.survey_year' )

  li_domains_for_railway_line_each_controller_page_on_right_side_menu = (v) ->
    return railway_line_domains_in_links_for_railway_line_each_controller_pages(v)
      .children( 'li.each_controller' )

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
  
  railway_line_domains_in_links_for_railway_line_each_controller_pages = (v) ->
    return $( '#links_to_railway_line_pages' )
      .children( 'ul.each_railway_line' )

  operator_domains_in_links_to_passenger_survey = (v) ->
    return $( 'ul#links_to_passenger_survey_pages' )
      .children( 'ul#links_to_year_pages' )
      .children( 'ul.operator' )

  link_to_csv_of_table = (v) ->
    return $( '#infos_in_db' )
      .children( '.to_csv' )
      .children( '.link_to_csv' )

  li_domains_of_platform_info_tabs = (v) ->
    return $( 'ul#platform_info_tabs' )
      .children( 'li' )

  list = (v) ->
    ary = []

    ary.push( link_to_top_page_on_header(v) )
    ary.push( li_domains_in_sns_accounts(v) )
    ary.push( li_domains_in_left_side_menu(v) )
    ary.push( li_domains_of_links_to_document_pages(v) )
    ary.push( li_domains_of_link_to_fare_contents_of_railway_lines(v) )
    ary.push( li_domains_of_links_to_station_info_pages(v) )
    ary.push( li_domains_of_links_to_railway_line_pages_from_station_facility_page(v) )
    ary.push( li_domains_of_links_to_railway_line_pages_from_platform_info(v) )
    ary.push( li_domains_of_links_to_railway_line_pages_from_railway_line_info(v) )

    ary.push( li_domains_to_railway_line_page_of_passenger_survey(v) )
    ary.push( li_domains_for_railway_line_each_year_page_of_passenger_survey(v) )
    ary.push( li_domains_for_railway_line_each_controller_page_on_right_side_menu(v) )

    ary.push( li_domains_to_operator_page_of_passenger_survey(v) )
    ary.push( li_domains_to_operator_each_year_page_of_passenger_survey(v) )

    ary.push( li_domains_to_operator_each_year_page_of_passenger_survey_on_index_page(v) )
    ary.push( link_to_csv_of_table(v) )

    return ary

  process: ->
    set_hover_event_of_escaping_class( @ , 'this_station' )
    set_hover_main_event(@)

    set_hover_event_to_li_domains_of_platform_info_tabs(@)
    set_hover_event_to_li_domains_of_each_year_page_on_passenger_survey(@)
    set_hover_event_to_li_domains_for_railway_line_each_controller_page_on_right_side_menu(@)
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
    $.each list(v) , ->
      # '.this_station' は除外しない
      @.not( '.same_category, .this_page , .this_year' ).hover( add_class_hover_normally(v) , remove_class_hover_normally(v) )
      return
    return

  set_hover_event_to_li_domains_of_platform_info_tabs = (v) ->
    li_domains_of_platform_info_tabs(v).hover( add_class_hover_normally(v) , remove_class_hover_normally(v) )
    return

  add_class_hover_normally = (v) ->
    f = ->
      $(@).addClass( 'hover' , { duration: 200 , children: true } )
      # console.log 'add_class_hover'
      return
    return f

  remove_class_hover_normally = (v) ->
    f = ->
      $(@).removeClass( 'hover' , { duration: 300 , children: true } )
      # console.log 'remove_class_hover'
      return
    return f

  set_hover_event_to_li_domains_of_each_year_page_on_passenger_survey = (v) ->
    hover_on_railway_line = hover_on_event_to_li_domains_of_each_content_on_right_side_menu( v , 'li.railway_line' )
    hover_off_railway_line = hover_off_event_to_li_domains_of_each_content_on_right_side_menu( v , 'li.railway_line' )

    li_domains_for_railway_line_each_year_page_of_passenger_survey(v).each ->
      $(@).hover( hover_on_railway_line , hover_off_railway_line )
      return

    hover_on_operator = hover_on_event_to_li_domains_of_each_content_on_right_side_menu( v , 'li.tokyo_metro' )
    hover_off_operator = hover_off_event_to_li_domains_of_each_content_on_right_side_menu( v , 'li.tokyo_metro' )

    li_domains_to_operator_each_year_page_of_passenger_survey(v).each ->
      $(@).hover( hover_on_operator , hover_off_operator )
      return

    return

  set_hover_event_to_li_domains_for_railway_line_each_controller_page_on_right_side_menu = (v) ->
    hover_on_railway_line = hover_on_event_to_li_domains_of_each_content_on_right_side_menu( v , 'li.railway_line' )
    hover_off_railway_line = hover_off_event_to_li_domains_of_each_content_on_right_side_menu( v , 'li.railway_line' )

    li_domains_for_railway_line_each_controller_page_on_right_side_menu(v).each ->
      $(@).hover( hover_on_railway_line , hover_off_railway_line )
      return

    return

  hover_on_event_to_li_domains_of_each_content_on_right_side_menu = ( v , selector ) ->
    e = ->
      $(@)
        .prevAll( selector )
        .not( '.this_page' )
        .addClass( '_hover' , { duration: 200 , children: true } )
      return
    return e

  hover_off_event_to_li_domains_of_each_content_on_right_side_menu = ( v , selector ) ->
    e = ->
      $(@)
        .prevAll( selector )
        .not( '.this_page' )
        .removeClass( '_hover' , { duration: 300 , children: true } )
      return
    return e

window.LinkDomainsToSetHoverEvent = LinkDomainsToSetHoverEvent
