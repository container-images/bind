.PHONY: build run

TYPE='AUTHORITATIVE'

IMAGE_NAME = dns-bind
IMAGE_OPTIONS = \
    -v $(shell pwd)/config.yaml:/config.yaml:ro \
    -p 127.0.0.1:53:53 \
    -p 127.0.0.1:53:53/udp \
		-e SERVER_TYPE=$(TYPE)

run: build
	docker run $(IMAGE_OPTIONS) $(IMAGE_NAME)

debug: build
	docker run -t -i $(IMAGE_OPTIONS) $(IMAGE_NAME)

build: Makefile Dockerfile files/*
	docker build --tag=$(IMAGE_NAME) .

test:
	run-test.sh
