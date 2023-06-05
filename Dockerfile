# deps
FROM node:20.2-alpine as deps

WORKDIR /app

COPY package.json package-lock.json $PROJECT_ROOTDIR

RUN npm ci

COPY . $PROJECT_ROOTDIR

EXPOSE 3000

# runner
FROM mcr.microsoft.com/playwright:v1.27.1-focal as runner

WORKDIR /app

COPY --from=deps /app/package.json package.json
COPY --from=deps /app/e2e e2e
COPY --from=deps /app/playwright.config.ts playwright.config.ts
COPY --from=deps /app/node_modules node_modules

RUN npx playwright install

EXPOSE 3000

ENV NODE_ENV production
ENV CI true
ENV PORT 3000

# CMD ["npm", "run", "test:e2e"]