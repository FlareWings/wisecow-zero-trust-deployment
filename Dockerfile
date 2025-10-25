# Start with a lightweight Linux distribution as the base image
FROM ubuntu:20.04

# Add /usr/games to the PATH environment variable
ENV PATH="/usr/games:${PATH}"

# Avoid interactive prompts during package installation
ARG DEBIAN_FRONTEND=noninteractive

# Install dependencies and clean up apt-cache in a single layer
# Note: `fortune` contains the `fortune` executable, while the separate
# `fortunes` package contains the text files with the quotes. Both are required.
RUN apt-get update && apt-get install -y \
    fortune \
    fortunes \
    cowsay \
    netcat \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /app

# Copy the application script into the container's working directory
COPY wisecow.sh .

# Grant execution permissions to the script
RUN chmod +x wisecow.sh

# Expose the port the application will run on
EXPOSE 4499

# Define the command to run when the container starts
CMD ["./wisecow.sh"]
