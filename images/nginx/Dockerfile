FROM nginx:1.13.8-alpine

LABEL maintainer=root@memogarcia.mx

RUN rm /etc/nginx/conf.d/default.conf

RUN rm /etc/nginx/conf.d/examplessl.conf

COPY conf /etc/nginx

COPY conf /etc/nginx