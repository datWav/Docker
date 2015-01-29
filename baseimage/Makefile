all: build

build:
	docker build -t=datwav/baseimage .

start:
	docker run --rm --name baseimage datwav/baseimage

stop:
	docker stop baseimage