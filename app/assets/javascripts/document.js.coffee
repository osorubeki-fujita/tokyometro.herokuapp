class Document

  constructor: ->

  process: ->
    link_to_document_contents = new LinkToDocumentContents()
    color_infos_in_document = new ColorInfosInDocument()
    train_types_in_document = new TrainTypesInDocument()

    link_to_document_contents.process()
    color_infos_in_document.process()
    train_types_in_document.process()
    return

window.Document = Document

#--------------------------------

class LinkToDocumentContents

  constructor: ( @domain = $( '#links_to_datas' ) ) ->

  content_name_domains = (v) ->
    return v.domain.find( '.content_name' )

  width_of_content_name = (v) ->
    console.log 'LinkToDocumentContents\#width_of_content_name'
    p = new DomainsCommonProcessor( content_name_domains(v).children() )
    return p.max_width()

  process_domain = (v) ->
    # console.log 'LinkToDocumentContents\#process_domain'
    _content_name_domains = content_name_domains(v)
    p = new DomainsCommonProcessor( _content_name_domains )
    p.set_css_attribute( 'width' , width_of_content_name(v) )
    p.set_css_attribute( 'margin-right' , 16 )
    return

  process_each_content = (v) ->
    console.log 'LinkToDocumentContents\#process_each_content'
    v.domain.children().each ->
      console.log $( this )
      d = new LinkToEachDocument( $( this ) )
      d.process()
      return
    return

  process: ->
    console.log 'LinkToDocumentContents\#process'
    process_each_content(@)
    process_domain(@)
    return

class LinkToEachDocument

  constructor: ( @domain ) ->

  text = (v) ->
    return v.domain.children( '.text' ).first()

  content_name = (v) ->
    return text(v).children( '.content_name' ).first()

  model_name_text_en = (v) ->
    return text(v).children( '.model_name.text_en' ).first()

  height_of_content_name = (v) ->
    return content_name(v).innerHeight()

  margin_top_of_model_name_text_en = (v) ->
    return height_of_content_name(v) - model_name_text_en(v).innerHeight()

  process: ->
    _text = text(@)
    model_name_text_en(@).css( 'margin-top' , margin_top_of_model_name_text_en(@) )
    _text.css( 'height' , height_of_content_name(@) )
    @domain.css( 'height' , _text.outerHeight( true ) )
    return

#--------------------------------

class ColorInfosInDocument
  constructor: ( @domain = $( 'div#railway_lines' ) ) ->

  top_contents = (v) ->
    return v.domain.find( '.top' )

  process: ->
    top_contents(@).each ->
      d = new ColorInfoInDocumentEachTop( $( this ) )
      d.process()
      return
    return

class ColorInfoInDocumentEachTop
  constructor: ( @domain ) ->

  height_of_top_domain = (v) ->
    p = new DomainsCommonProcessor( v.domain )
    return p.sum_outer_height( true )

  color_info = (v) ->
    return v.domain.children( '.color_info' ).first()

  margin_top_of_color_info = (v) ->
    return height_of_top_domain(v) - color_info(v).outerHeight( true )

  process: ->
    color_info(@).css( 'margin-top' , margin_top_of_color_info(@) )
    @domain.css( 'height' , height_of_top_domain(@) )
    return

#--------------------------------


class TrainTypesInDocument
  constructor: ( @domain = $( '#train_types' ) ) ->

  document_info_boxes = (v) ->
    return v.domain.find( '.document_info_box_wide' )

  max_width_of_train_type_name = (v) ->
    # console.log 'TrainTypesInDocument\#max_width_of_train_type_name'
    len = 0
    document_info_boxes(v).each ->
      train_type = new TrainTypeInDocument( $( this ) )
      len = Math.max( train_type.train_type_name().outerWidth() , len )
      return
    return len

  process: ->
    _max_width_of_train_type_name = max_width_of_train_type_name(@)
    document_info_boxes(@).each ->
      train_type = new TrainTypeInDocument( $( this ) )
      train_type.train_type_name().css( 'width' , _max_width_of_train_type_name )
      return
    return

class TrainTypeInDocument
  constructor: ( @domain ) ->
  train_type_name: ->
    return @domain.children( '.train_type_name' ).first()