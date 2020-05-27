# Network
This is a repo of using Go, Go mod file, two directories, docker/docker-compose to orchestrate two Go programs running at the sametime through docker-compose.

1. To demonstrate this you may need to run sudo and install docker/docker-compose.


| main.go | net2/main.go |
| ------ | ------ |
| Dockerfile | net2/Dockerfile |
| docker-compose |    | 

Basically the two main.go files are just the following

**main.go**
```
package main

import "github.com/davecgh/go-spew/spew"

func main() {
	var news = "works2"
	spew.Dump(news)
}
```
**/net2/main.go**
```
package main

import "github.com/davecgh/go-spew/spew"

func main() {
	var news = "works"
	spew.Dump(news)
}
```
The mod file is started with `sudo go mod init whatevernameyouwant`


The two Dockerfiles are the same.
```
# build stage
FROM golang as builder

COPY . /LoadLocation
WORKDIR /LoadLocation
ENV GO111MODULE=on
RUN CGO_ENABLED=0 GOOS=linux go build -o LoadLocation
#second stage
FROM alpine:latest
WORKDIR /root/
RUN apk add --no-cache tzdata
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /LoadLocation .
CMD ["./LoadLocation"]
```
The Docker-compose file is the following.
```
# Docker Compose file Reference (https://docs.docker.com/compose/compose-file/)
 
version: '3'
 
# Define services
services:
  service1:
    # App Service
      build:
        context: . # Use an image built from the specified dockerfile in the current directory.
        dockerfile: Dockerfile
      ports:
        - "8083:8083"
      image: localhost:8083/servers #####change here
      restart: unless-stopped
  service2:
     # App Service
      build:
        context: ./net2/ # Use an image built from the specified dockerfile in the current directory.
        dockerfile: Dockerfile
      ports:
        - "8082:8082"
      image: localhost:8082/servers #####change here
      restart: unless-stopped
```

You may need to download the go image when you first do docker build imagename .
These are the steps I used to get docker going.
1. [installed docker ](https://docs.google.com/document/d/1lqpv7zRxL1DPmlP2KmcsZd9O1JwgfzRzpK3ZBu9Th2U/edit)
2. You then have to login with sudo docker login
3. Build the image with `sudo docker build -t appname .` <--remember the dot
4. To run it `sudo docker run imagename` can be image or app name that you used above

This is to just run docker but we want to run docker-compose
1. install docker-compose
2. Build the docker-compose image with `sudo docker-compose build`
3. To run it do `sudo docker-compose up`

Things to remember are the following.
1. Dockerfiles/docker-compose files care about spacing and tabs.
2. Remember the ports you are opening in the apps and the docker-compose
3. The mod file may need you to run sudo and  export GO111MODULE=on

The whole point of doing all this is the following.
1. You can use this on any go program and you dont have to worry about dependencies
2. The Docker files pull their own os and turn modules on and enable which os to run on
3. The Docker files also build to a binary
4. The Docker-compose file starts up two services and it controls the ports and how they might communicate.
