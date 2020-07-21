---
layout: default
title: What are Protocol Buffers?
parent: gRPC
nav_order: 6
---


# What are Protocol Buffers ?

- gRPC focuses on optimizing three layers of the OSI model:
     - Application (HTTP2)
     - Presentation (Protobuf)
     - Session (RPC)
 
 it is time to take a deep dive into Protobuf or Protocol Buffers. One of the biggest concerns when 
 it comes to REST/JSON micro-service architectures is the “I couldn’t care less” attitude about bandwidth.
 The whole JSON message is sent among clients and servers in a plain text form, and its payload becomes repetitive and sometimes unnecessary.
 
 JSON APIs are widely adopted by many developers because they are easy to read and debug, and JSON is implemented natively in many languages, 
 such as NodeJS. For early projects, which need to go fast and have the Firsts prototypes up and running in a very short time, a JSON API can be recommended.
 But problems can arise. JSON messages are supposed to evolve, but client and server source code can be duplicated, and any feature connected to the same API
 will need to hard code the same parsing/interpretation functionality.
 
 - gRPC uses Protocol Buffers as a remedy to all of these known issues:
    - Formal contracts
    - Code generation
    - Bandwidth optimization
    
    
- Protocol Buffers is a standard process for serializing data, with the goal to minimize the data representation of a given structure. 
Protocol Buffers were created by Google early in 2001, but not publically released until 2008. The method offers a syntax in order to describe plenty of 
strong typing variables, as well as an IDL (Interface Description Language) in order to autogenerate source code with several programming languages and 
easily parse a stream of bytes into the given object. A .proto file needs to be created, and in it we’ll add all desired messages/objects with their specific
fields, as well as the services that use those messages. Once the .proto file is edited, we need to compile it with protoc in order to generate the classes for
every given message.

Here you can see a typical .proto file example:   

```
syntax = "proto#";

message Film {
    string title = 1;
    string director = 2;
    string producer = 3;
    optional string release_date = 4;
    repeated string characters = 5;
}


```
You specify that message fields are one of the following:
- required: a well-formed message must have exactly one of this field.
- optional: a well-formed message can have zero or one of this field (but not more than one).
- repeated: this field can be repeated any number of times (including zero) in a well-formed message. The order of the repeated values will be preserved.

# tags

As you can see in the example above all variables are strong typed (string), and they are followed by a sequential numbered tag. That will be the order of the serialization of all the fields for the message Film, and it will be mandatory to be able to parse the binary message. 
This order will of course not have to be modified at any time. Once a Film has been serialized, it isn’t possible to reconstruct the original structure. 
 
    
    
    


