# Time Series Databases  
Definition : A Time Series Database (TSDB) is a database type which is optimized fortime series or time-stamped data.  
It is built specifically for handling metrics,events or measurements that are time-stamped. 
A TSDB is optimized formeasuring change over time.  A TSDB allows its users to create, enumerate,update, destroy and
organize various time series in a more efficient manner.The key difference with time series data from regular data is 
that mostly youask questions about it over time.  Nowadays, the majority of the companiesare generating a insanely large 
stream of metrics and events (time series data)and hence the need of a TSDBs is unavoidable.

#  Properties 

The  main  properties  distinguishing  time  series  data  from  the  regular  dataworkloads are summarization, data life cycle management, and large rangescans of many records.  The overview of some of the required properties of aTSDB is as follows:
<br>
- Data Location:If related data is not located together in the physicalstorage, the data queries can be really slow and even result in timeoutsbecause non-sequential I/O operations are still very slow as comparedto the sequential I/O even when using SSD. A TSDB co-locates chucksof data within the same time range on the same physical part of thedatabase cluster and hence enables quick access for faster, more efficientanalysis.<br>
- Fast,  easy  range  queries:As  a  TSDB  keeps  the  co-related  datatogether it ensures that the range queries are fast. In many cases regulardatabases produce an index out of memory error because of the sheervolume  of  time  series  data  and  subsequently  affect  the  performanceof  read  and  write  operations.   In  addition,  it  should  be  taken  intoconsideration that the query language used should make it easier forusers to write such queries.<br>
- High write performance: A lot of databases are not able to serverequests  predictably  and  quickly  during  peak  loads.   TSDBs  shouldensure high availability and high performance for both read and write operations during peak loads because they are usually designed to stayavailable even under the most demanding conditions.  Time series datais usually being recorded every second or even less than that, so writeoperations need to be fast.<br>
- Data compression: As time-series data is mostly recorded per secondor even with less granularity, they usually need a better data compres-sion technique.  And as the data grows older granularity becomes lessimportant, so TSDBs should provide functionality to perform roll-upsin such scenarios for data compaction.<br>
- Scalability: Time-series data increases very quickly.  For example aconnected car will send 25 GB of data to the cloud every hour And regular databases are not designed to handle this scalability.  On theother hand time series databases are designed to take care of scale byintroducing functionalities that are only possible when you treat timeas  your  first  concern.   This  can  result  in  performance  improvements,including:  higher  insertion  rates,  faster  queries  at  scale,  and  betterdata compression.<br>
- Usability: TSDBs typically include functions and operations that arecommon  to  time  series  data  analysis.   For  example  they  utilize  dataretention policies, continuous queries, flexible time aggregations, rangequeries etc.  So this increases the usability by improving the user expe-rience in case of dealing with time related analysis.<br>
