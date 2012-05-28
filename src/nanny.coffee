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
    blocks  = @blocks()

    console.log('showing');

    if @_block = blocks[blocks.indexOf(@_block) + 1] || blocks[0]
      options = @_block.data('nanny') || {}
      options.html or= @_block.attr('title') || ''
      options.position or= @options.position

      @removeClass('nanny-top').removeClass('nanny-left').removeClass('nanny-right').removeClass('nanny-bottom')
      @addClass("nanny-#{options.position}").body.html options.html
      @insertTo document.body

      window.setTimeout =>
        @show()
      , @options.timeout

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
  # Finds the list of blocks that should be nannyed
  #
  # @return {dom.NodeList} elements
  #
  blocks: ->
    $(@options.scope).find """
      *[data-nanny], *[data-nanny-html], *[data-nanny-position]
    """