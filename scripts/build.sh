#! /usr/bin/env bash
set -x
set -e

docker run --rm -v /tmp/gradle-caches:/root/.gradle/caches -v $WORKDIR/pipelines/$GO_PIPELINE_NAME:/opt/app -w /opt/app gradle:3.5-jdk8 gradle clean bootRepackage
if [[ -z $DOCKER_REGISRTY ]]; then
  DOCKER_REGISRTY=10.202.129.3:5000
fi
IMAGE_NAME=${DOCKER_REGISRTY}/tw-ms-train/user-service:${GO_PIPELINE_COUNTER}
docker build -t $IMAGE_NAME .
docker push $IMAGE_NAME
docker rmi $IMAGE_NAME
