FROM node:12 AS build

WORKDIR /usr/src/app

# تثبيت الأدوات الضرورية لبناء المكتبات على Debian
RUN apt-get update && apt-get install -y python make g++ --no-install-recommends

COPY package*.json ./

RUN npm install --production

COPY . .

FROM node:12-slim

WORKDIR /usr/src/app


COPY --from=build /usr/src/app .

EXPOSE 3000
CMD [ "npm", "start" ]