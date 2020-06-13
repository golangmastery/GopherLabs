package main

import (
	"log"
	"fmt"
	"context"

	"github.com/docker/docker/api/types"
	"github.com/docker/docker/client"
)

// Stop and remove a container
func stopAndRemoveContainer(client *client.Client, containername string) error {
	ctx := context.Background()

	if err := client.ContainerStop(ctx, containername, nil); err != nil {
		log.Printf("Unable to stop container %s: %s", containername, err)
	}

	removeOptions := types.ContainerRemoveOptions{
		RemoveVolumes: true,
		Force:         true,
	}

	if err := client.ContainerRemove(ctx, containername, removeOptions); err != nil {
		log.Printf("Unable to remove container: %s", err)
		return err
	}

	return nil
}

func main() {
	client, err := client.NewEnvClient()
	if err != nil {
		fmt.Printf("Unable to create docker client: %s", err)
	}

	// Stops and removes a container
	stopAndRemoveContainer(client, "containername")
}
