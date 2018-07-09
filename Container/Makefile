.PHONY: all
all: build rm deamon logs

pjName := cfx.registry
imgName := cfx/registry

build:
	docker build -t ${imgName} .

rebuild:
	docker build --no-cache -t ${imgName} .

push:
	docker push ${imgName}

docker:
	docker run \
		--name ${pjName} \
		--rm \
		-p 4000:3000 \
		${imgName} "yarn dev"

deamon:
	docker run -d \
		--name ${pjName} \
		--restart always \
		-p 4000:3000 \
		${imgName}

in:
	docker exec \
		-ti \
		${pjName} \
		/bin/bash

rm:
	-docker rm -f ${pjName}

logs:
	docker logs -f ${pjName}
