coffeecoverageify = require 'browserify-coffee-coverage'

class Config
  @basePath: './'
  @frameworks: [
    'jasmine'
    'browserify'
  ]
  @files: [
    'src/scripts/vendor.coffee'
    'node_modules/angular-mocks/angular-mocks.js'
    'src/scripts/main.coffee'
    'test/unit/**/*.coffee'
  ]
  @exclude: []
  @preprocessors:
    'src/scripts/vendor.coffee': ['browserify']
    'src/scripts/main.coffee': ['browserify']
    'test/unit/**/*.coffee': ['coffee-coverage']
  @browserify:
    debug: true
    transform: [coffeecoverageify]
    extensions: ['.coffee']
  @coffeeCoverage:
    preprocessor:
      instrumentor: 'istanbul'
  @reporters: [
    'mocha'
    'coverage'
  ]
  @coverageReporter:
    dir: 'coverage'
    reporters: [
      type: 'text-summary'
    ,
      type: 'json'
      subdir: '.'
      file: 'coverage-final.json'
    ,
      type: 'html'
    ,
      type: 'lcov'
    ]
  @port: 9876
  @colors: true
  @autoWatch: true
  @browsers: ['Chrome']
  @singleRun: false
  @concurrency: Infinity

module.exports = (config) -> config.set Config
