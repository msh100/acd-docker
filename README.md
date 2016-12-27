# Amazon Cloud Drive in a Container

This container uses a sligtly modified configuration of the `acd_cli`, `encfs`, and `unionfs-fuse` setup as [documented here](https://amc.ovh).
Unlike the mentioned blog, this setup will utilise `encfs` reverse mounting, and therefore is incompatible.


## Usage

This container is not cable of producing the `oauth_data` used by `acd_cli` and the `encfs.xml` file required. 

The `encfs.xml` file must be produced and support reverse mounting (it should be mounted as a volume to `/config/encfs.xml`), the password should then be declared in an environment variable (`ENCFS_PASS`). 
The `oauth_data` file can be produced by running `acd_cli` locally and copying the produced JSON to a file which should be mounted as a volume to `/oauth_data`.

As this container needs to create mounts (and possibly load the FUSE kernel module), the container needs to be started with privileged access (if anyone knows the minimum possible with `CAP_ADD`, please raise an issue/PR).


## Environment Variables

Variable          | Example      | Use 
------------------|--------------|---------------------------------------------------------------
`UID`             | `1010`       | UNIX user ID of all the files within the exposed mountpoint.
`GID`             | `1010`       | UNIX group ID of all the files within the exposed mountpoint.
`ENCFS_PASS`      | `mypass`     | The password used with the ENCFS configuration file.
`ACD_ROOT`        | `/media/`    | Where on Amazon Cloud Drive you'd like to store data.
`UPLOAD_INTERVAL` | `30 3 * * *` | Cron interval to upload data
`LOCAL_DAYS`      | `14`         | How many days to keep data stored locally before deleting it.


## Todo

 * At the moment on Ubuntu, the following is required to allow the mount to be shared:
```
mount --bind /mnt/ /mnt/
mount --make-shared /mnt/
```
 * Existing containers do not cleanly unmount unionfs, and therefore `fusermount -u` may be needed to restart the container setup.
 * Verify files have been uploading before allowing local objects to be deleted.
