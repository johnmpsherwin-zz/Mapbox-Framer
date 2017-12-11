# map.css file in ../framer/map.css sets cursor style to 'inherit' so we get the framer cursor. Other set up for mapbox js and css is in index.html

map = new Layer
	size: Screen.size

map.ignoreEvents = false

# you'll need to use our own access token here
mapboxgl.accessToken = 'YOUR ACCESS TOKEN'

mapbox = new mapboxgl.Map
	container: map._element,
	# copy and paste your own style or one of mapbox's default styles here
	style: 'YOUR STYLE URL'
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

