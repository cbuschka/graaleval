build:
	docker build -t graaleval:latest .
	docker run -u $(shell id -u):$(shell id -g) $(shell pwd):/work 
