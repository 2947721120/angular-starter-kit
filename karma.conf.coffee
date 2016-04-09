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
    'src/views/**/*.jade'
    'test/unit/**/*.coffee'
  ]
  @exclude: []
  @preprocessors:
    'src/scripts/vendor.coffee': ['browserify']
    'src/scripts/main.coffee': ['browserify']
    'src/views/**/*.jade': ['ng-jade2js']
    'test/unit/**/*.coffee': ['coffee']
  @browserify:
    debug: true
    transform: ['coffeeify']
    extensions: ['.coffee']
  @ngJade2JsPreprocessor:
    stripPrefix: 'src/views'
    moduleName: 'app.template'
  @reporters: ['mocha']
  @port: 9876
  @colors: true
  @autoWatch: true
  @browsers: ['Chrome']
  @singleRun: false
  @concurrency: Infinity

if process.env.TRAVIS
  Config.browsers = ['PhantomJS']
  Config.singleRun = true

module.exports = (config) -> config.set Config
