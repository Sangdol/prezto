#!/usr/bin/env bash

rsync -aL --no-compress --delete --exclude 'target' --exclude 'node_modules' --exclude 'classes' --exclude 'WEB-INF/lib' /Users/hugh/Google\ Drive/ /backup/Google\ Drive
rsync -aL --no-compress --delete --exclude 'target' --exclude 'node_modules' --exclude 'classes' --exclude 'WEB-INF/lib' /Users/hugh/Dropbox/ /backup/Dropbox

cd /backup || exit 1
chown -R root Google\ Drive
chown -R root Dropbox
