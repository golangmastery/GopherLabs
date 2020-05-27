


# COCKROACH DB


# Introduction
Nowadays world is moving towards cloud infrastructure. Research has shown that by 2019 the ma- jority of IT infrastructure 
spend will be cloud based, as shown in the figure 1. Existing technologies are now shaping themselves to adopt the growing needs of Silicon Valley. 
Particularly ’data’ which is considered as a backbone of every industry is now demanding quick and easy access with its huge
geographically growing size. Existing databases particularly monolithic systems require a lot of en- gineering and 
configuration to run smoothly on clouds, especially when it comes to the distributed databases. Businesses are being 
evolved worldwide and so is the data. As businesses are evolving, their needs are also changing. In this air of clouds
every business requires a scalable, survivable, consistent and highly available solution for its data and applications
regardless of its location. Here comes a need of the database which contains these features in the native environment. 
Providing such solution is a trivial task. A NewSQL database ’CockroachDB’ built on native SQL engine claims to provide
all these features in the distributed environment.

![](assets/img/Cockrochdb_report.png)

This report contains all the detail required to understand CockroachDB to get started with your application from development to testing phase with a short explanation of NewSQL. Moreover, we have also benchmarked cockroachDB on 
different parameters against PostgreSQL for our application.


# 2 NewSQL
NewSQL is a class of modern relational database management systems that seek to provide the same scalable performance of NoSQL systems for online transaction processing (OLTP) read-write workloads while 
still maintaining the ACID guarantees of a traditional database system.

# 2.1 From SQL to NewSQL
We should actually say it like: Journey from SQL to NoSQL, and NoSQL to NewSQL, because the term NewSQL was not known before NoSQL. NoSQL was introduced to fill the gaps present in SQL databases. With the team being, it get popularity in the database world. However, No database has been remained perfect at 
any time since the beginning of the databases. So it would not be wrong to make an analogy that these terms are just wheels of data, carrying the data in a new form and a different method with the passage of time. These wheels get transformed according to the industrial and business needs plus the requirements and behaviour of the people controlling the world of data. We all know SQL, most of us know NoSQL too, but the main dilemma is when to choose which tool for our needs? Because not everything is perfect when you think about future and want to take your past along in the race of future. NoSQL did very well to fill that gaps but again here comes a choosing of choice. So tech guys moved back and started to fill the gaps by not loosing the traditional Standard Query Languages and ACID transactions. This resulted in NewSQL which we would say an update of SQL NoSQL having best
aspects of both, merged as one.


# 2.2 What NewSQL is?
Other than the definition of NewSQL, here we would describe it as a rule of thumb. If you favor availability and require some specific data models, NoSQL would come in your mind. Similarly if you need transparent ACID transactions with primary, secondary indexes and industrial standards, SQL will come into your mind. But if you need both of the above set of requirements, NewSQL should click here! Precisely, get a speed of NoSQL at-scale with stronger consistency and standard powerful query language.

# 2.3 Characteristics of NewSQL 
• NewSQL provide full ACID transactional support.<br>
• NewSQL minimizes application complexity.<br>
• NewSQL increases consistency.<br>
• NewSQL doesn’t require new tool or language to learn.<br>
• NewSQL provides clustering like NoSQL but in a traditional environment.<br>

# 3 CockroachDB
CockroachDB is a distributed SQL database build on transactional and strongly-consistent key- value store.
It can scale horizontally, survive disk, rack, machine and data center failures without manual intervention with 
disruption of minimum latency. It supports strongly consistent ACID transactions and provides a familiar SQL API 
to perform any function on the data.More precisely, CockroachDB is a SQL database for building global cloud services.

# 3.1 Brief History
Cockroach Labs was founded in 2015 by Spencer Kimball, Ben Darnell and Peter Mattis (ex-Google employees). 
Kimball and Mattis were key members of the Google File System team while Darner was a key member of Google Reader Team. 
They had used BigTable at Google and were acquainted with Spanner. After leaving Google, they wanted to design and build 
something similar for companies outside of Google. They started working on CockroachDB software on June 2015 .
Spencer Kimball wrote the first iteration of the design in January 2014 and to allow outside access and contribution,
he decided to start the project as an open-source and released it on GitHub in February 2014. Luckily, 
it got attracted by community and may experienced developers contributed in its development. It also earned 
the honor of Open Source Rookie of the Year because of its collaborations on GitHub.
Currently CockroachDB is a production-ready having as its latest release version.
Many companies of various sizes are using their global services with CockroachDB
e.g. Baidu, kindred futures and heroic Labs.


