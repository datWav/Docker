all: build

build:
	docker build -t=datwav/ruby .

start:
	docker run --name ruby \
		--rm \
		datwav/ruby

stop:
	docker stop ruby