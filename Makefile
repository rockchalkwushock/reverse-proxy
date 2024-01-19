.PHONY: help
help:
	@echo 'Usage:'
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'

.PHONY: run-containers
run-containers:
	docker run --rm -d -p 9001:80 --name server1 kennethreitz/httpbin
	docker run --rm -d -p 9002:80 --name server2 kennethreitz/httpbin
	docker run --rm -d -p 9003:80 --name server3 kennethreitz/httpbin

.PHONY: run-proxy-server
run-proxy-server:
	@go run main.go

.PHONY: stop
stop:
	docker stop server1
	docker stop server2
	docker stop server3

.PHONY: tidy
tidy:
	@go fmt ./...
	@go mod tidy -v

.PHONY: audit
audit:
	@go vet ./...
	@go run honnef.co/go/tools/cmd/staticcheck@latest -checks=all,-ST1000,-U1000 ./...
	@go test -race -vet=off ./...
	@go mod verify

build:
	@go build -o bin/rp

run:
	@./bin/rp
