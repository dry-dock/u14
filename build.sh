#!/bin/bash -e

export BRANCH=master
export IMAGE_NAME=drydock/u14
export IMAGE_TAG=$BRANCH.$BUILD_NUMBER
export RES_DOCKER_CREDS=docker-creds
export RES_REPO=u14-repo
export RES_IMAGE=u14-img

dockerBuild() {
  echo "Starting Docker build for" $IMAGE_NAME:$IMAGE_TAG
  cd ./IN/$RES_REPO/gitRepo
  sudo docker build -t=$IMAGE_NAME:$IMAGE_TAG .
  echo "Completed Docker build for" $IMAGE_NAME:$IMAGE_TAG
}

checkIfTagBuild() {
  echo "Check Tag Version for" $RES_REPO
  export isGitTag=$(cat ./IN/$RES_REPO/version.json | jq -r '.version.propertyBag.shaData.isGitTag')
  export gitTagName=$(cat ./IN/$RES_REPO/version.json | jq -r '.version.propertyBag.shaData.gitTagName')
  export gitTagMessage=$(cat ./IN/$RES_REPO/version.json | jq -r '.version.propertyBag.shaData.gitTagMessage')
  echo "Completed for Tag and found : isGitTag: " $isGitTag " and gitTagName: " gitTagName
}

dockerPush() {
  if [ "$isGitTag" = true ];
  then
    echo "Pulling " $IMAGE_NAME:tip
    sudo docker pull $IMAGE_NAME:tip
    echo "Tagging " $IMAGE_NAME:gitTagName
    echo "Tag Message: " gitTagMessage
    sudo docker tag $IMAGE_NAME:tip $IMAGE_NAME:gitTagName;
    sudo docker push $IMAGE_NAME:gitTagName
    echo "Completed Tagging" $IMAGE_NAME:gitTagName
  else
    echo "Starting Docker push for" $IMAGE_NAME:$IMAGE_TAG
    sudo docker tag $IMAGE_NAME:$IMAGE_TAG $IMAGE_NAME:tip
    sudo docker push $IMAGE_NAME:$IMAGE_TAG
    sudo docker push $IMAGE_NAME:tip
    echo "Completed Docker push for" $IMAGE_NAME:$IMAGE_TAG
  fi
}

dockerLogin() {
  echo "Extracting docker creds"
  . ./IN/$RES_DOCKER_CREDS/integration.env
  echo "logging into Docker with username" $username
  docker login -u $username -p $password -e $email
  echo "Completed Docker login"
}

createOutState() {
  echo "Creating a state file for" $RES_IMAGE
  echo versionName=$IMAGE_TAG > /build/state/$RES_IMAGE.env
  cat /build/state/$RES_IMAGE.env
  echo "Completed creating a state file for" $RES_IMAGE
}

main() {
  dockerLogin
  dockerBuild
  checkIfTagBuild
  dockerPush
  createOutState
}

main
