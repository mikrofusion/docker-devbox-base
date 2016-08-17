run: build
	docker run -d \
		--name "devbox-base" \
		-p 0.0.0.0:33322:22 \
		-v /Users/mikrofusion/.ssh/id_rsa:/home/mikrofusion/.ssh/id_rsa \
		-v /Users/mikrofusion/.ssh/authorized_keys:/home/mikrofusion/.ssh/authorized_keys \
		-v /Users/mikrofusion/devbox:/home/mikrofusion/mount \
		devbox-base

build:
	docker build -t devbox-base .

rebuild:
	docker build --no-cache -t devbox-base .

clean:
	docker kill devbox-base
	docker rm devbox-base
	docker rmi devbox-base

publish: rebuild push

push:
	docker tag devbox-base mikrofusion/docker-devbox-base
	docker push mikrofusion/docker-devbox-base

