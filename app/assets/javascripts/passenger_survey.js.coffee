class PassengerSurvey

  constructor: ( @domain = $( '#passenger_survey_table' ) ) ->

  table = (v) ->
    return $( '#passenger_survey_table' ).children( 'table' ).first()

  has_table = (v) ->
    return $( '#passenger_survey_table' ).children( 'table' ).length > 0

  passenger_survey_page = (v) ->
    return $( '#passenger_survey_title' ).length > 0

  process: ->
    if has_table(@)
      process_table(@)
      process_links_to_railway_line_pages(@)
    # else if passenger_survey_page(@)
      # process_links_to_railway_line_pages(@)
    return
  
  process_table = (v) ->
    t = new PassengerSurveyTable( table(v) , v.domain.width() )
    t.process()
    return

  process_links_to_railway_line_pages = (v) ->
    l = new LinksToPassengerSurveyPages( $( '#links_to_passenger_survey_pages' ) )
    l.process()
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

  link_domains_to_railway_line_pages = (v) ->
    ary = []
    $.each li_railway_line_domains(v) , ->
      $( this ).children( '.link_to_railway_line_page' ).each ->
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

  link_domains_to_operator_page = (v) ->
    _li_tokyo_metro_domain = li_tokyo_metro_domain(v)
    if _li_tokyo_metro_domain is null
      d = null
    else
      d = li_tokyo_metro_domain(v).children( '.link_to_operator_page' )
    return d

  contents_of_railway_line_or_operator_domain = (v) ->
    ary = []

    $.each link_domains_to_railway_line_pages(v) , ->
      ary.push( $( this ) )
      return

    # console.log 'contents_of_railway_line_or_operator_domain size: ' + ary.length

    _link_domains_to_operator_page = link_domains_to_operator_page(v)
    unless _link_domains_to_operator_page is null
      _link_domains_to_operator_page.each ->
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

  process: ->
    process_titles(@)
    set_width_of_railway_line_and_operator_domain_to_instance(@)
    process_railway_line_and_operator_domain(@)
    set_height_of_survey_year_domain(@)
    set_width_of_survey_year_domain(@)
    process_width_of_cells(@)
    return

  process_titles = (v) ->
    w = width_of_whole_domain(v)
    titles(v).each ->
      paddings_left_and_right = $( this ).innerWidth() - $( this ).width()
      $( this ).css( 'width' , w - paddings_left_and_right )
      return
    return

  set_width_of_railway_line_and_operator_domain_to_instance = (v) ->
    # $.each contents_of_railway_line_or_operator_domain(v) , ->
    #   console.log $( this ).outerWidth( true )
    #   return
    p = new DomainsCommonProcessor( $( contents_of_railway_line_or_operator_domain(v) ) )
    w = p.max_outer_width( true )
    v.width_of_railway_line_and_operator_domain = w
    # console.log w
    return

  process_railway_line_and_operator_domain = (v) ->
    $.each li_railway_line_domains(v) , ->
      # console.log $( this )
      p = new LinkToRailwayLinePage( $( this ) , 'passenger_survey' , v.width_of_railway_line_and_operator_domain , '.link_to_railway_line_page' )
      p.process()
      return

    _li_tokyo_metro_domain = li_tokyo_metro_domain(v)
    unless _li_tokyo_metro_domain is null
      # console.log 'process_railway_line_and_operator_domain - operator'
      $.each _li_tokyo_metro_domain , ->
        # console.log $( this )
        p = new LinkToRailwayLinePage( $( this ) , 'passenger_survey' , v.width_of_railway_line_and_operator_domain , '.link_to_operator_page' )
        p.process()
        return
    return

  set_height_of_survey_year_domain = (v) ->
    $.each ul_each_railway_line_domains(v) , ->
      height_of_railway_line = $( this ).children( 'li.railway_line' ).height()
      p = new DomainsCommonProcessor( $( this ).children( 'li.survey_year' ) )
      # console.log height_of_railway_line
      p.set_css_attribute( 'height' , height_of_railway_line )
      return

    _ul_operator_domains = ul_operator_domains(v)

    unless _ul_operator_domains is null
      _ul_operator_domains.each ->
        height_of_operator = $( this ).children( 'li.tokyo_metro' ).height()
        p = new DomainsCommonProcessor( $( this ).children( 'li.survey_year' ) )
        p.set_css_attribute( 'height' , height_of_operator )
        return
    return

  set_width_of_survey_year_domain = (v) ->
    _li_survey_year_domains = li_survey_year_domains(v)
    p = new DomainsCommonProcessor( _li_survey_year_domains )
    w = Math.ceil( p.max_width() )
    # console.log _li_survey_year_domains.length
    # console.log w
    p.set_css_attribute( 'width' , w )
    return

  process_width_of_cells = (v) ->
    w = width_of_whole_domain(v)
    console.log w
    first_railway_line_domain = ul_each_railway_line_domains(v)[0]

    console.log first_railway_line_domain
    console.log first_railway_line_domain.attr( 'class' )

    number_of_children = first_railway_line_domain.children().length
    p1 = new DomainsCommonProcessor( first_railway_line_domain.children() )
    p2 = new RailwayLineAndStationMatrix()
    sum_w = p1.sum_width() + p2.border_width * ( number_of_children + 1 )
    current_margin_right = w - sum_w
    console.log p1.sum_width()
    console.log sum_w
    console.log current_margin_right
    return