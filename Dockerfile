# Dockerfile 

FROM Ubuntu:22.04

# AVOID interactive dialog during apt-get install
ENV DEBIAN_FRONTEND=noninteractive

# Update system and install Apache, Git, and AWS CLI
RUN apt-get update && \
    apt-get install -y \
    apache2 \
    git \
    curl \
    software-properties-common \
    awscli

# Configure Apache to listen on port 82(in addition to 80)
RUN echo "Listen 82" >> /etc/apache2/ports.conf
COPY apache-config.conf /etc/apache2/sites-available/000-default.conf

#Install Node.js (if needed for builds)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

# Install Python and pip
RUN apt-get install -y python3 python3-pip

# Clean up
RUN apt-get clean &&\
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /builds

# Copy entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]