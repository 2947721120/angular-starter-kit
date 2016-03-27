describe 'Component: simple', ->
  beforeEach module 'app.simple'

  scope = null
  controller = null

  beforeEach inject ($rootScope, $componentController) ->
    scope = $rootScope.$new()
    controller =
      $componentController 'simple',
        $scope: scope
      ,
        version: '1.0.0'

  it 'should have a title', ->
    expect(controller.title).toBeDefined()
    expect(controller.title).toBe 'Angular Starter Kit'

  it 'should have a version', ->
    expect(controller.version).toBeDefined()
    expect(controller.version).toBe '1.0.0'
