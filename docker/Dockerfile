FROM alpine:edge

RUN echo https://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories

RUN apk --update add openssl ca-certificates opensmtpd perl-mime-tools dkimproxy redis rspamd opensmtpd-filter-rspamd
RUN echo daemonize yes >> /etc/redis.conf

COPY docker-entrypoint.sh /usr/local/bin/

EXPOSE 25/tcp
EXPOSE 587/tcp
EXPOSE 465/tcp

CMD [ "/usr/local/bin/docker-entrypoint.sh" ]

