express = require 'express.io'
schedule = require 'node-schedule'
Datastore = require 'nedb'
path = require 'path'

app = express()
db = new Datastore
	filename: 'data/store.db'

app.http().io()

app.use express.static path.join process.cwd() + '/public'
app.use express.static path.join process.cwd() + '/build/client/'

app.io.route 'init', (req) ->
	req.io.emit 'image', {url: 'https://www.google.com/images/srpr/logo11w.png'}
	console.log 'init from client'
	name = req.name
	rotate = new schedule.RecurrenceRule()
	rotate.minute = 5
	counter = 0
	job = schedule.scheduleJob rotate, ((req)->
		db.count
			isSlide: true
		, (err, count) ->
			if counter >= count
				counter = 0
			db.findOne
				isSlide: true
				count: counter
			,(err, doc) ->
				req.io.emit 'slide',
					document: doc
	).bind req

app.listen 3000
