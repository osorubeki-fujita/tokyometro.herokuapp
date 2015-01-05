// 特殊な路線（「有楽町線・副都心線」を想定）の box の設定
function changeAttributesOfSpecialLineBoxes( railway_lines , width ) {
  railway_lines.each( function() {
    // .line_box の幅の変更
    changeWidth( $( this ) , width ) ;
    var special_railway_line_info = $( this ).children( '.info' ).first() ;
    changeAttributesOfSpecialLineCodeBox( special_railway_line_info ) ;
    changeMarginOfLineBoxInfoDomain( $( this ) , special_railway_line_info ) ;
  }) ;
}

// // 路線の box のコンテンツの幅の変更
// function changeWidthOfSpecialLineCodeBox( line_box , width ) {
//  // .railway_line_codes , .text_ja , .text_en の配列
//  var array_of_contents_in_line_box = line_box.children( '.info' ).contents() ;
//  // .railway_line_codes , .text_ja , .text_en の幅の設定
//  array_of_contents_in_line_box.each( function() {
//    // $( this ) は .railway_line_codes , .text_ja , .text_en のいずれか
//    changeWidth( $( this ) , width ) ;
//  }) ;
//}
  
// 路線記号の設定の変更
function changeAttributesOfSpecialLineCodeBox( special_railway_line_info ) {
  var array_of_railway_line_codes = special_railway_line_info.children( '.railway_line_codes' ) ;
  // 路線記号のサイズの取得
  var size_of_railway_line_code_box = setSizeOfSpecialLineCodeBox( array_of_railway_line_codes ) ;
  
  var width_of_railway_line_code_box = size_of_railway_line_code_box[0] ;
  var height_of_railway_line_code_box = size_of_railway_line_code_box[1] ;

  array_of_railway_line_codes.each( function() {
    // --------
    // 属性 .railway_line_codes をもつ要素
    // var railway_line_codes = $( this ) ;
    // railway_line_codes.css( 'height' , height_of_railway_line_code_box ) ;
    // 属性 .railway_line_codes をもつ要素とその子孫要素の設定
    // setAttributesToLineCodesAndChildren( railway_line_codes , width_of_railway_line_code_box , height_of_railway_line_code_box ) ;
    
    $( this ).css( 'height' , height_of_railway_line_code_box ) ;
    setAttributesToLineCodesAndChildren( $( this ) , width_of_railway_line_code_box , height_of_railway_line_code_box ) ;
    // --------
  });
}

// 路線記号のサイズの取得
function setSizeOfSpecialLineCodeBox( array_of_railway_line_codes ) {
  var width_of_railway_line_code_box = 0 ;
  var height_of_railway_line_code_box = 0 ;

  // array_of_railway_line_codes は 属性 .railway_line_codes をもつ要素の配列（長さ1）
  array_of_railway_line_codes.each( function() {
    // --------
      // 属性 .railway_line_codes をもつ要素
      // var railway_line_codes = $( this ) ;
      // railway_line_codes.children() は、属性 .railway_line_codes をもつ要素の子要素の配列（.railway_line_code_block、長さ1）
      // railway_line_codes.children().each( function() {
    $( this ).children().each( function() {
    // --------
      // --------
        // 属性 .railway_line_code_block をもつ要素
        // var railway_line_code_block = $( this ) ;
        // railway_line_code_block は、属性 .railway_line_code_block をもつ要素
        // railway_line_code_block.children() - $( this ).children() は、属性 .railway_line_code_block をもつ要素の子要素の配列 (.yurakucho , .fukutoshin)
      $( this ).children().each( function() {
          // railway_line_name_domain は、属性 .yurakucho または .fukutoshin をもつ要素
          //   var railway_line_name_domain = $( this ) ;
          // railway_line_name_domain.children( '.railway_line_code_outer' ) は、属性 .yurakucho または .fukutoshin をもつ要素の子要素であり、
          // かつ 属性 .railway_line_code_outer をもつ要素の配列（.railway_line_code_outer、長さ1）
          //    railway_line_name_domain.children( '.railway_line_code_outer' ).each( function() {
          $( this ).children( '.railway_line_code_outer' ).each( function() {
            var railway_line_code_outer = $( this ) ;
            width_of_railway_line_code_box = Math.max( railway_line_code_outer.outerWidth( true ) , width_of_railway_line_code_box ) ;
            height_of_railway_line_code_box = Math.max( railway_line_code_outer.outerHeight( true ) , height_of_railway_line_code_box ) ;
          });
        });
    }) ;
  }) ;
  return [ width_of_railway_line_code_box , height_of_railway_line_code_box ] ;
}

// 属性 .railway_line_codes をもつ要素とその子孫要素の設定
function setAttributesToLineCodesAndChildren( railway_line_codes , width_of_railway_line_code_box , height_of_railway_line_code_box ) {
  // railway_line_codes.children() は、属性 .railway_line_codes をもつ要素の子要素の配列（.railway_line_code_block, 長さ 1）
  railway_line_codes.children().each( function() {
    // 属性 .railway_line_code_block をもつ要素
    //   var railway_line_code_block = $( this ) ;
    // .railway_line_code_block の高さを設定
    //   railway_line_code_block.css( 'height' , height_of_railway_line_code_box ) ;
    // 属性 .railway_line_code_block をもつ要素の子要素の配列 (.yurakucho , .fukutoshin)
    //   var elements_of_railway_line_codes = railway_line_code_block.children() ;
    // .yurakucho , .fukutoshin に幅と margin を設定
    //   setAttributesToLineDomain( width_of_railway_line_code_box , height_of_railway_line_code_box , elements_of_railway_line_codes ) ;
    // .railway_line_code_block の margin を設定
    //   setMarginToLineCodeBlock( railway_line_codes , railway_line_code_block , elements_of_railway_line_codes ) ;
    $( this ).css( 'height' , height_of_railway_line_code_box ) ;
    var elements_of_railway_line_codes = $( this ).children() ;
    setAttributesToLineDomain( width_of_railway_line_code_box , height_of_railway_line_code_box , elements_of_railway_line_codes ) ;
    setMarginToLineCodeBlock( railway_line_codes , $( this ) , elements_of_railway_line_codes ) ;
  });
}


// .yurakucho , .fukutoshin に幅と margin を設定する関数
function setAttributesToLineDomain( width_of_railway_line_code_box , height_of_railway_line_code_box , elements_of_railway_line_codes ) {
  elements_of_railway_line_codes.each( function() {
    // .yurakucho または .fukutoshin
    //  var line_domain = $( this ) ;
    // margin の大きさ
    //    const margin = 4 ;
    //  line_domain.css( 'width' , width_of_railway_line_code_box ).css( 'height' , height_of_railway_line_code_box ).css( 'margin-left' , margin ).css( 'margin-right' , margin ) ;

    const margin = 4 ;
    $( this ).css( 'width' , width_of_railway_line_code_box ).css( 'height' , height_of_railway_line_code_box ).css( 'margin-left' , margin ).css( 'margin-right' , margin ) ;
  }) ;
}

// .railway_line_code_block の margin を設定
function setMarginToLineCodeBlock( railway_line_codes , railway_line_code_block , elements_of_railway_line_codes ) {
  // .railway_line_code_block の幅を取得
  var width_of_railway_line_code_block = getWidthOfLineCodeBlock( elements_of_railway_line_codes ) ;
  // .railway_line_code_block の margin を決定
  var margin_of_railway_line_code_block = ( railway_line_codes.innerWidth() - width_of_railway_line_code_block ) * 0.5 ;
  railway_line_code_block.css( 'margin-left' , margin_of_railway_line_code_block ).css( 'margin-right' , margin_of_railway_line_code_block ) ;
}

// .railway_line_code_block の幅を取得する関数
function getWidthOfLineCodeBlock( elements_of_railway_line_codes ) {
  var width_of_railway_line_code_block = 0 ;
  elements_of_railway_line_codes.each( function() {
    // var line_domain = $( this ) ;
    // width_of_railway_line_code_block = width_of_railway_line_code_block + line_domain.outerWidth( true ) ;
    width_of_railway_line_code_block = width_of_railway_line_code_block + $( this ).outerWidth( true ) ;
  });
  return width_of_railway_line_code_block ;
}