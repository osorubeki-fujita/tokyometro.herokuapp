class DomainsVerticalAlignProcessor

  constructor: ( @domains , @outer_height_of_external_domain = 'auto' , @setting = 'middle' ) ->

  _outer_height_of_external_domain = (v) ->
    if v.outer_height_of_external_domain? and v.outer_height_of_external_domain isnt 'auto'
      h = v.outer_height_of_external_domain
    else
      # console.log v.domains
      # console.log v.outer_height_of_external_domain
      # console.log v.setting
      p = new DomainsCommonProcessor( v.domains )
      h = p.max_outer_height( false )
    return h

  process: ->
    _outer_h = _outer_height_of_external_domain(@)
    switch @setting
      when 'middle'
        @domains.each ->
          p = new DomainVerticalAlignMiddleProcessor( $( @ ) , _outer_h )
          p.process()
          return
      when 'top'
        @domains.each ->
          p = new DomainVerticalAlignTopProcessor( $( @ ) , _outer_h )
          p.process()
          return
      when 'bottom'
        @domains.each ->
          p = new DomainVerticalAlignBottomProcessor( $( @ ) , _outer_h )
          p.process()
          return
    return

window.DomainsVerticalAlignProcessor = DomainsVerticalAlignProcessor

class DomainVerticalAlignCommonProcessor

  constructor: ( @domain , @outer_height_of_external_domain ) ->

  outer_height: ->
    h = @domain.outerHeight( false )
    return h

  margin: ->
    return @outer_height_of_external_domain - @.outer_height()

  margin_is_zero = (v) ->
    return v.margin is 0

  process: ->
    unless margin_is_zero(@)
      _margin = @.margin()
      _domain = @domain
      _attributes = @.attributes()
      for i in [ 0..( _attributes.length - 1 ) ]
        _attr = _attributes[i]
        if i is 0
          m = Math.floor( _margin )
        else
          m = Math.ceil( _margin )
        _domain.css( _attr , m )
        i += 1
    return

class DomainVerticalAlignMiddleProcessor extends DomainVerticalAlignCommonProcessor

  margin: ->
    p = ( @outer_height_of_external_domain - @.outer_height() ) * 0.5
    return p

  attributes: ->
    return [ 'margin-top' , 'margin-bottom' ]

class DomainVerticalAlignTopProcessor extends DomainVerticalAlignCommonProcessor

  attributes: ->
    return [ 'margin-bottom' ]

class DomainVerticalAlignBottomProcessor extends DomainVerticalAlignCommonProcessor

  attributes: ->
    return [ 'margin-top' ]