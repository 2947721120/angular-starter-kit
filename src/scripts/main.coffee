require './modules'
# require './templates'

angular
  .module 'app', [
    'ngComponentRouter'
    'ngMaterial', 'firebase'
    'app.core'
    # 'app.template'
    'app.simple'
  ]
a = 1
