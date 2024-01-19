package main

import (
	"log"

	"github.com/rockchalkwushock/reverse-proxy/internals/server"
)

func main() {
	if err := server.Run(); err != nil {
		log.Fatalf("could not start the server: %v", err)
	}
}
