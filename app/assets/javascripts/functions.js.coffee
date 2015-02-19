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

window.getMaxOuterWidth = getMaxOuterWidth
window.getMaxWidth = getMaxWidth
window.getMaxOuterHeight = getMaxOuterHeight
window.getMaxHeight = getMaxHeight

#--------------------------------
# getSumLength
#--------------------------------

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

window.getSumOuterWidth = getSumOuterWidth
window.getSumWidth = getSumWidth
window.getSumOuterHeight = getSumOuterHeight
window.getSumHeight = getSumHeight

#--------------------------------
# setAllOfUniformLengthToMax
#--------------------------------

setAllOfUniformWidthToMax = ( blocks ) ->
  max_width = getMaxOuterWidth( blocks , false )
  blocks.each ->
    $( this ).css( 'width' , max_width )
  return

setAllOfUniformHeightToMax = ( blocks ) ->
  max_height = getMaxOuterHeight( blocks , false )
  blocks.each ->
    $( this ).css( 'height' , max_height )
  return

window.setAllOfUniformWidthToMax = setAllOfUniformWidthToMax
window.setAllOfUniformHeightToMax = setAllOfUniformHeightToMax

#--------------------------------
# setCssAttributes
#--------------------------------

setCssAttributesToEachDomain = ( domains , css_attributes , css_value ) ->
  domains.each ->
    $( this ).css( css_attributes , css_value )
  return

window.setCssAttributesToEachDomain = setCssAttributesToEachDomain