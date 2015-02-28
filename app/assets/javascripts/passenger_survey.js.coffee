class PassengerSurveyTable
  constructor: ( @table = $( '#passenger_survey_table' ).children( 'table' ).first() ) ->

  tbody = (v) ->
    v.table.children( 'tbody' )

  tr_rows = (v) ->
    tbody(v).children( 'tr' )

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
    tr_rows(@).each ->
      station_info = $( this ).children( 'td.station_info' ).first()
      station_text = station_info.children( '.text' ).first()
      margin_of_station_text = ( $( this ).height() - station_text.outerHeight( true ) ) * 0.5
      station_text.css( 'margin-top' , margin_of_station_text ).css( 'margin-bottom' , margin_of_station_text )
      return
    set_link_to_each_row(@)
    return

window.PassengerSurveyTable = PassengerSurveyTable