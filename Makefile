WINE_ROOT=wine-root
RELEASE=5.1.1.0
INSTALLER="iqfeed_client_$(shell echo $(RELEASE) | sed 's/\./_/g').exe"
DEB=iqfeed-$(RELEASE)_amd64.deb

menu:
	@echo "Because of required manual intervention, there are five steps:"
	@echo "  make fetch -- fetch $(INSTALLER) from www.iqfeed.net"
	@echo "  make install -- install into a subdirectory (requires GUI)"
	@echo "  make launch -- configure login/password (requires GUI)"

fetch:
	wget http://www.iqfeed.net/$(INSTALLER)

install:
	mkdir -p $(shell pwd)/$(WINE_ROOT) && WINEPREFIX=$(shell pwd)/$(WINE_ROOT) wine $(INSTALLER)

launch:
	@echo "Set up your username, password and autoconnect, then connect and test"
	WINEPREFIX=$(shell pwd)/$(WINE_ROOT) wine 'c:\\Program Files (x86)\\DTN\\IQFeed\\iqconnect.exe' -product IQFEED_DEMO -version 1.0.0.0
