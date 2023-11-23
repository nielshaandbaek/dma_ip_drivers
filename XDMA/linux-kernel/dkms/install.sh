#!/bin/sh
set -e
set -u

# Change working directory to script directory.
script_dir="$(dirname $(realpath "$0"))"
cd "$script_dir" || exit 1

# Get package name and version from 'dkms.conf'.
package_name="$(grep '^PACKAGE_NAME' dkms.conf | cut -d'=' -f2)"
package_version="$(grep '^PACKAGE_VERSION' dkms.conf | cut -d'=' -f2)"

# Install the sources.
src_dir="/usr/src/${package_name}-${package_version}"
rm -rf "$src_dir"
mkdir "$src_dir"
cp -v -r ../include ../xdma "$src_dir"
cp -v ../COPYING ../LICENSE ../readme.txt ../RELEASE "$src_dir"
cp -v ./dkms.conf "$src_dir"

# Enable command echo.
set -x

# Remove the module from the DKMS tree if it was previously there.
dkms remove -m "$package_name" -v "$package_version" --all || true

# Add the module to the DKMS tree.
dkms add -m "$package_name" -v "$package_version"
dkms build -m "$package_name" -v "$package_version"
dkms install -m "$package_name" -v "$package_version"

cat << EOF
###########################################################

    Module 'xdma' installed. Load using

    $ sudo modprobe xdma

###########################################################
EOF
