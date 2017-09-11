.PHONY: build run debug test doc

TYPE='AUTHORITATIVE'

DISTRO = fedora-26-x86_64
VERSION = 9
DG = /home/rpitonak/.local/bin/dg

DG_EXEC = ${DG} --distro ${DISTRO}.yaml --spec specs/configuration.yml --multispec specs/multispec.yml --multispec-selector version=${VERSION}
DISTRO_ID = $(shell ${DG_EXEC} --template "{{ config.os.id }}")

IMAGE_NAME = modularitycontainers/bind
IMAGE_OPTIONS = \
    -p 127.0.0.1:53:53 \
    -p 127.0.0.1:53:53/udp \
		-e SERVER_TYPE=$(TYPE)

run: build
	docker run $(IMAGE_OPTIONS) $(IMAGE_NAME)

debug: build
	docker run -t -i $(IMAGE_OPTIONS) $(IMAGE_NAME) bash

build: doc dg
	docker build --tag=$(IMAGE_NAME) -f Dockerfile.rendered .

test: build
	cd tests && VERSION=${VERSION} DISTRO=${DISTRO} DOCKERFILE="../Dockerfile.rendered" MODULE=docker URL="docker=$(IMAGE_NAME)" make all
	cd tests/authoritative/ && VERSION=${VERSION} DISTRO=${DISTRO} DOCKERFILE="../Dockerfile.rendered" MODULE=docker URL="docker=$(IMAGE_NAME)" make all
	cd tests/caching/ && VERSION=${VERSION} DISTRO=${DISTRO} DOCKERFILE="../Dockerfile.rendered" MODULE=docker URL="docker=$(IMAGE_NAME)" make all

doc: dg
	mkdir -p ./root/
	go-md2man -in=help/help.md.rendered -out=./root/help.1

dg:
	${DG_EXEC} --template Dockerfile --output Dockerfile.rendered
	${DG_EXEC} --template help/help.md --output help/help.md.rendered
	${DG_EXEC} --template files/named.conf --output files/named.conf.rendered

clean:
	rm -f Dockerfile.*
	rm -f help/help.md.*
	rm -rf root
	rm -rf files/named.conf.*
