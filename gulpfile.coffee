gulp = require 'gulp'
gulpif = require 'gulp-if'
changed = require 'gulp-changed'
notify = require 'gulp-notify'
jade = require 'gulp-jade'
minifyHtml = require 'gulp-minify-html'
jadelint = require 'gulp-jadelint'
stylus = require 'gulp-stylus'
nib = require 'nib'
poststylus = require 'poststylus'
uglifycss = require 'gulp-uglifycss'
stylint = require 'gulp-stylint'
browserify = require 'browserify'
watchify = require 'watchify'
coffeeify = require 'coffeeify'
source = require 'vinyl-source-stream'
buffer = require 'vinyl-buffer'
streamify = require 'gulp-streamify'
uglify = require 'gulp-uglify'
gutil = require 'gulp-util'
prettyHrtime = require 'pretty-hrtime'
coffeelint = require 'gulp-coffeelint'
sourcemaps = require 'gulp-sourcemaps'
imagemin = require 'gulp-imagemin'
pngquant = require 'imagemin-pngquant'
browserSync = require 'browser-sync'
runSequence = require 'run-sequence'

vendorsCssSrc = ['./node_modules/angular-material/angular-material.css']

IN_DEV = true

APP_SRC = './src'
ICO_TXT_SRC = ["#{APP_SRC}/favicon.ico", "#{APP_SRC}/robots.txt"]
TEMPLATES_SRC = "#{APP_SRC}/**/*.jade"
STYLES_SRC = "#{APP_SRC}/styles"
STYLES_VENDOR_SRC = "#{STYLES_SRC}/vendor.styl"
STYLES_MAIN_SRC = "#{STYLES_SRC}/main.styl"
STYLES_ALL_SRC = "#{STYLES_SRC}/**/*.styl"
SCRIPTS_SRC = "#{APP_SRC}/scripts"
SCRIPTS_VENDOR_SRC = 'vendor'
SCRIPTS_MAIN_SRC = 'main'
SCRIPTS_ALL_SRC = "#{SCRIPTS_SRC}/**/*.coffee"
IMAGES_SRC = "#{APP_SRC}/images/**/*"
WATCH_SRC = "#{APP_SRC}/**/*"

APP_DEST = './public'
CSS_DEST = "#{APP_DEST}/css"
JAVASCRIPT_DEST = "#{APP_DEST}/javascript"
IMAGES_DEST = "#{APP_DEST}/images"

handleErrors = (error) ->
  if IN_DEV is true
    args = Array::slice.call arguments

    notify
      .onError
        title: 'Compile Error'
        message: '<%= error %>'
      .apply this, args

    @emit 'end'

  else
    console.log error
    process.exit 1

gulp.task 'ico-txt-copy', ->
  gulp
    .src ICO_TXT_SRC
    .pipe gulp.dest APP_DEST

gulp.task 'templates', ->
  gulp
    .src TEMPLATES_SRC
    .pipe gulpif IN_DEV, changed APP_DEST
    .pipe jade()
    .on 'error', handleErrors
    .pipe minifyHtml()
    .pipe gulp.dest APP_DEST

gulp.task 'templates-lint', ->
  gulp
    .src TEMPLATES_SRC
    .pipe jadelint()

gulp.task 'vendors-css-copy', ->
  gulp
    .src vendorsCssSrc
    .pipe uglifycss()
    .pipe gulp.dest CSS_DEST

gulp.task 'vendors-css-load', ->
  gulp
    .src STYLES_VENDOR_SRC
    .pipe stylus()
    .pipe uglifycss()
    .pipe gulp.dest CSS_DEST

gulp.task 'vendors-css', [
  'vendors-css-copy'
  'vendors-css-load'
]

gulp.task 'styles', ->
  gulp
    .src STYLES_MAIN_SRC
    .pipe gulpif IN_DEV, changed CSS_DEST
    .pipe gulpif IN_DEV, sourcemaps.init loadMaps: true
    .pipe stylus
      use: [
        nib()
        poststylus [
          'autoprefixer'
          'rucksack-css'
        ]
      ]
      import: ['nib']
    .on 'error', handleErrors
    .pipe uglifycss()
    .pipe gulpif IN_DEV, sourcemaps.write './'
    .pipe gulp.dest CSS_DEST

gulp.task 'styles-lint', ->
  gulp
    .src STYLES_ALL_SRC
    .pipe stylint config: '.stylintrc'
    .pipe stylint.reporter()

scripts = (file, watch) ->
  opts =
    entries: "#{SCRIPTS_SRC}/#{file}.coffee"
    transform: [coffeeify]

  if watch is true
    opts.debug = true
    opts.cache = {}
    opts.packageCache = {}
    opts.fullPaths = true

  bundler = if watch then watchify browserify opts else browserify opts

  bundle = ->
    bundler
      .bundle()
      .on 'error', handleErrors
      .pipe source "#{file}.js"
      .pipe buffer()
      .pipe gulpif watch, sourcemaps.init loadMaps: true
      .pipe streamify uglify()
      .pipe gulpif watch, sourcemaps.write './'
      .pipe gulp.dest JAVASCRIPT_DEST

  bundler.on 'update', ->
    start = process.hrtime()
    gutil.log 'Starting', "'#{gutil.colors.cyan 'scripts'}'..."

    bundle()

    end = process.hrtime start
    words = prettyHrtime end
    gutil.log 'Finished',
      "'#{gutil.colors.cyan 'scripts'}' after #{gutil.colors.magenta words}"

  bundle()

gulp.task 'vendors-javascript', ->
  scripts SCRIPTS_VENDOR_SRC, false

gulp.task 'scripts', ->
  scripts SCRIPTS_MAIN_SRC, IN_DEV

gulp.task 'scripts-lint', ->
  gulp
    .src SCRIPTS_ALL_SRC
    .pipe coffeelint 'coffeelint.json'
    .pipe coffeelint.reporter()

gulp.task 'images', ->
  gulp
    .src IMAGES_SRC
    .pipe gulpif IN_DEV, changed IMAGES_DEST
    .pipe imagemin
      progressive: true
      svgoPlugins: [removeViewBox: false]
      use: [pngquant()]
    .pipe gulp.dest IMAGES_DEST

gulp.task 'build', (callback) ->
  IN_DEV = false
  runSequence(
    'ico-txt-copy'
    'templates'
    ['vendors-css', 'styles']
    ['vendors-javascript', 'scripts']
    'images'
    callback
  )

gulp.task 'serve', ->
  browserSync
    server:
      baseDir: APP_DEST

gulp.task 'watch', ->
  gulp.watch WATCH_SRC, [
    'templates'
    'styles'
    'images'
    browserSync.reload
  ]

gulp.task 'default', (callback) ->
  runSequence(
    'ico-txt-copy'
    ['templates', 'templates-lint']
    ['vendors-css', 'styles', 'styles-lint']
    ['vendors-javascript', 'scripts', 'scripts-lint']
    'images'
    'serve'
    'watch'
    callback
  )
