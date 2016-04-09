SpecReporter = require 'jasmine-spec-reporter'
phantomjs = require 'phantomjs'

class Config
  @directConnect: true
  @specs: ['./test/e2e/**/*.coffee']
  @exclude: []
  @capabilities: browserName: 'chrome'
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
  Config.capabilities =
    browserName: 'phantomjs'
    'phantomjs.binary.path': phantomjs.path
  Config.directConnect = false

exports.config = Config
