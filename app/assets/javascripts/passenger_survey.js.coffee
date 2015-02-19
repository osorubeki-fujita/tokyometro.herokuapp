# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# function processPassengerSurvey() {
#   var passenger_survey_table = $( '#passenger_survey_table' ).children( 'table' ).first() ;
#   passenger_survey_table.children( 'tbody' ).first().children( 'tr' ).each( function() {
#     var station_info = $( this ).children( 'td.station_info' ).first() ;
#     var station_text = station_info.children( '.text' ).first() ;
#     var margin_of_station_text = ( $( this ).height() - station_text.outerHeight( true ) ) * 0.5 ;
#     station_text.css( 'margin-top' , margin_of_station_text ).css( 'margin-bottom' , margin_of_station_text ) ;
#   });
# }

# // 行全体へのリンク
# jQuery(function($) {
#   $('tr[data-href]').addClass('clickable').click( function(e) {
#     if(!$(e.target).is('a')){
#       window.location = $(e.target).closest('tr').data('href');
#     };
#   });
# });

processPassengerSurvey = ->
  passenger_survey_table = $( '#passenger_survey_table' ).children( 'table' ).first()
  passenger_survey_table.children( 'tbody' ).first().children( 'tr' ).each ->
    station_info = $( this ).children( 'td.station_info' ).first()
    station_text = station_info.children( '.text' ).first()
    margin_of_station_text = ( $( this ).height() - station_text.outerHeight( true ) ) * 0.5
    station_text.css( 'margin-top' , margin_of_station_text ).css( 'margin-bottom' , margin_of_station_text )
    return
  setLinkToEachPassengerSurveyTableRow()
  return

window.processPassengerSurvey = processPassengerSurvey

setLinkToEachPassengerSurveyTableRow = ->
  return