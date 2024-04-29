.DEFAULT_GOAL := setup

setup: main.go
	mkdir -p bin
	go mod init lesson1

.PHONY: fmt vet build run test clean
fmt:
	go fmt ./...

vet: fmt
	go vet ./...

build: vet
	go build -o bin/lesson1

run: build
	./bin/lesson1

test:
	go test

clean:
	go clean
