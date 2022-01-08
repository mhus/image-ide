#!/bin/bash
cd summer-ide
docker build -t summer-ide . || exit 1
cd ..
cd summer-eclipse
docker build -t summer-eclipse . || exit 1
cd ..
cd summer-ide-java
docker build -t summer-ide-java . || exit 1
cd ..
