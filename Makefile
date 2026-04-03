APP_NAME = ResetDictation
BUNDLE = $(APP_NAME).app
INSTALL_DIR = ~/Applications

.PHONY: build install uninstall clean

build:
	swiftc $(APP_NAME).swift -o $(APP_NAME)
	mkdir -p $(BUNDLE)/Contents/MacOS
	cp $(APP_NAME) $(BUNDLE)/Contents/MacOS/
	cp Info.plist $(BUNDLE)/Contents/
	@echo "Built $(BUNDLE)"

install: build
	mkdir -p $(INSTALL_DIR)
	cp -R $(BUNDLE) $(INSTALL_DIR)/
	@echo "Installed to $(INSTALL_DIR)/$(BUNDLE)"

uninstall:
	-killall $(APP_NAME) 2>/dev/null
	rm -rf $(INSTALL_DIR)/$(BUNDLE)
	@echo "Uninstalled $(BUNDLE)"

clean:
	rm -rf $(APP_NAME) $(BUNDLE)

release: build
	ditto -c -k --keepParent $(BUNDLE) $(APP_NAME).zip
	@echo "Created $(APP_NAME).zip"
