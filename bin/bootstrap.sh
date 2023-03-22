#!/usr/bin/env bash
echo "Running script with bash version: $BASH_VERSION"
GIT_ROOT=$(git rev-parse --show-toplevel)

message() {
  echo -e "\n######################################################################"
  echo "# $1"
  echo "######################################################################"
}

usage() {
  echo "Run the script with '$0 <some node name> (optional <some target path>)'"
  echo "e.g. '$0 k3os-pi4-a /Volumes/system-boot'"
  echo -e "the following node files are detected:\n"
  ls -1 $GIT_ROOT/nodes
  exit 1
}

if [ $# -eq 0 ]
  then
    usage
else
  NODE="$1"
  if [ -d "$GIT_ROOT/nodes/$NODE" ]
    then
      echo "$NODE found"
    else
      usage
  fi
fi

if [ -z "$2" ]
  then
    # check if the ubuntu system-boot volume is already present in the default location
    if [ -f /Volumes/system-boot/cmdline.txt ]
      then
        echo "Assuming /Volumes/system-boot as the target"
        TARGET_VOLUME="/Volumes/system-boot"
      else
        echo "No path given as a target. Call the script with '$0 <some node name> <some target path>'"
        exit 1
    fi
else
  TARGET_VOLUME="$2"
fi

message "writing $NODE configuration to $TARGET_VOLUME"

echo "copying cmdline.txt to $TARGET_VOLUME/cmdline.txt"
cp -f $GIT_ROOT/nodes/global/cmdline.txt "$TARGET_VOLUME/cmdline.txt"
echo "copying network-config nodes/${NODE} to $TARGET_VOLUME/network-config"
cp -f $GIT_ROOT/nodes/$NODE/network-config "$TARGET_VOLUME/network-config"
echo "copying user-data nodes/${NODE} to $TARGET_VOLUME/user-data"
envsubst < $GIT_ROOT/nodes/$NODE/user-data > $TARGET_VOLUME/user-data
