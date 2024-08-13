FROM node:16.20.1-alpine

WORKDIR /app

COPY package.json package.json
COPY package-lock.json package-lock.json

RUN npm i

COPY . .
RUN rm -rf .env

RUN npm run build
CMD [ "npm", "run", "start:prod" ]