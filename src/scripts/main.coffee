require './modules.coffee'
# require './templates.js'

angular
  .module 'app', [
    'ngComponentRouter'
    'ngMaterial', 'firebase'
    'app.core'
    # 'app.template'
  ]
