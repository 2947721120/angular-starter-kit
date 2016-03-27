class Config
  constructor: (config) ->
    config.set
      basePath: './'
      frameworks: [
        'jasmine'
        'browserify'
      ]
      files: [
        'src/scripts/vendor.coffee'
        'node_modules/angular-mocks/angular-mocks.js'
        'src/scripts/main.coffee'
        'test/unit/**/*.coffee'
      ]
      exclude: []
      preprocessors:
        'src/scripts/vendor.coffee': ['browserify']
        'src/scripts/main.coffee': ['browserify']
        'test/unit/**/*.coffee': ['coffee']
      browserify:
        debug: true
        transform: ['coffeeify']
        extensions: ['.coffee']
      reporters: ['mocha']
      port: 9876
      colors: true
      logLevel: config.LOG_INFO
      autoWatch: true
      browsers: ['Chrome']
      singleRun: false
      concurrency: Infinity

module.exports = Config
