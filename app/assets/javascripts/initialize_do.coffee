initializeDo = ->
  processTopContent()
  processLinkToEachDocument()
  processColorInfoInDocument()
  processLineAndStationMatrixes()
  processRailwayLine()
  processStationTimetable()
  processStationFacility()
  processPassengerSurvey()
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
# processLinkToEachDocument
#--------------------------------

processLinkToEachDocument = ->
  links_to_datas = $( '#links_to_datas' )
  width_of_content_name = 0

  links_to_datas.contents().each ->
    link_to_content = $( this )

    text = link_to_content.children( '.text' ).first()
    content_name = text.children( '.content_name' ).first()
    model_name_text_en = text.children( '.model_name.text_en' ).first()

    height_of_content_name = content_name.innerHeight()

    width_of_content_name = Math.max( width_of_content_name , content_name.innerWidth() )

    model_name_text_en.css( 'margin-top' , height_of_content_name - model_name_text_en.innerHeight() )
    text.css( 'height' , height_of_content_name )
    link_to_content.css( 'height' , text.outerHeight( true ) )
    return

  content_names = links_to_datas.find( '.content_name' )
  setCssAttributesToEachDomain( content_names , 'width' , width_of_content_name )
  setCssAttributesToEachDomain( content_names , 'margin-right' , 16 )
  return

#--------------------------------
# processColorInfoInDocument
#--------------------------------

processColorInfoInDocument = ->
  $( 'div#railway_lines' ).find( '.top' ).each ->
    top_domain = $( this )
    height_of_top_domain = getSumOuterHeight( top_domain , true )
    color_info_domain = top_domain.children( '.color_info' ).first()
    color_info_domain.css( 'margin-top' , height_of_top_domain - color_info_domain.outerHeight( true ) )
    top_domain.css( 'height' , height_of_top_domain )
  return

#--------------------------------
# processLineAndStationMatrixes
# 路線記号の操作
#--------------------------------

processLineAndStationMatrixes = ->
  selector_for_railway_line_matrixes = "#railway_line_matrixes"
  selector_for_station_matrixes =  "#station_matrixes"

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

  changeAttributesOfBoxesInStationMatrixes( selector_for_station_matrixes , width_of_main_content_center , width_of_each_normal_railway_line , width_of_border )
  changeAttributesOfBoxesInStationMatrixes( "#train_informations" , width_of_main_content_center , width_of_each_normal_railway_line , width_of_border )
  # changeAttibutesOfBoxesInTrainInformation( width_of_each_normal_railway_line )

  # 路線記号の文字の垂直方向の位置を、円の中心へ
  moveLineCodeLettersToCenter()
  return