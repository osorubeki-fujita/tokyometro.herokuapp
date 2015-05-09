class UlSideMenuLinks

  constructor: ( @domain = $( '#side_menu' ) ) ->

  links_to_main_contents = (v) ->
    return v.domain.children( 'ul#links_to_main_contents' )

  links_to_documents = (v) ->
    return v.domain.children( 'ul#links_to_documents' )

  links_to_other_websites = (v) ->
    return v.domain.children( 'ul#links_to_other_websites' )

  process: ->
    process_links_to_main_contents(@)
    process_links_to_documents(@)
    process_links_to_other_websites(@)
    return

  process_links_to_main_contents = (v) ->
    process_links( v , links_to_main_contents(v) , '.link_to_content' )
    return

  process_links_to_documents = (v) ->
    process_links( v , links_to_documents(v) , '.link_to_document' )
    return

  process_links_to_other_websites = (v) ->
    process_links( v , links_to_other_websites(v) , '.link_to_other_website' )
    return

  process_links = ( v , ul_domain , class_name ) ->
    li_domains = ul_domain.children( 'li' )
    li_domains.each ->
      li = new SideMenuEachLink( $( this ) , class_name )
      li.process()
      return
    p = new DomainsCommonProcessor( li_domains )
    ul_domain.css( 'height' , p.sum_outer_height( true ) )
    return

window.UlSideMenuLinks = UlSideMenuLinks

class UlStationRelatedLinks

  constructor: ( @domain = $( '#links_to_station_info_pages' ) ) ->

  links_to_station_info_pages_are_present = (v) ->
    return ( v.domain.length > 0 )

  links = (v) ->
    return v.domain.children( 'ul' + v.ul_id )

  li_domains = (v) ->
    return links(v).children( 'li' )

  number_of_li_domains = (v) ->
    return li_domains(v).length

  max_width_of_li = (v) ->
    p = new DomainsCommonProcessor( li_domains(v) )
    return p.max_width()

  process: ->
    process_each( @ , '#links' )
    process_each( @ , '#links_to_station_facility_info_of_connecting_other_stations' )
    return

  process_each = ( v , ul_id = '#links' ) ->
    v.ul_id = ul_id
    if links_to_station_info_pages_are_present(v)
      li_domains(v).each ->
        li = new SideMenuEachLink( $(@) , '.link_to_content' )
        li.process()
        return
      set_width_to_li(v)
      set_height_to_ul(v)
      set_clear_to_li(v)
    return

  set_width_to_li = (v) ->
    w = max_width_of_li(v)
    li_domains(v).each ->
      $( this ).css( 'width' , w )
      return
    return

  set_height_to_ul = (v) ->
    links(v).css( 'height' , height_of_ul(v) )
    return

  set_clear_to_li = (v) ->
    if v.li_rows > 1
      i = v.actual_in_a_row
      while i < number_of_li_domains(v)
        li_domains(v).eq(i).css( 'clear' , 'both' )
        i += v.actual_in_a_row
    return

  height_of_ul = (v) ->
    get_li_rows(v)
    p = new DomainsCommonProcessor( li_domains(v) )
    border_width = 1
    rows = v.li_rows
    return p.max_outer_height( true ) * rows - ( rows - 1 ) * border_width

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
    # console.log actual_in_a_row
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


window.UlStationRelatedLinks = UlStationRelatedLinks

class SideMenuEachLink

  constructor: ( @domain , @class_name ) ->

  link = (v) ->
    return v.domain.children( 'a' ).first()

  link_domain = (v) ->
    return v.domain.children( v.class_name ).first()

  sub_domains_of_link_domain = (v) ->
    return link_domain(v).children()

  icon = (v) ->
    return link_domain(v).children( '.icon' ).first()

  has_icon_content = (v) ->
    return icon(v).children().length == 1

  has_font_awesome_icon = (v) ->
    return icon(v).children( 'i' ).length == 1

  has_image_icon = (v) ->
    return icon(v).children( 'img' ).length == 1

  icon_content = (v) ->
    return icon(v).children().first()

  text = (v) ->
    return link_domain(v).children( '.text' ).first()

  text_large = (v) ->
    return link_domain(v).children( '.text_large' ).first()

  sub_domains_of_text = (v) ->
    return text(v).children()

  sub_domains_of_text_large = (v) ->
    return text_large(v).children()

  has_text = (v) ->
    return ( link_domain(v).children( '.text' ).length > 0 )

  has_text_large = (v) ->
    return ( link_domain(v).children( '.text_large' ).length > 0 )

  has_sub_domains_of_text = (v) ->
    return ( sub_domains_of_text(v).length > 0 )

  has_sub_domains_of_text_large = (v) ->
    return ( sub_domains_of_text_large(v).length > 0 )

  text_ja = (v) ->
    return text(v).children( '.text_ja' ).first()

  text_en = (v) ->
    return text(v).children( '.text_en' ).first()

  process: ->
    set_position_of_icon(@)
    process_text(@)
    return

  set_position_of_icon = (v) ->
    if has_icon_content(v)
      _icon = icon(v)
      p1 = new DomainsVerticalAlignProcessor( icon(v).children() , _icon.outerHeight( false ) , 'middle' )
      p1.process()

      p2 = new DomainsHorizontalAlignProcessor( icon(v).children() , _icon.outerWidth( false ) , 'center' )
      p2.process()
    return

  process_text = (v) ->
    if has_text(v) or has_text_large(v)
      set_height_of_text(v)

      _max_outer_height_of_sub_domains = max_outer_height_of_sub_domains(v)
      set_vertical_align_of_sub_domains( v , _max_outer_height_of_sub_domains )
      set_height_of_link_domain( v , _max_outer_height_of_sub_domains )

      set_height_of_whole_domain(v)
    return

  sum_outer_height_of_text = (v) ->
    p = new DomainsCommonProcessor( sub_domains_of_text(v) )
    return p.sum_outer_height( true )

  sum_outer_height_of_text_large = (v) ->
    p = new DomainsCommonProcessor( sub_domains_of_text_large(v) )
    return p.sum_outer_height( true )

  set_height_of_text = (v) ->
    if has_text(v) and has_sub_domains_of_text(v)
      text(v).css( 'height' , sum_outer_height_of_text(v) )
    else if has_text_large(v) and has_sub_domains_of_text_large(v)
      text_large(v).css( 'height' , sum_outer_height_of_text_large(v) )
    return

  max_outer_height_of_sub_domains = (v) ->
    p = new DomainsCommonProcessor( sub_domains_of_link_domain(v) )
    return p.max_outer_height( true )

  set_vertical_align_of_sub_domains = ( v , _max_outer_height_of_sub_domains ) ->
    p = new DomainsVerticalAlignProcessor( sub_domains_of_link_domain(v) , _max_outer_height_of_sub_domains , 'middle' )
    p.process()
    return

  set_height_of_link_domain = ( v , _max_outer_height_of_sub_domains ) ->
    link_domain(v).css( 'height' , _max_outer_height_of_sub_domains )
    return

  set_height_of_whole_domain = (v) ->
    v.domain.css( 'height' , link_domain(v).outerHeight( true ) )
    return