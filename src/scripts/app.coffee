class Config
  @$inject: ['$locationProvider']

  constructor: ($locationProvider) ->
    $locationProvider.html5Mode true

class Value
  @inject: '$routerRootComponent'
  @tag: 'app'

class Component
  @templateUrl: '../views/main.html'

exports.config = Config
exports.inject = Value.inject
exports.tag = Value.tag
exports.component = Component
