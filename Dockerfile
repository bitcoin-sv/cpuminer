#
# Dockerfile for cpuminer
# usage: docker run creack/cpuminer --url xxxx --user xxxx --pass xxxx
# ex: docker run creack/cpuminer --url stratum+tcp://ltc.pool.com:80 --user creack.worker1 --pass abcdef
#
#

FROM            ubuntu:24.04
MAINTAINER      Guillaume J. Charmes <guillaume@charmes.net>

RUN             apt-get update -qq && \
                apt-get install -qqy automake libcurl4-openssl-dev make gcc

WORKDIR         /cpuminer
COPY            . .

RUN             ./autogen.sh && \
                ./configure CFLAGS="-O3" && \
                make

ENTRYPOINT      ["./minerd"]
