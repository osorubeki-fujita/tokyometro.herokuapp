class LinksToStationInfoPages

  constructor: ( @domain = $( '#links_to_station_info_pages' ) ) ->

  links_to_station_info_pages_are_present = (v) ->
    return ( v.domain.length > 0 )

  links = (v) ->
    return v.domain.children( "ul#{ v.ul_id }" )

  li_domains = (v) ->
    return links(v).children( 'li' )

  number_of_li_domains = (v) ->
    return li_domains(v).length

  max_width_of_li = (v) ->
    p = new DomainsCommonProcessor( li_domains(v) )
    return p.max_width()

  process: ->
    process_each( @ , '#list_of_links_to_station_pages' )
    process_each( @ , '#list_of_links_to_station_facility_page_of_connecting_other_stations' )
    return

  process_each = ( v , ul_id ) ->
    v.ul_id = ul_id
    if links_to_station_info_pages_are_present(v)
      li_domains(v).each ->
        li = new SideMenuEachLink( $(@) , '.link_to_content' )
        li.process()
        return
      set_width_to_li(v)
      # set_height_to_ul(v)
      set_clear_to_li(v)
    return

  set_width_to_li = (v) ->
    w = max_width_of_li(v)
    li_domains(v).each ->
      $(@).css( 'width' , w )
      return
    return

  set_clear_to_li = (v) ->
    if v.li_rows > 1
      i = v.actual_in_a_row
      while i < number_of_li_domains(v)
        li_domains(v).eq(i).css( 'clear' , 'both' )
        i += v.actual_in_a_row
    return

  get_li_rows = (v) ->
    if in_a_single_row(v)
      r = 1
      actual_in_a_row = number_of_li_domains(v)
    else
      max_in_a_row = Math.floor( outer_main_domain_width(v) * 1.0 / max_width_of_li(v) )
      r = Math.ceil( number_of_li_domains(v) * 1.0 / max_in_a_row )
      actual_in_a_row = max_in_a_row
      while ( actual_in_a_row - 1 ) * r >= number_of_li_domains(v)
        actual_in_a_row -= 1
    v.li_rows = r
    v.actual_in_a_row = actual_in_a_row
    return

  in_main_content_center = (v) ->
    return ( $( '#main_content_center' ).length > 0 )

  in_main_content_wide = (v) ->
    return ( $( '#main_content_wide' ).length > 0 )

  outer_main_domain = (v) ->
    if in_main_content_center(v)
      d = $( '#main_content_center' )
    else if in_main_content_wide(v)
      d = $( '#main_content_wide' )
    else
      d = false
    return d

  outer_main_domain_width = (v) ->
    return outer_main_domain(v).width()

  in_a_single_row = (v) ->
    return ( max_width_of_li(v) * number_of_li_domains(v) + 1 <= outer_main_domain_width(v) )

window.LinksToStationInfoPages = LinksToStationInfoPages
