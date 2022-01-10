#!/bin/bash
. docker.parameters
version=${version:-latest}
echo ">>> x11vnc-desktop:$version"
cd ../x11vnc-desktop
git reset --hard || exit 1
git pull || exit 1
cd -
#echo ">>> docker-desktop:$version"
#cd ../docker-desktop
git reset --hard || exit 1
git pull || exit 1
#cd -
echo ">>> vscode-desktop:$version"
cd ../vscode-desktop
git reset --hard || exit 1
git pull || exit 1
cd -
echo ">>> image-ide:$version"
git reset --hard || exit 1
git pull || exit 1
