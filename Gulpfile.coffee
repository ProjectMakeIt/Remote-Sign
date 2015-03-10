## This Source Code Form is subject to the terms of the Mozilla Public License, 
## v. 2.0. If a copy of the MPL was not distributed with this file,
## You can obtain one at http://mozilla.org/MPL/2.0/

gulp = require 'gulp'
mocha = require 'gulp-mocha'
istanbul = require 'gulp-coffee-istanbul'
coveralls = require 'gulp-coveralls'
coffeelint = require 'gulp-coffeelint'
coffee = require 'gulp-coffee'
nodemon = require 'gulp-nodemon'
livereload = require 'gulp-livereload'
cached = require 'gulp-cached'

gulp.task 'default', ['test', 'lint', 'build', 'watch', 'run']

gulp.task 'watch', ['build', 'test', 'lint'], ->
	livereload.listen
		port: 8000
	gulp.watch 'src/**/*.coffee', ['test', 'lint', 'build']

gulp.task 'run', ['watch'], ->
	console.log "launching server"
	nodemon
		script: 'build/server/app.js'
		watch: 'build/server'

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
