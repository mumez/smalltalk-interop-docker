# smalltalk-interop-docker

A Docker image for running [PharoSmalltalkInteropServer](https://github.com/mumez/PharoSmalltalkInteropServer) with VNC and supervisord.

By combining this image with [smalltalk-dev-plugin](https://github.com/mumez/smalltalk-dev-plugin), you can use AI-assisted Pharo development (e.g., via Claude Code) without polluting your local environment. Pharo runs fully isolated inside the container as a sandbox, keeping your host system clean while enabling seamless AI-driven development workflows.

## Environment Variables

| Variable | Description | Default |
|---|---|---|
| `PHARO_SIS_PORT` | Server port | `8086` |
| `PHARO_SIS_SCREENSHOT_DIR` | Screenshot output directory | `/root/screenshots` |

## Volumes

| Path | Description |
|---|---|
| `/root/smalltalk-interop` | PharoSmalltalkInterop server directory |
| `/root/screenshots` | Screenshot output directory |
| `/root/repos` | Repositories directory. Mount a local directory containing your Pharo project Git repositories. PharoSmalltalkInteropServer imports from and exports packages to this directory. |

## Usage

### Build and run (example)

Using Docker Compose:

```bash
docker compose up -d
```

Using the run script:

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
    -v /host/path/repos:/root/repos \
    sis-pharo
```

### Access

- Smalltalk Interop Server base URL: `http://localhost:8086`
- Pharo VNC (browser): `http://localhost:6901/?password=vncpassword`
- Pharo VNC (client): `localhost:5900`


### Other settings

For VNC-related settings (VNC port, password, etc.), see [ubuntu-vnc-supervisor](https://github.com/mumez/ubuntu-vnc-supervisor).

For Pharo-related settings (Pharo version, mode, etc.), see [pharo-vnc-supervisor](https://github.com/mumez/pharo-vnc-supervisor).