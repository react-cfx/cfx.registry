FROM mooxe/node

MAINTAINER FooTearth "footearth@gmail.com"

WORKDIR /root

# update
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get autoremove -y

RUN git clone https://github.com/react-cfx/cfx.registry.git && \
    cd /root/cfx.registry && bash -lc 'yarn && yarn rebuild'
