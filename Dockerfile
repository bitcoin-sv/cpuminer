#
# Dockerfile for cpuminer
# 
# docker build -t image_name:tag .
# ex: docker build -t cpuminer:1.0 .
#
# usage:
#  docker run image_name:tag -a sha256d -o http://<bitcoin host>:<port> -O <rpcuser>:<rpcpass> --coinbase-addr=<address>
#  docker run image_name:tag --url xxxx --user xxxx --pass xxxx
#
# ex (direct):  docker run cpuminer:1.0 -a sha256d -o http://host.docker.internal:18332 -O bitcoin:bitcoin --coinbase-addr=mpXwg4jMtRhuSpVq4xS3HFHmCmWp9NyGKt
#
# ex (stratum): docker run cpuminer:1.0 --url stratum+tcp://bsv.svpool.com:3333 -a sha256d --user worker.1 --pass abcdef

#
# Usage: minerd [OPTIONS]
#Options:
#  -a, --algo=ALGO       specify the algorithm to use
#                          scrypt    scrypt(1024, 1, 1) (default)
#                          scrypt:N  scrypt(N, 1, 1)
#                          sha256d   SHA-256d
#  -o, --url=URL         URL of mining server
#  -O, --userpass=U:P    username:password pair for mining server
#  -u, --user=USERNAME   username for mining server
#  -p, --pass=PASSWORD   password for mining server
#      --cert=FILE       certificate for mining server using SSL
#  -x, --proxy=[PROTOCOL://]HOST[:PORT]  connect through a proxy
#  -t, --threads=N       number of miner threads (default: number of processors)
#  -r, --retries=N       number of times to retry if a network call fails
#                          (default: retry indefinitely)
#  -R, --retry-pause=N   time to pause between retries, in seconds (default: 30)
#  -T, --timeout=N       timeout for long polling, in seconds (default: none)
#  -s, --scantime=N      upper bound on time spent scanning current work when
#                          long polling is unavailable, in seconds (default: 5)
#      --coinbase-addr=ADDR  payout address for solo mining
#      --coinbase-sig=TEXT  data to insert in the coinbase when possible
#      --no-longpoll     disable long polling support
#      --no-getwork      disable getwork support
#      --no-gbt          disable getblocktemplate support
#      --no-gmc          disable getminingcandidate support
#      --no-stratum      disable X-Stratum support
#      --no-redirect     ignore requests to change the URL of the mining server
#  -q, --quiet           disable per-thread hashmeter output
#  -D, --debug           enable debug output
#  -P, --protocol-dump   verbose dump of protocol-level activities
#  -S, --syslog          use system log for output messages
#  -B, --background      run the miner in the background
#      --benchmark       run in offline benchmark mode
#  -c, --config=FILE     load a JSON-format configuration file
#  -V, --version         display version information and exit
#  -h, --help            display this help text and exit#

FROM            ubuntu:24.04

RUN             apt-get update -qq && \
                apt-get install -qqy \
                    automake \
                    gcc \
                    git \
                    libcurl4-openssl-dev \
                    make && \
                rm -rf /var/lib/apt/lists/* && \
                git clone https://github.com/bitcoin-sv/cpuminer && \
                cd cpuminer && \
                ./autogen.sh && \
                ./configure CFLAGS="-O3" && \
                make

WORKDIR         /cpuminer
ENTRYPOINT      ["./minerd"]
