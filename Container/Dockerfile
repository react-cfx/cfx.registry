FROM mooxe/node

MAINTAINER FooTearth "footearth@gmail.com"

# update
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get autoremove -y

WORKDIR /root

RUN git clone -b 0.0.8 https://github.com/react-cfx/cfx.registry.git --depth 1

WORKDIR /root/cfx.registry

# RUN git checkout -b 0.0.8

RUN bash -lc 'yarn'

WORKDIR /root/cfx.registry/Container/config

ENTRYPOINT [ "/bin/bash", "-lc" ]
CMD [ "/root/cfx.registry/bin/index.coffee" ]
