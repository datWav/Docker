all: build

build:
	docker build -t=datwav/redmine .

start:
	docker run --name redmine \
		--rm \
		--volumes-from=DATA_SCM \
		-e DB_NAME=openproject_production \
		-e DB_USER=openproject \
		-e DB_PASS=password \
		--link Mysql:db \
		-p 80:8080 \
		datwav/redmine

stop:
	docker stop redmine