
FROM debian:8
MAINTAINER "Gerard Hickey <hickey@kinetic-compute.com>"

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y build-essential autoconf git libncurses5-dev libncursesw5-dev groff && \
    cd /tmp && git clone https://github.com/hickey/empserver.git && \
    cd empserver && ./bootstrap && \
    CFLAGS='-Wmaybe-uninitialized' ./configure --prefix /empire && make && make install


