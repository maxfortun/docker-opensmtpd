#!/bin/bash -e

pushd "$(dirname $0)"
SWD=$(pwd)
BWD=$(dirname "$SWD")

. $SWD/setenv.sh

RUN_IMAGE="$REPO/$NAME"

# Publish exposed ports
imageId=$(docker images --format="{{.Repository}} {{.ID}}"|grep "^$RUN_IMAGE "|awk '{ print $2 }')
while read port; do
	hostPort=$DOCKER_PORT_PREFIX${port%%/*}
	[ ${#hostPort} -gt 5 ] && hostPort=${hostPort:${#hostPort}-5}
	DOCKER_RUN_ARGS+=( -p $hostPort:$port )
done < <(docker image inspect -f '{{json .Config.ExposedPorts}}' $imageId|jq -r 'keys[]')

DOCKER_RUN_ARGS=( -e container=docker )

DOCKER_RUN_ARGS+=( -v $BWD/mnt/etc/smtpd:/etc/smtpd )
DOCKER_RUN_ARGS+=( -v $BWD/mnt/var/mail:/var/mail )

docker stop $NAME || true
docker system prune -f
docker run -d -it "${DOCKER_RUN_ARGS[@]}" --name $NAME $RUN_IMAGE:$VERSION $*

echo "Attaching to container. To detach CTRL-P CTRL-Q."
docker attach $NAME
