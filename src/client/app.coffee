## This Source Code Form is subject to the terms of the Mozilla Public License,
## v. 2.0. If a copy of the MPL was not distributed with this file,
## You can obtain one at http://mozilla.org/MPL/2.0/

window.socket = socket = io.connect()

socket.emit 'init'

socket.emit 'getAll'

frames = {}

window.addFrame = (item) ->
	frame = ''
	if item.type = 'image'
		frame = $('<img></img>')
			.addClass('imageSlide')
			.attr('id', item._id)
			.attr('src',item.url)
	else if item.type = 'video'
		frame = $('<video></video>')
			.addClass('videoSlide')
			.attr('id',item._id)
			.attr('src',item.url)
	frames[item._id] = frame

window.setFrame = (item) ->
	frame = frames[item._id]
	$('#screen')
		.empty()
		.append(image)

socket.on 'setSlide', (data) ->
	console.log 'Set slide'
	setFrame data

socket.on 'addSlide', (data) ->
	addFrame(data)
