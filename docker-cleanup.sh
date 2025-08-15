#!/bin/bash

# Stop all running containers
docker stop $(docker ps -q) 2>/dev/null

# Remove all containers
docker rm $(docker ps -aq) 2>/dev/null

# Remove all images
docker rmi -f $(docker images -q) 2>/dev/null

# Remove all volumes
docker volume prune -f

# Remove all networks not used by at least one container
docker network prune -f
