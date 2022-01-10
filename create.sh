#!/bin/bash
. docker.parameters
version=${version:-latest}
echo ">>> x11vnc-desktop:$version"
cd ../x11vnc-desktop
docker build -t x11vnc/desktop:$version . || exit 1
cd -
#echo ">>> docker-desktop:$version"
#cd ../docker-desktop
#docker build -t x11vnc/docker-desktop:$version . || exit 1
#cd -
echo ">>> vscode-desktop:$version"
cd ../vscode-desktop
docker build -t x11vnc/vscode-desktop:$version . || exit 1
cd -
echo ">>> summer-ide:$version"
cd summer-ide
docker build -t summer-ide:$version . || exit 1
cd ..
echo ">>> summer-eclipse:$version"
cd summer-eclipse
docker build -t summer-eclipse:$version . || exit 1
cd ..
echo ">>> summer-ide-java:$version"
cd summer-ide-java
docker build -t summer-ide-java:$version . || exit 1
cd ..
echo ">>> summer-ide-web:$version"
cd summer-ide-web
docker build -t summer-ide-web:$version . || exit 1
cd ..
