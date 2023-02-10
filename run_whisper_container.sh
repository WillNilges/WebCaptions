#!/bin/bash
set -e
help_me () {
    echo "-d : run in background | -p : path to file (required) | -h : help"
}
WC_BACKGROUND="-it"
WC_PATH=""
while getopts ":h:dp:" option; do
    case $option in
        d)
            WC_BACKGROUND="-d";;
        p) # select file path 
            WC_PATH=$OPTARG;;
        h)
            help_me
            exit;;
    esac
done
if [[ -z "$WC_PATH" ]]; then help_me; exit 1; fi
podman run --rm $WC_BACKGROUND --hooks-dir=/usr/share/containers/oci/hooks.d/ --security-opt=label=disable -v $(dirname $WC_PATH):/workdir:Z -e WHISPER_VIDEO_PATH=$(basename $WC_PATH) --name="$(whoami)_$(basename $WC_PATH)" webcaptions 
