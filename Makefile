REGISTRY?=registry.devshift.net
REPOSITORY?=bayesian/data-model-importer
DEFAULT_TAG=latest

ifeq ($(TARGET), rhel)
    DOCKERFILE := Dockerfile.data-model.rhel
else
    DOCKERFILE := Dockerfile.data-model
endif

.PHONY: all docker-build fast-docker-build test get-image-name get-image-repository

all: fast-docker-build

docker-build:
	docker build --no-cache -t $(REGISTRY)/$(REPOSITORY):$(DEFAULT_TAG) -f $(DOCKERFILE) .

fast-docker-build:
	docker build -t $(REGISTRY)/$(REPOSITORY):$(DEFAULT_TAG) -f $(DOCKERFILE) .

test:
	./runtests.sh

get-image-name:
	@echo $(REGISTRY)/$(REPOSITORY):$(DEFAULT_TAG)

get-image-repository:
	@echo $(REPOSITORY)

