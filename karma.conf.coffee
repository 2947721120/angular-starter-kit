module.exports = (config) ->
  config.set
    basePath: './'
    frameworks: [
      'jasmine'
      'browserify'
    ]
    files: [
      'node_modules/angular/angular.js'
      'node_modules/angular-mocks/angular-mocks.js'
      'src/scripts/main.coffee'
      'test/unit/**/*.coffee'
    ]
    exclude: []
    preprocessors:
      'src/scripts/main.coffee': ['browserify']
      'test/unit/**/*.coffee': ['coffee']
    browserify:
      debug: true
      transform: ['coffeeify']
      extensions: ['.coffee']
    reporters: ['dots']
    port: 9876
    colors: true
    logLevel: config.LOG_INFO
    autoWatch: true
    browsers: ['Chrome']
    singleRun: false
    concurrency: Infinity
