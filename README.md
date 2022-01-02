
docker build -t summer-ide .

docker buildx run --rm \
  -p 5900:5900 -p 6080:6080 \
  --name summer-ide \
  summer-ide

