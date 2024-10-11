.PHONY: all build test ios macos tvos clean pretty

pretty:
	swiftformat . --config airbnb.swiftformat

# Default target
all: clean build test

# Build target
build: clean build-ios build-macos build-tvos

# Test target
test: test-ios test-macos test-tvos

# Build for iOS
build-ios:
	@echo "Building for iOS..."
	swift build \
		--build-path .build/ios

# Build for macOS
build-macos:
	@echo "Building for macOS..."
	swift build \
		--build-path .build/macos

# Build for tvOS
build-tvos:
	@echo "Building for tvOS..."
	swift build \
		--build-path .build/tvos
		
# Clean the build directories
clean:
	@echo "Cleaning build directories..."
	rm -rf .build
