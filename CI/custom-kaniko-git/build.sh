#!/bin/bash

if [ -z "$REGISTRY_USERNAME" ]; then
  echo "Not found \$REGISTRY_USERNAME PASSWORD_REGISTRY"
  exit 1
fi

if [ -z "$REGISTRY_PASSWORD" ]; then
  echo "Not found \$REGISTRY_PASSWORD PASSWORD_REGISTRY"
  exit 1
fi

if [ -z "$REGISTRY_URL" ]; then
  echo "Not found \$REGISTRY_URL."
  exit 1
fi

if [ -z "$GIT_USERNAME" ]; then
  echo "Not found \$GIT_USERNAME."
  exit 1
fi

if [ -z "$GIT_PASSWORD" ]; then
  echo "Not found \$GIT_PASSWORD."
  exit 1
fi

echo """

███▀▀▀▀▀▀▀▀▀███
██░░░░░░░░░░░██
█▄▄▄▄▄▄▄▄▄▄▄▄▄█
▌▌▐███▀░▀███▌▐▐
█▌▄▀▀░╥╥╥░▀▀▄▐█
▌═░░╨╨╨╨╨╨╨░░═▐
▌═║░║░▄█▄░║░║═▐
█▄▄█▄█████▄█▄▄█

"""


echo "*****************************************************************"
echo "GIT_URL=$GIT_URL"
echo "Name Images=$NAME_IMAGE:$NAME_TAG"
echo "*****************************************************************"


auth_base64=$(echo -n "$REGISTRY_USERNAME:$REGISTRY_PASSWORD" | base64)

mkdir /kaniko/.docker
cat <<EOF >/kaniko/.docker/config.json
{
  "auths": {
    "$REGISTRY_URL": {
      "auth": "$auth_base64"
    }
  }
}
EOF

git_url="$GIT_URL"
repository_name=$(basename "$git_url" .git)
git clone "$git_url" "$repository_name"


if [ -d "$repository_name" ]; then
  cd "$repository_name"
else
  echo "Error: "$repository_name" not found"
  exit 1
fi

if [[ -v DOCKERFILE_PATH ]]; then
    /kaniko/executor --context=/workdir/$repository_name/$DOCKERFILE_PATH/Dockerfile \
    --dockerfile=/workdir/$repository_name/$DOCKERFILE_PATH \
    --destination=$NAME_IMAGE:$NAME_TAG
else
    /kaniko/executor --context=/workdir/$repository_name/image \
    --dockerfile=/workdir/$repository_name/image/Dockerfile \
    --destination=$NAME_IMAGE:$NAME_TAG

fi

exit