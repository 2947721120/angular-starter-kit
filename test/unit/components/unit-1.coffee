describe 'Component: simpleCpn', ->
  beforeEach module 'app.simple'

  controller = null
  scope = null
  beforeEach inject ($rootScope, $componentController) ->
    scope = $rootScope.$new()
    controller =
      $componentController 'simpleCpn',
        $scope: scope
      ,
        version: '1.0.0'

  it 'should have a title', ->
    expect(controller.title).toBeDefined()
    expect(controller.title).toBe 'Angular Starter Kit'

  it 'should have a version', ->
    expect(controller.version).toBeDefined()
    expect(controller.version).toBe '1.0.0'
