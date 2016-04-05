SpecReporter = require 'jasmine-spec-reporter'

class Config
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

if process.env.TRAVIS
  Config.sauceUser = 'Shyam-Chen'
  Config.sauceKey = 'c3608032-6eff-452e-9027-602ca80a8778'
  Config.capabilities =
    'tunnel-identifier': process.env.TRAVIS_JOB_NUMBER
    build: process.env.TRAVIS_BUILD_NUMBER

exports.config = Config
