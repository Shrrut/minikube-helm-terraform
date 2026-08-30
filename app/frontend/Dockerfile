FROM nginx:1.27-alpine

ENV BACKEND_HOST=backend-svc
ENV BACKEND_PORT=5000

COPY index.html /usr/share/nginx/html/index.html
COPY app.js /usr/share/nginx/html/app.js
COPY style.css /usr/share/nginx/html/style.css

COPY default.conf.template /etc/nginx/templates/default.conf.template

EXPOSE 80