browserify = require 'browserify'
coffee     = require 'gulp-coffee'
concat     = require 'gulp-concat'
del        = require 'del'
fs         = require 'fs'
gulp       = require 'gulp'
gutil      = require 'gulp-util'
handlebars = require 'gulp-compile-handlebars'
jasmine    = require 'gulp-jasmine'
plumber    = require 'gulp-plumber'
rename     = require 'gulp-rename'
rev        = require 'gulp-rev'
# sourcemaps = require 'gulp-sourcemaps'
transform  = require 'vinyl-transform'
uglify     = require 'gulp-uglify'


paths =
    scripts: ['./src/*.coffee']
    content: ['./content/*.hbs']
    vendorjs: []
    vendorcss: []


# transpile coffeescript code into build directory
gulp.task 'build:coffee', ->
    gulp.src paths.scripts
        .pipe plumber()
        .pipe coffee bare:true
        .pipe gulp.dest './build'


gulp.task 'js:concat', ['build:coffee'], ->
    gulp.src ['./build/react-monitorbox.js']
        .pipe plumber()
        .pipe concat 'app.js'
        .pipe gulp.dest './build'


gulp.task 'copy:js', ->
    gulp.src ['./src/*.js', './vendor/js/*.js']
        .pipe gulp.dest './dist/js'


gulp.task 'copy:css', ->
    gulp.src ['./vendor/css/**'], 'base': './vendor/css'
        .pipe gulp.dest './dist/css'


gulp.task 'copy:img', ->
    gulp.src ['./content/img/*']
        .pipe gulp.dest './dist/img'


gulp.task 'package', ['js:concat'], ->
    browserified = transform((filename) ->
        browserify(filename).bundle())

    gulp.src './build/app.js'
        .pipe plumber()
        .pipe browserified
        .pipe gulp.dest './dist/js'
        # .pipe sourcemaps.init()
        .pipe uglify()
        # .pipe sourcemaps.write()
        .pipe rename suffix:'.min'
        .pipe rev()
        .pipe gulp.dest './dist/js'
        .pipe rev.manifest()
        .pipe gulp.dest './dist'


# comile handlebars templates
gulp.task 'build:html', ['package'], ->
    opts =
        helpers:
            assetJsPath: (path, ctx) ->
                ['/js', ctx.data.root[path]].join '/'
        batch:
            ['./content/partials']

    manifest = JSON.parse(fs.readFileSync './dist/rev-manifest.json', 'utf8')
    gulp.src paths.content
        .pipe plumber()
        .pipe handlebars manifest, opts
        .pipe rename extname:'.html'
        .pipe gulp.dest './dist'


gulp.task 'test', ->
    gulp.src './spec/*.coffee'
        .pipe jasmine verbose:true


gulp.task 'clean', ->
    del.sync [
        './build/*',
        './dist/*'
    ], force: true


gulp.task 'watch', ->
    gulp.watch paths.scripts, ['test']
    gulp.watch paths.content, ['build:html']


gulp.task 'default', ['clean', 'test', 'package', 'build:html', 'copy:js', 'copy:css', 'copy:img']
