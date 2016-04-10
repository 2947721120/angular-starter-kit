describe 'Component: about', ->
  beforeEach module 'core.about'

  scope = null
  $componentController = null
  component = null

  beforeEach inject ($rootScope, _$componentController_) ->
    scope = $rootScope.$new()
    $componentController = _$componentController_

    component =
      $componentController 'about',
        $scope: scope

  it 'should have a component', ->
    expect(component).toBeDefined()
