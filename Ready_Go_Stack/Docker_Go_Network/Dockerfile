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