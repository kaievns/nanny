#
# Project's main unit
#
# Copyright (C) 2012 Nikolay Nemshilov
#
class Nanny extends Element
  include: core.Options
  extend:
    Options:
      scope:      document.body  # working scope element
      timeout:    4000           # how long each piece should hang
      position:   'top'          # default message position
      loop:       true           # whether to loop or not through the helpers
      html:       ''             # default html content
      fxName:     'fade'         # name of the visual effect to use
      fxDuration: 'normal'       # visual effect duration

  #
  # Basic constructor
  #
  # @param {Object} options
  #
  constructor: (options)->
    @setOptions(options)

    super 'div', class: 'nanny'

    @append(
      @icon = new Element('div', class: 'nanny-icon'),
      @body = new Element('div', class: 'nanny-body'))

    @icon.on('click', => @_closed = true; @hide())

    return @

  #
  # Shows the nanny at the scope element
  #
  # NOTE: wont' do anything if the scope element is not set
  #
  # @return {Nanny} self
  #
  show: ->
    if block = @nextBlock()
      options = block.data('nanny') || {}

      options.html     or= @options.html
      options.position or= @options.position
      options.timeout  or= @options.timeout

      @removeClass('nanny-top').removeClass('nanny-left').removeClass('nanny-right').removeClass('nanny-bottom')
      @addClass("nanny-#{options.position}").body.html options.html
      @style(visibility: 'hidden').insertTo document.body

      @moveNextTo(block).style(display: 'none', visibility: 'visible')

      window.setTimeout =>
        @show() unless @_closed
      , options.timeout

      @$super(@options.fxName, duration: @options.fxDuration, finish: => @emit('show'))
      if @options.fxName then @ else @emit('show')

    else
      @hide()

  #
  # Hides an open nanny and removes it out of the dom's tree
  #
  # @return {Nanny} self
  #
  hide: ->
    @$super(@options.fxName, duration: @options.fxDuration, finish: => @emit('hide'))
    if @options.fxName then @ else @emit('hide')

  #
  # Moves the nanny next to the block
  #
  # @param {dom.Element} refereced block
  # @return {Nanny} self
  #
  moveNextTo: (block)->
    position = block.position(); size = block.size()
    box = @size(); win = $(window).size(); offset = 8

    position = switch (block.data('nanny') || {}).position || @options.position
      when 'top'
        x: position.x + (size.x - box.x)/2
        y: position.y - box.y   - offset
      when 'left'
        x: position.x - box.x   - offset
        y: position.y + (size.y - box.y)/2
      when 'right'
        x: position.x + size.x  + offset
        y: position.y + (size.y - box.y)/2
      else # bottom
        x: position.x + (size.x - box.x)/2
        y: position.y + size.y  + offset

    position.x = offset if position.x < offset
    position.y = offset if position.y < offset

    position.x = win.x - box.x - offset if win.x < (position.x + box.x + offset)
    position.y = win.y - box.y - offset if win.y < (position.y + box.y + offset)

    @position position

  #
  # Finds the list of blocks that should be nannyed
  #
  # @return {dom.NodeList} elements
  #
  nextBlock: ->
    blocks = $(@options.scope).find """
      *[data-nanny], *[data-nanny-html], *[data-nanny-position]
    """

    if @options.loop || !@_block || @_block isnt blocks[blocks.length - 1]
      return @_block = blocks[blocks.indexOf(@_block) + 1] || blocks[0]
