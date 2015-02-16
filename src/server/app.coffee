express = require 'express-io'
schedule = require 'node-schedule'
Datastore = require 'nedb'
path = require 'path'

app = express()
db = new Datastore
	filename: 'data/store.db'

app.http().io()

app.get '/', (req,res) ->
	res.sendFile path.join __dirname, 'views/index.html'

app.io.route 'init', (req) ->
	name = req.name
	rotate = new schedule.RecurrenceRule()
	rotate.minute = 5
	counter = 0
	job = schedule.scheduleJob rotate, (()->
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
