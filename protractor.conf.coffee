exports.config =
  directConnect: true
  specs: ['./test/scenario/**/*.coffee']
  capabilities:
    browserName: 'chrome'
  baseUrl: 'http://localhost:9876/'
  framework: 'jasmine'
  jasmineNodeOpts:
    isVerbose: true
    showColors: true
    includeStackTrace: true
