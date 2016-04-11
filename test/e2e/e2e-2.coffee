describe 'About', ->
  beforeEach ->
    browser.get '/'
    browser.waitForAngular()
    element(By.id 'about').click()

  it 'should route correctly', ->
    expect(browser.getLocationAbsUrl()).toMatch '/about'

  it 'should have a content', ->
    el = element By.css 'md-content span'
    expect(el.getText()).toEqual 'About Page'
