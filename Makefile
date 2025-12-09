TARGET := iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = Spotify
ARCHS = arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = GalapagameSpotify

GalapagameSpotify_FILES = $(shell find Sources/GalapagameSpotify -name '*.swift') $(shell find Sources/GalapagameSpotifyC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
GalapagameSpotify_SWIFTFLAGS = -ISources/GalapagameSpotifyC/include -Osize
GalapagameSpotify_EXTRA_FRAMEWORKS = SwiftProtobuf
GalapagameSpotify_CFLAGS = -fobjc-arc -ISources/GalapagameSpotifyC/include -Os

include $(THEOS_MAKE_PATH)/tweak.mk

copy-swiftprotobuf:
	mkdir -p swiftprotobuf && cd swiftprotobuf ;\
	curl -OL https://github.com/whoGalapagame/GalapagameSpotify/releases/download/swift2.0/org.swift.protobuf.swiftprotobuf_1.26.0_iphoneos-arm.deb ;\
	ar -x org.swift.protobuf.swiftprotobuf_1.26.0_iphoneos-arm.deb ;\
	tar -xvf data.tar.lzma ;\
	cp -r Library/Frameworks/SwiftProtobuf.framework "${THEOS}/lib" ;\
