package main

import (
	"context"
	"fmt"

	"github.com/docker/docker/api/types"
	"github.com/docker/docker/client"
)

func main() {
	cli, err := client.NewClientWithOpts(client.WithVersion("1.37"))
	if err != nil {
		panic(err)
	}

	containers, err := cli.ContainerList(context.Background(), types.ContainerListOptions{All: true})
	if err != nil {
		panic(err)
	}
  fmt.Printf("%s", 
                     _               _       _         
                  | |             | |     | |        
  __ _  ___  _ __ | |__   ___ _ __| | __ _| |__  ___ 
 / _` |/ _ \| '_ \| '_ \ / _ \ '__| |/ _` | '_ \/ __|
| (_| | (_) | |_) | | | |  __/ |  | | (_| | |_) \__ \
 \__, |\___/| .__/|_| |_|\___|_|  |_|\__,_|_.__/|___/
  __/ |     | |                                      
 |___/      |_|                                      

)

	for _, container := range containers {
		fmt.Printf("%s %s\n", container.ID[:10], container.Image)
	}
}
