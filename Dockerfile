FROM golang:1.15.3-alpine3.12

ENV SIMPLEGENEREATOR_VERSION=1.0.1
ENV SPECTOOLS_VERSION=1.24.1
ENV GATEWAY_VERSION=2.0.1
ENV GEN_GO_VERSION=1.25.0
ENV GEN_GO_GRPC_VERSION=1.0.0
ENV SIMPLEGENERATOR_VERSION=1.0.1
ENV FUROC_VERSION=0.3.0
ENV YQ_VERSION=3.4.1
ENV GOBIN $GOPATH/bin
ENV PATH="$PATH:$GOPATH/bin"
ENV PATH="/usr/local/sbin:$PATH"
ENV PS1="\e[0;34mフロー BEC \t# \e[m "
ENV GOPRIVATE=github.com/theNorstroem

RUN apk add --no-cache bash git curl wget ca-certificates openssh jq

# install protoc
RUN set -eux; \
    curl -L https://github.com/protocolbuffers/protobuf/releases/download/v3.13.0/protoc-3.13.0-linux-x86_64.zip -o /tmp/protoc.zip; \
    unzip /tmp/protoc.zip -d /usr/local; \
    # install glibc for alpine
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub; \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.32-r0/glibc-2.32-r0.apk; \
    apk add glibc-2.32-r0.apk; \
    rm -rf /tmp/*

# install the tools
RUN set -eux; \
    GO111MODULE=on go get \
       github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway@v$GATEWAY_VERSION \
       github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2@v$GATEWAY_VERSION \
       google.golang.org/protobuf/cmd/protoc-gen-go@v$GEN_GO_VERSION \
       google.golang.org/grpc/cmd/protoc-gen-go-grpc@v$GEN_GO_GRPC_VERSION \
       github.com/theNorstroem/simple-generator@v$SIMPLEGENEREATOR_VERSION \
       github.com/theNorstroem/spectools@v$SPECTOOLS_VERSION \
       github.com/theNorstroem/furoc@v$FUROC_VERSION  \
       github.com/mikefarah/yq/v3@$YQ_VERSION; \
    rm -rf /go/pkg; \
    rm -rf /root/.cache/*

WORKDIR /specs/
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["bash"]