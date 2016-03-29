class Config
  @directConnect: true
  @specs: ['./test/e2e/**/*.coffee']
  @capabilities:
    browserName: 'chrome'
  @baseUrl: 'http://localhost:9876/'
  @framework: 'jasmine'
  @jasmineNodeOpts:
    showColors: true
    defaultTimeoutInterval: 30000
    print: ->
    grep: 'pattern'
    invertGrep: false

exports.config = Config
