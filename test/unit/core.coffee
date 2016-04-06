describe 'Core', ->
  beforeEach module 'app.core'

  scope = null
  $componentController = null
  component = null

  beforeEach inject ($rootScope, _$componentController_) ->
    scope = $rootScope.$new()
    $componentController = _$componentController_

    component =
      $componentController 'app',
        $scope: scope

  it 'should have a component', ->
    expect(component).toBeDefined()
