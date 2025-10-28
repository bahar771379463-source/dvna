FROM node:10-alpine AS build
WORKDIR /usr/src/app
RUN apk add --no-cache --virtual .gyp python make g++
COPY package*.json ./
RUN npm install --production
COPY . .
FROM node:10-alpine
WORKDIR /usr/src/app
COPY --from=build /usr/src/app .
EXPOSE 3000
CMD [ "npm", "start" ]