class PassengerSurvey

  constructor: ( @domain = $( '#passenger_survey_table' ) ) ->
  
  main_title = (v) ->
    return $('#passenger_survey_title')

  has_main_title = (v) ->
    return main_title(v).length > 0

  main_text_domain_in_main_title = (v) ->
    return main_title(v).children( '.main_text' )

  children_of_main_text_domain_in_main_title = (v) ->
    return main_text_domain_in_main_title(v).children()

  survey_year_domain_in_main_title = (v) ->
    return children_of_main_text_domain_in_main_title(v).filter( '.survey_year' )

  has_survey_year_domain_in_main_title = (v) ->
    return has_main_title(v) and survey_year_domain_in_main_title(v).length > 0
    
  #--------

  tables = (v) ->
    return  $( '#passenger_survey_table' ).children( 'table' )

  table = (v) ->
    return tables(v).first()

  has_table = (v) ->
    return tables(v).length > 0

  ul_links_to_year_pages_on_index_page = (v) ->
    return $( 'ul#links_to_year_pages_on_index_page' )

  on_passenger_survey_index_page = (v) ->
    return ul_links_to_year_pages_on_index_page(v).length > 0

  process: ->
    if has_survey_year_domain_in_main_title(@)
      process_survey_year_domain_in_main_title(@)
    if has_table(@)
      process_table(@)
      process_links_to_pages(@)
    if on_passenger_survey_index_page(@)
      process_links_to_pages(@)
      process_icon_of_operator_on_index_page(@)
    return

  process_survey_year_domain_in_main_title = (v) ->
    p0 = new LengthToEven( survey_year_domain_in_main_title(v) )
    p0.set()
    _domains = children_of_main_text_domain_in_main_title(v)
    p1 = new DomainsCommonProcessor( _domains )
    p2 = new DomainsVerticalAlignProcessor( _domains , p1.max_outer_height( false ) )
    p2.process()
    return

  process_table = (v) ->
    t = new PassengerSurveyTable( table(v) , v.domain.width() )
    t.process()
    return

  process_links_to_pages = (v) ->
    l = new LinksToPassengerSurveyPages( $( 'ul#links_to_passenger_survey_pages' ) )
    l.process()
    return

  process_icon_of_operator_on_index_page = (v) ->
    ul_links_to_year_pages_on_index_page(v).children( 'li.survey_year' ).each ->
      l = new LinksToPassengerSurveyPagesOnIndexPage( $(@) )
      l.process()
      return
    return


window.PassengerSurvey = PassengerSurvey

class PassengerSurveyTable

  constructor: ( @domain , @width_of_table_domain ) ->

  tbody = (v) ->
    return v.domain.children( 'tbody' ).first()

  tr_rows = (v) ->
    return tbody(v).children( 'tr' )

  first_station_code_image = (v) ->
    row = new PassengerSurveyTableRow( tr_rows(v).first() )
    return row.first_station_code_image()

  max_number_of_station_code = (v) ->
    n = 0
    tr_rows(v).each ->
      row = new PassengerSurveyTableRow( $( this ) )
      n = Math.max( n , row.number_of_station_code_images() )
      return
    # console.log ( 'max_number_of_station_code: ' + n )
    return n

  max_width_of_station_codes = (v) ->
    return first_station_code_image(v).outerWidth( true ) * max_number_of_station_code(v)

  margin_right_of_table = (v) ->
    return v.width_of_table_domain - v.domain.outerWidth( true )

  max_td_graph_width = (v) ->
    return 240

  min_additional_width_of_td_station_info = (v) ->
    return 8

  svg_width = (v) ->
    # console.log margin_right_of_table(v)
    # console.log max_td_graph_width(v)
    return Math.min( margin_right_of_table(v) - min_additional_width_of_td_station_info(v) , max_td_graph_width(v) )

  additional_width_of_td_station_info = (v) ->
    _margin_right_of_table = margin_right_of_table(v)
    _max_td_graph_width = max_td_graph_width(v)
    _min_additional_width_of_td_station_info = min_additional_width_of_td_station_info(v)

    if _margin_right_of_table > _max_td_graph_width + _min_additional_width_of_td_station_info
      # console.log 'Wide station info'
      w = _margin_right_of_table - _max_td_graph_width
    else
      w = Math.max( _min_additional_width_of_td_station_info , _margin_right_of_table - _max_td_graph_width )

    return w

  max_passenger_journeys = (v) ->
    n = 0
    tr_rows(v).each ->
      row = new PassengerSurveyTableRow( $( this ) )
      n = Math.max( n , row.passenger_journeys() )
    return n

  process: ->
    process_station_infos(@)

    # console.log 'margin_right_of_table: '+ margin_right_of_table(@)
    # console.log 'min_additional_width_of_td_station_info: '+ min_additional_width_of_td_station_info(@)

    _svg_width = svg_width(@)
    _additional_width_of_td_station_info = additional_width_of_td_station_info(@)

    # console.log 'svg_width: ' + _svg_width
    # console.log 'additional_width_of_td_station_info: ' + _additional_width_of_td_station_info
    
    process_graphs( @ , _svg_width )
    set_width_of_td_station_info( @ , _additional_width_of_td_station_info )
    return

  process_station_infos = (v) ->
    _max_width_of_station_codes = max_width_of_station_codes(v)
    # console.log 'max_width_of_station_codes: '+ _max_width_of_station_codes

    tr_rows(v).each ->
      row = new PassengerSurveyTableRow( $( this ) ) 
      row.process_station_info( max_width_of_station_codes(v) )
      return
    return

  process_graphs = ( v , _svg_width ) ->
    _max_passenger_journeys = max_passenger_journeys(v)
    # console.log 'max_passenger_journeys: ' + _max_passenger_journeys

    tr_rows(v).each ->
      row = new PassengerSurveyTableRow( $( this ) )
      row.process_graph( _svg_width , _max_passenger_journeys )
      return
    return

  set_width_of_td_station_info = ( v , _additional_width_of_td_station_info ) ->
    # console.log _additional_width_of_td_station_info
    first_row = new PassengerSurveyTableRow( tr_rows(v).first() )
    first_row.set_width_of_td_station_info( _additional_width_of_td_station_info )
    return

class PassengerSurveyTableRow

  constructor: ( @row ) ->

  station_info = (v) ->
    return v.row.children( 'td.station_info' ).first()

  station_info_domain = (v) ->
    return station_info(v).children( '.station_info_domain' ).first()

  station_codes = (v) ->
    return station_info_domain(v).children( '.station_codes' ).first()

  station_code_images = (v) ->
    return station_codes(v).children( 'img.station_code' )

  graph = (v) ->
    return v.row.children( 'td.graph' ).first()

  svg = (v) ->
    return graph(v).children( 'svg' ).first()

  rect = (v) ->
    return svg(v).children( 'rect' ).first()

  first_station_code_image: ->
    return station_code_images(@).first()

  number_of_station_code_images: ->
    return station_code_images(@).length

  passenger_journeys: ->
    return parseInt( svg(@).attr( 'passenger_journeys' ) )

  process_station_info: ( _max_width_of_station_codes ) ->
    set_width_of_station_codes( @ , _max_width_of_station_codes )
    set_attributes_of_station_info(@)
    return

  # 各行の .station_codes の幅の設定
  set_width_of_station_codes = ( v , _max_width_of_station_codes ) ->
    station_codes(v).css( 'width' , _max_width_of_station_codes )
    return

  # 各行の .station_info の高さ、子要素の margin の設定
  set_attributes_of_station_info = (v) ->
    s = new StationInfoProcessor( station_info_domain(v) )
    station_info_domain(v).css( 'height' , s.max_outer_height_of_children( true ) )
    s.process()
    return

  process_graph: ( svg_width , max_passenger_journeys ) ->
    w = width_of_svg_rectangle( @ , svg_width , max_passenger_journeys )
    set_width_of_svg( @ , svg_width )
    set_width_of_rect( @ , w )
    return

  width_of_svg_rectangle = ( v , svg_width , max_passenger_journeys )->
    if max_passenger_journeys is v.passenger_journeys()
      w = svg_width
    else
      w = Math.ceil( ( v.passenger_journeys() * 1.0 / max_passenger_journeys ) * svg_width )
    # console.log 'width_of_svg_rectangle: ' + w
    return w

  set_width_of_svg = ( v , svg_width ) ->
    svg(v).css( 'width' , svg_width )
    return

  set_width_of_rect = ( v , w ) ->
    rect(v).attr( 'width' , w )
    return

  set_width_of_td_station_info: ( _additional_width_of_td_station_info ) ->
    _station_info = station_info(@)
    current_width = _station_info.width()
    # console.log 'current_width: ' + current_width
    # console.log 'additional_width_of_td_station_info: ' + _additional_width_of_td_station_info
    _station_info.css( 'width' , current_width + _additional_width_of_td_station_info )
    return


class LinksToPassengerSurveyPages

  constructor: ( @domain ) ->

  width_of_whole_domain = (v) ->
    return v.domain.width()

  titles = (v) ->
    return v.domain.children( 'ul' ).children( 'li.title' )

  links_to_railway_line_pages_of_this_station = (v) ->
    return v.domain.children( 'ul#links_to_railway_line_pages_of_this_station' )

  links_to_railway_line_pages = (v) ->
    return v.domain.children( 'ul#links_to_railway_line_pages' )

  links_to_year_pages = (v) ->
    return v.domain.children( 'ul#links_to_year_pages' )

  has_links_to_railway_line_pages_of_this_station = (v) ->
    return links_to_railway_line_pages_of_this_station(v).length > 0

  has_links_to_railway_line_pages = (v) ->
    return links_to_railway_line_pages(v).length > 0

  has_links_to_year_pages = (v) ->
    return links_to_year_pages(v).length > 0

  li_domains = (v) ->
    return v.domain.find( 'li.railway_line , li.tokyo_metro , li.survey_year' )

  ul_each_railway_line_domains = (v) ->
    ary = []
    $.each [ links_to_railway_line_pages_of_this_station(v) , links_to_railway_line_pages(v) ] , ->
      if $( this ).length > 0
        d = $( this ).children( 'ul.each_railway_line' )
        d.each ->
          ary.push( $( this ) )
          return
      return
    return ary

  li_railway_line_domains = (v) ->
    ary = []
    $.each ul_each_railway_line_domains(v) , ->
      d = $( this ).children( 'li.railway_line' )
      d.each ->
        ary.push( $( this ) )
        return
      return
    # console.log 'li_railway_line_domains size: ' + ary.length
    return ary

  main_contents_in_link_to_railway_line_pages = (v) ->
    ary = []
    $.each li_railway_line_domains(v) , ->
      $( this ).children( '.railway_line_without_link , .with_link_to_railway_line_page' ).each ->
        ary.push( $( this ) )
        return
      return
    return ary

  ul_operator_domains = (v) ->
    if has_links_to_year_pages(v)
      d = links_to_year_pages(v).children( 'ul.operator' )
    else
      d = null
    return d

  li_tokyo_metro_domain = (v) ->
    _ul_operator_domains = ul_operator_domains(v)
    if _ul_operator_domains is null
      d = null
    else
      d = _ul_operator_domains.children( 'li.tokyo_metro' )
    return d

  main_content_in_link_to_operator_page = (v) ->
    _li_tokyo_metro_domain = li_tokyo_metro_domain(v)
    if _li_tokyo_metro_domain is null
      d = null
    else
      d = li_tokyo_metro_domain(v).children( '.link_to_operator_page' )
    return d

  contents_of_railway_line_or_operator_domain = (v) ->
    ary = []

    $.each main_contents_in_link_to_railway_line_pages(v) , ->
      ary.push( $( this ) )
      return

    # console.log 'contents_of_railway_line_or_operator_domain size: ' + ary.length

    _main_content_in_link_to_operator_page = main_content_in_link_to_operator_page(v)
    unless _main_content_in_link_to_operator_page is null
      _main_content_in_link_to_operator_page.each ->
        ary.push( $( this ) )
        return

    # console.log 'contents_of_railway_line_or_operator_domain size: ' + ary.length
    return ary

  li_survey_year_domains = (v) ->
    ary = []

    # console.log ul_each_railway_line_domains(v).length

    $.each ul_each_railway_line_domains(v) , ->
      # console.log $( this )
      $( this ).children( 'li.survey_year' ).each ->
        # console.log $( this )
        ary.push( $( this ) )
        return
      return

    # console.log ary.length

    _ul_operator_domains = ul_operator_domains(v)
    unless _ul_operator_domains is null
      _ul_operator_domains.each ->
        $( this ).children( 'li.survey_year' ).each ->
          ary.push( $( this ) )
          return
        return

    # console.log ary.length

    return ary

  max_number_of_li_domains_for_each_ul = (v) ->
    n = 0
    $.each [ ul_each_railway_line_domains(v) , ul_operator_domains(v) ] , ->
      ul_group = $(@)
      ul_group.each ->
        ul = $(@)
        n = Math.max( n , ul.children( 'li' ).length )
        return
      return
    return n

  max_border_width_of_li_domains = (v) ->
    p = new DomainsCommonProcessor( li_domains(v) )
    return p.max_border_width()

  max_width_of_li_survey_year_domains = (v) ->
    p = new DomainsCommonProcessor( li_survey_year_domains(v) )
    return p.max_inner_width()

  max_outer_width_of_railway_line_and_operator_domains = (v) ->
    _contents = contents_of_railway_line_or_operator_domain(v)
    p = new DomainsCommonProcessor( $( _contents ) )
    return p.max_outer_width( true )

  process: ->
    set_width_of_text_domain_in_railway_line_and_operator_domain(@)

    set_width_of_whole_domain_to_this_object(@)
    set_max_number_of_li_domains_for_each_ul_to_this_object(@)
    set_border_width_of_li_domains_to_this_object(@)
    set_width_of_li_survey_year_domains_to_this_object(@)
    set_width_of_railway_line_and_operator_domains_to_this_object(@)

    process_titles(@)
    process_railway_line_and_operator_domain(@)
    set_length_of_survey_year_domain(@)
    return

  set_width_of_text_domain_in_railway_line_and_operator_domain = (v) ->
    $.each [ li_railway_line_domains(v) , li_tokyo_metro_domain(v) ] , ->
      li_domain_group = $(@)
      $.each li_domain_group , ->
        l = new LinkToRailwayLinePage( $(@) , 'passenger_survey' )
        l.set_text_width()
        return
      return
    return

  set_width_of_whole_domain_to_this_object = (v) ->
    w = width_of_whole_domain(v)
    v.width_of_whole_domain = w
    console.log 'width_of_whole_domain: ' + w
    return
  
  set_max_number_of_li_domains_for_each_ul_to_this_object = (v) ->
    n = max_number_of_li_domains_for_each_ul(v)
    v.max_number_of_li_domains = n
    console.log 'max_number_of_li_domains: ' + n
    return
  
  set_border_width_of_li_domains_to_this_object = (v) ->
    w = max_border_width_of_li_domains(v)
    v.border_width_of_li_domains = w
    console.log 'border_width_of_li_domains: ' + w
    return
  
  set_width_of_li_survey_year_domains_to_this_object = (v) ->
    w = max_width_of_li_survey_year_domains(v)
    v.width_of_li_survey_year_domains = w
    console.log 'width_of_li_survey_year_domains: ' + w
    return

  set_width_of_railway_line_and_operator_domains_to_this_object = (v) ->
    w1 = max_outer_width_of_railway_line_and_operator_domains(v)
    w2 = v.width_of_whole_domain - ( v.width_of_li_survey_year_domains * ( v.max_number_of_li_domains - 1 ) + v.border_width_of_li_domains * ( v.max_number_of_li_domains + 1 ) )
    w = Math.max( w1 , w2 )
    v.width_of_railway_line_and_operator_domains = w
    console.log 'width_of_railway_line_and_operator_domains: ' + w
    return

  process_titles = (v) ->
    titles(v).each ->
      paddings_left_and_right = $(@).innerWidth() - $(@).width()
      $(@).css( 'width' , v.width_of_whole_domain - paddings_left_and_right )
      return
    return

  process_railway_line_and_operator_domain = (v) ->
    $.each li_railway_line_domains(v) , ->
      # console.log $( this )
      p = new LinkToRailwayLinePage( $( this ) , 'passenger_survey' , v.width_of_railway_line_and_operator_domains , '.with_link_to_railway_line_page , .railway_line_without_link' )
      p.process()
      return

    _li_tokyo_metro_domain = li_tokyo_metro_domain(v)
    unless _li_tokyo_metro_domain is null
      # console.log 'process_railway_line_and_operator_domain - operator'
      $.each _li_tokyo_metro_domain , ->
        # console.log $( this )
        p = new LinkToRailwayLinePage( $( this ) , 'passenger_survey' , v.width_of_railway_line_and_operator_domains , '.link_to_operator_page' )
        p.process()
        return
    return

  set_length_of_survey_year_domain = (v) ->
    $.each ul_each_railway_line_domains(v) , ->
      p = new LinkToPassengerSurveyPagesInEachUl( $(@) , 'railway_line' , v.width_of_li_survey_year_domains )
      p.process()
      return

    _ul_operator_domains = ul_operator_domains(v)

    unless _ul_operator_domains is null
      _ul_operator_domains.each ->
        p = new LinkToPassengerSurveyPagesInEachUl( $(@) , 'tokyo_metro' , v.width_of_li_survey_year_domains )
        p.process()
        return
    return

class LinkToPassengerSurveyPagesInEachUl
  
  constructor: ( @domain , @name_of_li_main_content , @width_of_survey_year_domains ) ->
  
  name_domain = (v) ->
    return v.domain.children( "li.#{ v.name_of_li_main_content }" ).first()
  
  height_of_name_domain = (v) ->
    return name_domain(v).height()
  
  survey_year_domains = (v) ->
    return v.domain.children( 'li.survey_year' )
  
  process: ->
    set_height_of_each_li_domain_to_this_object(@)
    set_height_to_survey_year_domains(@)
    set_vertical_align_of_texts_and_width(@)
    return
  
  set_height_of_each_li_domain_to_this_object = (v) ->
    v.height_of_each_li_domain = height_of_name_domain(v)
    return

  set_height_to_survey_year_domains = (v) ->
    p = new DomainsCommonProcessor( survey_year_domains(v) )
    p.set_css_attribute( 'height' , v.height_of_each_li_domain )
    return
  
  set_vertical_align_of_texts_and_width = (v) ->
    survey_year_domains(v).each ->
      survey_year = $(@)
      p_domain = $(@).children( 'p.text_en' ).first()
      p = new DomainsVerticalAlignProcessor( p_domain , v.height_of_each_li_domain )
      p.process()
      survey_year.css( 'width' , v.width_of_survey_year_domains )
      return
    return

class LinksToPassengerSurveyPagesOnIndexPage

  constructor: ( @domain ) ->
  
  icon = (v) ->
    return v.domain.children( '.icon' ).first()
  
  icon_img = (v) ->
    return icon(v).children( 'img' ).first()
    
  text = (v) ->
    return v.domain.children( '.text' ).first()
  
  process: ->
    set_position_of_icon(@)
    process_text(@)
    set_vertical_align(@)
    return
  
  set_position_of_icon = (v) ->
    p1 = new DomainsVerticalAlignProcessor( icon_img(v) , icon(v).height() )
    p1.process()
    p2 = new DomainsHorizontalAlignProcessor( icon_img(v) , icon(v).width() )
    p2.process()
    return
  
  process_text = (v) ->
    l = new LengthToEven( text(v) )
    l.set()
    return

  set_vertical_align = (v) ->
    _children = v.domain.children().not( 'a' )
    p1 = new DomainsCommonProcessor( _children )
    h = p1.max_outer_height( false )
    console.log h
    p2 = new DomainsVerticalAlignProcessor( _children , h )
    p2.process()
    return