.PHONY: run build test

run:
	@echo "Running the project..."
	@zig build run

build:
	@echo "Building the project..."
	@zig build
	@echo "done!"

test:
	@echo "Testing the project..."
	@zig build test

clean:
	@echo "Cleaning build artifacts..."
	@rm -rf ./.zig-cache ./zig-out
