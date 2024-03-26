FROM node:21.7.1-alpine3.18
WORKDIR /usr/src/app
COPY . .
RUN npm i
# EXPOSE 3000
EXPOSE 18000
# CMD [ "node", "app.js" ]
CMD [ "npm", "start" ]
