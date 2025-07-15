# Start from Maven with Java 17
FROM maven:3.9.5-eclipse-temurin-17

# Install OS dependencies required by Playwright browsers
RUN apt-get update && \
    apt-get install -y wget gnupg unzip curl \
    libnss3 libnspr4 libatk-bridge2.0-0 libgtk-3-0 libxss1 \
    libasound2 libgbm1 libdrm2 libxcomposite1 libxrandr2 \
    libpango-1.0-0 libpangocairo-1.0-0 libxdamage1 libx11-xcb1 \
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set work directory
WORKDIR /app

# Copy everything into the container
COPY . .

# Install Playwright browsers
RUN mvn exec:java -e -Dexec.mainClass=com.microsoft.playwright.CLI -Dexec.args="install"

# Run tests
CMD ["mvn", "test"]