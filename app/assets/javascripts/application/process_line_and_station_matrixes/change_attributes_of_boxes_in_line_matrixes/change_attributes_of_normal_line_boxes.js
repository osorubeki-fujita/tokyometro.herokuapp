// 一般路線の box の設定
function changeAttributesOfNormalLineBoxes( lines , width ) {
  changeWidthOfNormalLineBoxes( lines , width ) ;
}

// 一般路線の box の幅の変更
function changeWidthOfNormalLineBoxes( lines , width ) {
  lines.each( function() {
    // var line_box = $( this ) ;
    // 路線の box (.line_box) の幅の変更
    // changeWidth( line_box , width ) ;
    // 路線の box のコンテンツの幅の変更
    // !! changeWidthOflLineBoxes( line_box , width ) ;
    // 路線記号の左右の margin の変更
    // changeMarginOfNormalLineCodeOuter( line_box , width ) ;
    changeWidth( $( this ) , width ) ;
    changeMarginOfNormalLineCodeOuter( $( this ) , width ) ;
    changeMarginOfLineBoxInfoDomain( $( this ) , $( this ).children( '.info' ).first() ) ;
  }) ;
}

// 路線記号の左右の margin の変更
function changeMarginOfNormalLineCodeOuter( jq , width_of_each_normal_railway_line ) {
  jq.find( '.railway_line_code_outer' ).each( function() {
    var width_of_railway_line_code_outer = $( this ).outerWidth( true ) ;
    var margin_of_railway_line_code_outer = ( ( width_of_each_normal_railway_line - width_of_railway_line_code_outer ) * 0.5 )  + 'px' ;
    $( this ).css( 'marginLeft' , margin_of_railway_line_code_outer ).css( 'marginRight' , margin_of_railway_line_code_outer) ;
  });
}