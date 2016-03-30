describe 'App Core', ->
  core = null

  beforeEach ->
    core = angular.module 'app.core'

  it 'should be registered', ->
    expect(core).toBeDefined()
