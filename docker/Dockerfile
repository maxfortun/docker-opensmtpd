FROM alpine:3.11

RUN apk --update add openssl ca-certificates opensmtpd perl-mime-tools dkimproxy

COPY docker-entrypoint.sh /usr/local/bin/

EXPOSE 25/tcp
EXPOSE 587/tcp
EXPOSE 465/tcp

CMD [ "/usr/local/bin/docker-entrypoint.sh" ]

