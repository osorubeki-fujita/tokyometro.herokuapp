class RealTimeInfoProcessor

  constructor: ( @domain = $( "#real_time_info_and_update_button" ) ) ->

  has_real_time_info_and_update_button = (v) ->
    return ( v.domain.length > 0 )
  
  has_links_to_railway_line_pages_in_right_side_menu = (v) ->
    return links_to_railway_line_pages_in_right_side_menu(v).length > 0

  content_header = (v) ->
    return v.domain
      .children( '.content_header' )

  size_changing_button_domain = (v) ->
    return content_header(v)
      .children( '.size_changing_button' )
      .first()

  size_changing_button = (v) ->
    return size_changing_button_domain(v)
      .children( 'button' )
      .first()

  i_in_size_changing_button = (v) ->
    return size_changing_button(v)
      .children( 'i' )
      .first()

  domain_of_time_infos = (v) ->
    return v.domain
      .children( 'ul.time_infos' )
      .first()

  time_infos = (v) ->
    return domain_of_time_infos(v)
      .children( 'li' )
    
  links_to_railway_line_pages_in_right_side_menu = (v) ->
    return $('#links_to_real_time_info_pages_of_railway_lines' )
      .children( 'ul#links_to_railway_line_pages' )

  process: ->
    if has_real_time_info_and_update_button(@)
      process_content_header(@)
      process_time_infos(@)
    if has_links_to_railway_line_pages_in_right_side_menu(@)
      process_links_to_railway_line_pages_in_right_side_menu(@)
    return

  process_content_header = (v) ->
    t = new ContentHeaderProcessor( content_header(v) )
    t.process()
    return

  process_time_infos = (v) ->
    time_infos(v).each ->
      t = new EachRealTimeInfo( $( this ) )
      t.process()
      return
    return
    
  process_links_to_railway_line_pages_in_right_side_menu = (v) ->
    p = new LinksToRealTimeInfoPages( $( '#links_to_real_time_info_pages_of_railway_lines' ) )
    p.process()
    return

  set_size_change_event: ->
    # console.log 'RealTimeInfoProcessor\#set_size_change_event'
    _this = @
    size_changing_button(@).on 'click' , ->
      # console.log 'click'
      _this.change_display_settings()
      return
    return

  change_display_settings: ->
    d = new DisplaySettingsOnClick( @domain , size_changing_button(@) , i_in_size_changing_button(@) )
    d.process()
    return

window.RealTimeInfoProcessor = RealTimeInfoProcessor

class EachRealTimeInfo

  constructor: ( @domain ) ->

  domain_of_titles = (v) ->
    return v.domain
      .children( 'ul.titles' )
      .first()

  titles = (v) ->
    return domain_of_titles(v)
      .children( 'li.title' )

  # domain_of_time_infos_of_category = (v) ->
    # return v.domain.children( 'ul.time_infos_of_category' ).first()

  # time_infos_of_category = (v) ->
    # return domain_of_time_infos_of_category(v).children( 'li' )

  # dc_date_and_validity = (v) ->
    # return domain_of_time_infos_of_category(v).children( 'li.dc_date , li.validity' )

  # en = (v) ->
    # return domain_of_time_infos_of_category(v).children( 'ul.en' ).first()

  # title_of_time_infos = (v) ->
    # return v.domain.find( '.title_of_time_info' )

  process: ->
    process_titles(@)
    # set_height_of_li_domains(@)
    # set_height_of_li_domains_of_en(@)
    # set_width_of_li_domains_of_en(@)
    return

  process_titles = (v) ->
    titles(v).each ->
      t = new ContentHeaderProcessor( $(@) )
      t.process()
      return
    return

  # set_height_of_li_domains = (v) ->
    # dc_date_and_validity(v).each ->
      # time_info = $(@)
      # p = new DomainsCommonProcessor( time_info.children() )
      # time_info.css( 'height' , p.sum_outer_height( true ) )
      # return
    # return

  # set_height_of_li_domains_of_en = (v) ->
    # en(v).children( 'li.dc_date , li.validity' ).each ->
      # li = $(@)
      # p = new DomainsCommonProcessor( li.children() )
      # li.css( 'height' , p.max_outer_height( true ) )
      # li.css( 'width' , p.sum_outer_width( true ) )
      # return
    # return

  # set_width_of_li_domains_of_en = (v) ->
    # lis = new DomainsCommonProcessor( en(v).children( 'li' ) )
    # en(v).css( 'width' , lis.max_outer_width( true ) )
    # return