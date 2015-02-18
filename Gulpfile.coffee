gulp = require 'gulp'
mocha = require 'gulp-mocha'
istanbul = require 'gulp-coffee-istanbul'
coveralls = require 'gulp-coveralls'
coffeelint = require 'gulp-coffeelint'
coffee = require 'gulp-coffee'
server = require 'gulp-express'
livereload = require 'gulp-livereload'
cached = require 'gulp-cached'

gulp.task 'default', ['test', 'lint', 'build', 'watch', 'run']

gulp.task 'watch', ['build', 'test', 'lint'], ->
	livereload.listen
		port: 8000
	gulp.watch 'src/**/*.coffee', ['test', 'lint', 'build']

gulp.task 'run', ['watch'], ->
	console.log "launching server"
	server.run ['build/server/app.js']
	gulp.watch 'build/server/**/*.js', ()->
		server.run ['build/server/app.js']

gulp.task 'build', ->
	gulp.src 'src/**/*.coffee'
		.pipe coffee()
		.pipe gulp.dest 'build'
		.pipe livereload()

gulp.task 'test', (done) ->
	gulp.src 'src/**/*.coffee'
		.pipe istanbul
			includeUntested: true
		.pipe istanbul.hookRequire()
		.on 'finish', ->
			if process.env.CI
				reporter = 'spec'
			else
				reporter = 'nyan'
			gulp.src 'tests/**/*.coffee'
				.pipe mocha
					reporter:reporter
				.pipe istanbul.writeReports()
				.on 'end', () ->
					if process.env.CI
						gulp.src 'coverage/**/lcov.info'
							.pipe coveralls()
							.on 'finish', done
					else
						done()
	return null

gulp.task 'lint', ->
	gulp.src ['**/*.coffee','!node_modules/**/*']
		.pipe coffeelint 'coffeelint.json'
		.pipe coffeelint.reporter()
		.pipe coffeelint.reporter 'fail'
