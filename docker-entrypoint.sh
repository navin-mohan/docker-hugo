#!/bin/bash

# abort the script if there is a non-zero error
set -e

# install hugo

get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"v([^"]+)".*/\1/'                                  # Pluck JSON value
}

HUGO_VERSION=get_latest_release "gohugoio/hugo"

wget "https://github.com/gohugoio/hugo/releases/download/v$HUGO_VERSION/hugo_$HUGO_VERSION_Linux-64bit.deb" -O hugo.deb
dpkg -i hugo.deb
rm hugo.deb

exec "$@"