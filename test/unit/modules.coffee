describe 'Modules', ->
  core = null
  simple = null

  beforeEach ->
    core = angular.module 'app.core'
    simple = angular.module 'app.simple'

  it 'should be registered', ->
    expect(core).toBeDefined()
    expect(simple).toBeDefined()
