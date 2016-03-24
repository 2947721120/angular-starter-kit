gulp = require 'gulp'
gutil = require 'gulp-util'
notify = require 'gulp-notify'
prettyHrtime = require 'pretty-hrtime'
changed = require 'gulp-changed'
gulpif = require 'gulp-if'
combiner = require 'stream-combiner'
merge = require 'merge-stream'
jade = require 'gulp-jade'
minifyHtml = require 'gulp-minify-html'
templateCache = require 'gulp-angular-templatecache'
jadelint = require 'gulp-jadelint'
sourcemaps = require 'gulp-sourcemaps'
stylus = require 'gulp-stylus'
nib = require 'nib'
poststylus = require 'poststylus'
uglifycss = require 'gulp-uglifycss'
stylint = require 'gulp-stylint'
coffeeify = require 'coffeeify'
watchify = require 'watchify'
browserify = require 'browserify'
source = require 'vinyl-source-stream'
buffer = require 'vinyl-buffer'
streamify = require 'gulp-streamify'
uglify = require 'gulp-uglify'
coffeelint = require 'gulp-coffeelint'
imagemin = require 'gulp-imagemin'
pngquant = require 'imagemin-pngquant'
browserSync = require 'browser-sync'
rimraf = require 'gulp-rimraf'
runSequence = require 'run-sequence'

# ----------
# config
[DEV, WATCH] = [true, true]

APP_SRC = './src'
INDEX_SRC = "#{APP_SRC}/index.jade"
VIEWS_SRC = "#{APP_SRC}/views/**/*.jade"
STYLES_SRC = "#{APP_SRC}/styles"
CSS_VENDOR_SRC = ['./node_modules/angular-material/angular-material.css']
STYLES_VENDOR_SRC = "#{STYLES_SRC}/vendor.styl"
STYLES_MAIN_SRC = "#{STYLES_SRC}/main.styl"
STYLES_FILTER_SRC = "#{STYLES_SRC}/**/*.styl"
SCRIPTS_SRC = "#{APP_SRC}/scripts"
SCRIPTS_VENDOR_SRC = 'vendor'
SCRIPTS_MAIN_SRC = 'main'
SCRIPTS_FILTER_SRC = "#{SCRIPTS_SRC}/**/*.coffee"
IMAGES_SRC = "#{APP_SRC}/images/**/*"
FONTS_SRC = "#{APP_SRC}/fonts/**/*"
SURPLUS_SRC = ["#{APP_SRC}/favicon.ico", "#{APP_SRC}/robots.txt"]

APP_DEST = './public'
VIEWS_DEST = "#{APP_DEST}/views"
TEMPLATES_DEST = "#{SCRIPTS_SRC}/templates.js"
STYLES_DEST = "#{APP_DEST}/styles"
SCRIPTS_DEST = "#{APP_DEST}/scripts"
IMAGES_DEST = "#{APP_DEST}/images"
FONTS_DEST = "#{APP_DEST}/fonts"

# ----------
# utils
handleErrors = (error) ->
  if DEV is true
    arr = Array::slice.call arguments

    notify
      .onError
        title: 'Compile Error'
        message: "\r\n#{error}"
      .apply this, arr

    @emit 'end'

  else
    console.log "#{gutil.colors.red error}"
    process.exit 1

class TimeLogger
  start = null

  constructor: (@task) ->

  startTime: ->
    start = process.hrtime()
    gutil.log 'Starting', "'#{gutil.colors.cyan @task}'..."

  endTime: ->
    end = process.hrtime start
    words = prettyHrtime end
    gutil.log 'Finished', "
      '#{gutil.colors.cyan @task}' after #{gutil.colors.magenta words}
    "

# ----------
# tasks
gulp.task 'compile-jade', ->
  shared = ->
    combined =
      combiner(
        jade()
        minifyHtml()
      )

    combined.on 'error', handleErrors

  handleTemplates = ->
    combiner(
      templateCache
        module: 'app.template'
        standalone: true
        root: '../views'
      uglify()
    )

  index =
    gulp
      .src INDEX_SRC
      .pipe shared()
      .pipe gulp.dest APP_DEST

  views =
    gulp
      .src VIEWS_SRC
      .pipe changed VIEWS_DEST
      .pipe shared()
      .pipe gulpif not DEV, handleTemplates()
      .pipe gulpif DEV, (gulp.dest VIEWS_DEST), gulp.dest SCRIPTS_SRC

  merge index, views
    .pipe browserSync.stream()

gulp.task 'lint-jade', ->
  index = gulp.src INDEX_SRC

  views = gulp.src VIEWS_SRC

  merge index, views
    .pipe jadelint()

gulp.task 'compile-stylus', ->
  shared = (vendor, map) ->
    opts =
      use: [
        nib()
        poststylus [
          'autoprefixer'
          'rucksack-css'
        ]
      ]
      import: ['nib']

    combined =
      combiner(
        changed STYLES_DEST
        gulpif map, sourcemaps.init loadMaps: true
        gulpif vendor, stylus(), stylus opts
        uglifycss()
        gulpif map, sourcemaps.write './'
      )

    combined.on 'error', handleErrors

  copy = gulp.src CSS_VENDOR_SRC
  load = gulp.src STYLES_VENDOR_SRC
  vendor =
    merge copy, load
      .pipe shared true, false

  main =
    gulp
      .src STYLES_MAIN_SRC
      .pipe shared false, DEV

  merge vendor, main
    .pipe gulp.dest STYLES_DEST
    .pipe browserSync.stream()

gulp.task 'lint-stylus', ->
  gulp
    .src STYLES_FILTER_SRC
    .pipe stylint config: '.stylintrc'
    .pipe stylint.reporter()

gulp.task 'compile-coffeescript', ->
  shared = (file, watch, map) ->
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
        .pipe gulpif map, sourcemaps.init loadMaps: true
        .pipe streamify uglify()
        .pipe gulpif map, sourcemaps.write './'
        .pipe gulp.dest SCRIPTS_DEST
        .pipe browserSync.stream()

    bundler.on 'update', ->
      bundleLogger = new TimeLogger 'compile-coffeescript'

      bundleLogger.startTime()

      bundle()

      bundleLogger.endTime()

    bundle()

  vendor = shared SCRIPTS_VENDOR_SRC, DEV and WATCH, false

  main = shared SCRIPTS_MAIN_SRC, DEV and WATCH, DEV

  merge vendor, main

gulp.task 'lint-coffeescript', ->
  gulp
    .src SCRIPTS_FILTER_SRC
    .pipe coffeelint 'coffeelint.json'
    .pipe coffeelint.reporter()

gulp.task 'optimize-images', ->
  gulp
    .src IMAGES_SRC
    .pipe changed IMAGES_DEST
    .pipe imagemin
      progressive: true
      svgoPlugins: [removeViewBox: false]
      use: [pngquant()]
    .pipe gulp.dest IMAGES_DEST
    .pipe browserSync.stream()

gulp.task 'copy-files', ->
  fonts =
    gulp
      .src FONTS_SRC
      .pipe changed FONTS_DEST
      .pipe gulp.dest FONTS_DEST

  surplus =
    gulp
      .src SURPLUS_SRC
      .pipe changed APP_DEST
      .pipe gulp.dest APP_DEST

  merge fonts, surplus
    .pipe browserSync.stream()

gulp.task 'build', (callback) ->
  runSequence(
    ['compile-jade', 'lint-jade']
    ['compile-stylus', 'lint-stylus']
    ['compile-coffeescript', 'lint-coffeescript']
    'optimize-images'
    'copy-files'
    callback
  )

gulp.task 'serve', ->
  browserSync
    server:
      baseDir: APP_DEST

gulp.task 'watch', ->
  gulp.watch [INDEX_SRC, VIEWS_SRC], ['compile-jade', 'lint-jade']
  gulp.watch STYLES_FILTER_SRC, ['compile-stylus', 'lint-stylus']
  gulp.watch SCRIPTS_FILTER_SRC, ['lint-coffeescript']
  gulp.watch IMAGES_SRC, ['optimize-images']
  gulp.watch [FONTS_SRC, SURPLUS_SRC], ['copy-files']

gulp.task 'clean', ->
  gulp
    .src [APP_DEST, TEMPLATES_DEST], read: false
    .pipe rimraf force: true

# ----------
# main
gulp.task 'build-dev', (callback) ->
  WATCH = false
  runSequence 'clean', 'build', callback

gulp.task 'build-dev-watch', (callback) ->
  runSequence 'clean', 'build', 'watch', callback

gulp.task 'build-prod', (callback) ->
  DEV = false
  runSequence 'clean', 'build', callback

gulp.task 'build-prod-serve', (callback) ->
  DEV = false
  runSequence 'clean', 'build', 'serve', callback

gulp.task 'default', (callback) ->
  runSequence 'clean', 'build', 'serve', 'watch', callback
