gulp = require 'gulp'
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

APP_DEST = './public'
CSS_DEST = "#{APP_DEST}/css"
JAVASCRIPT_DEST = "#{APP_DEST}/javascript"
IMAGES_DEST = "#{APP_DEST}/images"

gulp.task 'ico-txt-copy', ->
  gulp.src([
    './src/favicon.ico'
    './src/robots.txt'
  ])
    .pipe gulp.dest(APP_DEST)

gulp.task 'templates', ->
  gulp.src('./src/**/*.jade')
    .pipe(changed(APP_DEST))
    .pipe(jade())
    .pipe(minifyHtml())
    .pipe gulp.dest(APP_DEST)

gulp.task 'templates-lint', ->
  gulp.src('./src/**/*.jade')
    .pipe jadelint()

gulp.task 'vendors-css-copy', ->
  gulp.src('./node_modules/angular-material/angular-material.css')
    .pipe(uglifycss())
    .pipe gulp.dest(CSS_DEST)

gulp.task 'vendors-css-load', ->
  gulp.src('./src/styles/vendor.styl')
    .pipe(stylus())
    .pipe(uglifycss())
    .pipe gulp.dest(CSS_DEST)

gulp.task 'vendors-css', [
  'vendors-css-copy'
  'vendors-css-load'
]

gulp.task 'styles-prod', ->
  gulp.src('./src/styles/main.styl')
    .pipe(stylus(
      use: [
        poststylus([
          'autoprefixer'
          'rucksack-css'
        ])
      ]
    ))
    .pipe(uglifycss())
    .pipe gulp.dest(CSS_DEST)

gulp.task 'styles-dev', ->
  gulp.src('./src/styles/main.styl')
    .pipe(changed(CSS_DEST))
    .pipe(sourcemaps.init(loadMaps: true))
    .pipe(stylus(
      use: [
        poststylus([
          'autoprefixer'
          'rucksack-css'
        ])
      ]
    ))
    .pipe(uglifycss())
    .pipe(sourcemaps.write('./'))
    .pipe gulp.dest(CSS_DEST)

gulp.task 'styles-lint', ->
  gulp.src('./src/styles/**/*.styl')
    .pipe(stylint(config: '.stylintrc'))
    .pipe stylint.reporter()

gulp.task 'vendors-javascript', ->
  browserify(
    entries: './src/scripts/vendor.coffee'
    transform: [coffeeify]
  )
    .bundle()
    .pipe(source('vendor.js'))
    .pipe(buffer())
    .pipe(streamify(uglify()))
    .pipe gulp.dest(JAVASCRIPT_DEST)

gulp.task 'scripts-prod', ->
  browserify(
    entries: './src/scripts/main.coffee'
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
      entries: './src/scripts/main.coffee'
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
  gulp.src('./src/scripts/**/*.coffee')
    .pipe(coffeelint('coffeelint.json'))
    .pipe coffeelint.reporter()

gulp.task 'images', ->
  gulp.src('./src/images/**/*')
    .pipe(changed(IMAGES_DEST))
    .pipe(imagemin(
      progressive: true
      svgoPlugins: [removeViewBox: false]
      use: [pngquant()]
    ))
    .pipe gulp.dest(IMAGES_DEST)

gulp.task 'build', [
  'ico-txt-copy'
  'templates',
  'vendors-css', 'styles-prod'
  'vendors-javascript', 'scripts-prod',
  'images'
]

gulp.task 'serve', ->
  browserSync
    server:
      baseDir: APP_DEST

gulp.task 'watch', ['scripts-dev'], ->
  gulp.watch './src/**/*', [
    'templates'
    'styles-dev'
    'images'
    browserSync.reload
  ]

gulp.task 'default', (callback) ->
  runSequence(
    'ico-txt-copy'
    ['templates', 'templates-lint']
    ['vendors-css', 'styles-dev', 'styles-lint']
    ['vendors-javascript', 'scripts-dev', 'scripts-lint']
    'images'
    'serve'
    'watch'
    callback
  )
