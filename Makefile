pjName := cfx.registry

docker:
	docker run \
		--name ${pjName} \
		--rm \
		-ti \
		-p 4000:3000 \
		-v $$(pwd):/root/${pjName} \
		mooxe/node \
		/bin/bash
	
rm:
	docker rm -f ${pjName}

in:
	docker exec \
		-ti \
		${pjName} \
		/bin/bash
