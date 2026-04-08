APP_NAME = SpineReminder
BUILD_DIR = .build/release
APP_BUNDLE = build/$(APP_NAME).app

.PHONY: app clean

app: $(APP_BUNDLE)

$(APP_BUNDLE):
	swift build -c release
	@mkdir -p $(APP_BUNDLE)/Contents/MacOS
	@mkdir -p $(APP_BUNDLE)/Contents/Resources
	@cp $(BUILD_DIR)/$(APP_NAME) $(APP_BUNDLE)/Contents/MacOS/
	@cp Resources/Info.plist $(APP_BUNDLE)/Contents/
	@echo "Built $(APP_BUNDLE)"

clean:
	swift package clean
	rm -rf build/
