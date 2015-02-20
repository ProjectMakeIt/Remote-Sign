window.socket = socket = io.connect()

$ () ->
	newSlide = document.getElementById "newSlide"
	addFile = document.getElementById "addFile"

	newSlide.addEventListener "click", (e) ->
		if addFile
			addFile.click()
	socket.on 'slides', window.getSlides
	socket.emit 'getAll'

window.addImage = (files)->
	window.image = files
	file = files[0]
	reader = new FileReader()
	reader.onload = (e) ->
		addSlide e.target.result
	reader.readAsDataURL file
	console.log files

window.addSlide = (url)->
	doc =
		url: url
	socket.emit 'add', doc

window.removeSlide = (id) ->
	doc =
		id: id
	socket.emit 'remove', doc

window.getSlides = (docs) ->
	slides = $("#slides")
	slides.empty()
	for doc in docs
		slides.append $ Handlebars.templates['slide-template.html'](doc)
