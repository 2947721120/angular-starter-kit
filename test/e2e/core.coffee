describe 'Core', ->
  beforeEach ->
    browser.get '/'

  it 'should have a router', ->
    expect(browser.getLocationAbsUrl()).toMatch '/'
