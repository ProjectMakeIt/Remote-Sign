express = require 'express.io'
schedule = require 'node-schedule'
Datastore = require 'nedb'
path = require 'path'

app = express()
db = new Datastore
	filename: 'data/store.db'
	autoload: true

app.http().io()

app.use express.static path.join process.cwd() + '/public'
app.use express.static path.join process.cwd() + '/build/client/'

counter = 0

nextSlide = (req) ->
	db.count
		isSlide: true
	, (err, count) ->
		counter = counter + 1
		if counter >= count
			counter = 0
		db.find
			isSlide: true
		,(err, docs) ->
			if err or doc is null
				console.error err
				return
			doc = docs[counter]
			req.io.emit 'image',
				url: doc.url

app.io.route 'init', (req) ->
	req.io.emit 'image', {url: 'img/fltlogo.png'}
	setInterval	nextSlide, 5000, req

app.io.route 'add', (req) ->
	db.count
		isSlide: true
	, (err, count) ->
		doc =
			url: req.data.url
			name: req.data.name
			isSlide: true
		db.insert doc, (err)->
			if err
				console.error err
			getAll(req)


app.io.route 'remove', (req) ->
	console.log req.data.id
	if not req.data.id
		req.io.emit 'error', 'no id object'
	db.find
		_id: req.data.id
	, (err, data) ->
		console.log data
	db.remove
		_id: req.data.id
	, (err) ->
		if err
			console.error err
		getAll(req)
		

app.io.route 'next', (req) ->
	nextSlide req
	
app.io.route 'getAll', (req) ->
	getAll req

getAll = (req) ->
	db.find
		isSlide: true
	, (err, doc) ->
		req.io.emit 'slides', doc
console.log 'running'

port = process.env.PORT || 3000
app.listen port
