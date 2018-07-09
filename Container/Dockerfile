FROM mooxe/node

MAINTAINER FooTearth "footearth@gmail.com"

# update
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get autoremove -y

RUN /bin/bash -lc "yarn global add cfx.registry" && \
    mkdir -p /root/cfx.registy

WORKDIR /root/cfx.registry

ENTRYPOINT [ "/bin/bash", "-lc" ]
CMD [ "yarn --cwd $(yarn global dir) registry" ]
