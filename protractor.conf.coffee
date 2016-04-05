SpecReporter = require 'jasmine-spec-reporter'

class Config
  @sauceUser: 'Shyam-Chen'
  @sauceKey: 'c3608032-6eff-452e-9027-602ca80a8778'
  @sauceSeleniumAddress: 'http://ondemand.saucelabs.com:80/wd/hub'
  @directConnect: true
  @specs: ['./test/e2e/**/*.coffee']
  @exclude: []
  @capabilities:
    browserName: 'chrome'
    'tunnel-identifier': process.env.TRAVIS_JOB_NUMBER
    build: process.env.TRAVIS_BUILD_NUMBER
  @baseUrl: 'http://localhost:3000/'
  @allScriptsTimeout: 110000
  @onPrepare: ->
    jasmine.getEnv().addReporter new SpecReporter displayStacktrace: true
    browser.ignoreSynchronization = false
  @framework: 'jasmine'
  @jasmineNodeOpts:
    showTiming: true
    showColors: true
    isVerbose: false
    includeStackTrace: false
    defaultTimeoutInterval: 400000

exports.config = Config
