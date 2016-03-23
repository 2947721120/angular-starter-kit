browserifyCoffeeCoverage = require 'browserify-coffee-coverage'

module.exports = (config) ->
  config.set
    basePath: ''
    frameworks: [
      'jasmine'
      'browserify'
    ]
    files: [
      './node_modules/angular-mocks/angular-mocks.js'
      './src/scripts/**/*.coffee'
      './test/unit/**/*.coffee'
    ]
    exclude: []
    preprocessors:
      '**/*.coffee': [
        'browserify'
        'coffee-coverage'
      ]
    browserify:
      debug: true
      transform: [
        browserifyCoffeeCoverage
          noInit: false
      ]
    coffeeCoverage:
      preprocessor:
        instrumentor: 'istanbul'
    reporters: [
      'progress'
      'coverage'
    ]
    coverageReporter:
      dir: 'coverage'
      reporters: [
        { type: 'text-summary' }
        { type: 'json', subdir: '.', file: 'coverage-final.json' }
        { type: 'html' }
      ]
    port: 9876
    colors: true
    logLevel: config.LOG_INFO
    autoWatch: true
    browsers: ['Chrome']
    singleRun: false
    concurrency: Infinity
