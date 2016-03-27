describe 'Protractor Demo App', ->
  firstNumber = element(By.model('first'))
  secondNumber = element(By.model('second'))
  goButton = element(By.id('gobutton'))
  latestResult = element(By.binding('latest'))
  history = element.all(By.repeater('result in memory'))

  add = (x, y) ->
    firstNumber.sendKeys x
    secondNumber.sendKeys y

    goButton.click()

  beforeEach ->
    browser.get 'http://juliemr.github.io/protractor-demo/'

  it 'should have a history', ->
    add 1, 2
    add 3, 4

    expect(history.count()).toEqual 2

    add 5, 6

    expect(history.count()).toEqual 3
