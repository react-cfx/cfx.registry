pjName := cfx.registry
dlName := download.${pjName}

registry:
	docker run -ti --rm \
		--name ${pjName} \
		-p 4000:3000 \
		-v $$(pwd):/root/${pjName} \
		mooxe/node \
		/bin/bash

docker: registry

download:
	docker run -ti --rm \
		--name ${dlName} \
		-p 5000:80 \
		-v $$(pwd):/root/${pjName} \
		mooxe/node \
		/bin/bash
	
rmRegistry:
	docker rm -f ${pjName}

inRegistry:
	docker exec \
		-ti \
		${pjName} \
		/bin/bash

rmDownload:
	docker rm -f ${dlName}

inDownload:
	docker exec \
		-ti \
		${dlName} \
		/bin/bash

rm: rmRegistry rmDownload

clean:
	rm -rf ./Container/data ./Container/log
	mkdir -p ./Container/data
	mkdir -p ./Container/log
