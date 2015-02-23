processDocument = ->
  processLinkToEachDocument()
  processColorInfoInDocument()
  processTrainTypeNameInDocument()
  return

window.processDocument = processDocument

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
# processTrainTypeNameInDocument
#--------------------------------

processTrainTypeNameInDocument = ->
  max_width_of_train_type_name = 0
  domains_of_document_info_box_wide = $( '#train_types' ).find( '.document_info_box_wide' )
  domains_of_document_info_box_wide.each ->
    train_type_name = $( this ).children( '.train_type_name' ).first()
    max_width_of_train_type_name = Math.max( train_type_name.outerWidth() , max_width_of_train_type_name )
    return
  domains_of_document_info_box_wide.each ->
    $( this ).children( '.train_type_name' ).first().css( 'width' , max_width_of_train_type_name )
    return
  return