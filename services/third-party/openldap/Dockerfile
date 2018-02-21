FROM alpine:latest

LABEL maintainer=root@memogarcia.mx

RUN apk update && apk add openldap

EXPOSE 389 636

CMD ["slapd"]
