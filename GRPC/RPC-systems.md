# RPC systems

Here we cover the typical traits shared by all RPC systems. There are systems that contain some of these traits, whereas mature systems provide them all:

- Since it’s RPC, the programming model is of course procedure calls: the networking aspect of the technology is abstracted away from application code, making it look almost as if it were a normal in-process function call 
versus an out-of-process network call.
- There is a way to define the interfaces as the names and signatures of the procedures that can be invoked along with the data types that are exchanged as arguments and return values. For RPC systems that are language-agnostic (e.g. can be used with multiple programming languages), the interface is typically defined in an Interface Definition Language, or IDL for short. 
IDLs can describe the shape of data and interfaces but cannot express business logic.
- The RPC systems often include code generation tools for transforming the interface descriptions into usable libraries. And they include a runtime library that handles the transport protocol details and provides an ABI for the generated code to hook into that transport implementation. Some systems rely more heavily on runtime reflection and less on code generation. And this can even vary from one programming language 
to another for the various implementations of a single RPC system.
- Unlike REST, these systems typically do not expose all of the flexibility of HTTP. Some eschew HTTP completely, opting for a custom binary TCP protocol. Those that do use HTTP as a transport tend to have rigid conventions for mapping RPCs to HTTP requests, which often cannot be customized. The details of what the HTTP request looks like are meant to be an implementation detail 
encapsulated in the system’s transport implementation.


# gRPC

Let’s talk about gRPC first. The first thing to note is that the architecture of gRPC is layered:

- The lowest layer is the transport: gRPC uses HTTP/2 as its transport protocol. HTTP/2 provides the same basic semantics as HTTP 1.1 (the version with which nearly all developers are familiar),
but aims to be more efficient and more secure. The new features in HTTP/2 that are most obvious at first glance are (1) that it can multiplex many parallel requests over the same network 
connection and (2) that it allows full-duplex bidirectional communication. We’ll learn more about HTTP/2 and the ways it differs from and 
improves on HTTP 1.1 later in gopherlabs.
- The next layer is the channel. This is a thin abstraction over the transport. The channel defines calling conventions and implements the mapping of an
RPC onto the underlying transport. At this layer, a gRPC call consists of a client-provided service name and method name, optional request metadata
(key-value pairs), and zero or more request messages. A call is completed when the server provides optional response header metadata, zero or more
response messages, and response trailer metadata. The trailer metadata indicates the final disposition of the call: whether it was a success or a failure.
At this layer, there is no knowledge of interface constraints, data types, or message encoding. A message is just a sequence of zero or more bytes. 
A call may have any number of request and response messages.
- The last layer is the stub. The stub layer is where interface constraints and data types are defined. Does a method accept exactly one request message 
or a stream of request messages? What kind of data is in each response message and how is it encoded? The answers to these questions are provided by the stub. 
The stub marries the IDL-defined interfaces to a channel. The stub code is generated from the IDL. The channel layer provides the ABI that these generated stubs use.

Another key component of gRPC is a technology called Protocol Buffers. Protocol Buffers, or “protobufs” for short, are an IDL for describing services, methods, and messages. A compiler turns IDL into generated code for a wide variety of programming languages, 
along with runtime libraries for each of those supported programming languages. 

It is important to note that Protocol Buffers have a role only in the last layer in the list above: the stub. The lower layers of gRPC, 
the channel and the transport, are IDL-agnostic. This makes it possible to use any IDL with gRPC (though the core gRPC libraries only provide tools for 
using protobufs). You can even find unofficial open source implementations of the stub layer using other formats and IDLs, such as flatbuffers and messagepack.



