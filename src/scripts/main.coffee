require './modules'
# require './templates'

angular
  .module 'app', [
    'ngComponentRouter'
    'ngMaterial', 'firebase'
    'app.core'
    'app.simple'
    'app.simple2'
    # 'app.template'
  ]
