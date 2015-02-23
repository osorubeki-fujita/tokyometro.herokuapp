initializeDo = ->
  processTopContent()
  processDocument()
  processLineAndStationMatrixes()
  processRailwayLine()
  processStationTimetable()
  processStationFacility()
  processPassengerSurvey()
  processMainContents()
  # processBottomContent() 不使用
  return

window.initializeDo = initializeDo

#----------------------------------------------------------------
# 個別の操作
#----------------------------------------------------------------

#--------------------------------
# processTopContent
# top_content の操作
#--------------------------------

processTopContent = ->
  top_content = $( 'div#top_content' )
  domain_of_text = top_content.children( '.text' ).first()
  domain_of_title = domain_of_text.children( '.title' ).first()
  domain_of_now_developing = domain_of_text.children( '.now_developing' ).first()

  domain_of_now_developing.css( 'margin-top' , domain_of_title.outerHeight() - domain_of_now_developing.outerHeight() )

  margin_of_domain_of_text = ( top_content.innerHeight() - domain_of_title.outerHeight() ) * 0.5
  domain_of_text.css( 'margin-top' , margin_of_domain_of_text ).css( 'margin-bottom' , margin_of_domain_of_text )
  return

#--------------------------------
# processLineAndStationMatrixes
# 路線記号の操作
#--------------------------------

processLineAndStationMatrixes = ->
  selector_for_railway_line_matrixes = "#railway_line_matrixes"

  # 一般路線の数 (const)
  numberOfNormalLines = 9

  #-------- 9路線の整列

  # 1行に表示する路線数 (const)
  lineDivision = 3
  # box の border の幅 (const)
  width_of_border = 1

  # 路線の box (.line_box) の要素の集合
  line_boxes = $( selector_for_railway_line_matrixes ).children()

  # 特殊路線（「有楽町線・副都心線」など）の数
  number_of_special_railway_lines = line_boxes.size() - numberOfNormalLines
  # 一般路線の集合
  normal_railway_lines = line_boxes.slice( 0 , numberOfNormalLines )
  # 特殊路線の集合
  special_railway_lines = line_boxes.slice( numberOfNormalLines )

  # 一般路線の box の高さ (outerHeight)
  outer_height_of_each_line = normal_railway_lines.first().outerHeight()
  # 中央の div#main_content_center の幅 (innerWidth)
  width_of_main_content_center = $( 'div#main_content_center' ).innerWidth()

  # 一般路線の幅の決定
  width_of_each_normal_railway_line = Math.floor( ( width_of_main_content_center - ( lineDivision + 1 ) * width_of_border ) * 1.0 / lineDivision )

  # 特殊路線の幅の決定
  width_of_special_railway_lines_in_railway_line_matrixes = ( width_of_each_normal_railway_line *  lineDivision + ( lineDivision - 1 ) * width_of_border )

  changeAttributesOfBoxesInLineMatrixes( selector_for_railway_line_matrixes , normal_railway_lines , special_railway_lines , width_of_each_normal_railway_line , width_of_special_railway_lines_in_railway_line_matrixes , lineDivision , number_of_special_railway_lines , outer_height_of_each_line , width_of_border )

  changeWidth( $( 'div#main_content_center' ) , width_of_special_railway_lines_in_railway_line_matrixes + width_of_border * 2 )

  processStationMatrixes( "#station_matrixes" , width_of_main_content_center , width_of_each_normal_railway_line , width_of_border )
  processStationMatrixes( "#train_informations" , width_of_main_content_center , width_of_each_normal_railway_line , width_of_border )
  # changeAttibutesOfBoxesInTrainInformation( width_of_each_normal_railway_line )

  # 路線記号の文字の垂直方向の位置を、円の中心へ
  moveLineCodeLettersToCenter()
  return

#-------- 路線記号の文字の垂直方向の位置を、円の中心へ
# 記号すべて
moveLineCodeLettersToCenter = ->
  $( 'div.railway_line_code_48 , div.railway_line_code_32 , div.railway_line_code_24 , div.railway_line_code_16' ).each ->
  
    #---- 路線記号の文字の垂直方向の位置を、円の中心へ
    # それぞれの記号
    
    # .railway_line_code の高さ (innnerHeight) を取得
    height_of_railway_line_code = $( this ).innerHeight()
    
    # .railway_line_code の子要素である p タグを操作
    $( this ).children('p').each ->
      p_domain = $( this )
      # p タグの高さ (outerHeight) を取得
      height_of_p = p_domain.outerHeight( true )
      # p タグの上下の margin を決定
      margin_of_p = ( ( height_of_railway_line_code - height_of_p ) * 0.5 ) + 'px'
      # p タグの上下の margin を適用
      p_domain.css( 'marginTop' , margin_of_p ).css( 'marginBottom' , margin_of_p )
      return

    return
  return

#--------------------------------
# bottom_content
# （不使用）
#--------------------------------

processBottomContent = ->
  bottom_content = $( 'div#bottom_content' )
  links = bottom_content.children( '.links' )
  height_of_domain = bottom_content.outerHeight( true )
  margin_of_links = ( height_of_domain - getSumOuterHeight( links , true ) ) * 0.5
  setCssAttributesToEachDomain( links , 'margin-top' , margin_of_links )
  setCssAttributesToEachDomain( links , 'margin-bottom' , margin_of_links )
  return