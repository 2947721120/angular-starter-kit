gulp = require 'gulp'
gulpif = require 'gulp-if'
changed = require 'gulp-changed'
jade = require 'gulp-jade'
minifyHtml = require 'gulp-minify-html'
jadelint = require 'gulp-jadelint'
stylus = require 'gulp-stylus'
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
coffeelint = require 'gulp-coffeelint'
sourcemaps = require 'gulp-sourcemaps'
imagemin = require 'gulp-imagemin'
pngquant = require 'imagemin-pngquant'
browserSync = require 'browser-sync'
runSequence = require 'run-sequence'

IN_DEV = true

APP_SRC = './src'
ICO_TXT_SRC = ["#{APP_SRC}/favicon.ico", "#{APP_SRC}/robots.txt"]
TEMPLATES_SRC = "#{APP_SRC}/**/*.jade"
VENDORS_CSS_SRC = ['./node_modules/angular-material/angular-material.css']
STYLES_SRC = "#{APP_SRC}/styles"
STYLES_VENDOR_SRC = "#{STYLES_SRC}/vendor.styl"
STYLES_MAIN_SRC = "#{STYLES_SRC}/main.styl"
STYLES_ALL_SRC = "#{STYLES_SRC}/**/*.styl"
SCRIPTS_SRC = "#{APP_SRC}/scripts"
SCRIPTS_VENDOR_SRC = "#{SCRIPTS_SRC}/vendor.coffee"
SCRIPTS_MAIN_SRC = "#{SCRIPTS_SRC}/main.coffee"
SCRIPTS_ALL_SRC = "#{SCRIPTS_SRC}/**/*.coffee"
IMAGES_SRC = "#{APP_SRC}/images/**/*"
WATCH_SRC = "#{APP_SRC}/**/*"

APP_DEST = './public'
CSS_DEST = "#{APP_DEST}/css"
JAVASCRIPT_DEST = "#{APP_DEST}/javascript"
IMAGES_DEST = "#{APP_DEST}/images"

gulp.task 'ico-txt-copy', ->
  gulp.src(ICO_TXT_SRC)
    .pipe gulp.dest(APP_DEST)

gulp.task 'templates', ->
  gulp.src(TEMPLATES_SRC)
    .pipe(gulpif(
      IN_DEV
      changed(APP_DEST)
    ))
    .pipe(jade())
    .pipe(minifyHtml())
    .pipe gulp.dest(APP_DEST)

gulp.task 'templates-lint', ->
  gulp.src(TEMPLATES_SRC)
    .pipe jadelint()

gulp.task 'vendors-css-copy', ->
  gulp.src(VENDORS_CSS_SRC)
    .pipe(uglifycss())
    .pipe gulp.dest(CSS_DEST)

gulp.task 'vendors-css-load', ->
  gulp.src(STYLES_VENDOR_SRC)
    .pipe(stylus())
    .pipe(uglifycss())
    .pipe gulp.dest(CSS_DEST)

gulp.task 'vendors-css', [
  'vendors-css-copy'
  'vendors-css-load'
]

gulp.task 'styles', ->
  gulp.src(STYLES_MAIN_SRC)
    .pipe(gulpif(
      IN_DEV
      changed(CSS_DEST)
    ))
    .pipe(gulpif(
      IN_DEV
      sourcemaps.init(loadMaps: true)
    ))
    .pipe(stylus(
      use: [
        poststylus([
          'autoprefixer'
          'rucksack-css'
        ])
      ]
    ))
    .pipe(uglifycss())
    .pipe(gulpif(
      IN_DEV
      sourcemaps.write('./')
    ))
    .pipe gulp.dest(CSS_DEST)

gulp.task 'styles-lint', ->
  gulp.src(STYLES_ALL_SRC)
    .pipe(stylint(config: '.stylintrc'))
    .pipe stylint.reporter()

gulp.task 'vendors-javascript', ->
  browserify(
    entries: SCRIPTS_VENDOR_SRC
    transform: [coffeeify]
  )
    .bundle()
    .pipe(source('vendor.js'))
    .pipe(buffer())
    .pipe(streamify(uglify()))
    .pipe gulp.dest(JAVASCRIPT_DEST)

gulp.task 'scripts-prod', ->
  browserify(
    entries: SCRIPTS_MAIN_SRC
    transform: [coffeeify]
  )
    .bundle()
    .pipe(source('main.js'))
    .pipe(buffer())
    .pipe(streamify(uglify()))
    .pipe gulp.dest(JAVASCRIPT_DEST)

gulp.task 'scripts-dev', ->
  bundler =
    browserify
      entries: SCRIPTS_MAIN_SRC
      transform: [coffeeify]
      debug: true
      cache: {}
      packageCache: {}
      fullPaths: true

  bundle bundler

  bundler = watchify bundler
  bundler.on 'update', ->
    bundle bundler

bundle = (bundler) ->
  bundler
    .bundle()
    .pipe(source('main.js'))
    .pipe(buffer())
    .pipe(sourcemaps.init(loadMaps: true))
    .pipe(streamify(uglify()))
    .pipe(sourcemaps.write('./'))
    .pipe gulp.dest(JAVASCRIPT_DEST)

gulp.task 'scripts-lint', ->
  gulp.src(SCRIPTS_ALL_SRC)
    .pipe(coffeelint('coffeelint.json'))
    .pipe coffeelint.reporter()

gulp.task 'images', ->
  gulp.src(IMAGES_SRC)
    .pipe(gulpif(
      IN_DEV
      changed(IMAGES_DEST)
    ))
    .pipe(imagemin(
      progressive: true
      svgoPlugins: [removeViewBox: false]
      use: [pngquant()]
    ))
    .pipe gulp.dest(IMAGES_DEST)

gulp.task 'build', (callback) ->
  IN_DEV = false
  runSequence(
    'ico-txt-copy'
    'templates'
    ['vendors-css', 'styles']
    ['vendors-javascript', 'scripts-prod']
    'images',
    callback
  )

gulp.task 'serve', ->
  browserSync
    server:
      baseDir: APP_DEST

gulp.task 'watch', ['scripts-dev'], ->
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
    ['vendors-javascript', 'scripts-dev', 'scripts-lint']
    'images'
    'serve'
    'watch'
    callback
  )
