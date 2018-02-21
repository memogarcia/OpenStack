FROM alpine:latest

LABEL maintainer=root@memogarcia.mx

RUN apk update && apk add openntpd

EXPOSE 123

CMD ["ntpd", "-d"]