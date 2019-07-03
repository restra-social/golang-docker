FROM golang:1.12-alpine

#install Glide
RUN apk add --no-cache git curl openssh openssl tar gzip bash ca-certificates && \
    curl https://glide.sh/get | sh

# Install requirements
RUN apk add -U openssl curl tar gzip bash ca-certificates && \
  wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
  wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.29-r0/glibc-2.29-r0.apk && \
  apk add glibc-2.29-r0.apk && \
  rm glibc-2.29-r0.apk

# Install kubectl
RUN curl -L -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v1.8.0/bin/linux/amd64/kubectl && \
  chmod +x /usr/bin/kubectl && \
  kubectl version --client

#install docker
ENV DOCKER_VERSION 1.13.1

RUN curl https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz | tar -xvz && \
    mv docker/docker /usr/local/bin/docker && \
    chmod +x /usr/local/bin/docker && \
    rm -r docker

# Copy Kubectl Config
RUN mkdir -p /root/.kube/
COPY config /root/.kube/

# set the kubectl Config pass from gitlab to container
COPY set-env.sh /
RUN chmod +x /set-env.sh
ENTRYPOINT ["/set-env.sh"]
