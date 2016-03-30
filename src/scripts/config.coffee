class Config
  @$inject: ['$locationProvider']

  constructor: (@$locationProvider) ->

class Core extends Config
  constructor: ->
    super
    $locationProvider.html5Mode(true)

exports.core = Core
