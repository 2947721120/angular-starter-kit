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

gulp.task 'compile-all-jade', ->
  shared = ->
    combined =
      combiner(
        gulpif IN_DEV, changed APP_DEST
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

gulp.task 'jade-lint', ->
  index =
    gulp
      .src INDEX_SRC

  views =
    gulp
      .src VIEWS_ALL_SRC

  merge index, views
    .pipe jadelint()

gulp.task 'compile-stylus-vendor', ->
  copy =
    gulp
      .src cssVendorsSrc

  load =
    gulp
      .src STYLES_VENDOR_SRC
      .pipe stylus()

  merge copy, load
    .pipe uglifycss()
    .pipe gulp.dest STYLES_DEST

gulp.task 'compile-stylus-main', ->
  gulp
    .src STYLES_MAIN_SRC
    .pipe gulpif IN_DEV, changed STYLES_DEST
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
    .pipe gulp.dest STYLES_DEST

gulp.task 'stylus-lint', ->
  gulp
    .src STYLES_ALL_SRC
    .pipe stylint config: '.stylintrc'
    .pipe stylint.reporter()

compileCoffeescript = (file, watch) ->
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
      .pipe gulp.dest SCRIPTS_DEST

  bundler.on 'update', ->
    start = process.hrtime()
    gutil.log 'Starting', "
      '#{gutil.colors.cyan 'compile-coffeescript-main'}'...
    "

    bundle()

    end = process.hrtime start
    words = prettyHrtime end
    gutil.log 'Finished', "
      '#{gutil.colors.cyan 'compile-coffeescript-main'}' after
      #{gutil.colors.magenta words}
    "

  bundle()

gulp.task 'compile-coffeescript-vendor', ->
  compileCoffeescript SCRIPTS_VENDOR_SRC, false

gulp.task 'compile-coffeescript-main', ->
  compileCoffeescript SCRIPTS_MAIN_SRC, IN_DEV

gulp.task 'coffeescript-lint', ->
  gulp
    .src SCRIPTS_ALL_SRC
    .pipe coffeelint 'coffeelint.json'
    .pipe coffeelint.reporter()

gulp.task 'optimize-images', ->
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
    'copy-files'
    'compile-all-jade'
    'compile-stylus-vendor'
    'compile-stylus-main'
    'compile-coffeescript-vendor'
    'compile-coffeescript-main'
    'optimize-images'
    callback
  )

gulp.task 'serve', ->
  browserSync
    server:
      baseDir: APP_DEST

gulp.task 'watch', ->
  gulp.watch WATCH_SRC, [
    'compile-all-jade'
    'compile-stylus-main'
    'optimize-images'
    browserSync.reload
  ]

gulp.task 'default', (callback) ->
  runSequence(
    'copy-files'
    ['compile-all-jade', 'jade-lint']
    'compile-stylus-vendor'
    ['compile-stylus-main', 'stylus-lint']
    'compile-coffeescript-vendor'
    ['compile-coffeescript-main', 'coffeescript-lint']
    'optimize-images'
    'serve'
    'watch'
    callback
  )
