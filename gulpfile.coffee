browserify = require 'browserify'
coffee     = require 'gulp-coffee'
del        = require 'del'
gulp       = require 'gulp'
gutil      = require 'gulp-util'
jasmine    = require 'gulp-jasmine'
jshint     = require 'gulp-jshint'
plumber    = require 'gulp-plumber'
rename     = require 'gulp-rename'
transform  = require 'vinyl-transform'
uglify     = require 'gulp-uglify'


gulp.task 'build:coffee', ->
    gulp.src './src/*.coffee'
        .pipe plumber()
        .pipe coffee bare:true
        .pipe gulp.dest './build'


gulp.task 'browserify', ['build:coffee'], ->
    browserified = transform((filename) ->
        browserify(filename).bundle())

    gulp.src './build/*.js'
        .pipe plumber()
        .pipe browserified
        .pipe gulp.dest './output'


gulp.task 'js:minify', ['browserify'], ->
    gulp.src './output/react-monitorbox.js'
        .pipe plumber()
        .pipe uglify()
        .pipe rename suffix:'.min'
        .pipe gulp.dest './dist'


gulp.task 'js:lint', ->
    gulp.src './build/*.js'
        .pipe plumber()
        .pipe jshint()
        .pipe jshint.reporter 'jshint-stylish'


gulp.task 'copy:static', ['browserify'], ->
    gulp.src ['./content/**', './output/**']
        .pipe plumber()
        .pipe gulp.dest './dist'


gulp.task 'test', ->
    gulp.src './spec/*.coffee'
        .pipe jasmine verbose:true


gulp.task 'clean', ->
    del.sync [
        './build',
        './output',
        './dist'
    ]

gulp.task 'default', ['clean', 'test', 'js:lint', 'js:minify', 'copy:static']
