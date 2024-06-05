FROM cypress/base:latest

WORKDIR /app

RUN apt-get update && apt-get install -y alsa-utils

COPY package.json package-lock.json ./

RUN npm install

COPY cypress.config.js ./

COPY cypress/ ./cypress/

COPY asound.conf /etc/asound.conf

CMD ["npx", "cypress", "run"]