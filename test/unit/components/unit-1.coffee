describe 'Component: simple', ->
  beforeEach module 'app.simple'

  scope = null
  $componentController = null
  component = null

  beforeEach inject ($rootScope, _$componentController_) ->
    scope = $rootScope.$new()
    $componentController = _$componentController_

    component =
      $componentController 'simple',
        $scope: scope
      ,
        version: '1.0.0'

  it 'should have a title', ->
    expect(component.title).toBeDefined()
    expect(component.title).toBe 'Angular Starter Kit'

  it 'should have a version', ->
    expect(component.version).toBeDefined()
    expect(component.version).toBe '1.0.0'
