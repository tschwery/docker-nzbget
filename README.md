# docker-nzbget

This [Docker](https://www.docker.com) image allows you to run a
[NZBGet](https://nzbget.net) instance.

## Environment variables configuration
Each section of the `nzbget.conf` file can be overridden using environment
variables in the following form : 

```
NZB_SETTINGS="var1 = value\nvar2 = value\nvar3 = value"
```

For example: 
```
NZB_SETTINGS="ControlUsername=nzbget\nControlPassword=nzbget\n"
```

In addition, the following variables can be used:
* `NZB_OUTPUT` instead of `NZB_SETTINGS="DestDir=something"`

## Volumes
By default, the configuration points the downloads to the `/home/nzbget/downloads`
directory. It can be overridden using the `$NZB_OUTPUT` shortcut variable
or `DestDir` in the configuration file.
