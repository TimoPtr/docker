#!/bin/bash

function checkbin() {
    type -P su-exec
}

function su_mt_user() {
    su android -c '"$0" "$@"' -- "$@"
}

chown android:android /opt/android-home/android-sdk-linux

printenv


/opt/android-home/tools/android-sdk-update.sh "$@"






