class DomainsHorizontalAlignProcessor

  constructor: ( @domains , @outer_width_of_external_domain , @setting = 'center' ) ->

  process: ->
    _outer_width_of_external_domain = @outer_width_of_external_domain
    switch @setting
      when 'center'
        @domains.each ->
          p = new DomainHorizontalAlignCenterProcessor( $( this ) , _outer_width_of_external_domain )
          p.process()
          return
      when 'left'
        @domains.each ->
          p = new DomainHorizontalAlignLeftProcessor( $( this ) , _outer_width_of_external_domain )
          p.process()
          return
      when 'right'
        @domains.each ->
          p = new DomainHorizontalAlignRightProcessor( $( this ) , _outer_width_of_external_domain )
          p.process()
          return
    return

window.DomainsHorizontalAlignProcessor = DomainsHorizontalAlignProcessor

class DomainHorizontalAlignCenterProcessor

  constructor: ( @domain , @outer_width_of_external_domain ) ->

  outer_width: ->
    w = @domain.outerWidth( false )
    return w

  margin: ->
    m = ( @outer_width_of_external_domain - @.outer_width() ) * 0.5
    return m

  process: ->
    _margin = @.margin()
    @domain.css( 'margin-left' , _margin )
    @domain.css( 'margin-right' , _margin )
    return

class DomainHorizontalAlignLeftProcessor

  constructor: ( @domain , @outer_width_of_external_domain ) ->

  outer_width: ->
    m = @domain.outerWidth( false )
    return m

  margin: ->
    return @outer_width_of_external_domain - @.outer_width()

  process: ->
    _margin = @.margin()
    @domain.css( 'margin-right' , _margin )
    return

class DomainHorizontalAlignRightProcessor

  constructor: ( @domain , @outer_width_of_external_domain ) ->

  outer_width: ->
    m = @domain.outerWidth( false )
    return m

  margin: ->
    return @outer_width_of_external_domain - @.outer_width()

  process: ->
    _margin = @.margin()
    @domain.css( 'margin-left' , _margin )
    return