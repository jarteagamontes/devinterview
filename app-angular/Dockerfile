##OWO##
FROM node:18-alpine as build
RUN mkdir /app
WORKDIR /app
COPY app-angular/package*.json ./
RUN npm install --unsafe-perm
COPY app-angular/. .
RUN npm run build

##=W=##
FROM nginx:alpine
COPY --from=build /app/dist/challenge-devops/browser /usr/share/nginx/html
EXPOSE 80
