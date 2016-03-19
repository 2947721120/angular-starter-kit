require './modules.coffee'
require './templates.js'

angular
  .module 'app', [
    'ngMaterial', 'firebase'
    'app.core'
    'app.template'
  ]
