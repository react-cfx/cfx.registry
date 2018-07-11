.PHONY: all
all: build rm deamon logs

pjName := cfx.registry
imgName := cfx/registry
dlName := download.cfx.registry

build:
	docker build -t ${imgName} .

rebuild:
	docker build --no-cache -t ${imgName} .

push:
	docker push ${imgName}

docker:
	docker run -ti \
		--rm \
		--name ${pjName} \
		-p 4000:3000 \
		-v $$(pwd):/cfx.registry/config \
		${imgName} \
		/bin/bash

deamon:
	docker run -d \
		--name ${pjName} \
		--restart always \
		-v $$(pwd):/cfx.registry \
		${imgName}

download:
	docker run -d \
		--name ${dlName} \
		--restart always \
		-p 5000:3000 \
		-v $$(pwd)/data:/srv \
		-v $$(pwd)/Caddyfile:/etc/Caddyfile \
		productionwentdown/caddy

in:
	docker exec \
		-ti \
		${pjName} \
		/bin/bash

rm:
	-docker rm -f ${pjName}

logs:
	docker logs -f ${pjName}
