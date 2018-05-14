FROM ubuntu:16.04
COPY run.sh run.sh 
RUN apt-get update \
    && apt-get install git wget curl -y

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

COPY run.sh /usr/local/bin/


