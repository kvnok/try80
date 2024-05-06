IMAGE := nginximage80
CONTAINER := nginxcontainer80

go: build run start

# Build the Docker image only if it doesn't exist
build:
	@if [ -z "$$(docker images -q $(IMAGE))" ]; then \
		echo "$(IMAGE) does not exist"; \
		docker build -t $(IMAGE) .; \
	else \
		echo "$(IMAGE) already exists"; \
	fi

# Create and run the Docker container if it doesn't exist
run:
	@if [ -z "$$(docker ps -q -f name=$(CONTAINER))" ]; then \
		echo "$(CONTAINER) does not exist"; \
		docker run -d -p 443:443 --name $(CONTAINER) $(IMAGE); \
	else \
		echo "$(CONTAINER) already exists"; \
	fi

# Start the Docker container if it's not already running
start:
	@if [ -z "$$(docker ps -q -f name=$(CONTAINER))" ]; then \
		echo "$(CONTAINER) is not running"; \
	else \
		echo "$(CONTAINER) is already running"; \
		docker start $(CONTAINER); \
	fi

# Restart the Docker container
restart:
	docker restart $(CONTAINER)

# Stop the Docker container
stop:
	docker stop $(CONTAINER)

# Remove the Docker container
rm:
	docker rm $(CONTAINER)

# Remove the Docker image
rmi:
	docker rmi $(IMAGE)

# Clean up everything (stop, remove container, and remove image)
clean: stop rm rmi

# Display usage information
help:
	@echo "Available make targets:"
	@echo "  build       - Build the Docker image (if not already built)"
	@echo "  run         - Create and run the Docker container (if not already created)"
	@echo "  start       - Start the Docker container (if not already running)"
	@echo "  stop        - Stop the Docker container"
	@echo "  rm          - Remove the Docker container"
	@echo "  rmi         - Remove the Docker image"
	@echo "  clean       - Stop, remove container, and remove image"
	@echo "  help        - Display this help message"

.PHONY: build run start stop rm rmi clean help
