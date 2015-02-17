socket = io.connect()

socket.emit 'init'

window.updateFrame = (type, item) ->
	if type = 'image'
		image = $('<img></img>')
			.attr('src',item.url)
		$('#screen')
			.append(image)

socket.on 'image', (data) ->
	console.log 'new image'
	updateFrame 'image', data
