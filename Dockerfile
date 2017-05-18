
FROM debian:8
MAINTAINER "Gerard Hickey <hickey@kinetic-compute.com>"

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y build-essential autoconf git libncurses5-dev libncursesw5-dev groff && \
    groupadd empire && useradd -g empire -d /empire -c 'Empire Deity' deity && \
    cd /tmp && git clone https://github.com/hickey/empserver.git && \
    cd empserver && ./bootstrap && \
    CFLAGS='-Wmaybe-uninitialized' ./configure --prefix /empire && make && make install && \
    rm -rf /tmp/empserver && chown -R deity:empire /empire/var /empire/etc/empire && \
    cp -a /empire/etc/empire /empire/etc/empire-dist
    
ADD README.md /empire
ADD entrypoint.sh /
ADD bashrc /empire/.bashrc

USER deity
WORKDIR /empire
ENTRYPOINT ["/entrypoint.sh"]

