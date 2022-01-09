#!/bin/bash

cp /data/file.key.devel /data/file.key
chmod 400 /data/file.key
chown 999:999 /data/file.key

exec "$@"