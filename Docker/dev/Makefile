pjName := cfx.registry
imgName := cfx/registry:dev

build:
	docker build -t ${imgName} .

rebuild:
	docker build --no-cache -t ${imgName} .

push:
	docker push ${imgName}

rm:
	docker rm -f ${pjName}

docker:
	docker run \
		--name ${pjName} \
		--rm \
		-ti \
		-p 4000:3000 \
		${imgName} \
		/bin/bash

deamon:
	docker run -d \
		--name ${pjName} \
		--restart always \
		-p 4000:3000 \
		${imgName} \
		/bin/bash -lc " \
			cd /root/${pjName} && \
			yarn start \
		"

in:
	docker exec \
		-ti \
		${pjName} \
		/bin/bash
