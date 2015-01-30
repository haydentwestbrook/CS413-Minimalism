FLEX_SDK = C:/Flex
ADL = $(FLEX_SDK)/bin/adl
AMXMLC = $(FLEX_SDK)/bin/amxmlc
SOURCES = src/*.hx assets/loading.png

all: game.swf

game.swf: $(SOURCES)
	haxe \
	-cp src \
	-cp vendor \
	-swf-version 11.8 \
	-swf-header 640:480:60:ffffff \
	-main Startup \
	-swf game.swf \
	-swf-lib vendor/starling-11.8.swc --macro "patchTypes('vendor/starling.patch')"

clean:
	rm -rf GGame.swf *~ src/*~

test: game.swf
	$(ADL) -profile tv -screensize 640x480:640x480 game.xml
