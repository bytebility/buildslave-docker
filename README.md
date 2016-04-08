Docker Build Slave
==================

This is a build slave docker image. It is used to provide build capabilities to
the main Jenkins server. To run this you must have been assigned a `slave ID`
and a `slave secret`. With those in place, run:

```
./build.sh docker-all
```

> This uses a temporary container with the image from above and a volume
> mapped to the directory containing the source. Tests are run and
> binary packages created.

```bash
SLAVE_ID="some-slave-id"
SLAVE_SECRET="a long secret string"
docker run -h "${SLAVE_ID}.syncthing.net" --restart=always syncthing/buildslave "$SLAVE_ID" "$SLAVE_SECRET"
```

The image should download, start up, and output something similar to:

```
...
INFO: Trying protocol: JNLP2-connect
Apr 08, 2016 9:05:56 AM hudson.remoting.jnlp.Main$CuiListener status
INFO: Connected
```
