function changeAttributesOfBoxesInStationMatrixes( selector_for_station_matrixes , width_of_main_content_center , width_of_each_normal_railway_line , width_of_border ) {
  // 各路線の要素 (.railway_lines) の要素の集合
  var railway_lines = $( selector_for_station_matrixes ).children() ;

  var width_of_main_content_center = $( '#main_content_center' ).innerWidth() ;
  var width_of_railway_line_matrix = width_of_each_normal_railway_line ; // Math.floor( width_of_each_normal_railway_line * 1.0 / goldenRatio ) ;
  var width_of_stations = width_of_main_content_center - ( width_of_railway_line_matrix + width_of_border * 2 )  - width_of_border ;

  railway_lines.each( function() {
    var a_railway_line = $( this ) ;
    var contents_in_a_railway_line = a_railway_line.children() ;
    var railway_line_matrix = contents_in_a_railway_line.eq(0) ;
    var stations = contents_in_a_railway_line.eq(1) ;

    // railway_line_matrix, stations それぞれの長さを設定し、a_railway_line の長さも微調整する
    changeWidth( a_railway_line , width_of_main_content_center ) ;
    changeWidth( railway_line_matrix , width_of_railway_line_matrix ) ;
    changeWidth( stations , width_of_stations - ( stations.innerWidth() - stations.width() ) ) ; // - width_of_border * 2  ;

    // railway_line_matrix 内部の要素を操作する
    var info = railway_line_matrix.children( '.info' ).first() ;

    var railway_line_code_outer = info.children( '.railway_line_code_outer' ).first() ;
    var text = info.children( '.text' ).first() ;


    var info_height = Math.max( railway_line_code_outer.outerHeight( true ) , text.outerHeight( true ) ) ;

    var margin_of_railway_line_code_outer = ( info_height - railway_line_code_outer.outerHeight() ) * 0.5 ;
    var margin_of_text = ( info_height - text.outerHeight() ) * 0.5 ;

    // info 領域の高さを設定し、railway_line_code_outer と text の上下方向の位置を中心揃えにする
    railway_line_code_outer.css( 'margin-top' , margin_of_railway_line_code_outer ).css( 'margin-bottom' , margin_of_railway_line_code_outer ) ;
    text.css( 'margin-top' , margin_of_text ).css( 'margin-bottom' , margin_of_text ) ;

    info.css( 'height' , info_height ) ;

    // railway_line_matrix , stations , a_railway_line それぞれの高さを揃える
    var height_of_contents = Math.max( railway_line_matrix.outerHeight( true ) , stations.outerHeight( true ) ) ;
    a_railway_line.css( 'height' , height_of_contents ) ;
    railway_line_matrix.css( 'height' , height_of_contents - width_of_border * 2 ) ;
    stations.css( 'height' , height_of_contents - width_of_border * 2 - ( stations.innerHeight() - stations.height() ) ) ;

    // info 領域の上下の margin を変更
    var margin_of_info = ( railway_line_matrix.innerHeight() - info_height ) * 0.5 ;
    info.css( 'margin-top' , margin_of_info ).css( 'margin-bottom' , margin_of_info )
  });
}