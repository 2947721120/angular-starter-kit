describe 'Component: home', ->
  beforeEach module 'core.home'

  scope = null
  $componentController = null
  component = null

  beforeEach inject ($rootScope, _$componentController_) ->
    scope = $rootScope.$new()
    $componentController = _$componentController_

    component =
      $componentController 'home',
        $scope: scope

  it 'should have a component', ->
    expect(component).toBeDefined()
