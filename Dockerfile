FROM ubuntu:16.04
COPY run.sh run.sh 
RUN apt install -y git

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

COPY run.sh run.sh


