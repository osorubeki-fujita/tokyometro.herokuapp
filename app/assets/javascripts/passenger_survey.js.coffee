class PassengerSurveyTable
  constructor: ( @table = $( '#passenger_survey_table' ).children( 'table' ).first() ) ->

  tbody = (v) ->
    v.table.children( 'tbody' )

  tr_rows = (v) ->
    tbody(v).children( 'tr' )

  first_station_code_image = (v) ->
    row = new PassengerSurveyTableRow( tr_rows(v).first() )
    row.first_station_code_image()

  max_number_of_station_code = (v) ->
    n = 0
    tr_rows(v).each ->
      row = new PassengerSurveyTableRow( $( this ) )
      n = Math.max( n , row.number_of_station_code_images() )
      return
    # console.log ( 'max_number_of_station_code: ' + n )
    n

  max_width_of_station_codes = (v) ->
    first_station_code_image(v).outerWidth( true ) * max_number_of_station_code(v)
  
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
    v.row.children( 'td.station_info' ).first()

  station_codes = (v) ->
    station_info(v).children( '.station_codes' ).first()

  station_text = (v) ->
    station_info(v).children( '.text' ).first()

  station_code_images = (v) ->
    station_codes(v).children( 'img.station_code' )

  station_info_height_new = (v) ->
    margin_top = 8
    margin_bottom = 8
    Math.max( station_codes(v).outerHeight( true ) , station_text(v).outerHeight( true ) ) + ( margin_top + margin_bottom )

  first_station_code_image: ->
    station_code_images(@).first()

  number_of_station_code_images: ->
    station_code_images(@).length
    
  set_width_of_station_codes: ( width_new ) ->
    station_codes(@).css( 'width' , width_new )
    return

  set_attributes_of_station_info: ->
    station_info(@).css( 'height' , station_info_height_new(@) )

    margin_of_station_codes = ( station_info(@).height() - station_codes(@).height() ) * 0.5
    station_codes(@).css( 'margin-top' , margin_of_station_codes ).css( 'margin-bottom' , margin_of_station_codes )

    margin_of_station_text = ( station_info(@).height() - station_text(@).height() ) * 0.5
    station_text(@).css( 'margin-top' , margin_of_station_text ).css( 'margin-bottom' , margin_of_station_text )
    return