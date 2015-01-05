//-------- #railway_line_matrix の高さの設定
function setHeightOfLineMatrixes( selector , normal_railway_lines , line_division , number_of_special_railway_lines , outer_height_of_each_line , width_of_border ) {
  // 一般路線の行の数
  var number_of_rows_of_normal_railway_lines = Math.ceil( ( normal_railway_lines.size() * 1.0 ) / line_division - 0.01 ) ;
  // 全体の行の数
  var number_of_rows_whole = number_of_rows_of_normal_railway_lines + number_of_special_railway_lines ;
  // 高さ
  var height_of_lines = number_of_rows_whole * ( outer_height_of_each_line - width_of_border ) + width_of_border ;
  // $( selector ).each( function() {
    // $( this ).css( 'height' , height_of_lines + 'px' ) ;
  // }) ;
  $( selector ).css( 'height' , height_of_lines + 'px' ) ;
}