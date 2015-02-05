all: build

build:
	docker build -t=datwav/baseimage .

start:
	docker run --name baseimage \
		--rm \
		datwav/baseimage

stop:
	docker stop baseimage