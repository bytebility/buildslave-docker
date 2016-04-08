Docker Build Slave
==================

This is a build slave docker image. It is used to provide build capabilities to
the main Jenkins server. To run this you must have been assigned a `slave ID`
and a `slave secret`. With those in place, run:

```bash
SLAVE_ID="some-slave-id"
SLAVE_SECRET="a long secret string"
docker run -h "${SLAVE_ID}.syncthing.net" syncthing/buildslave "$SLAVE_ID" "$SLAVE_SECRET"
```

The image should download, start up, and output something similar to:

```
...
INFO: Trying protocol: JNLP2-connect
Apr 08, 2016 9:05:56 AM hudson.remoting.jnlp.Main$CuiListener status
INFO: Connected
```

To run the build slave in the background and let it start up with the host, run:

```bash
SLAVE_ID="some-slave-id"
SLAVE_SECRET="a long secret string"
docker run -d --restart=always -h "${SLAVE_ID}.syncthing.net" syncthing/buildslave "$SLAVE_ID" "$SLAVE_SECRET"
```

