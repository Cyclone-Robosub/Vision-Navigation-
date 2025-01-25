# Use Ubuntu as the base image
FROM ubuntu:20.04

# Set environment variable to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libopencv-dev \
    git \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

# Set the timezone (update to your desired timezone, e.g., UTC)
RUN ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

# Set the working directory
WORKDIR /app

# Copy project files into the container
COPY . .

# Create a build directory and compile the project
RUN mkdir -p build && cd build && cmake .. && make

# Set the default command to run the application
CMD ["./build/opencv_test"]
