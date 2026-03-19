# smalltalk-interop-docker

A Docker image for running [PharoSmalltalkInteropServer](https://github.com/mumez/PharoSmalltalkInteropServer) with VNC and supervisord.

## Environment Variables

| Variable | Description | Default |
|---|---|---|
| `PHARO_SIS_PORT` | Server port | `8086` |
| `PHARO_SIS_SCREENSHOT_DIR` | Screenshot save directory | `/root/smalltalk-interop/screenshots` |

## Volumes

| Path | Description |
|---|---|
| `/root/smalltalk-interop/screenshots` | Screenshot output directory (mountable) |

## Usage

### Build and run (example)

```bash
bash run.sh
```

### Custom port

```bash
docker run --name sis-pharo01 -d \
    -p 5900:5900 \
    -p 6901:6901 \
    -p 9090:9090 \
    -e PHARO_SIS_PORT=9090 \
    -v /host/path/screenshots:/root/smalltalk-interop/screenshots \
    sis-pharo
```

### Access

- SIS API: `http://localhost:8086`
- Pharo VNC (browser): `http://localhost:6901/?password=vncpassword`
- Pharo VNC (client): `localhost:5900`
