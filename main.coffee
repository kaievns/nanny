#
# Nanny main file
#
# Copyright (C) 2012 Nikolay Nemshilov
#

# hook up dependencies
core     = require('core')
$        = require('dom')
UI       = require('ui')

# local variables assignments
ext      = core.ext
Class    = core.Class
Element  = $.Element
NodeList = $.NodeList

# glue in your files
include 'src/nanny'

# export your objects in the module
return ext Nanny,
  version: '%{version}'