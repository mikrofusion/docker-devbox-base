run: build
	docker run -d \
		--name "dev-env" \
		-p 0.0.0.0:33322:22 \
		-v /Users/mikrofusion/.ssh/id_rsa:/home/mikrofusion/.ssh/id_rsa \
		-v /Users/mikrofusion/.ssh/authorized_keys:/home/mikrofusion/.ssh/authorized_keys \
		-v /Users/mikrofusion/devbox:/home/mikrofusion/mount \
		dev-env

build:
	docker build -t dev-env .

rebuild:
	docker build --no-cache -t dev-env .

clean:
	docker kill dev-env
	docker rm dev-env

