# omnibus_base_ubuntu14

https://hub.docker.com/r/opsrock/omnibus_base_ubuntu14/

## Omnibus by Docker Bros.

- https://github.com/OpsRockin/omnibus_base_ubuntu14
- https://github.com/OpsRockin/omnibus_base_centos6

### Auto build policies

build via IFTTT.

- gem omnibus master branch updated.
- gem omnibus-software master branch updated.
- cookbook omnibus new version released.


## Usage

First, create empty `Dockerfile` for your omnibus-project.

for `*.deb`, `Dockerfile.ubuntu1404`.

```
FROM opsrock/omnibus_base_ubuntu14
MAINTAINER you
```

for `*.rpm`, `Dockerfile.centos6`.

```
FROM opsrock/omnibus_base_centos6
MAINTAINER you
```

## Build once to execute ONBUILD

```
## DEB
$ docker build -t omnibus_myproject-ubuntu1404 -f Dockerfile.ubuntu1404 .

## RPM
$ docker build -t omnibus_myproject-centos6 -f Dockerfile.centos6 .
```

## Run to create package!

Run with passing your project name via env `OMNIBUS_PROJECT`.

```
## DEB
$ docker run -e OMNIBUS_PROJECT=serverspec -v pkg:/home/omnibus/omnibus-project/pkg omnibus_myproject-ubuntu1404

## RPM
$ docker run -e OMNIBUS_PROJECT=serverspec -v pkg:/home/omnibus/omnibus-project/pkg omnibus_myproject-centos6
```

Packages will be created in `./pkg/` directory.
