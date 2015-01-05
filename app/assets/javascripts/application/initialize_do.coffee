initializeDo = ->
  processTopContent
  processLinkToEachDocument
  processColorInfoInDocument
  processLineAndStationMatrixes
  changeAttrOfStationTimetable
  return

window.initializeDo = initializeDo

#----------------------------------------------------------------
# common_sub_functions
#----------------------------------------------------------------

#--------------------------------
# changeWidth
# 幅の変更
#--------------------------------

changeWidth = ( jq , length ) ->
  jq.css( 'width' , length + 'px' )
  return

window.changeWidth = changeWidth

#--------------------------------
# changeMarginOfLineBoxInfoDomain
#--------------------------------

changeMarginOfLineBoxInfoDomain = ( matrix , line_info ) ->
  contents_of_special_railway_line_info = line_info.children()
  railway_line_code_domain = contents_of_special_railway_line_info.eq(0)
  text_ja = contents_of_special_railway_line_info.eq(1)
  text_en = contents_of_special_railway_line_info.eq(2)

  height_of_special_railway_line_info = railway_line_code_domain.outerHeight( true ) + text_ja.outerHeight( true ) + text_en.outerHeight( true ) ;

  line_info.css( 'height' , height_of_special_railway_line_info )
  special_railway_line_info_margin = ( matrix.innerHeight() - height_of_special_railway_line_info ) * 0.5
  line_info.css( 'margin-top' , special_railway_line_info_margin ).css( 'margin-bottom' , special_railway_line_info_margin )
  return

window.changeMarginOfLineBoxInfoDomain = changeMarginOfLineBoxInfoDomain


#--------------------------------
# getMaxLength
#--------------------------------

getMaxOuterHeight = ( domains , settings ) ->
  len = 0
  domains.each ->
    len = Math.max( len , $( this ).outerHeight( settings ) )
  return len

getMaxHeight = ( domains ) ->
  len = 0
  domains.each ->
    len = Math.max( len , $( this ).height() )
  return len

getMaxOuterWidth = ( domains , settings ) ->
  len = 0
  domains.each ->
    len = Math.max( len , $( this ).outerWidth( settings ) )
  return len

getMaxWidth = ( domains ) ->
  len = 0
  domains.each ->
    len = Math.max( len , $( this ).width() )
  return len

window.getMaxOuterHeight = getMaxOuterHeight
window.getMaxHeight = getMaxHeight
window.getMaxOuterWidth = getMaxOuterWidth
window.getMaxWidth = getMaxWidth

#--------------------------------
# getSumLength
#--------------------------------

getSumOuterHeight = ( domains , settings ) ->
  len = 0
  domains.each ->
    len = len + $( this ).outerHeight( settings )
  return len

getSumHeight = ( domains ) ->
  len = 0
  domains.each ->
    len = len + $( this ).height()
  return len

getSumOuterWidth = ( domains , settings ) ->
  len = 0
  domains.each ->
    len = len + $( this ).outerWidth( settings )
  return len

getSumWidth = ( domains ) ->
  len = 0
  domains.each ->
    len = len + $( this ).width()
  return len

window.getSumOuterHeight = getSumOuterHeight
window.getSumHeight = getSumHeight
window.getSumOuterWidth = getSumOuterWidth
window.getSumWidth = getSumWidth

#--------------------------------
# setAllOfUniformLengthToMax
#--------------------------------

setAllOfUniformWidthToMax = ( blocks ) ->
  max_width = getMaxWidth( blocks )
  blocks.each ->
    $( this ).css( 'width' , max_width )
  return

setAllOfUniformHeightToMax = ( blocks ) ->
  max_height = getMaxHeight( blocks )
  blocks.each ->
    $( this ).css( 'height' , max_height )
  return

window.setAllOfUniformWidthToMax = setAllOfUniformWidthToMax
window.setAllOfUniformHeightToMax = setAllOfUniformHeightToMax

#-------- setCssAttributes
setCssAttributesToEachDomain = ( domains , css_attributes , css_value ) ->
  domains.each ->
    $( this ).css( css_attributes , css_value )
  return

window.setCssAttributesToEachDomain = setCssAttributesToEachDomain


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

#--------------------------------
# changeAttrOfStationTimetable
#--------------------------------

changeAttrOfStationTimetable = ->
  timetables = $( 'table.timetable' )
  changeWidthOfOperationDay( timetables )
  changeAttibutesOfTopHeader( timetables )
  changeWidthOfTdHour( timetables )
  changeWidthOfMin( timetables )
  changeWidthAndHeightOfTrainTime( timetables )
  return

changeWidthOfOperationDay = ( timetables ) ->
  domains_of_weekday_and_holiday = timetables.find( '.operation_day' )
  changeWidthOfContentsInTimetable( domains_of_weekday_and_holiday )
  # setVarticalPositionOfOperationDay( domains_of_weekday_and_holiday )
  return

changeAttibutesOfTopHeader = ( timetables ) ->
  timetables.each ->
    timetable_top_header = $( this ).find( 'td.top_header' ).eq(0)
    main_domain = timetable_top_header.children( '.main' ).eq(0)
    max_height_of_main_domain = getMaxOuterHeight( main_domain.children() , true )
    
    main_domain.css( 'height' , max_height_of_main_domain )

    direction = main_domain.children( '.direction' ).eq(0)
    additional_infos = main_domain.children( '.additional_infos' ).eq(0)
    margin_top_and_bottom = ( max_height_of_main_domain - direction.height() ) * 0.5

    direction.css( 'margin-top' , margin_top_and_bottom )
    direction.css( 'margin-bottom' , margin_top_and_bottom )
    additional_infos.css( 'margin-top' , margin_top_and_bottom )
    return
  return

changeWidthOfTdHour = ( timetables ) ->
  domains_of_hour = timetables.find( '.hour' )
  changeWidthOfContentsInTimetable( domains_of_hour )
  return

changeWidthOfMin = ( timetables ) ->
  blocks = timetables.find( '.min' )
  width_new = getMaxWidth( blocks )
  setCssAttributesToEachDomain( blocks , 'width' , width_new )
  return

changeWidthAndHeightOfTrainTime = ( timetables ) ->
  timetables.each ->
    timetable = $( this )
    train_time_blocks = timetable.find( '.train_time' )
    train_time_block_max_width = getMaxWidth( train_time_blocks )

    setCssAttributesToEachDomain( train_time_blocks , 'width' , train_time_block_max_width )

    domains_of_each_hour = timetable.find( 'td.train_times' )
    domains_of_each_hour.each ->
      domain_of_an_hour = $( this )
      domains_of_train_times = domain_of_an_hour.children( '.train_time' )
      height_max = getMaxHeight( domains_of_train_times )

      setCssAttributesToEachDomain( domains_of_train_times , 'height' , height_max )
      return
    return
  return

changeWidthOfContentsInTimetable = ( blocks ) ->
  max_width = getMaxWidth( blocks )
  width_new = Math.ceil( max_width * goldenRatio )
  padding = Math.ceil( ( width_new - max_width ) * 0.5 )

  width_new = max_width + padding * 2
  setCssAttributesToEachDomain( blocks , 'width' , width_new )
  setCssAttributesToEachDomain( blocks , 'padding-left' , padding )
  setCssAttributesToEachDomain( blocks , 'padding-right' , padding )
  return

setVarticalPositionOfOperationDay = ( domains_of_weekday_and_holiday ) ->
  domains_of_weekday_and_holiday.each ->
    height_of_domain = $( this ).height()
    height_of_text = getMaxOuterHeight( $( this ).children() , true )
    padding_top_and_bottom = ( height_of_domain - height_of_text ) * 0.5

    $( this ).css( 'padding-top' , padding_top_and_bottom )
    $( this ).css( 'padding-bottom' , padding_top_and_bottom )
    return
  return