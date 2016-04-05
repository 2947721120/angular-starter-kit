SpecReporter = require 'jasmine-spec-reporter'

class Config
  @sauceUser: process.env.SAUCE_USERNAME
  @sauceKey: process.env.SAUCE_ACCESS_KEY
  @directConnect: true
  @specs: ['./test/e2e/**/*.coffee']
  @exclude: []
  @capabilities:
    browserName: 'chrome'
    'tunnel-identifier': process.env.TRAVIS_JOB_NUMBER
    build: process.env.TRAVIS_BUILD_NUMBER
    name: 'Scenario Testing'
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
