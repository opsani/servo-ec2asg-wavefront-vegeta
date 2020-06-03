IMG_NAME ?= opsani/servo-ec2asg-wavefront-vegeta
IMG_TAG ?= latest
VER_TAG ?= 0.9.0

.PHONY: branch

branch: 
	$(eval BRANCH_TAG=$(shell git branch --show-current))

build: branch
	docker build . -t $(IMG_NAME):$(IMG_TAG) -t $(IMG_NAME):$(BRANCH_TAG) -t $(IMG_NAME):$(VER_TAG)

push: build
	docker push $(IMG_NAME):$(IMG_TAG)
	docker push $(IMG_NAME):$(BRANCH_TAG)

release: push
	docker push $(IMG_NAME):$(VER_TAG)
