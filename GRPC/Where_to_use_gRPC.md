---
layout: default
title: Where to use gRPC 
parent: gRPC
nav_order: 5
---

# Where to use gRPC

- So now you know that gRPC is a request-response protocol for streaming RPC that uses Protocol Buffers to define interfaces and messages. 
But, what about where or why you would use gRPC, or what programming languages can be used with gRPC.

The “where” is pretty easy: you can leverage gRPC almost anywhere you have two computers communicating over a network:

- Microservices: gRPC shines as a way to connect servers in service-oriented environments. One of the original problems its predecessor, Stubby, aimed to solve was wiring together microservices. It is well-suited for a wide variety of arenas: 
from medium and large enterprises systems all the way to “web-scale” eCommerce and SaaS offerings.

- Client-Server Applications: gRPC works just as well in client-server applications, where the client application runs on desktop or mobile devices. It uses HTTP/2, which improves on HTTP 1.1 in both latency and network utilization. 
This means you get improved response times and longer battery life.

- Integrations and APIs: gRPC is also a way to offer APIs over the Internet, for integrating applications with services from third-party providers.
As an example, many of Google’s Cloud APIs are exposed via gRPC. This is an alternative to REST+JSON, but it does not have to be mutually exclusive. 
There are tools for easily exposing gRPC services over REST+JSON, such as grpc-gateway

- Browser-based Web Applications: The last big area superficially seems like a poor fit. JavaScript code running in a browser cannot directly utilize gRPC since 
gRPC has a strict requirement for HTTP/2, but browser XHRs do not. However, as mentioned above, there are tools for exposing your gRPC APIs as REST+JSON, 
where they can then be easily consumed by browser clients.


For each of the above situations where you might use gRPC, there are alternatives. In fact, REST and JSON are a sort of de-facto standard for all of these situations. So why would you use gRPC instead? There are several dimensions along which gRPC wins out over the others,
particularly over REST and JSON:

- Performance/Efficiency: HTTP 1.1 is a verbose protocol and JSON is a very verbose message format. 
They are great for human-readability, but less so for computer-readability, requiring a good deal of string parsing. HTTP 1.1 also has a severe limitation of 
how a single connection can be used for multiple requests: all requests must be sent back in the order the corresponding requests were received. So clients that 
use pipelining will see head-of-line blocking delays, but the later responses may have been computed quickly, and must wait for earlier responses to be computed 
and transmitted before they can be sent. And the other alternative, using a connection for only one request at a time and then using a pool of connections to issue
parallel requests, consumes more resources in both clients and servers as well as potentially in between proxies and load balancers.

     - HTTP/2 and Protocol Buffers do not have these problems. HTTP/2 is much less verbose thanks largely to header compression. And it supports multiplexing many requests over a single connection.
Protocol Buffers, unlike JSON, were designed to be both compact on the wire and efficient for computers to parse.

     - The result is that gRPC can reduce resource usage, resulting in lower response times compared to using REST and JSON. This also means reduced network usage and longer battery life for 
      clients running on mobile devices.
      
- Productive Programming Model: The programming model with gRPC is simple to understand and leads to developer productivity. Defining interfaces and canonical 
message formats in an IDL means a lot of boilerplate code is auto-generated. 

- Forget the days of manually wiring up server handlers based on URI paths and then manually marshalling paths, query string parameters, requests, and
      response bodies. Similarly, forget the days of manually creating HTTP request objects, with all of the same overhead on the server side.
- While there are myriad tools and libraries that can alleviate this burden for REST+JSON (including a great number of home-grown, proprietary solutions 
      within organizations and projects), they tend to vary significantly from one programming language to another, possibly even from one project to another. 
      And in some cases they are incomplete: one library, for example, may address one aspect (reduce boilerplate in servers) but fail to address others
      (common definition of interfaces and message schemas, reduce boilerplate in clients). gRPC is thorough: it addresses all of these concerns. It also does 
      so in a way that is consistent across numerous programming languages. If you write code in multiple languages and/or in a polyglot environment, this is
      particularly poignant.
      
- Streaming: One of gRPC’s “killer features” is full-duplex bidirectional streaming. While the great majority of RPCs will be simple “unary” operations 
(single simple request, and single response), there are often cases where something more sophisticated is called for. Whether its affinity (often for performance 
reasons), server-push facilities for sending notifications, or something more complicated, it can be done using gRPC streams. 

    - Historically, this required writing a custom TCP-based protocol. This can be a good solution in the datacenter, but is much less realistic when clients and 
    servers are separated by a WAN or the Internet: open source proxy/load balancing software and hardware load balancers aren’t as effective when they don’t 
    understand the protocol. Even in the datacenter, where you might have a fairly homogeneous set of microservices that can all speak the protocol, 
    developing a custom protocol and client and server libraries is not trivial.
    - It is possible to do some of these sophisticated things with HTTP 1.1. The most flexible and widely-supported approach involves using web sockets, which 
    basically let you create a custom TCP-based protocol, tunneling it over HTTP connections. But this still comes with the cost of inventing the protocol 
    and implementing custom clients and servers
    
-  Security: gRPC was designed with security in mind. It is of course possible to use HTTP/2, and thus gRPC, 
in an insecure way with plain text connections. But when using TLS (transport-level security, sometimes called SSL), HTTP/2 is more strict than HTTP 1.1.
It allows only TLS 1.2 or higher; numerous cipher suites are blacklisted because they provide inadequate security; and compression and re-negotiation are disabled.
This greatly reduces the surface area of TLS vulnerabilities to which HTTP/2 connections are subjected.

Now that we know where gRPC is well-suited and why it is a good fit, the last question is, “What programming languages can you use with gRPC?” 
The following table shows the languages supported by the core gRPC and Protocol Buffers projects. In addition to these officially supported languages, 
you can also find unofficial open source gRPC libraries for other languages 
(such as Rust, Erlang, and TypeScript to name just a few).


| Language                      	| Notes                                                                                                                                                                                                                                                     	|
|-------------------------------	|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	|
| C++                           	| Based on the C core implementation. One of the original languages supported by <br>protoc.                                                                                                                                                                	|
| Java                          	| One of the original languages supported by <br>protoc.                                                                                                                                                                                                    	|
| Python                        	| One of the original languages supported by <br>protoc.                                                                                                                                                                                                    	|
| Go                            	| Support is provided via a protoc plugin named <br>protoc-gen-go. Reflection support (1) is limited.                                                                                                                                                       	|
| Ruby                          	| Based on the C core implementation. Lacks reflection support.                                                                                                                                                                                             	|
| C#                            	| Based on the C core implementation. Lacks reflection support.                                                                                                                                                                                             	|
| JavaScript                    	| Node.js only (not for browsers (2) ). Two implementations: one based on the C core, another that is pure JavaScript.                                                                                                                                      	|
| Android Java (aka “javanano”) 	| A lighter-weight approach to generated Java classes: simpler <br>representation, mutable POJOs (instead of immutable POJOs with <br>corresponding builders), and much fewer generated methods. Lacks <br>reflection support. No support for gRPC servers. 	|
| Objective-C                   	| Based on the C core implementation. Lacks reflection support. No support for gRPC servers.                                                                                                                                                                	|
| PHP                           	| Based on the C core implementation. Lacks reflection support. No support for gRPC servers.                                                                                                                                                                	|
| Dart                          	| Support is provided via a protoc plugin named <br>protoc-gen-dart. Lacks reflection support.                                                                                                                                                              	|
   
 
 - The term “reflection support” refers to being able to use Protocol Buffer descriptors to define and interact with message types at runtime. Without reflection, applications must always use protoc to generate code for message types. These limitations are only in the core gRPC and Protocol Buffer projects. For most,
 there exist third-party libraries to fill the gap.
 
 - Browsers must use alternative stubs and a web-to-gRPC proxy such as grpc-gateway, which is described later in gopherlabs series, or grpc-web https://github.com/grpc/grpc-web.

-  We see some interesting constraints to the supported languages above. It is obvious why Objective-C and Android Java don’t support gRPC servers: 
they target mobile devices that will always act as clients. For PHP, which is often used for building web servers, and the omission is a technical one: 
PHP integrates with web servers, as a module or via CGI. These interfaces were not designed with HTTP/2 in mind, so they are not compatible (even if the web 
server such as Apache, Nginx, or Lighttpd does support HTTP/2).

  
 
 
      
      
