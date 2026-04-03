APP_NAME = ResetDictation
BUNDLE = $(APP_NAME).app
INSTALL_DIR = ~/Applications

.PHONY: build install uninstall clean

build:
	swiftc $(APP_NAME).swift -o $(APP_NAME)
	mkdir -p $(BUNDLE)/Contents/MacOS
	cp $(APP_NAME) $(BUNDLE)/Contents/MacOS/
	cp Info.plist $(BUNDLE)/Contents/
	codesign --force --sign - $(BUNDLE)
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
	rm -rf $(APP_NAME) $(BUNDLE) $(APP_NAME).dmg

release: build
	mkdir -p dmg-staging
	cp -R $(BUNDLE) dmg-staging/
	ln -sf /Applications dmg-staging/Applications
	hdiutil create -volname "$(APP_NAME)" -srcfolder dmg-staging -ov -format UDZO $(APP_NAME).dmg
	rm -rf dmg-staging
	@echo "Created $(APP_NAME).dmg"
