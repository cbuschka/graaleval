build:
	docker build -t graaleval:latest .
	docker run --rm --name graaleval -u $(shell id -u):$(shell id -g) -v $(shell pwd):/work:Z graaleval:latest ./build.sh
