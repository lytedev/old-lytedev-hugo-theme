path = require 'path'
fs = require 'fs'

gulp = require 'gulp'
pug = require 'gulp-pug'
stylus = require 'gulp-stylus'
coffee = require 'gulp-coffee'
poststylus = require 'poststylus'

sourceDir = path.resolve __dirname + '/src/'
distDir = path.resolve __dirname + '/'

cfg =
	css:
		sources: sourceDir + '/styles/main.styl'
		dest: distDir + '/static/css/'
	templates:
		sources: sourceDir + '/templates/**/*.pug'
		dest: distDir + '/layouts/'
	scripts:
		sources: sourceDir + '/scripts/**/*.coffee'
		dest: distDir + '/'
	templateLocals:
		sitename: "lytedev"
		logoPath: require

gulp.task 'stylus', ->
	gulp.src cfg.css.sources
		.pipe stylus
			use: [ poststylus ['autoprefixer'] ]
		.pipe gulp.dest cfg.css.dest

gulp.task 'templates', ->
	gulp.src cfg.templates.sources
		.pipe pug
			locals: cfg.templateLocals
		.pipe gulp.dest cfg.templates.dest

gulp.task 'scripts', ->
	gulp.src cfg.scripts.sources
		.pipe coffee
			bare: true
		.pipe gulp.dest cfg.scripts.dest

gulp.task 'build', ['stylus', 'templates', 'scripts']

gulp.task 'watch-stylus', ->
	dirs = [
		cfg.css.sources
	]
	gulp.watch dirs, ['stylus']

gulp.task 'watch-templates', ->
	dirs = [
		cfg.templates.sources
	]
	gulp.watch dirs, ['templates']

gulp.task 'watch-scripts', ->
	dirs = [
		cfg.scripts.sources
	]
	gulp.watch dirs, ['scripts']

gulp.task 'watch-source', ['watch-stylus', 'watch-templates', 'watch-scripts']

gulp.task 'watch', ['build', 'watch-source']
gulp.task 'default', ['watch']
