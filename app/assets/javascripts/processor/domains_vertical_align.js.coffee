class DomainsVerticalAlignProcessor

  constructor: ( @domains , @outer_height_of_external_domain , @setting = 'middle' ) ->

  process: ->
    _outer_height_of_external_domain = @outer_height_of_external_domain
    switch @setting
      when 'middle'
        @domains.each ->
          p = new DomainVerticalAlignMiddleProcessor( $( this ) , _outer_height_of_external_domain )
          p.process()
          return
      when 'top'
        @domains.each ->
          p = new DomainVerticalAlignTopProcessor( $( this ) , _outer_height_of_external_domain )
          p.process()
          return
      when 'bottom'
        @domains.each ->
          p = new DomainVerticalAlignBottomProcessor( $( this ) , _outer_height_of_external_domain )
          p.process()
          return
    return

window.DomainsVerticalAlignProcessor = DomainsVerticalAlignProcessor

class DomainVerticalAlignMiddleProcessor

  constructor: ( @domain , @outer_height_of_external_domain ) ->

  outer_height: ->
    h = @domain.outerHeight( false )
    return h

  margin: ->
    p = ( @outer_height_of_external_domain - @.outer_height() ) * 0.5
    return p

  process: ->
    _margin = @.margin()
    @domain.css( 'margin-top' , _margin )
    @domain.css( 'margin-bottom' , _margin )
    return

class DomainVerticalAlignTopProcessor

  constructor: ( @domain , @outer_height_of_external_domain ) ->

  outer_height: ->
    h = @domain.outerHeight( false )
    return h

  margin: ->
    return @outer_height_of_external_domain - @.outer_height()

  process: ->
    _margin = @.margin()
    @domain.css( 'margin-bottom' , _margin )
    return

class DomainVerticalAlignBottomProcessor

  constructor: ( @domain , @outer_height_of_external_domain ) ->

  outer_height: ->
    h = @domain.outerHeight( false )
    return h

  margin: ->
    return @outer_height_of_external_domain - @.outer_height()

  process: ->
    _margin = @.margin()
    @domain.css( 'margin-top' , _margin )
    return