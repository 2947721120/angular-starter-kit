describe 'Component: simpleCpn', ->
  beforeEach module 'app.simple2'

  controller = undefined
  scope = undefined
  beforeEach inject ($rootScope, $componentController) ->
    scope = $rootScope.$new()
    controller =
      $componentController 'simpleCpn',
        $scope: scope
      ,
        myBinding: '1.5'

  it 'should expose my title', ->
    expect(controller.myTitle).toBeDefined()
    expect(controller.myTitle).toBe 'Unit Testing AngularCoffee'

  it 'should have my binding bound', ->
    expect(controller.myBinding).toBeDefined()
    expect(controller.myBinding).toBe '1.5'
