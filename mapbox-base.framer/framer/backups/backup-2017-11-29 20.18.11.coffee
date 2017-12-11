# map.css file in ../framer/map.css sets cursor style to 'inherit' so we get the framer cursor. Other set up for mapbox js and css is in index.html

map = new Layer
	size: Screen.size

map.ignoreEvents = false

mapboxgl.accessToken = 'pk.eyJ1Ijoiam9obnNoZXJ3aW4iLCJhIjoiLXZQUDZvSSJ9.iN89AOBzgBLPgQ0TSursiA'

mapbox = new mapboxgl.Map
	container: map._element,
	style: 'mapbox://styles/johnsherwin/civmiwjaw00qz2jqlrsu5pnlb'
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

pinRect = marker._element.getBoundingClientRect()

pin.onClick ->
	layer = new Layer
		x: pinRect.left

# add popup
popup = new mapboxgl.Popup ({
	offset: 35 
	closeButton: false })
	.setLngLat([-6.2673351934, 53.3408667])
	.setHTML('<h3 style="color:#000">Popup Test</h3>')
	.addTo(mapbox)
