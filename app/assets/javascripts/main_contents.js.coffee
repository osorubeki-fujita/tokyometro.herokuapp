#-------- メイン要素の操作
processMainContents = ->
  setHeightOfMainContents()
  return

window.processMainContents = processMainContents

#-------- メイン要素の高さを揃える
setHeightOfMainContents = ->
  # 高さ (outerHeight) の最大値（初期設定）
  max_height = 0
  
  # div#left_contents の高さ (outerHeight)
  height_of_left_contents = $( 'div#left_contents' ).outerHeight()
  
  # div#main_content_center の高さ (outerHeight)
  height_of_main_content_center = $( 'div#main_content_center' ).outerHeight()
  
  # div#main_content_wide の高さ (outerHeight)
  height_of_main_content_wide = $( 'div#main_content_wide' ).outerHeight()
  
  # div#right_contents の高さ (outerHeight)
  height_of_right_contents = $( 'div#right_contents' ).outerHeight()
  
  # 高さ (outerHeight) の最大値
  #---- 【注意】実際の最大値に 64px を加える
  max_height = Math.max( max_height , height_of_left_contents , height_of_main_content_center , height_of_main_content_wide , height_of_right_contents ) + 32

  padding_top_of_contents = 8 # $( 'div#contents' ).paddingTop
  padding_bottom_of_contents = 8 # $( 'div#contents' ).paddingBottom

  # div#main_content , div#list_of_contents , div#main_content_center の各要素に高さを設定
  $('div#contents').css( 'height' , max_height + padding_top_of_contents + padding_bottom_of_contents )
  $('div#left_contents').css( 'height' , max_height )
  $('div#main_content_center').css( 'height' , max_height )
  $('div#main_content_wide').css( 'height' , max_height )
  $('div#right_contents').css( 'height' , max_height )
  return