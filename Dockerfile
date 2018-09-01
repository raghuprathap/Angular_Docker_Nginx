FROM node:8.11.2-alpine as node
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2
FROM nginx:1.15.2-alpine
COPY --from=node /usr/src/app/dist/ui-service /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf