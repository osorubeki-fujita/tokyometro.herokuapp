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
    p = new DomainsVerticalAlignProcessor( _domains )
    p.process()
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

    _svg_width = svg_width(@)
    _additional_width_of_td_station_info = additional_width_of_td_station_info(@)

    process_graphs( @ , _svg_width )
    set_width_of_td_station_info( @ , _additional_width_of_td_station_info )
    return

  process_station_infos = (v) ->
    _max_width_of_station_codes = max_width_of_station_codes(v)

    tr_rows(v).each ->
      row = new PassengerSurveyTableRow( $( this ) ) 
      row.process_station_info( max_width_of_station_codes(v) )
      return
    return

  process_graphs = ( v , _svg_width ) ->
    _max_passenger_journeys = max_passenger_journeys(v)

    tr_rows(v).each ->
      row = new PassengerSurveyTableRow( $( this ) )
      row.process_graph( _svg_width , _max_passenger_journeys )
      return
    return

  set_width_of_td_station_info = ( v , _additional_width_of_td_station_info ) ->
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
    # set_vertical_align_of_svg(@)
    return

  width_of_svg_rectangle = ( v , svg_width , max_passenger_journeys )->
    if max_passenger_journeys is v.passenger_journeys()
      w = svg_width
    else
      w = Math.ceil( ( v.passenger_journeys() * 1.0 / max_passenger_journeys ) * svg_width )
    return w

  set_width_of_svg = ( v , svg_width ) ->
    svg(v).css( 'width' , svg_width )
    return

  set_width_of_rect = ( v , w ) ->
    rect(v).attr( 'width' , w )
    return

  set_vertical_align_of_svg = (v) ->
    p = new DomainsVerticalAlignProcessor( svg(v) , graph(v).height() )
    p.process()
    return

  set_width_of_td_station_info: ( _additional_width_of_td_station_info ) ->
    _station_info = station_info(@)
    current_width = _station_info.width()
    _station_info.css( 'width' , current_width + _additional_width_of_td_station_info )
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
    l = new LengthToEven( text(v) , true )
    l.set()
    return

  set_vertical_align = (v) ->
    _children = v.domain.children().not( 'a' )
    p = new DomainsVerticalAlignProcessor( _children )
    p.process()
    return
