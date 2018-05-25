#
# Stage 'dist' creates restic distribution.
#

# https://hub.docker.com/_/golang
FROM golang:1.9-alpine AS dist


# Install build tools.
RUN apk add --update --no-cache curl git

# Prepare dirs for export.
RUN mkdir -p /out/usr/local/bin/ \
             /out/usr/share/licenses/restic/ \
             /out/usr/share/licenses/rclone/

# Download and build rclone.
RUN go get -u -v gopkg.in/ncw/rclone.v1 \
 && cp /go/bin/rclone.v1 /out/usr/local/bin/rclone \
 && cp /go/src/gopkg.in/ncw/rclone.v1/COPYING /out/usr/share/licenses/rclone/

# Download restic.
RUN curl -fL -o /tmp/restic.tar.gz \
         https://github.com/restic/restic/releases/download/v0.9.0/restic-0.9.0.tar.gz \
 && tar -xzf /tmp/restic.tar.gz -C /tmp

# Build restic.
RUN cd /tmp/restic-* \
 && go run build.go \
 && cp restic /out/usr/local/bin/ \
 && cp LICENSE /out/usr/share/licenses/restic/




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
COPY --from=dist /out/ /

# Prepare default restic env vars.
ENV RESTIC_REPOSITORY=/mnt/repo \
    RESTIC_PASSWORD=""


VOLUME /data

ENTRYPOINT ["/usr/local/bin/restic"]
