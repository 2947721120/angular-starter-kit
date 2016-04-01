describe 'Core', ->
  beforeEach ->
    browser.get 'index.html'

  it 'should have a router', ->
    expect(browser.getLocationAbsUrl()).toMatch('/')
