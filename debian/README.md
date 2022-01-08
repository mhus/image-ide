
docker build -t summer-ide .

docker run --rm \
  -p 5900:5900 -p 6080:6080 \
  --name summer-ide \
  summer-ide

docker run --rm \
  -p 5900:5900 -p 6080:6080 \
  --name summer-ide \
  --env RESOLUTION=1440x900 \
  --env HOST_UID=1000 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $HOME:/home/ubuntu/shared \
  --security-opt seccomp=unconfined \
  x11vnc/vscode-desktop \
  startvnc.sh

