FROM maven:3.9.5-eclipse-temurin-17

# Install dependencies
RUN apt-get update && \
    apt-get install -y wget gnupg unzip curl libatk-bridge2.0-0 libgtk-3-0 libxss1 libasound2 xvfb && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project
COPY . .

# Install Playwright Browsers
RUN mvn dependency:resolve
RUN mvn exec:java -e -Dexec.mainClass=com.microsoft.playwright.CLI -Dexec.args="install"

# Run tests
CMD ["mvn", "test"]