FROM golang:1.8.3-alpine

#install Glide

RUN apk add --no-cache git curl openssh ca-certificates\
&& curl https://glide.sh/get | sh

#install docker
ENV DOCKER_VERSION 1.13.1

RUN curl https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz | tar -xvz && \
    mv docker/docker /usr/local/bin/docker && \
    chmod +x /usr/local/bin/docker && \
rm -r docker