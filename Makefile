pjName := cfx.micro-seed

docker:
	docker run \
		--name ${pjName} \
		--rm \
		-ti \
		-p 3030:3000 \
		-v $$(pwd):/root/${pjName} \
		mooxe/node \
		/bin/bash

in:
	docker exec \
		-ti \
		${pjName} \
		/bin/bash
