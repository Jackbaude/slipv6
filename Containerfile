# Use the liii/xmap:latest image as the base image
FROM liii/xmap:latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1

# Install dependencies for Jupyter
RUN apt update && \
    apt install -y python3-pip python3-venv build-essential cmake \
    git wget && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Create a working directory for Jupyter notebooks
RUN mkdir -p /notebooks && \
    chmod -R 777 /notebooks  # Ensuring correct permissions

WORKDIR /notebooks

# Copy all local files into the container's /notebooks directory
COPY . /notebooks

# Create a virtual environment and install Jupyter in it
RUN python3 -m venv /opt/venv && \
    /opt/venv/bin/pip install --upgrade pip && \
    /opt/venv/bin/pip install notebook numpy pandas matplotlib

# Set the virtual environment as the default Python environment
ENV PATH="/opt/venv/bin:$PATH"

# Expose port 8888 for Jupyter Notebook
EXPOSE 8888

# Declare a volume to persist data in the /notebooks directory
VOLUME ["/notebooks"]

# Start Jupyter Notebook server
CMD ["bash", "-c", "source /opt/venv/bin/activate && jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root"]
