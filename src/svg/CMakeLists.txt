
set(svg_SRC
	css-ostringstream.cpp
	#ftos.cpp
	itos.cpp
	path-string.cpp
	round.cpp
	sp-svg.def
	stringstream.cpp
	strip-trailing-zeros.cpp
	svg-affine.cpp
	svg-color.cpp
	svg-length.cpp
	svg-path.cpp
	# test-stubs.cpp


	# -------
	# Headers
	css-ostringstream-test.h
	css-ostringstream.h
	path-string.h
	stringstream-test.h
	stringstream.h
	strip-trailing-zeros.h
	svg-affine-test.h
	svg-color-test.h
	svg-color.h
	svg-icc-color.h
	svg-length-test.h
	svg-length.h
	svg-path-geom-test.h
	svg.h
	# test-stubs.h

)

# add_inkscape_lib(svg_LIB "${svg_SRC}")
add_inkscape_source("${svg_SRC}")
