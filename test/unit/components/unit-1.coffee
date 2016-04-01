describe 'Component: example', ->
  beforeEach module 'app.example'

  scope = null
  $componentController = null
  component = null

  beforeEach inject ($rootScope, _$componentController_) ->
    scope = $rootScope.$new()
    $componentController = _$componentController_

    component =
      $componentController 'starterKit',
        $scope: scope
      ,
        version: 'v1.0.0'

  it 'should have a component', ->
    expect(component).toBeDefined()

  it 'should be attached to the scope', ->
    expect(scope.$ctrl).toBe component

  it 'should have a title', ->
    expect(component.title).toBeDefined()
    expect(component.title).toBe 'ngular Starter Kit'

  it 'should have a version', ->
    expect(component.version).toBeDefined()
    expect(component.version).toBe 'v1.0.0'
