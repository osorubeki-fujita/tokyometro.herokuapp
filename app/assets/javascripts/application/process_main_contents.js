//-------- メイン要素の操作
function processMainContents() {
  //-------- メイン要素の高さを揃える
  setHeightOfMainContents() ;
}

//-------- メイン要素の高さを揃える
function setHeightOfMainContents() {
  // 高さ (outerHeight) の最大値（初期設定）
  var maxHeight = 0 ;
  // div#left_contents の高さ (outerHeight)
  var height_of_left_contents = $( 'div#left_contents' ).outerHeight() ;
  // div#main_content_center の高さ (outerHeight)
  var height_of_main_content_center = $( 'div#main_content_center' ).outerHeight() ;
  // div#main_content_wide の高さ (outerHeight)
  var height_of_main_content_wide = $( 'div#main_content_wide' ).outerHeight() ;
  // div#right_contents の高さ (outerHeight)
  var height_of_right_contents = $( 'div#right_contents' ).outerHeight() ;
  // 高さ (outerHeight) の最大値
  // ---- 【注意】実際の最大値に 64px を加える
  maxHeight = Math.max( maxHeight , height_of_left_contents , height_of_main_content_center , height_of_main_content_wide , height_of_right_contents ) + 32 ;

  var padding_top_of_contents = 8 ; // $( 'div#contents' ).paddingTop ;
  var padding_bottom_of_contents = 8 ; // $( 'div#contents' ).paddingBottom ;

  // div#main_content , div#list_of_contents , div#main_content_center の各要素に高さを設定
  $('div#contents').css( 'height' , maxHeight + padding_top_of_contents + padding_bottom_of_contents );
  $('div#left_contents').css( 'height' , maxHeight );
  $('div#main_content_center').css( 'height' , maxHeight );
  $('div#main_content_wide').css( 'height' , maxHeight );
  $('div#right_contents').css( 'height' , maxHeight );
}