FROM node:10-alpine

WORKDIR /usr/src/app

COPY package*.json ./

# الآن، هذا الأمر لن يحتاج إلى أي أدوات بناء خارجية
RUN npm install --production

COPY . .

EXPOSE 3000
CMD [ "npm", "start" ]