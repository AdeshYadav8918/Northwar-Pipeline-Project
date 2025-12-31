#!/bin/bash
# docker-entrypoint.sh

# Start Apache in the background for port 82 testing 
service apache2 start

# Execute the command passed to Docker (for Codebuild)
exec "$@"