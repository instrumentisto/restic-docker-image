restic Docker Image
===================

[![Release](https://img.shields.io/github/v/release/instrumentisto/restic-docker-image "Release")](https://github.com/instrumentisto/restic-docker-image/releases)
[![CI](https://github.com/instrumentisto/restic-docker-image/workflows/CI/badge.svg?branch=main "CI")](https://github.com/instrumentisto/restic-docker-image/actions?query=workflow%3ACI+branch%3Amain)
[![Docker Hub](https://img.shields.io/docker/pulls/instrumentisto/restic?label=Docker%20Hub%20pulls "Docker Hub pulls")](https://hub.docker.com/r/instrumentisto/restic)

[Docker Hub](https://hub.docker.com/r/instrumentisto/restic)
| [GitHub Container Registry](https://github.com/orgs/instrumentisto/packages/container/package/restic)
| [Quay.io](https://quay.io/repository/instrumentisto/restic)

[Changelog](https://github.com/instrumentisto/restic-docker-image/blob/main/CHANGELOG.md)




## Supported tags and respective `Dockerfile` links

- [`0.17.0-r0`, `0.17.0`, `0.17`, `latest`][201]




## What is restic?

restic is a program that does backups right and was designed with the following principles in mind:
- __Easy:__ Doing backups should be a frictionless process, otherwise you might be tempted to skip it. Restic should be easy to configure and use, so that, in the event of a data loss, you can just restore it. Likewise, restoring data should not be complicated.
- __Fast:__ Backing up your data with restic should only be limited by your network or hard disk bandwidth so that you can backup your files every day. Nobody does backups if it takes too much time. Restoring backups should only transfer data that is needed for the files that are to be restored, so that this process is also fast.
- __Verifiable:__ Much more important than backup is restore, so restic enables you to easily verify that all data can be restored.
- __Secure:__ Restic uses cryptography to guarantee confidentiality and integrity of your data. The location the backup data is stored is assumed not to be a trusted environment (e.g. a shared space where others like system administrators are able to access your backups). Restic is built to secure your data against such attackers.
- __Efficient:__ With the growth of data, additional snapshots should only take the storage of the actual increment. Even more, duplicate data should be de-duplicated before it is actually written to the storage back end to save precious backup space.

restic supports the following backends for storing backups natively:
- [Local directory](https://restic.readthedocs.io/en/stable/030_preparing_a_new_repo.html#local)
- [sftp server (via SSH)](https://restic.readthedocs.io/en/stable/030_preparing_a_new_repo.html#sftp)
- [HTTP REST server](https://restic.readthedocs.io/en/stable/030_preparing_a_new_repo.html#rest-server) ([protocol](https://github.com/restic/restic/blob/master/doc/REST_backend.rst), [rest-server](https://github.com/restic/rest-server))
- [AWS S3](https://restic.readthedocs.io/en/stable/030_preparing_a_new_repo.html#amazon-s3) (either from Amazon or using the [Minio](https://minio.io) server)
- [OpenStack Swift](https://restic.readthedocs.io/en/stable/030_preparing_a_new_repo.html#openstack-swift)
- [BackBlaze B2](https://restic.readthedocs.io/en/stable/030_preparing_a_new_repo.html#backblaze-b2)
- [Microsoft Azure Blob Storage](https://restic.readthedocs.io/en/stable/030_preparing_a_new_repo.html#microsoft-azure-blob-storage)
- [Google Cloud Storage](https://restic.readthedocs.io/en/stable/030_preparing_a_new_repo.html#google-cloud-storage)
- And many other services via the [rclone](https://rclone.org) [Backend](https://restic.readthedocs.io/en/stable/030_preparing_a_new_repo.html#other-services-via-rclone)

> [restic.net](https://restic.net)

> [restic.readthedocs.io](https://restic.readthedocs.io/en/latest)

![restic Logo](http://restic.readthedocs.io/en/latest/_static/logo.png)




## How to use this image

Mount your data, specify your credentials, and provide the `restic` command you require:
```bash
docker run --rm -v $(pwd):/data \
           -e RESTIC_REPOSITORY=s3:s3.amazonaws.com/bucket_name \
           -e RESTIC_PASSWORD=my-secure-password \
           -e AWS_ACCESS_KEY_ID=my-aws-access-key \
           -e AWS_SECRET_ACCESS_KEY=my-aws-secret-key \
    instrumentisto/restic backup --host myHost /data
```

> __NOTE__: restic snapshots are tied to the hostname of your devices that are backed up. In case of using Docker, the host name is generate randomly every time you start a new container. Therefore, it's important to use the `--host myHost` parameter, otherwise the backups take much longer time, because the repository is scanned completely.


### With `rclone`

First, generate `rclone` config file:
```bash
docker run --rm -it -v rclone-config:/config/rclone rclone/rclone config
```

Then, mount it a volume:
```bash
docker run --rm -v $(pwd):/data \
           -v rclone-config:/root/.config/rclone \
           -e RESTIC_REPOSITORY=rclone:rclone-respository-name:folder-path \
           -e RESTIC_PASSWORD=my-secure-password \
       instrumentisto/restic backup --host myHost /data
```




## Image tags

This image is based on the popular [Alpine Linux project][1], available in [the alpine official image][2]. [Alpine Linux][1] is much smaller than most distribution base images (~5MB), and thus leads to much slimmer images in general.

This variant is highly recommended when final image size being as small as possible is desired. The main caveat to note is that it does use [musl libc][4] instead of [glibc and friends][5], so certain software might run into issues depending on the depth of their libc requirements. However, most software doesn't have an issue with this, so this variant is usually a very safe choice. See [this Hacker News comment thread][6] for more discussion of the issues that might arise and some pro/con comparisons of using [Alpine][1]-based images.


### `<X>`

Latest tag of the latest major `X` restic version.


### `<X.Y>`

Latest tag of the latest minor `X.Y` restic version.


### `<X.Y.Z>`

Latest tag of the concrete `X.Y.Z` restic version.


### `<X.Y.Z>-r<N>`

Concrete `N` image revision tag of the concrete `X.Y.Z` restic version.

Once built, it's never updated.




## License

restic is licensed under [BSD 2-Clause license][93].

As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.

The [sources][92] for producing `instrumentisto/restic` Docker images are licensed under [Blue Oak Model License 1.0.0][91].




## Issues

We can't notice comments in the [DockerHub] (or other container registries) so don't use them for reporting issue or asking question.

If you have any problems with or questions about this image, please contact us through a [GitHub issue][90].




[DockerHub]: https://hub.docker.com

[1]: http://alpinelinux.org
[2]: https://hub.docker.com/_/alpine
[4]: http://www.musl-libc.org
[5]: http://www.etalabs.net/compare_libcs.html
[6]: https://news.ycombinator.com/item?id=10782897

[90]: https://github.com/instrumentisto/restic-docker-image/issues
[91]: https://github.com/instrumentisto/restic-docker-image/blob/main/LICENSE.md
[92]: https://github.com/instrumentisto/restic-docker-image
[93]: https://github.com/restic/restic/blob/master/LICENSE

[201]: https://github.com/instrumentisto/restic-docker-image/blob/main/Dockerfile
