argv       = require('yargs').argv
browserify = require 'browserify'
coffee     = require 'gulp-coffee'
concat     = require 'gulp-concat'
del        = require 'del'
fs         = require 'fs'
gulp       = require 'gulp'
gulpif     = require 'gulp-if'
gutil      = require 'gulp-util'
handlebars = require 'gulp-compile-handlebars'
jasmine    = require 'gulp-jasmine'
minify_css = require 'gulp-minify-css'
plumber    = require 'gulp-plumber'
refills    = require('node-refills').includePaths
rename     = require 'gulp-rename'
rev        = require 'gulp-rev'
sass       = require 'gulp-sass'
transform  = require 'vinyl-transform'
uglify     = require 'gulp-uglify'


paths =
    scripts: ['./src/*.coffee']
    content: ['./content/*.hbs']
    sass: ['./scss/*.scss']
    build_transpiled: ['./build/transpiled']
    build_packaged: ['./build/packaged']
    dist: ['./dist']
    vendorjs: []
    vendorcss: []


# transpile coffeescript code into build directory
gulp.task 'build:coffee', ->
    gulp.src paths.scripts
        .pipe coffee bare:true
        .pipe gulp.dest paths.build_transpiled + '/js'


# transpile sass code into build directory
gulp.task 'build:sass', ->
    gulp.src paths.sass
        .pipe plumber()
        .pipe sass includePaths: refills
        .pipe gulp.dest paths.build_transpiled + '/css'


# concatenate required js files into app.js
gulp.task 'js:concat', ['build:coffee'], ->
    gulp.src [paths.build_transpiled + '/js/react-monitorbox.js']
        .pipe concat 'app.js'
        .pipe gulp.dest paths.build_transpiled + '/js'


gulp.task 'package:js', ['js:concat'], ->
    browserified = transform((filename) ->
        browserify(filename).bundle())

    gulp.src [paths.build_transpiled + '/js/app.js']
        .pipe plumber()
        .pipe browserified
        .pipe gulp.dest paths.build_packaged + '/js'
        .pipe uglify()
        .pipe rename suffix:'.min'
        .pipe gulp.dest paths.build_packaged + '/js'


gulp.task 'package:css', ['build:sass'], ->
    gulp.src [paths.build_transpiled + '/css/*.css']
        .pipe gulp.dest paths.build_packaged + '/css'
        .pipe minify_css()
        .pipe rename suffix:'.min'
        .pipe gulp.dest paths.build_packaged + '/css'


gulp.task 'cachebust', ['package:css', 'package:js'], ->
    gulp.src [paths.build_packaged + '/**/*.js', paths.build_packaged + '/**/*.css']
        .pipe rev()
        .pipe gulp.dest './dist'
        .pipe rev.manifest()
        .pipe gulp.dest './dist'


# comile handlebars templates
gulp.task 'build:html', ['cachebust'], ->
    opts =
        helpers:
            assetPath: (path, ctx) ->
                ctx.data.root[path]
        batch:
            ['./content/partials']

    template_data = JSON.parse(fs.readFileSync './dist/rev-manifest.json', 'utf8')
    template_data.app_js = if argv.production then 'js/app.min.js' else 'js/app.js'
    template_data.app_css = if argv.production then 'css/all.min.css' else 'css/all.css'

    gulp.src paths.content
        .pipe plumber()
        .pipe handlebars template_data, opts
        .pipe rename extname:'.html'
        .pipe gulp.dest './dist'



# deploy vendor code

# gulp.task 'copy:js', ->
#     gulp.src ['./src/*.js', './vendor/js/*.js']
#         .pipe gulp.dest './dist/js'


# gulp.task 'copy:css', ->
#     gulp.src ['./vendor/css/**'], 'base': './vendor/css'
#         .pipe gulp.dest './dist/css'


# gulp.task 'copy:img', ->
#     gulp.src ['./content/img/*']
#         .pipe gulp.dest './dist/img'



gulp.task 'test', ->
    gulp.src './spec/*.coffee'
        .pipe jasmine verbose:true


gulp.task 'clean', ->
    del.sync [
        './build/*',
        './dist/*'
    ], force: true


gulp.task 'watch', ->
    gulp.watch paths.scripts, ['default']
    gulp.watch paths.sass, ['default']
    gulp.watch './content/*', ['default']


gulp.task 'default', ['clean', 'test', 'cachebust', 'build:html']
