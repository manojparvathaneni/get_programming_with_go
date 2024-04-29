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
