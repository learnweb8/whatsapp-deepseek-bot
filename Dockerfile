FROM node:18.17.1

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

# Puppeteer के लिए ज़रूरी dependencies इंस्टॉल करें
RUN apt-get update && apt-get install -y \
    libnss3 \
    libatk1.0-0 \
    libx11-xcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libdbus-1-3 \
    libgtk-3-0 \
    libgbm1 \
    libasound2 \
    wget

# Puppeteer को Chromium डाउनलोड करने से रोकें
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

COPY . .

CMD ["node", "index.js"]
