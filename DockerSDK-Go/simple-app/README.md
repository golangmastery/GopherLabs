```
 git  clone https://github.com/sangam14/GopherLabs
Cloning into 'GopherLabs'...
remote: Enumerating objects: 28, done.
remote: Counting objects: 100% (28/28), done.
remote: Compressing objects: 100% (28/28), done.
remote: Total 1651 (delta 11), reused 0 (delta 0), pack-reused 1623
Receiving objects: 100% (1651/1651), 88.41 MiB | 40.98 MiB/s, done.
Resolving deltas: 100% (761/761), done.
[node1] (local) root@192.168.0.33 ~
$ cd GopherLabs/
[node1] (local) root@192.168.0.33 ~/GopherLabs
$ cd DockerSDK-Go/
[node1] (local) root@192.168.0.33 ~/GopherLabs/DockerSDK-Go
$ cd simple-app/
[node1] (local) root@192.168.0.33 ~/GopherLabs/DockerSDK-Go/simple-app
$ docker build -t simple .
Sending build context to Docker daemon  4.096kB
Step 1/7 : FROM golang:latest
latest: Pulling from library/golang
e9afc4f90ab0: Pull complete 
989e6b19a265: Pull complete 
af14b6c2f878: Pull complete 
5573c4b30949: Pull complete 
d4020e2aa747: Pull complete 
94fe4bf42ebf: Pull complete 
c24da2810430: Pull complete 
Digest: sha256:ede9a57fa6d862ab87f5abcea707c3d55e445ff01d806334a1cb7aae45ec73bb
Status: Downloaded newer image for golang:latest
 ---> 5fbd6463d24b
Step 2/7 : RUN mkdir /app
 ---> Running in 979e5b54d5c0
Removing intermediate container 979e5b54d5c0
 ---> 5ba80b690c8c
Step 3/7 : ADD . /app/
 ---> e7f2dcdc5d13
Step 4/7 : WORKDIR /app
 ---> Running in f2461a6ad5c8
Removing intermediate container f2461a6ad5c8
 ---> 459694d5d959
Step 5/7 : RUN go get github.com/docker/docker/client
 ---> Running in 37d97f355f0a

Removing intermediate container 37d97f355f0a
 ---> ffa6f0a63a1c
Step 6/7 : RUN go build -o main .
 ---> Running in acc9d40c9f9a
Removing intermediate container acc9d40c9f9a
 ---> defd4c605656
Step 7/7 : CMD ["/app/main"]
 ---> Running in c801656d88db
Removing intermediate container c801656d88db
 ---> ca3a98b3c7fb
Successfully built ca3a98b3c7fb
Successfully tagged simple:latest



[node1] (local) root@192.168.0.33 ~/GopherLabs/DockerSDK-Go/simple-app
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED              SIZE
simple              latest              ca3a98b3c7fb        About a minute ago   1.05GB
golang              latest              5fbd6463d24b        26 hours ago         810MB



[node1] (local) root@192.168.0.33 ~/GopherLabs/DockerSDK-Go/simple-app
$ docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -it simple:latest

```
