restic Docker Image
===================

[![GitHub release](https://img.shields.io/github/release/instrumentisto/restic-docker-image.svg)](https://hub.docker.com/r/instrumentisto/restic/tags) [![Build Status](https://travis-ci.org/instrumentisto/restic-docker-image.svg?branch=master)](https://travis-ci.org/instrumentisto/restic-docker-image) [![Docker Pulls](https://img.shields.io/docker/pulls/instrumentisto/restic.svg)](https://hub.docker.com/r/instrumentisto/restic)




## What is restic?

restic is a program that does backups right and was designed with the following principles in mind:
- __Easy:__ Doing backups should be a frictionless process, otherwise you might be tempted to skip it. Restic should be easy to configure and use, so that, in the event of a data loss, you can just restore it. Likewise, restoring data should not be complicated.
- __Fast:__ Backing up your data with restic should only be limited by your network or hard disk bandwidth so that you can backup your files every day. Nobody does backups if it takes too much time. Restoring backups should only transfer data that is needed for the files that are to be restored, so that this process is also fast.
- __Verifiable:__ Much more important than backup is restore, so restic enables you to easily verify that all data can be restored.
- __Secure:__ Restic uses cryptography to guarantee confidentiality and integrity of your data. The location the backup data is stored is assumed not to be a trusted environment (e.g. a shared space where others like system administrators are able to access your backups). Restic is built to secure your data against such attackers.
- __Efficient:__ With the growth of data, additional snapshots should only take the storage of the actual increment. Even more, duplicate data should be de-duplicated before it is actually written to the storage back end to save precious backup space.

restic supports the following backends for storing backups natively:
- [Local directory](https://restic.readthedocs.io/en/latest/manual.html#local)
- [sftp server (via SSH)](https://restic.readthedocs.io/en/latest/manual.html#sftp)
- [HTTP REST server](https://restic.readthedocs.io/en/latest/manual.html#rest-server) ([protocol](https://github.com/restic/restic/blob/master/doc/rest_backend.rst), [rest-server](https://github.com/restic/rest-server))
- [AWS S3](https://restic.readthedocs.io/en/latest/manual.html#amazon-s3) (either from Amazon or using the [Minio](https://minio.io) server)
- [OpenStack Swift](https://restic.readthedocs.io/en/latest/manual.html#openstack-swift)
- [BackBlaze B2](https://restic.readthedocs.io/en/latest/manual.html#backblaze-b2)
- [Microsoft Azure Blob Storage](https://restic.readthedocs.io/en/latest/manual.html#microsoft-azure-blob-storage)
- [Google Cloud Storage](https://restic.readthedocs.io/en/latest/manual.html#google-cloud-storage)


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
    instrumentisto/restic backup /data
```




## Image versions


### `latest`

Latest version of restic.


### `X`

Latest version of restic `X` branch.


### `X.Y`

Latest version of restic `X.Y` branch.


### `X.Y.Z`

Concrete `X.Y.Z` version of restic.




## License

restic itself is licensed under [BSD 2-Clause license][91].

restic Docker image is licensed under [MIT license][92].




## Issues

We can't notice comments in the DockerHub, so don't use them for reporting issue or asking question.

If you have any problems with or questions about this image, please contact us through a [GitHub issue][10].





[10]: https://github.com/instrumentisto/restic-docker-image/issues
[91]: https://github.com/restic/restic/blob/master/LICENSE
[92]: https://github.com/instrumentisto/restic-docker-image/blob/master/LICENSE.md
