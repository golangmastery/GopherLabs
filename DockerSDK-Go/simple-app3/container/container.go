// Package container has all the functions for docker container operations
package container

import (
	"context"
	"log"

	"github.com/docker/docker/api/types"
	"github.com/docker/docker/api/types/container"
	"github.com/docker/docker/api/types/filters"
	"github.com/docker/docker/client"
	"github.com/docker/go-connections/nat"
)

// ListContainer lists all the containers running on host machine
func ListContainer() error {
	cli, err := client.NewEnvClient()
	if err != nil {
		log.Fatalf("Unable to get new docker client: %v", err)
	}
	containers, err := cli.ContainerList(context.Background(), types.ContainerListOptions{})
	if err != nil {
		log.Printf("Unable to list containers: %v", err)
		return err
	}
	if len(containers) > 0 {
		for _, container := range containers {
			log.Printf("Container ID: %s", container.ID)
		}
	} else {
		log.Println("There are no containers running")
	}
	return nil
}

// CreateNewContainer creates a new container from given image
func CreateNewContainer(image string) (string, error) {
	cli, err := client.NewEnvClient()
	if err != nil {
		log.Fatalf("Unable to create docker client\n")
	}

	hostBinding := nat.PortBinding{
		HostIP:   "0.0.0.0",
		HostPort: "8000",
	}
	containerPort, err := nat.NewPort("tcp", "80")
	if err != nil {
		log.Println("Unable to get newPort")
		return "", err
	}

	portBinding := nat.PortMap{containerPort: []nat.PortBinding{hostBinding}}
	cont, err := cli.ContainerCreate(
		context.Background(),
		&container.Config{
			Image: image,
		},
		&container.HostConfig{
			PortBindings: portBinding,
		}, nil, "")
	if err != nil {
		log.Println("ContainerCreate failed")
		return "", err
	}

	err = cli.ContainerStart(context.Background(), cont.ID, types.ContainerStartOptions{})
	if err != nil {
		log.Println("ContainerStart failed")
		return "", err
	}
	log.Printf("Container %s has been started\n", cont.ID)
	return cont.ID, nil
}

// StopContainer stops the container of given ID
func StopContainer(containerID string) error {
	cli, err := client.NewEnvClient()
	if err != nil {
		log.Fatalf("Unable to create docker client\n")
	}

	err = cli.ContainerStop(context.Background(), containerID, nil)
	if err != nil {
		log.Println("Stop container failed")
		return err
	}
	return nil
}

// PruneContainers clears all containers that are not running
func PruneContainers() error {
	cli, err := client.NewEnvClient()
	if err != nil {
		log.Fatalf("Unable to create docker client\n")
	}
	report, err := cli.ContainersPrune(context.Background(), filters.Args{})
	if err != nil {
		log.Println("Prune container failed")
		return err
	}
	log.Printf("Containers pruned: %v\n", report.ContainersDeleted)
	return nil
}
