.PHONY: all
all: build rm deamon logs

pjName := cfx.registry
imgName := mooxe/${pjName}
dlName := download.${pjName}

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
		${imgName} \
		/bin/bash

deamon:
	docker run -d \
		--name ${pjName} \
		--restart always \
		-v $$(pwd)/data:/root/cfx.registry/Container/data \
		${imgName}

download:
	docker run -d \
		--name ${dlName} \
		--restart always \
		-p 5000:80 \
		-v $$(pwd)/data:/srv \
		-v $$(pwd)/Caddyfile:/etc/Caddyfile \
		-v $$(pwd)/log:/var/log/caddy \
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
