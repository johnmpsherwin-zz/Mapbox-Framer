# map.css file in ../framer/map.css sets cursor style to 'inherit' so we get the framer cursor. Other set up for mapbox js and css is in index.html

map = new Layer
	size: Screen.size

map.ignoreEvents = false

mapboxgl.accessToken = 'pk.eyJ1Ijoiam9obnNoZXJ3aW4iLCJhIjoiLXZQUDZvSSJ9.iN89AOBzgBLPgQ0TSursiA'

mapbox = new mapboxgl.Map
	container: map._element,
	style: 'mapbox://styles/johnsherwin/civmizfzg00qg2io7a43xgozg'
	zoom: 12
	center: [-6.2673351934, 53.3408667]
	attributionControl: false

# create custom pin
pin = new Layer
	size: 40
	borderRadius: 100
	backgroundColor: 'rgba(29, 200, 200, .60)'

# pin animation
scaleUp = new Animation pin,
	size: 60
	options:
		time: 1
		curve: 'ease'
scaleDown = scaleUp.reverse()
scaleUp.start()
scaleUp.onAnimationEnd -> scaleDown.start()
scaleDown.onAnimationEnd -> scaleUp.start()

# insert marker and use custom pin ⇣
marker = new mapboxgl.Marker(pin._element) 
	.setLngLat([-6.2673351934, 53.3408667])
	.addTo(mapbox)

# store marker position and size values in a variable
markerRect = marker._element.getBoundingClientRect()

# func to create popover
createPopover = ->
	popover = new Layer
		width: 300
		height: 80
		backgroundColor: "rgb(33, 33, 33)"
		borderRadius: 8
		midX: markerRect.left + markerRect.width
		maxY: markerRect.top 
	
	# update position of popover as map m
	mapbox.on 'touchmove', ->
		popover.midX = markerRect.left + markerRect.width
		popover.maxY = markerRect.top 


# put popover over the marker on tap
pin.onClick ->
	createPopover()

# update value when the map moves
mapbox.on 'touchmove', ->
	markerRect = marker._element.getBoundingClientRect()
	

# add popup
#popup = new mapboxgl.Popup ({
#	offset: 35 
#	closeButton: false })
#	.setLngLat([-6.2673351934, 53.3408667])
#	.setHTML('<h3 style="color:#000">Popup Test</h3>')
#	.addTo(mapbox)
