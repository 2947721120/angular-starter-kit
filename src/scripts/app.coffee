class Config
  @$inject: ['$locationProvider']

  constructor: ($locationProvider) ->
    $locationProvider.html5Mode true

class Value
  @service: '$routerRootComponent'
  @directive: 'app'

class Component
  @templateUrl: '../views/main.html'
###
  @$routeConfig: [
    path: ''
    name: ''
    component: ''
    useAsDefault: true
  ,
    path: ''
    name: ''
    component: ''
  ]
###

exports.config = Config
exports.service = Value.service
exports.directive = Value.directive
exports.component = Component
