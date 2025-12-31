FROM node:22-alpine

WORKDIR /app

RUN corepack enable && corepack prepare pnpm@latest --activate

COPY package.json package.json
COPY pnpm-lock.yaml pnpm-lock.yaml

RUN pnpm install --frozen-lockfile

COPY . .
RUN rm -rf .env

RUN pnpm run build
CMD [ "pnpm", "run", "start:prod" ]