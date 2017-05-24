FROM ubuntu:16.04
MAINTAINER Jakob Borg <jakob@nym.se>

ENV GO_VERSION 1.8.2
ENV MIN_GO_VERSION 1.7.6

# Install required packages

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential openjdk-9-jdk-headless zip git mercurial graphviz \
        ca-certificates curl fakeroot rubygems ruby-dev rpm \
        snapcraft \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

RUN gem install fpm

# Install Go

RUN curl -sSL https://golang.org/dl/go${MIN_GO_VERSION}.linux-amd64.tar.gz \
        | tar -C /usr/local -xz && mv /usr/local/go /usr/local/oldgo

RUN curl -sSL https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz \
        | tar -C /usr/local -xz

# Use Go

ENV PATH /usr/local/go/bin:$PATH
ENV GOPATH /usr/local

# Fetch required utilities, from build.go setup()

RUN go get github.com/alecthomas/gometalinter \
	&& go get github.com/AlekSi/gocov-xml \
	&& go get github.com/axw/gocov/gocov \
	&& go get github.com/FiloSottile/gvt \
	&& go get github.com/golang/lint/golint \
	&& go get github.com/gordonklaus/ineffassign \
	&& go get github.com/mdempsky/unconvert \
	&& go get github.com/mitchellh/go-wordwrap \
	&& go get github.com/opennota/check/cmd/... \
	&& go get github.com/tsenart/deadcode \
	&& go get golang.org/x/net/html \
	&& go get golang.org/x/tools/cmd/cover \
	&& go get honnef.co/go/simple/cmd/gosimple \
	&& go get honnef.co/go/staticcheck/cmd/staticcheck \
	&& go get honnef.co/go/unused/cmd/unused

# Extra

RUN go get golang.org/x/tools/cmd/cover \
	&& go get golang.org/x/net/html \
	&& go get github.com/AlekSi/gocov-xml \
	&& go get github.com/tebeka/go2xunit

# Add a user for the builder and let it own the Go installation so it can
# build packages for cross compilation

RUN useradd --system -m -s /bin/bash buildslave
RUN chown -R buildslave /usr/local/go /usr/local/oldgo

# Add our slave running script

ADD runslave.sh /usr/local/bin/runslave

# USe the script as entry point

USER buildslave
WORKDIR /home/buildslave
ENTRYPOINT ["/usr/local/bin/runslave"]

