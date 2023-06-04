FROM node:20.2-alpine

ENV PROJECT_ROOTDIR /usr/src/app

WORKDIR $PROJECT_ROOTDIR

COPY package.json package-lock.json $PROJECT_ROOTDIR

RUN npm install

COPY . $PROJECT_ROOTDIR

EXPOSE 3000

# CMD ["npm", "start"]
