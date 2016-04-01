SpecReporter = require 'jasmine-spec-reporter'

class Config
  @seleniumAddress: 'http://localhost:4444/wd/hub'
  @directConnect: true
  @specs: ['./test/e2e/**/*.coffee']
  @exclude: []
  @capabilities:
    browserName: 'chrome'
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
