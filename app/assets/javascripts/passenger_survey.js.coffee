class PassengerSurveyTable
  constructor: ( @table = $( '#passenger_survey_table' ).children( 'table' ).first() ) ->

  tbody = (v) ->
    return v.table.children( 'tbody' ).first()

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

  # 各行の .station_codes の幅の設定
  set_width_of_station_codes = (v) ->
    _width = max_width_of_station_codes(v)
    tr_rows(v).each ->
      row = new PassengerSurveyTableRow( $( this ) )
      row.set_width_of_station_codes( _width )
      return
    return

  # 各行の .station_info の高さ、子要素の margin の設定
  set_attributes_of_station_info = (v) ->
    tr_rows(v).each ->
      row = new PassengerSurveyTableRow( $( this ) )
      row.set_attributes_of_station_info()
      return
    return

  # 行全体へのリンク
  set_link_to_each_row = (v) ->
    # jQuery(function($) {
    #   $('tr[data-href]').addClass('clickable').click( function(e) {
    #     if(!$(e.target).is('a')){
    #       window.location = $(e.target).closest('tr').data('href');
    #     };
    #   });
    # });
    return

  process: ->
    set_width_of_station_codes(@)
    set_attributes_of_station_info(@)
    set_link_to_each_row(@)
    return

window.PassengerSurveyTable = PassengerSurveyTable

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

  first_station_code_image: ->
    return station_code_images(@).first()

  number_of_station_code_images: ->
    return station_code_images(@).length

  set_width_of_station_codes: ( width_new ) ->
    station_codes(@).css( 'width' , width_new )
    return

  set_attributes_of_station_info: ->
    s = new StationInfoProcessor( station_info_domain(@) )
    station_info_domain(@).css( 'height' , s.max_outer_height_of_children( true ) )
    s.process()
    return