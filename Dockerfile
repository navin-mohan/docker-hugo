FROM ubuntu:16.04
COPY run.sh run.sh 
RUN snap install hugo  && \
    apt install -y git && \
    chmod +x run.sh
    