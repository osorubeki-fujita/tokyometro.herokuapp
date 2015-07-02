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

class DomainHorizontalAlignCommonProcessor

  constructor: ( @domain , @outer_width_of_external_domain ) ->

  outer_width: ->
    w = @domain.outerWidth( false )
    return w

  margin: ->
    return @outer_width_of_external_domain - @.outer_width()

  process: ->
    _margin = @.margin()
    _domain = @domain
    _attributes = @.attributes()
    unless _margin is 0
      $.each _attributes , ->
        _attr = @
        _domain.css( _attr , _margin )
        return
    return

class DomainHorizontalAlignCenterProcessor extends DomainHorizontalAlignCommonProcessor

  margin: ->
    m = ( @outer_width_of_external_domain - @.outer_width() ) * 0.5
    return m

  attributes: ->
    return [ 'margin-left' , 'margin-right' ]

class DomainHorizontalAlignLeftProcessor extends DomainHorizontalAlignCommonProcessor

  attributes: ->
    return [ 'margin-right' ]

class DomainHorizontalAlignRightProcessor extends DomainHorizontalAlignCommonProcessor

  attributes: ->
    return [ 'margin-left' ]