FROM golang:alpine

RUN apk --update add git
RUN apk add --no-cache openssh

WORKDIR /GopherLabs
RUN git clone https://github.com/sangam14/GopherLabs.git /GopherLabs/present
RUN go get golang.org/x/tools/cmd/present

EXPOSE 3999

WORKDIR /GopherLabs/present

ENTRYPOINT [ "/go/bin/present", "-play=false", "-http=0.0.0.0:3999"]