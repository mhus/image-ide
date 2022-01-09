#!/bin/bash
echo ">>> summer-ide"
cd summer-ide
docker build -t summer-ide . || exit 1
cd ..
echo ">>> summer-eclipse"
cd summer-eclipse
docker build -t summer-eclipse . || exit 1
cd ..
echo ">>> summer-ide-java"
cd summer-ide-java
docker build -t summer-ide-java . || exit 1
cd ..
echo ">>> summer-ide-web"
cd summer-ide-web
docker build -t summer-ide-web . || exit 1
cd ..
