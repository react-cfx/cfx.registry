pjName := cfx.registry

devdocker:
	docker run \
		--name ${pjName} \
		--rm \
		-ti \
		-p 4000:3000 \
		-v $$(pwd):/root/${pjName} \
		mooxe/node \
		/bin/bash
	
devdeamon:
	docker run -d \
		--name ${pjName} \
		--restart always \
		-p 4000:3000 \
		-v $$(pwd):/root/${pjName} \
		mooxe/node \
		/bin/bash -lc "cd /root/${pjName} && yarn dev"

build:
	docker build -t cfx/registry .

rebuild:
	docker build --no-cache -t cfx/registry .

push:
	docker push cfx/registry

rm:
	docker rm -f ${pjName}

docker:
	docker run \
		--name ${pjName} \
		--rm \
		-ti \
		-p 4000:3000 \
		cfx/registry \
		/bin/bash

deamon:
	docker run -d \
		--name ${pjName} \
		--restart always \
		-p 4000:3000 \
		-v $$(pwd):/root/${pjName} \
		mooxe/node \
		/bin/bash -lc "cd /root/${pjName} && yarn start"

in:
	docker exec \
		-ti \
		${pjName} \
		/bin/bash
