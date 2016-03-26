describe 'Component: myComponent', ->
  beforeEach module('app.simple2')
  element = undefined
  scope = undefined
  beforeEach inject(($rootScope, $compile) ->
    scope = $rootScope.$new()
    element = angular.element('
      <simple-cpn my-binding="{{outside}}"></simple-cpn>
    ')
    element = $compile(element)(scope)
    scope.outside = '1.5'
    scope.$apply()
    return
  )
  it 'should render the text', ->
    h1 = element.find('h1')
    expect(h1.text()).toBe 'Unit Testing AngularJS 1.5'
    return
  return
