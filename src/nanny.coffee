#
# Project's main unit
#
# Copyright (C) 2012 Nikolay Nemshilov
#
class Nanny extends Element
  include: core.Options
  extend:
    Options:
      html:       null     # default html
      location:   'top'    # location top/left/right/bottom
      fxName:     'fade'
      fxDuration: 'normal'

  #
  # Basic constructor
  #
  # @param {Object} options
  #
  constructor: (options)->
    options = options[0] if options instanceof NodeList

    if options instanceof $.Element
      @scope options
    else
      @setOptions options

    super 'div', class: 'nanny'

    @append(
      @icon = new Element('div', class: 'nanny-icon'),
      @body = new Element('div', class: 'nanny-body'))

    @icon.on('click', => @hide())

    return @

  #
  # Shows the nanny at the scope element
  #
  # NOTE: wont' do anything if the scope element is not set
  #
  # @return {Nanny} self
  #
  show: ->
    return @ if !@_scope

    @style(display: 'none').insertTo(@_scope, 'top')
    @body.html @options.html
    @removeClass('nanny-top').removeClass('nanny-left').removeClass('nanny-right').removeClass('nanny-bottom')
    @addClass "nanny-#{@options.location}"

    @$super(@options.fxName, duration: @options.fxDuration, finish: => @fire('show'))
    if @options.fxName then @ else @fire('show')

  #
  # Hides an open nanny and removes it out of the dom's tree
  #
  # @return {Nanny} self
  #
  hide: ->
    @$super(@options.fxName, duration: @options.fxDuration, finish: => @fire('hide'))
    if @options.fxName then @ else @fire('hide')


  #
  # sets/reads the current scope
  #
  # @param {HTMLElement|dom.Element} the scope element
  # @return {Nanny|dom.Element}
  #
  scope: (element)->
    if element is undefined
      return @_scope

    else
      @_scope = $(element)
      @_scope = @_scope[0] if @_scope instanceof NodeList

      if @_scope
        @_scope.on
          mouseenter: => @show()
          mouseleave: => @hide()

        options = @_scope.data('nanny') || {}
        options.html or= @_scope.attr('title') || ''
        @_scope.attr('title', null)

        @_scope.nanny = @setOptions options

    return @
