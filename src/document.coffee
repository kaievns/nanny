#
# Document level hooks for nanny
#
# Copyright (C) 2012 Nikolay Nemshilov
#
$(document).delegate '*[data-nanny],*[data-nanny-location],*[data-nanny-html]', 'mouseenter', ->
  @nanny || new Nanny(@).show()
