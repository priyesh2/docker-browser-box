[![Docker Repository on Quay.io](https://quay.io/repository/sameersbn/browser-box/status "Docker Repository on Quay.io")](https://quay.io/repository/sameersbn/browser-box)

# sameersbn/browser-box:2018.07.21

- [Introduction](#introduction)
  - [Contributing](#contributing)
  - [Issues](#issues)
- [Getting started](#getting-started)
  - [Installation](#installation)
  - [Use Cases](#use-case)
  - [How it works](#how-it-works)
- [Maintenance](#maintenance)
  - [Upgrading](#upgrading)
  - [Uninstallation](#uninstallation)
  - [Shell Access](#shell-access)
- [References](#references)

# Introduction

`Dockerfile` to create a [Docker](https://www.docker.com/) container image consisting of the following web browsers:

 - chromium-browser
 - firefox
 - google-chrome
 - tor-browser

The image uses [X11](http://www.x.org) and [Pulseaudio](http://www.freedesktop.org/wiki/Software/PulseAudio/) unix domain sockets on the host to enable audio/video support in the web browsers. These components are available out of the box on pretty much any modern linux distribution.

![browser](https://cloud.githubusercontent.com/assets/410147/4377777/2ccda3d2-4352-11e4-9314-122e4f58a30c.gif)

## Contributing

If you find this image useful here's how you can help:

- Send a pull request with your awesome features and bug fixes
- Help users resolve their [issues](../../issues?q=is%3Aopen+is%3Aissue).
- Support the development of this image with a [donation](http://www.damagehead.com/donate/)

## Issues

Before reporting your issue please try updating Docker to the latest version and check if it resolves the issue. Refer to the Docker [installation guide](https://docs.docker.com/installation) for instructions.

SELinux users should try disabling SELinux using the command `setenforce 0` to see if it resolves the issue.

If the above recommendations do not help then [report your issue](../../issues/new) along with the following information:

- Output of the `docker version` and `docker info` commands
- The `docker run` command or `docker-compose.yml` used to start the image. Mask out the sensitive bits.
- Please state if you are using [Boot2Docker](http://www.boot2docker.io), [VirtualBox](https://www.virtualbox.org), etc.

# Getting started

## Installation

Automated builds of the image are available on [Dockerhub](https://hub.docker.com/r/sameersbn/browser-box) and is the recommended method of installation.

> **Note**: Builds are also available on [Quay.io](https://quay.io/repository/sameersbn/browser-box)

```bash
docker pull sameersbn/browser-box:2018.07.21
```

Alternatively you can build the image yourself.

```bash
docker build -t sameersbn/browser-box github.com/sameersbn/docker-browser-box
```

With the image locally available, install the wrapper scripts using:

```bash
docker run -it --rm \
  --volume /usr/local/bin:/target \
    cerebro46/browser install
```

If you want the settings for chrome and firefox to persist
after each time the browser is launched then you will need to add additional environment variable to the install command. In the example below "username" needs to get replace with your login user name.

```bash
docker run -it --rm \
  --volume /usr/local/bin:/target \
  --env CHROME_USERDATA=/home/username/.chrome \
  --env FIREFOX_USERDATA=/home/username/.mozillia \
    cerebro46/browser install
```


This will install wrapper scripts to launch:

- `chromium-browser`
- `firefox`
- `google-chrome, google-chrome-stable`
- `tor-browser`

> **Note**
>
> If the browser being launched is installed on the the host then the host binary is launched instead of starting a Docker container. To force the launch of a browser in a container use the `browser-bundle` script. For example, `browser-bundle firefox` will launch the Firefox browser inside a Docker container regardless of whether it is installed on the host or not.

## Use Cases

- Protect your anonymity on the internet (tor-browser)
- Access websites your ISP has blocked (tor-browser)
- Protection from Adobe Flash vulnerabilities
- Guest access

## How it works

The wrapper scripts volume mount the X11 and pulseaudio sockets in the launcher container. The X11 socket allows for the user interface display on the host, while the pulseaudio socket allows for the audio output to be rendered on the host.

# Maintenance

## Upgrading

To upgrade to newer releases:

  1. Download the updated Docker image:

  ```bash
  docker pull sameersbn/browser-box:2018.07.21
  ```

  2. Run `install` to make sure the host scripts are updated.

  ```bash
  docker run -it --rm \
    --volume /usr/local/bin:/target \
    cerebro46/browser install
  ```

## Uninstallation

```bash
docker run -it --rm \
  --volume /usr/local/bin:/target \
  cerebro46/browser uninstall
```

## Shell Access

For debugging and maintenance purposes you may want access the containers shell. If you are using Docker version `1.3.0` or higher you can access a running containers shell by starting `bash` using `docker exec`:

```bash
docker exec -it browser-box bash
```

# References

- http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/
