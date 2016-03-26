class SimpleCpn
  @bindings:
    myBinding: '@'
  @controller: ->
    @myTitle = 'Unit Testing AngularCoffee'
  @template: "<h1>{{ $ctrl.myTitle }} {{ $ctrl.myBinding }}</h1>"

module.exports = SimpleCpn
