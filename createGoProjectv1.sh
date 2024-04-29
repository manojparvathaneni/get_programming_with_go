#!/bin/sh

# Function to print separators
print_separator() {
    echo "--------------------------------------------"
}

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <folder_name> <module_name>"
    exit 1
fi

# Assigning arguments to variables
folder_name="$1"
module_name="$2"

# Store the current directory
current_dir=$(pwd)

echo "Creating main project directory: $folder_name"
# Create main project directory
mkdir -p "$folder_name"
cd "$folder_name" || exit 1

# # Initialize Git
# echo "Initializing Git repository..."
# git init

# Create .gitignore file
echo "Creating .gitignore file..."
cat > .gitignore <<EOF
# Ignore bin directory
bin/

EOF
echo ".gitignore file created."
print_separator

# Check if Makefile exists
if [ ! -f Makefile ]; then
    echo "Makefile not found. Creating one..."
     # Create Makefile if it doesn't exist
    cat > Makefile <<EOF
.DEFAULT_GOAL := setup

setup: main.go
	mkdir -p bin
	go mod init $module_name

.PHONY: fmt vet build run test clean
fmt:
	go fmt ./...

vet: fmt
	go vet ./...

build: vet
	go build -o bin/$module_name

run: build
	./bin/$module_name

test:
	go test

clean:
	go clean
EOF
    echo "Makefile created."
    print_separator
fi

# Create main.go file if it doesn't exist
if [ ! -f main.go ]; then
    echo "Creating main.go file..."
    cat > main.go <<EOF
package main

import "fmt"

func main() {
	fmt.Println("Hello, world!")
}
EOF
    echo "main.go created."
    print_separator
fi

# Create main_test.go file if it doesn't exist
if [ ! -f main_test.go ]; then
    echo "Creating main_test.go file..."
    cat > main_test.go <<EOF
package main

import (
	"testing"
)

func TestMain(t *testing.T) {
	want := "Hello, world!"
	if got := "Hello, world!"; got != want {
		t.Errorf("Main() = %q, want %q", got, want)
	}
}
EOF
    echo "main_test.go created."
    print_separator
fi

# Run make setup
echo "Running 'make setup'..."
print_separator
make setup
print_separator

# Run the code
echo "Running the main.go code..."
print_separator
make run
print_separator

# # Run the test code
# echo "Running the unittest code..."
# print_separator
# make test
# print_separator


# # If successful, comment out the print statement in main.go
# sed -i.bak 's/fmt.Println("Hello, world!")/\/\/ fmt.Println("Hello, world!")/' main.go
# echo "Print statement in main.go commented out."
# print_separator

# # Remove the .bak file
# rm -f main.go.bak

# Switch back to the original directory
cd "$current_dir" || exit 1

echo "GO Project setup complete. You can starting coding"
