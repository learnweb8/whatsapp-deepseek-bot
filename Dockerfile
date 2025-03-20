dockerfile
     FROM node:18
     WORKDIR /app
     COPY package.json .
     RUN apt-get update && apt-get install -y \
         gconf-service \
         libgbm-dev \
         libasound2 \
         && npm install
     COPY . .
     CMD ["node", "server.js"]
