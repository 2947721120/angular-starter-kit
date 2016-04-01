describe 'Core', ->
  beforeEach ->
    browser.get 'http://localhost:3000/'

  it 'should have a router', ->
    expect(browser.getLocationAbsUrl()).toMatch('/')
