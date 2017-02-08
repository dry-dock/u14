#!/bin/bash -e

export DOCKERHUB_ORG="drydock"
export IMAGE_NAME="u14"
export IMAGE_TAG="tip"

export RES_DOCKERHUB_INTEGRATION="docker-creds"
export RES_REPO="u14-repo"
export OUT_IMAGE="u14-img"

# get dockerhub EN string
export RES_DOCKERHUB_INTEGRATION_UP=$(echo ${RES_DOCKERHUB_INTEGRATION//-/} | awk '{print toupper($0)}')
export DH_STRING=$RES_DOCKERHUB_INTEGRATION_UP"_INTEGRATION"

# since resources here have dashes Shippable replaces them and UPPER cases them
export RES_REPO_UP=$(echo ${RES_REPO//-/} | awk '{print toupper($0)}')
export RES_REPO_UP_PATH=$RES_REPO_UP"_PATH"

setContext() {
  export DH_USERNAME=$(eval echo "$"$DH_STRING"_USERNAME")
  export DH_PASSWORD=$(eval echo "$"$DH_STRING"_PASSWORD")
  export DH_EMAIL=$(eval echo "$"$DH_STRING"_EMAIL")

  echo "DH_USERNAME=$DH_USERNAME"
  echo "DH_PASSWORD=${#DH_PASSWORD}" #show only count
  echo "DH_EMAIL=$DH_EMAIL"
}

dockerhubLogin() {
  echo "Logging in to Dockerhub"
  echo "----------------------------------------------"
  sudo docker login -u $DH_USERNAME -p $DH_PASSWORD -e $DH_EMAIL
}

createImage() {
  BLD_IMG=$DOCKERHUB_ORG/$IMAGE_NAME:$IMAGE_TAG

  pushd $(eval echo "$"$RES_REPO_UP_PATH"/gitRepo")

  echo "Starting Docker build & push for $BLD_IMG"
  sudo docker build -t=$BLD_IMG .
  echo "Pushing $BLD_IMG"
  sudo docker push $BLD_IMG
  echo "Completed Docker build &  push for $BLD_IMG"

  popd

}

createOutState() {
  echo "Creating a state file for $OUT_IMAGE"
  echo versionName=$BLD_IMG > /build/state/$OUT_IMAGE.env
  cat /build/state/$OUT_IMAGE.env
  echo "Completed creating a state file for $OUT_IMAGE"
}

main() {
  setContext
  dockerhubLogin
  createImage
  createOutState
}

main
