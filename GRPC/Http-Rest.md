# HTTP and REST

- HTTP is the protocol that powers the worldwide web. It stands for Hyper-Text Transfer Protocol. It’s a text-based request-response protocol.
Because it is text-based, the protocol itself is human-readable (data payloads, which can be binary, may not be). It was originally designed for accessing documents across the Internet, 
but it has become a ubiquitous protocol-not just for web browsers, but for all kinds of computer-to-computer interactions. Subsequently, HTTP and “web technology” have become the substrate of 
choice for many kinds of interactions thanks to common-place open source software components and a range of hardware components that make it possible to build and deploy HTTP-based systems with ease and at great scale.

- REST, which stands for REpresentational State Transfer, is based on HTTP. It defines constraints and conventions on top of HTTP that are intended to 
provide global interoperability and potential for scalability. A key architecture constraint in REST is statelessness: application servers do not store client 
context in between requests. Any client state needed to process a request is included with each request. This enables systems to grow to very large scale: 
requests can be load balanced across a large pool of servers, and multiple requests from a single client don’t have to be handled by a single server.

- he concepts used to define REST APIs focus on managing “documents” or “entities.” REST’s primitives are the various HTTP methods: 
GET, PUT, DELETE, POST, PATCH, etc. These methods map, more or less, to CRUD operations on these entities. (CRUD stands for Create, Read, Update, and Delete: 
the set of actions needed to work with data.) A REST API defines naming conventions so that clients can construct URLs to identify particular documents or entities. It also defines semantics for each of the methods when applied to a particular resource or document. Request and response payloads are used to transmit document contents. This is a very straight-forward model for a service that exposes a database-like or filesystem-like resource: you can use HTTP GET requests to list documents or retrieve document contents, and you can use PUT, PATCH, and DELETE requests to create new documents or to modify or delete existing ones.
When a service has more complicated and less document-centric operations, mapping them to REST can be a bit more challenging.

- here are numerous RPC systems that are built on top of REST. Some leverage the full flexibility of REST, such as Swagger and JAX-RS (the Java APIs for REST-ful web services). Swagger is a cross-platform and language-agnostic technology whose IDL-the Swagger spec-describes rules for
how a set of operations is represented in HTTP requests and responses. The spec describes the HTTP method, patterns for URI paths, and even the request and response structures for each operation. Code generation tools exist to create client stubs and server interfaces from a Swagger spec. JAX-RS, on the other hand, is Java-only, and its IDL is Java itself. A Java interface is used to define the operations, with annotations that control how its methods, arguments, and return values are mapped to the HTTP protocol. Servers can provide implementations of the interface. And a client stub is a runtime-generated implementation of that interface,
which uses reflection to intercept method calls and transform them into outgoing HTTP requests.

- Other RPC systems are based on HTTP. From a certain point of view, they can be seen as narrow subsets of REST: they still adhere to its architectural principles,
but put forth significant constraints/conventions on resource naming, methods, and the encoding of documents to simplify the implementation of both clients and servers. 
Such systems were created during the web’s “adolescent era,” including XML-RPC and SOAP. As the popularity of XML declined, different approaches to content encoding came into favor, such as JSON-RPC. In fact, gRPC finds itself in this category.
