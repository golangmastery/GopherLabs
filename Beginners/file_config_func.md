## File configuration with functional options


- This recipe is not directly related to the Go standard library but includes how to handle an optional configuration for your application. The recipe will use the functional options pattern in a real case with a file configuration.


## Create the main.go file with the following content:

```
package main

import (
	"encoding/json"
	"fmt"
	"os"
)

type Client struct {
	consulIP   string
	connString string
}

func (c *Client) String() string {
	return fmt.Sprintf("ConsulIP: %s , Connection String: %s",
		c.consulIP, c.connString)
}

var defaultClient = Client{
	consulIP:   "localhost:9000",
	connString: "postgres://localhost:5432",
}

// ConfigFunc works as a type to be used
// in functional options
type ConfigFunc func(opt *Client)

// FromFile func returns the ConfigFunc
// type. So this way it could read the configuration
// from the json.
func FromFile(path string) ConfigFunc {
	return func(opt *Client) {
		f, err := os.Open(path)
		if err != nil {
			panic(err)
		}
		defer f.Close()
		decoder := json.NewDecoder(f)

		fop := struct {
			ConsulIP string `json:"consul_ip"`
		}{}
		err = decoder.Decode(&fop)
		if err != nil {
			panic(err)
		}
		opt.consulIP = fop.ConsulIP
	}
}

// FromEnv reads the configuration
// from the environmental variables
// and combines them with existing ones.
func FromEnv() ConfigFunc {
	return func(opt *Client) {
		connStr, exist := os.LookupEnv("CONN_DB")
		if exist {
			opt.connString = connStr
		}
	}
}

func NewClient(opts ...ConfigFunc) *Client {

	client := defaultClient
	for _, val := range opts {
		val(&client)
	}
	return &client
}

func main() {
	client := NewClient(FromFile("config.json"), FromEnv())
	fmt.Println(client.String())
}



```
In the same folder, create the file config.json with content:

```
{
  "consul_ip":"127.0.0.1"
}

```

output :
```
Biradars-MacBook-Air-4:golang-daily sangam$ CONN_DB=oracle://local:5921 go run main.go
ConsulIP: 127.0.0.1 , Connection String: oracle://local:5921
Biradars-MacBook-Air-4:golang-daily sangam$ 

```

## How it works...

- The core concept of the functional options pattern is that the configuration API contains the functional parameters. In this case, the NewClient function accepts a various number of ConfigFunc arguments, which are then applied one by one on the defaultClient struct. This way, the default configuration is modified with huge flexibility. 

- See the FromFile and FromEnv functions, which return the ConfigFunc, that is in fact, accessing the file or environmental variables.

- Finally, you can check the output which applied both the configuration options and resulting Client struct that contains the values from the file and environmental variables.
