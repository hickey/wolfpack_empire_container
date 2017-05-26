
FROM debian:8
MAINTAINER "Gerard Hickey <hickey@kinetic-compute.com>"

RUN set -x && apt-get update && apt-get upgrade -y && \
    apt-get install -y build-essential autoconf git libncurses5-dev libncursesw5-dev libreadline-dev groff && \
    groupadd empire && useradd -g empire -d /empire -c 'Empire Deity' deity && \
    cd /tmp && git clone https://github.com/hickey/empserver.git && \
    cd empserver && ./bootstrap && \
    CFLAGS='-Wmaybe-uninitialized' ./configure --prefix /empire && make && make install && \
    rm -rf /tmp/empserver && chown -R deity:empire /empire/var /empire/etc/empire && \
    cp -a /empire/etc/empire /empire/etc/empire-dist && \
    cd /tmp && git clone https://github.com/hickey/empire_clients.git && \
    ls -l  &&  ls -l empire_clients && \
    cd empire_clients/Empire-0.122 && perl Makefile.PL && make install && \
    cd ../pei2 && make && mv example.peirc /empire && mv INSTALL /empire/README.pei2 && \
    mv pei highlight *.pl help.* /empire/bin && \
    cd ../pei3 && mv pei3 /empire/bin && mv example.pei3rc /empire && \
    mv README /empire/README.pei3 && rm -rf /tmp/empire_clients && \
    chown -R deity:empire /empire
    #cd ../eif && ./configure --prefix /empire && CFLAGS='-Wdeprecated-declarations' make install && \

ADD README.md /empire
ADD entrypoint.sh /
ADD bashrc /empire/.bashrc

USER deity
WORKDIR /empire
ENTRYPOINT ["/entrypoint.sh"]

