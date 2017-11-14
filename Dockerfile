#
# Stage 'dist' creates restic distribution.
#

# https://hub.docker.com/_/golang
FROM golang:1.9-alpine AS dist

# Download and compile restic.
RUN apk add --update \
        curl \
    \
 && curl -fL -o /tmp/restic.tar.gz \
             https://github.com/restic/restic/releases/download/v0.7.3/restic-0.7.3.tar.gz \
 && tar -xzf /tmp/restic.tar.gz -C /tmp \
 && cd /tmp/restic-* \
    \
 && go run build.go \
    \
 && mkdir -p /out \
 && cp restic /out/




#
# Stage 'runtime' creates final Docker image to use in runtime.
#

# https://hub.docker.com/_/alpine
FROM alpine:3.6 AS runtime

MAINTAINER Instrumentisto Team <developer@instrumentisto.com>


# Install restic runtime dependencies.
RUN apk update \
 && apk upgrade \
 && apk add --no-cache \
        ca-certificates \
        fuse nfs-utils openssh \
 && update-ca-certificates \
 && rm -rf /var/cache/apk/*

# Install restic.
COPY --from=dist /out/restic /usr/local/bin/

# Prepare default restic env vars.
ENV RESTIC_REPOSITORY=/mnt/repo \
    RESTIC_PASSWORD=""


VOLUME /data

ENTRYPOINT ["/usr/local/bin/restic"]
