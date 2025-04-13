#!/bin/bash

# Run Docker Compose for development
echo "Starting development environment..."
docker-compose -f docker-compose.dev.yml up -d --build