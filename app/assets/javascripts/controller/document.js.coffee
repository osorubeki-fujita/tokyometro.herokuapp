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

  constructor: ( @domain = $( 'ul#links_to_document_pages' ) ) ->

  has_links_to_document_pages = (v) ->
    return v.domain.length > 0

  text_domains = (v) ->
    return v.domain.find( '.text' )

  width_of_text = (v) ->
    # console.log( 'LinkToDocumentContents\#width_of_text' )
    p = new DomainsCommonProcessor( text_domains(v) )
    return p.max_outer_width( true )

  model_name_domains = (v) ->
    return v.domain.find( '.model_name.text_en' )

  width_of_model_name = (v) ->
    p = new DomainsCommonProcessor( model_name_domains(v) )
    return p.max_outer_width( true )

  process: ->
    if has_links_to_document_pages(@)
      # console.log( 'LinkToDocumentContents\#process' )
      process_domain(@)
      process_each_link(@)
    return

  process_domain = (v) ->
    # console.log 'LinkToDocumentContents\#process_domain'
    p1 = new DomainsCommonProcessor( text_domains(v) )
    p1.set_css_attribute( 'width' , width_of_text(v) )
    p2 = new DomainsCommonProcessor( model_name_domains(v) )
    p2.set_css_attribute( 'width' , width_of_model_name(v) )
    return

  process_each_link = (v) ->
    # console.log( 'LinkToDocumentContents\#process_each_content' )
    v.domain.children().each ->
      # console.log( $( this ) )
      d = new LinkToEachDocument( $( this ) )
      d.process()
      return
    return

class LinkToEachDocument

  constructor: ( @domain ) ->

  domain_of_link_to_document = (v) ->
    return v.domain.children( '.link_to_document' ).first()

  text = (v) ->
    return domain_of_link_to_document(v).children( '.text' ).first()

  model_name_text_en = (v) ->
    return domain_of_link_to_document(v).children( '.model_name.text_en' ).first()

  height_of_link_to_document_new = (v) ->
    p = new DomainsCommonProcessor( domain_of_link_to_document(v).children() )
    return p.max_outer_height( true )

  sum_width_of_link_to_document_new = (v) ->
    p = new DomainsCommonProcessor( domain_of_link_to_document(v).children() )
    return p.sum_outer_width( true )

  process: ->
    w = sum_width_of_link_to_document_new(@)
    h = height_of_link_to_document_new(@)
    p = new DomainsVerticalAlignProcessor( domain_of_link_to_document(@).children() , h , 'bottom' )
    p.process()
    domain_of_link_to_document(@).css( 'width' , w )
    domain_of_link_to_document(@).css( 'height' , h )
    @domain.css( 'width' , domain_of_link_to_document(@).outerWidth( true ) )
    return

#--------------------------------

class ColorInfosInDocument

  constructor: ( @domain = $( 'div#railway_lines' ) ) ->

  has_color_infos_in_document = (v) ->
    return v.domain.length > 0

  top_contents = (v) ->
    return v.domain.find( '.top' )

  process: ->
    if has_color_infos_in_document(@)
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

  has_train_types = (v) ->
    return v.domain.length > 0

  document_info_boxes = (v) ->
    return v.domain
      .find( 'ul.train_types_of_each_railway_line.in_document' )
      .children( 'li.document_info_box' )

  max_width_of_train_type_name_box = (v) ->
    # console.log 'TrainTypesInDocument\#max_width_of_train_type_name_box'
    len = 0
    document_info_boxes(v).each ->
      train_type = new TrainTypeInDocument( $( this ) )
      train_type.update_width_of_train_type_name_box()
      len = Math.max( train_type.train_type_name_box().width() , len )
      return
    return len

  max_width_of_train_type_name = (v) ->
    # console.log 'TrainTypesInDocument\#max_width_of_train_type_name'
    len = 0
    document_info_boxes(v).each ->
      train_type = new TrainTypeInDocument( $( this ) )
      train_type.update_width_of_train_type_name()
      len = Math.max( train_type.train_type_name().outerWidth() , len )
      return
    return len

  process: ->
    if has_train_types(@)
      process_train_type_domains(@)
    return

  process_train_type_domains = (v) ->
    _max_width_of_train_type_name_box = max_width_of_train_type_name_box(v)
    _max_width_of_train_type_name = max_width_of_train_type_name(v)
    document_info_boxes(v).each ->
      train_type = new TrainTypeInDocument( $( this ) )
      train_type.train_type_name_box().css( 'width' , _max_width_of_train_type_name_box )
      train_type.train_type_name().css( 'width' , _max_width_of_train_type_name )
      return
    return

class TrainTypeInDocument

  constructor: ( @domain ) ->

  train_type_name_box: ->
    return @domain
      .children( '.main' )
      .children( '.train_type' )
      .first()

  train_type_name: ->
    return @domain
      .children( '.main' )
      .children( '.train_type_name' )
      .first()

  update_width_of_train_type_name_box: ->
    p = new LengthToEven( @.train_type_name_box() , true )
    p.set()
    return

  update_width_of_train_type_name: ->
    p = new LengthToEven( @.train_type_name() , true )
    p.set()
    return
