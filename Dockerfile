# Start from the Jenkins LTS image
FROM jenkins/jenkins:lts

# Switch to root user to install Docker
USER root

# Install Docker dependencies
RUN apt-get update && \
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker’s official GPG key
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

# Add Docker apt repository
RUN echo "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
RUN apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io

# Add Jenkins user to the Docker group
RUN usermod -aG docker jenkins

# Switch back to the Jenkins user
USER jenkins

# Expose necessary ports and define the default command
EXPOSE 8080
EXPOSE 50000
CMD ["bash", "-c", "exec /usr/local/bin/jenkins.sh"]