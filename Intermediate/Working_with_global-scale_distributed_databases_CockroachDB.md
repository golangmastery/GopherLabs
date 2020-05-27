

# Working with global-scale distributed databases: CockroachDB

[Install CockroachDB](https://www.cockroachlabs.com/docs/v2.1/install-cockroachdb-mac.html)

# verify installation 
```
  cockroach start --insecure
==> Summary
đş  /usr/local/Cellar/cockroach/2.1.6: 5 files, 119.6MB
==> `brew cleanup` has not been run in 30 days, running now...
Removing: /Users/sangam/Library/Caches/Homebrew/openssl--1.0.2q.mojave.bottle.tar.gz... (3.7MB)
Removing: /Users/sangam/Library/Logs/Homebrew/ncurses... (64B)
Removing: /Users/sangam/Library/Logs/Homebrew/kakoune... (64B)
Removing: /Users/sangam/Library/Logs/Homebrew/exercism... (64B)
Removing: /Users/sangam/Library/Logs/Homebrew/kubernetes-cli... (64B)
Biradars-MacBook-Air:~ sangam$ cockroach start --insecure
*
* WARNING: RUNNING IN INSECURE MODE!
* 
* - Your cluster is open for any client that can access <all your IP addresses>.
* - Any user, even root, can log in without providing a password.
* - Any user, connecting as root, can read or write any data in your cluster.
* - There is no network encryption nor authentication, and thus no confidentiality.
* 
* Check out how to secure your cluster: https://www.cockroachlabs.com/docs/v2.1/secure-a-cluster.html
*
*
* WARNING: neither --listen-addr nor --advertise-addr was specified.
* The server will advertise "Biradars-MacBook-Air.local" to other nodes, is this routable?
* 
* Consider using:
* - for local-only servers:  --listen-addr=localhost
* - for multi-node clusters: --advertise-addr=<host/IP addr>
* 
*
CockroachDB node starting at 2019-04-22 11:49:26.218723 +0000 UTC (took 0.6s)
build:               CCL v2.1.6 @ 2019/04/19 15:37:49 (go1.12.4)
webui:               http://Biradars-MacBook-Air.local:8080
sql:                 postgresql://root@Biradars-MacBook-Air.local:26257?sslmode=disable
client flags:        cockroach <client cmd> --host=Biradars-MacBook-Air.local:26257 --insecure
logs:                /Users/sangam/cockroach-data/logs
temp dir:            /Users/sangam/cockroach-data/cockroach-temp876737166
external I/O path:   /Users/sangam/cockroach-data/extern
store[0]:            path=/Users/sangam/cockroach-data
status:              initialized new cluster
clusterID:           0cc83423-aff7-4ee9-abbd-25309e3e0c94
nodeID:              1


```


```

Biradars-MacBook-Air:~ sangam$ cockroach sql --insecure
# Welcome to the cockroach SQL interface.
# All statements must be terminated by a semicolon.
# To exit: CTRL + D.
#
# Server version: CockroachDB CCL v2.1.6 (x86_64-apple-darwin18.5.0, built 2019/04/19 15:37:49, go1.12.4) (same version as client)
# Cluster ID: 0cc83423-aff7-4ee9-abbd-25309e3e0c94
#
# Enter \? for a brief introduction.
#
root@:26257/defaultdb> create database company_db;                                                                                                                                                          set database = company_db;
CREATE DATABASE

Time: 13.213ms

SET

Time: 566Âľs

root@:26257/company_db> CREATE TABLE "tbl_employee" (                                                                                                                                                           "employee_id" SERIAL,                                                                                                                                                                                       "full_name" STRING(100),                                                                                                                                                                                    "department" STRING(50),                                                                                                                                                                                    "designation" STRING(50),                                                                                                                                                                                   "created_at" TIMESTAMPTZ,                                                                                                                                                                                   "updated_at" TIMESTAMPTZ,                                                                                                                                                                                   PRIMARY KEY ("employee_id")                                                                                                                                                                             );
CREATE TABLE

Time: 10.606ms


root@:26257/company_db> CREATE TABLE "tbl_employee" (
    "employee_id" SERIAL,
    "full_name" STRING(100),
    "department" STRING(50),
    "designation" STRING(50),
    "created_at" TIMESTAMPTZ,
    "updated_at" TIMESTAMPTZ,
    PRIMARY KEY ("employee_id")
);




```
# install drivers lib 
```
go get -u github.com/lib/pq
```
# sample program 
```

package main

import (
	"database/sql"
	"fmt"
	"log"

	_ "github.com/lib/pq"
)

func main() {
	// Connect to the "company_db" database.
	db, err := sql.Open("postgres", "postgresql://root@localhost:26257/company_db?sslmode=disable")
	if err != nil {
		log.Fatal("error connecting to the database: ", err)
	}

	// Insert a row into the "tbl_employee" table.
	if _, err := db.Exec(
		`INSERT INTO tbl_employee (full_name, department, designation, created_at, updated_at) 
		VALUES ('sangam', 'software', 'engineitops', NOW(), NOW());`); err != nil {
		log.Fatal(err)
	}

	// Select Statement.
	rows, err := db.Query("select employee_id, full_name FROM tbl_employee;")
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()
	for rows.Next() {
		var employeeID int64
		var fullName string
		if err := rows.Scan(&employeeID, &fullName); err != nil {
			log.Fatal(err)
		}
		fmt.Printf("Employee Id : %d \t Employee Name : %s\n", employeeID, fullName)
	}
}

```
# check database in cli
```
root@:26257/company_db> select * from tbl_employee;
     employee_id     | full_name | department |   designation   |            created_at            |            updated_at             
+--------------------+-----------+------------+-----------------+----------------------------------+----------------------------------+
  445201878515679233 | sangam    | software   | engineitops     | 2019-04-22 12:13:51.08935+00:00  | 2019-04-22 12:13:51.08935+00:00  

```
# check dasboard localhost:80 

![](assets/img/dasboardCockrochdb.png)




 
