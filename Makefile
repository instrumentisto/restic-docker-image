# This Makefile automates possible operations of this project.
#
# Images and description on Docker Hub will be automatically rebuilt on
# pushes to `master` branch of this repo and on updates of parent image.
#
# It's still possible to build, tag and push images manually. Just use:
#	make release


IMAGE_NAME := instrumentisto/restic
VERSION ?= 0.7.3-go1.9
TAGS ?= 0.7.3-go1.9,0.7.3,0.7,latest


comma := ,
empty :=
space := $(empty) $(empty)
eq = $(if $(or $(1),$(2)),$(and $(findstring $(1),$(2)),\
                                $(findstring $(2),$(1))),1)



# Build Docker image.
#
# Usage:
#	make image [no-cache=(yes|no)] [VERSION=]

no-cache-arg = $(if $(call eq,$(no-cache),yes),--no-cache,)

image:
	docker build $(no-cache-arg) -t $(IMAGE_NAME):$(VERSION) .



# Tag Docker image with given tags.
#
# Usage:
#	make tags [VERSION=] [TAGS=t1,t2,...]

tags:
	(set -e ; $(foreach tag, $(subst $(comma), ,$(TAGS)), \
		docker tag $(IMAGE_NAME):$(VERSION) $(IMAGE_NAME):$(tag) ; \
	))



# Manually push Docker images to Docker Hub.
#
# Usage:
#	make push [TAGS=t1,t2,...]

push:
	(set -e ; $(foreach tag, $(subst $(comma), ,$(TAGS)), \
		docker push $(IMAGE_NAME):$(tag) ; \
	))



# Make manual release of Docker images to Docker Hub.
#
# Usage:
#	make release [no-cache=(yes|no)] [VERSION=] [TAGS=t1,t2,...]

release: | image tags push



.PHONY: image tags push release
