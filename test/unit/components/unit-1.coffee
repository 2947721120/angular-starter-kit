describe 'Component: simple', ->
  beforeEach module 'app.simple'

  scope = null
  ctrl = null

  beforeEach inject ($rootScope, $componentController) ->
    scope = $rootScope.$new()
    ctrl =
      $componentController 'simple',
        $scope: scope
      ,
        version: '1.0.0'

  it 'should have a title', ->
    expect(ctrl.title).toBeDefined()
    expect(ctrl.title).toBe 'Angular Starter Kit'

  it 'should have a version', ->
    expect(ctrl.version).toBeDefined()
    expect(ctrl.version).toBe '1.0.0'
