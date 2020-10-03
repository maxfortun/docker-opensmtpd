FROM alpine:3.11

RUN apk --update add openssl ca-certificates opensmtpd procmail spamassassin

EXPOSE 25/tcp
EXPOSE 587/tcp
EXPOSE 465/tcp

CMD ["smtpd", "-d", "-P", "mda"]

