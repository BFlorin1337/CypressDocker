FROM cypress/base:14.17.0

# Install dependencies including Chrome
RUN apt-get update && \
    apt-get install -y \
    curl \
    wget \
    gnupg \
    unzip \
    && curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update && apt-get install -y \
    google-chrome-stable \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install the project dependencies
RUN npm install

# Copy the rest of the project files
COPY . .

# Define the command to run the Cypress tests
CMD ["npx", "cypress", "run", "--browser", "chrome", "--headless"]
