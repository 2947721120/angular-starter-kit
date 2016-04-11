class Config
  @directConnect: true
  @specs: ['./test/e2e/**/*.coffee']
  @exclude: []
  @capabilities: browserName: 'chrome'
  @baseUrl: 'http://localhost:3000/'
  @onPrepare: ->
    SpecReporter = require 'jasmine-spec-reporter'
    jasmine.getEnv().addReporter new SpecReporter displayStacktrace: true
    browser.ignoreSynchronization = false
  @framework: 'jasmine'
  @jasmineNodeOpts:
    isVerbose: false
    showColors: true
    includeStackTrace: false

if process.env.TRAVIS
  Config.capabilities = browserName: 'firefox'

exports.config = Config
