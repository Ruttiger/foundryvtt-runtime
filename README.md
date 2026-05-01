# FoundryVTT Runtime for Docker / Unraid

Minimal Docker runtime for running Foundry VTT with Node.js.

This image **does not include Foundry VTT itself**.\
Foundry is installed into a persistent volume so it can be updated from
the Foundry UI.

## Features

-   Lightweight Node.js runtime
-   Foundry app stored in a writable volume
-   Minor updates from the Foundry UI
-   Major versions isolated by folder
-   Unraid-friendly
-   No bundled Foundry software or license

## Setup (Quick)

### Build runtime

``` bash
./build.sh 14
```

### Install Foundry

``` bash
./install-foundry.sh 14
```

### Run container

``` bash
docker run -d \
  --name foundryvtt \
  -p 30000:30000 \
  -v /mnt/user/appdata/foundry-14/app:/opt/foundry/app \
  -v /mnt/user/appdata/foundry-14/data:/data \
  --restart unless-stopped \
  ruttiger/foundryvtt-runtime:14
```

Open: http://localhost:30000

## Updates

Minor updates: - Use Foundry UI

Major updates: - Re-run install script with new version - Use new
folders

## Backup

``` bash
./backup-foundry.sh 14 foundryvtt
```

## License

This repository does not distribute Foundry VTT. You must own a valid
license.
