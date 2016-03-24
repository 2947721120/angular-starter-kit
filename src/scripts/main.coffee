require './modules'
# require './templates.js'

angular
  .module 'app', [
    'ngComponentRouter'
    'ngMaterial', 'firebase'
    'app.core'
    'app.simple'
    # 'app.template'
  ]
