$(document).on 'page:change', ->

  $ ->

    add_class_hover = ->
      $( this ).addClass( 'hover' , { duration: 200 , children: true } )
      # console.log 'add_class_hover'
      return

    remove_class_hover = ->
      $( this ).removeClass( 'hover' , { duration: 800 , children: true } )
      # console.log 'remove_class_hover'
      return

    $( 'ul#links_to_main_contents , ul#links_to_other_websites , ul#links_to_documents , ul#links_to_document_pages' )
      .children( 'li' )
      .hover( add_class_hover , remove_class_hover )

    $( 'ul#links_to_year_pages' )
      .find( 'li.tokyo_metro' )
      .hover( add_class_hover , remove_class_hover )

    $( '#fare_contents' )
      .children( 'ul#links_to_railway_line_pages' )
      .find( 'li.railway_line' )
      .not( '.title' )
      .hover( add_class_hover , remove_class_hover )

    $( '#links_to_station_info_pages' )
      .children( 'ul#links , ul#links_to_station_facility_info_of_connecting_other_stations' )
      .children( 'li' )
      .hover( add_class_hover , remove_class_hover )

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