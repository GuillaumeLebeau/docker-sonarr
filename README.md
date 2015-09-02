# Docker Sonarr (previously NzbDrone)

### Tags
- guillaumegl/sonarr:**latest** - Installs from Sonarr master repository

### Ports
- **TCP 8989** - Web Interface

### Volumes
- **/data/config** - Sonarr configuration data
- **/data/torrent** - Completed downloads from download client
- **/data/media** - Sonarr media folder

## Running

The quickest way to get it running without integrating with a download client or media server (plex)
```
sudo docker run -d --restart always --name sonarr -p 8989:8989 -v /path/to/your/media/folder/:/data/media -v /path/to/your/completed/downloads:/data/torrent -v /path/to/your/config:/data/config guillaumegl/sonarr
```

## Updating

To update successfully, you must configure Sonarr to use the update script in ``/sonarr-update.sh``. This is configured under Settings > (show advanced) > General > Updates > change Mechanism to Script.

After updating, the update script will stop the container. If the container was run with `--restart always`, docker will automatically restart Sonarr.
