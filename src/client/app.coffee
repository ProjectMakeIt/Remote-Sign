## This Source Code Form is subject to the terms of the Mozilla Public License,
## v. 2.0. If a copy of the MPL was not distributed with this file,
## You can obtain one at http://mozilla.org/MPL/2.0/

window.socket = socket = io.connect()

socket.emit 'init'

window.updateFrame = (type, item) ->
	if type = 'image'
		image = $('<img></img>')
			.addClass('imageSlide')
			.attr('src',item.url)
		$('#screen')
			.empty()
			.append(image)
	else if type = 'text'
		text = $('<div></div>')
			.addClass('textSlide')
			.text(item.text)
		$('#screen')
			.empty()
			.append(text)

socket.on 'image', (data) ->
	console.log 'new image'
	updateFrame 'image', data

socket.on 'text', (data) ->
	console.log 'new text'
	updateFrame 'text', data
