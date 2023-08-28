FROM node:18-alpine3.18

WORKDIR /usr/src/app

COPY package.json .

RUN npm i

COPY . .

EXPOSE 5173

CMD ["npm", "run", "dev", "--", "--host"]