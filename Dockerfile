# ---------- deps ----------
FROM node:18-alpine AS deps
WORKDIR /app

COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# ---------- test ----------
FROM node:18-alpine AS test
WORKDIR /app

COPY --from=deps /app/node_modules ./node_modules
COPY . .

CMD ["yarn", "test"]

# ---------- build ----------
FROM node:18-alpine AS build
WORKDIR /app

COPY --from=deps /app/node_modules ./node_modules
COPY . .

RUN yarn build

# ---------- prod ----------
FROM node:18-alpine AS prod
WORKDIR /app

COPY --from=build /app ./

CMD ["node", "build/src/entry.js"]