# Streaming

- The closest siblings to gRPC are Thrift, an Apache project, and Twirp, open sourced by Twitch. But neither of these include support for streaming. gRPC, on the other hand,
was designed with streaming in mind from the outset

- Streaming allows a request or response to have an arbitrarily large size, such as operations that require uploading or downloading a huge amount of information.
Most RPC systems require that the arguments of an RPC be represented as data structures in memory that are then serialized to bytes and sent on the network.
When a very large amount of data must be exchanged, this can mean significant memory pressure on both the client process and the server process. And it means
that operations must typically impose hard limits on the size of request and response messages, to prevent resource exhaustion. Streaming alleviates this by 
allowing the request or response to be an arbitrarily long sequence of messages. The cumulative total size of a request or response stream may be incredibly 
large, but clients and servers do not need to store the entire stream in memory. Instead, they can operate on a subset of data, even as little as just one message at a time.

- Not only does gRPC support streaming, but it also supports full-duplex bidirectional streams. Bidirectional means that the client can use a stream to upload an arbitrary amount of request 
data and the server can use a stream to send back an arbitrary amount of response data, all in the same RPC. The novel part is the “full-duplex” part. Most request-response protocols,
including HTTP 1.1 are “half-duplex.” They support bidirectional communication (HTTP 1.1 even supports bidirectional streaming), but the two directions cannot be used at the same time. 
A request must first be fully uploaded before the server begins responding; only after the client is done transmitting can the server then reply with its full response. gRPC is built on HTTP/2, 
which explicitly supports full-duplex streams, which means that the client can upload request data at the same time the server is sending back response data. This is very powerful and eliminates 
the need for things like web sockets, which is an extension of HTTP 1.1, to allow full-duplex communication over an HTTP 1.1 connection. 
Thanks to streaming, applications can build very sophisticated conversational protocols on top of gRPC.
