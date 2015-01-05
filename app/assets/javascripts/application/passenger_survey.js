function processPassengerSurveyTable() {
  var passenger_survey_table = $( '#passenger_survey_table' ).children( 'table' ).first() ;
  passenger_survey_table.children( 'tbody' ).first().children( 'tr' ).each( function() {
    var station_info = $( this ).children( 'td.station_info' ).first() ;
    var station_text = station_info.children( '.text' ).first() ;
    var margin_of_station_text = ( $( this ).height() - station_text.outerHeight( true ) ) * 0.5 ;
    station_text.css( 'margin-top' , margin_of_station_text ).css( 'margin-bottom' , margin_of_station_text ) ;
  });
}

// 行全体へのリンク
jQuery(function($) {
  $('tr[data-href]').addClass('clickable').click( function(e) {
    if(!$(e.target).is('a')){
      window.location = $(e.target).closest('tr').data('href');
    };
  });
});