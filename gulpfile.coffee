gulp = require 'gulp'
notify = require 'gulp-notify'
gutil = require 'gulp-util'
gulpif = require 'gulp-if'
changed = require 'gulp-changed'
combiner = require 'stream-combiner'
merge = require 'merge-stream'
jade = require 'gulp-jade'
minifyHtml = require 'gulp-minify-html'
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
prettyHrtime = require 'pretty-hrtime'
coffeelint = require 'gulp-coffeelint'
imagemin = require 'gulp-imagemin'
pngquant = require 'imagemin-pngquant'
browserSync = require 'browser-sync'
runSequence = require 'run-sequence'

cssVendorsSrc = ['./node_modules/angular-material/angular-material.css']

IN_DEV = true
IS_WATCH = true

APP_SRC = './src'
FILES_COPY_SRC = ["#{APP_SRC}/favicon.ico", "#{APP_SRC}/robots.txt"]
INDEX_SRC = "#{APP_SRC}/index.jade"
VIEWS_SRC = "#{APP_SRC}/views"
VIEWS_ALL_SRC = "#{VIEWS_SRC}/**/*.jade"
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
VIEWS_DEST = "#{APP_DEST}/views"
STYLES_DEST = "#{APP_DEST}/styles"
SCRIPTS_DEST = "#{APP_DEST}/scripts"
IMAGES_DEST = "#{APP_DEST}/images"

handleErrors = (error) ->
  if IN_DEV is true
    args = Array::slice.call arguments

    notify
      .onError
        title: 'Compile Error'
        message: "\r\n#{error}"
      .apply this, args

    @emit 'end'

  else
    console.log "#{gutil.colors.red error}"
    process.exit 1

gulp.task 'copy-files', ->
  gulp
    .src FILES_COPY_SRC
    .pipe gulp.dest APP_DEST

gulp.task 'compile-jade', ->
  shared = ->
    combined =
      combiner(
        changed APP_DEST
        jade()
        minifyHtml()
      )

    combined.on 'error', handleErrors

  index =
    gulp
      .src INDEX_SRC
      .pipe shared()
      .pipe gulp.dest APP_DEST

  views =
    gulp
      .src VIEWS_ALL_SRC
      .pipe shared()
      .pipe gulp.dest VIEWS_DEST

  merge index, views

gulp.task 'lint-jade', ->
  index = gulp.src INDEX_SRC

  views = gulp.src VIEWS_ALL_SRC

  merge index, views
    .pipe jadelint()

gulp.task 'compile-stylus', ->
  opts =
    use: [
      nib()
      poststylus [
        'autoprefixer'
        'rucksack-css'
      ]
    ]
    import: ['nib']

  shared = (vendor, map) ->
    combined =
      combiner(
        changed STYLES_DEST
        gulpif map, sourcemaps.init loadMaps: true
        gulpif vendor, stylus(), stylus opts
        uglifycss()
        gulpif map, sourcemaps.write './'
      )

    combined.on 'error', handleErrors

  copy = gulp.src cssVendorsSrc
  load = gulp.src STYLES_VENDOR_SRC
  vendor =
    merge copy, load
      .pipe shared true, false

  main =
    gulp
      .src STYLES_MAIN_SRC
      .pipe shared false, IN_DEV

  merge vendor, main
    .pipe gulp.dest STYLES_DEST

gulp.task 'lint-stylus', ->
  gulp
    .src STYLES_ALL_SRC
    .pipe stylint config: '.stylintrc'
    .pipe stylint.reporter()

compileCoffeescript = (file, watch, map) ->
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

  bundler.on 'update', ->
    start = process.hrtime()
    gutil.log 'Starting', "
      '#{gutil.colors.cyan 'compile-coffeescript'}'...
    "

    bundle()

    end = process.hrtime start
    words = prettyHrtime end
    gutil.log 'Finished', "
      '#{gutil.colors.cyan 'compile-coffeescript'}' after
      #{gutil.colors.magenta words}
    "

  bundle()

gulp.task 'compile-coffeescript', ->
  vendor = compileCoffeescript SCRIPTS_VENDOR_SRC, IN_DEV and IS_WATCH, false

  main = compileCoffeescript SCRIPTS_MAIN_SRC, IN_DEV and IS_WATCH, IN_DEV

  merge vendor, main

gulp.task 'lint-coffeescript', ->
  gulp
    .src SCRIPTS_ALL_SRC
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

build = [
  'copy-files'
  'compile-jade', 'lint-jade'
  'compile-stylus', 'lint-stylus'
  'compile-coffeescript', 'lint-coffeescript'
  'optimize-images'
]

gulp.task 'serve', ->
  browserSync
    server:
      baseDir: APP_DEST

gulp.task 'watch', ->
  gulp.watch WATCH_SRC, [
    'compile-jade'
    'compile-stylus'
    'optimize-images'
    browserSync.reload
  ]

gulp.task 'build-dev', (callback) ->
  IS_WATCH = false
  runSequence build, callback

gulp.task 'build-dev-watch', (callback) ->
  runSequence build, 'watch', callback

gulp.task 'build-prod', (callback) ->
  IN_DEV = false
  runSequence build, callback

gulp.task 'default', (callback) ->
  runSequence build, 'serve', 'watch', callback
