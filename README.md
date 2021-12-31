# image-ide
Image with IDE to develope summer applications

* spring
* JHipster

Installed:

* GIT
* Java OpenJDK
* nodejs
* Eclipse IDE
* maven
* gradle
* Visual Studio Code

Using:

* VNC Player (vncviewer localhost:5900)
* Web Browser (http://localhost:6080)

Start:

```
docker run --rm \
  -p 5900:5900 -p 6080:6080 \
  --name summer-ide --platform linux/x86_64 \
  summer-ide
```

Build:

```
docker build --platform linux/x86_64 -t summer-ide .
```

Terminal:

Insert as terminal lxterminal