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
DOCKER_RUN_ARGS+=( -v $BWD/mnt/etc/dkimproxy:/etc/dkimproxy )
DOCKER_RUN_ARGS+=( -v $BWD/mnt/etc/rspamd/local.d/dkimproxy_out.conf:/etc/rspamd/local.d/dkimproxy_out.conf )
DOCKER_RUN_ARGS+=( -v $BWD/mnt/etc/rspamd/local.d/private.key:/etc/rspamd/local.d/private.key )

docker update --restart=no $NAME
docker stop $NAME || true
docker system prune -f
docker run -d -it "${DOCKER_RUN_ARGS[@]}" --name $NAME $RUN_IMAGE:$VERSION $*

echo "Attaching to container. To detach CTRL-P CTRL-Q."
docker attach $NAME
