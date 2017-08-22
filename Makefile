.PHONY: build run debug test doc

TYPE='AUTHORITATIVE'

IMAGE_NAME = modularitycontainers/bind
IMAGE_OPTIONS = \
    -p 127.0.0.1:53:53 \
    -p 127.0.0.1:53:53/udp \
		-e SERVER_TYPE=$(TYPE)

run: build
	docker run $(IMAGE_OPTIONS) $(IMAGE_NAME)

debug: build
	docker run -t -i $(IMAGE_OPTIONS) $(IMAGE_NAME) bash

build: doc
	docker build --tag=$(IMAGE_NAME) .

test: build
	cd tests && MODULE=docker URL="docker=$(IMAGE_NAME)" make all
	cd tests/authoritative/ && MODULE=docker URL="docker=$(IMAGE_NAME)" make all
	cd tests/caching/ && MODULE=docker URL="docker=$(IMAGE_NAME)" make all

doc:
	go-md2man -in=./root/help.md -out=./root/help.1
