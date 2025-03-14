FROM mcr.microsoft.com/cbl-mariner/base/nodejs:18

WORKDIR /app

COPY src/ /app/src
COPY package.json /app
COPY vite.config.js /app
COPY index.html /app

RUN npm install

EXPOSE 6000

CMD npm run container
