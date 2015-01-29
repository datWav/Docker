all: build

build:
	docker build -t=datwav/teamspeak3 .

start:
	docker run --rm -i --name teamspeak3 \
		-v /tmp/teamspeak3:/opt/data \
		datwav/teamspeak3

stop:
	docker stop teamspeak3