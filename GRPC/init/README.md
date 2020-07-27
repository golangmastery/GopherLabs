# grpc-golang-workshop

In this workshop, you will learn using Golang how to build a gRPC server, a gRPC client and how to deploy a gRPC server using docker.

## Steps to learn gRPC

### Get the initial files 

The source for this codelab is in ``.

Sample project layout:  
| Name              | Description                            |  
| client.go         | Command-line client for the server API.|  
| books/books.pb.go | go library for the books gRPC service. |  

#### Step 0: Run the client application

The sample application folder contains `client.go`, a command-line client for interacting with the gRPC service that you will create in this codelab.

Now, from the project directory, run the command-line client with no arguments to view the available commands:

```commandline
$ go run client.go 
client.go is a command-line client for this codelab's gRPC service

Usage:
  client.go list                            List all books
  client.go insert <id> <title> <author>    Insert a book
  client.go get <id>                        Get a book by its ID
  client.go delete <id>                     Delete a book by its ID
  client.go watch                           Watch for inserted books
```

Try calling one of the available commands:
```commandline
$ go run client.go list
```
You will see a list of errors after a few seconds because the golang gRPC server does not yet exist!
```commandline
2018/07/17 17:07:16 List books: rpc error: code = Unavailable desc = all SubConns are in TransientFailure, 
latest connection error: connection error: desc = "transport: Error while dialing dial tcp 0.0.0.0:50051: 
connect: connection refused"
exit status 1
```
Let's fix this!

### Step 1: List all books

In this step you will write the code to implement a Golang gRPC service that lists books in source  `grpc-workshop/start`.

gRPC services are defined in `.proto` files using the protocol buffer language.

The [Protocol Buffers Language Guide](https://developers.google.com/protocol-buffers/docs/proto3) documents the `.proto` file format.

The protocol buffer language is used to define services and message types.

Let's start by defining a service for books!

In the project directory `start/books`, create a new file called `books.proto` and add the following:

`books.proto`
```proto
syntax = "proto3";

package books;

service BookService {
  rpc List (Empty) returns (Empty) {}
}

message Empty {}
```

This defines a new service called *BookService* using the **proto3** version of the protocol buffers language. This is the latest version of protocol buffers and is recommended for use with gRPC.

From this proto file we will generate Go file that wraps the gRPC connection for us.
The generated files contain structs from all the "messages" defined in the proto files, and getters and setters to all structs.
Also, generated files contain gRPC client and server wrappers for the service.
  
Make sure you have protoc-gen-go in your $PATH. 
If it's not there, simply run `export PATH=$PATH:$GOPATH/bin`.

To generate the Go files from the proto file we need to use the following command:

`protoc -I . books/books.proto --go_out=plugins=grpc:.`

* `-I` indicates the path of the project the proto file is in (“.” means current directory, because we run it from the directory `start`).

* `--go_out=plugins=grpc:` indicates the path of the output. “.” means current directory. This is relative to the lction of the proto file. If the proto file is in books directory then the generated file will also be in the same directory if we use “.”.

Now, create a file called `server.go` and this to the file:

`server.go`
```go
package main

import (
	"flag"
	"fmt"
	"google.golang.org/grpc"
	"log"
	"net"
	pbBooks "github.com/mresti/grpc-workshop/start/books"
	"golang.org/x/net/context"
	"google.golang.org/grpc/status"
	"google.golang.org/grpc/codes"
)

var (
	port = flag.Int("port", 50051, "The server port")
)

func main() {
	flag.Parse()
	lis, err := net.Listen("tcp", fmt.Sprintf("localhost:%d", *port))
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	var opts []grpc.ServerOption
	grpcServer := grpc.NewServer(opts...)
	fmt.Println("Server running at http://0.0.0.0:50051")
	service := service{}
	pbBooks.RegisterBookServiceServer(grpcServer, &service)
	grpcServer.Serve(lis)
}

type service struct {
}

func (s *service) List(context.Context, *pbBooks.Empty) (*pbBooks.Empty, error){
	return &pbBooks.Empty{}, status.Error(codes.Unimplemented, "The server does not implement this method")
}
```
Run `go run server.go` and from another terminal tab run `go run client.go list`. The error we receive now is ``rpc error: code = Unimplemented desc = The server does not implement this method``.
This means we created a gRPC connection :) We just need to fix the List method.

Edit the files as following:

`books.proto`
```proto
syntax = "proto3";

package books;

service BookService {
  rpc List (Empty) returns (BookList) {}
}

message Empty {} 

message Book {
  int32 id = 1;
  string title = 2;
  string author = 3;
}

message BookList {
  repeated Book books = 1;
}
```

`server.go`
```go
package main

import (
	"flag"
	"fmt"
	"google.golang.org/grpc"
	"log"
	"net"
	pbBooks "github.com/mresti/grpc-workshop/start/books"
	"golang.org/x/net/context"
)

var (
	port = flag.Int("port", 50051, "The server port")
	bookList = []*pbBooks.Book{
		{
			Id: 123,
			Title: "A Tale of Two Cities",
			Author: "Charles Dickens",
		},
	}
)

func main() {
	flag.Parse()
	lis, err := net.Listen("tcp", fmt.Sprintf("localhost:%d", *port))
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	var opts []grpc.ServerOption
	grpcServer := grpc.NewServer(opts...)
	fmt.Println("Server running at http://0.0.0.0:50051")
	service := service{}
	pbBooks.RegisterBookServiceServer(grpcServer, &service)
	grpcServer.Serve(lis)
}

type service struct {
}

func (s *service) List(context.Context, *pbBooks.Empty) (*pbBooks.BookList, error){
	return &pbBooks.BookList{Books: bookList}, nil
}
```

Run `protoc -I . books/books.proto --go_out=plugins=grpc:.`, then `go run server.go` and from another terminal tab run `go run client.go`.

You should now see this book listed!
```commandline
Server sent 1 book(s).
{
  "books": [
    {
      "id": 123,
      "title": "A Tale of Two Cities",
      "author": "Charles Dickens"
    }
  ]
}
```

### Step 2: Insert new books

In this step you will write the code to implement adding new *Book* objects via the gRPC service.

To begin, edit `books.proto` and update *BookService* to the following:

`books.proto`
```proto
service BookService {
  rpc List (Empty) returns (BookList) {}
  // add the following line
  rpc Insert (Book) returns (Empty) {}
}
```

and run ```protoc -I . books/books.proto --go_out=plugins=grpc:.``` 

Now add the function to `server.go` as well:

 `server.go`
```go
func (s *service) Insert(ctx context.Context, book *pbBooks.Book) (*pbBooks.Empty, error){
	bookList = append(bookList, book)
	return &pbBooks.Empty{}, nil
}
```

To test this, restart the go server and then run the go gRPC command-line client's *Insert* command, passing *id*, *title*, and *author* as arguments:
```commandline
go run client.go insert 2 "The Three Musketeers" "Alexandre Dumas"
```

You should see an empty response:
```commandline
Server response:
{}
```

To verify that the book was inserted, run the list command again to see all books:
```commandline
go run client.go list
```

You should now see 2 books listed!
```commandline
Server sent 2 book(s).
{
  "books": [
    {
      "id": 123,
      "title": "A Tale of Two Cities",
      "author": "Charles Dickens"
    },
    {
      "id": 2,
      "title": "The Three Musketeers",
      "author": "Alexandre Dumas"
    }
  ]
}
```

### Step 3: Get and delete books
In this step you will write the code to *get* and *delete* Book objects by id via the gRPC service.

#### Get a book
To begin, edit `books.proto` and update *BookService* with the following:

`books.proto`
```proto
service BookService {
  rpc List (Empty) returns (BookList) {}
  rpc Insert (Book) returns (Empty) {}
  // add the following line
  rpc Get (BookIdRequest) returns (Book) {}
}

// add the message definition below
message BookIdRequest {
  int32 id = 1;
}
```

This defines a new *Get* rpc call that takes a *BookIdRequest* as its request and returns a *Book* as its response.

A *BookIdRequest* message type is defined for requests containing only a book's id.

To implement the Get method in the server, edit `server.go` and add the following get handler function:

`server.go`
```go
func (s *service) Get(ctx context.Context, req *pbBooks.BookIdRequest) (*pbBooks.Book, error){
	for i := 0; i < len(bookList); i++ {
		if bookList[i].Id == req.Id {
			return bookList[i], nil
		}
	}
	return nil, status.Errorf(codes.NotFound, "Not found")
}
```

To test this, restart the node server and then run the go gRPC command-line client's get command, passing id as an argument:
```commandline
go run client.go get 123
```

You should see the book response!
```commandline
Server response:
{
  "id": 123,
  "title": "A Tale of Two Cities",
  "author": "Charles Dickens"
}
```

Now try getting a book that doesn't exist:
```commandline
go run client.go get 404
```

You should see the error message returned:
```commandline
Get book (404): rpc error: code = NotFound desc = Not found
```

#### Delete a book

Now you will write the code to *delete* a book by id.

Edit `books.proto` and add the following *Delete* rpc method:

`books.proto`
```proto
service BookService {
  // ...
  // add the delete method definition
  rpc Delete (BookIdRequest) returns (Empty) {}
}
```

Now edit `server.go` and add the following *delete* handler function:

`server.go`
```go
func (s *service) Delete (ctx context.Context, req *pbBooks.BookIdRequest) (*pbBooks.Empty, error) {
	for i := 0; i < len(bookList); i++ {
		if bookList[i].Id == req.Id {
			bookList = append(bookList[:i], bookList[i+1:]...)
			return &books.Empty{}, nil
		}
	}
	return nil, status.Errorf(codes.NotFound, "Not found")
}
```

If the books array contains a *book* with the *id* requested, the book is removed, otherwise a **NOT_FOUND error** is returned.

To test this, restart the node server and then run the go gRPC command-line client to *delete* a book:
```commandline
go run client.go list
Server sent 1 book(s).
{
  "books": [
    {
      "id": 123,
      "title": "A Tale of Two Cities",
      "author": "Charles Dickens"
    }
  ]
}

go run client.go delete 123
Server response:
{}

go run client.go list
Server sent 0 book(s).
{}

go run client.go delete 123
Delete book (123): rpc error: code = 5 desc = "Not found"
```

Great!

You implemented a fully functioning gRPC service that can list, insert, get, and delete books!

### Step 4: Stream added books

In this step you will write the code to add a streaming endpoint to the service so the client can establish a stream to the server and listen for added books.
gRPC supports streaming semantics, where either the client or the server (or both) send a stream of messages on a single RPC call. The most general case is Bidirectional Streaming where a single gRPC call establishes a stream where both the client and the server can send a stream of messages to each other.

To begin, edit `books.proto` and add the following *Watch* rpc method to *BookService*:

`books.proto`
```proto
service BookService {
  // ...
  // add the watch method definition
  rpc Watch (Empty) returns (stream Book) {}
}
```

When the client calls the *Watch* method, it will establish a stream and server will be able to stream *Book* messages when books are inserted.

To implement the *Watch* method you will need to install `Emitter`:
```commandline
$ go get -u github.com/olebedev/emitter
```

Now edit `server.go` and add the following *events* package, bookStream event listener and watch handler function:

First define the following var 
```go
var (
    //...
    newBookEmitter = emitter.Emitter{}
)
``` 
and then modify the Insert function:
```go
func (s *service) Insert(ctx context.Context, book *pbBooks.Book) (*pbBooks.Empty, error) {
	bookList = append(bookList, book)
	newBookEmitter.Emit("NewBook")
	return &pbBooks.Empty{}, nil
}
```
Handler functions for streaming rpc methods are invoked with a writable stream object.

To stream messages to the client, the stream's write() function is called when an new_book event is emitted.

Edit `server.go` and update the insert function to emit a new_book event when books are inserted:
```go
func (s *service) Watch(empty *pbBooks.Empty, stream pbBooks.BookService_WatchServer) error {
	c := newBookEmitter.On("NewBook")
	for {
		<-c
		bookListLength := len(bookList)
		stream.Send(bookList[bookListLength-1])
	}
	newBookEmitter.Off("NewBook")
	return nil
}
```

To test this, restart the node server and then run the go gRPC command-line client's watch command in a 3rd Cloud Shell Session:
```commandline
go run client.go watch
```
Now run the go gRPC command-line client's insert command in your main Cloud Shell session to insert a book:
```commandline
go run client.go insert 2 "The Three Musketeers" "Alexandre Dumas"
```
Check the Cloud Shell session where the client.go watch process is running. It should have printed out the inserted book!
```commandline
go run client.go watch
Server stream data received:
{
  "id": 2,
  "title": "The Three Musketeers",
  "author": "Alexandre Dumas"
}
```

Press CTRL-C to exit the client.go watch process.

### Step 5: Create gRPC client

In the original workshop, in this step we create a new Node.js gRPC client. Because we already have a client written in go we can simply just go over it.

### Step 6: Deploy a gRPC server on docker-compose (optional)

In this step, we deploy the golang gRPC server on docker-compose, but we need to change the address and port to listen the gRPC server.

We change this line:

```golang
lis, err := net.Listen("tcp", fmt.Sprintf("localhost:%d", *port))
```

for this line:

```golang
lis, err := net.Listen("tcp", fmt.Sprintf(":%d", *port))
```

We listen the request for the gRPC server any address when we try to run a gRPC server over docker infrastructure.

Next step, is create a dockerfile with docker, we use docker image for golang version 1.10.5 `golang:1.10.5-alpine` or  golang version 1.11.2 `golang:1.11.2-alpine`. 

So that we create a file `Dockerfile`

```dockerfile
# build stage
FROM golang:1.11.2 as builder

ENV SRV_NAME start
ENV PKG_PATH /go/src/github.com/mresti/grpc-workshop

RUN go get -u google.golang.org/grpc golang.org/x/net/context github.com/golang/protobuf/proto github.com/olebedev/emitter

ADD books $PKG_PATH/$SRV_NAME/books
ADD server.go $PKG_PATH/$SRV_NAME/server.go

WORKDIR $PKG_PATH/$SRV_NAME

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o server .

# final stage
FROM alpine:latest

RUN apk --no-cache add ca-certificates

WORKDIR /root/

COPY --from=builder /go/src/github.com/mresti/grpc-workshop/start/server .

CMD ["./server"]

EXPOSE 50051
```

**Warning**: The end result is the same tiny production image as before, with a significant 
reduction in complexity. More information at [docker documentation](https://docs.docker.com/develop/develop-images/multistage-build/#name-your-build-stages)

Now, we have our docker with our gRPC server. 

Next step, we create a docker-compose file where we run our docker image. So that we create a file `docker-compose.yml`

```yml
version: '3'
services:
  server:
    build:
      context: .
      dockerfile: ./Dockerfile
    logging:
      driver: json-file
    ports:
      - "50051:50051"
```

Now, we build the images using below command:

```commandline
docker-compose build
```

Let's go to up the infrastructure using command:

```commandline
docker-compose up
```

At the end, we test using our infrastructure using our clients.

```commandline
go run client.go list
```
```commandline
go run client.go get 123
```
```commandline
go run client.go list
```
```commandline
go run client.go insert 1234 "Commit Conf" "2018"
```
```commandline
go run client.go list
```

*Remember:* To shutdown the infrastructure using command:
```commandline
docker-compose down
```
