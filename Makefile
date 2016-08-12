run: build
	docker run -d \
		--name "dev-env" \
		-p 0.0.0.0:33333:22 \
		dev-env

build:
	docker build -t dev-env .

re-build:
	docker build --no-cache -t dev-env .

clean:
	docker kill dev-env
	docker rm dev-env

