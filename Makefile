DOCKER_REGISTRY=
DOCKER_IMAGE_TAG=docker-library-solr
DOCKER_FILE_TEMPLATE=Dockerfile.tpl

build:
	sed 's|%DOCKER_REGISTRY%|$(DOCKER_REGISTRY)|g' $(DOCKER_FILE_TEMPLATE) \
	| docker build \
		--build-arg HTTP_PROXY=$(HTTP_PROXY) \
		--build-arg HTTPS_PROXY=$(HTTP_PROXY) \
 		-t $(DOCKER_REGISTRY)$(DOCKER_IMAGE_TAG) -

install-gc:
	gcloud docker push $(DOCKER_REGISTRY)$(DOCKER_IMAGE_TAG)
