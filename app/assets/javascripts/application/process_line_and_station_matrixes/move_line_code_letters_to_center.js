// 路線記号の文字の垂直方向の位置を、円の中心へ
// 記号すべて
function moveLineCodeLettersToCenter() {
  $( 'div.railway_line_code_48 , div.railway_line_code_32 , div.railway_line_code_24 , div.railway_line_code_16' ).each( function() {
    moveEachLineCodeLetterToCenter( $( this ) ) ;
  }) ;
}

// 路線記号の文字の垂直方向の位置を、円の中心へ
// それぞれの記号
function moveEachLineCodeLetterToCenter( jq ) {
  // .railway_line_code の高さ (innnerHeight) を取得
  var height_of_railway_line_code = jq.innerHeight() ;
  // .railway_line_code の子要素である p タグを操作
  jq.children('p').each( function() {
    var p_domain = $( this ) ;
    // p タグの高さ (outerHeight) を取得
    var height_of_p = p_domain.outerHeight( true ) ;
    // p タグの上下の margin を決定
    var margin_of_p = ( ( height_of_railway_line_code - height_of_p ) * 0.5 ) + 'px' ;
    // p タグの上下の margin を適用
    p_domain.css( 'marginTop' , margin_of_p ).css( 'marginBottom' , margin_of_p ) ;
  }) ;
}