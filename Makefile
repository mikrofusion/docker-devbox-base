run: build
	docker-compose up

build:
	docker build -t $(USER)/docker-devbox-base --build-arg user=$(USER) .

rebuild:
	docker build --no-cache -t $(USER)/docker-devbox-base --pull=true --build-arg user=$(USER) .

clean:
	docker kill $(USER)/docker-devbox-base
	docker rm $(USER)/docker-devbox-base
	docker rmi $(USER)/docker-devbox-base

push:
	docker push $(USER)/docker-devbox-base

publish: rebuild push
