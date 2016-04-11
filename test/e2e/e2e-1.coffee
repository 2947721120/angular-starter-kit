describe 'Home', ->
  beforeEach ->
    browser.get '/'
    browser.waitForAngular()

  it 'should route correctly', ->
    expect(browser.getLocationAbsUrl()).toMatch '/'

  it 'should have a content', ->
    el = element By.css 'md-content span'
    expect(el.getText()).toEqual 'Home Page'
