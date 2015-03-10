## This Source Code Form is subject to the terms of the Mozilla Public License, 
## v. 2.0. If a copy of the MPL was not distributed with this file,
## You can obtain one at http://mozilla.org/MPL/2.0/

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
