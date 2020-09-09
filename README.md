# PHP 7.3 Clear Linux - Docker image

[![Latest Version](https://img.shields.io/github/v/release/kiwfy/php73-clear-linux.svg?style=flat-square)](https://github.com/kiwfy/php73-clear-linux/releases)
[![Build Status](https://img.shields.io/github/workflow/status/kiwfy/php73-clear-linux/CI?label=ci%20build&style=flat-square)](https://github.com/kiwfy/php73-clear-linux/actions?query=workflow%3ACI)
![Code Size](https://img.shields.io/github/languages/code-size/kiwfy/php73-clear-linux?style=flat-square)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

Docker image with PHP 7.3 using Clear Linux S.O

### How to use this image

Requires [Docker](https://www.docker.com/get-started).

Before get the image is necessary [authenticate](https://docs.github.com/pt/packages/using-github-packages-with-your-projects-ecosystem/configuring-docker-for-use-with-github-packages) in Github Package

You can run the container and service like so:

```sh
docker run -d docker.pkg.github.com/kiwfy/php73-clear-linux/php73-clear-linux:latest
```

### Docker with compose tool

It's a good way to use [docker-compose](https://docs.docker.com/compose/). Example:

```
version: '3.7'
services:
    php:
        image: docker.pkg.github.com/kiwfy/php73-clear-linux/php73-clear-linux:latest
        container_name: php
        volumes:
            - ./:/var/www/html
```
### Get latest version

To found and verify what is latest image look at [Clear Linux CDN](https://cdn.download.clearlinux.org/latest)

### Development

Want to contribute? Great!

Make a change in image and be careful with your updates!

**Kiwfy - Open your code, open your mind!**
