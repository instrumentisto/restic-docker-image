#
# Stage 'dist' creates restic distribution.
#

# https://hub.docker.com/_/golang
FROM golang:1.9-alpine AS dist


RUN apk add --update curl git

# Download and build rclone.
RUN go get -u -v gopkg.in/ncw/rclone.v1 \
 && mv /go/bin/rclone.v1 /go/bin/rclone

# Download restic.
RUN curl -fL -o /tmp/restic.tar.gz \
             https://github.com/restic/restic/releases/download/v0.9.0/restic-0.9.0.tar.gz \
 && tar -xzf /tmp/restic.tar.gz -C /tmp

# Build restic.
RUN mkdir -p /out \
 && cd /tmp/restic-* \
 && go run build.go \
 && cp restic LICENSE /out/




#
# Stage 'runtime' creates final Docker image to use in runtime.
#

# https://hub.docker.com/_/alpine
FROM alpine:3.7 AS runtime

MAINTAINER Instrumentisto Team <developer@instrumentisto.com>


# Install restic runtime dependencies and upgrade existing packages.
RUN apk update \
 && apk upgrade \
 && apk add --no-cache \
        ca-certificates \
        fuse \
        openssh \
 && update-ca-certificates \
 && rm -rf /var/cache/apk/*

# Install restic and rclone.
COPY --from=dist /out/restic /usr/local/bin/ \
     /go/bin/rclone /usr/local/bin/

COPY --from=dist /out/LICENSE /usr/share/licenses/restic/
COPY --from=dist /go/src/gopkg.in/ncw/rclone.v1/COPYING /usr/share/licenses/rclone/

# Prepare default restic env vars.
ENV RESTIC_REPOSITORY=/mnt/repo \
    RESTIC_PASSWORD=""


VOLUME /data

ENTRYPOINT ["/usr/local/bin/restic"]
