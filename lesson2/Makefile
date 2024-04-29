.DEFAULT_GOAL := setup

setup:
	mkdir -p bin
	go mod init lesson2

.PHONY: fmt vet build run test clean
fmt:
	go fmt ./...

vet: fmt
	go vet ./...

build: vet
	go build -o bin/lesson2

run: build
	./bin/lesson2

test:
	go test

clean:
	go clean
