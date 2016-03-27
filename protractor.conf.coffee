class Config
  @directConnect: true
  @specs: ['./test/e2e/**/*.coffee']
  @capabilities:
    browserName: 'chrome'
  @baseUrl: 'http://localhost:9876/'
  @framework: 'jasmine'
  @jasmineNodeOpts:
    isVerbose: true
    showColors: true
    includeStackTrace: true

exports.config = Config
