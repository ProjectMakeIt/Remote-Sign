gulp = require 'gulp'
mocha = require 'gulp-mocha'
istanbul = require 'gulp-coffee-istanbul'
coveralls = require 'gulp-coveralls'
coffeelint = require 'gulp-coffeelint'
coffee = require 'gulp-coffee'
server = require 'gulp-express'

gulp.task 'default', ['jade', 'test', 'lint', 'build', 'watch', 'run']

gulp.task 'watch', ['build', 'test', 'lint', 'jade'], ->
	gulp.watch 'src/**/*.coffee', ['test', 'lint', 'build']
	gulp.watch 'src/**/*', ['jade']

gulp.task 'run', ['watch'], ->
	server.run
		file: 'build/server/app.js'
	
	gulp.watch ['build/server/**/*.js'], server.notify

gulp.task 'build', ->
	gulp.src 'src/**/*.coffee'
		.pipe coffee()
		.pipe gulp.dest 'build/server'

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
