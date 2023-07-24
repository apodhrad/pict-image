override IMAGE := pict:latest

build:
	@podman build --layers=true -t $(IMAGE) .

run-bash:
	@podman run -it --rm --entrypoint bash $(IMAGE)

run-example:
	@podman run -it --rm -v ./models:/var/pict:Z $(IMAGE) example.txt
